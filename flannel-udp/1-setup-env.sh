#!/bin/bash
date
set -e
set -v

# 1.prep noCNI env
cat <<EOF | kind create cluster --name=flannel-udp --image=reg.kubegg.io/library/node:v1.27.3 --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  disableDefaultCNI: true
  podSubnet: "10.244.0.0/16"
nodes:
- role: control-plane
- role: worker
- role: worker

containerdConfigPatches:
- |-
  [plugins."io.containerd.grpc.v1.cri".registry.configs."reg.kubegg.io".tls]
      insecure_skip_verify = true

  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."reg.kubegg.io"]
    endpoint = ["https://reg.kubegg.io"]

  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."172.16.0.120"]
    endpoint = ["https://172.16.0.120"]

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
controller_node=`kubectl get nodes --no-headers  -o custom-columns=NAME:.metadata.name| grep control-plane`
kubectl taint nodes $controller_node node-role.kubernetes.io/control-plane:NoSchedule-
kubectl get nodes -o wide

# 3.change hosts
for i in $(docker ps -a --format "table {{.Names}}" | grep flannel-udp)
do
  echo $i
  docker exec -it $i bash -c "echo 172.16.0.120 reg.kubegg.io >> /etc/hosts"
done

# 4.install CNI
kubectl apply -f ./flannel.yaml

