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
##    Following sequence described in Docker's site
##          https://hub.docker.com/_/sentry/
###################################################

resource "docker_container" "redis-container" {
  name  = "${var.redis-container}"
  image = "${docker_image.redis-image.latest}"
}

resource "docker_container" "postgres-container" {
  name  = "${var.postgres-container}"
  image = "${docker_image.postgres-image.latest}"
  env   = ["POSTGRES_PASSWORD=${var.postgresPass}", "POSTGRES_USER=${var.postgresUser}"]
}

resource "null_resource" "capture-sentry-key" {
  depends_on = ["docker_image.sentry-image"]

  provisioner "local-exec" {
    command = "docker run --rm ${docker_image.sentry-image.latest} config generate-secret-key | tr -d '\n' > sentry-key.out"
  }
}

data "local_file" "sentry-key" {
  depends_on = ["null_resource.capture-sentry-key"]
  filename   = "./sentry-key.out"
}

resource "null_resource" "capture-hostname" {
  provisioner "local-exec" {
    command = "hostname > hostname.out"
  }
}

data "local_file" "host-name" {
  depends_on = ["null_resource.capture-hostname"]
  filename   = "./hostname.out"
}

resource "null_resource" "upgrade-sentry-db" {
  depends_on = ["docker_container.postgres-container", "docker_container.redis-container"]

  provisioner "local-exec" {
    command = "docker run --rm -e SENTRY_SECRET_KEY='${data.local_file.sentry-key.content}' --link sentry-postgres:postgres --link sentry-redis:redis sentry upgrade --noinput"
  }
}

resource "null_resource" "create-sentry-superuser" {
  depends_on = ["null_resource.upgrade-sentry-db"]

  provisioner "local-exec" {
    command = "docker run --rm -e SENTRY_SECRET_KEY='${data.local_file.sentry-key.content}' --link sentry-postgres:postgres --link sentry-redis:redis sentry createuser --email ${var.user-email} --password ${var.user-password} --superuser"
  }
}

########################################################
##    Final containers, these will run the service
########################################################

resource "docker_container" "sentry-container" {
  name  = "${var.sentry-container}"
  image = "${docker_image.sentry-image.latest}"
  env   = ["SENTRY_SECRET_KEY='${data.local_file.sentry-key.content}'"]

  ports = {
    internal = "9000"
    external = "${var.sentry-webport}"
  }

  links      = ["${docker_container.redis-container.name}:${docker_image.redis-image.name}", "${docker_container.postgres-container.name}:${docker_image.postgres-image.name}"]
  depends_on = ["null_resource.create-sentry-superuser"]
}

resource "docker_container" "sentry-cron-container" {
  name    = "${var.cron-container}"
  image   = "${docker_image.sentry-image.latest}"
  env     = ["SENTRY_SECRET_KEY='${data.local_file.sentry-key.content}'"]
  links   = ["${docker_container.redis-container.name}:${docker_image.redis-image.name}", "${docker_container.postgres-container.name}:${docker_image.postgres-image.name}"]
  command = ["run", "cron"]
}

resource "docker_container" "sentry-worker-container" {
  name    = "${var.worker-container}"
  image   = "${docker_image.sentry-image.latest}"
  env     = ["SENTRY_SECRET_KEY='${data.local_file.sentry-key.content}'"]
  links   = ["${docker_container.redis-container.name}:${docker_image.redis-image.name}", "${docker_container.postgres-container.name}:${docker_image.postgres-image.name}"]
  command = ["run", "worker"]
}

#######################################################################
##   Final settings for the site to run wihtout config screen at start
#######################################################################

resource "null_resource" "set-sentry-urlprefix" {
  depends_on = ["docker_container.sentry-container"]

  provisioner "local-exec" {
    command = "docker run --rm -e SENTRY_SECRET_KEY='${data.local_file.sentry-key.content}' --link sentry-postgres:postgres --link sentry-redis:redis sentry config set system.url-prefix http://${data.local_file.host-name.content}"
  }
}

resource "null_resource" "set-sentry-adminemail" {
  depends_on = ["docker_container.sentry-container"]

  provisioner "local-exec" {
    command = "docker run --rm -e SENTRY_SECRET_KEY='${data.local_file.sentry-key.content}' --link sentry-postgres:postgres --link sentry-redis:redis sentry config set system.admin-email ${var.user-email}"
  }
}

resource "null_resource" "set-sentry-allowregistration" {
  depends_on = ["docker_container.sentry-container"]

  provisioner "local-exec" {
    command = "docker run --rm -e SENTRY_SECRET_KEY='${data.local_file.sentry-key.content}' --link sentry-postgres:postgres --link sentry-redis:redis sentry config set auth.allow-registration True"
  }
}

resource "null_resource" "set-sentry-beaconanonymous" {
  depends_on = ["docker_container.sentry-container"]

  provisioner "local-exec" {
    command = "docker run --rm -e SENTRY_SECRET_KEY='${data.local_file.sentry-key.content}' --link sentry-postgres:postgres --link sentry-redis:redis sentry config set beacon.anonymous True"
  }
}
