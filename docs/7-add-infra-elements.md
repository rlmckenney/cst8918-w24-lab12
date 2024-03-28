CST8918 - DevOps: Infrastructure as Code  
Prof. Robert McKenney

# Lab 12: Terraform CI/CD on Azure with GitHub Actions

## 7. Add some infrastructure elements

It is time to test everything out!

Create a new branch called `infra-elements` and switch to it.

Update the Terraform configuration in the `infra/tf-app` folder to include the some additional resource elements:

- A Virtual Network
- A Subnet

Commit your changes and push them to the repository.

On GitHub, create a pull request to merge the `infra-elements` branch into the `main` branch.

Check the GitHub Actions workflows to see the status of the pull request.
