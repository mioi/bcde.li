# Deploying

Put your IAM Access Key and Secret in a file in this dir named like `terraform.tfvars`, resembling:

```
access_key = "XXXXX"
secret_key = "XXXXX"
```

Then, `terraform plan` to see what trying to deploy would destroy.