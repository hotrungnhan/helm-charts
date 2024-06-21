{{/*
Since this is a template chart, the chart name will be filled in by the user and is the primary naming field.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}

{{- define "application.fullname" -}}
{{- $.Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "application.chart" -}}
{{- printf "%s-%s" $.Chart.Name $.Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}



{{/*
Selector labels
*/}}
{{- define "get.labels.selector" -}}
{{- $root := index . 0 -}}
{{- $current := index . 1 -}}
app.kubernetes.io/name: {{ include "application.fullname" $root }}
{{- with  $root.Values.common.labels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
    Get label | args [$  .labels]
*/}}
{{- define "get.labels.full" -}}
{{- $root := index . 0 -}}
{{- $current := index . 1 -}}
app.kubernetes.io/managed-by: Helm
app.kubernetes.io/release-name: {{ include "application.fullname" $root }}
app.kubernetes.io/chart: {{ include "application.chart" $root }}
{{- with  $root.Values.common.labels }}
{{ toYaml . }}
{{- end }}
{{- with $current }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
    Get annotations | args [$  .annotations]
*/}}
{{- define "get.annotations" -}}
{{- $root := index . 0 -}}
{{- $current := index . 1 -}}
{{- with  $root.Values.common.annotations }}
{{- toYaml . }}
{{- end }}
{{- with $current }}
{{- toYaml . }}
{{- end }}
{{- end }}

{{/*
App Image| args [$  .image]
*/}}
{{- define "get.image_url" -}}
{{- $root := index . 0 -}}
{{- $current := index . 1 -}}
{{- $image := $current | default dict }}
{{- printf "%s/%s:%s" ($image.registry | default $root.Values.common.image.registry) ($image.repository | default $root.Values.common.image.repository) ($image.tag | default $root.Values.common.image.tag)  }}
{{- end }}Ư

{{/*
Pull Secret | args [$  .pullSecrets]
*/}}

{{- define "get.image_pull_secrets" -}}
{{- $root := index . 0 -}}
{{- $current := index . 1 -}}
{{- if $current.registry }}
{{- toYaml $current}}
{{- else if $root.Values.common.image.pullSecrets }}
{{- toYaml $root.Values.common.image.pullSecrets }}
{{- end }}
{{- end }}

{{- define "template.resources" -}}
limits:
  cpu: {{dig "limits" "cpu" "100m" . }}
  memory: {{dig "limits" "memory"  "128Mi" .}}
requests:
  cpu: {{ dig "requests" "cpu" "100m" .}}
  memory: {{dig "requests" "memory" "128Mi" .}}
{{- end }}

{{- define "template.replicas" -}}
autoScalingEnabled: {{ dig "autoScalingEnabled" "" .  }}
replicaCount: {{ dig "replicaCount" 1 . }}
minReplicas: {{ dig "minReplicas" 0 . }}
maxReplicas: {{ dig "maxReplicas" 3 . }}
{{- end }}