require 'socket'
require 'logger'

=begin
CONSTANTS
=end
SERVER_PORT = 4000
GRP_NAME = 'epsilon'.freeze
AMT_OF_PACKETS_TO_RCV = 100
PROGRAM = 'server_tcp'.freeze
LOG_FILENAME = "#{PROGRAM}.log".freeze

=begin
RUNTIME
=end
# log file creation
logger = Logger.new(File.join(File.dirname(__FILE__), LOG_FILENAME))
# socket creation and usage (a solo client will get connected)
tcp_server = TCPServer.new(SERVER_PORT)
tcp_client = tcp_server.accept
AMT_OF_PACKETS_TO_RCV.times do |i|
  # get req (blocking)
  req = tcp_client.gets.chomp
  logger.add(Logger::INFO, "Received: '#{req}' from clt.", PROGRAM)
  puts("Received '#{req}'.")
  # send rsp
  data_to_send = "rsp_#{GRP_NAME}_#{i}"
  logger.add(Logger::INFO, "Sending: '#{data_to_send}' to clt.", PROGRAM)
  tcp_client.puts(data_to_send)
  puts("Sent '#{data_to_send}'.")
end
# cleaning
tcp_client.close
logger.close
