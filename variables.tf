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

variable "instances" {
  type = map(object({
    name = string
    type = string
    is_public = bool
  }))

   default = {
    instance1 = { name = "webapp", type = "t3.micro", ami = "ami-01b799c439fd5516a", is_public = true }
    instance2 = { name = "database", type = "t3.micro", ami = "ami-01b799c439fd5516a", is_public = false }
  }
}