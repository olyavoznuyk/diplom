output "cluster-k8s" {
  value = [
    for i in yandex_compute_instance.platform: 
   "name = ${i.name} | external-address=${i.network_interface.0.ip_address} | internal-address=${i.network_interface.0.nat_ip_address}"
  ]
}