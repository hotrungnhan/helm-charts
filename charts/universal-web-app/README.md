# Universal Web Application Helm Chart

This Helm chart is designed for deploying a universal web application with support for a main application and worker processes. It includes resources such as deployments, horizontal pod autoscalers, services, ingress, secrets, environment variables, and jobs. The chart is highly configurable and follows best practices for Kubernetes deployments.

## Features

- **Deployments**: Supports two types:
  - `main-app`: The primary application with ingress support.
  - `workers`: Background worker processes.

- **Horizontal Pod Autoscaler**: Automatically scales both `main-app` and `workers` deployments based on resource utilization.

- **Service & Ingress**: Manages service and ingress resources for the `main-app` deployment.

- **Secrets & Environment Variables**: 
  - Common secrets and environment variables shared across all pods.
  - Specific instances can also have their own secrets and environment variables.

- **Jobs**: Supports one-time jobs that are automatically triggered by Helm events.

## Kubernetes Resources

The chart deploys the following Kubernetes resources:

- **Deployments**:
  - `main-app`: Supports ingress.
  - `workers`: For background processing.

- **Horizontal Pod Autoscalers**:
  - For both `app` and `workers`.

- **Service & Ingress**:
  - For `app` only.

- **Secrets & Environment Variables**:
  - Common secrets and environment variables shared across all pods.
  - Specific instances can also have their own secrets and environment variables.

- **Jobs**:
  - One-time jobs that are automatically triggered by Helm events.

## Installation

To install the chart with the release name `my-release`:

```sh
helm install my-release ./universal-web-application
```


## Helm Hooks

The following Helm hooks are supported for jobs:

- `pre-install`
- `post-install`
- `pre-delete`
- `post-delete`
- `pre-upgrade`
- `post-upgrade`
- `pre-rollback`
- `post-rollback`
- `test`
- `test-success`
- `test-failure`

These hooks can be used to trigger jobs at specific points during the release lifecycle.

## Configuration table

### Cheetsheet template

```yaml
common:
  annotations: null
  labels: null
  env: 
    KEY1: "value1"
    KEY2: "value2"
  secret: 
    SECRET_KEY1: "secret_value1"
    SECRET_KEY2: "secret_value2"
  image:
    registry: "registry-1.docker.io"
    repository: "traefik/whoami"
    tag: "latest"

app:
  enabled: true
  name: "my-app"
  image:
    registry: "my-registry"
    repository: "my-repo"
    tag: "my-tag"
    pullSecrets: ["my-secret"]
  commands: ["cmd1", "cmd2"]
  args: ["arg1", "arg2"]
  port: 8080
  annotations:
    app-annotation: "value"
  labels:
    app-label: "value"
  ingress:
    enabled: true
    annotations: 
      ingress-annotation: "value"
    labels: 
      ingress-label: "value"
    className: "nginx"
    host: "my-app.example.com"
    path: "/app"
    pathType: "Prefix"
    tls: ""
  replicas:
    autoScalingEnabled: true
    replicaCount: 3
    minReplicas: 1
    maxReplicas: 5
    targetCPUUtilizationPercentage: 80
    targetMemoryUtilizationPercentage: 75
  resources:
    limits:
      cpu: "200m"
      memory: "256Mi"
    requests:
      cpu: "100m"
      memory: "128Mi"
  env: 
    APP_ENV_VAR: "value"
  secret: 
    APP_SECRET_KEY: "secret_value"
  jobs:
    - enabled: true
      name: "my-job"
      image:
        registry: "job-registry"
        repository: "job-repo"
        tag: "job-tag"
        pullSecrets: ["job-secret"]
      commands: ["job-cmd1", "job-cmd2"]
      args: ["job-arg1", "job-arg2"]
      events: ["pre-install", "post-install"]
      env:
        JOB_ENV_VAR: "value"
      secret:
        JOB_SECRET_KEY: "secret_value"
      resources:
        limits:
          cpu: "200m"
          memory: "256Mi"
        requests:
          cpu: "100m"
          memory: "128Mi"
  extras:
    - key: "extra_key"
      value: "extra_value"

workers:
  - enabled: true
    name: "worker1"
    labels:
      worker-label: "value"
    annotations:
      worker-annotation: "value"
    image:
      registry: "worker-registry"
      repository: "worker-repo"
      tag: "worker-tag"
      pullSecrets: ["worker-secret"]
    commands: ["worker-cmd1", "worker-cmd2"]
    args: ["worker-arg1", "worker-arg2"]
    replicas:
      autoScalingEnabled: true
      replicaCount: 2
      minReplicas: 1
      maxReplicas: 4
      targetCPUUtilizationPercentage: 75
      targetMemoryUtilizationPercentage: 75
    resources:
      limits:
        cpu: "150m"
        memory: "256Mi"
      requests:
        cpu: "100m"
        memory: "128Mi"
    env:
      WORKER_ENV_VAR: "value"
    secret:
      WORKER_SECRET_KEY: "secret_value"
    affinity: 
      nodeAffinity: "preferred"
    placement:
      nodeSelector: "key=value"
    extras:
      - key: "worker_extra_key"
        value: "worker_extra_value"
  - enabled: false
    name: "worker2"
    # other configurations

extras:
  - key: "extra_key"
    value: "extra_value"
```

