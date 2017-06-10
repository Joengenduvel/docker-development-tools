FROM joengenduvel/docker-x11-client

# Developer tools
RUN apk add --no-cache git nodejs ruby python2 make gcc g++ gnupg
RUN gem install sass --no-doc
RUN npm install -g grunt-cli bower
