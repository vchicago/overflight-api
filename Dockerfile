FROM golang:1.16-alpine as builder
WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -o app .

FROM alpine:latest
RUN mkdir /app
ADD static /app/static
COPY --from=builder /app/app /app/app
WORKDIR /app
ENTRYPOINT [ "./app" ]