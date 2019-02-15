#!/bin/bash

figlet WORKER

echo "[TASK 1] Start docker/kubelet"
systemctl start docker && systemctl enable docker
systemctl start kubelet && systemctl enable kubelet
sed -i 's/cgroup-driver=systemd/cgroup-driver=cgroupfs/g' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
systemctl daemon-reload
systemctl restart kubelet

echo "[TASK 2] Join master"
#Update the join token by executing the command on master node
#kubeadm token create --print-join-command
kubeadm join !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!