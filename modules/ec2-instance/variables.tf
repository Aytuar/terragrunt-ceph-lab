variable "name" {
  description = "Instance name"
  type        = string
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "sg_ids" {
  description = "Security group IDs"
  type        = list
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "monitoring" {
  description = "Monitoring"
  type        = bool
  default     = null
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "user_data" {
  description = "User data"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "user" {
  description = "User name"
  type        = string
  default     = "centos"
}

variable "path_to_keys" {
  description = "Path to SSH keys"
  type        = string
}
