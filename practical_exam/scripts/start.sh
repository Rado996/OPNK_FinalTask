su - ubuntu -c "minikube start --kubernetes-version=v1.23.13 --nodes=3"
su - ubuntu -c "minikube addons enable ingress"
su - ubuntu -c "minikube status"

docker run --name nginx -d -p 80:80 nginx

helm repo add bitnami https://charts.bitnami.com/bitnami
helm install my-release bitnami/mongodb