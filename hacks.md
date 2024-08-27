# General commands to navigate around the cluster

### Get cluster info
```
kubectl cluster-info
```

### Get contexts

```
kubectl config get-contexts
```

#### Set context
```
k config set-context --current something
```
 OR
 
 ``` 
 k config use-context cluster-context-name
 ```


### Set namespace

```
k config set-context --current --namespace argo
```
