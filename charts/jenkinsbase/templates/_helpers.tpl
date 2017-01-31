{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 24 -}}
{{- end -}}

{{/*
Create a random (but prefixed) name for unmanaged (hook) resources for easier cleanup
*/}}
{{- define "hookname" -}}
{{- $prefix := randAlpha 15 -}}
{{- printf "%s-%s" "hook" $prefix | lower | trunc 24 -}}
{{- end -}}