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

```bash
NAMESPACE="ingress-nginx"

kubectl get namespace $NAMESPACE -o json > $NAMESPACE.json
kubectl replace --raw "/api/v1/namespaces/$NAMESPACE/finalize" -f ./$NAMESPACE.json


### ARgo cd tls bootstrap steps:
```bash
kubectl create -n argocd secret tls argocd-tls-tls \
  --cert=/path/to/cert.pem \
  --key=/path/to/key.pem

## for dex
kubectl create -n argocd secret tls argocd-dex-tls-tls \
  --cert=/path/to/cert.pem \
  --key=/path/to/key.pem

```


### Create tls certs for argocd 

Generally you would create a CA (ca private key and ca certificate) and create CSR and sign the certificate from CSR with the CA's private key. 
```bash

1. with CA
# create a ca
openssl req -x509 -sha256 -days 10000 -newkey rsa:2048 -keyout certs/ca/rootCA.key -out certs/ca/rootCA.crt

## gen csr
openssl req -newkey rsa:2048 -keyout argocd-tls.key -out certs/argocd-tls.csr

```
### sign the certificate with CA certificate and CA private key
```
openssl x509 -req -CA ca/rootCA.crt -CAkey ca/rootCA.key -in argocd-tls.csr -out argo-meow.crt -days 365 -CAcreateserial

```

2. Just create a generic private key and sign the certificate with the private key
## gen private key
openssl genrsa -out certs/argocd-tls.key 2048


### gen the certifiate directly without csr with the private key
 openssl req -x509 -new -nodes -days 365 -key argocd-tls.key -out test.crt -subj "/CN=argo.k8.macgain.net"


#### Create k8 secret 
```bash

kubectl create secret tls argocd-tls-secret --cert=./certs/argo-tls.crt --key=./certs/argocd-tls.key -n argocd
kubectl create secret tls argocd-tls-secret --cert=test.crt --key=argocd-tls.key -n argocd


```