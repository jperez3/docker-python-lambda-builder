FROM amazonlinux:latest

RUN mkdir /app
ADD ./app /app
RUN yum -y install git \
    python3 python3-pip zip python-cffi libffi-devel\
    gcc python3-devel \
    && yum clean all \
    && rm -rf /var/cache/yum \
    && chmod +x /app/package.sh \
    && curl https://bootstrap.pypa.io/get-pip.py | python3 - \
    && pip3 install pipenv pylint flake8

ENV LANG en_US.UTF-8

CMD [ "/app/package.sh" ]