FROM golang:1.23-alpine as base

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o /app/main .

# Stage 2: Create a minimal image
FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["/main"]
