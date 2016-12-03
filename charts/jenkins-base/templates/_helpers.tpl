{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 24 -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 24 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "jenkins" -}}
{{- $name := default .Chart.Name "jenkins" -}}
{{- printf "%s-%s" .Release.Name $name | trunc 24 -}}
{{- end -}}
{{- define "nginx" -}}
{{- $name := default .Chart.Name "nginx" -}}
{{- printf "%s-%s" .Release.Name $name | trunc 24 -}}
{{- end -}}
{{- define "letsencrypt" -}}
{{- $name := default .Chart.Name "letsencrypt" -}}
{{- printf "%s-%s" .Release.Name $name | trunc 24 -}}
{{- end -}}