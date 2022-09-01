## CERNBox chart

A collection of other charts to deploy CERNBox in ScienceBox:
- [revad](https://github.com/cs3org/charts/tree/master/revad) ~ CS3org charts for the Reva interoperability platform 
- [ocis](https://github.com/sciencebox/charts/tree/master/ocis) ~ ownCloud Infinite Scale extensions
- [nginx](https://artifacthub.io/packages/helm/bitnami/nginx) ~ Bitnami's chart for NGINX webserver used to server CERNBox web assets and theme


### Limitations
This chart is an umbrella meant to group all the CERNBox charts together for deployment in ScienceBox:
* It cannot be used to deploy CERNBox in stand-alone mode, for now.
* The configuration provided here relies on external components (e.g., LDAP, MariaDB) that are not provided in this chart.
* It is possible to deploy a toy version of CERNBox (w/o external dependencies) but this requires reconfiguration of several components -- Contributions are welcome
