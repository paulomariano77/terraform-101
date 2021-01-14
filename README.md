# Terraform 101 - Introducing to Terraform

 This repository contains a brief example of using Terraform as an infrastructure as code tool.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| aws | ~> 3.0 |

## Install Terraform

### Install Terraform on Linux

```shell
wget https://releases.hashicorp.com/terraform/0.14.4/terraform_0.14.4_linux_amd64.zip
unzip terraform_0.13.24_linux_amd64.zip
mv terraform /usr/local/bin
```

### Install Terraform on Windows

You can use Chocolatey to install Terraform on Windows. To install Chocolatey, see [https://chocolatey.org/install](https://chocolatey.org/install).

```powershell
choco install terraform --version="0.13"
```

### Check the version of terraform

```shell
terraform version
```

## How to execute this?

**1. Install AWS CLI end active the Virtual Environment to use the AWS CLI:**

```shell
pipenv install
pipenv shell
```

**2. Plan your infrastructure:**

```shell
terraform plan
```

**3. Apply your changes:**

```shell
terraform apploy -auto-approve
```

**4. Destroy your infrastructure:**

```shell
terraform plan -destroy
terraform destroy
```
