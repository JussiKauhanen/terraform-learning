# Terraform Setup with tfenv

This guide walks you through installing Terraform using **tfenv** and running your first Terraform configuration.

---

## 📦 Step 1: Install tfenv

### 1. Clone the tfenv repository

```bash
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
```

### 2. Add tfenv to your PATH

```bash
mkdir -p ~/.local/bin/
sudo ln -s ~/.tfenv/bin/* /usr/local/bin/
```

### 3. Install and use a Terraform version

```bash
tfenv install 1.14.8
tfenv use 1.14.8
```

### 4. Verify installation

```bash
terraform -version
```

You should see the installed version printed in the output.

---

## 🧪 Step 2: Run Your First Terraform Project

### 1. Clone the demo repository

```bash
git clone https://github.com/JussiKauhanen/terraform-learning.git
```

### 2. Navigate to the project directory

```bash
cd terraform-learning/examples/aws-s3-bucket
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Preview the changes

```bash
terraform plan
```

### 5. Apply the configuration

```bash
terraform apply
```

---

## ✅ What You’ll Learn

* Installing Terraform using tfenv
* Managing Terraform versions
* Running a basic Terraform workflow:

  * `init`
  * `plan`
  * `apply`

---

## ⚠️ Notes

* Make sure you have AWS credentials configured before running the demo.
* Always review the `terraform plan` output before applying changes.
* Clean up resources after testing to avoid unnecessary costs:

  ```bash
  terraform destroy
  ```
