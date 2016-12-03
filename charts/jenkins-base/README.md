# Zonar jenkins

###Based loosely on the kubernetes/helm charts/stable/jenkins

##This chart will install a jenkins master set up to run CI for the Samsung CNCT zonar project.  It is designed to be used to the github repo samsung-cnct/zonar-ci-jobs. To change the job repo modify the Jenkins.Master.JobsRepo value to point to your repository.

## Architecture

There are three components installed by this chart:
	* A Jenkins master server set up to use the kubernetes plugin.  All tasks are spun up on slaves spun up in the kubernetes cluster that the chart is running on.
	* An Nginx proxy for SSL - This is exposed on the public internet.  A DNS entry is genreated after the public IP becomes available
	* A Lets encrpyt proxy service - Runs on Nginx and handles cert gerneation and management.Will automatically refresh the cert when it expires in 30 days.

## Installation

### from the Zonar charts helm repo

		helm repo add zonar http://charts.zonar.cnct.io
		helm install zonar/zonar-jenkins

### or git clone and install locally

		helm install <CHART_DIR>

## Configuration

### Secrets
Secrets are required to use this chart, and are currently stored in a gs bucket (zonar_secrets).  These secrets contain: ssh keeys used to connect to github, gcloud service account keys, and credential information for ZonarBot, the github account used for automated CD.
To install the required secrets connect to the desried kubernetes cluster and clone zonar utils project and execute:

		zonar-utils/scripts/secrets/create-secrets.sh --bucket <name of gs bucket containing secrets.yaml file>
		
This script will install files from the zonar secret bucket to your kubernetes cluster.

### DNS
By default the chart automatically creates a DNS entry for jenkins-test.zonar.cnct.io. Please change or override the DNS name under Nginx.domain in zonar_jenkins/values.yaml.  Otherwise you may override someone else's dns entry.

### SSL certficates
Real SSL certificate generation is handled by the LetsEncrypt pod that is installed as part of this chart.  Currently certificate generation is a manual process.  Real certificates cannot be generated until DNS is complete and the web server is reacheable by the letsencrypt servers.  

To genreate new certs get the name of the lets encrpyt pod for your helm install Ex:

		$kubectl get pods
		NAME                                      READY     STATUS    RESTARTS   AGE
		imprecise-duck-jenkins-1815430777-b4nr3   1/1       Running   1          7d
		imprecise-duck-letsencry-7n9ij            1/1       Running   0          7d
		imprecise-duck-nginx-516315889-9z2c1      1/1       Running   0          11h
		
Then run the refresh_certs.sh on that pod Ex:

		kubectl exec -it imprecise-duck-letsencry-7n9ij refresh_certs.sh
