<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

## Install and Set Up QEMU on Arch Linux

Follow these steps to install and configure QEMU and related virtualization tools on Arch Linux:

---

**1. Update Your System**

```bash
sudo pacman -Syu
```

Keeping your system up to date ensures compatibility with the latest virtualization packages[^5][^6][^7].

---

**2. Check CPU Virtualization Support**

Verify that your CPU supports hardware virtualization:

```bash
lscpu | grep -i virtualization
```

Look for `VT-x` (Intel) or `AMD-V` (AMD). If nothing appears, you may need to enable virtualization in your BIOS/UEFI[^2][^4].

---

**3. Ensure Kernel KVM Module Support**

Check if your kernel includes KVM modules:

```bash
zgrep CONFIG_KVM /proc/config.gz
```

A result with `y` or `m` means KVM support is present[^2][^4].

---

**4. Install QEMU, KVM, Libvirt, and Tools**

Install all necessary packages for virtualization:

```bash
sudo pacman -S qemu-full qemu-img libvirt virt-install virt-manager virt-viewer edk2-ovmf swtpm guestfs-tools libosinfo dnsmasq vde2 bridge-utils openbsd-netcat ebtables iptables
```

These packages provide QEMU, KVM, graphical and command-line VM management, UEFI support, networking, and more[^4][^5][^6][^7].

---

**5. Enable and Start Libvirt Daemon**

Libvirt manages your virtual machines:

```bash
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
```

Check status with:

```bash
sudo systemctl status libvirtd.service
```


---

**6. Add Your User to the libvirt Group**

This allows you to manage VMs without root privileges:

```bash
sudo usermod -aG libvirt $(whoami)
newgrp libvirt
```


---

**7. (Optional) Set Permissions for VM Images Directory**

If you encounter permission issues with VM images:

```bash
sudo setfacl -R -m "u:$(whoami):rwX" /var/lib/libvirt/images/
sudo setfacl -m "d:u:$(whoami):rwx" /var/lib/libvirt/images/
```


---

**8. (Optional) Edit Libvirt Configuration for Group Access**

Edit `/etc/libvirt/libvirtd.conf` and set:

```
unix_sock_group = "libvirt"
unix_sock_rw_perms = "0770"
```


---

**9. Reboot or Re-login**

Reboot your system or log out and back in to apply group changes.

---

**10. Launch virt-manager**

Start the graphical VM manager:

```bash
virt-manager
```

You can now create and manage virtual machines using the GUI or command-line tools[^4][^5][^6][^7].

---

### **Troubleshooting Tips**

- If you see errors about missing dependencies (e.g., `dmidecode`), install them with `sudo pacman -S dmidecode`[^3].
- If virt-manager cannot connect, try restarting `libvirtd` and ensure your user is in the `libvirt` group.
- For advanced networking or GPU passthrough, consult the Arch Wiki articles on [QEMU][^1], [KVM][^3], and [libvirt][^3].

---

This setup will get you a robust QEMU/KVM virtualization environment on Arch Linux, ready for kernel development or general VM use.

<div style="text-align: center">⁂</div>

[^1]: https://wiki.archlinux.org/title/QEMU

[^2]: https://kskroyal.com/how-to-install-qemu-kvm-on-linux/

[^3]: https://www.reddit.com/r/archlinux/comments/14akrgg/how_to_get_kvm_libvirtd_and_virtmanager_working/

[^4]: https://gist.github.com/tatumroaquin/c6464e1ccaef40fd098a4f31db61ab22

[^5]: https://christitus.com/setup-qemu-in-archlinux/

[^6]: https://www.youtube.com/watch?v=cN_a7NgBWX8

[^7]: https://www.youtube.com/watch?v=hzyIsb1Mdf0

[^8]: https://gist.github.com/lordofwizard/35e39955d70da70ddb4af4ca02afcd98

[^9]: https://www.tauceti.blog/posts/virtualization-with-archlinux-qemu-kvm-part-4/

[^10]: https://www.youtube.com/watch?v=OwFZW8x8SsY

[^11]: https://www.reddit.com/r/archlinux/comments/68jvew/installing_archlinux_in_a_qemu_kvm_vm/

[^12]: https://www.reddit.com/r/archlinux/comments/1cqv7tl/qemukvm_virtmanager_for_install_arch_linux/

[^13]: https://www.qemu.org/download

