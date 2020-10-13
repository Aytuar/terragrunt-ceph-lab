locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "github.com/jeffbilder/terraform-aws-ami-search?ref=patch-1"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  os = "centos-8"

  amis_os_map_regex = {
    centos-8 = "CentOS\\s+8.*x86_64.*"
  }
  amis_os_map_owners = {
    centos-8 = "125523088429"
  }
}
