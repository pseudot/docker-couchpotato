# Couchpotato on Centos 6.5 docker container

## Docker container for running Couchpotato.
  
  Access via https://localhost:5050
  SSL certificate are enabled with a self-signed certificate.

## Requires 
  Docker 1.3+

## Container setup

  When running these items should be exposed or mapped.
  
  Volumes
    - /var/logs/                for log files
  
    - /mnt/media                mapped to the media files

  Map Ports
    - 5050 ->  5050             Couchpotato page
  
    - 9001 ->  47091            supervisor page

## To build container

  > docker build --rm=true -t="couchpotato" .

## To run container

  > docker run --name couchpotato -v  /mnt/media:/container/media -v /mnt/downloads/completed"]="container/downloads"  -p 47091:9091 -p 5050:5050

## Backup config file

  > CONT=`docker ps -a | grep couchpotato | awk '{ print $1 }'`
  > docker cp $CONT:/root/.couchpotato/settings.conf $PWD/