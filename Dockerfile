# Use an official base image
FROM alpine:latest

# Set the version of Prometheus you want to use
ARG PROMETHEUS_VERSION=2.30.0

# Add necessary dependencies
RUN apk --no-cache add curl tar

# Download and extract Prometheus
RUN curl -L "https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz" \
    | tar -xz --strip-components=1 -C /usr/local/bin/ --wildcards '*/prometheus' '*/promtool'

# Clean up unnecessary dependencies
RUN apk del curl tar

# Copy the Prometheus configuration file into the container
COPY prometheus.yml /etc/prometheus/

# Set the working directory
WORKDIR /etc/prometheus

# Expose the default Prometheus port
EXPOSE 9090

# Set the default command for the container
CMD ["prometheus", "--config.file=/etc/prometheus/prometheus.yml"]
