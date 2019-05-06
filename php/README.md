# [![Linux for PHP Banner](https://linuxforphp.net/download_file/force/30/0)](https://linuxforphp.net/)

https://linuxforphp.net

# Linux for PHP for CI

[![Build Status](https://travis-ci.org/linuxforphp/docker-gitlab-ci.svg?branch=master)](https://travis-ci.org/linuxforphp/docker-gitlab-ci)

[CHANGELOG](https://github.com/linuxforphp/docker-gitlab-ci/blob/master/CHANGELOG.md)

**Linux for PHP** Docker images for continuous integration and running tests. These images can be used with Gitlab CI,
or any automated testing system or as standalone services.

# Supported tags and respective `Dockerfile` links

-	[`5.6-nts`, (*5.6/Dockerfile*)](https://github.com/linuxforphp/docker-gitlab-ci/blob/master/php/5.6/Dockerfile)
-	[`7.0-nts`, (*7.0/Dockerfile*)](https://github.com/linuxforphp/docker-gitlab-ci/blob/master/php/7.0/Dockerfile)
-	[`7.1-nts`, (*7.1/Dockerfile*)](https://github.com/linuxforphp/docker-gitlab-ci/blob/master/php/7.1/Dockerfile)
-	[`7.2-nts`, (*7.1/Dockerfile*)](https://github.com/linuxforphp/docker-gitlab-ci/blob/master/php/7.2/Dockerfile)
-	[`7.3-nts`, (*7.1/Dockerfile*)](https://github.com/linuxforphp/docker-gitlab-ci/blob/master/php/7.3/Dockerfile)

Images do not have `VOLUME` directories since fresh version of sources is supposed to be downloaded into image each time before running tests

These images are built from [Linux for PHP official Docker images](https://hub.docker.com/r/asclinux/linuxforphp-8.1-ultimate), and additionally include:

 - All extensions are compiled and ready and loaded
 - PECL extensions: memcached, redis, mongodb, xdebug
 - sendmail command via msmtp, configured as relay to localhost. Check `/etc/msmtprc` to setup relay server
 - Git client
 - Composer
 - PHPUnit - latest stable version for php >= 5.6 and PHPUnit 4.8 for php < 5.6
 - PHP Code Sniffer - latest stable version of `phpcs` and `phpcbf` commands
 - Node.js v10 from official Node.js repositories

See below for details

## Advantages of these images

 - Builds are based on the official Linux for PHP images (standard C toolchain)
 - Automatically rebuilt when official images are updated, so this repository always contains the latest versions

# Quick start guide

Check the [Quick start guide](https://github.com/linuxforphp/docker-gitlab-ci/blob/master/README.md#quick-start)

Check the [Example projects](https://github.com/linuxforphp/docker-gitlab-ci/tree/master/examples)

## PHP modules
All major modules are enabled by default (compiled-in) and some are installed using PECL

### Compiled-in modules
```
bcmath bz2 calendar ctype curl date dba dom ereg enchant exif fileinfo filter ftp gd gettext gmp hash iconv imap intl json ldap libxml mbstring mcrypt mssql mysqli mysqlnd opcache openssl pcntl pcre pdo pdo_dblib pdo_mysql pdo_pgsql pdo_sqlite pgsql phar posix pspell readline recode reflection session shmop simplexml snmp soap sockets spl sqlite3 standard sysvmsg sysvsem sysvshm tidy tokenizer wddx xml xmlreader xmlrpc xmlwriter xsl zip zlib
```

### Available core modules
```
```

### Available PECL modules
```
memcached mongodb redis xdebug
```

For more information check the [Github repository](https://github.com/linuxforphp/docker-gitlab-ci/)

## Environment variables

There are environment variables which can be passed to images on docker run

 - `WITHOUT_XDEBUG=1` - disables xdebug extension
 - `TIMEZONE=America/New_York` - set system and `php.ini` timezone. You can also set timezone in .gitlab-ci.yml - check [Example](https://github.com/linuxforphp/docker-gitlab-ci/blob/master/examples/purephp/.gitlab-ci.yml)
 - `COMPOSER_GITHUB=<YOUR_GITHUB_TOKEN>` - Adds Github oauth token for Composer, which allows Composer to get unlimited repositories from Github without blocking non-interactive mode with request for authorization. You can obtain your token at [https://github.com/settings/tokens](https://github.com/settings/tokens)

    [Composer documentation about Github API rate limit](https://getcomposer.org/doc/articles/troubleshooting.md#api-rate-limit-and-oauth-tokens)

# FAQ

1. **How to set custom php.ini values**

   Easiest way is to mount your local php.ini on container start like `docker run ... -v /home/user/php.ini:/etc/php.ini ...`
