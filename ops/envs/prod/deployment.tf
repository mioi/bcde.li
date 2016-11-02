variable "secret_key" {}

variable "access_key" {}

variable "region" {
  default = "us-west-2"
}

variable "azs" {
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

provider "aws" {
  region     = "${var.region}"
  secret_key = "${var.secret_key}"
  access_key = "${var.access_key}"
}

module "web" {
  source = "../../tf/bcde.li"
  azs = ["${var.azs}"]
}
