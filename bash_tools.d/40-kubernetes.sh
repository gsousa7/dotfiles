# Kubernetes Alias
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

