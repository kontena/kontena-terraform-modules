module "kontena_node_ignition_test" {
  source                = ".."
  master_uri            = "wss://TODO"
  grid_token            = "TODO"
  docker_opts           = "--label provider=TODO --label region=TODO --label az=TODO --label ephemeral=yes"
  overlay_version       = "overlay"
  peer_interface        = "ens4v1"
  main_interface_prefix = "ens4v"
  dns_server            = "169.254.169.254"
}

output "ignition" {
  value = "${module.kontena_node_ignition_test.rendered}"
}
