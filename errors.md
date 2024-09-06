Application/ingress-nginx is part of applications argocd/k8-cluster-azure-dev and cluster1-dev-apps

  Error syncing load balancer: failed to ensure load balancer: Retriable: false,
  RetryAfter: 0s, HTTPStatusCode: 403, RawError:
  {"error":{"code":"AuthorizationFailed","message":"The client
  '5486aa54-5cfd-419d-bca2-4089bd268a9d' with object id
  '5486aa54-5cfd-419d-bca2-4089bd268a9d' does not have authorization to perform
  action 'Microsoft.Network/publicIPAddresses/read' over scope
  '/subscriptions/90d20ec2-4b61-45da-8516-65b24c6440f6/resourceGroups/kubernetes-project/providers/Microsoft.Network'
  or the scope is invalid. If access was recently granted, please refresh your
  credentials.

    0/1 nodes are available: 1 Insufficient cpu. preemption: 0/1 nodes are
  available: 1 No preemption victims found for incoming pod.

  'Readiness probe failed: HTTP probe failed with statuscode: 500'