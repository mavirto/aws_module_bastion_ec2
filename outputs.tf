# Output IP Publica del Bastion host
output "PublicIP_bastion" {
  description = "Public IP Bastion host"
  value       = aws_instance.bastion_host.*.public_ip
}

# OUTPUT IP PRIVADA 
output "PrivateIP_bastion" {
  description = "Private IP Bastion host"
  value       = aws_instance.bastion_host.*.private_ip
}
