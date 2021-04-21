#!/bin/bash

source .env
echo -e "\e[39mLaravel project : \e[33m"$PROJECT_ID
echo -e "\e[39mEnvironment : \e[33m"$DOCKER_ENVIRONMENT


### Allowed commands
COMMANDS_FILE="./docker/command-list.txt"
read -d $'\x04' COMMANDS < "$COMMANDS_FILE"

function show_allowed_commands() {    
    echo -e "\e[31m Allowed commands are:"    
    echo -e "\e[93m "$COMMANDS"\e[39m"
}

if [ -z "$1" ]; then
    echo -e "\e[31mNo command supplied!"    
    show_allowed_commands
    exit 1
else
    echo -e "\e[39mCommand : \e[33m"$1
    echo -e "\e[39m"   
    
    DOCKER_COMPOSE_FILE_FLAGS="-f docker-compose.yml"

    case $DOCKER_ENVIRONMENT in
        local)
            DOCKER_COMPOSE_FILE_FLAGS="-f docker-compose.yml -f docker-compose-local.yml"
            ;;
        development)
            DOCKER_COMPOSE_FILE_FLAGS="-f docker-compose.yml -f docker-compose-dev.yml"
            ;;        
        production)
            DOCKER_COMPOSE_FILE_FLAGS="-f docker-compose.yml -f docker-compose-prod.yml"
            ;;
        *)
            echo -e "\e[31mOnly [local|development|production] environments are supported!"
            exit 1
            ;;    
    esac

    PARAMETER_REQUIRED=""

    if [[ " $PARAMETER_REQUIRED " =~ .*\ $1\ .* ]]; then
        if [ -z "$2" ]; then            
            echo -e "\e[31mSecond parameter is required!" 
            exit 1
        fi
    fi 

    case "$1" in   
        refresh-project)     
            refresh_project
            ;;
        build)
            docker-compose $DOCKER_COMPOSE_FILE_FLAGS build
            ;;
        start)
            docker-compose $DOCKER_COMPOSE_FILE_FLAGS start
            ;; 
        stop)
            docker-compose $DOCKER_COMPOSE_FILE_FLAGS stop
            ;;                       
        up)
            docker-compose $DOCKER_COMPOSE_FILE_FLAGS up -d
            echo ""
            docker-compose $DOCKER_COMPOSE_FILE_FLAGS ps
            ;;         
        down)
            docker-compose $DOCKER_COMPOSE_FILE_FLAGS down
            ;;
        down-volume)
            docker-compose $DOCKER_COMPOSE_FILE_FLAGS down -v
            ;;            
        ps)
            docker-compose $DOCKER_COMPOSE_FILE_FLAGS ps
            ;;         
        docker-stop-all)
            docker stop $(docker ps -a -q)
            ;;
        docker-remove-all)
            docker rm $(docker ps -a -q)
            ;;
        test-containers)
            test_containers
            ;;
        bash)
            docker-compose $DOCKER_COMPOSE_FILE_FLAGS exec -u www -w / traccar sh
            ;;
        root-bash)
            docker-compose $DOCKER_COMPOSE_FILE_FLAGS exec -u root -w / traccar bash
            ;;
#mysql
        mysql)
	        docker-compose $DOCKER_COMPOSE_FILE_FLAGS exec mysql mysql -u$DB_ROOT_USERNAME -p$DB_ROOT_PASSWORD $DB_DATABASE
            ;;
        mysqldump)
	        docker-compose $DOCKER_COMPOSE_FILE_FLAGS exec mysql mysqldump $DB_DATABASE -u$DB_ROOT_USERNAME -p$DB_ROOT_PASSWORD --result-file=/docker-entrypoint-initdb.d/$DB_DATABASE-$(date -d "$xx day" -u +%Y-%m-%d).sql
            ;;
        mysql-import)
	        docker-compose $DOCKER_COMPOSE_FILE_FLAGS exec mysql mysql -u$DB_ROOT_USERNAME -p$DB_ROOT_PASSWORD $DB_DATABASE < $DB_DATABASE.sql;
            ;;
        mysql-bash)
	        docker-compose $DOCKER_COMPOSE_FILE_FLAGS exec mysql bash
            ;;
### Rebuild certain services
        rebuild-mysql)
            docker-compose up -d --no-deps --build mysql
            ;;
        rebuild-traccar)
            docker-compose up -d --no-deps --build traccar
            ;;
        *)            
            echo -e "\e[31mWrong command supplied!" 
            show_allowed_commands
            exit 1
            ;;
    esac    
fi
