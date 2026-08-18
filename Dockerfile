ARG BUILD_FROM=ollama/ollama:latest
FROM ${BUILD_FROM}

# Home Assistant Labels
LABEL \
    io.hass.type="addon" \
    io.hass.name="Ollama" \
    io.hass.description="Ollama LLM Server as Home Assistant Add-on" \
    io.hass.version="1.0.1" \
    maintainer="wolli112-vc"

# Install additional tools for CLI access
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Copy start script
COPY run.sh /
RUN chmod a+x /run.sh

# Expose Ollama Port
EXPOSE 11434

# Volume for Models
VOLUME ["/root/.ollama"]

# Start via our script
CMD [ "/run.sh" ]
