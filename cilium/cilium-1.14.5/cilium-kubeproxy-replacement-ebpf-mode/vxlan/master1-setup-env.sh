#!/bin/bash
date
set -e
set -v

# 1.remove taints
controller_node_ip=`kubectl get node -o wide --no-headers | grep -E "control-plane|bpf1" | awk -F " " '{print $6}'`
controller_node=`kubectl get nodes --no-headers  -o custom-columns=NAME:.metadata.name| grep master1`
# kubectl taint nodes $controller_node node-role.kubernetes.io/control-plane:NoSchedule-
kubectl get nodes -o wide

# 2.install cilium
# VXLAN Options.
# (--set kubeProxyReplacement=true --set bpf.masquerade=true --set routingMode=tunnel --set tunnelProtocol=vxlan)
helm upgrade cilium --install \
--set k8sServiceHost=$controller_node_ip \
--set k8sServicePort=6443 \
--namespace kube-system \
--set debug.enabled=true \
--set debug.verbose=datapath \
--set monitorAggregation=none \
--set hubble.relay.enabled=true \
--set hubble.ui.enabled=true \
--set ipam.mode=cluster-pool \
--set cluster.name=cilium-kubeproxy-replacement-ebpf-vxlan \
--set kubeProxyReplacement=true \
--set tunnelProtocol=vxlan \
--set routingMode=tunnel \
--set bpf.masquerade=true \
-f ../../cilium-values.yaml \
../../cilium-1.14.5.tgz
