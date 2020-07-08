data aws_caller_identity "current" {

}

data aws_region "current" {

}

data aws_iam_policy_document "event_assume" {
  count = var.enable ? 1 : 0
  statement {
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
  }
}

data aws_iam_policy_document "event" {
  count = var.enable ? 1 : 0
  statement {
    effect    = "Allow"
    actions   = ["ssm:StartAutomationExecution"]
    resources = ["*"]
  }
  statement {
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = [aws_iam_role.ssm_automation[0].arn]
  }
}

data aws_iam_policy_document "ssm_automation_assume" {
  count = var.enable ? 1 : 0
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }
  }
}

data aws_iam_policy_document "ssm_automation" {
  count = var.enable ? 1 : 0
  statement {
    effect = "Allow"
    actions = [
      "rds:StopDB*",
      "rds:StartDB*",
      "rds:DescribeDBInstances"
    ]
    resources = ["*"]
  }
}