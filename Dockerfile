FROM joengenduvel/docker-x11-client

# Developer tools
RUN apk add --no-cache git nodejs ruby python2 make gcc \
 && gem install sass --no-doc \
 && npm install -g grunt-cli bower 
