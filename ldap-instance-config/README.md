## ldap-instance-config chart

-----

This chart populates an OpenLDAP instance with custom users and groups as required by ScienceBox.


#### Warning
There would no need for this chart if the ability to [seed LDAP database with ldif](https://github.com/osixia/docker-openldap#seed-ldap-database-with-ldif) worked in osixia/docker-openldap.
It seems instead to be buggy, and so is the resulting `customLdifFiles` in the [OpenLDAP Helm Chart](https://github.com/jp-gouin/helm-openldap#boostrap-custom-ldif).

There are plenty of issues in the osixia/docker-openldap repo on GitHub, nicely summarized at https://github.com/osixia/docker-openldap/issues/547#issuecomment-805686473

Please, don't try to make it work again unless the following issues are fixed:
- https://github.com/osixia/docker-openldap/issues/320
- https://github.com/osixia/docker-openldap/issues/433
- https://github.com/osixia/docker-openldap/issues/538
