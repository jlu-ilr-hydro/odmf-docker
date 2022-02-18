FROM alpine:latest

MAINTAINER "Philipp Kraft"
LABEL version="2022.02.15"

RUN apk add gzip bzip2
RUN apk --update add postgresql-client

# Method to pack the backup, can be gzip, bzip2 or cat (for unpacked backups)
ENV BACKUP_ZIP=gzip
ENV DB_URL=postgresql://db_user:db_pw@db:5432/odmf

ADD ./*.sh /
ADD ./crontab /crontab.txt

ENTRYPOINT ["/entry.sh"]

