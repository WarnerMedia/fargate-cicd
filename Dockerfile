FROM ubuntu:18.04

# install cli tools
ENV DOCKER_VERSION 19.03.6
ENV DC_VERSION 1.25.3
ENV FARGATE_VERSION v0.8.0

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      apt-transport-https \
      ca-certificates \
      ssh \
      git \
      bzip2 \
      curl \
      software-properties-common \
      jq \
      python-pip && \
    curl -sSfLO "https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" && \
    tar xzvf docker-${DOCKER_VERSION}.tgz --strip 1 -C /usr/local/bin docker/docker && \
    rm docker-${DOCKER_VERSION}.tgz && \
    curl -sSfLo /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/${DC_VERSION}/docker-compose-`uname -s`-`uname -m` && \
    chmod +x /usr/local/bin/docker-compose && \
    curl -sSfLO https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py --user && \
    python -m pip install awscli && \
    curl -sSfLo /usr/local/bin/fargate https://github.com/turnerlabs/fargate/releases/download/${FARGATE_VERSION}/ncd_linux_amd64 && \
    chmod +x /usr/local/bin/fargate && \
    mkdir -p /project && \
    echo "alias dc=docker-compose" >> ~/.bashrc && \
    echo "alias f=fargate" >> ~/.bashrc && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /project

CMD ["/bin/bash"]
