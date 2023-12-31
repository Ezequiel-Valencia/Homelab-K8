### Proxmox SSH

Proxmox requires [root ssh](https://forum.proxmox.com/threads/pve-cluster-can-i-safely-turn-off-ssh-permitrootlogin-passwordauthentication-and-usepam.122958/) for now, and it seems to require [port 22](https://pve.proxmox.com/wiki/Cluster_Manager#:~:text=An%20SSH%20tunnel%20on%20TCP%20port%2022%20between%20nodes%20is%20required) to be used.

### Method for Network protection

Since these two requirements are needed, what can be done is:

1. Install fail2ban to prevent repeated attempts
2. Add a firewall that will allow for only proxmox nodes to communicate with each other