/system backup save 
/system reset-configuration no-defaults=yes


#part1

 /interface wireless enable numbers=wlan1,wlan2 
/interface bridge
add name=bridge1
/interface bridge port
add bridge=bridge1 interface=ether1
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether3
add bridge=bridge1 interface=ether4
add bridge=bridge1 interface=ether5
/Ip address add address=10.0.1.1/24 interface=bridge1
/ip dhcp-server setup 
 ip dhcp-client add interface=wlan1 disabled=no
/routing ospf network add network=10.0.1.0/24 area=backbone
/routing ospf network add network=192.168.10.0/24 area=backbone 



#part2


/routing/ospf/instance/add name=v2 version=2 
/routing/ospf/area/add name=v2 instance=v2 
/routing/ospf/interface-template/add interfaces=bridge area=v2 networks=10.0.0.0/24 
/routing/ospf/interface-template/add interfaces=wlan1  area=v2 networks=192.168.10.0/24 

#part3


V6:
/system package enable ipv6
/system reboot
/ipv6 address add address=2a0b:b8c0:ffff:11::1/64 interface=wlan1 advertise=no
/ipv6 address add address=2a0b:b8c0:ffff:1::1/64 interface=bridge1 
/routing ospf-v3 interface add interface=all area=backbone 



V7 
/ipv6/address/add address=2a0b:b8c0:ffff:12::1/64 advertise=no interface=wlan1 
/ipv6/address/add address=2a0b:b8c0:ffff:2::1/64  interface=bridge   
/routing/ospf/instance/add name=v3 version=3 
/routing/ospf/area/ add name=v3 instance=v3 
/routing/ospf/interface-template/ add interfaces=bridge area=v3  networks=2a0b:b8c0:ffff:2::1/64 
/routing/ospf/interface-template/ add interfaces=wifi_2G  area=v3  networks=2a0b:b8c0:ffff:12::1/64 



