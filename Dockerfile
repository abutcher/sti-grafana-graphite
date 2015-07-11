# grafana-graphite
FROM openshift/base-centos7

MAINTAINER Andrew Butcher <abutcher@redhat.com>

LABEL io.k8s.description="Grafana w/ Graphite Backend" \
      io.k8s.display-name="grafana-graphite" \
      io.openshift.expose-services="3000:http" \
      io.openshift.tags="grafana,graphite" \
      io.openshift.s2i.scripts-url="image:///usr/local/sti"

RUN yum install -y https://grafanarel.s3.amazonaws.com/builds/grafana-2.0.2-1.x86_64.rpm && yum clean all -y

COPY grafana.db /usr/share/grafana/data/
RUN chown -R 1001:1001 /usr/share/grafana/

RUN mkdir -p /etc/openshift/dashboards
RUN chown -R 1001:1001 /etc/openshift/dashboards

COPY ./.sti/bin/ /usr/local/sti

# This default user is created in the openshift/base-centos7 image
USER 1001

EXPOSE 3000

CMD ["base-usage"]
