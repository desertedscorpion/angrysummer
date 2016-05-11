#!/bin/bash

TEMPDIR=$(mktemp -d) &&
    xsltproc --stringparam root ${TEMPDIR} /usr/local/lib/test-master.xslt.xml /usr/local/lib/test-master.xml &&
    for FILE in ${TEMPDIR}/*.xml
    do
	create-job ${FILE} &&
	    true
    done &&
    side-line side-easternmoose git@github.com:desertedscorpion/easternmoose.git &&
    side-line side-needlessbeta git@github.com:desertedscorpion/needlessbeta.git &&
    side-line side-solidpostal git@github.com:desertedscorpion/solidpostal.git &&
    side-line side-angrysummer git@github.com:desertedscorpion/angrysummer.git &&
    true
