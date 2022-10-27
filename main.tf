module "environment_info" {
  # Use the "main" branch as environment information will change
  # and it would be impractical to update this module
  # and all the applications using it every time.
  source          = "git@github.com:cbdr/terraform-environment-info" # tflint-ignore: terraform_module_pinned_source
  team            = var.team
  application     = var.application
  environment     = var.environment
}

locals {
  appname                     = "${var.team}-${var.shortApplication}-${var.resourceName}-${var.environment}"
  resourceName                = var.resourceName
  startCommand                = var.startCommand
  shortApplication            = var.shortApplication
  fifo_queue                  = var.fifo_queue
  sqsVisibilityTimeout        = var.sqsVisibilityTimeout
  content_based_deduplication = var.content_based_deduplication
}
