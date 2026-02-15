param name string
param location string
param tags object
param logAnalyticsId string
param internalOnly bool = true
param publicNetworkAccess string = 'Disabled'

resource env 'Microsoft.App/managedEnvironments@2024-03-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    appLogsConfiguration: {
      logAnalyticsConfiguration: {
        customerId: reference(logAnalyticsId, '2022-10-01', 'Full').customerId
        sharedKey: listKeys(logAnalyticsId, '2022-10-01').primarySharedKey
      }
    }
    vnetConfiguration: {
      internal: internalOnly
      infrastructureSubnetId: '' // set if you use VNet-injected CAE
    }
    zoneRedundant: false
  }
}

output id string = env.id