# helm-charts
Collection of ScienceBox Helm Charts.

This repository hosts a collection of Helm charts for stand-alone ScienceBox deployments:
- **sciencebox** ~ The master umbrella chart for the deployment of ScienceBox in its entirety.
- **cvmfs** ~ The [CVMFS](https://cernvm.cern.ch/fs/) client for [SWAN](https://swan.web.cern.ch/swan/) to use software stacks from centrally-managed repositories.
- **eos-instance-config** ~ An helper chart to get an [EOS](https://owncloud.dev/extensions/idp/) instance configured according to the ScienceBox requirements.
- **ocid-idp** ~ The Identity Provider based on [OwnCloud OpenID Connect provider](https://owncloud.dev/extensions/idp/).

Charts for other services part of ScienceBox are hosted on dedicated repositories:
- EOS --> https://github.com/cern-eos/eos-charts
- SWAN --> https://github.com/swan-cern/swan-charts


## Deploying on Minikube

Before, deploying the helm charts, run the following commands to update the helm dependencies:

```
git clone https://github.com/sciencebox/charts.git
git checkout devel-2
cd sciencebox
helm dep update
```

After updating the dependencies, in order to deploy the charts on minikube we have the installation scripts available [here](https://github.com/sciencebox/mboxed/tree/test-openldap#quick-setup) in a dedicated repository. 


## Work-Around

Currently, the `redirect_uris` in the [identifier_registration.yaml](https://github.com/sciencebox/charts/blob/devel-2/sciencebox/values.yaml#L393) file are hardcorded and not yet templated. They should be replaced with the `${HOSTNAME}` of the machine running the minikube cluster, because the ingress is configured to route the hostname.