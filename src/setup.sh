#!/bin/bash

credentials /usr/local/lib/credentials.xml &&
    ssh-key /var/private/id_rsa &&
    create-slave /usr/local/lib/dockerhost.xml &&
    dnf install --assumeyes git &&
    create-job /usr/local/lib/test-master.xml &&
    install-plugin git &&
    true
