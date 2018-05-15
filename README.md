# Apache + PHP + OCI + newrelic
This docker image is based on a friend of mine project [fernandotalonso/php7-apache-oci8]
Plus:
 - newrelic php extension: to grab metrics from application running on container and send to [newrelic], so you can mesure the performace of each endpoint

## Running
To run the container:
```
$ sudo docker run -d adelinogaspar/apache-php-oci-newrelic
```
Default web root:
```
/var/www/html
```
### Configure Newrelic license on container


[newrelic]: https://newrelic.com/
[fernandotalonso/php7-apache-oci8]: https://hub.docker.com/r/fernandotalonso/php7-apache-oci8/
