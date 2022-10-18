# ocis: OwnCloud Infinite Scale

The Helm chart for the ocis extensions


# ocis

![Version: 0.0.7](https://img.shields.io/badge/Version-0.0.7-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.20.0](https://img.shields.io/badge/AppVersion-1.20.0-informational?style=flat-square)

oCIS (ownCloud Infinite Scale) extensions

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| configFiles."identifier_registration.yaml" | string | [identifier_registration.yaml](https://github.com/sciencebox/charts/blob/ocis-schema/ocis/templates/configmap-configfiles.yaml#L9) | Configuration to register OAuth Clients to IDP |
| emptyDir.sizeLimit | string | `""` | `emptyDir` `sizeLimit` if a Persistent Volume is not used |
| extraEnv | list | `[]` | List of Environment variables passed to the container in pod field (`name` and `value`/`valueFrom`) form |
| image.pullPolicy | string | `"Always"` | kubernetes image pull policy |
| image.repository | string | `"gitlab-registry.cern.ch/sciencebox/docker-images/ocis"` | Name of the image repository |
| image.tag | string | `"1.20.0"` | Image Tag to use |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` | Boolean to enable/disable OCIS ingress |
| ingress.exposeIdp | bool | `true` | Configure ingress to expose the IDP |
| ingress.exposeLdap | bool | `false` | Configure ingress to expose the LDAP |
| ingress.grpc | object | `{}` | Configure ingress to use gRPC |
| ingress.hosts[0] | string | `"ocis-idp.local"` | Ingress hostnames |
| ingress.tls | list | `[]` | Ingress TLS configuration |
| persistentVolume.accessModes[0] | string | `"ReadWriteOnce"` | PV Access modes for OCIS Volumes |
| persistentVolume.annotations | object | `{}` |  |
| persistentVolume.enabled | bool | `false` |  |
| persistentVolume.existingClaim | string | `""` |  |
| persistentVolume.mountPath | string | `"/var/tmp"` |  |
| persistentVolume.size | string | `"10Gi"` |  |
| persistentVolume.subPath | string | `""` |  |
| replicaCount | int | `1` | Number of ocis replicas to run |
| resources | object | `{}` |  |
| services.idp.port | int | `9130` | Port for the ocis IDP extention |
| services.idp.targetPort | int | `9130` | Target port for the IDP extension |
| services.proxy.port | int | `443` | Port for the ocis proxy extention |
| services.proxy.targetPort | int | `9200` | Target port for the proxy extension |
| services.type | string | `"ClusterIP"` | ocis service type |
