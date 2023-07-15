FROM ubuntu:latest 
RUN apt-get update && \
    apt-get install -y curl openssl \
        dnsutils socat vim pv tmux jq
COPY setup-scripts /setup-scripts/
RUN /setup-scripts/setup-notation.sh
RUN /setup-scripts/setup-oras.sh
RUN rm -rf /setup-scripts

# Create user signer
RUN useradd -m signer

WORKDIR /notation-demos

RUN echo '#!/bin/bash' > /start.sh && \
    echo '/notation-demos/setup-scripts/setup-registry-forwarding.sh &' >> /start.sh && \
    echo 'exec "$@"' >> /start.sh && \
    chmod +x /start.sh

# Switch to user signer
USER signer

CMD ["/start.sh", "bash"]