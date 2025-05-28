require 'socket'
require 'openssl'
require 'base64'

=begin
CONSTANTS
=end
SERVER_PORT = 7000
GRP_NAME = 'epsilon'.freeze
AMT_OF_PACKETS_TO_RCV = 100
STANDARD_OPTS_FOR_SEND = 0
MAX_UDP_PACKET_LENGTH = 64
# encryption-related (on a real-world problem, these shall be passed as ENV values or another method)
ENCRYPTION_METHOD = 'AES-256-CBC'.freeze
KEY = 'G7kL9vTqNpXzJwErUyOiPmDfHsQaZxVc'.freeze
IV = 'mNzRgTpYwQsEdCfV'.freeze

=begin
METHODS DEFINITION
=end
def set_enc_key_iv(enc)
  enc.key = KEY
  enc.iv = IV
  enc
end

def get_cipher
  cipher = OpenSSL::Cipher.new(ENCRYPTION_METHOD)
  cipher.encrypt
  set_enc_key_iv(cipher)
end

def get_decipher
  decipher = OpenSSL::Cipher.new(ENCRYPTION_METHOD)
  decipher.decrypt
  set_enc_key_iv(decipher)
end

=begin
RUNTIME
=end
# socket creation and usage (IPv4)
udp_server = UDPSocket.new(Socket::AF_INET)
udp_server.bind('localhost', SERVER_PORT)
AMT_OF_PACKETS_TO_RCV.times do |i|
  # get req (blocking)
  req, ipaddr = udp_server.recvfrom(MAX_UDP_PACKET_LENGTH)
  req_decoded = Base64.decode64(req)
  decipher = get_decipher()
  req_decrypted = decipher.update(req_decoded) + decipher.final
  puts("Received '#{req}', decrypted as '#{req_decrypted}'.")
  # send rsp
  client_port = ipaddr[1] # i.e.: 1234
  client_ip = ipaddr[3] # i.e.: "192.168.1.2"
  data_to_send = "rsp_#{GRP_NAME}_#{i}"
  cipher = get_cipher()
  data_to_send_encrypted = Base64.strict_encode64(cipher.update(data_to_send) + cipher.final)
  udp_server.send(data_to_send_encrypted, STANDARD_OPTS_FOR_SEND, client_ip, client_port)
  puts("Sent '#{data_to_send}', encrypted as '#{data_to_send_encrypted}'.")
end
# cleaning
udp_server.close
