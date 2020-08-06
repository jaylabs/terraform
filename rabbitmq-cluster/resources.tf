resource "aws_ebs_volume" "rabbitmq-data" {
  count             = var.instance_count
  availability_zone = element(var.az_ids, count.index)
  size              = 10
  type              = "gp2"

  tags = {
    Name = "${var.instance_name}-node-${count.index + 1}-data"
  }
}

resource "aws_ebs_volume" "rabbitmq-logs" {
  count             = var.instance_count
  availability_zone = element(var.az_ids, count.index)
  size              = 10
  type              = "gp2"

  tags = {
    Name = "${var.instance_name}-node-${count.index + 1}-logs"
  }
}

resource "aws_volume_attachment" "ebs-att-rabbitmq-data" {
  count       = var.instance_count
  device_name = "/dev/sdd"
  volume_id   = element(aws_ebs_volume.rabbitmq-data.*.id, count.index)
  instance_id = element(aws_instance.rabbitmq.*.id, count.index)
}

resource "aws_volume_attachment" "ebs-att-rabbitmq-logs" {
  count       = var.instance_count
  device_name = "/dev/sdl"
  volume_id   = element(aws_ebs_volume.rabbitmq-logs.*.id, count.index)
  instance_id = element(aws_instance.rabbitmq.*.id, count.index)
}

resource "aws_instance" "rabbitmq" {
  count             = var.instance_count
  ami               = var.amis["ami-ubuntu-us-east-1"]
  instance_type     = var.instance_type
  availability_zone = element(var.az_ids, count.index)
  key_name          = var.key-jaylabs-dev
  subnet_id         = element(var.subnet_ids, count.index)
  tags = {
    Name        = "${var.instance_name}-node-${count.index + 1}"
    Environment = var.environment
    Region      = var.region
    Service     = "rabbitmq"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  root_block_device {
    volume_size           = 20
    volume_type           = "gp2"
    iops                  = 100
    encrypted             = false
    delete_on_termination = true
  }

  vpc_security_group_ids = [
    var.sg-jaylabs-dev
  ]

  connection {
    bastion_private_key = file(var.private_key)
    bastion_user        = "admin"
    bastion_host        = var.bastion_address

    private_key = file(var.private_key)
    user        = var.ansible_user
    host        = self.private_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 10",
      "sudo hostnamectl set-hostname ${var.instance_name}-node-${count.index + 1}.jaylabs.io",
      "sudo apt-get -qq update -y",
      "sudo apt-get -qq install python -y"
    ]
  }
}

resource "aws_route53_record" "rabbitmq-cluster-records" {
  zone_id = "AAAAAAAAAAAAAA"
  name    = var.dns_address
  type    = "A"
  ttl     = "10"
  records = aws_instance.rabbitmq.*.private_ip
}

resource "aws_route53_record" "rabbitmq-node-records" {
  zone_id = "AAAAAAAAAAAAAA"
  count   = var.instance_count
  name    = "${var.instance_name}-node-${count.index + 1}.dev.jaylabs.io"
  type    = "CNAME"
  ttl     = "10"
  records = ["${aws_instance.rabbitmq.*.private_dns[count.index]}"]
}

resource "null_resource" "rabbitmq-ansible" {
  # # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    cluster_instance_ids = "${join(",", aws_instance.rabbitmq.*.id)}"
  }

  # # Bootstrap script can run on any instance of the cluster
  connection {
    host        = element(aws_instance.rabbitmq.*.private_ip, 0)
    private_key = file(var.private_key)
    user        = var.ansible_user

    bastion_host        = var.bastion_address
    bastion_private_key = file(var.private_key)
    bastion_user        = "admin"
  }

  provisioner "local-exec" {
    # Ansible playbooks called with private_ip of each node in the clutser
    command = <<EOT
    >playbooks/rabbitmq-nodes;
	  echo "[rabbitmq]" | tee -a playbooks/rabbitmq-nodes;
    echo ${lookup(aws_instance.rabbitmq.*.tags[0], "Name")} ansible_host=${element(aws_instance.rabbitmq.*.private_ip, 0)} | tee -a playbooks/rabbitmq-nodes;
    echo ${lookup(aws_instance.rabbitmq.*.tags[1], "Name")} ansible_host=${element(aws_instance.rabbitmq.*.private_ip, 1)} | tee -a playbooks/rabbitmq-nodes;
    ansible-playbook -i playbooks/rabbitmq-nodes -u ${var.ansible_user} --private-key ${var.private_key} playbooks/main.yml;
    EOT
  }
}