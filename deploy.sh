docker build -t sqlmonk/multi-client:latest -t sqlmonk/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t sqlmonk/multi-server:latest -t sqlmonk/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t sqlmonk/multi-worker:latest -t sqlmonk/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push sqlmonk/multi-client:latest
docker push sqlmonk/multi-client:$GIT_SHA
docker push sqlmonk/multi-server:latest
docker push sqlmonk/multi-server:$GIT_SHA
docker push sqlmonk/multi-worker:latest
docker push sqlmonk/multi-worker:$GIT_SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=sqlmonk/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=sqlmonk/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=sqlmonk/multi-worker:$GIT_SHA