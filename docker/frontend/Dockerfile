FROM node:12-buster-slim 
COPY src /var/www/html

WORKDIR /var/www/html

RUN apt-get update > /dev/null && \
    apt-get install -y --no-install-recommends \
    libssl1.1 \
    curl \
    libglpk40 \
    bash \
    > /dev/null && \
    rm -rf /var/lib/apt/lists/* && \
    # Install dependencies
    npm config set loglevel error && \
    npm install 

ENV VROOM_EXTERNAL_HOST=${VROOM_EXTERNAL_HOST} 
ENV VROOM_EXTERNAL_PORT=${VROOM_EXTERNAL_PORT}

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 9966
ENTRYPOINT ["/bin/bash"]
CMD ["/docker-entrypoint.sh"]
