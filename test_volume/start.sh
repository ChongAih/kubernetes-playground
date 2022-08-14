#!/bin/bash

# Replace with local path
mkdir -p /Users/chongaih.hau/data/volumes/pv1
chmod 777 /Users/chongaih.hau/data/volumes/pv1

kubectl apply -f storage_class.yaml
kubectl apply -f pv.yaml
kubectl apply -f pvc.yaml
kubectl apply -f pod.yaml

#kubectl get StorageClass
#kubectl get pv -o json
#kubectl get pvc -o json
#kubectl get pod
#kubectl describe pod test-local-vol

cat /Users/chongaih.hau/data/volumes/pv1/test.txt

kubectl delete -f pod.yaml
kubectl delete -f pvc.yaml
kubectl delete -f pv.yaml
kubectl delete -f storage_class.yaml