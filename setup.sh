#!/bin/bash

# 1. Remove MOTD
[ -f "/usr/etc/motd" ] && rm /usr/etc/motd

# 2. Update Termux base
pkg update -y && pkg upgrade -y

# 3. Install essential Termux packages
pkg install -y proot-distro git

# 4. Install Ubuntu (latest LTS version)
proot-distro install ubuntu

# 5. Create safe login script for Ubuntu
cat > "$HOME/ubuntu-login.sh" <<'EOF'
#!/bin/bash
clear
echo "Welcome to Ubuntu in Termux"
proot-distro login ubuntu
EOF
chmod +x "$HOME/ubuntu-login.sh"

# 6. Safer .bashrc modification
if ! grep -q "ubuntu-login.sh" "$HOME/.bashrc"; then
    echo "[ -z \$PROOT_ENV ] && source $HOME/ubuntu-login.sh" >> "$HOME/.bashrc"
fi

# 7. First-run execution (safe version)
if [ ! -f "$HOME/.ubuntu_initialized" ]; then
    touch "$HOME/.ubuntu_initialized"
    "$HOME/ubuntu-login.sh" <<'INNER_EOF'
        # Commands to run INSIDE Ubuntu proot
        apt update -y && apt upgrade -y
        apt install -y git
        git clone https://github.com/Madfury0/.dotfiles.git
        cd .dotfiles/scripts
        
        # Modify setup.sh safely
        sed -i 's/sudo //g' setup.sh
        sed -i '/# Prevent running as root/,/^fi$/d' setup.sh
        
        # Run setup
        chmod +x setup.sh
        ./setup.sh
INNER_EOF
fi