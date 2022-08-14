# https://matthewpalmer.net/kubernetes-app-developer/articles/kubernetes-ingress-guide-nginx-example.html

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.2.1/deploy/static/provider/cloud/deploy.yaml
kubectl get pods -n ingress-nginx

kubectl apply -f apple.yaml
kubectl apply -f banana.yaml

kubectl apply -f ingress.yaml

kubectl get ingress example-ingress

curl -kL http://localhost/apple
curl -kL http://localhost/banana
curl -kL http://localhost/notfound

