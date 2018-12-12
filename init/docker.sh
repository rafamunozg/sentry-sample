# The following steps were taken from the official docs. 
# https://docs.docker.com/install/linux/docker-ce/ubuntu/#set-up-the-repository
# It should end up with a running docker service

sudo apt-get update -y
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update -y
sudo apt-get install docker-ce -y
#usermod -aG docker $USER
sudo gpasswd -a $USER docker
docker --version
