resource "google_service_account" "terraform_sa" {
  account_id   = "${var.env}-terraform"
  display_name = "Terraform Service Account for ${var.env}"
}

# Assign IAM roles to this service account
resource "google_project_iam_member" "terraform_roles" {
  for_each = toset(var.roles)
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.terraform_sa.email}"
}
