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

## Configuration table (WIP)
## License

This Helm chart is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.