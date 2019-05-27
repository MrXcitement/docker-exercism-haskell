FROM haskell:8
LABEL maintainer="mike@thebarkers.com" \
      description="An exercism 'haskell' track image." \
      version="0.1.2"

# Update, upgrade and install dev tools
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y git procps tree vim wget

# Install exercism tool
RUN cd /tmp \
    && wget https://github.com/exercism/cli/releases/download/v3.0.11/exercism-linux-64bit.tgz \
    && tar xzf exercism-linux-64bit.tgz \
    && mv exercism /usr/local/bin/

# Clean up apt repo
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Configure cabal and ghci
RUN echo 'PATH=/root/.cabal/bin:/root/.local/bin:/opt/cabal/bin:/opt/ghc/bin:$PATH' >> /root/.profile
ENV SHELL /bin/bash
WORKDIR /root/exercism

CMD ["bash", "--login"]
