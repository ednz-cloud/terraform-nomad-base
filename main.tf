# main file for terraform-nomad-base
terraform {
  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = ">= 2.17.0"
    }
    nomad = {
      source  = "hashicorp/nomad"
      version = ">= 1.4.20, < 2.0.0"
    }
  }
}

resource "nomad_job" "this" {
  for_each = var.jobs
  depends_on = [
    nomad_external_volume.this,
    consul_key_prefix.this,
    # consul_config_entry.this
    consul_intention.this
  ]

  jobspec          = file("${each.value}")
  purge_on_destroy = true
  hcl2 {
    enabled  = true
    allow_fs = true
  }
}

resource "nomad_external_volume" "this" {
  for_each = var.volumes

  volume_id    = each.key
  name         = each.key
  type         = each.value.type
  plugin_id    = each.value.plugin_id
  namespace    = each.value.namespace
  capacity_min = each.value.capacity_min
  capacity_max = each.value.capacity_max
  capability {
    access_mode     = each.value.capability.access_mode
    attachment_mode = each.value.capability.attachment_mode
  }
  parameters = sensitive(each.value.parameters)
  secrets    = sensitive(each.value.secrets)
}

resource "nomad_volume" "this" {
  for_each = var.nfs_volumes

  volume_id   = each.key
  external_id = each.key
  name        = each.key
  type        = each.value.type
  plugin_id   = each.value.plugin_id
  namespace   = each.value.namespace
  capability {
    access_mode     = each.value.capability.access_mode
    attachment_mode = each.value.capability.attachment_mode
  }
  context = each.value.context
  mount_options {
    fs_type     = each.value.mount_options.fs_type
    mount_flags = each.value.mount_options.mount_flags
  }
}

resource "consul_key_prefix" "this" {
  for_each = var.consul_kv

  path_prefix = each.key
  subkeys     = each.value
}

resource "consul_intention" "this" {
  for_each = var.consul_intentions

  source_name      = each.value.source_name
  destination_name = each.value.destination_name
  action           = each.value.action
}