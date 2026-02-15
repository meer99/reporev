param name string
param location string
param tags object
param userAssignedIdentityId string
param adminUserEnabled bool = false
param publicNetworkAccess string = 'Disabled'

resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: name
  location: location
  sku: {
    name: 'Premium'
  }
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${userAssignedIdentityId}': {}
    }
  }
  properties: {
    adminUserEnabled: adminUserEnabled
    publicNetworkAccess: publicNetworkAccess
    networkRuleSet: {
      defaultAction: 'Deny'
    }
  }
  tags: tags
}

output id string = acr.id
output loginServer string = acr.properties.loginServer