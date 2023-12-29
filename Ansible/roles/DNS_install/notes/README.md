### 403 Error

If it seems that everything is okay but the PiHole instance is throwing an error then it can be because the path being taken in the URL is not /admin.


### PiHole VM
By having the PiHole in a VM there's first an added layer of security since if it was in a linux container then it would be closer to the Proxmox OS.

Also by having it's own seprate VM there would be no conflicts with other services that may be running on the VM, plus security increase.

PiHole in docker container is so that it's easier to keep all of the services requirements neatly inside a box, thus if anything happens it's easier to diagnose and manage what occurs.
