terraform {
  backend "gcs" {
    bucket = "tfstate-rith-ha-k8s-prod"
    prefix = "ha-cluster"
  }
}
