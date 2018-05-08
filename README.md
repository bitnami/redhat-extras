# `bitnami/redhat-extras`

## TL;DR

```dockerfile
FROM bitnami/redhat-extras
```

## About

The `bitnami/redhat-extras` image is a customized base image for use in Bitnami container images and is built on top of the Red Hat Enterprise Linux image. 

The `Dockerfile` installs [Nami](https://github.com/bitnami/nami) and includes a `bitnami-pkg` helper script to simplify downloading of Nami modules from the Bitnami package repositories. Additionally the `Dockerfile` installs [tini](https://github.com/krallin/tini)  and is used in the default [entrypoint](../../blob/master/rootfs/entrypoint.sh).

## Usage

Use like a regular base image.

The following example uses the `install_packages` helper script to install packages from the RedHat repositories using `yum`. The `bitnami-pkg` tool to install `nami` packages published by Bitnami.

```dockerfile
FROM bitnami/redhat-extras:7
ENV BITNAMI_APP_NAME=apache
RUN install_packages wget apr apr-util bzip2-libs glibc \
    libcom_err libcurl expat libffi
RUN bitnami-pkg install apache-2.4.33-0
CMD ["nami", "start", "--foreground", "apache"]
```

## Configuration Parameters

The following tables lists the configurable parameters of the image.

|         Parameter         |                       Description                       |
|---------------------------|---------------------------------------------------------|
| `BASH_DEBUG`              | [Turn on bash debugging](#turn-on-bash-debugging)       |
| `NAMI_DEBUG`              | [Turn on nami debugging](#turn-on-nami-debugging)       |
| `DISABLE_WELCOME_MESSAGE` | [Turn off the welcome text](#turn-off-the-welcome-text) |

### Turn on BASH debugging

Add `BASH_DEBUG=1` to the container environment to enable [BASH debugging](http://wiki.bash-hackers.org/scripting/debuggingtips#use_shell_debug_output) which prints the commands being executed.

### Turn on Nami debugging

To enable debugging add `NAMI_DEBUG=1` to the container environment. The `NAMI_DEBUG` variable enables helpful logging and debugging features which can be valuable for debugging issues.

### Turn off the welcome text

When a new container is launched, a welcome message is displayed as illustrated below:

```console
 *** Welcome to the apache image ***
 *** Brought to you by Bitnami ***
 *** More information: https://github.com/bitnami/bitnami-docker-apache ***
 *** Issues: https://github.com/bitnami/bitnami-docker-apache/issues ***
```

Adding `DISABLE_WELCOME_MESSAGE=1` to the container environment turns off this message.

## Contributing

We'd love for you to contribute to this container. You can request new features by creating an [issue](../../issues/new) or submitting a [pull request](../../issues/pull) with your contribution.

### Issues

If you encountered a problem running this container, you can file an [issue](../../issues/new). Be sure to include the following information in your issue:

- Host OS and version
- Output of:
  + `docker version`
  + `docker info`
- Steps to reproduce the issue
- Logging information with debug mode enabled

## License

Copyright 2015 - 2018 Bitnami

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
