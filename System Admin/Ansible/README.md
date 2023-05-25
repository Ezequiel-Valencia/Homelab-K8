# Ansible

Ansible playbooks are executed within some host device, and then usually through ssh, Ansible tries to connect to remote servers listed within its host variable that can be in a seperate file.

These remote servers then have all the tasks within Ansible excuted in a order, **however** for critical tasks that require one to be done prior to the other specify it within playbook itself.

Use "ansible-playbook {playbook name that is desired} --check" to make peform a dry run of ansible playbooks.

## Ansible Modules
Ansible modules are the API's that allow for execution of tasks related to applications desired. Ansibles actual syntax is very sparse,
all of its functionality seems to come from its modules.

## What These Playbooks Do

### Add fingerprint

This playbook is supposed to add the remote server to the trusted fingerprints within the host. In addition it sends a ping such that it ensures the remote server is up.

***IMPROVEMENT*** 

Make it so that everything is done with ssh keys rather than password


### Install Docker

This playbook installs docker and portainer within the remote server


### Kubernetes

To automatically install non-control servers with kubernetes there is kubespray.
Create a few config files for kubespray myself, then just clone the repo and execute it with my config files.

### Execution structure
Playbook runs all everything, checking if these roles are affiliated with the set of hosts. For each role, the sub-tasks executed are checked to make sure the hostname is what their expected sub-task affiliated with, allowing two layers of filtering. One layer is for general theme, the second is for specfic devices.

### Commands
- Dry run
    - ansible-playbook ./p*/init_home_lab.ansible.yml --check--ask-vault-pass
- Helpful docker commands
    - dock rm
    - dock compose up
    - docker exec sonnar curl ifconfig.me (checks what public IP is)
    - docker exec "container name" hostname -i (find internal IP address, setting up qbit and jack)
    - docker log "container name"
- Fixing storage issues
    - df -h
    - lvs
    - fdisk
    - lsblk

### Low applications
https://hub.docker.com/r/linuxserver/grocy
https://hub.docker.com/r/jellyfin/jellyfin

### Sus applications
https://hub.docker.com/r/linuxserver/jackett
https://hub.docker.com/r/evanbuss/openbooks


### Sensitive applications
https://hub.docker.com/r/photoprism/photoprism
https://hub.docker.com/r/vaultwarden/server


### Infrastructure applications
https://hub.docker.com/r/pihole/pihole


# Errors
If "Missing privilege separation directory: /run/sshd\r\n" error than add the directory, than everything is fine.

The docker_compose module works for creating containers, the other one bugs out.

For some reason trying to set the network to container when composing it, it just bugs out.

Docker run does not have itempotency

GLUETUN DOES NOT WORK.
Every time I try to use wireguard gluetun it does not work

So what I had to do was read the logs for the gluetun container. Turns out that errors have been being raised within the container and I have not been able to read them. Makes sense why other networking related problems would occur, there was no container network to connect to since it kept on failing.
Also it has to use a VM, cause other wise there is not TUN in containers which is required.


Qbit not downloading or super duper slow, its due to file permissions. Make the external directory where its data stored permissions accesible recursively.

Having really low stoarge because the lvm parition for the VM was only 100GB in total for some reason, and even when I increased it manually docker did not increase the size of the volumes. The fix to this was to create a small virtual disk for the bootable drive, then a completely empty other disk that had all of the storage. Then format this empty disk and put all of the volumes within it. Overlay is simply a driver for the file system that is being used within the OS, and can not increase its size if the file systems parition is not large either!