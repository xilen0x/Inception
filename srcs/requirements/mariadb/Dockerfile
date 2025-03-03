#	_Dockerfile:mariadb                                                

FROM	debian:bullseye

#This container will be listening on port 3306
EXPOSE	3306

#install mariadb-server. The flags are used to avoid installing unnecessary packages.
#The rm -rf is used to clean the apt cache and avoid unnecessary files in the image.
RUN		apt update -y && \
		apt install -y --no-install-recommends --no-install-suggests \
		mariadb-server && \
		rm -rf /var/lib/apt/lists/*

#Copy the configuration file to the container 
COPY	conf/server_conf.cnf /etc/mysql/mariadb.conf.d/

#Copy the setup script to the container
COPY	tools/setup.sh /bin/
RUN		chmod +x /bin/setup.sh

#Run the setup script and start the mariadb server
CMD ["/bin/setup.sh", "mysqld_safe"]
