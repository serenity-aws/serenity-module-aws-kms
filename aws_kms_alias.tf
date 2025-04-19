# KMS aliases can be created in 2 ways:
# 1. Directly, using `aws_kms_alias` definition
# 2. Inline, part of `aws_kms_key` definition, using `aliases` or `prefix_aliases` properties

locals {
  inline_aliases = toset(flatten([
    for _id, _properties in try(var.resources.aws_kms_key.resources, {}) : [
      for alias in try(_properties.aliases, []) : { _id = alias, name = "alias/${alias}", kms_key = _id }
    ]
  ]))
  inline_prefix_aliases = toset(flatten([
    for _id, _properties in try(var.resources.aws_kms_key.resources, {}) : [
      for alias in try(_properties.prefix_aliases, []) : { _id = alias, name_prefix = "alias/${alias}", kms_key = _id }
    ]
  ]))
}

# Aliases created using `aws_kms_alias` definition
module "aws_kms_alias" {
  # source = "../serenity-resource-aws-kms-alias"
  source = "github.com/serenity-aws/serenity-resource-aws-kms-alias.git?ref=main"

  resources = try(var.resources.aws_kms_alias.resources, {})
  upstream = merge(
    var.upstream,
    {
      aws_kms_key = module.aws_kms_key.this
    }
  )
  name_tag_enabled = var.name_tag_enabled
  tags             = {}
}

# Aliases created using `aliases` property in `aws_kms_key` definition
module "aws_kms_alias_inline" {
  # source = "../serenity-resource-aws-kms-alias"
  source = "github.com/serenity-aws/serenity-resource-aws-kms-alias.git?ref=main"

  resources = { for alias in local.inline_aliases : alias._id => alias if var.create }
  upstream = merge(
    var.upstream,
    {
      aws_kms_key = module.aws_kms_key.this
    }
  )
  name_tag_enabled = var.name_tag_enabled
  tags             = {}
}

# Aliases created using `prefix_aliases` property in `aws_kms_key` definition
module "aws_kms_alias_inline_prefix" {
  # source = "../serenity-resource-aws-kms-alias"
  source = "github.com/serenity-aws/serenity-resource-aws-kms-alias.git?ref=main"

  resources = { for alias in local.inline_prefix_aliases : alias._id => alias if var.create }
  upstream = merge(
    var.upstream,
    {
      aws_kms_key = module.aws_kms_key.this
    }
  )
  name_tag_enabled = var.name_tag_enabled
  tags             = {}
}
