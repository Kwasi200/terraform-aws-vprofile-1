terraform {
  backend "s3" {
    bucket = "terra-vprofile-state1010"
    key = "terraform.tfstate"
    region = "eu-west-2"
      }
}