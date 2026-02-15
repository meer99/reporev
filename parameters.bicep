@description('Deployment location')
param location string

@description('Tags to apply to all resources')
param tags object

@description('Existing virtual network name')
param vnetName string

@description('Existing subnet name for private endpoints')
param subnetName string

@description('Managed identity name (user-assigned)')
param userAssignedIdentityName string

@description('Log Analytics workspace name')
param logAnalyticsName string

@description('Container Registry name')
param acrName string

@description('Container Apps Environment name')
param caeName string

@description('Container App Job 1 name')
param caJob1Name string

@description('Container App Job 2 name')
param caJob2Name string

@description('SQL Server name')
param sqlServerName string

@description('SQL Database name')
param sqlDbName string

@description('SQL admin login')
param sqlAdminLogin string

@secure()
@description('SQL admin password')
param sqlAdminPassword string

@description('SQL SKU name (e.g., Standard)')
param sqlSkuName string

@description('SQL DTU capacity')
param sqlDtu int

@description('SQL max size in bytes')
param sqlMaxSizeBytes int

@description('Private endpoint name for ACR')
param peAcrName string

@description('Private endpoint name for CAE')
param peCaeName string

@description('Private endpoint name for SQL')
param peSqlName string