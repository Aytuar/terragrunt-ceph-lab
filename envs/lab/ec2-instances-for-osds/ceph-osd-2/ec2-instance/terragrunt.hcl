locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../../../../modules/ec2-instance"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "subnet" {
  config_path = "../../../subnet"
}

dependency "sg" {
  config_path = "../../../sg"
}

dependency "centos_ami" {
  config_path = "../../../centos_ami"
}

inputs = {
  key_name      = "alexclear"
  name          = "ceph-osd-2"
  ami_id        = dependency.centos_ami.outputs.ami_id
  instance_type = "t2.medium"
  subnet_id     = dependency.subnet.outputs.id
  sg_ids        = [dependency.sg.outputs.id]
  monitoring    = true
  path_to_keys  = "${get_parent_terragrunt_dir()}/keys"
  path_to_hosts = "${get_parent_terragrunt_dir()}/hosts"
  private_ip    = "10.0.0.22"
}
