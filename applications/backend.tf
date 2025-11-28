terraform {
  backend "s3" {
    bucket = "terraform-artfacts-idasilva"
    key    = "harness/team-a"
    region = "sa-east-1"
  }
}
