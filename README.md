# Jenkins Base Helm Chart

Jenkins cluster utilizing the Jenkins Kubernetes plugin

* https://github.com/samsung-cnct/jenkins-base

## Chart Details
This chart will do the following:

* 1 x Jenkins Master with port 8080 exposed
* All using Kubernetes Deployments

## Configuration

The following tables lists the configurable parameters of the Jenkins chart and their default values.

### GitHub, Jenkins, or LDAP Authentication, images
| Parameter | Description | Default |
| --- | --- | --- |
| `adminEmail` | Administrator email address | `me@email.com` |
| `adminPassword` | Administrator account password | `admin` |
| `adminUser` | Administrator account username | `admin` |
| `javaOptions` | Java runtime options | `-Xms1024m -Xmx1024m -Djenkins.install.runSetupWizard=false` |
| `jenkinsUrl` | Jenkins URL | `jenkins.cnct.io` |
| `jobsRepo` | Jenkins jobs repo | `https://github.com/pipeline-jobs` |
| `jenkinsHookUrl` | Jenkins web url | `optional` |
| `workflowRepo` | Jenkins jobs repo | `https://github.com/samsung-cnct/cnct-pipeline-library` |
| `seedJobToken` | Seed job token | `seed` |
| `security` | Security type (`github`, `jenkins`, or `ldap`) | `jenkins` |
| `adminUserSalt` | Admin user salt; change if using Jenkins security | `change me if using jenkins security` |
| `images.gradle` | Image name with gradle tools installed | `set me` |
| `images.agent` | Image name with gke tools installed | `set me` |
| `images.master` | Master jenkins image | `set me` |


### Slack
| Parameter | Description | Default |
| --- | --- | --- |
| `slack.slackDomain` | Slack domain | `change me` |
| `slack.slackRoom` | Slack room name | `#ping-jenkins` |
| `slack.slackApiToken` | Slack API token | `change me` |

### GitHub
| Parameter | Description | Default |
| --- | --- | --- |
| `github.githubClientId` | GitHub client Id | `change me` |
| `github.githubAccessToken` | GitHub access token | `change me` |
| `github.githubUserName` | GitHub user name | `change me` |
| `github.githubClientKey` | GitHub client key | `change me` |
| `github.admin_usernames` | GitHub admin usernames | `change me` |

### GKE
| Parameter | Description | Default |
| --- | --- | --- |
| `gke.clusterName` | GKE cluster name | `production-cluster` |
| `gke.clusterPrimaryZone` | GKE cluster primary zone | `us-east1-b` |
| `gke.gkeProject` | GKE project | `change me` |
| `gke.svcAccountId` | GKE service account Id | `change me` |
| `gke.svcAccountKey` | GKE service account key | `change me` |

### SSH
| Parameter | Description | Default |
| --- | --- | --- |
| `ssh.sshPrivateKey` | SSH private key | `change me` |
| `ssh.sshPublicKey` | SSH public key | `change me` |

### Persistence
| Parameter | Description | Default |
| --- | --- | --- |
| `persistence.component` |  | `data_volume` |
| `persistence.enabled` | Enable the use of a Jenkins PVC | `false` |
| `persistence.storageClass` | The PVC storage class | `generic` |
| `persistence.accessMode` | The PVC access mode | `ReadWriteOnce` |
| `persistence.size` | The size of the PVC | `8Gi` |

### LDAP
| Parameter | Description | Default |
| --- | --- | --- |
| `ldap.ldapServer` | LDAP server |  |
| `ldap.rootDN` | Root DN |  |
| `ldap.userSearchBase` | User search base |  |
| `ldap.userSearchFilter` | User search filter | `uid={0}` |
| `ldap.groupMembershipFilter` | Group membership filter |  |
| `ldap.managerDN` | Manager DN |  |
| `ldap.managerDNPassword` | Manager DN password | `change me` |

### Agent
| Parameter | Description | Default |
| --- | --- | --- |
| `agent.cpu` | Agent requested cpu | `200m` |
| `agent.memory` | Agent requested memory | `1024Mi` |
| `agent.port` | Agent requested port | `50000` |

### Master
| Parameter | Description | Default |
| --- | --- | --- |
| `master.cpu` | Master requested cpu | `200m` |
| `master.memory` | Master requested memory | `1024Mi` |
| `master.port` | k8s service port | `8080` |
| `master.serviceType` | k8s service type | `NodePort` |
| `master.nodePort` | k8s node port | `30061` |

### Helm
| Parameter | Description | Default |
| --- | --- | --- |
| `helm.svcAccountId` | Helm service account Id | `change me` |
| `helm.svcAccountKey` | Helm service account key | `change me` |
