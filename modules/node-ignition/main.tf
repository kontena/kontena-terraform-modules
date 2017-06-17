data "template_file" "kontena_agent_env" {
  template = "${file("${path.module}/files/kontena-agent.env")}"
  vars {
    kontena_uri = "${var.master_uri}"
    kontena_token = "${var.grid_token}"
	kontena_peer_interface = "${var.peer_interface}"
  }
}

data "ignition_file" "kontena_agent" {
  filesystem = "root"
  path = "/etc/kontena-agent.env"
  content = {
    content = "${data.template_file.kontena_agent_env.rendered}"
  }
}

data "template_file" "kontena_dropin" {
  template = "${file("${path.module}/systemd/50-kontena.conf")}"
  vars {
	supernet = "${var.supernet}"
	docker_opts = "${var.docker_opts}"
  }
}

data "ignition_systemd_unit" "kontena_dropin" {
  name = "docker.service"
  dropin {
    name = "50-kontena.conf"
    content = "${data.template_file.kontena_dropin.rendered}"
  }
}

data "ignition_networkd_unit" "zz_default" {
  name = "zz-default.network"
  content = "${file("${path.module}/networkd/zz-default.network")}"
}

data "ignition_networkd_unit" "50_weave" {
  name = "50-weave.network"
  content = "${file("${path.module}/networkd/50-weave.network")}"
}

data "ignition_systemd_unit" "etcd2" {
  name = "etcd2.service"
  content = "${file("${path.module}/systemd/etcd2.service")}"
}

data "ignition_systemd_unit" "kontena_agent" {
  name = "kontena-agent.service"
  content = "${file("${path.module}/systemd/kontena-agent.service")}"
}

data "ignition_config" "default" {
  systemd = [
    "${data.ignition_systemd_unit.kontena_dropin.id}",
    "${data.ignition_systemd_unit.kontena_agent.id}",
    "${data.ignition_systemd_unit.etcd2.id}"

  ]
  networkd = [
    "${data.ignition_networkd_unit.zz_default.id}",
    "${data.ignition_networkd_unit.50_weave.id}"
  ]
  files = [
    "${data.ignition_file.kontena_agent.id}"
  ]
}