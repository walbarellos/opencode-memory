#!/bin/bash
# ═══════════════════════════════════════════════════════════════════════════════
# Memory Palace Server - Serve o visualizador 3D
# ═══════════════════════════════════════════════════════════════════════════════

set -e

PORT="${1:-8080}"
DIR="${2:-$HOME/.opencode-memory}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

# Banner
echo -e "${CYAN}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║        🧠 Memory Palace - Neural Network Visualizer       ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if directory exists
if [ ! -d "$DIR" ]; then
    echo -e "${RED}✗ Diretório não encontrado: $DIR${NC}"
    echo "Execute o instalador primeiro: ./setup-master.sh"
    exit 1
fi

# Check for Python (works everywhere)
if command -v python3 &> /dev/null; then
    echo -e "${GREEN}→ Iniciando servidor em http://localhost:$PORT${NC}"
    echo -e "${CYAN}Pressione Ctrl+C para parar${NC}"
    echo ""
    cd "$DIR"
    python3 -m http.server "$PORT"
elif command -v python &> /dev/null; then
    echo -e "${GREEN}→ Iniciando servidor em http://localhost:$PORT${NC}"
    cd "$DIR"
    python -m SimpleHTTPServer "$PORT"
else
    echo -e "${RED}✗ Python não encontrado${NC}"
    echo "Instale Python para usar o servidor"
    exit 1
fi
