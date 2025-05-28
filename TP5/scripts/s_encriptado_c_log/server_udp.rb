require 'socket'
require 'logger'

=begin
CONSTANTS
=end
SERVER_PORT = 7000
GRP_NAME = 'epsilon'.freeze
AMT_OF_PACKETS_TO_RCV = 100
PROGRAM = 'server_udp'.freeze
LOG_FILENAME = "#{PROGRAM}.log".freeze
STANDARD_OPTS_FOR_SEND = 0
MAX_UDP_PACKET_LENGTH = 32

=begin
RUNTIME
=end
# log file creation
logger = Logger.new(File.join(File.dirname(__FILE__), LOG_FILENAME))
# socket creation and usage (IPv4)
udp_server = UDPSocket.new(Socket::AF_INET)
udp_server.bind('localhost', SERVER_PORT)
AMT_OF_PACKETS_TO_RCV.times do |i|
  # get req (blocking)
  req, ipaddr = udp_server.recvfrom(MAX_UDP_PACKET_LENGTH)
  logger.add(Logger::INFO, "Received: '#{req}' from clt.", PROGRAM)
  puts("Received '#{req}'.")
  # send rsp
  client_port = ipaddr[1] # i.e.: 1234
  client_ip = ipaddr[3] # i.e.: "192.168.1.2"
  data_to_send = "rsp_#{GRP_NAME}_#{i}"
  logger.add(Logger::INFO, "Sending: '#{data_to_send}' to clt.", PROGRAM)
  udp_server.send(data_to_send, STANDARD_OPTS_FOR_SEND, client_ip, client_port)
  puts("Sent '#{data_to_send}'.")
end
# cleaning
udp_server.close
logger.close
