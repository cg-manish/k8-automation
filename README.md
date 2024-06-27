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



### Vault
Vault installation guide: https://developer.hashicorp.com/vault/tutorials/kubernetes/kubernetes-raft-deployment-guide 
```
helm repo add hashicorp https://helm.releases.hashicorp.com
```

### post installation of vault

1. init the vault
exec into the vault pod
```
vault operator init
```
Save the 5 unseal keys. Distribute it. lol

```
Unseal Key 1: CsLdlYznUeG/rB1He2krzZ79jovedraKPak4ejWHqUpZ
Unseal Key 2: FRx8OtnZJbgDHkb7XEJ6ntv3uCkBszsKyZlbHUJB/IQi
Unseal Key 3: a8g5wr4TFH3hdc5VmjQzgDmGJYuxKq9GgbaPGV3VH4HV
Unseal Key 4: Uyi2hiCQcETZ4PcDPmaxMRQQrsMXvsHLyWXPkxylyhr5
Unseal Key 5: IIVF9Z+g6trzMC+wNPZAuyK4fgNCqsRp3RjnQYFijjYz
```
Also the initial root token. The root token can also be envrypted with pgp.
```
 hvs.m4cE6DuVWYhrQzNPUTmlyBj9

```

Can also encrypt the unseal keys with pgp keys.

```
vault operator init \ 
-key-shares=3 \
-key-threshold=2 \
-pgp-keys="keybase:hashicorp,keybase:jefferai,keybase:sethvargo"
```

keu-shares=3 means there are three pgp keys used. 
key-threshold=2 means there should be at least 2 keys to unlock.


2. unseal the vault
Run the unseal command 3 times with the 3 out of 5 unseal keys.
```
vault operator unseal

```