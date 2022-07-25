#!/bin/sh
echo " ##### nsenter --net=/var/run/netns/netns10 ##### "
multipass exec sdx -- bash -c "sudo ip netns exec netns10 ip link set lo up"
multipass exec sdx -- bash -c "sudo ip netns exec netns10 ip link set ceth10 up"
multipass exec sdx -- bash -c "sudo ip netns exec netns10 ip addr add 192.168.0.10/24 dev ceth10"
echo " ##### nsenter --net=/var/run/netns/netns11 ##### "
multipass exec sdx -- bash -c "sudo ip netns exec netns11 ip link set lo up"
multipass exec sdx -- bash -c "sudo ip netns exec netns11 ip link set ceth11 up"
multipass exec sdx -- bash -c "sudo ip netns exec netns11 ip addr add 192.168.0.11/24 dev ceth11"
echo " ##### nsenter --net=/var/run/netns/netns12 ##### "

multipass exec sdx -- bash -c "sudo ip netns exec netns12 ip link set lo up"
multipass exec sdx -- bash -c "sudo ip netns exec netns12 ip link set ceth12 up"
multipass exec sdx -- bash -c "sudo ip netns exec netns12 ip addr add 192.168.0.12/24 dev ceth12"
echo " ##### nsenter --net=/var/run/netns/netns13 ##### "
multipass exec sdx -- bash -c "sudo ip netns exec netns13 ip link set lo up"
multipass exec sdx -- bash -c "sudo ip netns exec netns13 ip link set ceth13 up"
multipass exec sdx -- bash -c "sudo ip netns exec netns13 ip addr add 192.168.0.13/24 dev ceth13"
multipass exec sdx ip link
