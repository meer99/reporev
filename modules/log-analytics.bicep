param name string
param location string
param tags object
@allowed([
  'PerGB2018'
])
param sku string = 'PerGB2018'

resource la 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    retentionInDays: 30
    sku: {
      name: sku
    }
  }
}

output id string = la.id