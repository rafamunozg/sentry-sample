####################################################
##                 Outputs
####################################################

#Output the IP Address of the Container
output "Redis IP Address" {
  value = "${docker_container.redis-container.ip_address}"
}

output "redis-container-name" {
  value = "${docker_container.redis-container.name}"
}

output "Postgres IP Address" {
  value = "${docker_container.postgres-container.ip_address}"
}

output "postgres-container-name" {
  value = "${docker_container.postgres-container.name}"
}

output "Sentry main URL:" {
    value = "${format("http://%s:%s", ${data.local_file.host-name.content}, ${var.sentry-webport})}"
}