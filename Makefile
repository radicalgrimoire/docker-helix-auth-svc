STACK=auth-svc
COMPOSE_FILE=docker-compose.yml
CONTAINER=helix-auth-svc

start:
	docker-compose -f ${COMPOSE_FILE} -p ${STACK} up -d
stop:
	docker-compose -p ${STACK} stop
remove:
	docker-compose -p ${STACK} down
logs:
	docker-compose -p ${STACK} logs -f
shell:
	winpty docker exec -it ${CONTAINER} bash

build:
	docker-compose -f ${COMPOSE_FILE} build
rebuild:
	docker-compose -f ${COMPOSE_FILE} build --no-cache

net:
	docker network create helixcore_app_net

