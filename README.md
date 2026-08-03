*This project has been created as part of the 42 curriculum by manualva.*

# DESCRIPTION

Inception is a project to help you understand how to build containers and use Docker Compose to set up a web insfrastructure inside your own Virtual Machine.

## CONTAINERS AND DOCKER
A container is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another. Docker is a way to build and run those containers.

## .YML FILE
A .yml is a file used to define and build multiple containers in a Docker environment, allowing you to establish connections, configuration and services.

## DOCKERFILE
A Dockerfile is a text document that contains all the commands a user calls on the command line to assemble an image. Docker builds images automatically by reading the instructions from a Dockerfile. It uses commands such as RUN, COPY, or EXPOSE.

## MARIADB
MariaDB Server is a general purpose open-source relational database management system. It serves as a fast compatible  replacement for MySQL, and is used by major platforms such as Google and Wikipedia.

## WORDPRESS
WordPress is a free, open-source content management system that is used to build and manage websites and blogs without the need to write code.

## NGINX
NGINX is an open-source web server, reverse proxy and load balancer, which allows to host domains. 

# INSTRUCTIONS

A basic guide will be provided in this README. However, you can read DEV_DOC.md and USER_DOC.md for more specific information.

## STARTING UP THE PROJECT
First, we'll download the ISO image using the link provided below. As of making this prokect, the last stable version was Debian 13 Trixie, so the version to be downloaded was Debian 12 bookworm.
https://www.debian.org/distrib/index.es.html

Once downloaded, a machine will be created using Oracle VM VirtualBox. It's recommended to configure the hardware to Base Memory: 4096MB, and 2 processors.

Afterwards, we'll install Docker, and start building our project. Since our VM will have less resources and programs than our physical machine, I would recommend to use Github to upload the files.

## EXECUTING DOCKER
Once Docker is installed and you have a docker-compose.yml, you can start it up by either using Make (recommended), or by entering in the srcs/ directory 'docker compose -f up'. If you want to use Docker commands on the root directory, you can either type them like 'docker compose -f srcs/docker-compose.yml up', or add them to your Makefile if you frequently use them.

## IMPORTANT COMMANDS
```docker compuse up --build``` starts up the containers

```docker compose ps``` prints a list of containers

```docker logs (container)``` prints logs of specified container

```docker compose down``` shuts down containers

```docker system prune -f``` cleans containers

```docker exec -it (container) bash``` enters the container, allowing to use commands within it

# RESOURCES

Gemartin's Github page contains all the information you'd need for the project in an easy to follow guide to get started.
https://github.com/gemartin99/Inception

AI has been used to locate errors when I was unable to find what was wrong.