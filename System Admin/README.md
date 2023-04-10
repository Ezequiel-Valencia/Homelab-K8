# System Admin

## Type 1 hypervisor
* Hypervisors that don't work
There are plenty of type one hypervisor such as KVM, Xen Server, Xen Project, VMware EXSI, XCP-ng and more. Xen server and KVM are both great hypervisors but each have their caveot. KVM is not fully a type 1 hypervisor, having an easer interface and a less isolated architecture than Xen server. The issue with Xen server is that it is owned by Microsoft, and is focused more towards profit.

https://forums.lawrencesystems.com/t/xen-vs-xenserver-vs-kvm-vs-proxmox/14256

* My chosen Hypervisor
Proxmox seems to be the best choice. It is slightly bloated, but it seems to simply work out of the gate, is fully open source and free, plus has an excellent UI. I would choose Xen to do my hypervisors since it is the most secure hypervisor, but it takes to much work. 

https://youtu.be/GMAvmHEWAMU
https://www.reddit.com/r/selfhosted/comments/wu8y7s/hypervisor_options_xen_vs_proxmox/



## Firewall
Pfsense is a free, opensource fire wall with a nightly build version that has features earlier but costs money, that one is called pfsense CE. Has all the features that could be desired for a firewall. https://www.youtube.com/watch?v=0bTjibLYSOo



https://www.qubes-os.org/