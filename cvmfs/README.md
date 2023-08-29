# cvmfs

A CVMFS client chart

The Helm chart for the CVMFS client

![Version: 0.0.8](https://img.shields.io/badge/Version-0.0.8-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.11.0](https://img.shields.io/badge/AppVersion-2.11.0-informational?style=flat-square)

### Deploy
The chart can be installed via Helm with
```
helm install cvmfs oci://registry.cern.ch/sciencebox/charts/cvmfs
```

A DaemonSet will be created and the mountpoint `/cvmfs` will be exposed on all the hosts part of the cluster.

#TODO: Label hosts and deploy there only

### Notable defaults
- Mounted repositories:
    - cvmfs-config.cern.ch
    - sft.cern.ch
    - sft-nightlies.cern.ch
- 20 GB cache size
- Direct connection to CVMFS Straum 1 server (no caches)

### Mount other repositories
In `values.yaml`, add your desired as follows:
```yaml
repositories:
  - myrepo.cern.ch
  - sft.cern.ch
  - unpacked.cern.ch
```

Consider that the list specified as `repositories:` overrides the default ones.
If are required, they should be part of the list.

### Custom configuration for all repositories
The key-value pairs passed under `default_local` represent the configuration options for the CVMFS client and apply to all the repositories:
```yaml
default_local:
  CVMFS_DNS_MIN_TTL: 300
  CVMFS_QUOTA_LIMIT: 20000
  CVMFS_HTTP_PROXY: DIRECT
  CVMFS_CACHE_BASE: /var/lib/cvmfs
```

Such values are mapped to the cvmfs configuration file `/etc/cvmfs/default.local`.
Further documentation is available for supported configuration options:
- [Client configuration](https://cvmfs.readthedocs.io/en/stable/cpt-configure.html)
- [Create default.local](https://cvmfs.readthedocs.io/en/stable/cpt-quickstart.html#create-default-local)
- [List of client parameters](https://cvmfs.readthedocs.io/en/stable/apx-parameters.html#client-parameters)

### Custom configuration for each repository
The chart supports defining custom parameters for each repository under `config_d:`.
Example:
```yaml
config_d:
  atlas-nightlies.cern.ch:
    CVMFS_SERVER_URL: 'http://cvmfs-stratum-one.cern.ch/cvmfs/atlas-nightlies.cern.ch'
  sft.cern.ch:
    CVMFS_HTTP_PROXY: 'http://ca-proxy.cern.ch:3128'
```

A set of key-value pairs is expected for each repository and it will be mapped to the configuration file `/etc/cvmfs/config.d/<repo_name>.local`. If no custom parameters are provided, the default configuration defined in `defaul_local` (see above) will be used.

### Advanced options
1. Mount with a different `uid` or `gid`

Defaults are 998 and 996 for `uid` and `gid`, respectively.
Custom values can be specified in `values.yaml` as integers with:
```yaml
mountOptions:
  uid: 1234
  gid: 5678
```

If helm fails parsing the provided values, it will use 0, 0 (typically root, root).

2. Mount at a different path on the host

Default is to use `/cvmfs`, but this can be configured to a custom path using:
```yaml
mountOptions:
  hostMountpoint: /var/cvmfs
```

### Chartmuseum deprecation notice
Since 28 April 2023, the Helm chart for CVMFS will be stored in OCI format.

Chartmuseum format is deprecated. The last chart tag published in chartmuseum format is `0.0.7`.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cleanStaleMounts | bool | `true` | umount stale cvmfs repos in case previous mount crashed |
| customLabels | object | `{"component":"swan-users","service":"swan"}` | Custom labels to identify cvmfs pod.    They are used by node selection, if enabled (see above).    Label nodes accordingly to avoid scheduling problems. |
| default_local | object | `{"CVMFS_CACHE_BASE":"/var/lib/cvmfs","CVMFS_DNS_MIN_TTL":300,"CVMFS_HTTP_PROXY":"DIRECT","CVMFS_PROXY_SHARD":false,"CVMFS_QUOTA_LIMIT":20000}` | cvmfs configuration common to all repositories stored as key:value pairs     Documentation at:     - https://cvmfs.readthedocs.io/en/stable/cpt-configure.html     - https://cvmfs.readthedocs.io/en/stable/apx-parameters.html#client-parameters |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"gitlab-registry.cern.ch/sciencebox/docker-images/cvmfs"` | Docker image repository for the CVMFS image |
| image.tag | string | `"2.11.0"` | image tag for cvmfs image |
| mountOptions | object | `{"gid":996,"hostMountpoint":"/cvmfs","uid":998}` | Additional mount options common to all repositories |
| podAssignment | object | `{"enableNodeSelector":false}` | Assign cvmfs pod to a node with a specific label.    If true, it will be deployed only on nodes labeled as per customLabels (see below).    If false, it will be deployed on all nodes of the cluster (it is a daemonSet). |
| prefetcher | object | `{"enabled":false}` | Prefetch from cvmfs repos to keep client cache warm     Parameters:      - enabled: Boolean to enable/disable prefetcher. Defaults to false      - jobs: List of commands to execute in crond format     'cat_readme' is the name of a sample prefetching job with the following properties      - command: The command to be executed -- In this case, a simple cat of a file      - user: The user executing the command (Default: root)      - minute, hour, day, month, weekday: When to executre the command as per cron file format (Default: *, aka every minute) |
| repositories | list | `["cvmfs-config.cern.ch","sft.cern.ch","sft-nightlies.cern.ch"]` | Repositories to be mounted by cvmfs pod. |
| resources | object | `{"limits":{},"requests":{}}` | cvmfs container's resource (cpu and memory) requests and limits    Documentation at https://kubernetes.io/docs/user-guide/compute-resources/ |
| resources.limits | object | `{}` | limits: kubelet won't allow the continer to use more |
| resources.requests | object | `{}` | reqeusts: Resources that will be reserved for the container (can use more) |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
