FROM ubuntu:latest 
RUN apt-get update && \
    apt-get install -y curl openssl \
        dnsutils socat vim pv tmux jq
COPY setup-scripts /setup-scripts/
RUN /setup-scripts/setup-notation.sh
RUN /setup-scripts/setup-oras.sh
RUN rm -rf /setup-scripts
WORKDIR /notation-demos
