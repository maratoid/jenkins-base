FROM gcr.io/google_containers/ubuntu-slim:0.3

ENV GOOGLE_CLOUD_SDK_VERSION=117.0.0 \
  KUBERNETES_VERSION=v1.5.2 \
  HELM_VERSION=v2.1.3 

RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    bash \
    curl \
    git \
    dnsutils \
    lsb-release \
    wget \
    html-xml-utils \
    && rm -rf /var/lib/apt/lists/*

# Install Google Cloud SDK and kubectl
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" \
    && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && apt-get update && apt-get install -y -q google-cloud-sdk \
    && wget -O /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl

# Install helm
RUN wget http://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz \
  && tar xzf ./helm-${HELM_VERSION}-linux-amd64.tar.gz \
  && mv linux-amd64/helm /usr/local/bin \
  && rm -rf helm-${HELM_VERSION}-linux-amd64.tar.gz linux-amd64

# Install Docker from Docker Inc. repositories.   
 RUN curl -sSL https://get.docker.com/ | sh