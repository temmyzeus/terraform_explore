# terraform_explore
Learning about terraform as an IaC tool

# Terraform
Terraform uses file extensions to identfiy files that are to be used by it:
1. **.tf** to identify it's resource files
2. **.tfstate** to identify it state files
2. **.tfvars** to identify it's variables files (this files might contain sentive info so it's not to be version controlled)

Terraform uses **plugins** created / provided by **providers**, we have 3 types of providers:
1. Official Providers (Owned by Hashicorp)
2. Verified Providers (Companies verified by Hashicorp)
3. Individual Providers

Note: Important terms are in bold text
