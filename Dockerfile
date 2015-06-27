FROM ubuntu:15.04

RUN apt-get -y update && apt-get -y install python-pip python3.4 git openssh-server \
    python-tox postgresql postgresql-client libpq-dev python3-dev python-dev

RUN useradd runner --create-home

RUN mkdir /builds

RUN chown runner /builds 

RUN mkdir /var/run/sshd

RUN echo 'runner:runner' | chpasswd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

USER postgres

RUN    /etc/init.d/postgresql start &&\
    psql --command "CREATE USER mailman WITH SUPERUSER PASSWORD 'mailman';" &&\
    createdb -O mailman mailman &&\
    createdb -O mailman mailman_test


RUN which pg_config
