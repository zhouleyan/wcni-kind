#!/bin/bash
set -v

cat << EOF | sudo tee clab.yaml | clab deploy -t clab.yaml - 
name: vxlan
topology:
  nodes:
    gw0:
      kind: linux
      image: reg.kubegg.io/library/vyos:1.4.7
      cmd: /sbin/init
      binds:
        - /lib/modules:/lib/modules
        - ./startup-conf/gw0.cfg:/opt/vyatta/etc/config/config.boot
    
    gw1:
      kind: linux
      image: reg.kubegg.io/library/vyos:1.4.7
      cmd: /sbin/init
      binds:
        - /lib/modules:/lib/modules
        - ./startup-conf/gw1.cfg:/opt/vyatta/etc/config/config.boot

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
    - endpoints: ["gw0:eth1", "server1:net0"]
    - endpoints: ["gw1:eth1", "server2:net0"]
    - endpoints: ["gw0:eth2", "gw1:eth2"]

EOF
