FROM alpine:3.22
RUN apk add --no-cache curl
WORKDIR /app
COPY checker.sh .
CMD ["sh", "/app/checker.sh"]