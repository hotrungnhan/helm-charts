[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/hotrungnhan)](https://artifacthub.io/packages/search?repo=hotrungnhan)
# Helm Charts Repository

This repository contains Helm charts for deploying various applications and services on Kubernetes.

## Available Charts

| Chart Name        | Repository Path                                        | Artifact hub | Status |
| ----------------- | ------------------------------------------------------ | ------------ | ------ |
| universal-web-app | [/charts/universal/webapp](./charts/universal-web-app) | WIP          | WIP    |

## Getting Started

To use these Helm charts, follow the steps below:

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/hotrungnhan/helm-charts.git
   cd helm-charts
   ```

2. **Choose a Chart:**

   Navigate to the chart directory you are interested in. For example:

   ```bash
   cd charts/universal/webapp
   ```

3. **Customize Chart:**

   Modify any changes file to customize the configuration according to your needs.

4. **Deploy the Chart:**

   Use Helm to deploy the chart to your Kubernetes cluster:

   ```bash
   helm install my-release ./
   ```

   Replace `my-release` with the name you want to give to your deployment.

5. **Verify Deployment:**

   Check that the resources are created successfully:

   ```bash
   kubectl get pods
   kubectl get services
   ```

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