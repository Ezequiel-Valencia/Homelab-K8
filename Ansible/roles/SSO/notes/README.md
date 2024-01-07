# What is Authelia

Authelia is an authentication server dedicated to application security allows for scope in accessing applications (aka website) but not for acquiring resources from that application.

The Web application needs to support OpenID connect or some other form of identity authentication to have it truly be a SSO experience.

If it supports Oauth then it can require the user to sign in again but only with a providers credentials (ex. Google, Github, Reddit).


### Identity Provider
Right now it uses some LDAP server for an identity provider, but in the future it can itself server as an identity provider or use other providers (ex. Google).