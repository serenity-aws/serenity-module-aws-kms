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
    )
  }
}
