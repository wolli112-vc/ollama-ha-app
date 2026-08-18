#!/usr/bin/with-contenv bashio

# =============================================================================
# Ollama Home Assistant Add-on Start Script
# Version: 1.0.0
# =============================================================================

bashio::log.info "Starting Ollama Add-on..."

# Environment Variablen aus HA Config lesen
MODELS_DIR=$(bashio::config 'models_dir')

# Models-Verzeichnis erstellen falls nicht vorhanden
if ! bashio::fs.directory_exists "${MODELS_DIR}"; then
    bashio::log.info "Creating models directory at ${MODELS_DIR}"
    mkdir -p "${MODELS_DIR}"
fi

# Symlink für Ollama Models
if [ ! -L /root/.ollama ] && [ ! -d /root/.ollama ]; then
    bashio::log.info "Linking models directory to /root/.ollama"
    ln -sf "${MODELS_DIR}" /root/.ollama
fi

# Custom Environment Variablen setzen
if bashio::config.has_value 'env_vars'; then
    for var in $(bashio::config 'env_vars|keys'); do
        name=$(bashio::config "env_vars[${var}].name")
        value=$(bashio::config "env_vars[${var}].value")
        bashio::log.info "Setting env var: ${name}"
        export "${name}=${value}"
    done
fi

# OLLAMA_HOST auf alle Interfaces setzen (damit HA von aussen drankommt)
export OLLAMA_HOST=0.0.0.0:11434

bashio::log.info "Ollama API will be available on port 11434"
bashio::log.info "Use the addon CLI for ollama.com login"

# Ollama Server starten
exec /bin/ollama serve
