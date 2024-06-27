# Build stage
FROM golang:1.20 AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o rpccache .

# Final stage
FROM scratch

COPY --from=builder /app/rpccache .

EXPOSE 6969

CMD ["./rpccache"]
