require 'socket'
require 'openssl'
require 'base64'

=begin
CONSTANTS
=end
SERVER_PORT = 4000
GRP_NAME = 'epsilon'.freeze
AMT_OF_PACKETS_TO_RCV = 100
PROGRAM = 'server_tcp'.freeze
LOG_FILENAME = "#{PROGRAM}.log".freeze
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
# socket creation and usage (a solo client will get connected)
tcp_server = TCPServer.new(SERVER_PORT)
tcp_client = tcp_server.accept
AMT_OF_PACKETS_TO_RCV.times do |i|
  # get req (blocking)
  req = tcp_client.gets.chomp
  req_decoded = Base64.decode64(req)
  decipher = get_decipher()
  req_decrypted = decipher.update(req_decoded) + decipher.final
  puts("Received '#{req}', decrypted as '#{req_decrypted}'.")
  # send rsp
  data_to_send = "rsp_#{GRP_NAME}_#{i}"
  cipher = get_cipher()
  data_to_send_encrypted = Base64.strict_encode64(cipher.update(data_to_send) + cipher.final)
  tcp_client.puts(data_to_send_encrypted)
  puts("Sent '#{data_to_send}', encrypted as '#{data_to_send_encrypted}'.")
end
# cleaning
tcp_client.close
