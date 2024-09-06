@description('The name of the Managed Cluster resource.')
param clusterName string = 'k8-dev-cluster'

@description('The location of the Managed Cluster resource.')
param location string = 'southindia'

@description('Disk size (in GB) to provision for each of the agent pool nodes. This value ranges from 0 to 1023. Specifying 0 will apply the default disk size for that agentVMSize.')
@minValue(0)
@maxValue(1023)
param osDiskSizeGB int = 30

@description('The number of nodes for the cluster.')
@minValue(1)
@maxValue(50)
param agentCount int = 1

@description('The size of the Virtual Machine.')
param agentVMSize string = 'Standard_A2_v2'

@description('User name for the Linux Virtual Machines.')
param linuxAdminUsername string = 'azureuser'

@description('Configure all linux machines with the SSH RSA public key string. Your key should include three parts, for example \'ssh-rsa AAAAB...snip...UcyupgH azureuser@linuxvm\'')
param sshRSAPublicKey string='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBcS1ls6PHkmFB1Z3TNhZu8piHNl2y9OnC4yp/OK4fOztzVmHr7yoTf8O/G8aJ2QBzT3lcpqJccKvjqTms5wQPpeTFXgwv/WCAHOjWaewzk/cnk/ED/1FiNWFFcVEpOmo9VRUjBGLCUh7m9fyamLP+GC9C45Tl0yXw4JrwZpAJpHjr4at0n5UIJXzPuJrC34gQYM7HkTLrhBxoZ093CsU2jFYjXRwueRigvsEpvxDGwZS9EjUPE4+TlnnDHsBM11GN+mWRQ1LRB5o3GHlxUxvbfN0lurpXjzG1TTXeDMJICCr+dnSHjJ7FrztAlbUbh9jk59lr2CXXuI+4dEGXZ6X2MZr/yM1kQkWsehkEaa8RiwQPHAJEdA8XnxVqe+p6x3IzLmlV5SRg763xcc3uK2E1GPmiU5NE47XPpj+YOBWnKJJssQ+zWqbaYeGrN/NjVy55Unw6hwRtryxL3uuP8a9ZB4EDIJCWUmQWiSrVkf36HD513awd8TaH55Wa7QjU+cM= seriously-mac@Seriouslys-MacBook-Air.local'

param dnsPrefix string = 'k8-test-cluster-load-balancer'

resource aks 'Microsoft.ContainerService/managedClusters@2024-02-01' = {
  name: clusterName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: 'Base'
    tier: 'Free'
  }

  properties: {
  kubernetesVersion:'1.29.2'
  networkProfile:{
    loadBalancerSku:'Standard'
  }
  dnsPrefix: dnsPrefix
    agentPoolProfiles: [
      {
        name: 'agentpool1'
        osDiskSizeGB: osDiskSizeGB
        count: agentCount
        vmSize: agentVMSize
        osType: 'Linux'
        mode: 'System'
      }
    ]
    linuxProfile: {
      adminUsername: linuxAdminUsername
      ssh: {
        publicKeys: [
          {
            keyData: sshRSAPublicKey
          }
        ]
      }
    }

  }
}

output controlPlaneFQDN string = aks.properties.fqdn