### Configuration Table for `common`

| Key         | Type           | Default                | Description               |
| ----------- | -------------- | ---------------------- | ------------------------- |
| annotations | object \| null | null                   | Annotations to be applied |
| labels      | object \| null | null                   | Labels to be applied      |
| env         | object \| null | null                   | Environment variables     |
| secret      | object \| null | null                   | Secrets                   |
| image       | object         |                        | Image configuration       |
| registry    | string         | "registry-1.docker.io" | Image registry            |
| repository  | string         | "traefik/whoami"       | Image repository          |
| tag         | string         | "latest"               | Image tag                 |

### Configuration Table for `app`

| Key                                        | Type            | Default | Description                           |
| ------------------------------------------ | --------------- | ------- | ------------------------------------- |
| enabled                                    | boolean         | true    | Enable or disable the app             |
| name                                       | string          |         | Name of the app                       |
| image                                      | object \| null  | null    | App image configuration               |
| image.registry                             | string \| null  | null    | App image registry                    |
| image.repository                           | string \| null  | null    | App image repository                  |
| image.tag                                  | string \| null  | null    | App image tag                         |
| image.pullSecrets                          | array \| null   | null    | Secrets for image pulling             |
| commands                                   | array \| null   | null    | Commands to run                       |
| args                                       | array \| null   | null    | Arguments to pass                     |
| port                                       | integer \| null | 80      | Port number                           |
| annotations                                | object \| null  | null    | Annotations to be applied             |
| labels                                     | object \| null  | null    | Labels to be applied                  |
| ingress                                    | object          |         | Ingress configuration                 |
| ingress.enabled                            | boolean         | false   | Enable or disable ingress             |
| ingress.annotations                        | object \| null  | null    | Ingress annotations                   |
| ingress.labels                             | object \| null  | null    | Ingress labels                        |
| ingress.className                          | string \| null  | null    | Ingress class name                    |
| ingress.host                               | string \| null  | null    | Ingress host                          |
| ingress.path                               | string          | "/"     | Ingress path                          |
| ingress.pathType                           | string \| null  | null    | Ingress path type                     |
| ingress.tls                                | string \| null  | null    | Ingress TLS configuration             |
| replicas                                   | object          |         | Replica settings                      |
| replicas.autoScalingEnabled                | boolean         | true    | Enable or disable auto-scaling        |
| replicas.replicaCount                      | integer         | 1       | Number of replicas                    |
| replicas.minReplicas                       | integer         | 0       | Minimum number of replicas            |
| replicas.maxReplicas                       | integer         | 3       | Maximum number of replicas            |
| replicas.targetCPUUtilizationPercentage    | integer         | 70      | Target CPU utilization for scaling    |
| replicas.targetMemoryUtilizationPercentage | integer         | 70      | Target memory utilization for scaling |
| resources                                  | object \| null  | null    | Resource limits and requests          |
| resources.limits                           | object \| null  | null    | Resource limits                       |
| resources.limits.cpu                       | string          | "100m"  | CPU limit                             |
| resources.limits.memory                    | string          | "128Mi" | Memory limit                          |
| resources.requests                         | object \| null  | null    | Resource requests                     |
| resources.requests.cpu                     | string          | "100m"  | CPU request                           |
| resources.requests.memory                  | string          | "128Mi" | Memory request                        |
| env                                        | object \| null  | null    | Environment variables                 |
| secret                                     | object \| null  | null    | Secrets                               |
| jobs                                       | array           |         | Job configurations                    |
| extras                                     | array \| null   | []      | Extra configurations                  |

