resource "aws_budgets_budget" "global_budget" {
  name = "$1 Budget"

  budget_type  = "COST"
  limit_amount = "1.0"
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator = "GREATER_THAN"
    notification_type   = "ACTUAL"
    subscriber_email_addresses = [
      "bradyharper11@googlemail.com",
    ]
    threshold      = 0.6
    threshold_type = "ABSOLUTE_VALUE"
  }
}
