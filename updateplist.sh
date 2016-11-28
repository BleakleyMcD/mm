#!/usr/bin/env bash
SCRIPTDIR=$(dirname "${0}")
MM_CONFIG_FILE="${SCRIPTDIR}/mm.conf"
if [ -f "${MM_CONFIG_FILE}" ] ; then
    . "${MM_CONFIG_FILE}"
    . "${SCRIPTDIR}/mmfunctions"
else
    exit
fi

if [ "$PREMIS_PLIST" = "1" ] ; then
    _open_mysql_plist
fi