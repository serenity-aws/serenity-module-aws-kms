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
