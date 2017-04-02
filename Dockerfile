FROM debian:jessie

MAINTAINER opsxcq <opsxcq@thestorm.com.br>

RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    git \
    wget \
    rsync \
    ssh \
    python-pip \
    python-dev \
    build-essential && \
    apt-get clean


RUN mkdir /src && \
    mkdir /tasks

COPY src/requirements /src/
WORKDIR /src

RUN pip install -r requirements

COPY src/* /src/

RUN useradd --system --uid 666 -M --shell /usr/sbin/nologin task-runner && \
    chown task-runner -R /src /tasks

USER task-runner

EXPOSE 8080

ENTRYPOINT ["python"]
CMD ["server.py"]
