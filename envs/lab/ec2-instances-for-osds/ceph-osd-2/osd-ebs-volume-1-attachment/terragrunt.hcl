locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../../../../modules/ebs-volume-attachment"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "ec2_instance" {
  config_path = "../ec2-instance"
}

dependency "volume" {
  config_path = "../osd-ebs-volume-1"
}

inputs = {
  device_name = "/dev/sdf"
  volume_id   = dependency.volume.outputs.volume_id
  instance_id = dependency.ec2_instance.outputs.instance_id
}
