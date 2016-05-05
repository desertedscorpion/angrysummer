#!/bin/bash

docker build -t ninthgrimmercury/angrysummer . &&
    docker build -t freakygamma/angrysummer test &&
    docker rm $(docker stop $(docker ps -a -q --filter ancestor=freakygamma/angrysummer --format="{{.ID}}")) &&
    docker rmi --force freakygamma/angrysummer &&
    docker rmi --force ninthgrimmercury/angrysummer &&
    true
