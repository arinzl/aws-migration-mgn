provider "aws" {
  region = var.region

}

provider "aws" {
  alias  = "dr-region"
  region = var.region_dr

}

