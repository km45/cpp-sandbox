FROM alpine:3

# hadolint ignore=DL3018
RUN apk update \
    && apk add --no-cache \
        bash \
        cmake \
        g++ \
        ninja

CMD ["tail", "-f", "/dev/null"]
