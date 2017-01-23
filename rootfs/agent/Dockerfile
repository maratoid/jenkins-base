FROM ubuntu:16.04

# Install apt managed packages (python, ruby, golang, etc.)
ENV GOROOT=/usr/lib/go
ENV GOOGLE_CLOUD_SDK_VERSION=117.0.0 \
  KUBERNETES_VERSION=v1.5.1 \
  HELM_VERSION=v2.1.0 \
  JENKINS_REMOTING_VERSION=2.9 \
  HOME=/home/jenkins

RUN apt-get update -qq && apt-get install -qqy \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables \
    lsb-release \
    jq \
    build-essential \
    libssl-dev \
    libffi-dev \
    git \
    python \
    python-dev \
    python-pip \
    openjdk-9-jre-headless \
    vim \
    rsync \
    dnsutils \
    html-xml-utils \
    && rm -rf /var/lib/apt/lists/*

# Install Golang
RUN add-apt-repository ppa:ubuntu-lxc/lxd-stable --yes \
  && apt-get update -qq \
  && apt-get install golang -qqy

# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

# install the jenkins slave runner
ADD jenkins-slave /usr/local/bin/jenkins-slave
RUN chmod +x /usr/local/bin/jenkins-slave

# Install python modules
COPY requirements.txt /tmp
RUN pip install --upgrade pip \
  && pip install --requirement /tmp/requirements.txt \
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

# install jnlp remoting
RUN curl --create-dirs -sSLo /usr/share/jenkins/remoting-$JENKINS_REMOTING_VERSION.jar http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/$JENKINS_REMOTING_VERSION/remoting-$JENKINS_REMOTING_VERSION.jar \
    && chmod 755 /usr/share/jenkins

VOLUME /var/lib/docker
VOLUME /home/jenkins

CMD ["wrapdocker"]
ENTRYPOINT ["/usr/local/bin/jenkins-slave"]