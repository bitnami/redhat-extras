#!/bin/bash
. /opt/bitnami/base/functions

print_welcome_page

exec tini -- "$@"

