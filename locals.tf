locals {
  inline_aliases = toset(flatten([
    for _id, _data in try(var.data.aws_kms_key, {}) : [
      for alias in try(_data.aliases, []) : { _id = alias, name = "alias/${alias}", kms_key = _id }
    ]
  ]))
  inline_prefix_aliases = toset(flatten([
    for _id, _data in try(var.data.aws_kms_key, {}) : [
      for alias in try(_data.prefix_aliases, []) : { _id = alias, name_prefix = "alias/${alias}", kms_key = _id }
    ]
  ]))
}
