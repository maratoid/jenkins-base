FROM gcr.io/kubernetes-charts-ci/jenkins-master-k8s:v0.2.0
MAINTAINER John Felten <john.felten@gmail.com>
VOLUME /var/jenkins_home
VOLUME /etc/jenkins_jobs


# jenkins kubernetes plugin
RUN /usr/local/bin/install-plugins.sh kubernetes:0.8 workflow-aggregator:2.4 credentials-binding:1.9 git:3.0.0 \
    && mkdir -p /usr/share/jenkins/ref/secrets/ \
    && echo "false" > /usr/share/jenkins/ref/secrets/slave-to-master-security-kill-switch

# Preload host keys for github.com
#RUN ssh-keyscan -H github.com >> /root/.ssh/known_hosts

# Install Jenkins plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt


