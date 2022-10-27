# From main.tf

variable "sqsVisibilityTimeout" {
  description = "the visibility timeout for the queue. An integer from 0 to 43200 (12 hours)"
  default     = 30
  type        = number
}


variable "resourceName" {
  description = "name of worker"
  default     = ""
  type        = string
}

variable "shortApplication" {
  description = "2 or 3 letter abbrevition of application"
  default     = ""
  type        = string
}

variable "startCommand" {
  description = "start command for docker"
  default     = ""
  type        = string
}

variable "application" {
  description = "The application name (Short, lower case, dash as word separator)"
  type        = string
}

variable "environment" {
  description = "The code for the environment the service runs in"
  type        = string
}

variable "cpu" {
  description = "The number of CPU share each task will reserve (1 CPU = 1024 shares)"
  type        = number
}

variable "max_capacity" {
  description = "The maximum number of tasks for the service"
  type        = number
}

variable "memory" {
  description = "The amount of memory, in MB, reserved for each task"
  type        = number
}

variable "min_capacity" {
  description = "The minimum number of tasks for the service"
  type        = number
}

variable "cluster_override" {
  default     = ""
  description = "The name of a cluster to use instead of the default one"
  type        = string
}

variable "container_port" {
  default     = 8080
  description = "The port the application listens on"
  type        = number
}

variable "cpu_evaluation_periods" {
  default     = 3
  description = "The number of periods over which data is compared to the specified threshold"
  type        = number
}

variable "cpu_period" {
  default     = 60
  description = "The amount of time, in seconds, that is considered to evaluate the scale-in and scale-out rules"
  type        = number
}

variable "data_confidentiality" {
  default     = "Internal Use Only"
  description = "The level of confidentiality for the data processed by the application"
  type        = string
}

variable "drain_time" {
  default     = 30
  description = "The amount of time, in seconds, for the load balancer to wait before changing the state of a deregistering target from draining to unused"
  type        = number
}

variable "high_ratio_threshold" {
  default     = 25
  description = "The value against which the specified statistic is compared"
  type        = number
}

variable "low_ratio_threshold" {
  default     = 15
  description = "The value against which the specified statistic is compared"
  type        = number
}

variable "iam_statements" {
  default     = []
  description = "The statements to add to the IAM role for the service"
  type        = list(any)
}

variable "scale_in_adjustment" {
  default     = -1
  description = "The number of tasks to stop, when the low CPU threshold is breached"
  type        = number
}

variable "scale_in_cooldown" {
  default     = 60
  description = "The amount of time, in seconds, after a scale-in activity completes and before the next scaling activity can start"
  type        = number
}

variable "scale_out_cooldown" {
  default     = 60
  description = "The amount of time, in seconds, after a scale-out activity completes and before the next scaling activity can start"
  type        = number
}

variable "scale_out_adjustment" {
  default     = 1
  description = "The number of tasks to stop, when the low CPU threshold is breached"
  type        = number
}

variable "task_definition_file" {
  default     = "task-definition.json"
  description = "Path to the task-definition.json file from the root Terraform module"
  type        = string
}

variable "team" {
  default = "mando"
  description = "The 2 or 3-letter alias for the team name"
  type        = string
}

variable "max_receive_count_dlq" {
  default     = 10
  description = "The number of messages max to send to dlq"
  type        = number
}

variable "fifo_queue" {
  default     = false
  description = "Sqs queue type standard or fifo"
  type        = bool
}

variable "content_based_deduplication" {
  default = true
  description = "(Optional) Enables content-based deduplication for FIFO queues"
  type = bool
}
