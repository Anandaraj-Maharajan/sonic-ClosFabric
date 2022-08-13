FROM ubuntu:20.04

# Labels.
LABEL maintainer="anandaraj_maharajan@dell.com" \
    org.label-schema.schema-version="1.2" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="dellsonic/ansible" \
    org.label-schema.description="Ansible Docker with pre-installed enterprise Dell sonic collection" \
    org.label-schema.url="https://github.com/ansible-collections/dellemc.enterprise_sonic" \
    org.label-schema.vcs-url="https://github.com/Dell-Networking" \
    org.label-schema.vendor="Dell Technologies" \
    org.label-schema.docker.cmd="docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/id_rsa dellsonic/ansible:2.10-ubuntu-20.04"

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y gnupg2 python3-pip sshpass git openssh-client iproute2 net-tools vim && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean
    
RUN python3 -m pip install --upgrade pip cffi && \
    pip install ansible-core && \
    pip install mitogen ansible-lint jmespath paramiko && \
    pip install --upgrade pywinrm && \
    rm -rf /root/.cache/pip

RUN mkdir /ansible && \
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

RUN ansible-galaxy collection install dellemc.enterprise_sonic    

COPY . /ansible

WORKDIR /ansible

ENTRYPOINT [ "bash" ]

