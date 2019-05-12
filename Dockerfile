FROM debian:9
LABEL maintainer="mike@thebarkers.com" \
      description="An exercism 'haskel' track image." \
      version="0.1.1"

# Update, upgrade and install dev tools
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y git procps tree vim wget 

# Install exercism tool
RUN cd /tmp \
    && wget https://github.com/exercism/cli/releases/download/v3.0.11/exercism-linux-64bit.tgz \
    && tar xzf exercism-linux-64bit.tgz \
    && mv exercism /usr/local/bin/

# Install the haskel tools
RUN wget -qO- https://get.haskellstack.org/ | sh \
    && stack install ghc \
    && stack install hlint

# Clean up apt repo
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root/exercism

CMD ["bash", "--login"]
