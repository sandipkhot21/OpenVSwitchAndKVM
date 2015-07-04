#!/usr/bin/env python
# script to allocate static IP to virtual machines from guestConfig file
#Author Saurabh kukade
import os
import sys
import subprocess
import ConfigParser
parser=ConfigParser.ConfigParser()
parser.read('guestConfig')
listSection=list(parser.sections())
workingDir=subprocess.check_output("pwd",shell=True)
workingDir=((workingDir).splitlines())[0]
#Fucntion to allocate static IP Addr to virtual machine
def ipAlloc(ipAddr,netmask,imageFile):
	print "\nmounting file system of image file"
#mounting file system of qemu image
	subprocess.call("sync",shell=True)
	subprocess.call("modprobe nbd max_port=16",shell=True)
	subprocess.call("qemu-nbd -c /dev/nbd0 "+imageFile,shell=True)
	subprocess.call("partprobe /dev/nbd0",shell=True)
	subprocess.call("mount /dev/nbd0p1 /mnt",shell=True)
#changing interface file and allocating static IP
	print "\nallocating static ip in file /mnt/etc/network/interfaces"
	os.chdir('/mnt/etc/network/')
	fo1= open('interfaces.bak','a+')
	content=fo1.read()
	fo1.close()
	fo1= open('interfaces','w+')
	fo1.write(content+"\n#static ip allocation\nauto eth0\niface eth0 inet static\naddress "+ipAddr+"\nnetmask "+netmask+"\n");
	fo1.close()
	subprocess.call("cd ",shell=True)
	print "\ndone Allocating IP adress to machine"
	subprocess.call("sync",shell=True)
	subprocess.call("sleep 2s",shell=True)
	os.chdir(workingDir)
#unmoun and deleting device and machine
	print "\nunmounting file system and deleting device"
	subprocess.call("umount /mnt",shell=True)
	subprocess.call("qemu-nbd -d /dev/nbd0",shell=True)
	subprocess.call("killall qemu-nbd",shell=True)
	subprocess.call("sync;sleep 2s",shell=True)
	return;
cnt=len(list(parser.sections()))+1
for x in range (1,cnt):
	mac_addr = parser.get('guest_%d' % (x),'mac_addr',)
	ip_addr = parser.get('guest_%d' % (x),'ip_addr',)
	ram = parser.get('guest_%d' % (x),'ram',)
	imageFile = parser.get('guest_%d' % (x),'imageFile',)
	netmask=parser.get('guest_%d' % (x),'netmask',)
	ipAlloc(ip_addr,netmask,imageFile)
	print "\n\ndone "+str(x) 


