provider "aws" {
  version = "2.33.0"

  region = var.aws_region
}

provider "random" {
  version = "2.2"
}

resource "random_pet" "table_name" {}

resource "aws_dynamodb_table" "tfc_example_table" {
  name = "${var.db_table_name}-${random_pet.table_name.id}"

  read_capacity  = var.db_read_capacity
  write_capacity = var.db_write_capacity
  hash_key       = "UUID"
  range_key      = "UserName"

  attribute {
    name = "UUID"
    type = "S"
  }

  attribute {
    name = "UserName"
    type = "S"
  }

  tags = {
    user_name = var.tag_user_name
  }
}

module "s3-webapp" {
  source  = "app.terraform.io/test_rstrotman_org/s3-webapp/aws"
  version = "1.0.0"
  name= "37362923797329rst"
  prefix= "test"
  region=var.aws_region
  
}
