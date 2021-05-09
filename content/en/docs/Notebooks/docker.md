Docker
======
* don't run docker commands as root `sudo usermod -aG docker callimachus`
* [Docker Hub](https://hub.docker.com/)
* [Docker Compose](https://docs.docker.com/compose/)

#### Reference: Docker Commands
```bash
docker info
docker inspect
docker exec -it
docker run -d
docker ps -a
docker stop [my_container]
docker rm [my_container]
docker rmi [docker_image]
docker volume rm [my_volume]
docker volume create [my_volume]
docker volume ls
docker volume inspect [my_volume]
docker container ls -aq # list all containers
```

#### Tags
> nginx # default to latest  
> nginx:latest # specifically use tag latest  
> centos:centos6 # pull centos 6 base image

## Lifecycle Management

#### Run in detached mode (daemon mode), background
```bash
docker run -d --name=nginx nginx:latest
```
#### Restart Container
```bash
docker restart nginx
```

#### Execute a command in a container without affecting the running process
```bash
#  Interactive, attach with a shell.
docker exec -it nginx /bin/bash
```

#### List processes
```bash
docker ps # Running Processes
docker ps -a # Running and Stopped Processes
```

#### remove images, when no containers are based upon it
```bash
docker rmi centos:centos6
```

docker image prune # remove all currently unused imaged
docker image prune -a # clear everything

#### Remove containers
```bash
docker rm nginx:old
docker system prune # remove all stopped containers, images, unused networks
```

#### Stop all containers. Remove all stopped containers, using bash command substitution
docker container stop $(docker container ls -aq) # stop all containers
docker container rm $(docker container ls -aq) # remove all stopped containers
docker rmi -f $(docker images -aq)


## Docker Inspect

#### get info about container
```bash
docker inspect
```

#### get ip address of container
```bash
docker inspect nginx:latest | grep IPAddr
```



## Ports and Volumes

#### volumes

docker volume ls
docker volume rm
`docker volume prune`

#### ports
In docker-compose
`expose` -> reveal ports to the docker environment
`ports` -> expose ports to docker and to the host system (i.e. publish the ports)


#### Bind ports
```bash
# docker run -d -p HOSTPORT:CONTAINERPORT
docker run -d -p 8080:80 --name=WebServer nginx:latest
```

#### Create a mount point in a container
```bash
# docker run -d -p 8080:80 --name=webserver -v HOSTVOLPATH:CONTAINERVOLPATH nginx:latest
docker run -d -p 8080:80 --name=webserver -v /home/user/www:/usr/share/nginx/html nginx:latest
```




## BUILDING, using a Dockerfile

```bash
# Execute in directory with dockerfile, or define path
docker build -t dzoladz/ubuntu .
```

#### Dockerfile

* each step in the build process is a new container
* try to combine mulitple RUN commands when possible

>RUN * applies to the base images  
>CMD * applies to the container instantiated on the base image  
>EXPOSE * expose container ports to host system

#### Build a container using a Dockerfile and tag it
```bash
docker build -t keycloak-proxy .

docker run -d -p 80:80 -p 443:443 --name=keycloak-proxy keycloak-proxy:latest

# Reload Nginx config in running container
docker exec <container name> nginx -s reload
```




## Applications

#### Metabase
```bash
# NOTE: this will run Metabase without any persistent storage for the application.
docker run -d -p 3000:3000 --name metabase metabase/metabase
```

#### ownCloud
```bash
docker run -d -p 8080:80 --name owncloud --mount source=/Users/Derek/docker/owncloud,target=/var/www/html owncloud:8.1
```

## networks
docker network ls # list them all
docker network prune -a # get rid of them all
