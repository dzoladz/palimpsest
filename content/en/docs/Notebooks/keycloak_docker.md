# Keyclock, Docker for Testing

Notes on the installation of Keycloak using official [jboss/keycloak](https://hub.docker.com/r/jboss/keycloak/) Docker image.

## Install Git and Docker

Add the GPG key for the official Docker repo

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

Add the Docker repository to APT sources

```bash
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

Update package database

```bash
apt-get update
```

Install from the Docker repo, not the Ubuntu 16.04 distribution package.

```bash
apt-cache policy docker-ce
```

Install Docker Community Edition and Git

```bash
apt-get install -y docker-ce git
```

## Add Keycloak User

> Run docker as a non-root user

Create the Keycloak user

```bash
adduser keycloak
```

Add keycloak user to the docker group. No sudo for docker commands

```bash
usermod -aG docker keycloak
```

## Launch Keycloak w/ Postgres

Create the Keycloak network

```bash
docker network create keycloak-network
```

Deploy a PostGRES container for the Keycloak app

```bash
docker run -d --name keycloak-db --net keycloak-network -e POSTGRES_DB=keycloak -e POSTGRES_USER=keycloak -e POSTGRES_PASSWORD=password postgres
```

Deploy the Keycloak container

```bash
docker run -d --name keycloak-app --net keycloak-network -p 8443:8443 -e DB_ADDR=keycloak-db -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=password jboss/keycloak
```

Start Keycloak with Proxy Forwarding for use with Nginx

```bash
docker run -d --name keycloak-app --net keycloak-network -p 8443:8443 -e DB_ADDR=keycloak-db -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=password -e PROXY_ADDRESS_FORWARDING=true jboss/keycloak
```



