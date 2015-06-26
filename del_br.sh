#!/bin/sh

#Script to delete all the bridges along with there respective settings created in Step 2.

ovs-vsctl del-br br0;
ovs-vsctl del-br br1;
ovs-vsctl del-br br2;
