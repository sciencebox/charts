# cernbox

The chart to deploy and configure CERNBox in ScienceBox

A collection of other charts to deploy CERNBox in ScienceBox:
- [revad](https://github.com/cs3org/charts/tree/master/revad) ~ CS3org charts for the Reva interoperability platform
- [ocis](https://github.com/sciencebox/charts/tree/master/ocis) ~ ownCloud Infinite Scale extensions
- [nginx](https://artifacthub.io/packages/helm/bitnami/nginx) ~ Bitnami's chart for NGINX webserver used to server CERNBox web assets and theme

### Chartmuseum deprecation notice
Since 28 April 2023, the Helm chart for CERNBox will be stored in OCI format.

Chartmuseum format is deprecated. The last chart tag published in chartmuseum format is `0.0.4`.

![Version: 0.0.5](https://img.shields.io/badge/Version-0.0.5-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.4.1](https://img.shields.io/badge/AppVersion-1.4.1-informational?style=flat-square)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | cernbox-web(nginx) | 13.2.21 |
| https://cs3org.github.io/charts | gateway(revad) | 1.4.1 |
| https://cs3org.github.io/charts | storageprovideruser(revad) | 1.4.1 |
| https://cs3org.github.io/charts | storageproviderpublic(revad) | 1.4.1 |
| https://cs3org.github.io/charts | authprovidermachine(revad) | 1.4.1 |
| https://cs3org.github.io/charts | authproviderbearer(revad) | 1.4.1 |
| https://cs3org.github.io/charts | storageproviderhome(revad) | 1.4.1 |
| oci://registry.cern.ch/sciencebox/charts | ocis | 0.0.9 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| authproviderbearer.cfgmapName | string | `"authprovider-bearer-config"` | cfgmap containing revad authprovider bearer TOML configuratinos |
| authproviderbearer.image.repository | string | `"gitlab-registry.cern.ch/sciencebox/hotfixes/revad"` | authproviderbearer image to use for deployment |
| authproviderbearer.image.tag | string | `"latest-20220815"` | image tag to use |
| authproviderbearer.oidc.gid_claim | string | `"gid"` |  |
| authproviderbearer.oidc.id_claim | string | `"name"` |  |
| authproviderbearer.oidc.insecure | bool | `true` |  |
| authproviderbearer.oidc.uid_claim | string | `"uid"` |  |
| authproviderbearer.service.grpc.port | int | `9158` | port the grpc service listens on |
| authprovidermachine.cfgmapName | string | `"authprovider-machine-config"` |  |
| authprovidermachine.image.repository | string | `"gitlab-registry.cern.ch/sciencebox/hotfixes/revad"` |  |
| authprovidermachine.image.tag | string | `"latest-20220815"` |  |
| authprovidermachine.service.grpc.port | int | `9166` |  |
| cernbox-web.args[0] | string | `"-c"` |  |
| cernbox-web.args[1] | string | `"/etc/nginx/nginx.conf"` |  |
| cernbox-web.command[0] | string | `"/opt/bitnami/nginx/sbin/nginx"` |  |
| cernbox-web.extraVolumeMounts[0].mountPath | string | `"/etc/nginx/nginx.conf"` |  |
| cernbox-web.extraVolumeMounts[0].name | string | `"web-nginx"` |  |
| cernbox-web.extraVolumeMounts[0].subPath | string | `"nginx.conf"` |  |
| cernbox-web.extraVolumeMounts[1].mountPath | string | `"/var/www/web/config.json"` |  |
| cernbox-web.extraVolumeMounts[1].name | string | `"web-config"` |  |
| cernbox-web.extraVolumeMounts[1].subPath | string | `"config.json"` |  |
| cernbox-web.extraVolumeMounts[2].mountPath | string | `"/var/www/web/"` |  |
| cernbox-web.extraVolumeMounts[2].name | string | `"web-content"` |  |
| cernbox-web.extraVolumes[0].configMap.name | string | `"cernbox-web-nginx"` |  |
| cernbox-web.extraVolumes[0].name | string | `"web-nginx"` |  |
| cernbox-web.extraVolumes[1].configMap.name | string | `"cernbox-web-config"` |  |
| cernbox-web.extraVolumes[1].name | string | `"web-config"` |  |
| cernbox-web.extraVolumes[2].configMap.defaultMode | int | `493` |  |
| cernbox-web.extraVolumes[2].configMap.name | string | `"cernbox-web-init"` |  |
| cernbox-web.extraVolumes[2].name | string | `"web-init"` |  |
| cernbox-web.extraVolumes[3].emptyDir | object | `{}` |  |
| cernbox-web.extraVolumes[3].name | string | `"web-content"` |  |
| cernbox-web.initContainers[0].command | list | `["/bin/sh","/root/cbox_init.sh"]` | Command that the initContainer runs after startup |
| cernbox-web.initContainers[0].env | list | `[{"name":"WEB_ASSET","value":"https://github.com/cernbox/web-release/releases/download/v0.0.9/web.tar.gz"},{"name":"WEB_THEME","value":"https://github.com/cernbox/web-extensions/releases/download/theme-cernbox/v0.1.7/theme-cernbox.tar.gz"}]` | Environment Variables |
| cernbox-web.initContainers[0].env[0] | object | `{"name":"WEB_ASSET","value":"https://github.com/cernbox/web-release/releases/download/v0.0.9/web.tar.gz"}` | URL for the cernbox web asset tarball |
| cernbox-web.initContainers[0].env[0].value | string | `"https://github.com/cernbox/web-release/releases/download/v0.0.9/web.tar.gz"` | value for the web-asset env var |
| cernbox-web.initContainers[0].env[1].value | string | `"https://github.com/cernbox/web-extensions/releases/download/theme-cernbox/v0.1.7/theme-cernbox.tar.gz"` | value for the web-theme env var |
| cernbox-web.initContainers[0].image | string | `"busybox:stable"` | image that the initContainer should use |
| cernbox-web.initContainers[0].name | string | `"cernbox-web-init"` |  |
| cernbox-web.initContainers[0].volumeMounts | list | `[{"mountPath":"/root/cbox_init.sh","name":"web-init","subPath":"cbox_init.sh"},{"mountPath":"/var/www/web/","name":"web-content"}]` | volume mount for the initContainer |
| cernbox-web.initContainers[0].volumeMounts[0] | object | `{"mountPath":"/root/cbox_init.sh","name":"web-init","subPath":"cbox_init.sh"}` | web-init volume mount to mount the init shell script onto the initContainer |
| cernbox-web.initContainers[0].volumeMounts[0].mountPath | string | `"/root/cbox_init.sh"` | web-init volume mount path |
| cernbox-web.initContainers[0].volumeMounts[1].mountPath | string | `"/var/www/web/"` | web-content volume mount path |
| cernbox-web.livenessProbe.enabled | bool | `false` |  |
| cernbox-web.readinessProbe.enabled | bool | `false` |  |
| gateway.cfgmapName | string | `"gateway-config"` | configMap containing revad gateway TOML configurations |
| gateway.env.XrdSecPROTOCOL | string | `"sss"` | XrdSecPROTOCOL - protocol used to authenticate against EOS |
| gateway.image.repository | string | `"cs3org/revad"` | gateway image to use for deployment |
| gateway.image.tag | string | `"v1.19.0"` | image tag to use |
| gateway.service | object | `{"grpc":{"port":9142},"http":{"port":9143}}` | revad gateway service configuration |
| gateway.service.grpc | object | `{"port":9142}` | grpc port |
| gateway.service.grpc.port | int | `9142` | port that gateway grpc service listens on |
| gateway.service.http | object | `{"port":9143}` | http port |
| gateway.service.http.port | int | `9143` | port that gateway http service listens on |
| ocis.env.ACCOUNTS_DEMO_USERS_AND_GROUPS | bool | `false` |  |
| ocis.env.IDM_CREATE_DEMO_USERS | bool | `false` |  |
| ocis.env.IDP_ACCESS_TOKEN_EXPIRATION | int | `28800` | IDP Config - https://owncloud.dev/services/idp/configuration/#environment-variables |
| ocis.env.IDP_HTTP_ADDR | string | `"0.0.0.0:9130"` | Port on which the IDP listens |
| ocis.env.IDP_INSECURE | bool | `true` | set insecure flag for the idp |
| ocis.env.IDP_ISS | string | `"https://sciencebox.local"` | IDP issuer URL |
| ocis.env.IDP_LDAP_LOGIN_ATTRIBUTE | string | `"uid"` |  |
| ocis.env.IDP_LDAP_UUID_ATTRIBUTE | string | `"ownclouduuid"` |  |
| ocis.env.IDP_LDAP_UUID_ATTRIBUTE_TYPE | string | `"binary"` |  |
| ocis.env.LDAP_BIND_DN | string | `"cn=readuser,dc=owncloud,dc=com"` | LDAP - Bind DN |
| ocis.env.LDAP_BIND_PASSWORD | string | `"readuser"` | LDAP - Bind password |
| ocis.env.LDAP_GROUPFILTER | string | `"(objectclass=owncloud)"` | LDAP - group filter |
| ocis.env.LDAP_GROUP_BASE_DN | string | `"dc=owncloud,dc=com"` | LDAP - group base dn |
| ocis.env.LDAP_GROUP_OBJECTCLASS | string | `"groupOfUniqueNames"` | LDAP - group object class |
| ocis.env.LDAP_INSECURE | bool | `true` | set insecure flag for the LDAP |
| ocis.env.LDAP_LOGIN_ATTRIBUTES | string | `"uid,mail"` | LDAP - Login attributes |
| ocis.env.LDAP_URI | string | `"ldaps://sciencebox-ldap:636"` | LDAP URI address |
| ocis.env.LDAP_USERFILTER | string | `"(objectclass=owncloud)"` | LDAP - user filter |
| ocis.env.LDAP_USER_BASE_DN | string | `"dc=owncloud,dc=com"` | LDAP - user base dn |
| ocis.env.LDAP_USER_OBEJECTCLASS | string | `"inetOrgPerson"` | LDAP - user object class |
| ocis.env.OCIS_INSECURE | bool | `true` |  |
| ocis.env.OCIS_JWT_SECRET | string | `"Pive-Fumkiu4"` |  |
| ocis.env.OCIS_LOG_LEVEL | string | `"debug"` |  |
| ocis.env.OCIS_MACHINE_AUTH_API_KEY | string | `"random_api_key"` |  |
| ocis.env.PROXY_ACCOUNT_BACKEND_TYPE | string | `"cs3"` | Proxy Config - https://owncloud.dev/services/proxy/configuration/ |
| ocis.env.PROXY_ENABLE_BASIC_AUTH | bool | `false` |  |
| ocis.env.PROXY_TLS | bool | `true` |  |
| ocis.env.REVA_GATEWAY | string | `"sciencebox-gateway.default.svc.cluster.local:9142"` | Reva Gateway address (Cernbox backend) |
| ocis.env.STORAGE_TRANSFER_SECRET | string | `"replace-me-with-a-transfer-secret"` |  |
| ocis.extensions | list | `["proxy","idp"]` | ocis extensions (https://owncloud.dev/services/) |
| ocis.image.repository | string | `"gitlab-registry.cern.ch/sciencebox/docker-images/ocis"` | image to use for deploying ocis |
| ocis.image.tag | string | `"1.20.0"` | image tag to use |
| ocis.ingress.annotation | object | `{"nginx.ingress.kubernetes.io/backend-protocol":"HTTPS"}` | ingress annotation |
| ocis.ingress.enabled | bool | `true` | enable ingress for ocis |
| ocis.ingress.exposeIdp | bool | `true` | expose the IDP via the ingress |
| storageproviderhome.cfgmapName | string | `"storageprovider-home-config"` | configMap containing revad storageproviderhome TOML configurations |
| storageproviderhome.env.XrdSecPROTOCOL | string | `"sss"` | XrdSecPROTOCOL - protocol used to authenticate against EOS |
| storageproviderhome.image.repository | string | `"cs3org/revad"` | storageproviderhome image to use for deployment |
| storageproviderhome.image.tag | string | `"v1.19.0-eos"` | image tag to use |
| storageproviderhome.service | object | `{"grpc":{"port":18000},"http":{"port":17000}}` | service configurations |
| storageproviderhome.service.grpc | object | `{"port":18000}` | grpc port |
| storageproviderhome.service.grpc.port | int | `18000` | port that grpc service listens on |
| storageproviderhome.service.http | object | `{"port":17000}` | http port |
| storageproviderhome.service.http.port | int | `17000` | port that http service listens on |
| storageproviderpublic.cfgmapName | string | `"storageprovider-public-config"` | configMap containing revad storageproviderpublic TOML configurations |
| storageproviderpublic.env.XrdSecPROTOCOL | string | `"sss"` | XrdSecPROTOCOL - protocol used to authenticate against EOS |
| storageproviderpublic.image.repository | string | `"cs3org/revad"` | storageproviderpublic image to use for deployment |
| storageproviderpublic.image.tag | string | `"v1.19.0-eos"` | image tag to use |
| storageproviderpublic.service | object | `{"grpc":{"port":9278}}` | service configurations |
| storageproviderpublic.service.grpc | object | `{"port":9278}` | grpc port |
| storageproviderpublic.service.grpc.port | int | `9278` | port the grpc service listens on |
| storageprovideruser.cfgmapName | string | `"storageprovider-user-config"` | configMap containing revad storageprovideruser TOML configurations |
| storageprovideruser.env.XrdSecPROTOCOL | string | `"sss"` | XrdSecPROTOCOL - protocol used to authenticate against EOS |
| storageprovideruser.image.repository | string | `"cs3org/revad"` | storageprovideruser image to use for deployment |
| storageprovideruser.image.tag | string | `"v1.19.0-eos"` | image tag to use |
| storageprovideruser.service.grpc.port | int | `16000` | port the grpc service listens on |
| storageprovideruser.service.http.port | int | `15000` | port the http service listens on |
| web.oidcClientId | string | `"web"` |  |
| web.oidcScope | string | `"openid profile email"` |  |

### Limitations
This chart is an umbrella meant to group all the CERNBox charts together for deployment in ScienceBox:
* It cannot be used to deploy CERNBox in stand-alone mode, for now.
* The configuration provided here relies on external components (e.g., LDAP, MariaDB) that are not provided in this chart.
* It is possible to deploy a toy version of CERNBox (w/o external dependencies) but this requires reconfiguration of several components -- Contributions are welcome

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)

