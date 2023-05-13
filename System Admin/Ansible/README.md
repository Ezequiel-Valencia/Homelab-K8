# Ansible

Ansible playbooks are executed within some host device, and then usually through ssh, Ansible tries to connect to remote servers listed within its host variable that can be in a seperate file.

These remote servers then have all the tasks within Ansible excuted in a order, **however** for critical tasks that require one to be done prior to the other specify it within playbook itself.

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