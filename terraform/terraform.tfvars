####################################################
###            Custom values
###     Change values based on your environment
####################################################

# Docker images needed
redis-image = "redis"
postgres-image = "postgres"
sentry-image = "sentry"

# Redis settings
redis-container = "sentry-redis"

# Postgres settings
postgres-container = "sentry-postgres"
postgresPass = "secret"
postgresUser = "sentry"

# Sentry services
sentry-container = "my-sentry"
cron-container = "sentry-cron"
worker-container = "sentry-worker"
upgrade-sentry-db-container = "upgrade-sentry-db"

# Sentry settings
create-sentry-superuser = "create-sentry-superuser"
sentry-webport = 80
user-email = "user@mail.com"
user-password = "Pa55word"
