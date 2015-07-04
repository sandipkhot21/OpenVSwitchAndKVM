#!/usr/bin/env python
import sys
import os
import subprocess
from subprocess import Popen, PIPE
import zipfile 

filePath='files/'
print "updating a package list"
	#subprocess.call("apt-get update",shell=True)
#Install the necessary dependancies
os.system('clear')
print "---------install the necessary dependancies--------------------"

subprocess.call("apt-get install --force-yes -y debhelper autoconf automake libssl-dev graphviz python-all python-qt4;",shell=True)
subprocess.call("apt-get install --force-yes -y python-zopeinterface python-twisted-conch  libtool module-assistant;",shell=True)
subprocess.call("apt-get install ipsec-tools racoon dkms python-twisted-web",shell=True)

print "------------dependancies installed and managed---------------"
#installing openSwitch 
os.system('clear')
print "----------installing openSwitch host machine-------------------"
os.chdir(filePath)
os.system("unzip ovs-master.zip")
os.chdir("ovs-master")
os.system("DEB_BUILD_OPTIONS='parallel=8' fakeroot debian/rules binary;")
os.system("dpkg -i *.deb;")
os.system('clear')
print "-----------------openvswitch configured suceesfully----------------"
#------------------------------------------------------------------------------------------------------------------#
#Installing kvm and related packages
os.system('clear')
print "-----------Installing  the kvm and related packages----------------"
subprocess.call("apt-get install --force-yes -y qemu-kvm libvirt-bin libvirt0 python-libvirt virtinst",shell=True)
subprocess.call("apt-get install --force-yes -y uml-utilities",shell=True)
os.system('clear')
#---------------creating ovs-ifup and ovs-ifdown-------------#
os.chdir('/etc/')
fo1= open("ovs-ifup","w+")
fo1.write("!/bin/sh\nswitch=\"br0\"\n/sbin/ifconfig $1 0.0.0.0 up\novs-vsctl add-port ${switch} $1");
fo1.close
fo= open("ovs-ifdown","w+")
fo.write("!/bin/sh\nswitch=\"br0\"\n/sbin/ifconfig $1 0.0.0.0 down\novs-vsctl del-port ${switch} $1");
fo.close
os.chmod('/etc/ovs-ifup',0777)
os.chmod('/etc/ovs-ifdown',0777)
subprocess.call("cd -",shell=True)
os.system('clear')
print "resarting service manager"
subprocess.call("ifconfig eth0 0",shell=True)
subprocess.call("service network-manager stop",shell=True)
subprocess.call("service networking stop && service networking start",shell=True)
os.system('clear')
RED    =  subprocess.check_output(" tput setaf 1 " , shell=True)
GREEN  =  subprocess.check_output(" tput setaf 2 " , shell=True)
black   =  subprocess.check_output(" tput setab 5 " , shell=True)
NORMAL =  subprocess.check_output(" tput sgr0    " , shell=True)

os.system('clear')
subprocess.call("rm -rf files/*.deb",shell=True)
print GREEN+"ovs and kvm successfully installed on system"+NORMAL
