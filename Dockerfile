FROM ubuntu:15.10

RUN apt-get -y update && apt-get -y install python-pip python3-pip python3.4 \ 
    python3.5 git openssh-server postgresql-client libpq-dev python3-dev \
    libsqlite3-dev libmysqlclient-dev

RUN pip3 install tox

RUN useradd runner --create-home
RUN mkdir /builds
RUN chown runner /builds
RUN mkdir /var/run/sshd
RUN echo 'runner:runner' | chpasswd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22

COPY mysql.cfg postgres.cfg /home/runner/configs/

RUN chown -R runner:runner /home/runner/configs

USER runner
WORKDIR /home/runner
