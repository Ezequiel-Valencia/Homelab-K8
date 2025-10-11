### Cleanup Dead Images
If for some reason K3s agent is taking up large amounts of memory, it can be that the garbage
collection for images is not strict enough.
To force the equivalent of docker system prune for K3s run this.
https://github.com/k3s-io/k3s/issues/1900#issuecomment-644453072

```k3s crictl rmi --prune```


https://askubuntu.com/questions/1012912/systemd-logs-journalctl-are-too-large-and-slow
Size of journalctl logs


https://stackoverflow.com/questions/71900937/is-it-possible-to-shrink-the-spaces-of-io-containerd-snapshotter-v1-overlayfs-fo
Need to address container images being stored locally. That is whats taking up so much space.
If I can reduce that, or just increase disk size I'm golden.
It does not pull more images if the disk reaches 85% usage.

Monitor seems to be storing allocated logs locally. Need to move that to longhorn storage.

### Start Minikube
```bash
minikube start
```

### Dry Run Config
kubectl kustomize ./overlays/minikube | kubectl apply --dry-run=client --validate=true -f -

### Generate secrets
./SealedSecrets/sealed_vpn.sh > ../SealedSecrets/minikube/vpn-secrets.yml


### Remove All
kubectl kustomize ../overlays/dev-island | kubectl delete -f -


### Cert Manager
Manage the certificates for all services and ingress objects.
https://artifacthub.io/packages/helm/cert-manager/cert-manager 


## Security

Determine process user. ["ps aux" or "ps -ely"](https://man7.org/linux/man-pages/man1/ps.1.html)

### Linuxserver Containers
The entrypoint process runs as the containers internal root, but for linuxserver containers the
process that executes the main application runs as the user set by PUID and GUID enviromental
variable. Thus, if I put the security context settings of no privilege escalation and non-privileged
then it should be safe.


# Home-Network
 Internal home network architeture. Everything here is only for internal network and does not have any external connection, other than a singualr port that a VPN connection is required for.
 https://superuser.com/questions/1324710/why-do-end-device-need-to-support-vlans

 ## Applications
The applications that will be ran on top of the OS that are installed within the hypervisor, and the management interface for all of these applications.


## Work Enviroment


 ## System Admin
 Consists of Firewall, intrusion detection system (IDS), intrusion prevention system (IPS), type one hypervisor, and DNS.



# Whole Picture



An amazing web series that I found to late, but seems to be very informational. https://youtube.com/playlist?list=PLjLkaXQ353210citr52k74DWb3IOzHWL7

# What I still need to do manually

## Provision Containers and VMs
- Add public key to containers
- Add user to containers
- Check VPN connection
- Modify qbittorent download location
- Create additional hard drive for media VM

### Set K8 Cluster

- export KUBECONFIG=/home/zek/.kube/config_prd


