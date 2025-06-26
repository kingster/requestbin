# Requestbin

RequestBin gives you a URL that will collect requests made to it and let you inspect them in a human-friendly way. Use RequestBin to see what your HTTP client is sending or to inspect and debug webhook requests.

## Quick start

Launch your own RequestBin instance with docker

```
docker run -p "8000:8000" kingster/requestbin:latest
```

The pre-build image is available in the Docker central repository as [kingster/requestbin](https://hub.docker.com/u/kingster/requestbin).  

## Run it with persistence

Clone the project from github

```
$ git clone https://github.com/kingster/requestbin
```

From the project directory, run `docker-compose`:  

```
$ cd requestbin  
$ docker-compose up  
```  

This will run the automated build of the RequestBin image and then pull down the trusted `redis` image and run with a mounted volume as a linked container to the RequestBin app. RequestBin would be exposed on the port `8000`.  


## Run it manually  

Pull the image down from the Docker central repository:  

```
$ docker run -d -p "8000:8000" kingster/requestbin:latest
```

This will start the container with the requestbin app available externally on port 8000.  To run the image with a Redis back end, you need to startup redis first. Preferably with a mounted volume.

```
$ docker run -d -v /usr/data:/data \
      --name some-redis  \
      redis redis-server --appendonly yes

$ docker run -d --link some-redis:redis  \
	  -e "REALM=prod" -e REDIS_URL="//redis:6379" \
	  -p "8000:8000" \
	  kingster/requestbin
```


## API Documentation

Documenting these details here, since many folks have tried to create custom APIs that provide the same feature. These are only for programmatic use. For General use, directly use the WebUI

### Bin Management

- **Create a new bin**
  - `POST /api/v1/bins`
  - **Description:** Creates a new request bin.  
    Optional form data:
    - `private`: (true/on) If set, creates a private bin.
    - `custom_name`: Custom name for the bin.

- **Get bin details**
  - `GET /api/v1/bins/<name>`
  - **Description:** Retrieves metadata/details for a specific bin.


### Requests Management

- **List all requests for a bin**
  - `GET /api/v1/bins/<bin>/requests`
  - **Description:** Returns all the requests made to the specified bin.

- **Get a specific request**
  - `GET /api/v1/bins/<bin>/requests/<name>`
  - **Description:** Retrieves details for a specific request captured by the bin.


### Statistics

- **Get global statistics**
  - `GET /api/v1/stats`
  - **Description:** Returns statistics such as:
    - `bin_count`: Total number of bins.
    - `request_count`: Total number of requests.
    - `avg_req_size_kb`: Average request size (in KB).


## Developing on local

```
go install github.com/mattn/goreman@latest
goreman start
# now you can keep editing, it would auto reflect.
```


Contributors
------------
 * Originally Created by [Jeff Lindsay](http://progrium.com)
 * Barry Carlyon <barry@barrycarlyon.co.uk>
 * Jeff Lindsay <progrium@gmail.com>
 * Kinshuk Bairagi <hi@kinsh.uk>
