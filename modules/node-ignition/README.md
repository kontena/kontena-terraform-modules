# Kontena Node (Agent) CoreOS Container Linux Ignition


## Usage

```
module "kontena_node_ignition" {
  source = "github.com/kontena/kontena-terraform-modules/modules/node-ignition"
  master_uri = "${var.master_uri}"
  grid_token = "${var.grid_token}"
  docker_opts = "${var.docker_opts}"
}

resource "aws_instance" "kontena_node" {
  ...
  user_data = "${module.kontena_node_ignition.rendered}"
  ...
}
```
