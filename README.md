# Ollama Home Assistant Add-on

Dieses Add-on führt Ollama als Dienst in Home Assistant aus, damit du LLM-Modelle lokal oder über Ollama Cloud nutzen kannst.

## Features

- **Ollama Server** läuft auf Standard-Port `11434`
- **Ollama Cloud Login** über integrierte CLI möglich
- **Persistent Models** werden im HA `/config` Storage gesichert
- **Integration-freundlich** – andere HA-Integrationen können via `http://a0d7b954-ollama:11434` oder `http://homeassistant:11434` zugreifen

## Installation

### 1. Repository zum HA Add-on Store hinzufügen

1. Home Assistant → Einstellungen → Add-ons → Add-on Store
2. Menü (⋮) → Repositories
3. URL einfügen: `https://github.com/wolli112-vc/ollama-ha-app`
4. Hinzufügen → Schliessen

### 2. Add-on installieren & starten

1. Im Store "Ollama" suchen und installieren
2. Konfiguration anpassen (optional):
   - `models_dir`: Verzeichnis für Modelle (Default: `/config/models`)
   - `env_vars`: Zusätzliche Umgebungsvariablen
3. Starten

### 3. Ollama Cloud Login

Falls du Modelle von ollama.com nutzen willst (z.B. Private Models):

```bash
# In der Home Assistant Terminal/SSH Add-on Konsole:
ollama-login
```

Du wirst nach deinem API Key gefragt. Diesen findest du unter:
https://ollama.com/settings/keys

### 4. Von Integrationen aus ansprechen

Andere HA-Integrationen (z.B. `extended_openai_conversation`, `llmvision`, oder Custom Integrations) können Ollama über diese URL erreichen:

```
http://homeassistant:11434
```

Oder innerhalb des Docker Netzwerks:

```
http://a0d7b954-ollama:11434
```

## CLI-Befehle

```bash
# Login bei ollama.com
ollama-login

# Login-Status prüfen
ollama-login status

# Logout
ollama-login logout
```

## Konfiguration

| Option     | Beschreibung                        | Default           |
|------------|-------------------------------------|-------------------|
| models_dir | Persistenter Speicher für Modelle   | `/config/models`  |
| env_vars   | Liste von `name`/`value` Paaren    | `[]`              |

## Port

| Port  | Protokoll | Beschreibung          |
|-------|-----------|-----------------------|
| 11434 | TCP       | Ollama API            |

## Version

Aktuelle Version: **1.0.1**

## Lizenz

Siehe [LICENSE](LICENSE)
