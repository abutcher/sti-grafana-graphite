# grafana-graphite
FROM openshift/base-centos7

MAINTAINER Andrew Butcher <abutcher@redhat.com>

EXPOSE 3000

LABEL io.k8s.description="Grafana w/ Graphite Backend" \
      io.k8s.display-name="grafana-graphite" \
      io.openshift.expose-services="3000:http" \
      io.openshift.tags="grafana,graphite" \
      io.openshift.s2i.scripts-url="image:///usr/local/sti"

RUN yum install -y https://grafanarel.s3.amazonaws.com/builds/grafana-2.0.2-1.x86_64.rpm && yum clean all -y

COPY grafana.db /usr/share/grafana/data/
RUN chown -R 1001:0 /usr/share/grafana/ && chmod -R og+rwx /usr/share/grafana

RUN mkdir -p /etc/openshift/dashboards
RUN chown -R 1001:0 /etc/openshift/dashboards && chmod -R og+rwx /etc/openshift/dashboards

COPY ./.sti/bin/ /usr/local/sti

USER 1001

CMD ["usage"]
