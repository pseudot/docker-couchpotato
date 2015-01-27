# Based on centos:6.5. 
FROM centos:centos6
MAINTAINER Pseudot <pseudot@outlook.com>

# Install RPM keys
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6

# Install Git for updates
RUN yum -y install git wget tar 

# Download files or copy files
COPY scripts/  /tmp/scripts
RUN chmod +x /tmp/scripts/*.sh
RUN cd /tmp/scripts; /tmp/scripts/get_files.sh

#COPY python/ez_setup.py /tmp/python/ez_setup.py
#COPY couchpotato/ /opt/couchpotato

# Install Supervisor to control processes

# Install easy_setup, python is already installed
RUN python /tmp/python/ez_setup.py

# Easy install supervisor, for running multiple procersses
RUN easy_install pip==1.5.6
RUN pip install supervisor==3.0

# Copy supervisord configuration.
RUN mkdir -p /usr/local/etc
COPY supervisor/supervisord.conf /usr/local/etc/supervisord.conf
COPY supervisor/supervisord_couchpotato.conf /usr/local/etc/supervisor.d/supervisord_couchpotato.conf

# Install RAR
RUN cp /tmp/rar.tar.gz/rar/unrar /usr/local/sbin/

# Install couchpotato
COPY couchpotato_config/settings.conf /root/.couchpotato/settings.conf

# Copy SSL
COPY ssl/couchpotato.pem /opt/couchpotato/ssl/couchpotato.pem
COPY ssl/couchpotato.key /opt/couchpotato/ssl/couchpotato.key
RUN chmod 0700 /opt/couchpotato/ssl/couchpotato.key
RUN chmod 0700 /opt/couchpotato/ssl/couchpotato.pem

# Remove temp files
RUN rm -rf /tmp/*

# Expose volumes
VOLUME [ "/root/.couchpotato/logs", "/opt/couchpotato" ]

EXPOSE 5050 47091

# Run the supervisor
WORKDIR /usr/bin
CMD ["/usr/bin/supervisord","--configuration=/usr/local/etc/supervisord.conf"]