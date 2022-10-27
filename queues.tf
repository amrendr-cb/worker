resource "aws_sqs_queue" "dead_letter_queue" {
  delay_seconds                     = 0
  fifo_queue                        = local.fifo_queue
  max_message_size                  = 262144
  message_retention_seconds         = 864000
  content_based_deduplication       = (local.fifo_queue ? local.content_based_deduplication: false )
  name                              = (local.fifo_queue ? "${local.appname}-deadletterqueue.fifo" : "${local.appname}-deadletterqueue")
  receive_wait_time_seconds         = 0
  visibility_timeout_seconds        = local.sqsVisibilityTimeout
}

resource "aws_sqs_queue" "queue" {
  delay_seconds                     = 0
  fifo_queue                        = local.fifo_queue
  max_message_size                  = 262144
  message_retention_seconds         = 345600
  content_based_deduplication       = (local.fifo_queue ? local.content_based_deduplication: false )
  name                              = (local.fifo_queue ? "${local.appname}-queue.fifo" : "${local.appname}-queue")
  redrive_policy                    = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.dead_letter_queue.arn}\",\"maxReceiveCount\":${var.max_receive_count_dlq}}"  
  receive_wait_time_seconds         = 0
  visibility_timeout_seconds        = local.sqsVisibilityTimeout
}

resource "aws_sqs_queue_policy" "policy" {
  queue_url = aws_sqs_queue.queue.id

  policy = <<POLICY
  {
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__owner_statement",
      "Effect": "Allow",
      "Principal": "*", 
      "Action": [
        "sqs:SendMessage"
      ],
      "Resource": "${aws_sqs_queue.queue.arn}"
    }
  ]
}
POLICY
}
