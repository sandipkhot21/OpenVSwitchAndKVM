#!/bin/sh

MYP=/media/sandip/Common/PPSC;

ifconfig eth0 0;
service network-manager stop;
echo -e 'nameserver 8.8.8.8\nnameserver 8.8.4.4' > /etc/resolv.conf;
service networking stop && service networking start;
#Create the openvswitch Interface for the Virtual Machine to attach to
ovs-vsctl --may-exist add-br br0;
ovs-vsctl --may-exist add-port br0 eth0;
ifconfig eth0 0;
dhclient br0;


ovs-vsctl --may-exist add-br br1;
#ifconfig br1 192.168.2.1/24;
ovs-vsctl --may-exist add-br br2;
#ifconfig br2 192.168.3.1/24;
ovs-vsctl --may-exist add-port br1 cable12 -- set Interface cable12 type=patch options:peer=cable21;
ovs-vsctl --may-exist add-port br2 cable21 -- set Interface cable21 type=patch options:peer=cable12;








