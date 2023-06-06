For backups I am keeping backups within the last 7 days, having a backup occur every 3 days.

This means that there will be 2 backups of every VM at any given time.

# Mount Protcol

I am going to use SMB for my mounting method to transfer data to the NAS. NFS is native to linux and sounds better since its not windows related BUT it requires managing Kerbeos server and that is a pain in the ass.

Plus Proxmox does not seem to allow backups through RBD.

SMB is supported across multiple devices, is slower for small writes but not that much slower for large writes.

### Errors
Make sure to not lock the user which will have to use SMB or else you'll get an error 500, also make sure all permisions are set.

https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/security_guide/sect-security_guide-server_security-securing_nfs#sect-Security_Guide-Securing_NFS-Carefully_Plan_the_Network


https://pve.proxmox.com/wiki/Backup_and_Restore