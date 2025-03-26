# Removing motd
rm ../usr/etc/motd
# Update and upgrade 
apt update && apt upgrade -y
# Install proot-distro
apt install proot-distro -y
# install Ubuntu
proot-distro install ubuntu 
# create .bashrc file
touch .bashrc
# add Ubuntu login
echo "Welcome to Ubuntu" >> .bashrc
echo "proot-distro login ubuntu" >> .bashrc
# Login to Ubuntu 
proot-distro login ubuntu
# ran . dotfiles GitHub repo installation guide
apt update && apt upgrade -y
apt install git -y
git clone https://github.com/Madfury0/.dotfiles.git
cd ~/.dotfiles/scripts
chmod +x setup.sh
echo "On Ubuntu proot distro, edit setup.sh and remove the first root check and <sudo> "
