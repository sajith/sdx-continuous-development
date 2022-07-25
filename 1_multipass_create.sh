#!/bin/sh
multipass launch 20.04 --name sdx -d 20G -m 8192M -c 2
multipass set client.primary-name=sdx
multipass list
multipass info sdx
echo "### Ubuntu Update ###"
multipass exec sdx sudo apt-get update
multipass exec sdx sudo apt-get upgrade
echo "### mininet install ###"
multipass exec sdx sudo apt install net-tools
multipass exec sdx sudo apt-get install mininet
multipass exec sdx -- bash -c "sudo mn --version"
multipass exec sdx -- bash -c "sudo mn --switch ovsbr --test pingall"
multipass exec sdx -- bash -c "echo 'deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /' | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
multipass exec sdx -- bash -c "curl -L 'https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key' | sudo apt-key add -"
echo "### Network config ###"
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
