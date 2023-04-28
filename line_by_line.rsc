/system backup save 
/system reset-configuration no-defaults=yes


#part1 (v6)

/interface wireless enable numbers=wlan1,wlan2 
/interface wireless security-profiles set numbers=0 authentication-types=wpa-psk,wpa2-psk wpa-pre-shared-key=mikrotik wpa2-pre-shared-key=mikrotik mode=dynamic-keys 
/interface wireless set  numbers=0 ssid=ROS-6 mode=station 

#check if you're  connected to wireless

/interface bridge
add name=bridge1
/interface bridge port
add bridge=bridge1 interface=ether1
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether3
add bridge=bridge1 interface=ether4
add bridge=bridge1 interface=ether5

/ip address add address=10.0.X.1/24 interface=bridge1
/ip dhcp-server setup 

/ip dhcp-client add interface=wlan1 disabled=no
/routing ospf network add network=10.0.X.0/24 area=backbone
/routing ospf network add network=192.168.10.0/24 area=backbone 



#part2 (v7)


/routing/ospf/instance/add name=v2 version=2 
/routing/ospf/area/add name=v2 instance=v2 
/routing/ospf/interface-template/add interfaces=bridge area=v2 networks=10.0.X.0/24 
/routing/ospf/interface-template/add interfaces=wlan1  area=v2 networks=192.168.10.0/24 

