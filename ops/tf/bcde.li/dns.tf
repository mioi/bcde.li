resource "aws_route53_zone" "main" {
  name = "bcde.li"
}

resource "aws_route53_record" "ns" {
    zone_id = "${aws_route53_zone.main.zone_id}"
    name = "bcde.li"
    type = "NS"
    ttl = "30"
    records = [
        "${aws_route53_zone.main.name_servers.0}",
        "${aws_route53_zone.main.name_servers.1}",
        "${aws_route53_zone.main.name_servers.2}",
        "${aws_route53_zone.main.name_servers.3}"
    ]
}

resource "aws_route53_record" "main" {
    zone_id = "${aws_route53_zone.main.zone_id}"
    name = "bcde.li"
    type = "A"
    alias {
      name = "${aws_elb.web_elb.dns_name}"
      zone_id = "${aws_elb.web_elb.zone_id}"
      evaluate_target_health = true
    }
}

resource "aws_route53_record" "www" {
    zone_id = "${aws_route53_zone.main.zone_id}"
    name = "www.bcde.li"
    type = "CNAME"
    ttl = "300"
    records = ["${aws_route53_record.main.fqdn}"]
}
