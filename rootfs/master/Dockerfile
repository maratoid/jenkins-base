FROM gcr.io/kubernetes-charts-ci/jenkins-master-k8s:v0.2.0
MAINTAINER Samsung CNCT <john.felten@gmail.com>
VOLUME /var/jenkins_home
VOLUME /etc/jenkins_jobs

USER root
COPY plugins.txt /usr/share/jenkins/plugins.txt

# update jenkins to latest and install kubernetes and other plugins
RUN mkdir -p /usr/share/jenkins/ref/secrets/ \
    && echo "false" > /usr/share/jenkins/ref/secrets/slave-to-master-security-kill-switch \
    && rm -f /usr/share/jenkins/jenkins.war \
    && wget http://mirrors.jenkins-ci.org/war/latest/jenkins.war -P /usr/share/jenkins/ \
    && /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt \
    && apt-get update \
    && apt-get install -y --force-yes html-xml-utils 

User jenkins