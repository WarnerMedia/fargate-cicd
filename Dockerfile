FROM ubuntu:16.04

# convenient aliases
RUN echo "alias dc=docker-compose" >> ~/.bashrc && \
    echo "alias f=fargate" >> ~/.bashrc

# install docker
ENV DOCKER_VERSION 18.03.1
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
RUN apt-get update && apt-get install -y docker-ce=${DOCKER_VERSION}~ce-0~ubuntu 

# install docker-compose
ENV DC_VERSION 1.21.1
RUN curl -L https://github.com/docker/compose/releases/download/${DC_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

# jq
RUN apt-get install -y jq

# install aws-cli
RUN apt-get install -y python-pip
RUN curl -O https://bootstrap.pypa.io/get-pip.py && python get-pip.py --user
RUN python -m pip install awscli

# install fargate-cli
ENV FARGATE_VERSION v0.3.0-pre-5-g6c463b2
RUN curl -SLo /usr/local/bin/fargate https://github.com/turnerlabs/fargate/releases/download/${FARGATE_VERSION}/ncd_linux_amd64 && chmod +x /usr/local/bin/fargate

# cleanup
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /project
WORKDIR /project

CMD ["/bin/bash"]
