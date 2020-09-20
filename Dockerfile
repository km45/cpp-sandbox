FROM debian:10-slim

# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ccache \
        cmake \
        g++ \
        libgtest-dev \
        ninja-build \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV CCACHE_DIR /tmp/.ccache

CMD ["tail", "-f", "/dev/null"]
