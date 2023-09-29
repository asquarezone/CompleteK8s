{{/*
Expand the name of the chart.
*/}}
{{- define "mywebserver.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mywebserver.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mywebserver.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mywebserver.labels" -}}
helm.sh/chart: {{ include "mywebserver.chart" . }}
{{ include "mywebserver.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mywebserver.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mywebserver.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mywebserver.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mywebserver.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "mywebserver.mylables" -}}
app: {{ include "mywebserver.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
version: {{ .Chart.Version | quote }}
{{- end }}


{{- define "mywebserver.livenessProbe" -}}
port: {{ .Values.probes.livenessProbe.port }}
path: {{ .Values.probes.livenessProbe.path }}
{{- end }}
