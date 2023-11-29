Simple example golang app with a k8s deployment for use in other examples.


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

To build the development images:

```
docker build --tag trivial-golang-k8s-deployment -f Dockerfile.dev .
```

Or

```
docker buildx build --platform linux/amd64 --tag trivial-golang-k8s-deployment -f Dockerfile.dev --load .
```

## Step 2: Upload to some docker registry

_If you just want to deploy the example - you can skip this_

For deployment on k8s you will need to push the docker image to a registry. You _can't_ push to the registry for this repo, but these instructions will work if you forked this repo:


