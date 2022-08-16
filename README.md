# ScienceBox

ScienceBox project aims to provider container-based version CERN services namely EOS, CERNBox, CVMFS and SWAN services. The goal of the project is to provide an easy and hassle free way to deploy CERN Services on Kubernetes.

# ScienceBox Charts
Collection of ScienceBox Helm Charts.

This repository hosts a collection of Helm charts for stand-alone ScienceBox deployments:
- **Sciencebox**: The master umbrella chart for the deployment of ScienceBox in its entirety.
- **CVMFS**: The [CVMFS](https://cernvm.cern.ch/fs/) client for [SWAN](https://swan.web.cern.ch/swan/) to use software stacks from centrally-managed repositories.
- **eos-instance-config**: An helper chart to get an [EOS](https://owncloud.dev/extensions/idp/) instance configured according to the ScienceBox requirements.
- **OCIS**: OwnCloud Infinite Scale -  Web frontend, Proxy and Identity Provider based on [OwnCloud OpenID Connect Provider](https://owncloud.dev/extensions/idp/).
- **ldap-instance-config**: An helper chart to populate the LDAP server with custom users.

Charts for other services part of ScienceBox are hosted on dedicated repositories:
- EOS:   https://github.com/cern-eos/eos-charts
- SWAN:  https://github.com/swan-cern/swan-charts
- REVA/CERNBox: https://github.com/cs3org/charts/tree/master/revad
- OpenLDAP: https://github.com/helm/charts/tree/master/stable/openldap


## Deploying on Minikube

Before, deploying the helm charts, run the following commands to update the helm dependencies:

```
git clone https://github.com/sciencebox/charts.git
cd sciencebox
helm dep update
```

After updating the dependencies, in order to deploy the charts on minikube we have the installation scripts available [here](https://github.com/sciencebox/mboxed#quick-setup) in a dedicated repository. 

## CERNBox Work-around

With the current deployment scenario, the TOML configuration files are not templated and hence the OIDC Issuer URL is hardcoded [here](https://github.com/sciencebox/charts/blob/cbox-web/sciencebox/values.yaml#L1165). In order to run CERNBox, one needs to replace the URLs to the OIDC issuer hostname.
