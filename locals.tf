locals {
  inline_aliases = toset(flatten([
    for _id, _data in try(var.data.aws_kms_key, {}) : [
      for alias in try(_data.aliases, []) : { _id = alias, name = "alias/${alias}", kms_key = _id }
    ]
  ]))
}
