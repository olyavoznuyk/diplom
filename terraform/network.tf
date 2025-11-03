resource "yandex_vpc_network" "develop" {
  name = "develop"
}
resource "yandex_vpc_subnet" "subnet_zones" {
  count          = length(var.subnet_zone)
  name           = "subnet-${var.subnet_zone[count.index]}"
  zone           = var.subnet_zone[count.index]
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = [var.cidr[count.index]]
}