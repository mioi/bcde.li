variable "azs" {
  type = "list"
}

resource "aws_elb" "web_elb" {
  name = "web-elb"
  availability_zones = ["${var.azs}"]

  listener {
    instance_port = 443
    instance_protocol = "tcp"
    lb_port = 443
    lb_protocol = "tcp"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "TCP:443"
    interval = 60
  }

  instances = ["${aws_instance.web.id}"]
  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  tags {
    Name = "web-elb"
  }
}
