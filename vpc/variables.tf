variable "region" {
  description = "Region"
  type        = string
  default     = "us-east-1"
}

variable "cost_center" {
  description = "Cost Center"
  type        = string
  default     = "challenge-terraform"
}

variable "owner" {
  description = "Owner"
  type        = string
  default     = "Jonathan Vega"
}

variable "env" {
  description = "Enviroment"
  type        = string
  default     = "dev"
}

###
variable "name" {
  description = "Name VPC"
  type        = string
  default     = "pragma"
}

variable "cidr" {
  description = "(Optional) The IPv4 CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_tenancy" {
  description = "(Optional) Allowed tenancy of instances launched into the selected VPC. May be any of 'default', 'dedicated', or 'host'"
  type        = string
  default     = "default"
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}



