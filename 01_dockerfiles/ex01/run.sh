#!/bin/bash

docker run -it \
	--name ex01 \
	--user 9987:9987 \
	-p 9987:9987/udp \
	-p 10011:10011 \
	-p 30033:30033 \
	seli_ex01
