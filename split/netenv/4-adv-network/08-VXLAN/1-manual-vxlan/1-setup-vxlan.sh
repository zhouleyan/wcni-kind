#!/bin/bash

set -v

cat <<EOF | sudo tee clab.yaml | clab deploy -t clab.yaml - 
name: vxlan
topology:
  nodes:
    linux1:
      kind: linux
      image: reg.kubegg.io/library/nettool
      exec:
      - ip a a 10.1.5.1/24 dev eth1
      - ip a a 172.12.1.10/24 dev eth2
      - ip l a vxlan0 type vxlan id 5 dstport 4789 remote 172.12.1.11 local 172.12.1.10 dev eth2
      - ip a a 10.1.5.0/32 dev vxlan0
      - ip l s vxlan0 up
      - ip r a 10.1.8.0/24 via 10.1.8.0 dev vxlan0 onlink

    linux2:
      kind: linux
      image: reg.kubegg.io/library/nettool
      exec:
      - ip a a 10.1.8.1/24 dev eth1
      - ip a a 172.12.1.11/24 dev eth2
      - ip l a vxlan0 type vxlan id 5 dstport 4789 remote 172.12.1.10 local 172.12.1.11 dev eth2
      - ip a a 10.1.8.0/32 dev vxlan0
      - ip l s vxlan0 up
      - ip r a 10.1.5.0/24 via 10.1.5.0 dev vxlan0 onlink

    server1:
      kind: linux
      image: reg.kubegg.io/library/nettool
      exec:
      - ip a a 10.1.5.10/24 dev net0
      - ip r replace default via 10.1.5.1

    server2:
      kind: linux
      image: reg.kubegg.io/library/nettool
      exec:
      - ip a a 10.1.8.10/24 dev net0
      - ip r replace default via 10.1.8.1

  links:
    - endpoints: ["linux1:eth1", "server1:net0"]
    - endpoints: ["linux2:eth1", "server2:net0"]
    - endpoints: ["linux1:eth2", "linux2:eth2"]

EOF

