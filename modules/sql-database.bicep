param name string
param location string
param tags object
param serverName string
param skuName string
param maxSizeBytes int
param dtu int

resource db 'Microsoft.Sql/servers/databases@2023-08-01-preview' = {
  name: '${serverName}/${name}'
  location: location
  tags: tags
  sku: {
    name: skuName      // e.g., Standard
    tier: 'Standard'
    capacity: dtu
  }
  properties: {
    maxSizeBytes: maxSizeBytes
  }
}