variable "secret_key" {}

variable "access_key" {}

variable "region" {
  default = "us-west-2"
}

provider "aws" {
  region     = "${var.region}"
  secret_key = "${var.secret_key}"
  access_key = "${var.access_key}"
}

module "web" {
  source = "../../tf/bcde.li"
}
