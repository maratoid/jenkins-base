FROM jenkinsci/jnlp-slave

# Install apt managed packages (python, ruby, golang, etc.)
ENV GOROOT=/usr/lib/go
ENV GOLANG_DEB_VERSION=2:1.6.1+1~bpo8+1 \
	GOOGLE_CLOUD_SDK_VERSION=117.0.0 \
	KUBERNETES_VERSION=v1.4.4

USER root
RUN apt-get update --fix-missing --no-install-recommends\
    && apt-get install -y --force-yes \
      lsb-release \
      curl \
      unzip \
      jq \
      ruby \
      ruby-dev \
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
      dnsutils\
    && rm -rf /var/lib/apt/lists/*

# All python modules should be installed here if possible
COPY requirements.txt /tmp
RUN pip install --upgrade pip \
  && pip install --requirement /tmp/requirements.txt\
  && pip install virtualenv \
  && pip install --user jenkins-job-builder \
  && rm /tmp/requirements.txt

# All ruby gems should be installed here if possible
#COPY Gemfile Gemfile.lock /opt/kraken-ci/containers/jenkins/
#RUN gem install bundler \
#  && bundler install --gemfile=/opt/kraken-ci/containers/jenkins/Gemfile


# Install Google Cloud SDK
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" \
    && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && apt-get update && apt-get install google-cloud-sdk \
    && wget -O /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl


# RUN wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GOOGLE_CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
#  && tar xzf google-cloud-sdk-${GOOGLE_CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
#  && rm google-cloud-sdk-${GOOGLE_CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
#  && google-cloud-sdk/install.sh --usage-reporting=false --path-update true --bash-completion true --rc-path ~/.bashrc \
#  && rm -rf /google-cloud-sdk
