locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../../../../modules/ebs-volume"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "ec2_instance" {
  config_path = "../ec2-instance"
}

inputs = {
  name              = "ceph-osd-1-2"
  size              = "10"
  availability_zone = dependency.ec2_instance.outputs.availability_zone
}
