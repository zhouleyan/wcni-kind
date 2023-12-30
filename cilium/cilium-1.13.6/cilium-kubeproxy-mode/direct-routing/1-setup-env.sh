#!/bin/bash
date
set -e
set -v

# 1.prep noCNI env
cat <<EOF | kind create cluster \
--name=cilium-kubeproxy \
--image=reg.kubegg.io/library/node:v1.27.3 \
--config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  apiServerAddress: "10.1.1.10"
  apiServerPort: 16443
  disableDefaultCNI: true
  #kubeProxyMode: "none" # Enable KubeProxy
nodes:
- role: control-plane
- role: worker
- role: worker

containerdConfigPatches:
- |-
  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."reg.kubegg.io"]
    endpoint = ["http://reg.kubegg.io"]

  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."10.1.1.10"]
    endpoint = ["http://10.1.1.10"]

  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."docker.io"]
    endpoint = ["https://docker.nju.edu.cn/", "https://kuamavit.mirror.aliyuncs.com"]

  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."gcr.io"]
    endpoint = ["https://gcr.nju.edu.cn"]

  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."k8s.gcr.io"]
    endpoint = ["https://gcr.nju.edu.cn/google-containers/"]

  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."quay.io"]
    endpoint = ["https://quay.nju.edu.cn"]

  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."ghcr.io"]
    endpoint = ["https://ghcr.nju.edu.cn"]

  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."nvcr.io"]
    endpoint = ["https://ngc.nju.edu.cn"]
EOF

# 2.remove taints
controller_node_ip=`kubectl get node -o wide --no-headers | grep -E "control-plane|bpf1" | awk -F " " '{print $6}'`
controller_node=`kubectl get nodes --no-headers  -o custom-columns=NAME:.metadata.name| grep control-plane`
kubectl taint nodes $controller_node node-role.kubernetes.io/control-plane:NoSchedule-
kubectl get nodes -o wide

# 3.change hosts
for i in $(docker ps -a --format "table {{.Names}}" | grep cilium-kubeproxy)
do
  echo $i
  docker exec -it $i bash -c "echo 10.1.1.10 reg.kubegg.io >> /etc/hosts"
done

# 4.install cilium
helm upgrade cilium --install \
--namespace kube-system \
-f /root/kind/cilium/cilium-1.13.6/cilium-values.yaml \
/root/kind/cilium/cilium-1.13.6/cilium-1.13.6.tgz

