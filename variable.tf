variable "vpc_cidr" {
  type        = string
  description = "name of vpc cidr"
  default     = "10.0.0.0/16"
}

variable "public_cidr" {
  type        = string
  description = "name of public subnet 1 cidr"
  default     = "10.0.1.0/24"
}

variable "public_2_cidr" {
  type        = string
  description = "name of public subnet 2 cidr"
  default     = "10.0.10.0/24"
}

variable "public_3_cidr" {
  type        = string
  description = "name of public subnet 3 cidr"
  default     = "10.0.20.0/24"
}


variable "private_cidr" {
  type        = string
  description = "name of private subnet cidr"
  default     = "10.0.2.0/24"
}

variable "private_2_cidr" {
  type        = string
  description = "name of private subnet 1 cidr"
  default     = "10.0.200.0/24"
}


variable "az1" {
  type        = string
  description = "name of availability zone"
  default     = "eu-west-1a"
}

variable "az2" {
  type        = string
  description = "name of availability zone"
  default     = "eu-west-1b"
}

variable "region_name" {
  type        = string
  description = "name of region"
  default     = "eu-west-1"
}


variable "destination_cidr" {
  type        = string
  description = "name of internet gateway cidr"
  default     = "0.0.0.0/0"
}