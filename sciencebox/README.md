## ScienceBox chart

A collection of other charts (and umbrella charts) to deploy ScienceBox in its entirety:
- [EOS](https://eos-web.web.cern.ch/eos-web/) ~ Scalable distributed storage solution developed at CERN
- CERNBOX -- Work in Progress. Stay tuned!
- [SWAN](https://swan.web.cern.ch/swan/) ~ The CERN platform to perform interactive data analysis in the cloud with Jupyter Notebooks
- [CVMFS](https://cernvm.cern.ch/fs/) ~ A software distribution service to let SWAN use centrally-maintained software stacks

ScienceBox also provides additional components for the stand-alone operation of the above services, including:
- [IDP](https://owncloud.dev/extensions/idp/) ~ An identity provider based on OwnCloud OpenID Connect
- [Squid caching] -- Work in Progress. Stay Tuned!


### Deploy
Considering its many paramenters and configuration options, we recommend to try ScienceBox in its demo version first.  
Have a look at **mboxed**, our single-host self-configuring deployment in minikube --> https://github.com/sciencebox/mboxed.

If interested in chart itself and all its dependencies, download it with Helm:
```
helm repo add sciencebox https://registry.cern.ch/chartrepo/sciencebox
helm repo update
helm pull sciencebox/sciencebox --untar
```
