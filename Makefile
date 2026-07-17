# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: manualva <manualva@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/07 15:51:42 by manualva          #+#    #+#              #
#    Updated: 2026/07/17 09:20:08 by manualva         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = inception

all:
	docker compose -f srcs/docker-compose.yml up --build

up:
	docker compose -f srcs/docker-compose.yml up -d --build

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -f
	rm -rf /home/manualva/data/mariadb/*
	rm -rf /home/manualva/data/wordpress/*

fclean: down
	docker system prune -af --volumes
	rm -rf /home/manualva/data/mariadb/*
	rm -rf /home/manualva/data/wordpress/*

re: fclean all

.PHONY: all up down clean fclean re