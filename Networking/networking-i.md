# Networking I

![Internet](http://electls.blogs.wm.edu/files/2012/04/series-of-tubes.jpg)

## OSI Model
The internet as we know it is often conceptualized using the 7 layer [OSI (Open Systems Interconnection) Model](http://en.wikipedia.org/wiki/OSI_model). It's a way to separate functions and technologies used for networking at each layer into groups.

| Layer           | Data Unit       | Function                              |
|:----------------|:----------------|:--------------------------------------|
| 1. Physical     | Bit             | Media, Signal and binary transmission
| 2. Data Link    | Frame           | Physical addressing
| 3. Network      | Packet/Datagram | Logical addressing (routing)
| 4. Transport    | Segment         | End to End connections and flow control
| 5. Session      | (Data)          | Interhost communication, sessions between apps |
| 6. Presentation | (Data)          | Machine dependent to machine independent, encryption decryption |
| 7. Application  | (Data)          | Network process to application        |
| 8. Human/Chair	  |  ????           | Break stuff, complain |


## Tools
The internets network as we know it is a complicated beast. Since its inception many tools have been created for diagnosing problems and testing routing, connectivity and general network function.

Before we get started lets download:
* [nmap](http://nmap.org/download.html#macosx)
* [wireshark](http://www.wireshark.org/download.html) Note: This may have you dl some extra stuff to get it to display (X11 & XQuartz)

### `ifconfig`
You: Hey man, whats your IP?
That Guy: Um... where do I find that?
You: (facepalm)

On windows machines there is a command `ipconfig`. On every other *nix machine you ever touch (so pretty much everything else) you will find the `ifconfig` command utility. `ifconfig` (interface configuration) is a utility to query, control and configure your NIC (TCP/IP network interface card aka wireless card). 

running `ifconfig` alone will query all NIC's on your system and report something like this:

```
$ ifconfig
lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> mtu 16384
	options=3<RXCSUM,TXCSUM>
	inet6 fe80::1%lo0 prefixlen 64 scopeid 0x1 
	inet 127.0.0.1 netmask 0xff000000 
	inet6 ::1 prefixlen 128 
gif0: flags=8010<POINTOPOINT,MULTICAST> mtu 1280
stf0: flags=0<> mtu 1280
en0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	ether 54:26:96:d2:a4:93 
	inet6 fe80::5626:96ff:fed2:a493%en0 prefixlen 64 scopeid 0x4 
	inet 10.0.1.35 netmask 0xffffff00 broadcast 10.0.1.255
	media: autoselect
	status: active
p2p0: flags=8843<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST> mtu 2304
	ether 06:26:96:d2:a4:93 
	media: autoselect
	status: inactive
``` 
My wireless interface is *en0* and my loop back interface is *lo0*. Notice `inet 127.0.0.1` on *lo0* is my localhost loop back ip address.

Lets take a look at my *en0* config:

```
en0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	ether 54:26:96:d2:a4:93 
	inet6 fe80::5626:96ff:fed2:a493%en0 prefixlen 64 scopeid 0x4 
	inet 10.0.1.35 netmask 0xffffff00 broadcast 10.0.1.255
	media: autoselect
	status: active
```

* ether 54:26:96:d2:a4:93
This is my MAC address. This is the hardware address encoded on the actual network interface card hardware. You can usually figure out what type of device you're connected to based on the MAC address because vendors buy MAC address ranges and there are tools like [mac_find](http://www.coffer.com/mac_find/) that allow you to look up vendors by mac address.

* inet6 fe80::5626:96ff:fed2:a493%en0
This is my ipv6 address.

* inet 10.0.1.35 netmask 0xffffff00 broadcast 10.0.1.255
10.0.1.35 is the ipv4 address of my wireless card. Netmask is used to determine which network my computer is a part of. It is shown here in Hex, but more commonly its displayed as dotted decimal and would look like 255.255.255.0
The bits in the netmask can be binary anded against my ip address to determine my `net id` of the local network. So.

hostip 10.0.1.35    => 00001010.00000000.00000001.00100011
netmask255.255.255.0=> 11111111.11111111.11111111.00000000
netid  10.0.1.0     => 00001010.00000000.00000001.00000000

the broadcast ip is 10.0.1.255. this will always be the highest ip address in the local network. so for network with net id 10.0.1.0 and netmask 255.255.255.0 the highest possible ip is 10.0.1.255 and this is the address where we will send things if the intended destination is all of the hosts on our local network. (There is also a MAC level/Data Link Broadcast address that is FF:FF:FF:FF:FF:FF)


### `arp`
`arp`  

### `ping`
That Guy: The website looks like its down!
You: I cant browse to it either, but I just ping-d the webserver IP and it looks up. Can you ping it from your end?
That Guy: "I dont know how to ping..."

dun dun dun. lets not be That Guy

NB: localhost is an alias for your own machine. Your computer has a loop back address 127.0.0.1 there is a virtual interface with this ip address. In IPv6 the address is ::1 (looks funny but thats it). Some computers also allow 0.0.0.0 but thats not really correct. Use localhost or 127.0.0.1 to get to your self.


the `ping` command sends an ICMP (aka echo aka ping) request to a destination ip address on tcp/port 1. destination hosts and routers should respond with a `pong` response. The `ping` utility is to *test connectivity*


`username:~/$  ping localhost`
`username:~/$  ping 8.8.8.8`
`username:~/$  ping 256.1.1.1`
`username:~/$  ping 98.124.199.1`
`username:~/$  ping google.com` Lets talk about this one when we get to `nslookup`

This is what a ping to github looks like when github is sucking. 
```
$ ping github.com
PING github.com (207.97.227.239): 56 data bytes
Request timeout for icmp_seq 0
64 bytes from 207.97.227.239: icmp_seq=1 ttl=47 time=134.107 ms
Request timeout for icmp_seq 2
Request timeout for icmp_seq 3
Request timeout for icmp_seq 4
Request timeout for icmp_seq 5
Request timeout for icmp_seq 6
Request timeout for icmp_seq 7
^C
--- github.com ping statistics ---
12 packets transmitted, 1 packets received, 91.7% packet loss
round-trip min/avg/max/stddev = 134.107/134.107/134.107/0.000 ms
```

### `traceroute`
Routing is a huge topic. How to get stuff from one machine on the internet to another really fast. Tricky stuff.

There are lots of dynamic routing protocols that will basically change the path through the graph that they will traverse based on metrics. Here are some of the metrics the protocols might use to decide which path to send your packets over:

* Path length
* Reliability
* Delay
* Bandwidth
* Load
* Communication cost

`traceroute` is a command line utility that allows you to see how your packets are traversing the network. One huge benefit of this is you can see the delay between each hop so you can tell where the bottle necks are (speed).

```
$ traceroute www.sniperhill.net
traceroute to sniperhill.net (31.222.171.5), 64 hops max, 52 byte packets
 1  10.0.1.1 (10.0.1.1)  8.040 ms  5.890 ms  7.095 ms
 2  gw-block202.static.monkeybrains.net (199.241.202.1)  18.308 ms  10.226 ms  9.208 ms
 3  cpmc.cpmc-somagrand.core.monkeybrains.net (172.17.17.42)  16.777 ms  27.749 ms  12.855 ms
 4  grillo.grillo-cpmc.core.monkeybrains.net (208.69.43.165)  10.027 ms  23.334 ms  15.793 ms
 5  guava.guava-grillo.core.monkeybrains.net (208.69.43.137)  26.357 ms  14.399 ms  27.375 ms
 6  kiwi.kiwi-abeja.core.monkeybrains.net (208.69.43.133)  16.305 ms  19.765 ms  23.627 ms
 7  asn32107.wavebroadband.monkeybrains.net (208.90.215.13)  17.732 ms  19.545 ms  15.357 ms
 8  xe-0-2-0.mpr3.sfo3.us.above.net (64.124.146.181)  19.907 ms  18.194 ms  23.888 ms
 9  xe-5-1-0.cr1.sjc2.us.above.net (64.125.31.154)  19.600 ms  15.864 ms  14.805 ms
10  xe-1-2-0.cr1.ord2.us.above.net (64.125.26.138)  72.573 ms  69.186 ms  78.201 ms
11  xe-5-0-0.cr1.lga5.us.above.net (64.125.31.238)  93.442 ms  98.793 ms  93.112 ms
12  xe-0-1-0.mpr3.lhr3.uk.above.net (64.125.21.206)  156.434 ms  160.818 ms  158.753 ms
13  xe-8-1-1.mpr2.lhr3.uk.above.net.24.125.64.in-addr.arpa (64.125.24.218)  162.499 ms  167.350 ms  162.966 ms
14  xe-1-0-0.mpr1.lhr8.uk.above.net (64.125.28.206)  170.244 ms  171.225 ms  167.686 ms
15  xe-0-3-0.mpr1.lhr23.uk.above.net (64.125.29.14)  159.745 ms  161.995 ms  169.929 ms
16  94.31.34.190 (94.31.34.190)  160.153 ms  161.315 ms  162.487 ms
17  coreb-edge4.lon3.rackspace.net (164.177.137.36)  171.140 ms
    corea-edge4.lon3.rackspace.net (164.177.137.34)  199.148 ms
    coreb-edge4.lon3.rackspace.net (164.177.137.36)  165.984 ms
18  core6a-corea.lon3.rackspace.net (164.177.137.11)  161.600 ms
    core6a-coreb.lon3.rackspace.net (164.177.137.23)  183.669 ms
    core6a-corea.lon3.rackspace.net (164.177.137.11)  169.070 ms
19  aggr325a-4-core6a.lon3.rackspace.net (92.52.77.107)  168.653 ms  168.865 ms  176.803 ms
20  www.sniperhill.net (31.222.171.5)  167.966 ms !Z  168.804 ms !Z  161.457 ms !Z
```


Resources:
* [Cisco Routing Basics](http://docwiki.cisco.com/wiki/Routing_Basics)
* [Looking glass](http://lg.above.net/lg.cgi)
* [Routing - wiki](http://en.wikipedia.org/wiki/Routing)
* [Traceroute - wiki](http://en.wikipedia.org/wiki/Traceroute)

### `nmap`
`nmap` is a security scanner and is used to discover hosts and services on a network. This tool has an abundance of options... way too many... way way too many... when you think about scanning anything you should first think `nmap` then search the docs for how to do what you want. 

`nmap` can do:
* Host discovery
* Port scanning
* Version detection - Interrogating network services on remote devices to determine application name and version number. (This will use fingerprinting and try to determine stuff based on response times, formats of response packets and other metrics)
* OS detection - Usually open ports and versions of services
* Scriptable interaction with the target
* Information on targets - Reverse DNS names, device types, and MAC addresses.

Typical uses of `nmap`:
* Auditing the security of a device by identifying the network connections which can be made to it.[citation needed]
* Identifying open ports on a target host in preparation for auditing.[8]
* Network inventory, network mapping, maintenance and asset management.
* Auditing the security of a network by identifying new servers.[9]

`nmap -sS localhost` will perform a syn scan of your own computer. This will show open tcp ports. 

```
$ sudo nmap -sS localhost
Password:

Starting Nmap 6.40 ( http://nmap.org ) at 2013-08-15 11:39 PDT
Nmap scan report for localhost (127.0.0.1)
Host is up (0.00013s latency).
Not shown: 996 closed ports
PORT     STATE SERVICE
80/tcp   open  http
631/tcp  open  ipp
3000/tcp open  ppp
5432/tcp open  postgresql

Nmap done: 1 IP address (1 host up) scanned in 8.16 seconds
```

There are tons and tons of scans, and you can find the basics [here](http://nmap.org/bennieston-tutorial/)

Resources:
* [nmap.org](http://nmap.org/)
* [basic scans](http://nmap.org/bennieston-tutorial/)

### `telnet` and `ssh`
`telnet` and `ssh` are tools for remotely interacting with servers.
the huge difference between the two utilities is that telnet sends everything in clear text. SSH encrypts everything. *ALWAYS* try ssh first.

`telnet 10.0.1.133`

`ssh username@10.0.1.133`

### Wireshark
Tool for sniffing traffic and inspecting packets.
