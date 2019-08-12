provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "git::https://github.com/clouddrove/terraform-aws-vpc.git?ref=tags/0.11.0"

  name        = "vpc"
  application = "cloudDrove"
  environment = "test"

  cidr_block = "10.0.0.0/16"
}

module "subnets" {
  source = "../../"

  application         = "clouddrove"
  environment         = "dev"
  name                = "subnet"
  availability_zones  = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_id              = "${module.vpc.vpc_id}"
  type                = "public-private"
  igw_id              = "${module.vpc.igw_id}"
  nat_gateway_enabled = "true"
  cidr_block          = "${module.vpc.vpc_cidr_block}"
}
