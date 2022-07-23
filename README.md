# terraform_explore
Learning about terraform as an IaC tool

# Terraform
Terraform uses file extensions to identfiy files that are to be used by it:
1. **.tf** to identify it's resource files
2. **.tfstate** to identify it state files
2. **.tfvars** to identify it's variables files (this files might contain sentive info so it's not to be version controlled)

Terraform uses a plugin based architecture to work with various platforms like AWS, Azure, DigitalOcean etc, and these plugins are downloaded on *init***. These **plugins** created by **providers** and distributed by Hashicorp, we have 3 types of providers:
1. Official Providers (Owned by Hashicorp)
2. Verified Providers (Companies verified by Hashicorp)
3. Individual Providers

## Exploring the resource files
The terraform resource file is where we defines resources to be created amd it's file extension is **.tf**. An example is seeen below

```terraform
<!-- Start of Resource Block -->
<block_name> "<provider> + _ + <resource>" "<resource_name>" {
  argument_1 = "argument_value_1"
  argument_2 = "argument_value_2"
  argument_3 = "argument_value_3"
}
<!-- End of Resource Block -->
```
Creating an AWS S3 Bucket in Terraform will look like this
```terraform
<!-- Start of Resource Block -->
resource "aws_s3_bucket" "MyS3Bucket" {
  bucket_prefix = "terra"
  tags = {
    team = "data-eng-team"
    created_by = "temmyzeus"
}
<!-- End of Resource Block -->
```

P.S: **Resource Type** consists of provider followed by the underscore and the resource, hence Resource Type => "provider + _ + resource". 
**Resource Name** is a logical name to identify a resource and can be be anything.
**Arguments** are dependent on the **resource type**

Note: Important terms are in bold text
