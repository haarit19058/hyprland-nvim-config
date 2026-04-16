<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# The resolution of virltual machine in virt manager is too blurry

If your virtual machine display in Virt-Manager appears blurry, it is usually due to suboptimal resolution settings, scaling issues, or missing guest drivers. Here’s how you can address and improve the display quality:

## **1. Use the Right Video Device and Display Protocol**

- For Linux guests, set the video device to **QXL** and the display protocol to **SPICE** in Virt-Manager. This combination provides better 2D acceleration and allows dynamic resolution changes[^1][^3].
- For Windows guests, use **Virtio** as the video device and make sure to install the **virtio-win** drivers inside the guest OS for higher resolutions and better performance[^1][^5].


## **2. Install Guest Agents/Drivers**

- **Linux Guests:** Install the `spice-vdagent` package inside the guest. This agent enables automatic resolution adjustment and clipboard sharing between host and guest[^2][^3].

```bash
sudo pacman -S spice-vdagent   # Arch-based guests
sudo apt install spice-vdagent # Debian/Ubuntu guests
```

After installation, restart the guest OS. The display should now automatically resize when you adjust the VM window.
- **Windows Guests:** Mount the `virtio-win` ISO in Virt-Manager, then install the display and QXL drivers from the ISO within Windows[^1].


## **3. Adjust Video RAM**

- Increase the video memory (Video RAM) allocated to the VM in Virt-Manager. Go to **VM Details > Video**, and set a higher value (e.g., 128 MB or more). This allows higher resolutions and better performance[^3].


## **4. Set Custom Resolution (Advanced)**

If your desired resolution is not available, you can manually add it:

- Shut down the VM.
- In Virt-Manager, go to **View > Details > Video**.
- Click the **XML** button and add a `<resolution>` tag under the `<model>` element, for example:

```xml
<video>
  <model type="virtio" heads="1" primary="yes">
    <resolution x="2256" y="1504"/>
  </model>
  <address type="pci" domain="0x0000" bus="0x00" slot="0x01" function="0x0"/>
</video>
```

- Save and restart the VM. The new resolution should now be available in the guest OS display settings[^6].


## **5. Host Display Scaling and Wayland/X11 Issues**

- If you’re running Virt-Manager under Wayland (e.g., KDE Plasma Wayland), you may encounter scaling or blurriness issues. Try running Virt-Manager with the X11 backend:

```bash
GDK_BACKEND=x11 virt-manager
```

This can improve rendering and resolution accuracy, especially on Plasma/Wayland setups[^5].
- If using GNOME, ensure your display scaling is set to 100% for the best results, as higher scaling factors can cause blurriness in the VM window[^4].


## **6. Use "Resize to VM"**

- In Virt-Manager’s menu, select **View > Resize to VM** to match the window size to the guest’s resolution[^1].

---

### **Summary Table**

| Step | What to Do | Why It Helps |
| :-- | :-- | :-- |
| Set Video to QXL/Virtio | VM Details > Video > QXL (Linux), Virtio (Windows) | Better resolution support |
| Use SPICE Display | VM Details > Display > SPICE | Enables dynamic resizing |
| Install spice-vdagent | In guest OS | Auto-resize, clipboard |
| Install virtio-win drivers | In Windows guest | Unlocks high resolutions |
| Increase Video RAM | VM Details > Video > Video RAM | Supports higher resolutions |
| Add Custom Resolution (XML) | Edit VM XML, add `<resolution>` tag | Enables uncommon resolutions |
| Use X11 Backend | Run `GDK_BACKEND=x11 virt-manager` | Fixes scaling issues |
| Resize to VM | View > Resize to VM | Matches host/guest size |


---

By following these steps, your Virt-Manager virtual machine should display at crisp, native resolutions without blurriness[^1][^3][^6].

<div style="text-align: center">⁂</div>

[^1]: https://superuser.com/questions/132322/how-to-increase-the-visualized-screen-resolution-on-qemu-kvm

[^2]: https://discussion.fedoraproject.org/t/when-starting-a-linux-guest-in-virt-manager-i-do-not-have-full-screen-login-how-can-i-change-it/78947

[^3]: https://www.reddit.com/r/qemu_kvm/comments/1efu3by/virtmanager_auto_adjust_of_resolution_to_screen/

[^4]: https://askubuntu.com/questions/1265763/setting-high-resolution-default-for-kvm-qemu-vm-viewers

[^5]: https://discourse.nixos.org/t/virt-manager-seem-cannot-get-the-real-resolution-in-plasma-walyland/52653

[^6]: https://community.frame.work/t/tip-operating-a-guest-os-at-laptops-2256-x-1504-resolution/20113

[^7]: https://www.reddit.com/r/qemu_kvm/comments/oic7m7/qemu_fullscreen_looks_blurry_and_not_sharp/

[^8]: https://forums.opensuse.org/t/screen-resolution-with-windows-10-vm-on-qemu-kvm/173017

[^9]: https://communities.vmware.com/t5/VMware-Fusion-Discussions/Full-Screen-Display-is-Blurry/td-p/1420256

[^10]: https://community.frame.work/t/enabling-native-screen-resolution-in-vms-in-qemu-kvm/25464

