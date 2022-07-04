# yshurik/stunnel docker container

yshurik/stunnel is a container utility for making secure tunnels between docker
hosts. As data flow could be not protected between docker hosts located in
separate locations the container can work well as a transport layer.

```
       docker host1                                      docker host2
+------------+  +---------------+            +----------------+  +-------------+
|container   |  |yshurik/stunnel|            |yshurik/stunnel |  |container    |
|with service|--|with -s to make|..internet..|a client to make|--|with a client|
|to proctect |  |secure tunnel  |            |endpoint to use |  |of host1     |
+------------+  +---------------+            +----------------+  +-------------+
```

## Usage

`docker run [DOCKER_OPTIONS] yshurik/stunnel -c <connect-port> [-s]`

### Options

* `-c`   - **Required**; to connect to, in the form <host>:<port>.
* `-s`   - **Optional**; specifies that the endoint is a server.

## Examples:


## License MIT
