####################################################
###            Variable Definition
####################################################

variable "redis-container" {
  description = "Redis container needed to run Sentry"
}

variable "postgres-container" {
  description = "Postgres container needed to run Sentry"
}

variable "sentry-container" {
  description = "The actual container for Sentry server"
}

variable "cron-container" {
  description = "Service instance"
}

variable "worker-container" {
  description = "Workers working with service, it could be more than 1"
}

variable "upgrade-sentry-db-container" {
  description = "Used to create the required DB at the start of the process"
}

variable "create-sentry-superuser" {
  description = "Used to create the first superuser in silent mode"
}

variable "redis-image" {
  description = "image for Redis dependency"
}

variable "postgres-image" {
  description = "image for Postgres dependency"
}

variable "postgresPass" {
  description = "Postgres DB Password"
}

variable "postgresUser" {
  description = "Postgres DB User"
}

variable "sentry-image" {
  description = "image for Sentry server"
}

variable "user-email" {
  description = "Will be the username for initial superuser"
}

variable "user-password" {
  description = "Will be the password for superuser ... handle with care."
}

variable "sentry-webport" {
  description = "Port to be mapped externally"
}
