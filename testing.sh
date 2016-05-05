#!/bin/bash

docker build -t ninthgrimmercury/angrysummer . &&
    docker build -t freakygamma/angrysummer test &&
    if docker run --interactive --tty freakygamma/easternmoose dnf update --assumeyes | grep "^Last metadata expiration check: 0:00:"
    then
	echo dnf was updated within the last hour &&
	    true
    else
	echo dnf was not updated within the last hour &&
	    exit 64 &&
	    true
    fi &&
    docker rm $(docker stop $(docker ps -a -q --filter ancestor=freakygamma/angrysummer --format="{{.ID}}")) &&
    docker rmi --force freakygamma/angrysummer &&
    docker rmi --force ninthgrimmercury/angrysummer &&
    true
