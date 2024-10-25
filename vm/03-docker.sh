#**************************************
#Install Docker
#**************************************
sudo apt-get update

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
rm -rf get-docker.sh

sudo usermod -aG docker $(whoami)
#**************************************
