#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════════════════╗
# ║                    OpenCode Memory Setup - Quick Installer                  ║
# ║                         by Willian (Walbarellos)                           ║
# ║                                                                              ║
# ║  Usage:                                                                     ║
# ║    ./install.sh                    # Demo mode (no personal memories)       ║
# ║    PRIVATE_REPO=git@... ./install.sh  # With personal memories              ║
# ╚══════════════════════════════════════════════════════════════════════════════╝

set -e

INSTALL_DIR="$HOME/.opencode-memory"
REPO_URL="https://github.com/walbarellos/opencode-memory.git"
PRIVATE_REPO_URL="${PRIVATE_REPO_URL:-}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

# Banner
echo -e "${CYAN}"
echo "╔══════════════════════════════════════════════════════════════════════╗"
echo "║                                                                      ║"
echo "║     ██████╗ ████████╗ █████╗ ██████╗  ██████╗                       ║"
echo "║     ██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔═══██╗                      ║"
echo "║     ██████╔╝   ██║   ███████║██████╔╝██║   ██║                      ║"
echo "║     ██╔══██╗   ██║   ██╔══██║██╔══██╗██║   ██║                      ║"
echo "║     ██║  ██║   ██║   ██║  ██║██║  ██║╚██████╔╝                      ║"
echo "║     ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝                       ║"
echo "║                                                                      ║"
echo "║              Memory Setup - Quick Installer                           ║"
echo "║                         by Walbarellos                                 ║"
echo "║                                                                      ║"
echo "╚══════════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check for existing installation
if [ -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}⚠  OpenCode Memory já está instalado${NC}"
    read -p "Deseja reinstalar? Isso irá sobrescrever a instalação atual. (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Instalação cancelada."
        exit 0
    fi
    rm -rf "$INSTALL_DIR"
fi

# Distribution Selection
echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}  Selecione sua distribuição:${NC}"
echo ""
echo "  ${GREEN}[1]${NC} Arch Linux"
echo "  ${GREEN}[2]${NC} Ubuntu / Debian"
echo ""
read -p "  Escolha (1/2): " DISTRO

case $DISTRO in
    1) DISTRO_NAME="Arch Linux"
       PKG_MANAGER="pacman"
       ;;
    2) DISTRO_NAME="Ubuntu/Debian"
       PKG_MANAGER="apt"
       ;;
    *)
    echo -e "${RED}✗ Opção inválida!${NC}"
    exit 1
    ;;
esac
echo -e "${GREEN}✓ Distribuição: $DISTRO_NAME${NC}"

# Memory Mode Selection
echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}  Modo de instalação:${NC}"
echo ""
echo "  ${CYAN}[1]${NC} Demo Mode     - Memórias genéricas (público)"
echo "  ${MAGENTA}[2]${NC} Full Mode     - Inclui suas memórias pessoais (privado)"
echo "  ${YELLOW}[3]${NC} Custom URL     - URL do seu repo privado"
echo ""
read -p "  Escolha (1/2/3): " MEMORY_MODE

# Private Repo Setup
USE_PRIVATE=false
PRIVATE_CLONE_DIR=""

