#!/bin/bash
public_interface=$(ip route | grep '10.1.99.0/24' | awk '{print $3}' | head -1)
private_interface=$(ip route | grep '192.168.99.0/24' | awk '{print $3}' | head -1)
iptables -t nat -A PREROUTING -i $public_interface -p udp --dport 51820 -j DNAT --to-destination 192.168.99.3:51820
iptables -A FORWARD -i $public_interface -o $private_interface -p udp --dport 51820 -d 192.168.99.3 -j ACCEPT
iptables -A FORWARD -i $private_interface -o $public_interface -p udp --sport 51820 -s 192.168.99.3 -j ACCEPT
