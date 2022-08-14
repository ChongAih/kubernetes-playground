#!/bin/bash

# Create namespace
kubectl create namespace my-namespace

# Create config & secret
kubectl apply -f mongo-config.yaml
kubectl apply -f mongo-secret.yaml
# kubectl apply -f mongo-secret.yaml --namespace=my-namespace # create secret in my_namespace

# Create docker service
kubectl apply -f mongo.yaml
kubectl apply -f webapp.yaml

kubectl get namespace
kubectl get all --namespace=my-namespace # default namespace is used if not specified
kubectl get all -n my-namespace
kubectl get configmap -n my-namespace
kubectl get configmap -o yaml -n my-namespace # check detail in yaml
kubectl get secret -n my-namespace

# kubectl describe svc <service name> -n <namespace name>
# kubectl describe pod <pod name> -n <namespace name>
# kubectl logs <pod name> -n <namespace name>
# kubectl get node -o wide  -n <namespace name> --> to get ip of the worker node
# localhost:30100

# kubectl delete deployment mongo-deployment -n my-namespace
# kubectl delete deployment webapp-deployment -n my-namespace
# kubectl delete service mongo-service -n my-namespace
# kubectl delete service webapp-service -n my-namespace
# kubectl delete configmap mongo-config -n my-namespace
# kubectl delete secret mongo-secret -n my-namespace

# kubectl delete -f xxx.yaml