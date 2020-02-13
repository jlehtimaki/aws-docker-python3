FROM alpine:3.11 AS builder

RUN apk add --no-cache unzip curl

WORKDIR /build

# Fetch awscli installation
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip

FROM python:3.6.10

RUN apt update && apt install curl git
COPY --from=builder /build/aws .

RUN ./install -b /bin

CMD ["python3"]

