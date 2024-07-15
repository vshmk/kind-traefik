create-cluster:
	kind create cluster --config k8s-cluster.yaml
	kubectl config use-context kind-kind
	helm repo add traefik https://traefik.github.io/charts && helm repo update
    kubectl apply --server-side --force-conflicts -k https://github.com/traefik/traefik-helm-chart/traefik/crds/
	helm upgrade -i traefik traefik/traefik --values traefik-values.yml -n traefik --create-namespace --version v27.0.2
	kubectl apply -f  test-apps/nginx2.yaml

delete-cluster:
	kind delete cluster