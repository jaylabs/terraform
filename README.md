# Terraform

## Working with workspaces


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

**terraform workspace list** - List available Workspaces  
**terraform workspace select workspace_name** - Select relevant Workspace  
**terraform workspace show** - Shows the selected Workspace  
**terraform apply** - Apply changes to infrastructure  
**terraform destroy** - Destroy infrastructure  
