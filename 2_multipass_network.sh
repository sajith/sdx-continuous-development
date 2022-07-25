#!/bin/sh
multipass exec sdx ifconfig
echo " ##### Delete netns10 ##### "
multipass exec sdx sudo ip netns delete netns10
multipass exec sdx sudo ip netns delete netns11
multipass exec sdx sudo ip netns delete netns12
multipass exec sdx sudo ip netns delete netns13
echo " ##### Add netns10 ##### "
multipass exec sdx sudo ip netns add netns10
multipass exec sdx sudo ip netns add netns11
multipass exec sdx sudo ip netns add netns12
multipass exec sdx sudo ip netns add netns13
echo " ##### Delete link ##### "
multipass exec sdx sudo ip link delete veth10
multipass exec sdx sudo ip link delete ceth10
multipass exec sdx sudo ip link delete veth11
multipass exec sdx sudo ip link delete ceth11
multipass exec sdx sudo ip link delete veth12
multipass exec sdx sudo ip link delete ceth12
multipass exec sdx sudo ip link delete veth13
multipass exec sdx sudo ip link delete ceth13
echo " ##### Add link ##### "
multipass exec sdx -- bash -c "sudo ip link add veth10 type veth peer name ceth10"
multipass exec sdx -- bash -c "sudo ip link add veth11 type veth peer name ceth11"
multipass exec sdx -- bash -c "sudo ip link add veth12 type veth peer name ceth12"
multipass exec sdx -- bash -c "sudo ip link add veth13 type veth peer name ceth13"
echo " ##### Set veth link ##### "
multipass exec sdx sudo ip link set veth10 up
multipass exec sdx sudo ip link set veth11 up
multipass exec sdx sudo ip link set veth12 up
multipass exec sdx sudo ip link set veth13 up
multipass exec sdx ip link
echo " ##### Set ceth link ##### "
multipass exec sdx sudo ip link set ceth10 netns netns10
multipass exec sdx sudo ip link set ceth11 netns netns11
multipass exec sdx sudo ip link set ceth12 netns netns12
multipass exec sdx sudo ip link set ceth13 netns netns13
echo " ##### IP Route ##### "
multipass exec sdx ip route
multipass exec sdx sudo ip link add br0 type bridge
multipass exec sdx sudo ip link set br0 up
multipass exec sdx sudo ip link set veth10 master br0
multipass exec sdx sudo ip link set veth11 master br0
multipass exec sdx sudo ip link set veth12 master br0
multipass exec sdx sudo ip link set veth13 master br0
multipass exec sdx ip route
echo " ##### nsenter ##### "
echo "# ip link"
echo "# ip link set lo up && ip link set ceth10 up && ip addr add 192.168.0.10/24 dev ceth10"
echo "# exit"
multipass exec sdx -- bash -c "sudo nsenter --net=/var/run/netns/netns10"
echo "# ip link set lo up && ip link set ceth11 up && ip addr add 192.168.0.11/24 dev ceth11"
echo "# exit"
multipass exec sdx -- bash -c "sudo nsenter --net=/var/run/netns/netns11"
echo "# ip link set lo up && ip link set ceth12 up && ip addr add 192.168.0.12/24 dev ceth12"
echo "# exit"
multipass exec sdx -- bash -c "sudo nsenter --net=/var/run/netns/netns12"
echo "# ip link set lo up && ip link set ceth13 up && ip addr add 192.168.0.13/24 dev ceth13"
echo "# exit"
multipass exec sdx -- bash -c "sudo nsenter --net=/var/run/netns/netns13"

multipass exec sdx ip link
