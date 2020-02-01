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

## add own zone file
Modify /etc/named.conf like this.
```diff
diff --git a/files/etc/named.conf b/files/etc/named.conf
index c0750c2..a81d0c1 100644
--- a/files/etc/named.conf
+++ b/files/etc/named.conf
@@ -57,12 +57,10 @@ logging {
         };
 };

-/*
-zone "." IN {
-  type hint;
-  file "named.ca";
+zone "dev.local" IN {
+  type master;
+  file "dev.local.zone";
 };
-*/

 include "/etc/named.rfc1912.zones";
 include "/etc/named.root.key";
```
And add zone file to `/var/named/dev.local.zone`.
```
; Time to Live. Other dns cache server can keep the cache of this record until this time.
$TTL 3600

; SOA (= Start of Authority) record.
; This record contains administrative information about the zone.
; For example, following SOA record means that
; dev.local's
;  * primary dns server is mng-server.dev.local.
;  * administer's mail address is root@dev.local. (We should replace "@" of mail address to ".")
; and
;  * the record has serial number 2020020101 (normally YYYYMMDD + serial number is used)
;  * the record should be updated after 1 hour from when it got
;  * the record should be retried after 15 minutes if the primary dns server is down
;  * the record should be expired after 1 week from the primary dns server is down
;  * the negative cache of the record should be expired after 24 hour

@                IN      SOA mng-server.dev.local. root.dev.local. (
                         2020020101 ; serial
                         3600       ; refresh 1hr
                         900        ; retry 15min
                         604800     ; expire 1w
                         86400      ; min 24hr
)

                 IN      NS     mng-server.dev.local.
www              IN      A      192.168.11.1
mng-server       IN      A      192.168.11.1
```
