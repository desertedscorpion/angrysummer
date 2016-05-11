#!/bin/bash

docker build -t ninthgrimmercury/angrysummer . &&
    docker build -t freakygamma/angrysummer test &&
    if docker run --interactive --tty freakygamma/angrysummer dnf update --assumeyes | grep "^Last metadata expiration check: 0:0"
    then
	echo dnf was updated within the last ten minutes &&
	    true
    else
	echo dnf was not updated within the last ten minutes &&
	    exit 64 &&
	    true
    fi &&
    docker run --interactive --tty --privileged --detach --volume /sys/fs/cgroup:/sys/fs/cgroup:ro --volume ${PWD}/src:/usr/local/src:ro --volume ${HOME}/.private:/var/private -p 127.88.179.49:29141:8080 freakygamma/angrysummer &&
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
    if [[ "HTTP/1.1 200 OK" == $(curl --head http://127.88.179.49:29141/credential-store/domain/_/credential/79ad7607-ef6e-4e5f-a139-e633aded192b/ | head --lines 1 | tr -d "[:cntrl:]") ]]
    then
	echo the credentials were added &&
	    true
    else
	echo the credentials were not added &&
	    exit 66 &&
	    true
    fi &&
    sleep 1m &&
    if [[ "HTTP/1.1 200 OK" == $(curl --head http://127.88.179.49:29141/computer/dockerhost/ | head --lines 1 | tr -d "[:cntrl:]") ]]
    then
	echo the slave was added &&
	    true
    else
	echo the slave was not added &&
	    exit 67 &&
	    true
    fi &&
    sleep 6m &&
    if [[ "HTTP/1.1 200 OK" == $(curl --head http://127.88.179.49:29141/job/test-master/ | head --lines 1 | tr -d "[:cntrl:]") ]]
    then
	echo the job was added &&
	    true
    else
	echo the job was not added &&
	    exit 68 &&
	    true
    fi &&
    sleep 20m &&
    if [[ "HTTP/1.1 200 OK" == $(curl --head http://127.88.179.49:29141/job/test-master/ws/data.txt/*view*/ | head --lines 1 | tr -d "[:cntrl:]") ]]
    then
	echo the job built &&
	    true
    else
	echo the job did not build &&
	    exit 69 &&
	    true
    fi &&
    docker rm $(docker stop $(docker ps -a -q --filter ancestor=freakygamma/angrysummer --format="{{.ID}}")) &&
    docker rmi --force freakygamma/angrysummer &&
    docker rmi --force ninthgrimmercury/angrysummer &&
    true
