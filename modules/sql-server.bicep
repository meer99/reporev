param name string
param location string
param tags object
param adminLogin string
@secure()
param adminPassword string
param publicNetworkAccess string = 'Disabled'
param minimalTlsVersion string = '1.2'

resource sql 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: name
  location: location
  tags: tags
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
    publicNetworkAccess: publicNetworkAccess
    minimalTlsVersion: minimalTlsVersion
  }
}

output id string = sql.id