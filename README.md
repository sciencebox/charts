# helm-charts
Collection of ScienceBox Helm Charts.

This repository hosts a collection of Helm charts for stand-alone ScienceBox deployments:
- sciencebox -- The master umbrella chart for the deployment of ScienceBox in its entirety.
- cvmfs -- The [CVMFS](https://cernvm.cern.ch/fs/) client for [SWAN](https://swan.web.cern.ch/swan/) to use software stacks from centrally-managed repositories.
- eos-instance-config -- An helper chart to get an [EOS](https://owncloud.dev/extensions/idp/) instance configured according to the ScienceBox requirements.
- ocid-idp -- The Identity Provider based on [OwnCloud OpenID Connect provider](https://owncloud.dev/extensions/idp/).

Charts for other services part of ScienceBox are hosted on dedicated repositories:
- EOS --> https://github.com/cern-eos/eos-charts
- SWAN --> https://github.com/swan-cern/swan-charts
