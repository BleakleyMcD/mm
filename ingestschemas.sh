#!/bin/bash
SCRIPTDIR=$(dirname $(which "${0}"))
. "${SCRIPTDIR}/mmfunctions"

if [ -d "${1}" ] ; then
    cd "${1}"
else
    Echo "Please use a valid directory for input - Exiting" && exit 0
fi

if [ -z "${PREMIS_NAME}" ] || [ "${PREMIS_DB}" != "Y" ] ; then
    echo "Please configure database options in mmconfig. Exiting"
fi

for i in *.schema ; do
xmlschema="${i}"
MEDIA_ID=$(basename "${xmlschema}" | cut -d'.' -f1)
eventType="ingest"
_report_to_db
_report_schema_db
_eventoutcome_update
done