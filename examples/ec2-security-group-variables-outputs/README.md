# EC2 + Security Group + Variables + Outputs

This example provisions a simple EC2 instance with a security group and demonstrates variables, data sources, and outputs.

---

## Step 2: EC2 + Security Group

### What this includes

* Security Group allowing SSH (port 22) from your IP
* EC2 instance (`t2.micro`, Amazon Linux 2)
* Variables for configuration
* Outputs for public IP and URL

---

## Prerequisites

* Terraform installed
* AWS credentials configured
* Existing EC2 key pair

---

## Usage

### 1. Navigate to this directory

```bash
cd ec2-security-group-variables-outputs
```

### 2. Set your variables

Create a `terraform.tfvars` file:

```hcl
key_name = "your-key-pair-name"
```

🔑 No key pair yet?

Create one using AWS CLI:

aws ec2 create-key-pair \
  --key-name terraform-key \
  --query 'KeyMaterial' \
  --output text > terraform-key.pem

chmod 400 terraform-key.pem

Then update:

key_name = "terraform-key"

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Review the plan

```bash
terraform plan
```

### 5. Apply the configuration

```bash
terraform apply
```

---

## Verify

```bash
terraform output instance_public_ip
terraform output web_server_url
```

Test the web server:

```bash
curl $(terraform output -raw web_server_url)
```

---

## Clean up

```bash
terraform destroy
```

---

## What you learn

* Variables (`var.*`)
* Data sources (IP lookup, AMI)
* Resource relationships
* Outputs
* Basic EC2 provisioning
