To install and set up QEMU with KVM on Arch Linux, follow these steps to enable virtualization, install necessary packages, configure services, and manage virtual machines using `virt-manager`.([Wikipedia][1])

---

## ✅ Step 1: Verify Virtualization Support

Ensure your CPU supports virtualization:

```bash
lscpu | grep -i virtualization
```



You should see `VT-x` (Intel) or `AMD-V` (AMD).([Gist][2])

Check if the KVM modules are available:([Gist][2])

```bash
zgrep CONFIG_KVM /proc/config.gz
```



Look for `CONFIG_KVM=y` or `CONFIG_KVM=m`.

---

## 📦 Step 2: Install QEMU, KVM, and Management Tools

Update your system and install the required packages:([christitus.com][3])

```bash
sudo pacman -Syu
sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ebtables iptables libguestfs edk2-ovmf swtpm libosinfo tuned
```



These packages provide:

* `qemu` – the emulator
* `virt-manager` – GUI for managing virtual machines
* `virt-viewer` – viewer for virtual machine displays
* `dnsmasq`, `vde2`, `bridge-utils`, `openbsd-netcat`, `ebtables`, `iptables` – networking tools
* `libguestfs` – tools for accessing and modifying virtual machine disk images
* `edk2-ovmf` – UEFI firmware for virtual machines
* `swtpm` – TPM emulator
* `libosinfo` – library for managing operating system information
* `tuned` – system tuning daemon([Wikipedia][4], [Gist][5], [Gist][2], [christitus.com][3])

---

## 🔧 Step 3: Enable and Start libvirt

Enable and start the `libvirtd` service:([Gist][5])

```bash
sudo systemctl enable --now libvirtd.service
```



Check the status to ensure it's running:

```bash
sudo systemctl status libvirtd.service
```



---

## 👤 Step 4: Configure User Permissions

Add your user to the `libvirt` group to manage virtual machines without root privileges:([christitus.com][3])

```bash
sudo usermod -aG libvirt $(whoami)
newgrp libvirt
```



Edit the libvirt configuration to set appropriate socket permissions:

```bash
sudo nano /etc/libvirt/libvirtd.conf
```



Uncomment and set the following lines:

```ini
unix_sock_group = "libvirt"
unix_sock_rw_perms = "0770"
```



Restart the `libvirtd` service to apply changes:([Gist][2])

```bash
sudo systemctl restart libvirtd.service
```



---

## 🧪 Step 5: Validate Host Virtualization Setup

Run the following command to validate your virtualization setup:

```bash
sudo virt-host-validate
```



Address any warnings or errors as necessary.

---

## 🖥️ Step 6: Launch virt-manager

Start `virt-manager` to create and manage virtual machines:([TauCeti blog][6])

```bash
virt-manager
```



Use the GUI to create new virtual machines, configure hardware settings, and manage snapshots.

---

## 💡 Optional: Enable Nested Virtualization

If you plan to run virtual machines inside virtual machines (nested virtualization), enable it as follows:([Gist][2])

**For Intel CPUs:**

```bash
sudo modprobe -r kvm_intel
sudo modprobe kvm_intel nested=1
echo "options kvm_intel nested=1" | sudo tee /etc/modprobe.d/kvm-intel.conf
```



**For AMD CPUs:**

```bash
sudo modprobe -r kvm_amd
sudo modprobe kvm_amd nested=1
echo "options kvm_amd nested=1" | sudo tee /etc/modprobe.d/kvm-amd.conf
```



Reboot your system to apply the changes.([Gist][2])

---

For more detailed information, refer to the ArchWiki on QEMU: ([ArchWiki][7])

If you need assistance with creating specific virtual machines or configuring advanced settings, feel free to ask!

[1]: https://en.wikipedia.org/wiki/Virt-manager?utm_source=chatgpt.com "Virt-manager"
[2]: https://gist.github.com/tatumroaquin/c6464e1ccaef40fd098a4f31db61ab22?utm_source=chatgpt.com "QEMU-KVM Installation for Arch Linux - GitHub Gist"
[3]: https://christitus.com/setup-qemu-in-archlinux/?utm_source=chatgpt.com "Setup Qemu in Arch Linux - Chris Titus Tech"
[4]: https://en.wikipedia.org/wiki/QEMU?utm_source=chatgpt.com "QEMU"
[5]: https://gist.github.com/lordofwizard/35e39955d70da70ddb4af4ca02afcd98?utm_source=chatgpt.com "Installing QEMU + KVM on Arch.md - GitHub Gist"
[6]: https://www.tauceti.blog/posts/virtualization-with-archlinux-qemu-kvm-part-4/?utm_source=chatgpt.com "Virtualization with Arch Linux and Qemu/KVM - part 4 - TauCeti blog"
[7]: https://wiki.archlinux.org/title/QEMU?utm_source=chatgpt.com "QEMU - ArchWiki"
