variable "create" {
  type    = bool
  default = true
}

variable "name_tag_enabled" {
  type    = bool
  default = true
}

variable "resources" {
  type = any
}

variable "upstream" {
  type = any
}

variable "tags" {
  type = map(any)
}
