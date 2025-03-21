all:
	sudo mkdir -p /home/castorga/data/wordpress
	sudo mkdir -p /home/castorga/data/mariadb
	@docker compose -f ./srcs/docker-compose.yml up -d --build

up: all

down:
	@docker compose -f ./srcs/docker-compose.yml down

status:
	@docker ps -a

clean:
	@docker stop $$(docker ps -qa) || true;
	@docker rm $$(docker ps -qa) || true;
	@docker rmi -f $$(docker images -qa) || true;
	@docker volume rm $$(docker volume ls -q) || true;
	@docker system prune -a --volumes -f || true;

fclean: clean
	@rm -rf /home/castorga/data/wordpress/* || true;
	@rm -rf /home/castorga/data/mariadb/* || true;
	
re: down all

.PHONY: all up down status clean fclean re