=begin
Run this on the dir where clean generated log files exist.
=end

require 'csv'
require 'time'

=begin
METHODS DEFINITION
=end
def get_timestamps(file)
  timestamps = []
  File.readlines(file).each do |line|
    next if !(m = line.match(/\[(.+?)\s/))
    timestamps << Time.parse(m[1])    
  end
  timestamps
end

def calculate_jitter(latencies)
  diffs = []
  (1...(latencies.size)).each do |i|
    diffs << (latencies[i] - latencies[i - 1]).abs
  end
  diffs.inject(:+) / (diffs.size - 1)
end

=begin
RUNTIME
=end
scripts_dir = File.dirname(__FILE__)
c_tcp_data = get_timestamps(File.join(scripts_dir, 'client_tcp.log'))
s_tcp_data = get_timestamps(File.join(scripts_dir, 'server_tcp.log'))
c_udp_data = get_timestamps(File.join(scripts_dir, 'client_udp.log'))
s_udp_data = get_timestamps(File.join(scripts_dir, 'server_udp.log'))

# calculate statistics on TCP
tcp_latencies = []
s_tcp_data.each_with_index do |val, i|
  tcp_latencies << (val - c_tcp_data[i])
end

# calculate statistics on TCP
udp_latencies = []
s_udp_data.each_with_index do |val, i|
  udp_latencies << (val - c_udp_data[i])
end

# generate CSV string
csv_s = CSV.generate(write_headers: true) do |csv|
  csv << ['PROTOCOL', 'MIN LATENCY [ms]', 'MAX LATENCY [ms]', 'AVG LATENCY [ms]', 'JITTER [ms]']
  csv << ['TCP', (tcp_latencies.min * 1000), (tcp_latencies.max * 1000), ((tcp_latencies.inject(:+) / tcp_latencies.size) * 1000), calculate_jitter(tcp_latencies) * 1000]
  csv << ['UDP', (udp_latencies.min * 1000), (udp_latencies.max * 1000), ((udp_latencies.inject(:+) / tcp_latencies.size) * 1000), calculate_jitter(udp_latencies) * 1000]
end

File.write(File.join(scripts_dir, 'network_stats.csv'), csv_s)
