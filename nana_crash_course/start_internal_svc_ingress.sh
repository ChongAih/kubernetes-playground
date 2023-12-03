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

echo "Checking whether multiple pods working"
kubectl describe service webapp-service -n my-namespace # to check how many pods connected to this service
# if working, should find the IP of the two replicas (10.1.0.22, 10.1.0.23) in endpoints
# can check IPs of pods using 'kubectl describe pod <pod name> -n my-namespace'

# Debug if ingress is not working
kubectl get pods -n ingress-nginx
kubectl logs ingress-nginx-controller-6648b5dbb8-wqj64 -n ingress-nginx
# call url multiple times and check ingress log to see if nginx working
# if working, the IP of the two replicas (10.1.0.15, 10.1.0.14) should appear in round robin manner
# can check IPs of pods using 'kubectl describe pod <pod name> -n my-namespace'
# 192.168.65.3 - - [02/Dec/2023:23:30:02 +0000] "GET /profile-picture HTTP/1.1" 200 2906067 "http://localhost/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36" 594 0.048 [my-namespace-webapp-service-3000] [] 10.1.0.15:3000 2900407 0.048 200 8077fa018e7936e3a4ca3f7f36ad2208
# 192.168.65.3 - - [02/Dec/2023:23:30:02 +0000] "GET /get-profile HTTP/1.1" 304 0 "http://localhost/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36" 576 0.404 [my-namespace-webapp-service-3000] [] 10.1.0.14:3000 0 0.404 304 1d7bfa3ddf16f533d20a70bdaa4e7938

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
# kubectl delete deployment ingress-nginx-controller -n ingress-nginx
# kubectl delete service ingress-nginx-controller-admission -n ingress-nginx
# kubectl delete service ingress-nginx-controller -n ingress-nginx
# kubectl delete job ingress-nginx-admission-create -n ingress-nginx
# kubectl delete job ingress-nginx-admission-patch -n ingress-nginx
# kubectl delete --all pods -n my-namespace
# kubectl delete --all pods -n ingress-nginx