case $MEMORY_MODE in
    1)
        echo -e "${CYAN}→ Instalando em modo Demo (memórias genéricas)${NC}"
        ;;
    2)
        if [ -z "$PRIVATE_REPO_URL" ]; then
            echo -e "${MAGENTA}→ Clone seu repositório privado manualmente:${NC}"
            echo "  git clone git@github.com:walbarellos/opencode-memory-private.git"
            echo ""
            read -p "  Cole o caminho do repo privado (ou Enter para pular): " PRIVATE_PATH
            if [ -n "$PRIVATE_PATH" ]; then
                USE_PRIVATE=true
                PRIVATE_CLONE_DIR="$PRIVATE_PATH"
            fi
        else
            USE_PRIVATE=true
        fi
        ;;
    3)
        echo ""
        read -p "  Cole a URL SSH do repo privado: " CUSTOM_PRIVATE_URL
        if [ -n "$CUSTOM_PRIVATE_URL" ]; then
            USE_PRIVATE=true
            echo -e "${MAGENTA}→ Clonando repositório privado...${NC}"
            git clone "$CUSTOM_PRIVATE_URL" /tmp/opencode-memory-private 2>/dev/null || {
                echo -e "${RED}✗ Falha ao clonar repositório privado${NC}"
                echo "  Verifique se você tem acesso ao repositório"
                USE_PRIVATE=false
            }
            PRIVATE_CLONE_DIR="/tmp/opencode-memory-private"
        fi
        ;;
    *)
        echo -e "${RED}✗ Opção inválida! Usando modo Demo.${NC}"
        ;;
esac

# Create directories
echo -e "\n${BLUE}→ Criando diretórios...${NC}"
mkdir -p "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR/memories"
mkdir -p "$HOME/.mempalace"
mkdir -p "$HOME/.hermes/memories"

# Install Dependencies
echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}  Instalando dependências em $DISTRO_NAME...${NC}"

if command -v opencode &> /dev/null; then
    echo -e "${GREEN}✓ OpenCode já está instalado${NC}"
else
    echo -e "${YELLOW}→ Instalando OpenCode...${NC}"
    if [ "$DISTRO" = "1" ]; then
        if command -v yay &> /dev/null; then
            yay -S --noconfirm opencode 2>/dev/null || true
        elif command -v paru &> /dev/null; then
            paru -S --noconfirm opencode 2>/dev/null || true
        fi
    fi
    curl -fsSL https://raw.githubusercontent.com/opencode-ai/opencode/main/install.sh 2>/dev/null | sh || true
fi

# Install Python
if [ "$DISTRO" = "1" ]; then
    sudo pacman -S --noconfirm python python-pip 2>/dev/null || true
else
    sudo apt update -qq && sudo apt install -y python3 python3-pip 2>/dev/null || true
fi

# Install MemPalace
echo -e "${BLUE}→ Instalando MemPalace...${NC}"
pip3 install --user mempalace 2>/dev/null || pip install --user mempalace 2>/dev/null || true

# Copy files
echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}  Configurando arquivos...${NC}"

# Copy README
cp ~/opencode-memory/README.md "$INSTALL_DIR/" 2>/dev/null || true

# Copy memories based on mode
if [ "$USE_PRIVATE" = true ] && [ -d "$PRIVATE_CLONE_DIR/memories" ]; then
    echo -e "${MAGENTA}→ Copiando memórias pessoais...${NC}"
    cp -r "$PRIVATE_CLONE_DIR/memories/"* "$INSTALL_DIR/memories/" 2>/dev/null || true
    cp -r "$PRIVATE_CLONE_DIR/hermes/"* "$HOME/.hermes/memories/" 2>/dev/null || true
    cp "$PRIVATE_CLONE_DIR/mempalace/config.json" "$HOME/.mempalace/config.json" 2>/dev/null || true
    echo -e "${GREEN}✓ Memórias pessoais configuradas${NC}"
else
    # Create demo memories
    echo -e "${CYAN}→ Configurando memórias Demo...${NC}"
    
    cat > "$INSTALL_DIR/memories/demo_user.md" << 'EOF'
# User Profile (Demo)

## Identity
- Name: [Your Name]
- Age: [Your Age]
- Origin: [Your Country]
- Languages: [Your Languages]

## Interests
- Software Engineering
- Technology
- Learning

## Tech Stack
- Linux (any distribution)
- Python, JavaScript
- AI Tools

## Setup Instructions
Para usar suas memórias pessoais:
1. Clone o repositório privado de memórias
2. Use modo [2] na próxima instalação
3. Ou edite este arquivo manualmente
EOF

    cat > "$INSTALL_DIR/memories/demo_wakeup.txt" << 'EOF'
