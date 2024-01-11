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
# Direct Routing Options(--set kubeproxyReplacement=true --set tunnel=disabled --set autoDirectNodeRoutes=true --set ipv4NativeRoutingCIDR="10.0.0.0/8")
# Host Routing[EBPF](--set bpf.masquerade=true)
helm upgrade cilium --install \
--set k8sServiceHost=$controller_node_ip \
--set k8sServicePort=6443 \
--namespace kube-system \
--set debug.enabled=true \
--set debug.verbose=datapath \
--set monitorAggregation=none \
--set hubble.tls.enabled=false \
--set hubble.relay.enabled=true \
--set hubble.relay.tls.server.enabled=false \
--set ipam.mode=cluster-pool \
--set cluster.name=cilium-kubeproxy-replacement-ebpf \
--set kubeProxyReplacement=true \
--set tunnel=disabled \
--set routingMode=native \
--set autoDirectNodeRoutes=true \
--set ipv4NativeRoutingCIDR="10.0.0.0/8" \
--set bpf.masquerade=true \
-f ../../cilium-values.yaml \
../../cilium-1.14.5.tgz

