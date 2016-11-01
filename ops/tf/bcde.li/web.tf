resource "template_file" "userdata" {
  template = "${file("${path.module}/../../tf/bcde.li/userdata.sh")}"

  vars {
    altname = "web-${count.index}"
  }
}

resource "aws_instance" "web" {
  count                  = 1
  ami                    = "ami-a9d276c9"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  source_dest_check      = false
  user_data              = "${template_file.userdata.rendered}"

  tags = {
    Name = "web-${count.index}"
  }

  lifecycle {
    ignore_changes = ["user_data"]
  }
}

output "public_ip" {
  value = "${aws_instance.web.public_ip}"
}
