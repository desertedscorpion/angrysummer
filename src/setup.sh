#!/bin/bash

credentials /usr/local/lib/credentials.xml &&
    ssh-key /var/private/id_rsa &&
    create-slave /usr/local/lib/dockerhost.xml &&
    dnf install --assumeyes git &&
    TEMPDIR=$(mktemp -d) &&
    xsltproc --output ${TEMPDIR}/test-master.xml && /usr/local/lib/test-master.xslt.xml /usr/local/lib/test-master.xml &&
    create-job ${TEMPDIR}/test-master.xml &&
    install-plugin git &&
    true
