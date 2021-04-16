
variable "AWS_REGION" {
  default = "us-west-2"
}

variable "AMIS" {
  type = map
  default = {
    us-west-2 = "ami-01e78c5619c5e68b4"
  }
}

variable "instance_count" {
  description = "Number of instances to launch"
  default     = 2
}

variable "instance_type" {
  description = "The type of instance to start"
  default     = "t2.medium"
}

variable "pub_key_file" {
  description = "Provide public key file path."
  default     = "~/.ssh/id_rsa.pub"
}

variable "prv_key_file" {
  description = "Provide private key file path."
  default     = "~/.ssh/id_rsa"
}
