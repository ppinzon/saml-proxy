FROM fedora:23

RUN dnf install -y \
  apr-util-openssl \
  authconfig \
  httpd \
  mod_auth_gssapi \
  mod_auth_kerb \
  mod_auth_mellon \
  mod_intercept_form_submit \
  mod_session \
  mod_ssl \
  gettext \
  && dnf clean all

RUN ln -sf /proc/1/fd/1 /var/log/httpd/access.log && \
    ln -sf /proc/1/fd/2 /var/log/httpd/error.log 

# Add mod_auth_mellon setup script
ADD mellon_create_metadata.sh /usr/sbin/mellon_create_metadata.sh

# Add conf file for Apache
ADD proxy.conf /etc/httpd/conf.d/proxy.conf.template

EXPOSE 80

ADD configure /usr/sbin/configure
ENTRYPOINT /usr/sbin/configure
