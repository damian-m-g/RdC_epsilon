require 'socket'
require 'logger'

=begin
CONSTANTS
=end
SERVER_IP = '192.168.1.101'.freeze
SERVER_PORT = 7000
SLP_TIME = 1
GRP_NAME = 'epsilon'.freeze
AMT_OF_PACKETS_TO_SND = 100
PROGRAM = 'client_udp'.freeze
LOG_FILENAME = "#{PROGRAM}.log".freeze
STANDARD_OPTS_FOR_SEND = 0
MAX_UDP_PACKET_LENGTH = 32

=begin
RUNTIME
=end
# log file creation
logger = Logger.new(File.join(File.dirname(__FILE__), LOG_FILENAME))
# socket creation and usage (IPv4)
udp_client = UDPSocket.new(Socket::AF_INET)
udp_client.connect(SERVER_IP, SERVER_PORT)
AMT_OF_PACKETS_TO_SND.times do |i|
  # send req
  data_to_send = "req_#{GRP_NAME}_#{i}"
  puts("Sending '#{data_to_send}'...")
  logger.add(Logger::INFO, "Sending: '#{data_to_send}' to srv.", PROGRAM)
  udp_client.send(data_to_send, STANDARD_OPTS_FOR_SEND)
  # get rsp (blocking)
  rsp, ignore = udp_client.recvfrom(MAX_UDP_PACKET_LENGTH)
  logger.add(Logger::INFO, "Received: '#{rsp}' from srv.", PROGRAM)
  puts("Received '#{rsp}'.")
  # sleep a fixed amount of time between requests
  sleep(SLP_TIME)
end
# cleaning
udp_client.close
logger.close
