FROM golang:alpine

MAINTAINER LinkedIn Burrow "https://github.com/opentable/Burrow"

RUN apk add --update bash curl git && rm -rf /var/cache/apk/*

RUN curl -sSO https://raw.githubusercontent.com/pote/gpm/v1.4.0/bin/gpm && \
  chmod +x gpm && mv gpm /usr/local/bin

ADD . $GOPATH/src/github.com/opentable/Burrow
RUN cd $GOPATH/src/github.com/opentable/Burrow && gpm install && go install && mv $GOPATH/bin/Burrow $GOPATH/bin/burrow

ADD docker-config /etc/burrow

WORKDIR /var/tmp/burrow

CMD ["/go/bin/burrow", "--config", "/etc/burrow/burrow.cfg"]
