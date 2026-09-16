# Kubernetes Alias (same base as bash_tools.d/40-kubernetes.sh, kept identical
# so muscle memory transfers between shells)
alias k='kubectl'
alias ks='kubectl -n kube-system'
alias kdesc='kubectl describe'
alias kl='kubectl logs'
alias ke='kubectl exec -it'
alias kexp='kubectl explain'
alias ked='kubectl edit'
alias ksetns='kubectl config set-context --current --namespace'

## Cluster commands
alias kci='kubectl cluster-info'
alias kgnw='kubectl get nodes -o wide'

## Create resources
alias kcf='kubectl create -f'
alias kaf='kubectl apply -f'

## Get resources
alias kgn='kubectl get nodes'
alias kgp='kubectl get pods'
alias kgpl='kubectl get pods -l'
alias kgpa='kubectl get pods --all-namespaces'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kgns='kubectl get namespaces'

## Delete
alias kd='kubectl delete'
alias kdp='kubectl delete pod'
alias kds='kubectl delete service'
alias kdd='kubectl delete deployment'
alias kdn='kubectl delete namespace'

# ---------------------------------------------------------------------------
# Extras borrowed from mac-dot's kubectl.zsh. Skipped anything that collides
# with a different meaning above (their 'kdp'/'kdd' are 'describe', ours are
# 'delete' - kept ours since that's the existing muscle memory).
# ---------------------------------------------------------------------------
alias kgpn='kgp -n'
alias kgpsl='kubectl get pods --show-labels'
alias kgpw='kgp --watch'
alias kgpwide='kgp -o wide'
alias keti='kubectl exec -t -i'
alias kpf='kubectl port-forward'
alias kgdwide='kgd -o wide'
alias kgrs='kubectl get replicaset'
alias krh='kubectl rollout history'
alias kgi='kubectl get ingress'
alias kge="kubectl get events --sort-by='.lastTimestamp'"
alias kgew="kubectl get events --watch --sort-by='.lastTimestamp'"
alias klf='kubectl logs -f'
alias kj="kubectl get -o json | jq"
alias kjx="kubectl get -o json | fx"
alias ky="kubectl get -o yaml | yh"
alias kx="kubectx"

# Namespace shortlist + local switch (doesn't need 'list namespaces' RBAC)
KNOWN_NS=(argocd default kube-system)

knls() { printf '%s\n' "${KNOWN_NS[@]}"; }

kn() {
  local ns="${1:-}"
  if [ -z "$ns" ]; then
    PS3="namespace> "
    select ns in "${KNOWN_NS[@]}"; do [ -n "$ns" ] && break; done
  fi
  [ -z "$ns" ] && return 1
  kubectl config set-context --current --namespace="$ns" && echo "-> namespace: $ns"
}

# zsh completion (only if kubectl is actually installed)
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
  compdef k=kubectl 2>/dev/null
fi
