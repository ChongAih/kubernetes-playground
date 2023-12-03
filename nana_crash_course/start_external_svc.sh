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

echo "Checking whether multiple pods working"
kubectl describe service webapp-service -n my-namespace # to check how many pods connected to this service
# if working, should find the IP of the two replicas (10.1.0.22, 10.1.0.23) in endpoints
# can check IPs of pods using 'kubectl describe pod <pod name> -n my-namespace'

# Update profile using the localhost:30100 multiple times --> should see the IP in mongo logs
# kubectl logs -f mongo-deployment-7875498c-jfb9f -n my-namespace
# {"t":{"$date":"2023-12-02T23:52:02.557+00:00"},"s":"I",  "c":"ACCESS",   "id":20250,   "ctx":"conn4","msg":"Authentication succeeded","attr":{"mechanism":"SCRAM-SHA-256","speculative":false,"principalName":"mongouser","authenticationDatabase":"admin","remote":"10.1.0.23:46744","extraInfo":{}}}
# {"t":{"$date":"2023-12-02T23:52:07.153+00:00"},"s":"I",  "c":"ACCESS",   "id":20250,   "ctx":"conn5","msg":"Authentication succeeded","attr":{"mechanism":"SCRAM-SHA-256","speculative":false,"principalName":"mongouser","authenticationDatabase":"admin","remote":"10.1.0.22:55476","extraInfo":{}}}

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