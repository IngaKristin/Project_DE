sudo swapoff -a
sudo sed -i "/ swap / s/^\(.*\)$/#\1/g" /etc/fstab
sudo sysctl --system
# Install containerrd run time
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# Run to install containerd
sudo apt update
sudo apt install -y containerd.io
# Configure containerd so that it starts using systemd as cgroup.
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
# Restart and enable containerd service
sudo systemctl restart containerd
sudo systemctl enable containerd

# Execute following commands to add apt repository for Kubernetes
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

# Install kubernetes
sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

