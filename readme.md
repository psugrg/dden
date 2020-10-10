# README #

## The Docker based Development Environment - Base repository ##

The simple approach to the docker based development environment. 

The main intention of this project is to create a simple to use, self contained development environment.

This repository acts as a starting point for the actual, more sophisticated environments. 

## Quick reference guide ##

TODO: Reference guide will be updated!

### Image Build and Setup
Run `./setup.sh` to build the image. This script will generate <name>-create.sh and <name>-remove-image.sh scripts. 

### Create container
Run `<name>-create.sh <container_name>` in the project location, or use the optional -p argument to pass the path to the project location. This script will create container (DevEnv instance) dedicated to this (current or provided) location. This script will generate <container_name>-start.sh <container_name>-exec.sh <container_name>-stop.sh <container_name>-remove.sh scripts

### Start container 
Run `./<container_name>-start.sh` to start container before starting working on your project

### Call any command
Use `./<container_name>.sh` script to call any command from the container. 

#### Example usage

```./<container_name>.sh echo "Hello World!"```
This command will be executed inside the container. 

### Stop container
Run `./<container_name>-stop.sh` to stop running container

### Remove container
Run `<container_name>-remove.sh` to remove container