## L0 — IDENTITY
Configure seu perfil em memories/demo_user.md

## L1 — ESSENTIAL STORY
- [Adicione suas informações aqui]
- Use memórias demo ou importe suas próprias

## Setup
Consulte opencode-memory-private para memórias completas.
EOF
    echo -e "${GREEN}✓ Memórias Demo configuradas${NC}"
fi

# Copy HTML visualizer (from repo or inline)
echo -e "${BLUE}→ Configurando visualizador de memória...${NC}"
if [ -f ~/opencode-memory/index.html ]; then
    cp ~/opencode-memory/index.html "$INSTALL_DIR/index.html"
    echo -e "${GREEN}✓ Visualizador 3D configurado${NC}"
else
    echo -e "${YELLOW}⚠  index.html não encontrado, criando versão básica...${NC}"
fi

# Copy install script
cp "$0" "$INSTALL_DIR/install.sh"
chmod +x "$INSTALL_DIR/install.sh"

# Create uninstall script
cat > "$INSTALL_DIR/uninstall.sh" << 'EOF'
#!/bin/bash
echo "Desinstalando OpenCode Memory Setup..."
rm -rf "$HOME/.opencode-memory"
rm -rf "$HOME/.mempalace"
rm -rf "$HOME/.hermes"
echo "✓ Desinstalação concluída"
EOF
chmod +x "$INSTALL_DIR/uninstall.sh"

# Copy Vigilia binary if available
if [ -f "/home/walbarellos/Vigilia/.venv/bin/mempalace" ]; then
    mkdir -p "$INSTALL_DIR/tools"
    cp "/home/walbarellos/Vigilia/.venv/bin/mempalace" "$INSTALL_DIR/tools/"
    echo -e "${GREEN}✓ MemPalace CLI copiado${NC}"
fi

# Create sync script for private repo
if [ "$USE_PRIVATE" = true ]; then
    cat > "$INSTALL_DIR/sync-memories.sh" << EOF
#!/bin/bash
# Sincroniza memórias com repositório privado
PRIVATE_REPO="$PRIVATE_CLONE_DIR"

if [ -d "\$PRIVATE_REPO" ]; then
    echo "Sincronizando memórias..."
    cp -r "\$HOME/.mempalace/config.json" "\$PRIVATE_REPO/mempalace/" 2>/dev/null || true
    cp "\$HOME/.hermes/memories/USER.md" "\$PRIVATE_REPO/hermes/" 2>/dev/null || true
    cd "\$PRIVATE_REPO"
    git add .
    git commit -m "sync memories \$(date)"
    git push
    echo "✓ Memórias sincronizadas"
else
    echo "Repositório privado não encontrado"
fi
EOF
    chmod +x "$INSTALL_DIR/sync-memories.sh"
fi

# Final message
echo -e "\n${CYAN}╔══════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}${GREEN}  ✓ INSTALAÇÃO CONCLUÍDA COM SUCESSO!${NC}${CYAN}                                          ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}  Local:${NC}       $INSTALL_DIR"
echo -e "${BLUE}  Modo:${NC}        $([ "$USE_PRIVATE" = true ] && echo "Personal (Privado)" || echo "Demo (Genérico)")"
echo ""
echo -e "${YELLOW}  Próximos passos:${NC}"
echo "    1. Abrir visualizador:"
echo "       xdg-open $INSTALL_DIR/index.html"
echo ""
echo "    2. Testar OpenCode:"
echo "       opencode run 'hello world'"
echo ""
echo "    3. Para desinstalar:"
echo "       $INSTALL_DIR/uninstall.sh"
echo ""
if [ "$USE_PRIVATE" = true ]; then
    echo -e "${MAGENTA}  Para sincronizar memórias:${NC}"
    echo "    $INSTALL_DIR/sync-memories.sh"
    echo ""
fi
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
