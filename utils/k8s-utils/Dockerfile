FROM alpine:3.19

ENV KUBE_VERSION=1.25.0
ENV TARGETOS=linux
ENV TARGETARCH=amd64

RUN apk -U upgrade \
    && apk add --no-cache bash \
    && wget -q "https://dl.k8s.io/release/v$KUBE_VERSION/bin/$TARGETOS/$TARGETARCH/kubectl" -O /usr/local/bin/kubectl \
    && chmod 744 /usr/local/bin/kubectl \
    && kubectl version --client 
    

ENTRYPOINT /bin/bash