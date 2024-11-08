# The container log analytics workspace
variable "subscription_id" {
  description = "Azure Subscription Id"
  type        = string
  # default     = "f0c6d911-101d-4654-a2ec-492160af09aa"
}

# The Azure region where resources will be created
variable "location" {
  description = "The Azure region where resources will be deployed"
  type        = string
  # default     = "Southeast Asia"
}

# The name of the resource group to create or use
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  # default     = "blackbox"
}

# The name for the Azure Container Registry
variable "acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
  # default     = "blackboxcr"
}

# The name for the Azure Container App environment
variable "container_app_env_name" {
  description = "The name for the Azure Container App environment"
  type        = string
  # default     = "blackboxenv"
}

# The name for the Azure Container App itself
variable "container_app_name" {
  description = "The name of the Azure Container App"
  type        = string
  # default     = "blackbox-auth"
}

# The container image to deploy
variable "container_image" {
  description = "The container image URL to be deployed"
  type        = string
  # default     = "blackbox.auth"
}

# Optionally, configure the Dapr app ID
variable "dapr_app_id" {
  description = "The Dapr app ID"
  type        = string
  # default     = "blackbox-dapr"
}

# The container log analytics workspace
variable "container_log_analytics_workspace" {
  description = "The container log analytics workspace"
  type        = string
  # default     = "blackboxlgaw"
}

# If container app external enabled or not
variable "container_app_external_enabled" {
  description = "Container app external enabled or not"
  type        = bool
  # default     = false
}
#Container app url
output "container_app_url" {
  value = azurerm_container_app.example.ingress[0].fqdn
}
