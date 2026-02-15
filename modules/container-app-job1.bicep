param name string
param location string
param tags object
param environmentId string
param userAssignedIdentityId string
@description('Container image for job')
param image string = 'acraetestrevbc.azurecr.io/app:latest'

resource job 'Microsoft.App/jobs@2024-03-01' = {
  name: name
  location: location
  tags: tags
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${userAssignedIdentityId}': {}
    }
  }
  properties: {
    environmentId: environmentId
    configuration: {
      triggerType: 'Manual'
      replicaTimeout: 300
      replicaRetryLimit: 3
      registries: []
    }
    template: {
      containers: [
        {
          name: '${name}-container'
          image: image
          resources: {
            cpu: 0.5
            memory: '1Gi'
          }
        }
      ]
    }
  }
}