#!/usr/bin/env bash

XDEBUG_CONFIG="idekey=phpstorm" \
PHP_IDE_CONFIG="serverName=app" \
COMPOSER_ALLOW_XDEBUG=1 \
php $@
