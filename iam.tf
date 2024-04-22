resource "aws_iam_user" "ci" {
  name = "ci"
}

data "aws_iam_policy_document" "ci" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "ci" {
  name   = "CiAdminAccess"
  user   = aws_iam_user.ci.name
  policy = data.aws_iam_policy_document.ci.json
}

resource "aws_iam_access_key" "ci" {
  user = aws_iam_user.ci.name
}

resource "aws_ssm_parameter" "access_key" {
  name  = "ACCESS_KEY_ID"
  type  = "SecureString"
  value = aws_iam_access_key.ci.id
}

resource "aws_ssm_parameter" "secret_key" {
  name  = "SECRET_ACCESS_KEY"
  type  = "SecureString"
  value = aws_iam_access_key.ci.secret
}
