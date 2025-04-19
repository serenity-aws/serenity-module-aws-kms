locals {
  aws_ecr_repository = {
    for _id, _properties in try(var.resources.aws_ecr_repository.resources, {}) : _id => _properties if var.create
  }
}

module "aws_ecr_repository" {
  # source = "../serenity-resource-aws-kms-key"
  source = "github.com/serenity-aws/serenity-resource-aws-ecr-repository.git?ref=main"

  resources = local.aws_ecr_repository
  upstream  = var.upstream
  this = {
    aws_kms_key = module.aws_kms_key.this
  }
  name_tag_enabled = var.name_tag_enabled
  tags             = var.tags
}
