# main file for terraform-nomad-base
resource "nomad_job" "this" {
  for_each = var.jobs
  depends_on = [
    nomad_csi_volume.this,
    nomad_csi_volume_registration.this,
    consul_key_prefix.this,
    consul_intention.this
  ]

  jobspec          = try(file(each.value), each.value)
  purge_on_destroy = true
  hcl2 {
    allow_fs = true
    vars     = contains(keys(var.jobs_variables), each.key) ? var.jobs_variables[each.key] : {}
  }
}

resource "nomad_csi_volume" "this" {
  for_each = var.volumes

  volume_id    = each.key
  name         = each.key
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

resource "nomad_csi_volume_registration" "this" {
  for_each = var.nfs_volumes

  volume_id   = each.key
  external_id = each.key
  name        = each.key
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
