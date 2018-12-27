# zimme/transmission

Simple Transmission docker image

## Usage

```sh
docker run -d --name transmission -p 9091 -p 51413 -p 51413/udp -e TZ=Europe/Stockholm transmission
```
