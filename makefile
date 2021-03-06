ImageName?=gitlab/gitlab-ce
ContainerName?=devGitLab
MKFILE := $(abspath $(lastword $(MAKEFILE_LIST)))
CURDIR := $(dir $(MKFILE))

init:
	mkdir volume
	mkdir volume/data
	mkdir volume/logs
	mkdir volume/config

login:
	docker exec -it ${ContainerName} /bin/bash

log:
	docker logs -f -t --tail 20 ${ContainerName}

stop:
	docker stop ${ContainerName}
run:
	docker run -d --restart=always --name ${ContainerName} \
	-p 10080:80 -p 10022:22 \
	-v ${CURDIR}volume/data:/var/opt/gitlab:Z \
	-v ${CURDIR}volume/logs:/var/log/gitlab:Z \
	-v ${CURDIR}volume/config:/etc/gitlab:Z \
	--env-file ${CURDIR}envfile \
	${ImageName}
