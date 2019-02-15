#!/bin/bash

figlet MASTER

echo "[TASK 1] Start docker/kubelet"
systemctl start docker && systemctl enable docker
systemctl start kubelet && systemctl enable kubelet
sed -i 's/cgroup-driver=systemd/cgroup-driver=cgroupfs/g' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
systemctl daemon-reload
systemctl restart kubelet

echo 'export KUBECONFIG=/etc/kubernetes/admin.conf' >> ~/.bash_profile
source ~/.bash_profile

echo "[TASK 2] Start master"
kubeadm init --ignore-preflight-errors all --pod-network-cidr=10.244.0.0/16 --token-ttl 0

echo "[TASK 3] Install Flannel"
sysctl net.bridge.bridge-nf-call-iptables=1
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml


echo "[TASK 4] Display PODS"
kubectl get pods --all-namespaces


echo "[TASK 5] Install kubeconfig"
$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "[TASK 6] Install Dashboard"
kubectl apply -f kubernetes-dashboard.yaml
kubectl apply -f kubernetes-dashboard-rbac.yaml

echo "[TASK 7] Display All Services"
kubectl get services -n kube-system 



figlet NFS
yum -y install nfs-utils
systemctl enable nfs-server.service
systemctl start nfs-server.service
mkdir -p /mnt/storage
cat >>/etc/hosts<<EOF
/mnt/storage *(rw,sync,no_root_squash,no_subtree_check)
EOF
exportfs -a