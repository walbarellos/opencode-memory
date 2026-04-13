#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════════════════╗
# ║              Memory Palace - Demo Installer                               ║
# ║                        by Willian (Walbarellos)                          ║
# ║                                                                              ║
# ║  Este script instala apenas o VISUALIZADOR (demo, sem memórias).           ║
# ║  Para instalação COMPLETA com suas memórias, use:                           ║
# ║    git clone git@github.com:walbarellos/opencode-memory-private.git         ║
# ║    cd opencode-memory-private && ./setup-master.sh                          ║
# ╚══════════════════════════════════════════════════════════════════════════════╝

set -e

INSTALL_DIR="$HOME/.opencode-memory"

echo ""
echo "🧠 Memory Palace - Demo Installer"
echo "────────────────────────────────────────"
echo ""
echo "Este script instala apenas o visualizador DEMO."
echo ""
echo "⚠️  Para instalar com SUAS memórias pessoais:"
echo "    git clone git@github.com:walbarellos/opencode-memory-private.git"
echo "    cd opencode-memory-private && ./setup-master.sh"
echo ""
read -p "Continuar com demo? (Y/n): " -n 1 -r
echo
[[ $REPLY =~ ^[Nn]$ ]] && exit 0

echo ""
echo "→ Instalando em: $INSTALL_DIR"
echo ""

# Create directory
mkdir -p "$INSTALL_DIR"

# Copy files from current directory
cp index.html "$INSTALL_DIR/" 2>/dev/null || true
cp memories.json "$INSTALL_DIR/" 2>/dev/null || true

# Create serve script
cat > "$INSTALL_DIR/serve.sh" << 'SERVE'
#!/bin/bash
PORT="${1:-8080}"
echo "→ Servidor em http://localhost:$PORT"
echo "Abra: http://localhost:$PORT/index.html"
cd "$(dirname "$0")"
python3 -m http.server "$PORT" --bind 0.0.0.0
SERVE
chmod +x "$INSTALL_DIR/serve.sh"

# Create uninstall
cat > "$INSTALL_DIR/uninstall.sh" << 'UNINSTALL'
#!/bin/bash
echo "Desinstalar? (SIM para confirmar)"
read confirm
[ "$confirm" = "SIM" ] && rm -rf "$HOME/.opencode-memory" && echo "✓"
UNINSTALL
chmod +x "$INSTALL_DIR/uninstall.sh"

echo "✓ Instalado!"
echo ""
echo "Para iniciar:"
echo "  cd $INSTALL_DIR && ./serve.sh"
echo "  Abrir: http://localhost:8080"
echo ""
