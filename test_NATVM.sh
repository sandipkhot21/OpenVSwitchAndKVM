#!/bin/sh

MYP=/media/sandip/Common/PPSC;

#Start the virtual Machine 00 & 10
cp $MYP/Scripts/ovs-ifup /etc/ovs-ifup0_0;
cp $MYP/Scripts/ovs-ifdown /etc/ovs-ifdown0_0;
sync;
sed -i "s/.*switch=.*/switch=\'br0\'/" /etc/ovs-ifup0_0;
sed -i "s/.*switch=.*/switch=\'br0\'/" /etc/ovs-ifdown0_0;
chmod +x /etc/ovs-ifup0_0;
chmod +x /etc/ovs-ifdown0_0;


for i
	cp $MYP/Scripts/ovs-ifup /etc/ovs-ifup$i_$j;
	cp $MYP/Scripts/ovs-ifdown /etc/ovs-ifdown$i_$j;
	sync;
	sed -i "s/.*switch=.*/switch=\'br$i\'/" /etc/ovs-ifup$i_$j;
	sed -i "s/.*switch=.*/switch=\'br$i\'/" /etc/ovs-ifdown$i_$j;
	chmod +x /etc/ovs-ifup$i_$j;
	chmod +x /etc/ovs-ifdown$i_$j;

kvm -m 512 -net nic,macaddr=00:00:00:00:cc:10 -net tap,script=/etc/ovs-ifup0_0,downscript=/etc/ovs-ifdown0_0 -net nic,macaddr=18:03:73:ac:dd:01 -net tap,script=/etc/ovs-ifup1_0,downscript=/etc/ovs-ifdown1_0 -drive file=$MYP/QEMUImages/debian_00.img &
sleep 10;
sync;

KSTR1="kvm -m 512 "
KSTR2="-net nic,macaddr=00:00:00:00:cc:10 -net tap,script=/etc/ovs-ifup0_0,downscript=/etc/ovs-ifdown0_0 "
KSTR2=-drive file=$MYP/QEMUImages/debian_00.img &
