# Initial version, all in one block
# TODO: Split in Main, Variables, Outputs

####################################################
###            Variable Definition
####################################################

variable "redis-container" {
  description = "Redis container needed to run Sentry"
  default = "sentry-redis"
}

variable "postgres-container"{
  description = "Postgres container needed to run Sentry"
  default = "sentry-postgres"
}

variable "sentry-container" {
  description = "The actual container for Sentry server"
  default = "my-sentry"
}

variable "redis-image" {
  description = "image for Redis dependency"
  default = "redis:latest"
}

variable "postgres-image" {
  description = "image for Postgres dependency"
  default = "postgres:latest"
}

variable "postgresPass" {
  description = "Postgres DB Password"
  default = "secret"
}

variable "postgresUser" {
  description = "Postgres DB User"
  default = "sentry"
}

variable "sentry-image" {
  description = "image for Sentry server"
  default = "sentry:latest"
}

###################################################
###          Download images now
###################################################

# Download the latest Redis Image
resource "docker_image" "redis-image" {
  name = "${var.redis-image}"
}

# Download the latest Postgres Image
resource "docker_image" "postgres-image" {
  name = "${var.postgres-image}"
}

# Download the latest Sentry Image
resource "docker_image" "sentry-image" {
  name = "${var.sentry-image}"
}

###################################################
##           Start containers
###################################################

resource "docker_container" "redis-container" {
  name  = "${var.redis-container}"
  image = "${docker_image.redis-image.latest}"
}

resource "docker_container" "postgres-container" {
  name  = "${var.postgres-container}"
  image = "${docker_image.postgres-image.latest}"
  env = ["POSTGRES_PASSWORD=${var.postgresPass}","POSTGRES_USER=${var.postgresUser}"]
}

resource "null_resource" "capture-sentry-key" {
  depends_on = ["docker_image.sentry-image"]
  provisioner "local-exec" {
    command = "docker run --rm ${docker_image.sentry-image.latest} config generate-secret-key | tr -d '\n' > sentry-key.out"
  }
}

data "local_file" "sentry-key" {
  depends_on = ["null_resource.capture-sentry-key"]
  filename = "./sentry-key.out"
}

/*
resource "null_resource" "upgrade-sentry" {
  #depends_on = ["docker_container.postgres-container"]
  provisioner "local-exec" {
    command = "docker run --rm -e SENTRY_SECRET_KEY='${data.local_file.sentry-key.content}' --link sentry-postgres:postgres --link sentry-redis:redis sentry upgrade -v 0 --noinput"
  }
}
*/

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

output "sentry-key" {
  value = "${data.local_file.sentry-key.content}"
}


