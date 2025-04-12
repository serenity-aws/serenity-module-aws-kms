module "aws_kms_alias" {
  # source = "../serenity-resource-aws-kms-alias"
  source = "github.com/serenity-aws/serenity-resource-aws-kms-alias.git?ref=main"

  data = try(var.data.aws_kms_alias.resources, {})
  upstream = merge(
    var.upstream,
    {
      aws_kms_key = module.aws_kms_key.this
    }
  )
  name_tag_enabled = var.name_tag_enabled
  tags             = {}
}

module "aws_kms_alias_inline" {
  # source = "../serenity-resource-aws-kms-alias"
  source = "github.com/serenity-aws/serenity-resource-aws-kms-alias.git?ref=main"

  data = { for alias in local.inline_aliases : alias._id => alias }
  upstream = merge(
    var.upstream,
    {
      aws_kms_key = module.aws_kms_key.this
    }
  )
  name_tag_enabled = var.name_tag_enabled
  tags             = {}
}

module "aws_kms_alias_inline_prefix" {
  # source = "../serenity-resource-aws-kms-alias"
  source = "github.com/serenity-aws/serenity-resource-aws-kms-alias.git?ref=main"

  data = { for alias in local.inline_prefix_aliases : alias._id => alias }
  upstream = merge(
    var.upstream,
    {
      aws_kms_key = module.aws_kms_key.this
    }
  )
  name_tag_enabled = var.name_tag_enabled
  tags             = {}
}

module "aws_kms_key" {
  # source = "../serenity-resource-aws-kms-key"
  source = "github.com/serenity-aws/serenity-resource-aws-kms-key.git?ref=main"

  data             = try(var.data.aws_kms_key.resources, {})
  upstream         = var.upstream
  name_tag_enabled = var.name_tag_enabled
  tags             = var.tags
}
