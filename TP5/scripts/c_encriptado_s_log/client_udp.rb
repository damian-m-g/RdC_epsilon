require 'socket'
require 'openssl'
require 'base64'

=begin
CONSTANTS
=end
SERVER_IP = '192.168.1.100'.freeze
SERVER_PORT = 7000
SLP_TIME = 1
GRP_NAME = 'epsilon'.freeze
AMT_OF_PACKETS_TO_SND = 100
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
udp_client = UDPSocket.new(Socket::AF_INET)
udp_client.connect(SERVER_IP, SERVER_PORT)
AMT_OF_PACKETS_TO_SND.times do |i|
  # send req
  data_to_send = "req_#{GRP_NAME}_#{i}"
  cipher = get_cipher()
  data_to_send_encrypted = Base64.strict_encode64(cipher.update(data_to_send) + cipher.final)
  puts("Sending '#{data_to_send}', encrypted as '#{data_to_send_encrypted}'...")
  udp_client.send(data_to_send_encrypted, STANDARD_OPTS_FOR_SEND)
  # get rsp (blocking)
  rsp, ignore = udp_client.recvfrom(MAX_UDP_PACKET_LENGTH)
  rsp_decoded = Base64.decode64(rsp)
  decipher = get_decipher()
  rsp_decrypted = decipher.update(rsp_decoded) + decipher.final
  puts("Received '#{rsp}', decrypted as '#{rsp_decrypted}'.")
  # sleep a fixed amount of time between requests
  sleep(SLP_TIME)
end
# cleaning
udp_client.close
