<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

No requirements.

### Providers

| Name | Version |
|------|---------|
| <a name="provider_consul"></a> [consul](#provider_consul) | n/a |
| <a name="provider_nomad"></a> [nomad](#provider_nomad) | n/a |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [consul_intention.this](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/resources/intention) | resource |
| [consul_key_prefix.this](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/resources/key_prefix) | resource |
| [nomad_csi_volume.this](https://registry.terraform.io/providers/hashicorp/nomad/latest/docs/resources/csi_volume) | resource |
| [nomad_csi_volume_registration.this](https://registry.terraform.io/providers/hashicorp/nomad/latest/docs/resources/csi_volume_registration) | resource |
| [nomad_job.this](https://registry.terraform.io/providers/hashicorp/nomad/latest/docs/resources/job) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_consul_intentions"></a> [consul_intentions](#input_consul_intentions) | List of intentions associated with the job(s) | <pre>map(object({<br>    source_name      = string<br>    destination_name = string<br>    action           = string<br>  }))</pre> | `{}` | no |
| <a name="input_consul_kv"></a> [consul_kv](#input_consul_kv) | List key/value pairs to put at a specific prefix (mainly for traefik) | `map(any)` | `{}` | no |
| <a name="input_jobs"></a> [jobs](#input_jobs) | The list of jobs to deploy | `map(string)` | `{}` | no |
| <a name="input_jobs_variables"></a> [jobs_variables](#input_jobs_variables) | Map of object to pass variables to the nomad job(s). Key is the job's name, value is a map of variables and their values | `map(map(string))` | `{}` | no |
| <a name="input_nfs_volumes"></a> [nfs_volumes](#input_nfs_volumes) | List of nfs volumes associated to the job(s) | <pre>map(object({<br>    plugin_id  = string<br>    namespace  = string<br>    capability = map(string)<br>    context    = map(string)<br>    mount_options = object({<br>      fs_type     = string<br>      mount_flags = list(string)<br>    })<br>  }))</pre> | `{}` | no |
| <a name="input_volumes"></a> [volumes](#input_volumes) | List of volumes associated to the job(s) | <pre>map(object({<br>    plugin_id    = string<br>    namespace    = string<br>    capacity_min = string<br>    capacity_max = string<br>    capability   = map(string)<br>    parameters   = map(string)<br>    secrets      = map(string)<br>  }))</pre> | `{}` | no |

### Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
