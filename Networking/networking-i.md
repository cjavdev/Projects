# Networking I

## OSI Model
The internet as we know it is often conceptualized using the 7 layer OSI (Open Systems Interconnection) Model. It's a way to separate functions and technologies used for networking at each layer into groups.

| Layer           | Data Unit       | Function                              |
|:----------------|:----------------|:--------------------------------------|
| 1. Physical     | Bit             | Media, Signal and binary transmission
| 2. Data Link    | Frame           | Physical addressing
| 3. Network      | Packet/Datagram | Logical addressing (routing)
| 4. Transport    | Segment         | End to End connections and flow control
| 5. Session      | (Data)          | Interhost communication, sessions between apps |
| 6. Presentation | (Data)          | Machine dependent to machine independent, encryption decryption |
| 7. Application  | (Data)          | Network process to application        |


## Tools
The internet network as we know it is a complicated beast. Since its inception many tools have been created for diagnosing problems and testing routing, connectivity and general network function.

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


### `traceroute`

### `nmap`

### Wireshark