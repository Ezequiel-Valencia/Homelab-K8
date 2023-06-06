It would prove itself better to have certain docker applications to have their volumes stored within the NAS so that redundancy is assured. On the other hand other applications should not rely on the NAS and should be an entirely seperate system.

# NAS Volumes
- Firefly
    - Have the information on the NAS itself, with no proxmox backup

# Local Volumes
- Media server
    - The entire media server and all of the containers associated with it

- PiHole
    - In case of the NAS failing or turning off, it would be nice to still have a DNS provider.

    - There will be a proxmox backup

- Portainer
    - Same reasoning as PiHole