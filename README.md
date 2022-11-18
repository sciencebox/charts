# ScienceBox

ScienceBox project aims to provider container-based version CERN services namely EOS, CERNBox, CVMFS and SWAN services. The goal of the project is to provide an easy and hassle free way to deploy CERN Services on Kubernetes.

# ScienceBox Charts
Collection of ScienceBox Helm Charts.

This repository hosts a collection of Helm charts for stand-alone ScienceBox deployments:
- **Sciencebox**: The master umbrella chart for the deployment of ScienceBox in its entirety. More details [here](https://github.com/sciencebox/charts/tree/master/sciencebox).
- **CERNBox**: [CERNBox](https://cernbox.web.cern.ch/cernbox/) charts to deploy CERNBox along with [Reva](https://reva.link/) and other satellite components i.e. [MariaDB](https://charts.bitnami.com/bitnami) for storing share information, OCIS for proxy and Identity provider and Nginx Charts for serving CERNBox web frontend.
- **CVMFS**: The [CVMFS](https://cernvm.cern.ch/fs/) client for [SWAN](https://swan.web.cern.ch/swan/) to use software stacks from centrally-managed repositories.
- **eos-instance-config**: An helper chart to get an [EOS](https://owncloud.dev/extensions/idp/) instance configured according to the ScienceBox requirements.
- **OCIS**: OwnCloud Infinite Scale -  Proxy and Identity Provider based on [OwnCloud OpenID Connect Provider](https://owncloud.dev/extensions/idp/).
- **ldap-instance-config**: An helper chart to populate the LDAP server with custom users.

Charts for other services part of ScienceBox are hosted on dedicated repositories:
- EOS:   https://github.com/cern-eos/eos-charts
- SWAN:  https://github.com/swan-cern/swan-charts
- CERNBox: https://github.com/sciencebox/charts/tree/master/cernbox
- OpenLDAP: https://github.com/helm/charts/tree/master/stable/openldap

## Deploying

In order to deploy ScienceBox on a kubernetes cluster, run the following command (we assume you have Helm installed in your system and that you have a kubernetes cluster running)

```
helm repo add sciencebox https://registry.cern.ch/chartrepo/sciencebox
helm install sciencebox/sciencebox
```

## Deploying on Minikube

Before, deploying the helm charts, run the following commands to build the helm dependencies:

```
git clone https://github.com/sciencebox/charts.git
cd sciencebox
helm dep build
```

After updating the dependencies, in order to deploy the charts on minikube we have the installation scripts available [here](https://github.com/sciencebox/mboxed#quick-setup) in a dedicated repository. 

