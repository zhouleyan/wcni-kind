#!/bin/bash
set -e

docker pull quay.io/cilium/cilium:v1.14.5
docker pull quay.io/cilium/certgen:v0.1.9
docker pull quay.io/cilium/hubble-relay:v1.14.5
docker pull quay.io/cilium/hubble-ui-backend:v0.12.1
docker pull quay.io/cilium/hubble-ui:v0.12.1
docker pull quay.io/cilium/cilium-envoy:v1.26.6-ad82c7c56e88989992fd25d8d67747de865c823b
docker pull quay.io/cilium/cilium-etcd-operator:v2.0.7
docker pull quay.io/cilium/operator:v1.14.5
docker pull quay.io/cilium/operator-generic:v1.14.5
docker pull quay.io/cilium/startup-script:62093c5c233ea914bfa26a10ba41f8780d9b737f
docker pull quay.io/cilium/clustermesh-apiserver:v1.14.5
docker pull quay.io/coreos/etcd:v3.5.4
docker pull quay.io/cilium/kvstoremesh:v1.14.5

docker tag quay.io/cilium/cilium:v1.14.5 reg.kubegg.io/cilium/cilium:v1.14.5
docker tag quay.io/cilium/certgen:v0.1.9 reg.kubegg.io/cilium/certgen:v0.1.9
docker tag quay.io/cilium/hubble-relay:v1.14.5 reg.kubegg.io/cilium/hubble-relay:v1.14.5
docker tag quay.io/cilium/hubble-ui-backend:v0.12.1 reg.kubegg.io/cilium/hubble-ui-backend:v0.12.1
docker tag quay.io/cilium/hubble-ui:v0.12.1 reg.kubegg.io/cilium/hubble-ui:v0.12.1
docker tag quay.io/cilium/cilium-envoy:v1.26.6-ad82c7c56e88989992fd25d8d67747de865c823b reg.kubegg.io/cilium/cilium-envoy:v1.26.6-ad82c7c56e88989992fd25d8d67747de865c823b
docker tag quay.io/cilium/cilium-etcd-operator:v2.0.7 reg.kubegg.io/cilium/cilium-etcd-operator:v2.0.7
docker tag quay.io/cilium/operator:v1.14.5 reg.kubegg.io/cilium/operator:v1.14.5
docker tag quay.io/cilium/operator-generic:v1.14.5 reg.kubegg.io/cilium/operator-generic:v1.14.5
docker tag quay.io/cilium/startup-script:62093c5c233ea914bfa26a10ba41f8780d9b737f reg.kubegg.io/cilium/startup-script:62093c5c233ea914bfa26a10ba41f8780d9b737f
docker tag quay.io/cilium/clustermesh-apiserver:v1.14.5 reg.kubegg.io/cilium/clustermesh-apiserver:v1.14.5
docker tag quay.io/coreos/etcd:v3.5.4 reg.kubegg.io/coreos/etcd:v3.5.4
docker tag quay.io/cilium/kvstoremesh:v1.14.5 reg.kubegg.io/cilium/kvstoremesh:v1.14.5

docker push reg.kubegg.io/cilium/cilium:v1.14.5
docker push reg.kubegg.io/cilium/certgen:v0.1.9
docker push reg.kubegg.io/cilium/hubble-relay:v1.14.5
docker push reg.kubegg.io/cilium/hubble-ui-backend:v0.12.1
docker push reg.kubegg.io/cilium/hubble-ui:v0.12.1
docker push reg.kubegg.io/cilium/cilium-envoy:v1.26.6-ad82c7c56e88989992fd25d8d67747de865c823b
docker push reg.kubegg.io/cilium/cilium-etcd-operator:v2.0.7
docker push reg.kubegg.io/cilium/operator:v1.14.5
docker push reg.kubegg.io/cilium/operator-generic:v1.14.5
docker push reg.kubegg.io/cilium/startup-script:62093c5c233ea914bfa26a10ba41f8780d9b737f
docker push reg.kubegg.io/cilium/clustermesh-apiserver:v1.14.5
docker push reg.kubegg.io/coreos/etcd:v3.5.4
docker push reg.kubegg.io/cilium/kvstoremesh:v1.14.5

