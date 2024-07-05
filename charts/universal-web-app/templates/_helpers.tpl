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
labels: 
  app.kubernetes.io/managed-by: Helm
  app.kubernetes.io/release-name: {{ include "application.fullname" $root }}
  app.kubernetes.io/chart: {{ include "application.chart" $root }}
  {{- if $root.Values.common.labels }}
  {{- toYaml $root.Values.common.labels }}
  {{- end }}
  {{- if $current }}
  {{- toYaml $current }}
  {{- end }}
{{- end }}

{{/*
    Get annotations | args [$  .annotations]
*/}}
{{- define "get.annotations" -}}
{{- $root := index . 0 -}}
{{- $current := index . 1 -}}
{{- if or $root.Values.common.annotations $current }}
annotations: 
  {{- if $root.Values.common.annotations }}
  {{- toYaml $root.Values.common.annotations | nindent 2}}
  {{- end }}
  {{- if $current }}
  {{- toYaml $current | nindent 2}}
  {{- end }}
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
{{- end }}

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
minReplicas: {{ dig "minReplicas" 1 . }}
maxReplicas: {{ dig "maxReplicas" 3 . }}
targetCPUUtilizationPercentage: {{ dig "targetCPUUtilizationPercentage" 70 . }}
targetCPUUtilizationPercentage: {{ dig "targetMemoryUtilizationPercentage" 70 . }}
{{- end }}

{{- define "template.image" -}}
registry: {{ dig "registry" nil .  }}
repository: {{ dig "repository" nil .  }}
tag: {{ dig "tag" nil .  }}
pullSecrets: {{ dig "pullSecrets" list .  }}
{{- end }}


{{- define "template.ingress" -}}
enabled: {{ dig "enabled" false .  }}
{{- with (dig "annotations" nil .)}}
{{- if . }}
annotations:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "labels" nil .)}}
{{- if . }}
labels:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
className:  {{ dig "className" nil .  }}
{{- with (dig "host" nil .)}}
{{- if . }}
host: {{ . }}
{{- end }}
{{- end }}
{{- with (dig "tls" nil .)}}
{{- if . }}
tls: {{ . }}
{{- end }}
{{- end }}
path:  {{ dig "path" nil .  }}
pathType: {{ dig "pathType" nil .  }}
{{- end }}


{{- define "template.job" -}}
enabled: {{ dig "enabled" false .  }}
name: {{ dig "name" nil .  }}
{{- with (dig "image" nil .)}}
{{- if . }}
image:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "commands" nil .)}}
{{- if . }}
commands:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "args" nil .)}}
{{- if . }}
args:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "events" nil .)}}
{{- if . }}
events:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "env" nil .)}}
{{- if . }}
env:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "secret" nil .)}}
{{- if . }}
secret:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "resources" nil .)}}
{{- if . }}
resources:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- end }}

{{- define "template.app" -}}
enabled: {{ dig "enabled" false .  }}
name: {{ dig "name" nil .  }}
{{- with (dig "image" nil .)}}
{{- if . }}
image:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "commands" nil .)}}
{{- if . }}
commands:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "args" nil .)}}
{{- if . }}
args:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
port: {{ dig "port" nil .  }}
{{- with (dig "annotations" nil .)}}
{{- if . }}
annotations:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "labels" nil .)}}
{{- if . }}
labels:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "ingress" nil .)}}
{{- if . }}
ingress: {{ dig "ingress" nil .  }}
{{- end }}
{{- end }}
{{- with (dig "replicas" nil .)}}
{{- if . }}
replicas:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "resources" nil .)}}
{{- if . }}
resources:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "env" nil .)}}
{{- if . }}
env:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "secret" nil .)}}
{{- if . }}
secret:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "jobs" nil .)}}
{{- if . }}
jobs:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "extras" nil .)}}
{{- if . }}
extras:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- end }}


{{- define "template.worker" -}}
enabled: {{ dig "enabled" false .  }}
name: {{ dig "name" nil .  }}
{{- with (dig "image" nil .)}}
{{- if . }}
image:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "commands" nil .)}}
{{- if . }}
commands:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "args" nil .)}}
{{- if . }}
args:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "annotations" nil .)}}
{{- if . }}
annotations:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "labels" nil .)}}
{{- if . }}
labels:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "replicas" nil .)}}
{{- if . }}
replicas:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "resources" nil .)}}
{{- if . }}
resources:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "env" nil .)}}
{{- if . }}
env:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "secret" nil .)}}
{{- if . }}
secret:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- with (dig "secret" nil .)}}
{{- if . }}
extras:
  {{- . | toYaml |  nindent 2 }}
{{- end }}
{{- end }}
{{- end }}