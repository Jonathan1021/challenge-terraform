variable "region" {
  description = "Cost Center"
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