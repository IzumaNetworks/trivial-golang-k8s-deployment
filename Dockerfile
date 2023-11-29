FROM golang:1.20
LABEL org.opencontainers.image.source=https://github.com/IzumaNetworks/trivial-golang-k8s-deployment
LABEL org.opencontainers.image.description="Trivial Go K8s example"
LABEL org.opencontainers.image.licenses=Apache-2.0

ADD app /app
ENV CGO_ENABLED=0
RUN cd /app && go build -o app .
WORKDIR /app
ENTRYPOINT [ "/app/app" ]
