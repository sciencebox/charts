{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "ldap-instance-config.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ldap-instance-config.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ldap-instance-config.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "ldap-instance-config.labels" -}}
helm.sh/chart: {{ include "ldap-instance-config.chart" . }}
{{ include "ldap-instance-config.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "ldap-instance-config.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ldap-instance-config.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "ldap-instance-config.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "ldap-instance-config.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
MGM hostname definition
  Used to set the hostname of the MGM (short format) where:
  - Global value '.Values.global.hostnames.mgm' has highest priority
  - Local value '.Values.eosMgmUrl' has lower priority
  - Default values uses .Release.Name

  - It does not support inferring components name's when not using an umbrella chart
    A previous version was supporting this by using  the release name and appending '-mgm' to it
    The one liner is:
      {{- $mgmDefault := printf "%s-mgm" (splitList "-" .Release.Name | initial | join "-") -}}
*/}}
{{- define "mgm.hostname" -}}
{{- $mgmDefault := printf "%s-mgm" .Release.Name -}}
{{- $mgmLocal := "" -}}
{{- $mgmGlobal := "" -}}
{{- if .Values.eosMgmUrl -}}
  {{ $mgmLocal = .Values.eosMgmUrl }}
{{- end }}
{{- if .Values.global -}}
  {{- $mgmGlobal = dig "hostnames" "mgm" "" .Values.global -}}
{{- end }}
{{- coalesce $mgmGlobal $mgmLocal $mgmDefault }}
{{- end }}
