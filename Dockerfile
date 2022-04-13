FROM golang:1.18 as builder

WORKDIR /traefik-auth-cloudflare
COPY . .

RUN go build

###

FROM gcr.io/distroless/base-debian11

# Switch to non-root user
RUN adduser -D myapp
USER myapp
WORKDIR /home/myapp

COPY --from=builder --chown=myapp:myapp /traefik-auth-cloudflare/traefik-auth-cloudflare ./

CMD ["./traefik-auth-cloudflare"]
