### Future Proof

https://doc.traefik.io/traefik/providers/kubernetes-ingress/

https://github.com/kubernetes/ingress-nginx

![Treafik Architecture](image.png)

Traefik just seems a lot more flexible than NGINX although it's slower.

Traefik is batteries included meanwhile NGINX requires modules it seems like.

### Lets Encrypt and DNS

Traefik automatically allows for grabbing of certificates and is extremely helpful in that manner. In this specific setup DNS 01 is used for the challenge for lets encrypt allowing for our services to remain behind a firewall, closed from outside world but still have certificates.

What is needed for this to work is a DNS server that let's encrypt can access external from local network.

[Traefik Documentation](https://doc.traefik.io/traefik/https/acme/)
[Lets Encrypt through GO and Google domains](https://go-acme.github.io/lego/dns/googledomains/)
