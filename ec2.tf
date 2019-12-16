resource "aws_instance" "side_effect_bastion" {
  ami = "${data.aws_ami.ubuntu.id}"
  availability_zone = "${aws_subnet.side_effect_public_subnet1.availability_zone}"
  instance_type = "t2.nano"
  key_name = "YOUR-KEY-PAIR-NAME"
  vpc_security_group_ids = [
    "${aws_default_security_group.side_effect_default.id}",
    "${aws_security_group.side_effect_bastion.id}"
  ]
  subnet_id = "${aws_subnet.side_effect_public_subnet1.id}"
  associate_public_ip_address = true

  tags {
    Name = "bastion"
  }
}

resource "aws_eip" "side_effect_bastion" {
  vpc = true
  instance = "${aws_instance.side_effect_bastion.id}"
  depends_on = ["aws_internet_gateway.side_effect_igw"]
}