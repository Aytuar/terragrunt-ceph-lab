locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../../modules/route-to-subnet-table"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "gw" {
  config_path = "../igw"
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  vpc_id = dependency.vpc.outputs.id
  gw_id  = dependency.gw.outputs.id
}
