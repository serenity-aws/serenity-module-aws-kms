output "aws_ecr_repository" {
  value = module.aws_ecr_repository.this
}

output "aws_kms_key" {
  value = module.aws_kms_key.this
}

output "aws_kms_alias" {
  value = module.aws_kms_alias.this
}

output "aws_kms_alias_inline" {
  value = module.aws_kms_alias_inline.this
}

output "aws_kms_alias_inline_prefix" {
  value = module.aws_kms_alias_inline_prefix.this
}
