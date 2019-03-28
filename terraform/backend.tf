terraform {
  backend "s3" {
    bucket = "terraform-bruno"
    key    = "track_coins/terraform.tfstate"
    region = "us-east-1"
  }
}
