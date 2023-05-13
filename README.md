# Operation

## Instructions 
- Make sure to have Docker and Docker compose installed.
- To run the application locaclly run `docker-compose up`. This starts the `app` and the `model-service` containers. 
- Open `localhost:8080` to classify restaurant reviews. 

## Code Overview
- The [Model-training](https://github.com/remla23-team09/model-training/tree/main) repository trains the model and preprocesses the data. Check text_preprocessing.py and text_classification.py to see the preprocessing and training of the model. 
- The [Model-service](https://github.com/remla23-team09/model-service) repository embeds the ML model in a Flask webservice. Check model-service.py.
- The [Lib](https://github.com/remla23-team09/lib) repository contains a simple version-aware library. Check VersionUtil.py.
- The [App](https://github.com/remla23-team09/app) repository contains a simple Flask frontend application. Check app.py. 


# Monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

kubectl create namespace monitoring

helm install kube-prometheus prometheus-community/kube-prometheus-stack --namespace monitoring 

kubectl port-forward -n monitoring svc/kube-prometheus-kube-prome-prometheus 9090:9090
kubectl port-forward -n monitoring svc/kube-prometheus-grafana 80:80

Grafana credentials: admin; prom-operator