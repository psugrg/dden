# The Docker based Development Environment (DDEN)

This project is a base that can be used to create development environments.

This image contains the *environment installation and management scripts*.
A single-line command executed in the container will install the environment
on the development machine (see reference guide for details).

Child image that derives from *DDEN* can be installed and managed by these
scripts making the installation process much easier and *user friendly*.

This image is based on the *ubuntu:rolling* but doesn't install any packages
for you. Every development environment is different and requires different
packages.

## Derived image reference guide

### Derived image preparation

Derived image should be created from the *psugrg/dden* base image:
`FROM psugrg/dden:latest`.

Dockerfile should contain `ENV IMAGE_NAME="<image_name>"` where `<image_name>`
is the name of the Development Environment you're about to create.
This will tell the base image how to configure installation scripts.

It's possible to add extra flags to the `docker create` command run by the
`<image_name>-create.sh` script by adding `ENV DOCKER_CREATE_EXTRA=<extra flags>`
to the Dockerfile.

It's also possible to add extra commands to the `<container_name>-start.sh`
script by adding `ENV DOCKER_START_EXTRA=<extra commands>` to the Dockerfile.
These commands will be executed on host machine just before the `docker start`
command.

The content of the rest of the Dockerfile is in your hands.

#### Derived image example

- [SADEN](https://github.com/psugrg/saden) - reference implementation for the
x86 platform.
- [arm-m-dev](https://github.com/psugrg/arm-m-dev) - reference implementation
for the ARM Cortex M platform.

### Derived image installation

Derived image should be installed via [DUSET](https://github.com/psugrg/duset)
in order to create a development environment with the local user rights.

#### Installing without DUSET

In order to install the environment without local user rights run the following
bash command to install *DDEN type* environment in the `~/.local/bin` folder.

```bash
docker run --rm -v "$HOME/.local/bin:/home/user/.local/bin" \
-u "$(id -u):$(id -g)" \
<image/name> \
install.sh
```

Where:

- `<image/name>` - the name of the derived image that should be installed.
Note that all `/` that are part of the image name will be replaced by `-` in
the name of the installed scripts. Change it to `psugrg/dden` in order to
install this bear image (for test porpoises).

Change the `$HOME/.local/bin` if you want to change the default installation
location.

### Create Development Environment for a project location

Run `<image-name>-create.sh <container_name>` in the project location. Replace
the `<image-name>-create.sh` with the name of the script installed during the
installation process. Use optional *-p* argument to pass the path to the project
location.

This script will create a container (Instance of Development Environment image)
dedicated to this (current or provided) location. It will generate
`<container_name>-start.sh`, `<container_name>.sh`, `<container_name>-stop.sh`,
`<container_name>-remove.sh` scripts.

### Start container

Run `./<container_name>-start.sh` to start container before starting working on
your project.

### Call any command

Run `./<container_name>.sh` script to call any command from the container.

#### Example usage

```bash
./<container_name>.sh echo "Hello World!"
```

This command will be executed inside the container.

### Stop container

Run `./<container_name>-stop.sh` to stop running container.

### Remove container

Run `./<container_name>-remove.sh` to remove container.

### Uninstall

Run `<image-name>-uninstall.sh` to uninstall dden type environment and remove the
image.

## Image Build

Source code is available on [github](https://github.com/psugrg/dden).

Run `./build.sh` to build the image. Use `-r <tag>` option to set a custom tag
(release version) - default `latest`.
