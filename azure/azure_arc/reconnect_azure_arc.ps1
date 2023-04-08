# This feature requires PS >= 4.0
#Requires -RunAsAdministrator

# Reconnect Azure Arc Resource
$resourceGroup = "CHANGE_ME_TO_YOUR_RG"
$tenantId = (Get-AzContext).Tenant.Id
$region = (Get-AzResourceGroup -Name $resourceGroup).Location
$subscriptionId = (Get-AzContext).Subscription.Id

# Disconnect from Azure Arc, then reconnect
azcmagent disconnect -f --verbose

# Attempt to reconnect on-premises resource to Azure Arc
azcmagent connect  --resource-group "$resourceGroup" --tenant-id "$tenantId" --location "$region" --subscription-id "$subscriptionId" --verbose
