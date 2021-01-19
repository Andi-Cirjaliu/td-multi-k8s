docker build -t andicirjaliu/docker_complex_client:latest -t andicirjaliu/docker_complex_client:$SHA ./client
docker build -t andicirjaliu/docker_complex_server:latest -t andicirjaliu/docker_complex_server:$SHA ./server
docker build -t andicirjaliu/docker_complex_worker:latest  -t andicirjaliu/docker_complex_worker:$SHA ./worker

#Take these images and push them to Docker hub
docker push andicirjaliu/docker_complex_client:latest
docker push andicirjaliu/docker_complex_server:latest
docker push andicirjaliu/docker_complex_worker:latest
#Take these images and push them to Docker hub
docker push andicirjaliu/docker_complex_client:$SHA
docker push andicirjaliu/docker_complex_server:$SHA
docker push andicirjaliu/docker_complex_worker:$SHA

kubectl apply -f k8s

#set the image of the server deployment to the latest
kubectl set image deployments/client-deployment client=andicirjaliu/docker_complex_client:$SHA
kubectl set image deployments/server-deployment server=andicirjaliu/docker_complex_server:$SHA
kubectl set image deployments/worker-deployment worker=andicirjaliu/docker_complex_worker:$SHA