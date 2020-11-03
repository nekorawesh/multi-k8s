docker build -t nekorawesh/multi-client:latest -t nekorawesh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nekorawesh/multi-server:latest -t nekorawesh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nekorawesh/multi-worker:latest -t nekorawesh/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nekorawesh/multi-client:latest
docker push nekorawesh/multi-server:latest
docker push nekorawesh/multi-worker:latest

docker push nekorawesh/multi-client:$SHA
docker push nekorawesh/multi-server:$SHA
docker push nekorawesh/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=nekorawesh/multi-client:$SHA
kubectl set image deployments/server-deployment server=nekorawesh/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=nekorawesh/multi-worker:$SHA