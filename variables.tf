variable "master_uri" {
  description = "Kontena Master URI"
}

variable "grid_token" {
  description = "Kontena Grid token"
}

variable "peer_interface" {
  default     = "eth1"
  description = "Network interface that is used for intra-datacenter communication"
}

variable "main_interface_prefix" {
  default     = "eth1"
  description = "The main network interface to configure"
}

variable "dns_server" {
  default     = "169.254.169.253"
  description = "Network DNS server"
}

variable "supernet" {
  default = "10.81.0.0/16"
}

variable "docker_opts" {
  description = "Docker Engine options"
  default     = ""
}

variable "overlay_version" {
  description = "Docker overlay version"
  default     = "overlay2"
}

variable "ignition_disks" {
  description = "Ignition disk configs"
  default     = []
}

variable "ignition_filesystems" {
  description = "Ignition filesystems"
  default     = []
}

variable "authorized_keys_core" {
  description = "Authorized SSH keys for the user core"
  default     = []
}

variable "systemd_units" {
  description = "Additional Ignition systemd units"
  default     = []
}

variable "ignition_files" {
  description = "Additional Ignition files"
  default     = []
}
