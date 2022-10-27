# AWS ECS Worker Terraform Module for Rose Gold

Terraform module which manages [AWS ECS services](https://docs.aws.amazon.com/ecs/index.html) for the Rose Gold platform that run as workers (i.e, that do not expose HTTP/HTTPS endpoints and typically pull workloads from a queue).

## Usage

```json
module "ecs_service" {
  source = "git@github.com:cbdr/terraform-aws-ecs-worker-rg?ref=<TAG>"
  […]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 3.61 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application | The application name (Short, lower case, dash as word separator) | `string` | n/a | yes |
| cluster\_override | The name of a cluster to use instead of the default one | `string` | `""` | no |
| container\_port | The port the application listens on | `number` | `8080` | no |
| cpu | The number of CPU share each task will reserve (1 CPU = 1024 shares) | `number` | n/a | yes |
| cpu\_evaluation\_periods | The number of periods over which data is compared to the specified threshold | `number` | `3` | no |
| cpu\_period | The amount of time, in seconds, that is considered to evaluate the scale-in and scale-out rules | `number` | `60` | no |
| data\_confidentiality | The level of confidentiality for the data processed by the application | `string` | `"Internal Use Only"` | no |
| drain\_time | The amount of time, in seconds, for the load balancer to wait before changing the state of a deregistering target from draining to unused | `number` | `30` | no |
| environment | The code for the environment the service runs in | `string` | n/a | yes |
| high\_cpu\_threshold | The value against which the specified statistic is compared | `number` | `50` | no |
| iam\_statements | The statements to add to the IAM role for the service | `list(any)` | `[]` | no |
| low\_cpu\_threshold | The value against which the specified statistic is compared | `number` | `15` | no |
| max\_capacity | The maximum number of tasks for the service | `number` | n/a | yes |
| memory | The amount of memory, in MB, reserved for each task | `number` | n/a | yes |
| min\_capacity | The minimum number of tasks for the service | `number` | n/a | yes |
| scale\_in\_adjustment | The number of tasks to stop, when the low CPU threshold is breached | `number` | `-1` | no |
| scale\_in\_cooldown | The amount of time, in seconds, after a scale-in activity completes and before the next scaling activity can start | `number` | `60` | no |
| scale\_out\_cooldown | The amount of time, in seconds, after a scale-out activity completes and before the next scaling activity can start | `number` | `60` | no |
| scale\_out\_percent\_adjustment | The percentage of tasks by which to scale, when the high CPU threshold is breached (ie A value of 100 will double the number of tasks) | `number` | `100` | no |
| task\_definition\_file | Path to the task-definition.json file from the root Terraform module | `string` | `"task-definition.json"` | no |
| team | The 2 or 3-letter alias for the team name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ecs-task-role | n/a |
<!-- END_TF_DOCS -->
