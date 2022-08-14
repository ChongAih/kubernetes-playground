#!/bin/bash

# Install ingress controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.2.1/deploy/static/provider/cloud/deploy.yaml
kubectl get pods -n ingress-nginx

# Create namespace
kubectl create namespace my-namespace

# Create config & secret
kubectl apply -f mongo-config.yaml
kubectl apply -f mongo-secret.yaml
# kubectl apply -f mongo-secret.yaml --namespace=my-namespace # create secret in my_namespace

# Create docker service
kubectl apply -f mongo.yaml
kubectl apply -f webapp_internal.yaml

# Create ingress service
kubectl apply -f ingress.yaml

kubectl get namespace
kubectl get all --namespace=my-namespace # default namespace is used if not specified
kubectl get all -n my-namespace # Note the type of webapp-service now is ClusterIP (internal service)
kubectl get configmap -n my-namespace
kubectl get configmap -o yaml -n my-namespace # check detail in yaml
kubectl get secret -n my-namespace
kubectl get ingress -n my-namespace
kubectl describe ingress webapp-ingress -n my-namespace # show all the host, path and backend

# Debug if ingress is not working
kubectl get pods -n ingress-nginx
kubectl logs ingress-nginx-controller-6648b5dbb8-4nhv4 -n ingress-nginx

# kubectl describe ingress <ingress name> -n <namespace name>
# kubectl describe svc <service name> -n <namespace name>
# kubectl describe pod <pod name> -n <namespace name>
# kubectl logs <pod name> -n <namespace name>
# kubectl get node -o wide  -n <namespace name> --> to get ip of the worker node

curl -kL http://localhost/
curl -kL http://localhost/service

# kubectl delete deployment mongo-deployment -n my-namespace
# kubectl delete deployment webapp-deployment -n my-namespace
# kubectl delete service mongo-service -n my-namespace
# kubectl delete service webapp-service -n my-namespace
# kubectl delete configmap mongo-config -n my-namespace
# kubectl delete secret mongo-secret -n my-namespace
# kubectl delete ingress webapp-ingress -n my-namespace
# kubectl delete --all pods -n my-namespace
# kubectl delete --all pods -n ingress-nginx