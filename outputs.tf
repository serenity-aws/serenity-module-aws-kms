output "aws_kms_alias" {
  value = merge(
    module.aws_kms_alias.this,
    module.aws_kms_alias_inline.this
  )
}

output "aws_kms_key" {
  value = module.aws_kms_key.this
}
