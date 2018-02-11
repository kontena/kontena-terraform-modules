# Kontena Node (Agent) CoreOS Container Linux Ignition


## Usage

```
module "kontena_node_ignition" {
  source = "github.com/kontena/kontena-terraform-modules/modules/node-ignition"
  master_uri = "${var.master_uri}"
  grid_token = "${var.grid_token}"
  docker_opts = "${var.docker_opts}"
  dns_server = "${var.dns_server}"
  peer_interface = "${var.peer_interface}"
  main_interface_prefix = "${var.main_interface_prefix}"
}

resource "aws_instance" "kontena_node" {
  ...
  user_data = "${module.kontena_node_ignition.rendered}"
  ...
}

resource "google_compute_instance" "kontena_node" {
  ...
  metadata {
    user-data = "${module.kontena_node_ignition.rendered}"
  }
  ...
}
```

## Disks and filesystems

`ignition_disk` and `ignition_filesystem` like these:

```
data "ignition_disk" "sda" {
  device     = "/dev/sda"
  wipe_table = true

  partition {
    label = "ROOT"
  }
}

data "ignition_filesystem" "root" {
  name = "ROOT"

  mount {
    device = "/dev/sda1"
    format = "ext4"

    wipe_filesystem = true
    options         = ["-L", "ROOT"]
  }
}
```

Can be passed through with:

```
  ignition_disks = [
    "${data.ignition_disk.sda.id}",
  ]
  ignition_filesystems = [
    "${data.ignition_filesystem.root.id}",
  ]
```

## Testing

    $ cd test && terraform init && terraform apply