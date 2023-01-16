#!/bin/bash 

pod=$1
[ -z "${pod}"  ]  && echo "ERROR: the pod is empty"

namespace=$2 
[ -z "${namespace}" ] &&  namespace='default'

pods=$(kubectl get po -n ${namespace} | grep ${pod} )

if [ -n "${pods}" ]; then 

    ready=$(echo -n "${pods}" | awk '{print $2}')
    ready_min=$(echo -n "${ready}" | awk -F / '{print $1}' )
    ready_max=$(echo -n "${ready}" | awk -F / '{print $2}')   
    status=$(echo -n "${pods}" | awk '{print $3}' )
    
    if  [ "${ready_min}" == "${ready_max}"  ]  && [  "${status}" == "Running" ] ; then 
         echo "the pod is running"
    else 
         echo "the pod is not running the status is:"
         echo "${status}"
         echo "For more info please try to describe the pod!"   
    fi
else 
   
   echo "cannot find the pod, please check the pod name!"
    
    
fi
