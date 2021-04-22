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

Test request for the route in Kiev.
'''
curl 'http://localhost:5000/route/v1/driving/30.4652,50.4561;30.46525,50.45617?steps=true&alternatives=true'
'''

### VROOM (Vehicle Routing Open-source Optimization Machine)
VROOM is an open-source optimization engine written in C++17 that aim at providing good solutions to various real-life vehicle routing problems (VRP) within a small computing time [Explore details](https://github.com/VROOM-Project/vroom).

Supported problem types are:
* TSP (travelling salesman problem)
* CVRP (capacitated VRP)
* VRPTW (VRP with time windows)
* MDHVRPTW (multi-depot heterogeneous vehicle VRPTW)
* PDPTW (pickup-and-delivery problem with TW)

API health check:
'''
curl -w "%{http_code}" http://localhost:3000/health
'''

Test request.
'''
curl --header "Content-Type:application/json" --data '{"vehicles":[{"id":0,"start":[30.4652,50.4561],"end":[30.4652,50.4561]}],"jobs":[{"id":0,"location":[30.4653,50.4562]},{"id":1,"location":[30.4657,50.4567]}],"options":{"g":true}}' http://localhost:3000
'''

### Traccar
Modern GPS Tracking Platform [Explore detials](https://www.traccar.org/documentation/).
Modified configuration file `traccar.xml` is located in `docker/traccar/conf` folder [See more parameters](https://www.traccar.org/configuration-file/).

### MySQL


## Geo data
[Ukrainian regions](https://download.openstreetmap.fr/extracts/europe/ukraine/)

