###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  default     = "b1ga4bt1b7rmgrntoq1o"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1ggvs5gfmh3tqvj537v"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "subnet_zone" {
  type        = list(string)
  default     = ["ru-central1-a","ru-central1-b","ru-central1-d"]
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "cidr" {
  type        = list(string)
  default     = ["10.10.1.0/24","10.10.2.0/24","10.10.3.0/24"]
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

### ssh vars
variable "public_key" {
  type        = string
  description = "ssh-keygen -t ed25519"
}

variable "ubuntu-2004-lts" {
  default = "fd8m2ak64lipvicd94sf"
}
