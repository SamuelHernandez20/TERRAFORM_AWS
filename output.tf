# Mostramos la IP pública de las instancias:

output "elastic_ip_f1" {
  value = aws_eip.ip_elastica_f1.public_ip
}

output "elastic_ip_f2" {
  value = aws_eip.ip_elastica_f2.public_ip
}

output "elastic_ip_NFS" {
  value = aws_eip.ip_elastica_NFS.public_ip
}

output "elastic_ip_BAL" {
  value = aws_eip.ip_elastica_Bal.public_ip
}