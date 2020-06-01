provider "aws" {
  version = "2.33.0"
  region = var.aws_region
}

provider "random" {
  version = "2.2"
}

terraform {
  backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "test_rstrotman_org"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "github-test-01"
    }
  }
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
