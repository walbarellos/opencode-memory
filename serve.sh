#!/bin/bash
# Memory Palace Server
PORT="${1:-8080}"
DIR="$HOME/.opencode-memory"

echo "→ Servidor em http://localhost:$PORT"
echo "Abra: http://localhost:$PORT/index.html"
echo ""

cd "$DIR"
python3 -m http.server "$PORT" --bind 0.0.0.0
