### Network Stack

Each container has it's own loopback interface, associated with 127.0.0.1. This is different from the host loopback interface.

Because all of the containers use the gluetuen network stack, this means they all have the same IP address and local interface. So when communicating between different services which use glueten as the network stack, all that needs to be done is set the port and IP address to localhost.

Failed attempts:
    - Docker links 
        - Would have a cyclic dependency with containers that use the VPN
    - Each container has its own individual network
        - Not possible when wanting to use another services network stack as the gateway for communication with other conatiners
    - Manually set the IP table routes
        - To much of a pain
    - Set the VPN container as the gateway
        - To much of a pain


### Health Check

Health check currently has intervals of 4 minutes not to spam the website which allows checking region. Start period does not seem necessary, and may not be helpful.

[Source](https://www.paulsblog.dev/how-to-successfully-implement-a-healthcheck-in-docker-compose/)