# frontier-squid

The Helm chart for the frontier-squid proxy

![Version: 0.1.7](https://img.shields.io/badge/Version-0.1.7-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 4.17-2.1](https://img.shields.io/badge/AppVersion-4.17--2.1-informational?style=flat-square)

### Deploy
The chart can be installed via Helm with
```
helm install squid oci://registry.cern.ch/sciencebox/charts/frontier-squid
```

A Deployment will be created with one replica of the frontier-squid pod, together with a Service to make the frontier-squid proxy reachable by other applications running in the cluster. No ingress functionalities are provided: The proxy is meant for clients within the same Kubernetes cluster only.

The number of replicas can be increased to achieve high availability or provide more capacity for requests from clients. In this case, the Service provides load-balancing across all the available backend replicas.

### Notable defaults
- Squid on-disk cache:
  - Allowed cache size: 10 GB
  - Max object size on disk: 1 GB
- Squid in-memory cache:
  - Allowed cache size: 256 MB
  - Max object size in memory: 32 KB
- Allowed traffic:
  - Protocol: HTTP (80, 8080), HTTPS (443 -- Connect method only)
  - Source: Everyone
  - Destination: All known CVMFS Stratum One servers and other CVMFS-based infrastructures

### Custom configuration
Several squid configuration parameters can be tuned in `values.yaml`:
```
config:
  fileDescriptors: 16384
  cache:
    minSize: "0 KB"             # Applies to both in-memory and on disk caches
    diskDirectory: "/var/cache/squid"
    diskSpace: 10000    # in MB
    diskMaxSize: "1 GB"         # Maximum object size to be cached on disk
    memorySpace: "256 MB"
    memoryMaxSize: "32 KB"      # Maximum object size to be cached in memory
```
Extensive documentation on such parameters is provided by the [upstream squid-cache documentation](http://www.squid-cache.org/Doc/config/).

It is also possible to replace the configuration file completely by setting `configFile: <custom_configuration_file>` in `values.yaml`. This configuration option will apply only if the `configFile` parameter is set and if the file at the provided path exists.

### Chartmuseum deprecation notice
Since 28 April 2023, the Helm chart for Frontier Squid will be stored in OCI format.

Chartmuseum format is deprecated. The last chart tag published in chartmuseum format is `0.1.5`.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config.cache.cache_dir | string | `"cache_dir ufs {{ $.Values.config.cache.diskDirectory }} {{ $.Values.config.cache.diskSpace }} 16 256"` | For further customization of cache_dir if needed. |
| config.cache.diskDirectory | string | `"/var/cache/squid"` |  |
| config.cache.diskMaxSize | string | `"1 GB"` |  |
| config.cache.diskSpace | int | `10000` | in MB |
| config.cache.memoryMaxSize | string | `"32 KB"` | Maximum object size to be cached in memory |
| config.cache.memorySpace | string | `"256 MB"` | Maximum object size to be cached on disk |
| config.cache.minSize | string | `"0 KB"` | Applies to both in-memory and on disk caches |
| config.fileDescriptors | int | `16384` |  |
| configFile | string | `"files/mysquid.conf"` | Squid configuration       - configFile: Provide a full configuration file.          Overrides the provided configMap only if provided and the file exists      - config: Parameters to change default valules in the provided configMap. |
| containerSecurityContext | object | (See values) | securityContext of containers in the pod. |
| customLabels | object | `{"component":"frontier-squid","service":"cvmfs"}` | Custom labels to identify frontier-squid pod(s).     They are used by node selection, if enabled (see above).    Label nodes accordingly to avoid scheduling problems. |
| httpAccessAllow | list | `["stratum_ones","osgstorage","misc","grid_ca"]` | List of squid ACLs to enable via 'http_access allow' (see configmap for ACL definitions) |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"gitlab-registry.cern.ch/sciencebox/docker-images/frontier-squid"` | Docker image for the frontier squid image |
| image.tag | string | `"4.17-2.1"` | image tag for frontier squid image |
| podAssignment | object | `{"enableNodeSelector":false,"enablePodAntiAffinity":false}` | Assign frontier-squid pod(s) to a node with a specific label    and distribute them on different nodes to avoid single points of failure. |
| podAssignment.enableNodeSelector | bool | `false` | If true, requires a node labeled as per customLabels. |
| podAssignment.enablePodAntiAffinity | bool | `false` | If true, run the pods on separate nodes if possible.    Relevant only when running multiple replicas.    Highly recommended for production scenarios. |
| priorityClassName | string | `""` | priorityClassName, recommended for high-occupancy clusters to prioritize squid over other pods. |
| probes | object | `{"liveness":true,"readiness":true,"readinessUrl1":"http://cvmfs-stratum-one.cern.ch/cvmfs/info/v1/meta.json","readinessUrl2":"http://cvmfs.fnal.gov/cvmfs/info/v1/meta.json"}` | Enable or disable health probes.    Docs: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/     Liveness Probe:     Checks every 10 seconds whether it is possible to open a TCP socket againsts port 3128.     The frontier-squid container will be restarted after 3 failures.     Readiness Probe:     Checks every 30 seconds whether the readinessUrl is reachable using the squid in the pod as proxy.     If unreachable, the failing frontier-squid pod will be removed from the service load-balanced alias.     Readiness Urls:     The URLs used by the readiness probe to check the squid in the pod works as expected.     Two URLs are used as backups for each other, to avoid marking the pods unready if one external server is unavailable.    Default: All probes enabled. |
| replicas | int | `1` | Number of frontier-squid pods to run     Squid is seamlessly load-balanced via its network service. Running more replicas    will provide more capacity and the ability to serve more clients.    Consider enabling PodAntiAffinity to increase availability. |
| resources | object | `{}` | Squid pod resource requests and limits (CPU, RAM, etc.) |
| service | object | `{"clusterIP":"None","ports":[{"name":"squid","port":3128,"protocol":"TCP","targetPort":3128}],"type":"ClusterIP"}` | Network Service Specs    Docs: https://kubernetes.io/docs/concepts/services-networking/service/    clusterIP is set to None to have DNS returning all the A records for the pod replicas (headless service)   This is required to leverage on the CVMFS client Proxy Sharding fearure:   https://cvmfs.readthedocs.io/en/latest/cpt-configure.html#sct-proxy-sharding |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
