resource "aws_instance" "instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  user_data     = var.user_data
  monitoring    = var.monitoring
  private_ip    = var.private_ip

  tags = {
    Name = var.name
  }

  vpc_security_group_ids = var.sg_ids

  volume_tags = {
    Name = var.name
  }
}

resource "null_resource" "provisioners" {
  triggers = {
    ts = "${timestamp()}"
  }

  provisioner "file" {
    source      = var.path_to_keys
    destination = "/tmp/"
    connection {
      type  = "ssh"
      host  = "${aws_instance.instance.public_ip}"
      user  = var.user
      agent = true
    }
  }

  provisioner "file" {
    source      = var.path_to_hosts
    destination = "/tmp/hosts"
    connection {
      type  = "ssh"
      host  = "${aws_instance.instance.public_ip}"
      user  = var.user
      agent = true
    }
  }

  provisioner "file" {
    source      = "${var.root_path}/files/ceph.repo"
    destination = "/tmp/ceph.repo"
    connection {
      type  = "ssh"
      host  = "${aws_instance.instance.public_ip}"
      user  = var.user
      agent = true
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/keys/id_rsa /home/centos/.ssh/id_rsa",
      "sudo chmod 600 /home/centos/.ssh/id_rsa",
      "sudo chown centos:centos /home/centos/.ssh/id_rsa",
      "sudo cat /tmp/keys/id_rsa.pub >> /home/centos/.ssh/authorized_keys",
      "sudo cp /tmp/hosts /etc/hosts",
      "sudo cp /tmp/ceph.repo /etc/yum.repos.d/ceph.repo",
      "sudo rpm --import 'https://download.ceph.com/keys/release.asc'",
      "sudo yum install epel-release -y",
      "sudo yum install ceph -y",
    ]
    connection {
      type  = "ssh"
      host  = "${aws_instance.instance.public_ip}"
      user  = var.user
      agent = true
    }
  }
}
