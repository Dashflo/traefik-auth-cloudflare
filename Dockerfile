FROM golang:1.18 as builder
WORKDIR /traefik-auth-cloudflare
COPY . .
RUN go build

###

FROM gcr.io/distroless/base-debian11
USER 1000
COPY --from=builder --chown=1000:1000 /traefik-auth-cloudflare/traefik-auth-cloudflare /app
CMD ["/app"]
