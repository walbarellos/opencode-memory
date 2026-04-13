#!/bin/bash
# ═══════════════════════════════════════════════════════════════════════════════
# Memory Palace Server - Serve o visualizador 3D com CORS
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

# Check for Python
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}✗ Python3 não encontrado${NC}"
    echo "Instale Python3 para usar o servidor"
    exit 1
fi

echo -e "${GREEN}→ Iniciando servidor em http://localhost:$PORT${NC}"
echo -e "${CYAN}Pressione Ctrl+C para parar${NC}"
echo ""
echo -e "Abra no navegador: http://localhost:$PORT/index.html"
echo ""

cd "$DIR"

# Run Python server with CORS handler
python3 -c "
import http.server
import socketserver
import json

class CORSRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', '*')
        self.send_header('Cache-Control', 'no-store, no-cache, must-revalidate')
        super().end_headers()
    
    def log_message(self, format, *args):
        pass  # Silencia logs

PORT = $PORT
with socketserver.TCPServer(('', PORT), CORSRequestHandler) as httpd:
    print(f'Servidor rodando em http://localhost:{PORT}')
    httpd.serve_forever()
"
