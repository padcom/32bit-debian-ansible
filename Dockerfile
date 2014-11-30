FROM 32bit/debian:jessie

MAINTAINER Matthias Hryniszak <padcom@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
    apt-get install -y python-yaml python-jinja2 python-httplib2 python-keyczar python-paramiko python-setuptools python-pkg-resources git python-pip && \
    apt-get autoclean && apt-get clean && apt-get autoremove --purge

RUN mkdir /etc/ansible/ && \
    echo '[local]\nlocalhost\n' > /etc/ansible/hosts && \
    mkdir /opt/ansible/ && \
    git clone http://github.com/ansible/ansible.git /opt/ansible/ansible

WORKDIR /opt/ansible/ansible

RUN git submodule update --init

ENV PATH /opt/ansible/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin
ENV PYTHONPATH /opt/ansible/ansible/lib
ENV ANSIBLE_LIBRARY /opt/ansible/ansible/library
