# zimme/transmission-daemon

Minimal `transmission-daemon` image based on alpine.

This Docker image will run `transmission-daemon` with `--config-dir /config` by
default.  
It's recommended to mount a named volume `transmission-config` on `/config` to
make sure config is saved when container is stopped or removed.  
When using a named volume for `/config` this image will setup a default
`settings.json` file. It's expected to bind-mount a host path on `/downloads`,
when using the default config.

The image will run `transmission-daemon` as the user and group `transmission`
with `uid = 100` and `gid = 101`, to override this use the `-u` and/or
`--group-add` of `docker run`.

It's recommend using `--init` when running this image.

## Usage

```sh
docker run \
  -d \
  --init \
  --name transmission \
  -p 9091:9091 \
  -p 51413:51413 \
  -p 51413:51413/udp \
  -e TZ=Europe/Stockholm \
  -v transmission-config:/config \
  -v /host/path/to/downloads:/downloads \
  zimme/transmission-daemon
```

## Config

This image will provide a default `settings.json` file when using a named volume
for `/config`. On first run `transmission-daemon` will append its default config
values to the `settings.json` file too.

The following is the default config values this image provides.

```json
{
  "download-dir": "/downloads",
  "encryption": 2,
  "rpc-whitelist": "10.*,127.*,169.254.*,172.16.*,172.17.*,172.18.*,172.19.*,172.20.*,172.21.*,172.22.*,172.23.*,172.24.*,172.25.*,172.26.*,172.27.*,172.28.*,172.29.*,172.30.*,172.31.*,192.168.*",
}
```
