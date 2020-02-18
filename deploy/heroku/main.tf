provider "heroku" {}

variable "app-name" {
  type = "string"
}

variable "app-version" {
  type = "string"
}

variable "database-plan" {
  type = "string"
  default = "peakon-dev"
}

variable "region" {
  type = "string"
  default = "us"
}

variable "github-client-id" {
  type = "string"
}

variable "github-client-secret" {
  type = "string"
}

variable "github-redirect-uri" {
  type = "string"
}

variable "secret-key" {
  type = "string"
}

variable "git-url" {
  type = "string"
  default = "git@github.com:eyablokov/node-postgre-starter.git"
}

resource "heroku_app" "app" {
    name = "${var.app-name}"
    region = "${var.region}"

    # PORT, DATABASE_URI are injected by heroku
    config_vars {
        SECRET_KEY = "${var.secret-key}"
        GITHUB_CLIENT_ID = "${var.github-client-id}"
        GITHUB_CLIENT_SECRET = "${var.github-client-secret}"
        GITHUB_REDIRECT_URI = "${var.github-redirect-uri}"
    }

    buildpacks = [
      # Here I'm not sure. maybe we should build own buildpack
      "heroku/nodejs",
    ]
}

resource "heroku_build" "app" {
  app = "${heroku_app.app.id}"

  source = {
    # Set buildpack in `buildpacks` above. As mentioned above, create own buildpack.
    url = "https://github.com/eyablokov/node-postgre-starter/archive/${var.app-version}.tar.gz"
    version = "${var.app-version}"
  }
}

# I guess, it could be possible to use Heroku DB pg, not sure.
resource "heroku_addon" "database" {
  app  = "${heroku_app.app.name}"
  plan = "heroku-postgresql:${var.database-plan}"
}
