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

/*
resource "docker_container" "postgres-container" {
  name  = "${var.postgres-container}"
  image = "${docker_image.postgres-image.latest}"
  env {
    internal = "${var.int_port}"
    external = "${var.ext_port}"
  }
}
*/ 

#Output the IP Address of the Container

output "Redis IP Address" {
  value = "${docker_container.redis-container.ip_address}"
}

output "redis-container-name" {
  value = "${docker_container.redis-container.name}"
}


