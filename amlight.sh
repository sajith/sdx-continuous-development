#!/bin/sh
multipass exec sdx -- bash -c "sudo ip netns exec netns10 python3 -m http.server --bind 192.168.10.10 5000"
