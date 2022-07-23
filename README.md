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
<!-- filename: main.tf -->
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

## Using variables in Terraform
Terraform just like any goof tool allows you to use variables to increase the usability of your terraform files and also not have to input credentials in files.

The **variables.tf** files is used in defining our variables and variables be define can be referenced in the resource file by **var.variable_name**
 ```terraform
<!-- filename: variables.tf  -->
 variable <variable_name> {
  type = <variable type> #This is optional
  default = <default value to be used> # This is optional
  description = <description of what the variables is for> # This is optional
 }
 ```
 
 A simple variable to collect the bucket name can be as below
 ```terraform
<!-- filename: variables.tf  -->
 variable bucket_name {
  type = string
  description = "Name of AWS S3 Bucket"
 }
 
<!-- filename: main.tf -->
resource "aws_s3_bucket" "MyS3Bucket" {
  bucket_prefix = var.bucket_name
  tags = {
    team = "data-eng-team"
    created_by = "temmyzeus"
}
<!--  -->
 ```
 Note: Absence of default values will ensure you enter the values via the CLI
 
 ### Variables Types In Terraform
 #### Single variables Types In Terraform
 1. string
 2. number
 3. bool
 4. any #default type

 #### Collection Variables Types In Terraform
 1. list: A list must contain values of same type
 2. map: Map is like a dict having a key: value mapping style
 3. set: Values in a set cannot be repeated
 4. object: Similar to an Object in Programming
 5. tuple: Can contain values of various types

Examples of more complex nested types
type: tuple([string, number, bool])
type: list
type: object({
  name = string,
  age = number
})

Note: Important terms are in bold text
