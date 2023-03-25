output "dns_load_balancer" {
  description = "DNS pública del load balancer"
  value       = module.loadbalancer.dns_load_balancer
}
