## Work-arounds for running CERNBOX Charts


This documents keeps track of all the work-arounds used to run CERNBox charts. It contains a brief description of all the charts used.


### EOS Charts

- Chart Used: Upstream Charts [here](https://gitlab.cern.ch/eos/eos-charts/-/tree/master)
- Chart Registry: https://registry.cern.ch/chartrepo/eos
- Image Used: `gitlab-registry.cern.ch/dss/eos/eos-all:4.8.62` (Official Image)

#### Work-Around/Manual steps:

- For the Reva pods to talk to EOS, we need to configure EOS MGM to "trust" the reva pods. By default, the reva pods do not have enough permission to run eos commands. Hence we have to exec into the MGM pod and manually configure MGM to allow reva pods to run eos commands.
- The Reva pods talking to EOS are the `sciencebox-storageprovider-home` and `sciencebox-storageprovider-user`. Hence the following commands are required to be ran for both pods.

**COMMANDS**

```bash
# allow the host 
eos access allow 172-17-0-9.sciencebox-storageprovider-home.default.svc.cluster.local (<FQDN of the pod running reva>)

# add gateway
eos vid add gateway 172-17-0-9.sciencebox-storageprovider-home.default.svc.cluster.local
eos vid set map -tident "*@172-17-0-9.sciencebox-storageprovider-home.default.svc.cluster.local" vuid 0 vgid 0
```

### Reva Charts

- Chart Used: Upstream CS3Org Charts. [here](https://github.com/cs3org/charts)
- Chart Registry: https://cs3org.github.io/charts/
- Image Used: jimil749/revad-master-debug (https://hub.docker.com/repository/docker/jimil749/revad-master-debug)
- Official Image: cs3org/revad (https://hub.docker.com/r/cs3org/revad)

The only difference between the used image and the official image is the logging.

#### Work-Around/Manual steps:

- There are some trivial manual steps that are needed to be executed from inside the revad containers.
- From the `sciencebox-storageprovider-home` & the `sciencebox-storageprovider-user` pod, we need to run:
    - `mkdir /tmp/reva` -> the pods running eos commands store the eos binary at `/tmp/reva/...` which does not exist when the container is created, hence we need to create the directory manually.
    - Replace `/etc/eos.keytab` to match the keytab on mgm, which is:
    ```
    0 u:daemon g:daemon n:sciencebox+ N:6977428376717885441 c:1624559140 e:0 f:0 k:5755929b34c43d4512b739be1b90904f5cb17da5885b91d87d9f7925004a54f6
    ```

### oCIS Charts

- Chart Used: Local Chart. Path: `../ocis-idp`
- Image Used: owncloud/ocis:latest (https://hub.docker.com/r/owncloud/ocis) (Official Image)

#### Work-Around/Manual steps:

Currently the entrypoint command for the OCIS Container is `sleep infinity`. In order the run the ocis server with correct extensions we run the following commands:

```bash
# create the ocis config file
$ mkdir -p /var/tmp/ocis/.config

# add the json manifest
$ vi /var/tmp/ocis/.config/web-config.json

# run ocis server
$ ocis server&

# delete the ocis accounts and glauth service (because we use openldap)
$ ocis kill accounts
$ ocis kill glauth
```

/var/tmp/ocis/.config/web-config.json:
```json
{
  "server": "https://localhost:9200",
  "theme": "owncloud",
  "version": "0.1.0",
  "openIdConnect": {
    "metadata_url": "https://localhost:9200/.well-known/openid-configuration",
    "authority": "https://localhost:9200",
    "client_id": "web",
    "response_type": "code",
    "scope": "openid profile email"
  },
  "apps": ["files"],
  "external_apps": [
    {
      "id": "settings",
      "path": "/settings.js"
    }
  ],
  "options": {
    "hideSearchBar": true,
    "homeFolder": "/eos/user/{{substr 0 1 .Id}}/{{.Id}}"
  }
}
```

As you can notice we configure the server to run at `https://localhost:9200` inside the pod. So in order to access the server from a browser, one needs to port-forward 9200 port to the localhost:

```bash
$ kubectl port-forward <ocis-pod> 9200:9200
```

After running the port-forward and the above mentioned manual steps, one can access the sciencebox deployment from their browser by going to [https://localhost:9200](https://localhost:9200)

In the future, this should be exposed via a kubernetes services which can be reachable by an ingress object.

### Charts Dependencies

Currently, the `ocis-idp` charts and the `ldap-instance-config` charts use local charts as the chart repositories, we need to tag and push the charts to a Cloud Registry.