# geo-lab-docker
Collection of geo services.

## How to work

### Parameters
Modify and copy `.env.template` into `.env` file.

### Docker
We use docker and docker-compose to manage collection of services.
Three different environments are considered: local, development, production.

### Helper script
Run `./ldc.sh up` command to build and up containers.

## Services

### Traccar
Modern GPS Tracking Platform [Explore detials](https://www.traccar.org/documentation/).
Modified configuration file `traccar.xml` is located in `docker/traccar/conf` folder [See more parameters](https://www.traccar.org/configuration-file/).

### MySQL



