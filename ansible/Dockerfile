FROM arm32v6/alpine:3.7

ARG ANSIBLE_VERSION=2.4.2.0
ARG DOCKER_PY_VERSION=1.10.6

RUN	apk --update add \
		bash \
		ca-certificates \
		git \
		less \
		openssl \
		openssh-client \
		p7zip \
		python \
		py-lxml \
		py-pip \
		rsync \
		sshpass \
		sudo \
		subversion \
		vim \
		zip \
		gcc \
    && apk --update add --virtual \
		build-dependencies \
		python-dev \
		libffi-dev \
		openssl-dev \
		build-base \
	&& pip install --upgrade \
		pip \
		cffi \
	&& pip install \
		ansible==${ANSIBLE_VERSION} \
		docker-py==${DOCKER_PY_VERSION} \
	&& apk del build-dependencies \
	&& rm -rf /var/cache/apk/*

RUN	mkdir -p /etc/ansible \
	&& echo 'localhost' > /etc/ansible/hosts \
	&& mkdir -p ~/.ssh && touch ~/.ssh/known_hosts

WORKDIR	/tmp
ONBUILD	RUN	ansible -c local -m setup all > /dev/null
CMD ["bash"]
