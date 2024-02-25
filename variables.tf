# variables file for terraform-nomad-base
variable "jobs" {
  type        = map(string)
  description = "The list of jobs to deploy"
  default     = {}
}

variable "jobs_variables" {
  type        = map(map(string))
  default     = {}
  description = "Map of object to pass variables to the nomad job(s). Key is the job's name, value is a map of variables and their values"
}

variable "volumes" {
  type = map(object({
    plugin_id    = string
    namespace    = string
    capacity_min = string
    capacity_max = string
    capability   = map(string)
    parameters   = map(string)
    secrets      = map(string)
  }))
  description = "List of volumes associated to the job(s)"
  default     = {}
}

variable "nfs_volumes" {
  type = map(object({
    plugin_id  = string
    namespace  = string
    capability = map(string)
    context    = map(string)
    mount_options = object({
      fs_type     = string
      mount_flags = list(string)
    })
  }))
  description = "List of nfs volumes associated to the job(s)"
  default     = {}
}

variable "consul_kv" {
  type        = map(any)
  description = "List key/value pairs to put at a specific prefix (mainly for traefik)"
  default     = {}
}

variable "consul_intentions" {
  type = map(object({
    source_name      = string
    destination_name = string
    action           = string
  }))
  description = "List of intentions associated with the job(s)"
  default     = {}
}
