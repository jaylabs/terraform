# Terraform

## Working with workspaces + modules


### Setting up AWS named profiles

The credentials and config file should look like this:


**~/.aws/credentials**
```
[jaylabs-development]
aws_access_key_id = XXXxxxXXX
aws_secret_access_key = XXXxxxXXX

[jaylabs-qa]
aws_access_key_id = XXXxxxXXX
aws_secret_access_key = XXXxxxXXX

[jaylabs-staging]
aws_access_key_id = XXXxxxXXX
aws_secret_access_key = XXXxxxXXX

[jaylabs-production]
aws_access_key_id = XXXxxxXXX
aws_secret_access_key = XXXxxxXXX
```

**~/.aws/config**
```
[profile jaylabs-development]
output = json

[profile jaylabs-qa]
output = json

[profile jaylabs-staging]
output = json

[profile jaylabs-production]
output = json
```

### Commands

```
terraform init
terraform workspace new development
terraform workspace new qa
terraform workspace new staging
terraform workspace new production
terraform workspace select development
terraform plan
terraform apply
```