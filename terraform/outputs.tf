####################################################
##                 Outputs
####################################################

output "Sentry host server" {
    value = "${format("http://%s:%s",chomp(data.local_file.host-name.content), var.sentry-webport)}"
}

output "Login credentials" {
    value = "${format("%s / %s", var.user-email, var.user-password)}"
}
