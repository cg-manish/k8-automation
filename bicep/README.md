##  Azure Kubernetes cluster with Bicep


### Creating the cluster
```bash
az deployment group create --resource-group=kubernetes-project --template-file main.bicep
```


### Deleting the cluster

```

```


### Add network contributor access in Azure for the cluster to get access to public IP address of load balancer
```
 az role assignment create --assignee 5486aa54-5cfd-419d-bca2-4089bd268a9d \
 --role "Network Contributor" \
--scope /subscriptions/90d20ec2-4b61-45da-8516-65b24c6440f6/resourceGroups/kubernetes-project
````