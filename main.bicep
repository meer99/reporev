import './parameters.bicep' as p

param location string
param tags object
param vnetName string
param subnetName string
param userAssignedIdentityName string
param logAnalyticsName string
param acrName string
param caeName string
param caJob1Name string
param caJob2Name string
param sqlServerName string
param sqlDbName string
param sqlAdminLogin string
@secure()
param sqlAdminPassword string
param sqlSkuName string
param sqlDtu int
param sqlMaxSizeBytes int
param peAcrName string
param peCaeName string
param peSqlName string

var subnetId = resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, subnetName)

module mi './modules/managed-identity.bicep' = {
  name: 'mi'
  params: {
    name: userAssignedIdentityName
    location: location
    tags: tags
  }
}

module la './modules/log-analytics.bicep' = {
  name: 'la'
  params: {
    name: logAnalyticsName
    location: location
    tags: tags
  }
}

module acr './modules/container-registry.bicep' = {
  name: 'acr'
  params: {
    name: acrName
    location: location
    tags: tags
    userAssignedIdentityId: mi.outputs.id
  }
}

module cae './modules/container-app-env.bicep' = {
  name: 'cae'
  params: {
    name: caeName
    location: location
    tags: tags
    logAnalyticsId: la.outputs.id
  }
}

module job1 './modules/container-app-job1.bicep' = {
  name: 'job1'
  params: {
    name: caJob1Name
    location: location
    tags: tags
    environmentId: cae.outputs.id
    userAssignedIdentityId: mi.outputs.id
  }
}

module job2 './modules/container-app-job2.bicep' = {
  name: 'job2'
  params: {
    name: caJob2Name
    location: location
    tags: tags
    environmentId: cae.outputs.id
    userAssignedIdentityId: mi.outputs.id
  }
}

module sql './modules/sql-server.bicep' = {
  name: 'sql'
  params: {
    name: sqlServerName
    location: location
    tags: tags
    adminLogin: sqlAdminLogin
    adminPassword: sqlAdminPassword
  }
}

module db './modules/sql-database.bicep' = {
  name: 'db'
  params: {
    name: sqlDbName
    tags: tags
    serverName: sqlServerName
    skuName: sqlSkuName
    maxSizeBytes: sqlMaxSizeBytes
    dtu: sqlDtu
  }
}

module peAcr './modules/private-endpoint.bicep' = {
  name: 'peAcr'
  params: {
    name: peAcrName
    location: location
    tags: tags
    subnetId: subnetId
    groupId: 'registry'
    targetResourceId: acr.outputs.id
  }
}

module peCae './modules/private-endpoint.bicep' = {
  name: 'peCae'
  params: {
    name: peCaeName
    location: location
    tags: tags
    subnetId: subnetId
    groupId: 'managedEnvironments'
    targetResourceId: cae.outputs.id
  }
}

module peSql './modules/private-endpoint.bicep' = {
  name: 'peSql'
  params: {
    name: peSqlName
    location: location
    tags: tags
    subnetId: subnetId
    groupId: 'sqlServer'
    targetResourceId: sql.outputs.id
  }
}