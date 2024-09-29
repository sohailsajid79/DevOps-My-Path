# build stage 
FROM python:3.9-alpine AS builder

# install tools and libraries for alpine
RUN apk add --no-cache \
    gcc \
    musl-dev \
    libffi-dev \
    openssl-dev \
    python3-dev \
    build-base

WORKDIR /app

COPY requirements.txt .

# install dependencies into /app/dependencies dir without caching the packages
RUN pip install --no-cache-dir --target=/app/dependencies -r requirements.txt

# final stage - opting for minimal python image
FROM python:3.9-alpine

WORKDIR /app

# runtime dependencies
RUN apk add --no-cache libffi openssl

# install dependencies from builder stage
COPY --from=builder /app/dependencies /usr/local/lib/python3.9/site-packages

COPY . .

ENV FLASK_APP=app.py

CMD ["flask", "run", "--host=0.0.0.0", "--port=5002"]