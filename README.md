# hyprland-nvim-config

Welcome, traveler! This repository is your compass to harness the elegance of Arch and the power of Hyprland, all while boosting your productivity with Neovim.

> **⚠️ Note:** This guide assumes UEFI firmware. Please verify your hardware firmware type beforehand to avoid hiccups.

---

## 📖 Table of Contents

1. [Guides](#guides)
2. [Directory Structure](#directory-structure)
3. [Fonts](#fonts)
4. [Virtualization](#virtualization)
5. [Helper Scripts](#helper-scripts)
6. [Power Management](#power-management)

---

## 📚 Guides

* **`howToBuildArchHyper.md`**
  The main walkthrough to install Arch Linux and configure Hyprland.

* **`Install and Setup QEMU.md`**
  Step-by-step to install and run QEMU on Arch Linux.

* **`virtualbox-configuration.md`**
  Configuration tips for VirtualBox and how to disable services by default for power savings.

## 📂 Directory Structure

```text
├── howToBuildArchHyper.md          # Arch + Hyprland installation guide
├── Install and Setup QEMU.md       # QEMU setup on Arch Linux
├── virtualbox-configuration.md    # VirtualBox power-efficient setup
├── nvim/                           # Neovim config (→ ~/.config/nvim)
├── kitty/                          # Kitty terminal config (→ ~/.config/kitty)
├── hypr/                           # Hyprland configs for a tailored desktop
├── fonts/                          # .ttf files (Comic Mono, Consolas)
├── copyfile.sh                     # Utility to sync config files
├── qemu.sh                         # Toggle QEMU services on/off
└── vbox start-stop.sh              # VirtualBox service toggle scripts
```

## 🖋️ Fonts

* **Comic Mono** for your terminal
* **Consolas** for VS Code

Simply drop the `.ttf` files into your system fonts folder or install via your preferred font manager.

## 🖥️ Virtualization

* **QEMU:** Follow **`Install and Setup QEMU.md`** to get up and running.
* **VirtualBox:** Use **`virtualbox-configuration.md`** to optimize performance and power usage.

## 🛠️ Helper Scripts

* **copyfile.sh** — Quickly symlink or copy your dotfiles into this repo.
* **qemu.sh** — Enable/disable QEMU services on demand.
* **vbox start-stop.sh** — Start or stop VirtualBox services easily.

## 🔋 Power Management

Always disable unnecessary background services to conserve battery life. Use the provided scripts to **enable services temporarily** only when needed.

---

Happy customizing! 🚀
