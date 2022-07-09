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
$ docker run -d -p "8000:8000" kingster/requestbin
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


Contributors
------------
 * Originally Created by [Jeff Lindsay](http://progrium.com)
 * Barry Carlyon <barry@barrycarlyon.co.uk>
 * Jeff Lindsay <progrium@gmail.com>
 * Kinshuk Bairagi <hi@kinsh.uk>
