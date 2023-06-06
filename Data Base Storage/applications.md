# Remote Storage
Trying to do remote storage for theses applications using SMB, NFS, or iSCSI is to much of a pain to follow through with.
- SMB
    - Even though permisions and users are set appropately it does not seem to work. Specifically the database applications require to change the owner of files and the SMB does not seem to allow for that.

    - Owned by microsoft

- NFS
    - Insecure unless I use Kerbeos and setting up a ticket granting system is to much of a pain.

- iSCSI
    - This is acting as a completely remote HDD, working on the block level rather than the file system level. This proves itself to be tricky if I want to back up this storage information or migrate.
    
    - The security for this I don't know well enough.

# Local Storage
The only issue with having the apps installed with the TrueNAS application is the potential bug that arises and not understanding how to fix it since it uses kubernetes. But, whatever I'm tired and we ball.

- If there is some issue when starting up TrueNAS again just reboot it and see if that fixes it.

### Syncthing
Used for files which I don't want to be stored remotely, and just want to be synced across multiple devices.

### Nextcloud
Used for having some form of cloud storage and cloud applications


### Photoprisim
Used for just storing photos.


Its better not to have it on the NAS since if something goes wrong the tools available are really only the GUI and its not optimal.