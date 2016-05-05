#!/bin/bash

credentials /usr/local/lib/credentials.xml &&
    ssh-key /var/private/id_rsa &&
    create-slave /usr/local/lib/dockerhost.xml &&
    create-job /usr/local/lib/job.xml &&
    true
