#!/bin/sh
echo "### Starting Instance ###"
multipass start sdx
echo "### Network config ###"
multipass exec sdx ifconfig
echo " ##### Add name spaces ##### "
multipass exec sdx sudo ip netns add netns10
multipass exec sdx sudo ip netns add netns11
multipass exec sdx sudo ip netns add netns12
multipass exec sdx sudo ip netns add netns13
echo " ##### interconnecting containers to host: Add  devices link ##### "
multipass exec sdx -- bash -c "sudo ip link add veth10 type veth peer name ceth10"
multipass exec sdx -- bash -c "sudo ip link add veth11 type veth peer name ceth11"
multipass exec sdx -- bash -c "sudo ip link add veth12 type veth peer name ceth12"
multipass exec sdx -- bash -c "sudo ip link add veth13 type veth peer name ceth13"
echo " ##### Set veth devices up ##### "
multipass exec sdx sudo ip link set veth10 up
multipass exec sdx sudo ip link set veth11 up
multipass exec sdx sudo ip link set veth12 up
multipass exec sdx sudo ip link set veth13 up
echo " ##### IP Route ##### "
multipass exec sdx sudo ip link add br0 type bridge
multipass exec sdx sudo ip link set br0 up
multipass exec sdx sudo ip link set veth10 master br0
multipass exec sdx sudo ip link set veth11 master br0
multipass exec sdx sudo ip link set veth12 master br0
multipass exec sdx sudo ip link set veth13 master br0
echo "##### assign the name spaces gateway IP address to the bridge network interface ##### "
multipass exec sdx sudo ip addr add 192.168.10.1/28 dev br0
echo " ##### Move ceth devices to netns namespaces ##### "
multipass exec sdx sudo ip link set ceth10 netns netns10
multipass exec sdx sudo ip link set ceth11 netns netns11
multipass exec sdx sudo ip link set ceth12 netns netns12
multipass exec sdx sudo ip link set ceth13 netns netns13
echo " ##### nsenter --net=/var/run/netns/netns10 ##### "
multipass exec sdx -- bash -c "sudo ip netns exec netns10 ip link set lo up"
multipass exec sdx -- bash -c "sudo ip netns exec netns10 ip link set ceth10 up"
multipass exec sdx -- bash -c "sudo ip netns exec netns10 ip addr add 192.168.10.10/28 dev ceth10"
multipass exec sdx -- bash -c "sudo ip netns exec netns10 ip route add default via 192.168.10.1"
echo " ##### nsenter --net=/var/run/netns/netns11 ##### "
multipass exec sdx -- bash -c "sudo ip netns exec netns11 ip link set lo up"
multipass exec sdx -- bash -c "sudo ip netns exec netns11 ip link set ceth11 up"
multipass exec sdx -- bash -c "sudo ip netns exec netns11 ip addr add 192.168.10.11/28 dev ceth11"
multipass exec sdx -- bash -c "sudo ip netns exec netns11 ip route add default via 192.168.10.1"
echo " ##### nsenter --net=/var/run/netns/netns12 ##### "
multipass exec sdx -- bash -c "sudo ip netns exec netns12 ip link set lo up"
multipass exec sdx -- bash -c "sudo ip netns exec netns12 ip link set ceth12 up"
multipass exec sdx -- bash -c "sudo ip netns exec netns12 ip addr add 192.168.10.12/28 dev ceth12"
multipass exec sdx -- bash -c "sudo ip netns exec netns12 ip route add default via 192.168.10.1"
echo " ##### nsenter --net=/var/run/netns/netns13 ##### "
multipass exec sdx -- bash -c "sudo ip netns exec netns13 ip link set lo up"
multipass exec sdx -- bash -c "sudo ip netns exec netns13 ip link set ceth13 up"
multipass exec sdx -- bash -c "sudo ip netns exec netns13 ip addr add 192.168.10.13/28 dev ceth13"
multipass exec sdx -- bash -c "sudo ip netns exec netns13 ip route add default via 192.168.10.1"
