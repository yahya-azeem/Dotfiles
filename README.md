# 🌑 Monochrome AI-Managed Dotfiles

### *Utmost Perfection. Absolute Efficiency. Strictly Monochrome.*

This project is a high-performance, AI-managed workstation configuration built on top of the **ML4W** (My Linux for Work) Hyprland ecosystem. It is designed for developers, security researchers, and "vibecoders" who demand a zero-distraction, monochrome aesthetic coupled with advanced agentic automation.

---

## 🚀 Quick Installation

Deploy the entire workstation configuration (including themes, scripts, and Nix environments) with a single command:

```bash
git clone https://github.com/mylinuxforwork/dotfiles.git ~/dotfiles-custom
cd ~/dotfiles-custom
chmod +x install.sh
./install.sh
```

---

## ✨ Core Features

### 🎨 Strict Monochrome Aesthetics
- **Hyprland**: Sharp 5ms animations, zero-vibrancy blur, and white-to-gray active borders.
- **Alacritty**: High-contrast black/white theme using Iosevka Nerd Font.
- **Waybar**: Custom monochrome theme integrated directly into the ML4W theme switcher.

### 🤖 AI-Managed Workflow
- **AI Agent Sessions (`Ctrl+Shift+A`)**: Instant access to a technical execution environment with pre-configured AI prompts.
- **Manual Nix Shell (`Ctrl+Shift+I`)**: Enter a reproducible environment loaded with dev, security, and debugging tools.
- **Automated Health Checks**: Daily systemd-driven audits that monitor service status, disk health, and kernel errors with auto-remediation.

### 🛡️ Resilience & Security
- **Immutable Protection**: Scripts to "lock" critical configuration files (`chattr +i`) to prevent accidental or malicious changes.
- **Automated Backups**: Integrated Borg/Vorta backup verification and rclone-backed cloud synchronization.
- **Nix Backend**: All technical tooling is managed via Nix to keep the host system clean and stable.

---

## 🛠️ Included Components

| Component | Description | Keybinding |
| :--- | :--- | :--- |
| **Hyprland** | Window Manager (ML4W Base) | `Super` + ... |
| **AI Agent** | Specialized Execution Session | `Ctrl+Shift+A` |
| **Nix Shell** | Technical Tooling Stack | `Ctrl+Shift+I` |
| **Browser** | Quick Web Access | `Ctrl+Shift+Return` |
| **Health Check** | Daily System Audit | *Automated (Systemd)* |

---

## 📂 Repository Structure

- `dotfiles/.config/`: Core configurations (Hyprland, Waybar, Alacritty, etc.).
- `scripts/`: The brain of the system (AI launcher, protection, health checks).
- `nix/`: Reproducible environment definitions.
- `systemd/`: Automation timers and service units.
- `wallpaper/`: Curated monochrome backgrounds.

---

## ⚖️ Credits & Inspirations

- Based on the excellent [ML4W Dotfiles](https://github.com/mylinuxforwork/dotfiles).
- Aesthetics inspired by high-end technical workstations and monochrome minimalism.

---

*“Simplicity is the ultimate sophistication.”* 🌑
