variable "master_uri" {
	description = "Kontena Master URI"
}
variable "grid_token" {
	description = "Kontena Grid token"
}
variable "peer_interface" {
	default = "eth1"
	description = "Network interface that is used for intra-datacenter communication"
}
variable "supernet" {
	default = "10.81.0.0/16"
}
variable "docker_opts" {
	description = "Docker Engine options"
	default = ""
}