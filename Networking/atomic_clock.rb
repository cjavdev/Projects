require 'socket'
require 'timeout'

def atomic_time
  #get atomic clock time from internet
  sock = UDPSocket.new
  sock.connect('pool.ntp.org', 'ntp')
  sock.send "uuuu", 0
  p sock.recvfrom(960)

end

atomic_time
