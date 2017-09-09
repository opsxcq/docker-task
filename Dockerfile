FROM debian:jessie

LABEL maintainer "opsxcq@strm.sh"

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
    unzip \
    unrar-free \
    build-essential && \
    apt-get clean


RUN mkdir /src && \
    mkdir /tasks

COPY src/requirements /src/
WORKDIR /src

RUN pip install -r requirements

COPY src/* /src/

RUN useradd --system --uid 666 -m --shell /usr/sbin/nologin task-runner && \
    mkdir -p /home/task-runner && \
    chown task-runner -R /src /tasks /home/task-runner/ 

RUN mkdir /data && \
    chown task-runner /data

USER task-runner

EXPOSE 8080

ENTRYPOINT ["python"]
CMD ["server.py"]
