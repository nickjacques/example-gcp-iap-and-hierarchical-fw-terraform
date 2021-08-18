resource "random_string" "random" {
  length = 6
  lower = true
  upper = false
  special = false
  number = true
}