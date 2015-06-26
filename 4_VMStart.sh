#!/bin/sh

OVS_MYP=/media/sandip/Common/PPSC/Scripts;
IMG_MYP=/media/sandip/Common/PPSC/QEMUImages;

#Start the virtual Machine 00 & 10
cp $OVS_MYP/ovs-ifup /etc/ovs-ifup0_0;
cp $OVS_MYP/ovs-ifdown /etc/ovs-ifdown0_0;
sync;
sed -i "s/.*switch=.*/switch=\'br0\'/" /etc/ovs-ifup0_0;
sed -i "s/.*switch=.*/switch=\'br0\'/" /etc/ovs-ifdown0_0;
chmod +x /etc/ovs-ifup0_0;
chmod +x /etc/ovs-ifdown0_0;

cp $OVS_MYP/ovs-ifup /etc/ovs-ifup1_0;
cp $OVS_MYP/ovs-ifdown /etc/ovs-ifdown1_0;
sync;
sed -i "s/.*switch=.*/switch=\'br1\'/" /etc/ovs-ifup1_0;
sed -i "s/.*switch=.*/switch=\'br1\'/" /etc/ovs-ifdown1_0;
chmod +x /etc/ovs-ifup1_0;
chmod +x /etc/ovs-ifdown1_0;
kvm -m 512 -net nic,macaddr=00:00:00:00:cc:10 -net tap,script=/etc/ovs-ifup0_0,downscript=/etc/ovs-ifdown0_0 -net nic,macaddr=18:03:73:ac:dd:01 -net tap,script=/etc/ovs-ifup1_0,downscript=/etc/ovs-ifdown1_0 -drive file=$IMG_MYP/debian_00.img &
sleep 10;
sync;

#Start the virtual Machine 11
cp $OVS_MYP/ovs-ifup /etc/ovs-ifup1_1;
cp $OVS_MYP/ovs-ifdown /etc/ovs-ifdown1_1;
sync;
sed -i "s/.*switch=.*/switch=\'br0\'/" /etc/ovs-ifup1_1;
sed -i "s/.*switch=.*/switch=\'br0\'/" /etc/ovs-ifdown1_1;
chmod +x /etc/ovs-ifup1_1;
chmod +x /etc/ovs-ifdown1_1;
kvm -m 512 -net nic,macaddr=00:11:22:CC:CC:10 -net tap,script=/etc/ovs-ifup1_1,downscript=/etc/ovs-ifdown1_1 -drive file=$IMG_MYP/debian_01.img &
sleep 10;
sync;

#Start the virtual Machine 20
cp $OVS_MYP/ovs-ifup /etc/ovs-ifup2_0;
cp $OVS_MYP/ovs-ifdown /etc/ovs-ifdown2_0;
sync;
sed -i "s/.*switch=.*/switch=\'br1\'/" /etc/ovs-ifup2_0;
sed -i "s/.*switch=.*/switch=\'br1\'/" /etc/ovs-ifdown2_0;
chmod +x /etc/ovs-ifup2_0;
chmod +x /etc/ovs-ifdown2_0;
kvm -m 512 -net nic,macaddr=22:22:22:00:cc:10 -net tap,script=/etc/ovs-ifup2_0,downscript=/etc/ovs-ifdown2_0 -drive file=$IMG_MYP/debian_10.img &
sleep 10;
sync;

#Start the virtual Machine 21
cp $OVS_MYP/ovs-ifup /etc/ovs-ifup2_1;
cp $OVS_MYP/ovs-ifdown /etc/ovs-ifdown2_1;
sync;
sed -i "s/.*switch=.*/switch=\'br1\'/" /etc/ovs-ifup2_1;
sed -i "s/.*switch=.*/switch=\'br1\'/" /etc/ovs-ifdown2_1;
chmod +x /etc/ovs-ifup2_1;
chmod +x /etc/ovs-ifdown2_1;
kvm -m 512 -net nic,macaddr=00:11:22:EE:EE:EE -net tap,script=/etc/ovs-ifup2_1,downscript=/etc/ovs-ifdown2_1 -drive file=$IMG_MYP/debian_11.img &
sleep 10;
sync;
