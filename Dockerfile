FROM alpine:latest

RUN apk add stunnel

COPY execute.sh /execute.sh
RUN chmod +x /execute.sh

EXPOSE 13000

ENTRYPOINT ["/execute.sh"]
