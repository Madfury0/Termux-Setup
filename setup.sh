#!/bin/bash

# 1. Remove MOTD (Message of the Day)
rm -f /usr/etc/motd

# 2. Update Termux base
pkg update && pkg upgrade -y

# 3. Install essential Termux packages
pkg install proot-distro -y

# 4. Install Ubuntu (latest LTS version)
proot-distro install ubuntu

# 5. Create safe login script for Ubuntu
cat > $HOME/ubuntu-login.sh <<EOF
#!/bin/bash
echo "Welcome to Ubuntu in Termux"
proot-distro login ubuntu
EOF
chmod +x $HOME/ubuntu-login.sh

# 6. Modify .bashrc to run login script
touch $HOME/.bashrc
if ! grep -q "$HOME/ubuntu-login.sh" "$HOME/.bashrc"; then
    echo "$HOME/ubuntu-login.sh" >> "$HOME/.bashrc"
fi

# 7. Prevent login script from running more than once in the session
if [ -z "$LOGIN_SCRIPT_EXECUTED" ]; then
    export LOGIN_SCRIPT_EXECUTED=true
    $HOME/ubuntu-login.sh
fi

# 8. Inside the Ubuntu proot environment
# Update Ubuntu and install git
apt update && apt upgrade -y
apt install git -y

# Clone dotfiles repository
git clone https://github.com/Madfury0/.dotfiles.git
cd ~/.dotfiles/scripts

# 9. Modify setup.sh safely (remove sudo and root protection)
sed -i 's/sudo //g' ~/.dotfiles/scripts/setup.sh
sed -i '/# Prevent running as root/,/^fi$/d' ~/.dotfiles/scripts/setup.sh

# 10. Run setup
chmod +x ~/.dotfiles/scripts/setup.sh
./setup.sh