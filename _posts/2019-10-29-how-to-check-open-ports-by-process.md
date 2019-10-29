---
layout: post
title: "How to check open ports by process"
date: 2019-10-29
excerpt: "A list of useful debugging commands to check for open ports by process"
comments: true
tags: [linux, processes, network, english]
eye_catch: https://blog.guilhermegarnier.com/images/doors.png
---
<img src="/images/doors.png" alt="Hallway with doors" />

When debugging a server problem, you may need to know which ports a specific process opened - or which process is listening on a specific port. There are many ways to do this, using different tools. It may be useful to know more than one, because you may not have every tool available (specially in containerized environments).


## Checking if a port is open

The first step is checking if a port is open. The easiest way to do this is using [`netcat`](http://netcat.sourceforge.net/). In this example, there's an HTTP server running on port 8000:

```sh
$ nc -zv localhost 8000
Connection to localhost 8000 port [tcp/*] succeeded!

$ nc -zv localhost 8001
nc: connect to localhost port 8001 (tcp) failed: Connection refused
```

You can also add a `-u` flag to check UDP ports.

Another tool you can use to check for open ports is [`telnet`](https://en.wikipedia.org/wiki/Telnet):

```sh
$ telnet localhost 8000
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
^]
telnet> quit
Connection closed.

$ telnet localhost 8001
Trying 127.0.0.1...
telnet: Unable to connect to remote host: Connection refused
```

Telnet can't be used to test UDP ports.


### Testing HTTP ports

In the specific case of an HTTP server, you can use [`curl`](https://curl.haxx.se) to make requests - `-v` flags makes the output verbose:

```sh
$ curl -v localhost:8000/check
*   Trying 127.0.0.1:8000...
* TCP_NODELAY set
* Connected to localhost (127.0.0.1) port 8000 (#0)
> GET /check HTTP/1.1
> Host: localhost:8000
> User-Agent: curl/7.65.3
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Content-Type: text/html; charset=utf-8
< Content-Length: 2
< ETag: W/"2-4KoCHiHd29bYzs7HHpz1ZA"
< Date: Fri, 13 Sep 2019 21:11:22 GMT
< Connection: keep-alive
<
* Connection #0 to host localhost left intact
OK
```

When the port isn't open, you get a `Connection refused` message:

```sh
$ curl -v localhost:8001/check
*   Trying 127.0.0.1:8001...
* TCP_NODELAY set
* connect to 127.0.0.1 port 8001 failed: Connection refused
* Failed to connect to localhost port 8001: Connection refused
* Closing connection 0
curl: (7) Failed to connect to localhost port 8001: Connection refused
```

You can also make this same request with `telnet`, if `curl` is unavailable:

```sh
$ telnet localhost 8000
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
GET /check

HTTP/1.1 200 OK
Content-Type: text/html; charset=utf-8
Content-Length: 2
ETag: W/"2-4KoCHiHd29bYzs7HHpz1ZA"
Date: Fri, 13 Sep 2019 21:16:53 GMT
Connection: close

OKConnection closed by foreign host.
```


## Checking open ports by process

Sometimes you need to check which ports a specific process is listening to. First you need to find out the process id (pid) using [`ps`](https://en.wikipedia.org/wiki/Ps_(Unix)):

```sh
$ ps aux | grep python
ggarnier  8762  0.6  0.0  94900 14928 pts/2    S+   17:31   0:00 python server.py
ggarnier  8789  0.0  0.0  21536  1092 pts/11   S+   17:31   0:00 grep python
```

The process id is the second column - in this example it's `8762`. Now you can use [`lsof`](https://en.wikipedia.org/wiki/Lsof):

```sh
$ lsof -Pan -p 8762 -i
COMMAND  PID     USER   FD   TYPE   DEVICE SIZE/OFF NODE NAME
python  8762 ggarnier    3u  IPv4 13254927      0t0  TCP *:8000 (LISTEN)
```

In the example above, process `8762` is listening on port TCP `8000`.

An alternative command is [`ss`](http://man7.org/linux/man-pages/man8/ss.8.html):

```sh
$ ss -tulpn | grep "pid=8762"
tcp    LISTEN   0        5                                      0.0.0.0:8000                  0.0.0.0:*            users:(("python"id=8762,fd=3))
```

You may need to run `lsof` and `ss` with `sudo` if the process is owned by another user.


## Checking which process is listening on a port

Finally, if a port is open and you don't know with process did it, use `lsof`:

```sh
$ lsof -i :8000
COMMAND  PID     USER   FD   TYPE   DEVICE SIZE/OFF NODE NAME
python  8762 ggarnier    3u  IPv4 13254927      0t0  TCP *:8000 (LISTEN)
```

[`netstat`](https://en.wikipedia.org/wiki/Netstat) can also be used. It doesn't support filtering by port or process, but you can use [`grep`](https://en.wikipedia.org/wiki/Grep) to filter its output:

```sh
$ netstat -ntlp | grep 8000
tcp        0      0 0.0.0.0:8000            0.0.0.0:*               LISTEN      8762/python
```

In both commands, use `sudo` if you aren't the process owner.
