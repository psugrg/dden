#!/bin/bash
echo "Unistalling DDEN environment"
docker rmi psugrg/dden

if [ $? -eq 0 ]
then
rm $HOME/.local/bin/dden-create.sh $HOME/.local/bin/dden-uninstall.sh
  echo "DDEN environment unistalled"
  exit 0
else
  echo "Could not uninstall DDEN" >&2
  exit 1
fi