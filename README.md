# [![Linux for PHP Banner](https://linuxforphp.net/download_file/force/30/0)](https://linuxforphp.net/)

https://linuxforphp.net

# Linux for PHP CI Kit for GitLab using Docker

[![Build Status](https://travis-ci.org/linuxforphp/docker-gitlab-ci.svg?branch=master)](https://travis-ci.org/linuxforphp/docker-gitlab-ci)

This repository contains a set of utilities for running PHP tests via [GitLab CI](https://about.gitlab.com/gitlab-ci/).

These tools provide:

1. [GitLab Runner](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner) deployment script for Ubuntu on VM or metal server. It is not recommended to install runner right on the production system.

2. Set of Docker images for PHP 5.6 - 7.3 based on official Linux for PHP Docker images, with all essential PHP modules. The images also include Node.js.

The goal of these tools is to automate as much as possible the routine work that is related to configuring the GitLab Runner, so you can concentrate on writing tests for your code.
Also these tools are trying to be resource savvy, since in most cases, huge in-RAM caches are not needed for only running unit tests with some fixtures. So, very small VMs can be suitable for running tests.

## Contents of repository
 - [gitlab-runner bootstrap script](https://github.com/linuxforphp/docker-gitlab-ci/tree/master/gitlab-runner-vm) for deploying GitLab Runner.
 - [PHP Docker images](https://github.com/linuxforphp/docker-gitlab-ci/tree/master/php) - based on official Linux for PHP images, including all major modules and extensions. Also, PHP 5.6 is available.
 - [Example projects](https://github.com/linuxforphp/docker-gitlab-ci/tree/master/examples) - Example PHP test script.

## Quick start

1. Install [GitLab](https://about.gitlab.com/),
2. Get a server (VM or metal) with minimal Ubuntu-14.04 installed. It will be used for the runner.
3. Login as root to a server and execute `curl -S https://raw.githubusercontent.com/linuxforphp/docker-gitlab-ci/master/gitlab-runner-vm/bootstrap.sh | bash` and answer the questions. This script will install Docker, the Gitlab Runner, and configure the Runner for using these Docker images.

Runner is limited to `asclinux/linuxforphp-8.1-ultimate:*` images for main container (where your repository is cloned) and any service images `*/*` (secondary containers that are spun up for services, like MySQL, Redis, etc).

If you want to use the server for also running other images (`ruby` or whatever), you can add other runners to `/etc/gitlab-runner/config.toml`. Please DO NOT overwrite `allowed_images = ["asclinux/linuxforphp-8.1-ultimate:*"]` for this runner, since it is a potential security breach.

Moreover, many services and languages are already available from within the **Linux for PHP** Docker images. Thus, by adding the appropriate `RUN` commands in the container's `Dockerfile`, one can launch all the needed services to quickly run a set of tests (Ruby, Python, Java, Node.js, Mongo server, Redis server, PostgreSQL server, etc.).

## Requirements
 - Gitlab v`9.0` and later
 - Gitlab runner v`9.0` and later

## Similar projects
 - https://github.com/bobey/docker-gitlab-ci-runner (For legacy gitlab-ci-runner)
