#!/bin/sh
ifconfig
echo " ##### Delete netns10 ##### "
sudo ip netns delete netns10
sudo ip netns delete netns11
sudo ip netns delete netns12
sudo ip netns delete netns13
echo " ##### Add netns10 ##### "
sudo ip netns add netns10
sudo ip netns add netns11
sudo ip netns add netns12
sudo ip netns add netns13
echo " ##### Delete link ##### "
sudo ip link delete veth10
sudo ip link delete ceth10
sudo ip link delete veth11
sudo ip link delete ceth11
sudo ip link delete veth12
sudo ip link delete ceth12
sudo ip link delete veth13
sudo ip link delete ceth13
echo " ##### Add link ##### "
sudo ip link add veth10 type veth peer name ceth10
sudo ip link add veth11 type veth peer name ceth11
sudo ip link add veth12 type veth peer name ceth12
sudo ip link add veth13 type veth peer name ceth13
echo " ##### Set veth link ##### "
sudo ip link set veth10 up
sudo ip link set veth11 up
sudo ip link set veth12 up
sudo ip link set veth13 up
ip link
echo " ##### Set ceth link ##### "
sudo ip link set ceth10 netns netns10
sudo ip link set ceth11 netns netns11
sudo ip link set ceth12 netns netns12
sudo ip link set ceth13 netns netns13
echo " ##### IP Route ##### "
ip route
sudo ip link add br0 type bridge
sudo ip link set br0 up
sudo ip link set veth10 master br0
sudo ip link set veth11 master br0
sudo ip link set veth12 master br0
sudo ip link set veth13 master br0
ip route
echo " ##### netns10 ip link ##### "
sudo nsenter --net=/var/run/netns/netns10 ip link set lo up
sudo nsenter --net=/var/run/netns/netns10 ip link set ceth10 up
sudo nsenter --net=/var/run/netns/netns10 ip addr add 192.168.0.10/24 dev ceth10
sudo nsenter --net=/var/run/netns/netns10 ip link
echo " ##### netns11 ip link ##### "
sudo nsenter --net=/var/run/netns/netns11 ip link set lo up
sudo nsenter --net=/var/run/netns/netns11 ip link set ceth11 up
sudo nsenter --net=/var/run/netns/netns11 ip addr add 192.168.0.11/24 dev ceth11
sudo nsenter --net=/var/run/netns/netns11 ip link
echo " ##### netns12 ip link ##### "
sudo nsenter --net=/var/run/netns/netns12 ip link set lo up
sudo nsenter --net=/var/run/netns/netns12 ip link set ceth12 up
sudo nsenter --net=/var/run/netns/netns12 ip addr add 192.168.0.12/24 dev ceth12
sudo nsenter --net=/var/run/netns/netns12 ip link
echo " ##### netns13 ip link ##### "
sudo nsenter --net=/var/run/netns/netns13 ip link set lo up
sudo nsenter --net=/var/run/netns/netns13 ip link set ceth13 up
sudo nsenter --net=/var/run/netns/netns13 ip addr add 192.168.0.13/24 dev ceth13
sudo nsenter --net=/var/run/netns/netns13 ip link

ip link
