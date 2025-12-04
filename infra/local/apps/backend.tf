terraform {
  backend "s3" {
    bucket = "terraform-artfacts-idasilva"
    key    = "harness/kind"
    region = "sa-east-1"
  }
}
