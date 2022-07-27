# Traffic Manager FQDN Output
output "traffic_manager_fqdn" {
  description = "Traffic Manager FQDN"
  value       = azurerm_traffic_manager_profile.tm_profile.fqdn
}

# 
output "traffic_manager_eastus2_endpoint_id_from_data_source" {
  description = "Traffic Manager Endpoint - Project-1-EastUs2 from data source"
  value       = data.terraform_remote_state.project1_eastus2.outputs.web_lb_public_ip_address_id
}

output "traffic_manager_westus2_endpoint_id_from_data_source" {
  description = "Traffic Manager Endpoint - Project-2-WestUs2 from data source"
  value       = data.terraform_remote_state.project2_westus2.outputs.web_lb_public_ip_address_id
}

output "traffic_manager_eastus2_endpoint_id" {
  description = "Traffic Manager Endpoint - Project-1-EastUs2"
  value       = azurerm_traffic_manager_azure_endpoint.tm_endpoint_project1_eastus2
}

output "traffic_manager_westus2_endpoint_id" {
  description = "Traffic Manager Endpoint - Project-2-WestUs2"
  value       = azurerm_traffic_manager_azure_endpoint.tm_endpoint_project2_westus2
}