# OpenVSwitchAndKVM
It implements the network displayed within the image file.
This project has the bash scripts that will: -
  1. Install openvswitch, kvm and there respective dependencies.
  2. Create 3 openvswitch bridges and add patch interface between 2 bridges to communicate
  3. Create an image file for debian netinst. (Refer Qemu documentation to creaate the image file)
     Also Preseeding explained in my OpenStack project can be used to install the OS(.img file).
  4. Start each VM with creating tap interface to respective bridges.
  5. Run NAT addition script on the first VM
  6. Commands to test proper working of the network setup
  
Note:-  This setup can be used to see how basic openvswitch layer 2 switch works, basic NAT i.e Virtual Machine 
        can be made to work as a router.
