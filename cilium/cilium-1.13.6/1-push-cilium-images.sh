#!/bin/bash
set -e

docker pull quay.io/cilium/cilium:v1.13.6
docker pull quay.io/cilium/certgen:v0.1.8@sha256:4a456552a5f192992a6edcec2febb1c54870d665173a33dc7d876129b199ddbd
docker pull quay.io/cilium/hubble-relay:v1.13.6
docker pull quay.io/cilium/hubble-ui-backend:v0.11.0
docker pull quay.io/cilium/hubble-ui:v0.11.0
docker pull quay.io/cilium/cilium-envoy:v1.26.6-ad82c7c56e88989992fd25d8d67747de865c823b
docker pull quay.io/cilium/cilium-etcd-operator:v2.0.7@sha256:04b8327f7f992693c2cb483b999041ed8f92efc8e14f2a5f3ab95574a65ea2dc
docker pull quay.io/cilium/operator:v1.13.6
docker pull quay.io/cilium/operator-generic:v1.13.6
docker pull quay.io/cilium/startup-script:62093c5c233ea914bfa26a10ba41f8780d9b737f
docker pull quay.io/cilium/clustermesh-apiserver:v1.13.6
docker pull quay.io/coreos/etcd:v3.5.4@sha256:795d8660c48c439a7c3764c2330ed9222ab5db5bb524d8d0607cac76f7ba82a3

docker tag quay.io/cilium/cilium:v1.13.6 reg.kubegg.io/cilium/cilium:v1.13.6
docker tag quay.io/cilium/certgen:v0.1.8@sha256:4a456552a5f192992a6edcec2febb1c54870d665173a33dc7d876129b199ddbd reg.kubegg.io/cilium/certgen:v0.1.8@sha256:4a456552a5f192992a6edcec2febb1c54870d665173a33dc7d876129b199ddbd
docker tag quay.io/cilium/hubble-relay:v1.13.6 reg.kubegg.io/cilium/hubble-relay:v1.13.6
docker tag quay.io/cilium/hubble-ui-backend:v0.11.0 reg.kubegg.io/cilium/hubble-ui-backend:v0.11.0
docker tag quay.io/cilium/hubble-ui:v0.11.0 reg.kubegg.io/cilium/hubble-ui:v0.11.0
docker tag quay.io/cilium/cilium-envoy:v1.26.6-ad82c7c56e88989992fd25d8d67747de865c823b reg.kubegg.io/cilium/cilium-envoy:v1.26.6-ad82c7c56e88989992fd25d8d67747de865c823b
docker tag quay.io/cilium/cilium-etcd-operator:v2.0.7@sha256:04b8327f7f992693c2cb483b999041ed8f92efc8e14f2a5f3ab95574a65ea2dc reg.kubegg.io/cilium/cilium-etcd-operator:v2.0.7@sha256:04b8327f7f992693c2cb483b999041ed8f92efc8e14f2a5f3ab95574a65ea2dc
docker tag quay.io/cilium/operator:v1.13.6 reg.kubegg.io/cilium/operator:v1.13.6
docker tag quay.io/cilium/operator-generic:v1.13.6 reg.kubegg.io/cilium/operator-generic:v1.13.6
docker tag quay.io/cilium/startup-script:62093c5c233ea914bfa26a10ba41f8780d9b737f reg.kubegg.io/cilium/startup-script:62093c5c233ea914bfa26a10ba41f8780d9b737f
docker tag quay.io/cilium/clustermesh-apiserver:v1.13.6 reg.kubegg.io/cilium/clustermesh-apiserver:v1.13.6
docker tag quay.io/coreos/etcd:v3.5.4@sha256:795d8660c48c439a7c3764c2330ed9222ab5db5bb524d8d0607cac76f7ba82a3 reg.kubegg.io/coreos/etcd:v3.5.4@sha256:795d8660c48c439a7c3764c2330ed9222ab5db5bb524d8d0607cac76f7ba82a3

docker push reg.kubegg.io/cilium/cilium:v1.13.6
docker push reg.kubegg.io/cilium/certgen:v0.1.8@sha256:4a456552a5f192992a6edcec2febb1c54870d665173a33dc7d876129b199ddbd
docker push reg.kubegg.io/cilium/hubble-relay:v1.13.6
docker push reg.kubegg.io/cilium/hubble-ui-backend:v0.11.0
docker push reg.kubegg.io/cilium/hubble-ui:v0.11.0
docker push reg.kubegg.io/cilium/cilium-envoy:v1.26.6-ad82c7c56e88989992fd25d8d67747de865c823b
docker push reg.kubegg.io/cilium/cilium-etcd-operator:v2.0.7@sha256:04b8327f7f992693c2cb483b999041ed8f92efc8e14f2a5f3ab95574a65ea2dc
docker push reg.kubegg.io/cilium/operator:v1.13.6
docker push reg.kubegg.io/cilium/operator-generic:v1.13.6
docker push reg.kubegg.io/cilium/startup-script:62093c5c233ea914bfa26a10ba41f8780d9b737f
docker push reg.kubegg.io/cilium/clustermesh-apiserver:v1.13.6
docker push reg.kubegg.io/coreos/etcd:v3.5.4@sha256:795d8660c48c439a7c3764c2330ed9222ab5db5bb524d8d0607cac76f7ba82a3

