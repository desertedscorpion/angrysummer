#!/bin/bash

docker build -t ninthgrimmercury/angrysummer . &&
    docker build -t freakygamma/angrysummer test &&
    if docker run --interactive --tty freakygamma/angrysummer dnf update --assumeyes | grep "^Last metadata expiration check: 0:0"
    then
	echo dnf was updated within the ten minutes &&
	    true
    else
	echo dnf was not updated within the last ten minutes &&
	    exit 64 &&
	    true
    fi &&
    docker run --interactive --tty --privileged --detach --volume /sys/fs/cgroup:/sys/fs/cgroup:ro --volume ${PWD}/test/src:/usr/local/src:ro --volume ${HOME}/.private:/var/private -p 127.88.179.49:29141:8080 freakygamma/angrysummer &&
    sleep 2m &&
    if [[ "HTTP/1.1 200 OK" == $(curl --head http://127.88.179.49:29141 | head --lines 1 | tr -d "[:cntrl:]") ]]
    then
	echo the web page is up &&
	    true
    else
	echo the web page is down &&
	    exit 65 &&
	    true
    fi &&
    docker rm $(docker stop $(docker ps -a -q --filter ancestor=freakygamma/angrysummer --format="{{.ID}}")) &&
    docker rmi --force freakygamma/angrysummer &&
    docker rmi --force ninthgrimmercury/angrysummer &&
    true
