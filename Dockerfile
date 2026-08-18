FROM ollama/ollama:latest

# Installiere zusätzliche Tools für CLI-Zugriff
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

# Volume für Models
VOLUME ["/root/.ollama"]

# Starte über unser Script
CMD [ "/run.sh" ]
