output "ec2_details" {
  value = aws_instance.mediawiki.*.public_ip
}
