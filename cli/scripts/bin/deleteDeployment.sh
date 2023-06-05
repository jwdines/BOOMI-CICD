#!/bin/bash
source bin/common.sh

# get atom id of the by atom name
# mandatory arguments
ARGUMENTS=(env componentName componentType packageVersion)
OPT_ARGUMENTS=(extractComponentXmlFolder tag)

inputs "$@"
if [ "$?" -gt "0" ]
then
        return 255;
fi

savePackageVersion=${packageVersion}

source bin/queryEnvironment.sh env="$env" classification="*"
saveEnvId=${envId}

source bin/queryComponentMetadataName.sh componentName="${componentName}" componentType=${componentType} 

source bin/queryPackagedComponent.sh componentId=${componentId} componentType=${componentType} packageVersion=${packageVersion}

source bin/queryDeployedPackageActive.sh packageId=${packageId} envId=${saveEnvId} version=${savePackageVersion} active="true"

echov "deploymentId=${deploymentId}"

if [[ -z "$deploymentId" ]]
then
  return 255;
fi

source bin/deleteDeployedPackage.sh deploymentId=${deploymentId}

if [ "$ERROR" -gt "0" ]
then
  return 255;
fi

clean
