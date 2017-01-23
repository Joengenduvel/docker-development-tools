FROM joengenduvel/docker-x11-client

# Developer tools
RUN apk add --no-cache git nodejs \
 && npm install -g grunt-cli bower maven opencv
