### Things to install in the cluster

1. Cilium
2. ArgoCD
3. Use helm for everythign
4. Databases like mysql, postgres, oracle
5. Nice monitoring with prometheus, grafana, jaegar, loki stuff
6. ELK
7. Metal lb maybe or in another cluster. learn bgp stuff
8. Create cluster from scratch with kubeadm
9. Ingress/ nginx and maybe Traefik as well.
10. VAULT
11. Apache Kafka
12. Rabbit MQ



### Delete namespace

```
NAMESPACE="ingress-nginx"

kubectl get namespace $NAMESPACE -o json > $NAMESPACE.json
kubectl replace --raw "/api/v1/namespaces/$NAMESPACE/finalize" -f ./$NAMESPACE.json


### ARgo cd tls bootstrap steps:
```
kubectl create -n argocd secret tls argocd-server-tls \
  --cert=/path/to/cert.pem \
  --key=/path/to/key.pem

## for dex
kubectl create -n argocd secret tls argocd-dex-server-tls \
  --cert=/path/to/cert.pem \
  --key=/path/to/key.pem

```