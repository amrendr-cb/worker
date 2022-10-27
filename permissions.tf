resource "aws_iam_role" "task_role" {
  name = "${var.team}-${var.shortApplication}-${var.resourceName}-${var.environment}-task"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "task_role_policy" {
  name   = "${var.team}-${var.application}-${var.environment}-task-role"
  policy = length(var.iam_statements) > 0 ? data.aws_iam_policy_document.combined_task_role_policy_document.json : data.aws_iam_policy_document.default_task_role_policy_document.json
  role   = aws_iam_role.task_role.id
}

data "aws_iam_policy_document" "combined_task_role_policy_document" {
  source_policy_documents = [
    data.aws_iam_policy_document.default_task_role_policy_document.json,
    data.aws_iam_policy_document.optional_task_role_policy_document.json
  ]
}

data "aws_iam_policy_document" "optional_task_role_policy_document" {
  statement {
    actions   = length(var.iam_statements) > 0 ? var.iam_statements[0]["actions"] : []
    resources = length(var.iam_statements) > 0 ? var.iam_statements[0]["resources"] : []
    sid       = "AdditionalPermissions"
  }
}

data "aws_iam_policy_document" "default_task_role_policy_document" {
  statement {
    actions = [
      "application-autoscaling:*",
      "autoscaling:Describe*",
      "cloudwatch:*",
      "ec2:Describe*",
      "ecs:DescribeServices",
      "ecs:UpdateService",
      "logs:*",
      "sns:*",
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:SendMessage",
      "sqs:publish"
    ]

    resources = [
      "*",
    ]

    sid = "DefaultPermissions"
  }
}
