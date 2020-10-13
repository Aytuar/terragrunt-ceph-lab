variable "availability_zone" {
  description = "Availability zone"
  type        = string
}

variable "size" {
  description = "Size in GiB"
  type        = number
}

variable "name" {
  description = "Volume name"
  type        = string
}

variable "type" {
  description = "Type"
  default     = "gp2"
  type        = string
}
