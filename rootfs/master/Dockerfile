FROM jenkins
MAINTAINER Samsung CNCT <john.felten@gmail.com>

ARG JENKINS_VERSION
ENV JENKINS_VERSION ${JENKINS_VERSION:-2.40}

VOLUME /var/jenkins_home
VOLUME /etc/jenkins_jobs

USER root
COPY plugins.txt /usr/share/jenkins/plugins.txt

# update jenkins to latest and install kubernetes and other plugins
RUN mkdir -p /usr/share/jenkins/ref/secrets/ \
    && echo "false" > /usr/share/jenkins/ref/secrets/slave-to-master-security-kill-switch \
    && rm -f /usr/share/jenkins/jenkins.war \
    && wget https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war -P /usr/share/jenkins/jenkins.war \
    && /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt \
    && apt-get update \
    && apt-get install -y --force-yes html-xml-utils 

User jenkins