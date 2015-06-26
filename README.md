# OpenVSwitchAndKVM
It implements the network displayed within the image file.
This project has the bash scripts that will: -
  1. Install openvswitch, kvm and there respective dependencies.
  2. Create 3 openvswitch bridges and add patch interface between 2 bridges to communicate
  3. Create an image file for debian netinst. (Refer Qemu documentation to creaate the image file)
     Also Preseeding explained in my OpenStack project can be used to install the OS(.img file).
  4. Start each VM with creating tap interface to respective bridges.
  5. Run NAT addition script on the first VM
  6. Commands to test proper working of the network as per the image setup:
      On VM_0 and VM_1 machine these should give some reply:
        $ping -c 4 192.168.4.11
        $ping -c 4 192.168.1.12
        $ping -c 4 8.8.8.8
      On VM_0 & VM_1 machine these should not reply:
        $ping -c 4 192.168.2.11
        $ping -c 4 192.168.2.12
      Similarly on VM_2 and VM_3 machine these should give some reply:
        $ping -c 4 192.168.4.11
        $ping -c 4 192.168.2.12
        $ping -c 4 192.168.2.11
        $ping -c 4 8.8.8.8
      On VM_2 and VM_3 machine these should not reply:
        $ping -c 4 192.168.1.12
        $ping -c 4 192.168.5.201
  
Note:-  This setup can be used to see how basic openvswitch layer 2 switch works, basic NAT i.e Virtual Machine 
        can be made to work as a router.
        The layer 3 functionality has been implemented by using the VM_0 as a router.
        To make the ovs switches(br0-2) we need to add layer three functionality to them.
        The best explaination/example available for the same can be found on the below link:
        http://en.community.dell.com/techcenter/networking/w/wiki/3820.openvswitch-openflow-lets-get-started
