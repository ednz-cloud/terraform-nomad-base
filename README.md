terraform-nomad-base
=========

Terraform module to deploy nomad jobs. Optionally, this module can deploy csi volumes, consul kv, and consul intentions associated to the job(s).
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_consul"></a> [consul](#provider\_consul) | n/a |
| <a name="provider_nomad"></a> [nomad](#provider\_nomad) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [consul_intention.this](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/resources/intention) | resource |
| [consul_key_prefix.this](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/resources/key_prefix) | resource |
| [nomad_external_volume.this](https://registry.terraform.io/providers/hashicorp/nomad/latest/docs/resources/external_volume) | resource |
| [nomad_job.this](https://registry.terraform.io/providers/hashicorp/nomad/latest/docs/resources/job) | resource |
| [nomad_volume.this](https://registry.terraform.io/providers/hashicorp/nomad/latest/docs/resources/volume) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_consul_intentions"></a> [consul\_intentions](#input\_consul\_intentions) | List of intentions associated with the job(s) | <pre>map(object({<br>    source_name      = string<br>    destination_name = string<br>    action           = string<br>  }))</pre> | `{}` | no |
| <a name="input_consul_kv"></a> [consul\_kv](#input\_consul\_kv) | List key/value pairs to put at a specific prefix (mainly for traefik) | `map(any)` | `{}` | no |
| <a name="input_jobs"></a> [jobs](#input\_jobs) | The list of jobs to deploy | `map(string)` | `{}` | no |
| <a name="input_nfs_volumes"></a> [nfs\_volumes](#input\_nfs\_volumes) | List of nfs volumes associated to the job(s) | <pre>map(object({<br>    type       = string<br>    plugin_id  = string<br>    namespace  = string<br>    capability = map(string)<br>    context    = map(string)<br>    mount_options = object({<br>      fs_type     = string<br>      mount_flags = list(string)<br>    })<br>  }))</pre> | `{}` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | List of volumes associated to the job(s) | <pre>map(object({<br>    type         = string<br>    plugin_id    = string<br>    namespace    = string<br>    capacity_min = string<br>    capacity_max = string<br>    capability   = map(string)<br>    parameters   = map(string)<br>    secrets      = map(string)<br>  }))</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->