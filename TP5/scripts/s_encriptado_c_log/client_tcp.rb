require 'socket'
require 'logger'

=begin
CONSTANTS
=end
SERVER_IP = '192.168.1.101'.freeze
SERVER_PORT = 4000
SLP_TIME = 1
GRP_NAME = 'epsilon'.freeze
AMT_OF_PACKETS_TO_SND = 100
PROGRAM = 'client_tcp'.freeze
LOG_FILENAME = "#{PROGRAM}.log".freeze

=begin
RUNTIME
=end
# log file creation
logger = Logger.new(File.join(File.dirname(__FILE__), LOG_FILENAME))
# socket creation and usage
tcp_client = TCPSocket.new(SERVER_IP, SERVER_PORT)
AMT_OF_PACKETS_TO_SND.times do |i|
  # send req
  data_to_send = "req_#{GRP_NAME}_#{i}"
  puts("Sending '#{data_to_send}'...")
  logger.add(Logger::INFO, "Sending: '#{data_to_send}' to srv.", PROGRAM)
  tcp_client.puts(data_to_send)
  # get rsp (blocking)
  rsp = tcp_client.gets.chomp
  logger.add(Logger::INFO, "Received: '#{rsp}' from srv.", PROGRAM)
  puts("Received '#{rsp}'.")
  # sleep a fixed amount of time between requests
  sleep(SLP_TIME)
end
# cleaning
tcp_client.close
logger.close
