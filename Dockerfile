FROM caddy:builder as builder
ARG CADDY_VERSION
ARG ROUTE53_VERSION

RUN xcaddy build ${CADDY_VERSION} \
    --with github.com/caddy-dns/route53@${ROUTE53_VERSION}

FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
RUN /usr/bin/caddy version
RUN /usr/bin/caddy list-modules --skip-standard --versions
