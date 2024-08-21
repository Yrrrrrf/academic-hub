# Some Docker commands

## Useful commands
```bash
docker ps  # List running containers
docker ps -a  # List all containers (running and stopped)
docker images  # List images on the system
docker stop <container-id>  # Stop a container


```



## Build an image
```bash
docker build -t my-image-name:latest .
# docker
# build - build an image from a Dockerfile
# -t, --tag list - Name and optionally a tag in the 'name:tag' format
# my-image-name:latest - Name and tag of the image
```

## Run a container
```bash
docker run -d -p 8080:80 my-image-name:latest
# docker
# run - run a command in a new container
# -d, --detach - Run container in background and print container ID
# -p, --publish list - Publish a container's port(s) to the host
# 8080:80 - Map port 80 in the container to port 8080 on the host
# my-image-name:latest - Name and tag of the image
```

