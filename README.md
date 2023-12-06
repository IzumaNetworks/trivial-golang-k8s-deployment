Simple example golang app with a k8s deployment for use in other examples.

This is good boilerplate code for starting a Golang project that will deploy on Kubernetes.

### This example is used by these tutorials / posts

[Sync a pod with rsync for fast K8s ECT cycle](https://www.izumanetworks.com/blog/use-rsync-with-k8s/)

[How to build a x86/amd64 docker container image on Apple silicon (or any other arch)](https://www.izumanetworks.com/blog/build-docker-on-apple-m/)

[Build, push and pull a container using Github GHCR or Gitlab Container Registry](https://www.izumanetworks.com/blog/use-github-gitlab-for-docker-registry/)

## Step 1: Build docker images

Assuming you will deploy to an `amd64` arch...

If building on an `amd64` arch machine:

```
docker build --tag trivial-golang-k8s-deployment .
```

If on another arch, such as Apple Silicon etc.

```
docker buildx build --platform linux/amd64 --tag trivial-golang-k8s-deployment --load .
```

Or if need Cgo and you want an Alpine base image:

```
docker buildx build -f Dockerfile-cross-cgo-xx-alpine --platform linux/amd64 --tag trivial-golang-k8s-deployment --load .
```

To build the development images:

```
docker build --tag trivial-golang-k8s-deployment -f Dockerfile.dev .
```

Or

```
docker buildx build --platform linux/amd64 --tag trivial-golang-k8s-deployment -f Dockerfile.dev --load .
```

## Step 2: Upload to some docker registry

_If you just want a test deployment using the original example - you can skip this_

Otherwise read: https://www.izumanetworks.com/blog/use-github-gitlab-for-docker-registry/

## Step 3: Deploy to K8s

For deployment on K8s you will need to push the docker image to a registry. You _can't_ push to the registry for this repo, but these instructions will work if you forked this repo:

```
kubectl apply -f deployment.yaml
```

To apply our basic deployment.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: trivial-golang-k8s-deployment
  labels:
    app: trivial-golang-k8s-deployment
spec:
  containers:
  - name: trivial-golang-k8s-deployment
    image: ghcr.io/izumanetworks/trivial-golang-k8s-deployment:latest
    imagePullPolicy: Always
    ports:
    - containerPort: 8080
    livenessProbe:
      httpGet:
        path: /hello
        port: 8080
      initialDelaySeconds: 5
      periodSeconds: 5
  imagePullSecrets:
    - name: regcred
```

