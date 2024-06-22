[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/hotrungnhan)](https://artifacthub.io/packages/search?repo=hotrungnhan)
# Helm Charts Repository

This repository contains Helm charts for deploying various applications and services on Kubernetes.

## Available Charts

| Chart Name                                      | Repository Path                                                                         | Status      |
| ----------------------------------------------- | --------------------------------------------------------------------------------------- | ----------- |
| [universal-web-app](./charts/universal-web-app) | [universal-web-app](https://artifacthub.io/packages/helm/hotrungnhan/universal-web-app) | Development |

## Getting Started

To use these Helm charts, follow the steps below:
To add and deploy the Helm chart from the specified repository, you can follow these steps:

### Step 1: Add the Helm Repository

First, add the Helm repository to your local Helm client:

```sh
helm repo add hotrungnhan https://hotrungnhan.github.io/helm-charts
```

### Step 2: Update Helm Repositories

Update your local Helm chart repository cache to ensure you have the latest version of the charts:

```sh
helm repo update
```

### Step 3: Install the Chart 

Install the `universal-web-app` Helm chart using the specified release name `whoami`, yours should replace this values file with yours config.

```sh
helm install whoami hotrungnhan/universal-web-app -f https://raw.githubusercontent.com/hotrungnhan/helm-charts/main/examples/universal-web-app/whoami.yaml
```

### Summary of Commands

Here’s a summary of all the commands you need to run:

```sh
helm repo add hotrungnhan https://hotrungnhan.github.io/helm-charts
helm repo update
helm install whoami hotrungnhan/universal-web-app -f https://raw.githubusercontent.com/hotrungnhan/helm-charts/main/examples/universal-web-app/whoami.yaml
```

These steps will add the repository, install the chart with the name `whoami`, and apply the custom configuration from the provided YAML file.


## Contributing

Contributions to improve these Helm charts are welcome! To contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/improvement`).
3. Make your changes.
4. Commit your changes (`git commit -am 'Add new feature'`).
5. Push to the branch (`git push origin feature/improvement`).
6. Create a new Pull Request.

## License

This project is licensed under the [MIT License](LICENSE).

---

Feel free to adjust the structure and content to better fit your repository and the specific details of your Helm charts.