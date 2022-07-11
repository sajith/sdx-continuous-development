#!/bin/sh
multipass exec mininet ifconfig
echo " ##### Delete netns10 ##### "
multipass exec mininet sudo ip netns delete netns10
multipass exec mininet sudo ip netns delete netns11
multipass exec mininet sudo ip netns delete netns12
multipass exec mininet sudo ip netns delete netns13
echo " ##### Add netns10 ##### "
multipass exec mininet sudo ip netns add netns10
multipass exec mininet sudo ip netns add netns11
multipass exec mininet sudo ip netns add netns12
multipass exec mininet sudo ip netns add netns13
echo " ##### Delete link ##### "
multipass exec mininet sudo ip link delete veth10
multipass exec mininet sudo ip link delete ceth10
multipass exec mininet sudo ip link delete veth11
multipass exec mininet sudo ip link delete ceth11
multipass exec mininet sudo ip link delete veth12
multipass exec mininet sudo ip link delete ceth12
multipass exec mininet sudo ip link delete veth13
multipass exec mininet sudo ip link delete ceth13
echo " ##### Add link ##### "
multipass exec mininet -- bash -c "sudo ip link add veth10 type veth peer name ceth10"
multipass exec mininet -- bash -c "sudo ip link add veth11 type veth peer name ceth11"
multipass exec mininet -- bash -c "sudo ip link add veth12 type veth peer name ceth12"
multipass exec mininet -- bash -c "sudo ip link add veth13 type veth peer name ceth13"
echo " ##### Set veth link ##### "
multipass exec mininet sudo ip link set veth10 up
multipass exec mininet sudo ip link set veth11 up
multipass exec mininet sudo ip link set veth12 up
multipass exec mininet sudo ip link set veth13 up
multipass exec mininet ip link
echo " ##### Set ceth link ##### "
multipass exec mininet sudo ip link set ceth10 netns netns10
multipass exec mininet sudo ip link set ceth11 netns netns11
multipass exec mininet sudo ip link set ceth12 netns netns12
multipass exec mininet sudo ip link set ceth13 netns netns13
echo " ##### nsenter ##### "
multipass exec mininet -- bash -c "sudo nsenter --net=/var/run/netns/netns10"
# ip link set lo up && ip link set ceth10 up && ip addr add 192.168.0.10/24 dev ceth10
multipass exec mininet -- bash -c "sudo nsenter --net=/var/run/netns/netns11"
# ip link set lo up && ip link set ceth11 up && ip addr add 192.168.0.11/24 dev ceth11
multipass exec mininet -- bash -c "sudo nsenter --net=/var/run/netns/netns12"
# ip link set lo up && ip link set ceth12 up && ip addr add 192.168.0.12/24 dev ceth12
multipass exec mininet -- bash -c "sudo nsenter --net=/var/run/netns/netns13"
# ip link set lo up && ip link set ceth13 up && ip addr add 192.168.0.13/24 dev ceth13

multipass exec mininet ip link
