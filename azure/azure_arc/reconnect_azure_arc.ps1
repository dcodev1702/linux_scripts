# This feature requires PS >= 4.0
#Requires -RunAsAdministrator

# Reconnect Azure Arc Resource
$resourceGroup = "CHANGE_ME_TO_YOUR_RG"
$tenantId = (Get-AzContext).Tenant.Id
$region = (Get-AzResourceGroup -Name $resourceGroup).Location
$subscriptionId = (Get-AzContext).Subscription.Id

azcmagent connect  --resource-group "$resourceGroup" --tenant-id "$tenantId" --location "$region" --subscription-id "$subscriptionId" --verbose
