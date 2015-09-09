FROM eeacms/plone

ENV CONFIG buildout.cfg

COPY buildout.cfg /opt/zope/buildout.cfg

RUN ./install.sh
