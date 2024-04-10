{{/*
Expand the name of the chart.
*/}}
{{- define "project.name" -}}
{{- default .Values.application.name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "project.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "project.labels" -}}
helm.sh/chart: {{ include "project.chart" . | quote }}
app.kubernetes.io/version: {{ .Values.application.version | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/part-of: {{ include "project.name" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "project.selectorLabels" -}}
app.kubernetes.io/name: {{ include "project.name" . }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end }}

{{/*
Namespace
*/}}
{{- define "project.namespace" -}}
{{- default .Release.Namespace .Values.namespace -}}
{{- end }}

{{/*
Template Rendering Utility.
*/}}
{{- define "util.keyValue" -}}
  {{- range $dataKey, $dataValue := .value }}
  {{ $dataKey }}: {{ $dataValue | quote }}
  {{- end }}
{{- end }}

{{/*
Template Rendering Utility.
*/}}
{{- define "util.toYaml" -}}
{{- if .value }}
{{ toYaml .value | indent .indent }}
{{- end }}
{{- end }}