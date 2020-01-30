# bind

## build docker image
```bash
$ docker build .
```

## start docker container
```bash
$ docker run -d --rm --privileged -p 53:53 -p 53:53/udp <IMAGE ID> /sbin/init
```
or
```bash
$ docker-compose up -d
```

## name resolution test
```bash
$ dig www.google.com @localhost

; <<>> DiG 9.10.6 <<>> www.google.com @localhost
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 50526
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 4, ADDITIONAL: 9

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;www.google.com.			IN	A

;; ANSWER SECTION:
www.google.com.		53	IN	A	172.217.31.164

;; AUTHORITY SECTION:
google.com.		172552	IN	NS	ns1.google.com.
google.com.		172552	IN	NS	ns3.google.com.
google.com.		172552	IN	NS	ns4.google.com.
google.com.		172552	IN	NS	ns2.google.com.

;; ADDITIONAL SECTION:
ns2.google.com.		172552	IN	A	216.239.34.10
ns1.google.com.		172552	IN	A	216.239.32.10
ns3.google.com.		172552	IN	A	216.239.36.10
ns4.google.com.		172552	IN	A	216.239.38.10
ns2.google.com.		172552	IN	AAAA	2001:4860:4802:34::a
ns1.google.com.		172552	IN	AAAA	2001:4860:4802:32::a
ns3.google.com.		172552	IN	AAAA	2001:4860:4802:36::a
ns4.google.com.		172552	IN	AAAA	2001:4860:4802:38::a

;; Query time: 4 msec
;; SERVER: ::1#53(::1)
;; WHEN: Tue Jan 21 23:05:39 JST 2020
;; MSG SIZE  rcvd: 307
```
