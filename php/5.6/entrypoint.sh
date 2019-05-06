#!/bin/bash
set -e

# With env variable WITHOUT_XDEBUG=1 xdebug extension will be disabled
[ ! -z "$WITHOUT_XDEBUG" ] &&
export PHP_ZEND_EXTENSION_DIR = $( php -i | grep extensions | awk '{print $3}' ) &&
sed -i "s/zend_extension=${PHP_ZEND_EXTENSION_DIR//\//\\\/}\/xdebug.so/;zend_extension=${PHP_ZEND_EXTENSION_DIR//\//\\\/}\/xdebug.so/" /etc/php.ini

# Provide github token if you are using composer a lot in non-interactive mode
# Otherwise one day it will get stuck with request for authorization
# https://github.com/settings/tokens
if [[ ! -z "$COMPOSER_GITHUB" ]]
then
  composer config --global github-oauth.github.com "$COMPOSER_GITHUB"
fi

#
# If $TIMEZONE variable is passed to the image - it will set system timezone
# and php.ini date.timezone value as well
# Overwise the default system Etc/UTC timezone will be used
#
# Also you can set the php timezone with direct setting it in php.ini
# within your .gitlab-ci.yml like
# before_script:
# - sed -i "s/;date.timezone =/date.timezone = America\/New_York/" /etc/php.ini

if [[ ! -z "$TIMEZONE" ]]; then
  echo "$TIMEZONE" > /etc/timezone
  cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime
  sed -i "s/;date.timezone =/date.timezone = ${TIMEZONE//\//\\\/}/" /etc/php.ini
fi

exec "$@"
