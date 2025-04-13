data "github_repository_file" "policy" {
  for_each = { for _id, _properties in try(var.resources.aws_kms_key.resources, {}) : _id => _properties if can(_properties.policy.github) }

  repository = split("//", each.value.policy.github)[0]
  file       = split("//", each.value.policy.github)[1]
  branch     = each.value.policy.ref
}
