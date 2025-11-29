terraform {
  backend "s3" {
    bucket = "terraform-artfacts-idasilva"
    key    = "harness/team-b"
    region = "sa-east-1"
  }
}
