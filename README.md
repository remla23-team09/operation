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
Install Istio.

Run the following commands:
1. `minikube start --memory=3000 --cpus=2` (start with the memory you want, for us it is enough with this)
2. `istioctl install`
3. `kubectl label namespace default istio-injection=enabled`

Inside the folder with your istio installation run the following commands:
4. `kubectl apply -f istio-1.17.2/samples/addons/prometheus.yaml`    
6. `kubectl apply -f istio-1.17.2/samples/addons/jaeger.yaml`    
7. `kubectl apply -f istio-1.17.2/samples/addons/kiali.yaml`   
8. `kubectl apply -f istio-1.17.2/samples/addons/grafana.yaml`  

8. `helm install app .\app-chart\` (inside the app repo)
9. `helm install model-service .\model-service-chart\` (inside the model-service repo)
10. `istioctl analyze` (check that everything is ok)
11. `kubectl apply -f istio.yml`
12. `minikube tunnel`

Open localhost/ to reach the app.

To open Kiali, promotheus and grafana:
- istioctl dashboard kiali
- istioctl dashboard prometheus
- istioctl dashboard grafana

