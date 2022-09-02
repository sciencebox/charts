# REVA

Reva is an open source platform with two purposes:

- To be an interoperability middleware to [link platforms with the storage and application providers](https://reva.link/docs/overview/).
- To serve as the reference implementation of the [CS3APIS](https://github.com/cs3org/cs3apis).

## Introduction

This chart creates a Reva deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Install

To install the chart with the release name `my-reva`:

```console
$ helm install my-reva cs3org/revad
```

## Uninstalling the Chart

To uninstall/delete the deployment:

```console
$ helm delete my-reva
```

## Configuration

The following configurations may be set. It is recommended to use `values.yaml` for overwriting the revad config.

| Parameter                                         | Description                                                                                                  | Default                                                                                                                   |
| ------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------- |
| `replicaCount`                                    | How many replicas to run.                                                                                    | `1`                                                                                                                       |
| `image.repository`                                | Name of the image to run, without the tag.                                                                   | [`cs3org/revad`](https://hub.docker.com/r/cs3org/revad)                                                                   |
| `image.tag`                                       | The image tag to use.                                                                                        | `v1.7.0`                                                                                                                  |
| `image.pullPolicy`                                | The kubernetes image pull policy.                                                                            | `Always`                                                                                                                  |
| `service.type`                                    | The kubernetes service type to use.                                                                          | `ClusterIP`                                                                                                               |
| `service.grpc.port`                               | Revad's GRPC Service port. To be set on the `address` under the `[grpc]` section of the config.              | `19000`. Can be explicitly disabled by setting `service.grpc` to `null`.                                                  |
| `service.http.port`                               | Revad's HTTP Service port. To be set on the `address` under the `[http]` section of the config.              | `19001`. Can be explicitly disabled by setting `service.http` to `null`.                                                  |
| `extraVolumeMounts`                               | Array of additional volume mounts.                                                                           | `[]`                                                                                                                      |
| `extraVolumes`                                    | Array of additional volumes.                                                                                 | `[]`                                                                                                                      |
| `emptyDir.sizeLimit`                              | `emptyDir` `sizeLimit` if a Persistent Volume is not used                                                    | `""`                                                                                                                      |
| `persistentVolume.enabled`                        | If true, Revad will create a Persistent Volume Claim.                                                        | `false`                                                                                                                   |
| `persistentVolume.accessModes`                    | Revad data Persistent Volume access modes.                                                                   | `[ReadWriteOnce]`                                                                                                         |
| `persistentVolume.annotations`                    | Revad data Persistent Volume annotations.                                                                    | `{}`                                                                                                                      |
| `persistentVolume.existingClaim`                  | Revad data pre-existing Persistent Volume Claim's name.                                                      | `""`                                                                                                                      |
| `persistentVolume.mountPath`                      | Revad data Persistent Volume mount root path. To be set as the `storage` service `root`.                     | `/var/tmp/reva`                                                                                                           |
| `persistentVolume.subPath`                        | Subdirectory of the Persistent Volume to mount as Revad's datadir.                                           | `""`                                                                                                                      |
| `persistentVolume.size`                           | Revad data Persistent Volume size.                                                                           | `2Gi`                                                                                                                     |
| `persistentVolume.storageClass`                   | [PVC Storage Class](https://kubernetes.io/docs/concepts/storage/storage-classes/#the-storageclass-resource). | `unset`                                                                                                                   |
| `persistentVolume.volumeBindingMode`              | [PVC Binding Mode](https://kubernetes.io/docs/concepts/storage/storage-classes/#volume-binding-mode).        | `unset`                                                                                                                   |
| `env`                                             | Dictionary of environment variables passed to the container in `NAME:value` form.                            | `{}`                                                                                                                      |
| `extraEnv`                                        | List of environment variables passed to the container in pod field (`name` and `value`/`valueFrom`) form.    | `[]`                                                                                                                      |
| `envFrom`                                         | List of sources (ConfigMap/Secret) to populate environment variables in the container.                       | `[]`                                                                                                                      |
| `ingress.enabled`                                 | Whether to create an Ingress resource to access the reva daemon services.                                    | `false`. Individual ingress resources might be disabled by setting `ingress.services.{http,grpc}` to `null`.              |
| `ingress.services.{http,grpc}.hostname`           | The {HTTP, gRPC} service ingress hostname.                                                                   | `{http,grpc}.revad.local`                                                                                                 |
| `ingress.services.{http,grpc}.path`               | The {HTTP, gRPC} service ingress path.                                                                       | `/`                                                                                                                       |
| `ingress.services.{http,grpc}.annotations`        | {HTTP, gRPC} ingress resource annotations.                                                                   | `{}`                                                                                                                      |
| `ingress.services.{http,grpc}.tls`                | {HTTP, gRPC} ingress TLS configuration (YAML).                                                               | `[]`                                                                                                                      |
| `configFiles.revad\\.toml`                        | Revad [config file](https://reva.link/docs/config/). Mounted on `/etc/revad/`.                               | [`examples/standalone/standalone.toml`](https://github.com/cs3org/reva/blob/master/examples/standalone/standalone.toml)   |
| `configFiles.users\\.json`                        | Revad `users.json` for the `auth_manager` and `userprovider` services. Mounted on `/etc/revad/`.             | [`examples/standalone/users.demo.json`](https://github.com/cs3org/reva/blob/master/examples/standalone/users.demo.json)   |
| `configFiles.groups\\.json`                       | Revad `groups.json` for the `groupprovider` service. Mounted on `/etc/revad/`.                               | [`examples/standalone/groups.demo.json`](https://github.com/cs3org/reva/blob/master/examples/standalone/groups.demo.json) |
| `configFiles.ocm-providers\\.json`                | Revad `ocm-providers.json` for the `ocmproviderauthorizer` service. Mounted on `/etc/revad/`.                | `[]`                                                                                                                      |

> **Note:** `service.grpc` and `service.http` can't be both `null`.

### Deploying REVA with a `custom-config.toml` file

```console
$ helm install custom-reva cs3org/revad \
  --set-file configFiles.revad\\.toml=custom-config.toml
```
