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

variable "cron-container" {
  description = "Service instance"
  default = "sentry-cron"
}

variable "worker-container" {
  description = "Workers working with service, it could be more than 1"
  default = "sentry-worker"
}

variable "upgrade-sentry-db-container" {
  description = "Used to create the required DB at the start of the process"
  default = "upgrade-sentry-db"
}

variable "create-sentry-superuser" {
  description = "Used to create the first superuser in silent mode"
  default = "create-sentry-superuser"
}

variable "redis-image" {
  description = "image for Redis dependency"
  default = "redis"
}

variable "postgres-image" {
  description = "image for Postgres dependency"
  default = "postgres"
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
  default = "sentry"
}

variable "user-email" {
  description = "Will be the username for initial superuser"
  default = "user@mail.com"
}

variable "user-password" {
  description = "Will be the password for superuser ... handle with care."
  default = "Pa55word"
}

variable "sentry-webport" {
  description = "Port to be mapped externally"
  default = 80
}
