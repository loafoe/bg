FROM golang:1.17.0-alpine3.13 AS build
ARG VERSION
ENV VERSION=${VERSION}
WORKDIR /src
ENV CGO_ENABLED=0
COPY go.* .
RUN go mod download
COPY . .
RUN go build -o /src/bg -ldflags "-X main.Version=${VERSION}" .

FROM golang:1.17.0-alpine3.13
RUN apk add --no-cache tzdata ca-certificates
ENV HOME /root
WORKDIR /app
EXPOSE 8080
COPY --from=build /src/bg /app/bg
CMD ["/app/bg"]
