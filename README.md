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
In order to start Prometheus and Grafana run the following commands:

- `helm repo add prometheus-community https://prometheus-community.github.io/helm-charts`
- `helm repo update`
- `kubectl create namespace monitoring`
- `helm install kube-prometheus prometheus-community/kube-prometheus-stack --namespace monitoring`
- `kubectl port-forward -n monitoring svc/kube-prometheus-kube-prome-prometheus 9090:9090`
- `kubectl port-forward -n monitoring svc/kube-prometheus-grafana 80:80`

## Grafana
Grafana credentials: admin; prom-operator

To open the Grafana dashboard, follow these instructions:
1. Download the JSON file in this repository.
2. Open Grafana
3. Click Dashboards in the left-side menu.
4. Click New and select Import in the dropdown menu.
4. Upload the dashboard JSON file. 

# Istio

- minikube start --memory=3000 --cpus=2 (start with the memory you want, for me this works)
- istioctl install
- kubectl label namespace default istio-injection=enabled
- kubectl apply -f istio-1.17.2/samples/addons/prometheus.yaml (inside the folder with your istio installation)
- kubectl apply -f istio-1.17.2/samples/addons/jaeger.yaml (inside the folder with your istio installation)
- kubectl apply -f istio-1.17.2/samples/addons/kiali.yaml (inside the folder with your istio installation)
kubectl apply -f istio-1.17.2/samples/addons/grafana.yaml (inside the folder with your istio installation)
- helm install app .\app-chart\
- helm install model-service .\model-service-chart\
- istioctl analyze (check that everything is OK)
- kubectl apply -f istio.yml
- minikube tunnel

Open localhost to reach the app.

To open Kiali, promotheus and grafana:
- istioctl dashboard kiali
- istioctl dashboard prometheus
- istioctl dashboard grafana

