#!/bin/bash
echo "Installation start"

if [ ${IMAGE_NAME} == "" ]
then 
echo "WARNING: It looks like you're installing the base DDEN environment which is not intended to be run standalone!"
IMAGE_NAME="psugrg/dden"
fi

# Replace '/' in the image name with '-' to avoid problems with scripts
# Note that the standard / delimeter has been replaced by , (comma) to avoid problems with slash in the image name
ENV_NAME=$(echo "${IMAGE_NAME}" | sed -e "s,/,-,")

sed -e "s,{{ image_name }},${IMAGE_NAME}," -e "s,{{ docker_create_Extra }},${DOCKER_CREATE_EXTRA}," -e "s,{{ docker_Start_Extra }},${DOCKER_START_EXTRA}," \
     /usr/src/create.tmpl > /home/user/.local/bin/${ENV_NAME}-create.sh
chmod +x /home/user/.local/bin/${ENV_NAME}-create.sh

sed -e "s,{{ image_name }},${IMAGE_NAME}," -e "s,{{ env_name }},${ENV_NAME},g" /usr/src/uninstall.tmpl > /home/user/.local/bin/${ENV_NAME}-uninstall.sh
chmod +x /home/user/.local/bin/${ENV_NAME}-uninstall.sh

echo "Done"