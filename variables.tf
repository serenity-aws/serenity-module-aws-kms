variable "create" {
  type    = bool
  default = true
}

variable "data" {
  type = any
}

variable "upstream" {
  type = any
}

variable "name_tag_enabled" {
  type    = bool
  default = true
}

variable "tags" {
  type = map(any)
}
