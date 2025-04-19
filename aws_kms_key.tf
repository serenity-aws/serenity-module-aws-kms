locals {
  aws_kms_key = {
    for _id, _properties in try(var.resources.aws_kms_key.resources, {}) : _id => merge(
      _properties,
      can(_properties.policy.json) ? {
        kms_key = _id,
        policy  = _properties.policy.json
        } : can(_properties.policy.template) ? {
        kms_key = _id,
        policy  = templatefile("${path.module}/${_properties.policy.template}", var.template_variables)
        } : can(_properties.policy.github) ? {
        kms_key = _id,
        policy  = templatestring(data.github_repository_file.policy[_id].content, var.template_variables)
      } : {}
    ) if var.create
  }
}

module "aws_kms_key" {
  # source = "../serenity-resource-aws-kms-key"
  source = "github.com/serenity-aws/serenity-resource-aws-kms-key.git?ref=main"

  resources        = local.aws_kms_key
  upstream         = var.upstream
  name_tag_enabled = var.name_tag_enabled
  tags             = var.tags
}
