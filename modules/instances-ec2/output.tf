output "instancia_ids" {
  description = "Valores de todos los ids de las instancias"
  value       = [for servidor in aws_instance.servidor : servidor.id]

}
