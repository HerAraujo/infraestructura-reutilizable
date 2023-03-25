// variables para el modulo loadbalancer

variable "subnet_id" {
  description = "Todos los ids de las subnets donde provisionamos el loadbalancer"
  type        = set(string)
}

variable "instancia_ids" {
  description = "Ids de las instancias EC2"
  type        = set(string)
}

variable "puerto_servidor" {
  description = "Puerto para las instancias EC2"
  type        = number
  default     = 8080

  validation {
    condition     = var.puerto_servidor > 0 && var.puerto_servidor <= 65536
    error_message = "El valor del puerto debe estar comprendido entre 1 y 65536."
  }
}

variable "puerto_lb" {
  description = "Puerto para el Load Balancer"
  type        = number
  default     = 80
}
