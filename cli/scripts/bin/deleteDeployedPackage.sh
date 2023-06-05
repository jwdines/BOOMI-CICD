#!/bin/bash

source bin/common.sh 

# mandatory arguments
ARGUMENTS=(deploymentId)
inputs "$@"
if [ "$?" -gt "0" ]
then
        return 255;
fi
echov "$@"

URL=$baseURL/DeployedPackage/${deploymentId} 
deleteAPI
clean
if [ "$ERROR" -gt "0" ]
then
   return 255;
fi
