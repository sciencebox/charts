{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "cvmfs.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cvmfs.fullname" -}}
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
{{- define "cvmfs.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "cvmfs.labels" -}}
helm.sh/chart: {{ include "cvmfs.chart" . }}
{{ include "cvmfs.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "cvmfs.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cvmfs.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "cvmfs.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "cvmfs.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Join repositories to blank-spaced list
*/}}
{{- define "repolist" -}}
{{- join " " .Values.repositories }}
{{- end -}}

{{/*
Join repositories to comma-separated list
*/}}
{{- define "repolist_csv" -}}
{{- join "," .Values.repositories }}
{{- end -}}

{{/*
Mount UID definition
  Define the owner (uid) of the cvmfs mount.
*/}}
{{- define "mount_uid" -}}
{{- $uid := 998 -}}
{{- if .Values.mountOptions -}}
{{- if .Values.mountOptions.uid -}}
  {{ $uid = int (.Values.mountOptions.uid) }}
{{- end }}
{{- end }}
{{- printf "%d" $uid }}
{{- end }}

{{/*
Mount GID definition
  Define the group (gid) owning the cvmfs mount.
*/}}
{{- define "mount_gid" -}}
{{- $gid := 996 -}}
{{- if .Values.mountOptions -}}
{{- if .Values.mountOptions.gid -}}
  {{ $gid = int (.Values.mountOptions.gid) }}
{{- end }}
{{- end }}
{{- printf "%d" $gid }}
{{- end }}

{{/*
hostMountpoint definition
  Define the mountpoint on the host where cvmfs repositories will be mounted.
*/}}
{{- define "host_mountpoint" -}}
{{- $hm := "/cvmfs" -}}
{{- if .Values.mountOptions -}}
{{- if .Values.mountOptions.hostMountpoint -}}
  {{ $hm = .Values.mountOptions.hostMountpoint }}
{{- end }}
{{- end }}
{{- printf "%s" $hm }}
{{- end }}
