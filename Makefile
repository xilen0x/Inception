all: create_dirs
	docker compose -f ./srcs/docker-compose.yml up -d --build

create_dirs:
	mkdir -p /home/${USER}/data/wordpress
	mkdir -p /home/${USER}/data/mariadb

up: all

down:
	docker compose -f ./srcs/docker-compose.yml down

clean:
	docker stop $$(docker ps -qa) || true;
	docker rm $$(docker ps -qa) || true;
	docker rmi -f $$(docker images -qa) || true;
	docker volume rm $$(docker volume ls -q) || true;
	docker system prune -a --volumes -f || true;

fclean: clean
	rm -rf /home/${USER}/data/wordpress/* || true;
	rm -rf /home/${USER}/data/mariadb/* || true;

re: down all

.PHONY: all create_dirs up down clean fclean re