### Configuration Table for `workers`

| Key                                        | Type           | Default | Description                                  |
| ------------------------------------------ | -------------- | ------- | -------------------------------------------- |
| enabled                                    | boolean        | true    | Enable or disable the worker                 |
| name                                       | string         |         | Name of the worker                           |
| labels                                     | object \| null | null    | Labels to be applied to the worker           |
| annotations                                | object \| null | null    | Annotations to be applied to the worker      |
| image                                      | object         |         | Worker image configuration                   |
| image.registry                             | string \| null | null    | Worker image registry                        |
| image.repository                           | string \| null | null    | Worker image repository                      |
| image.tag                                  | string \| null | null    | Worker image tag                             |
| image.pullSecrets                          | array \| null  | null    | Secrets for pulling the worker image         |
| commands                                   | array \| null  | null    | Commands to run for the worker               |
| args                                       | array \| null  | null    | Arguments to pass to the worker              |
| replicas                                   | object         |         | Worker replica settings                      |
| replicas.autoScalingEnabled                | boolean        | true    | Enable or disable auto-scaling for workers   |
| replicas.replicaCount                      | integer        | 1       | Number of worker replicas                    |
| replicas.minReplicas                       | integer        | 0       | Minimum number of worker replicas            |
| replicas.maxReplicas                       | integer        | 10      | Maximum number of worker replicas            |
| replicas.targetCPUUtilizationPercentage    | integer        | 70      | Target CPU utilization for worker scaling    |
| replicas.targetMemoryUtilizationPercentage | integer        | 70      | Target memory utilization for worker scaling |
| resources                                  | object \| null | null    | Worker resource limits and requests          |
| resources.limits                           | object \| null | null    | Worker resource limits                       |
| resources.limits.cpu                       | string         | "100m"  | Worker CPU limit                             |
| resources.limits.memory                    | string         | "128Mi" | Worker memory limit                          |
| resources.requests                         | object \| null | null    | Worker resource requests                     |
| resources.requests.cpu                     | string         | "100m"  | Worker CPU request                           |
| resources.requests.memory                  | string         | "128Mi" | Worker memory request                        |
| env                                        | object \| null | null    | Worker environment variables                 |
| secret                                     | object \| null | null    | Worker secrets                               |
| affinity                                   | object \| null | null    | Worker affinity settings                     |
| placement                                  | object \| null | null    | Worker placement settings                    |
| extras                                     | array \| null  | []      | Extra configurations for workers             |

### Configuration Table for `jobs`

| Key               | Type           | Default | Description                       |
| ----------------- | -------------- | ------- | --------------------------------- |
| enabled           | boolean        | true    | Enable or disable the job         |
| name              | string         |         | Name of the job                   |
| image             | object \| null | null    | Job image configuration           |
| image.registry    | string \| null | null    | Job image registry                |
| image.repository  | string \| null | null    | Job image repository              |
| image.tag         | string \| null | null    | Job image tag                     |
| image.pullSecrets | array \| null  | null    | Secrets for pulling the job image |
| commands          | array \| null  | null    | Commands to run for the job       |
| args              | array \| null  | null    | Arguments to pass to the job      |
| events            | array          | null    | Events triggering the job         |
| env               | object \| null | null    | Job environment variables         |
| secret            | object \| null | null    | Job secrets                       |
| resources         | object         |         | Job resource limits and requests  |
|                   |

 resources.limits                    | object              |         | Job resource limits                                    |
| resources.limits.cpu                | string              | "100m"  | Job CPU limit                                          |
| resources.limits.memory             | string              | "128Mi" | Job memory limit                                       |
| resources.requests                  | object              |         | Job resource requests                                  |
| resources.requests.cpu              | string              | "100m"  | Job CPU request                                        |
| resources.requests.memory           | string              | "128Mi" | Job memory request                                     |

## License

This Helm chart is licensed under the MIT License. See the [LICENSE](../../LICENSE) file for more details.