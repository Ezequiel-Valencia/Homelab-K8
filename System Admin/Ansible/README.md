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
