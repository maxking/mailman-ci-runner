FROM ubuntu:15.10

RUN apt-get -y update && apt-get -y install python-pip python3.4 python3.5 git openssh-server \
    postgresql-client libpq-dev python3-dev libsqlite3-dev libmysqlclient-dev

RUN wget "https://bitbucket.org/hpk42/tox/get/87a9def32696.zip"
RUN pip install 87a9def32696.zip

RUN useradd runner --create-home
RUN mkdir /builds
RUN chown runner /builds
RUN mkdir /var/run/sshd
RUN echo 'runner:runner' | chpasswd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
