## eos-user-cache-refresher chart

-----

This chart runs `eos access ls` on the MGM pod to keep the internal cache consistent with the information stored in LDAP.
This is relevant for oAuth authentication via fuse as the token contains the user name and the MGM must be capable of mapping it to a Unix uid and gid.
