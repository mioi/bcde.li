resource "template_file" "userdata" {
  template = "${file("${path.module}/../../tf/bcde.li/userdata.sh")}"
}

resource "aws_instance" "sft-win-vm" {
  count                  = "${var.instances}"
  ami                    = "ami-52aee332"
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
