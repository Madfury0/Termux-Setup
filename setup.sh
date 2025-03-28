#!/bin/bash

# 1. Remove MOTD
[ -f "/usr/etc/motd" ] && rm /usr/etc/motd

# 2. Update Termux base
pkg update -y && pkg upgrade -y

# 3. Install essential Termux packages
pkg install -y proot-distro git

# 4. Distribution selection
echo "Select Linux distribution:"
echo "1) Ubuntu (LTS)"
echo "2) Debian (stable)"
read -p "Enter choice (1/2): " distro_choice

case $distro_choice in
    1) 
        distro="ubuntu"
        echo "Installing Ubuntu..."
        ;;
    2) 
        distro="debian"
        echo "Installing Debian..."
        ;;
    *)
        echo "Invalid choice! Exiting."
        exit 1
        ;;
esac

# 5. Install selected distribution
proot-distro install $distro

# 6. Create safe login script
login_script="$HOME/${distro}-login.sh"
cat > "$login_script" <<EOF
#!/bin/bash
clear
echo "Welcome to ${distro^} in Termux"
proot-distro login $distro
EOF
chmod +x "$login_script"

# 7. Safer .bashrc modification
if ! grep -q "${distro}-login.sh" "$HOME/.bashrc"; then
    echo "[ -z \\\$PROOT_ENV ] && source ${distro}-login.sh" >> "$HOME/.bashrc"
fi

# 8. First-run execution (safe version)
if [ ! -f "$HOME/.${distro}_initialized" ]; then
    touch "$HOME/.${distro}_initialized"
    "$login_script" <<'INNER_EOF'
        # Commands to run INSIDE proot
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