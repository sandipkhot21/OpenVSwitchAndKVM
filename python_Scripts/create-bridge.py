#! /usr/bin/python
# creation of ovs switches  
#author ajay shinde
import subprocess, sys, ConfigParser

Config = ConfigParser.ConfigParser()
Config.read("switchconf")
def shortdelay():
 subprocess.call("sleep 1",shell=True)

def executeCmd(cmd):
 print cmd
 subprocess.call(cmd,shell=True)
 shortdelay()

cnt = len(list(Config.sections()))
switch_name = Config.get('switch_0','switch_name')
port = Config.get('switch_0','port')
ip = Config.get('switch_0','ip')
print "creating switches"

cmds = []

cmds.append("ifconfig eth0 0");
cmds.append("service networking stop >> /dev/null 2>&1");
cmds.append("service networking start >> /dev/null 2>&1");  
cmds.append("ovs-vsctl add-br "+switch_name);
cmds.append("ovs-vsctl add-port "+switch_name+" "+port);
cmds.append("ifconfig "+switch_name+" "+ip+" up");
cmds.append("service openvswitch-switch restart >> /dev/null 2>&1");

for cmd in cmds:
  executeCmd(cmd)	
#=-----------------------------------------------------------------------------------------------------------=#
for x in xrange(1, cnt):
	switch_name=Config.get("switch_"+str(x),'switch_name')
	subprocess.call("ovs-vsctl add-br "+switch_name,shell=True);
	subprocess.call("ifconfig "+switch_name+" up",shell=True);
print cnt, "switch created Sucessfully "
sys.exit(0)
