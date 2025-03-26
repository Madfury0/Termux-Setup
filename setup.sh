# 1. motd removal 
rm ../usr/etc/motd

# 2. Update Termux base
pkg update && pkg upgrade -y

# 3. Install essential Termux packages
pkg install proot-distro git -y

# 4. Install Ubuntu (latest LTS)
proot-distro install ubuntu

# 5. Create safe login script instead of .bashrc modification
cat > $HOME/ubuntu-login.sh <<EOF
#!/bin/bash
echo "Welcome to Ubuntu in Termux"
proot-distro login ubuntu
EOF
chmod +x $HOME/ubuntu-login.sh

# 6. Login to Ubuntu 
touch .bashrc
echo "./ubuntu-login.sh" >> .bashrc
./ubuntu-login.sh

# 7. --- Now inside Ubuntu proot environment --- 
# Clone dotfiles
apt update && apt upgrade -y
apt install git -y
git clone https://github.com/Madfury0/.dotfiles.git
cd ~/.dotfiles/scripts

# 11. Modify setup.sh safely
sed -i 's/sudo //g' ~/.dotfiles/scripts/setup.sh
sed -i '/# Prevent running as root/,/^fi$/d' setup.sh

# 12. Run setup
chmod +x setup.sh
./setup.sh