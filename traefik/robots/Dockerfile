FROM arm32v7/golang:1.12-alpine

RUN apk add --no-cache \
    git \
    openssh-client

WORKDIR /go/src/app

COPY ./src /go/src/app
RUN go get && \
    go install

ENTRYPOINT ["app"]