# Termux Proot Linux Environment Setup

A secure, optimized Linux environment setup for Termux (Android) using proot-distro. Creates an isolated Linux container with automatic development environment configuration.

## 🚀 Key Features
- **Termux Optimization** (Removed MOTD, Safe Updates)
- **Linux Distribution Choice** (Ubuntu LTS or Debian Stable)
- **Automatic Environment Setup** ([Dotfiles](https://github.com/Madfury0/.dotfiles.git), Development Tools)
- **Secure Containment** (Proot Isolation, safe bashrc modification)
- **One-Click Login** (Persistent Environment Configuration)

## 📱 Prerequisites
1. Termux installed from [F-Droid](https://f-droid.org/en/packages/com.termux/)
2. Minimum 2GB storage free
3. Stable internet connection

## ⚙️ Installation

### Basic Setup
```bash
# 1. Download setup script
curl -O https://raw.githubusercontent.com/Madfury0/Termux-Setup/main/setup.sh

# 2. Make executable
chmod +x setup.sh

# 3. Run setup
./setup.sh
```

### First-Run Workflow
1. Select distribution (1 for Ubuntu, 2 for Debian)
2. Wait for base installation (5-15 minutes)
3. Environment auto-configures on first login
4. Development tools install automatically

## 🔄 Setup Process Breakdown

### 1. Termux Base Configuration
- Removes intrusive MOTD
- Updates all base packages
- Installs essential proot tools

### 2. Linux Distribution Options
| Choice | Distro    | Version   | Size    |
|--------|-----------|-----------|---------|
| 1      | Ubuntu    | 22.04 LTS | ~350MB  |
| 2      | Debian    | Bookworm  | ~250MB  |

### 3. Automatic Environment Setup
- Creates secure login script (`~/ubuntu-login.sh` or `~/debian-login.sh`)
- Safe .bashrc modification (auto-login only in fresh sessions)

## 🛡️ Security Features
- **Proot Containment**: Linux environment runs unprivileged
- **Session Isolation**: Original Termux environment remains untouched
- **Safe Updates**: Package updates verified through Termux repos
- **Clean .bashrc**: Modifications include safety checks

## 🔧 Post-Install Configuration
Access your Linux environment:
```bash
# Manual login
./ubuntu-login.sh # or debian-login.sh

# Automatic login (via Termux restart)
exit
# Reopen Termux
```

## 🚨 Troubleshooting

### Common Issues
1. **Installation Fails**:
   ```bash
   termux-change-repo # Select main mirror
   pkg clean
   ./setup-termux.sh
   ```

2. **Login Issues**:
   ```bash
   # Check installation
   proot-distro list
   # Reinstall if needed
   proot-distro remove <distro> && ./setup.sh
   ```

3. **First-Run Errors**:
   ```bash
   rm ~/."${distro}"_initialized
   ./setup.sh
   ```

## 🔄 Maintenance

### Remove Environment
```bash
# 1. Remove proot distro
proot-distro remove <distro>

# 2. Clean Termux
rm ~/*-login.sh
sed -i '/login.sh/d' ~/.bashrc
```

## ⚠️ Important Notes
- **Storage**: Linux environments are stored in `~/../usr/var/lib/proot-distro`
- **Backups**: Use `termux-setup-storage` to access Android storage
- **Performance**: Expect 60-80% of native Linux speed
- **Networking**: Port forwarding available via `termux-open-url`

## 🌟 Customization

### Change Default Distro
```bash
# Edit setup.sh
nano setup.sh
# Modify distribution section
```

---

**📜 License**: none
**⚠️ Warning**: Proot environments have limitations - not suitable for kernel-level development  
**💡 Tip**: Use Termux:Widget for quick environment access from Android home screen  
