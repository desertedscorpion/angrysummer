#!/bin/bash

TEMPDIR=$(mktemp -d) &&
    xsltproc /usr/local/lib/test-master.xslt.xml /usr/local/lib/test-master.xml &&
    for FILE in ${TEMPDIR}/*.xml
    do
	create-job ${FILE} &&
	    true
    done &&
    true