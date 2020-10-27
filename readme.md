# The Docker based Development Environment (DDEN)
This image is intended to be a base for creating development environments. 

The main feature are the installation and management scripts embedded into the image.
A single-line command executed in the container will install the environment on the development machine (see reference guide for details). 
Child image that derives from *DDEN* can be installed and managed by these scripts making the installation process much easier and *user friendly*.

This image is based on the *ubuntu:rolling* but doesn't install any packages for you. Every development environment is different and requires different packages. 

## Reference guide

### Derived image preparation
Derived image should be created from the *psugrg/dden* base image: `FROM psugrg/dden:latest`.

Dockerfile should contain `ENV IMAGE_NAME="<image_name>"` where `<image_name>` is the name of the Development Environment you're about to create. This will tell the base image how to configure installation scripts.

It's possible to add extra flags to the `docker create` command run by the `<image_name>-create.sh` script by adding `ENV DOCKER_CREATE_EXTRA=<extra flags>` to the Dockerfile. 

It's also possible to add extra commands to the `<container_name>-start.sh` script by adding `ENV DOCKER_START_EXTRA=<extra commands>` to the Dockerfile.

The content of the rest of the Dockerfile is in your hands.

### Installation
Run `docker run --rm -v "$HOME/.local/bin:/home/user/.local/bin" -u "$(id -u):$(id -g)" psugrg/dden install.sh` to install *DDEN* Environment in the *$HOME/.local/bin* folder.

Change `/home/user/.local/bin` if you want to change the default installation location.

For derived image replace the `psugrg/dden` with its name. Note that all `/` that are part of the image name will be replaced by `-` in the name of the installed scripts.

### Create Development Environment for a project location
Run `psugrg-dden-create.sh <container_name>` in the project location, or use the optional *-p* argument to pass the path to the project location. This script will create container (Instance of Development Environment image) dedicated to this (current or provided) location. This script will generate <container_name>-start.sh <container_name>.sh <container_name>-stop.sh <container_name>-remove.sh scripts.

For derived image replace the `psugrg-dden-create.sh` with the name of the script installed during the installation process. 

### Start container 
Run `./<container_name>-start.sh` to start container before starting working on your project.

### Call any command
Run `./<container_name>.sh` script to call any command from the container. 

#### Example usage

```
./<container_name>.sh echo "Hello World!"
```
This command will be executed inside the container. 

### Stop container
Run `./<container_name>-stop.sh` to stop running container.

### Remove container
Run `./<container_name>-remove.sh` to remove container.

### Uninstall
Run `psugrg-dden-uninstall.sh` to uninstall dden environment and remove dden image.

For derived image replace the `psugrg-dden-create.sh` with the name of the script installed during the installation process. 

## Image Build
Source code is available in `https://bitbucket.org/psu82/dden/src/master/`.

Run `./build.sh` to build the image. Use -r option to set a custom tag (release version) - default 'latest'.
