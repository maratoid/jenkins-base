FROM jenkinsci/jnlp-slave

# Install apt managed packages (python, ruby, golang, etc.)
ENV GOROOT=/usr/lib/go
ENV GOLANG_DEB_VERSION=2:1.6.1+1~bpo8+1 \
  GOOGLE_CLOUD_SDK_VERSION=117.0.0 \
  KUBERNETES_VERSION=v1.5.1 \
  HELM_VERSION=v2.1.0 \
  DOCKER_VERSION=1.11.2

USER root
RUN apt-get update --fix-missing --no-install-recommends\
    && apt-get install -y --force-yes \
      lsb-release \
      curl \
      unzip \
      jq \
      build-essential \
      libssl-dev \
      libffi-dev \
      git \
      python \
      python-dev \
      python-pip \
      vim \
      golang-doc=${GOLANG_DEB_VERSION} \
      golang-go=${GOLANG_DEB_VERSION} \
      golang-src=${GOLANG_DEB_VERSION} \
      rsync \
      dnsutils \
      html-xml-utils\
    && rm -rf /var/lib/apt/lists/*

# All python modules should be installed here if possible
COPY requirements.txt /tmp
RUN pip install --upgrade pip \
  && pip install --requirement /tmp/requirements.txt\
  && rm /tmp/requirements.txt

# Install Google Cloud SDK
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" \
    && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && apt-get update && apt-get install -y --force-yes google-cloud-sdk \
    && wget -O /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl

# Install helm
RUN wget http://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz \
  && tar xzf ./helm-${HELM_VERSION}-linux-amd64.tar.gz \
  && mv linux-amd64/helm /usr/local/bin \
  && rm -rf helm-${HELM_VERSION}-linux-amd64.tar.gz linux-amd64

# Install docker client
RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz \
  && tar --strip-components=1 -xvzf docker-${DOCKER_VERSION}.tgz -C /usr/local/bin \
  && rm docker-${DOCKER_VERSION}.tgz