#!/bin/sh

MYP=/media/Common/PPSC;

#Install the necessary dependancies
apt-get update;
apt-get install --force-yes -y debhelper autoconf automake libssl-dev graphviz python-all python-qt4;
apt-get install --force-yes -y python-zopeinterface python-twisted-conch  libtool module-assistant;

#Install Openvswitch
cp $MYP/OVS_Source/ovs-master.zip ~/;
cd;
unzip ovs-master.zip;
cd ovs-master;
DEB_BUILD_OPTIONS='parallel=8' fakeroot debian/rules binary;
dpkg -i ../*.deb;

#Install the kvm related packages
apt-get install qemu-kvm libvirt-bin libvirt0 python-libvirt virtinst;
apt-get install uml-utilities;

#
echo -e '#!/bin/sh\nswitch="br0"\n/sbin/ifconfig $1 0.0.0.0 up\novs-vsctl add-port ${switch} $1' > /etc/ovs-ifup;
echo -e '#!/bin/sh\nswitch="br0"\n/sbin/ifconfig $1 0.0.0.0 down\novs-vsctl del-port ${switch} $1' > /etc/ovs-ifdown;
chmod +x /etc/ovs-ifup;
chmod +x /etc/ovs-ifdown;

ifconfig eth0 0;
service network-manager stop;
service networking stop && service networking start;
