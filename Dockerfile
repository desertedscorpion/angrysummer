FROM taf7lwappqystqp4u7wjsqkdc7dquw/solidpostal
RUN dnf update --assumeyes && dnf install --assumeyes libxslt && dnf update --assumeyes && dnf clean all && chmod 0500 /usr/local/src/setup
COPY lib/* /usr/local/lib/
CMD ["/usr/sbin/init"]