#!/bin/sh

[ -e /usr/bin/aws ] && exit 0 || pip install --upgrade awscli
