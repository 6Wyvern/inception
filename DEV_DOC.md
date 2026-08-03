# ARCHITECTURE

The project contains three containers:

	MariaDB: Stores the Wordpress database. Port 3306, internal.

	WordPress + PHP-FPM: The application logic. Port 9000, internal.

	NGINX: Hosts the web server. Port 443.

# STRUCTURE

The following structure is strongly encouraged, if not directly required:

├── Makefile
├── secrets/
└── srcs/
	├── docker-compose.yml
	├── .env
	└── requirements/
		├── mariadb/
		├── nginx/
		└── wordpress/

# ENVIRONMENT

You'll have to set up a .env with some variables. Do note you should NOT put any passwords here, those will go in the secrets/ folder.

# LAUNCH AND MANAGE

Before setting up the environment, ensure Docker is installed by running ```run docker --version```

To build all the images, run ```Make``` on the root folder or ```docker compose build``` on srcs/

To run Inception, run ```Make up``` on the root folder or ```docker compose up``` on srcs/

To stop the project, run ```Make down``` on the root folder or ```docker compose down``` on srcs/

If you wish to instead close the containers and clear all data, run ```Make fclean```

You can check all containers are running with the command ```docker compose -f srcs/docker-compose.yml ps```

# DATA STORAGE

Docker named volumes are used for persistent storage. They are backed by directories under $HOME/data on the host and mounted into the containers. Declared volumes are on docker-compose.yml, or you can run ```docker volum ls``` in srcs/