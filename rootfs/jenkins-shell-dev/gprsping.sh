#/bin/sh

UNUSED=("ac-staging-internal-lb", "10.142.15.204:30203",
"gtc-staging-internal-lb", "10.142.15.203:30222",
"gprsd-staging-internal-lb", "10.142.15.201:30162",
"test-internal-lb", "10.142.15.111:30091" )

# NOTE: These pod IP addresses, the one's at the end of the line,
#       are only valid for the life of the current pod.  They need
#       to be updated every time the pod restarts.
VIPS=( 
"admin-console-internal-lb" "10.142.14.100:30100" "TCP" "10.64.1.2:80"
"gprsd-internal-lb" "10.142.15.14:30062" "UDP" "10.64.3.6:9827" 
"gtc-internal-lb" "10.142.14.102:30102" "TCP" "10.64.3.4:80"
"jenkins-internal-lb" "10.142.15.15:30061" "TCP" "10.64.8.128:8080"
"postgres-internal-lb" "10.142.15.13:30064" "TCP" "10.64.21.4:5432"
)

VIPS_LEN=${#VIPS[@]}

echo "Running VIP connectivity check"
echo "*** curl -V ***"
curl -V
echo "*** *** *** *** *** Begin Test *** *** *** *** ***"
for (( i=0; i<${VIPS_LEN}; i+=4 ));
do
  echo "***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** "
  echo "----> Attempting to contact load balancer: ${VIPS[$i]}, at: ${VIPS[$i+1]}, proto: ${VIPS[$i+2]} **** "
  lbip=$( echo ${VIPS[$i+1]} | cut -d\: -f1 )
  lbport=$( echo ${VIPS[$i+1]} | cut -d\: -f2 )
  if [ "${VIPS[$i+2]}" == "TCP" ]; then
    echo "----> curl --connect-timeout 10 -m 15 -vsk http://${VIPS[$i+1]}/"
    curl --connect-timeout 10 -m 15 -vsk http://${VIPS[$i+1]}/
  else 
    echo "----> nc -w 10 -n -v ${lbip} ${lbport}"
    nc -w 10 -n -v ${lbip} ${lbport}
  fi 
  echo "----> traceroute load balancer ip: ${lbip}"
  traceroute ${lbip}


  echo "----> Attempting to contact service directly at pod address: ${VIPS[$i+3]} **** "
  podip=$( echo ${VIPS[$i+3]} | cut -d\: -f1 )
  podport=$( echo ${VIPS[$i+3]} | cut -d\: -f2 )
  if [ "${VIPS[$i+2]}" == "TCP" ]; then
    echo "----> curl --connect-timeout 10 -m 15 -vsk http://${VIPS[$i+3]}/"
    curl --connect-timeout 10 -m 15 -vsk http://${VIPS[$i+3]}/
  else 
    echo "----> nc -w 10 -n -v ${podip} ${podport}"
    nc -w 10 -n -v ${podip} ${podport}
  fi 

  echo "----> traceroute pod ip: ${podip}"
  traceroute ${podip}
  if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo "----> get route for pod ip: ${podip}"
    ip route get ${podip}   
  fi
  echo "----> ping -c 3 ${podip}"
  ping -c 3 ${podip}
done

