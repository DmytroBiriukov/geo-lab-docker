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

### OSRM (Open Source Routing Machine)
High performance routing engine written in C++14 designed to run on OpenStreetMap data [Explore details](https://github.com/Project-OSRM/osrm-backend).

Test request.
'''
curl "http://localhost:5000/route/v1/driving/13.388860,52.517037;13.385983,52.496891?steps=true&alternatives=true"
'''

### Traccar
Modern GPS Tracking Platform [Explore detials](https://www.traccar.org/documentation/).
Modified configuration file `traccar.xml` is located in `docker/traccar/conf` folder [See more parameters](https://www.traccar.org/configuration-file/).

### MySQL



