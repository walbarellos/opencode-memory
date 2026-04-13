#!/bin/bash
# ═══════════════════════════════════════════════════════════════════════════════
# Memory Palace Server - Serve o visualizador 3D com CORS
# ═══════════════════════════════════════════════════════════════════════════════

PORT="${1:-8080}"
DIR="${2:-$HOME/.opencode-memory}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║        🧠 Memory Palace - Neural Network Visualizer       ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

if [ ! -d "$DIR" ]; then
    echo -e "${RED}✗ Diretório não encontrado: $DIR${NC}"
    exit 1
fi

echo -e "${GREEN}→ Iniciando servidor em http://localhost:${PORT}${NC}"
echo -e "${CYAN}Abra no navegador: http://localhost:${PORT}/index.html${NC}"
echo -e "${CYAN}Pressione Ctrl+C para parar${NC}"
echo ""

cd "$DIR"

# Simple Python server with CORS
python3 << PYEOF
import http.server
import socketserver
import os

class CORSHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', '*')
        super().end_headers()
    
    def log_message(self, format, *args):
        pass  # Silencia logs

PORT = ${PORT}
os.chdir('${DIR}')
with socketserver.TCPServer(('', PORT), CORSHandler) as httpd:
    print(f'Servidor rodando em http://localhost:{PORT}')
    httpd.serve_forever()
PYEOF
