FROM alpine:3.20.2

RUN apk add --no-cache \
		bzip2 \
		file \
		gzip \
		libffi \
		libffi-dev \
		krb5 \
		krb5-dev \
		krb5-libs \
		musl-dev \
		openssh \
		openssl-dev \
		python3-dev=3.12.3-r1 \
		py3-cffi \
		py3-cryptography=42.0.7-r0 \
		py3-setuptools=69.5.1-r0 \
		sshpass \
		tar \
		&& \
	apk add --no-cache --virtual build-dependencies \
		gcc \
		make \
		&& \
	python3 -m venv	/opt/venv \
		&& \
	/opt/venv/bin/pip install --upgrade pip \
		&& \
	/opt/venv/bin/pip install \
		ansible==10.2.0 \
		botocore==1.31.44 \
		boto3==1.28.44 \
		awscli==1.29.44 \
		pywinrm[kerberos]==0.4.2 \
		&& \
	ln -s /opt/venv/bin/ansible* /usr/local/bin/ \
		&& \
	apk del build-dependencies \
		&& \
	rm -rf /root/.cache

VOLUME ["/tmp/playbook"]

WORKDIR /tmp/playbook

ENTRYPOINT ["ansible-playbook"]

CMD ["--version"]
