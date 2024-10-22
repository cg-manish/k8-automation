pf:
	kubectl config use-context kind-argo &&  kubectl port-forward svc/argocd-server -n argocd 8080:443
ac:
	kubectl config use-context k8-dev-cluster
lc:
	kubectl config use-context kind-argo
arg-ref:
	argocd repo  get --refresh hard https://github.com/cg-manish/k8-playground.git 
	
.PHONY: pf ac lc arg-ref
