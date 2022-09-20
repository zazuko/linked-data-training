FROM docker.io/library/nginx:1.23-alpine

COPY index.html /usr/share/nginx/html/
COPY img /usr/share/nginx/html/img
COPY LD-Basics /usr/share/nginx/html/LD-Basics
COPY Ontologies /usr/share/nginx/html/Ontologies
COPY SPARQL /usr/share/nginx/html/SPARQL

EXPOSE 80

RUN chmod -R 755 /usr/share/nginx/html/
