# OpenCode Memory Installer
# Supports Arch Linux and Ubuntu/Debian
# Author: Willian (Walbarellos)

set -e

INSTALL_DIR="$HOME/.opencode-memory"
REPO_URL="https://github.com/walbarellos/opencode-memory.git"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║     OpenCode Memory Setup - Quick Installer               ║"
echo "║     by Willian (Walbarellos)                               ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if already installed
if [ -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}⚠  OpenCode Memory já está instalado em $INSTALL_DIR${NC}"
    read -p "Deseja reinstalar? Isso irá sobrescrever a instalação atual. (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Instalação cancelada."
        exit 0
    fi
    rm -rf "$INSTALL_DIR"
fi

# Select distribution
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}Selecione sua distribuição:${NC}"
echo ""
echo "  1) Arch Linux"
echo "  2) Ubuntu / Debian"
echo ""
read -p "Escolha (1/2): " DISTRO

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

echo -e "${GREEN}✓ Distribuição selecionada: $DISTRO_NAME${NC}"
echo ""

# Create install directory
echo -e "${BLUE}→ Criando diretório de instalação...${NC}"
mkdir -p "$INSTALL_DIR"
mkdir -p "$HOME/.mempalace"
mkdir -p "$HOME/.hermes/memories"

# Install dependencies
echo -e "${BLUE}→ Instalando dependências em $DISTRO_NAME...${NC}"

if command -v opencode &> /dev/null; then
    echo -e "${GREEN}✓ OpenCode já está instalado${NC}"
else
    echo -e "${YELLOW}→ Instalando OpenCode...${NC}"
    
    if [ "$DISTRO" = "1" ]; then
        # Arch Linux - install via yay or aurman
        if command -v yay &> /dev/null; then
            yay -S --noconfirm opencode
        elif command -v paru &> /dev/null; then
            paru -S --noconfirm opencode
        else
            echo -e "${YELLOW}⚠  OpenCode não está no AUR. Tentando instalar via script...${NC}"
            curl -fsSL https://raw.githubusercontent.com/opencode-ai/opencode/main/install.sh | sh
        fi
    else
        # Ubuntu/Debian - install via script
        curl -fsSL https://raw.githubusercontent.com/opencode-ai/opencode/main/install.sh | sh
    fi
fi

# Install Python and pip if not present
if [ "$DISTRO" = "1" ]; then
    sudo pacman -S --noconfirm python python-pip python-virtualenv 2>/dev/null || \
    sudo pacman -S --noconfirm python python-pip
else
    sudo apt update && sudo apt install -y python3 python3-pip python3-venv
fi

# Install MemPalace
echo -e "${BLUE}→ Instalando MemPalace...${NC}"
pip install --user mempalace 2>/dev/null || pip3 install --user mempalace

# Copy files from repository or create them
echo -e "${BLUE}→ Configurando arquivos do repositório...${NC}"

# Create memories directory
mkdir -p "$INSTALL_DIR/memories"

# User info markdown
cat > "$INSTALL_DIR/memories/user_info.md" << 'EOF'
# User Profile: Willian

- Name: Willian (also called Walbarellos on Linux)
- Age: 30 years old
- Origin: Brazil
- Languages: Portuguese (BR), English (US), Hebrew, Spanish
- Operating System: Linux (Arch)

## Interests

- Software Engineering (passionate about it)
- Anime and Manga
- Video Games
- Cryptocurrencies
- Israel and Israeli culture
- Judaism and Hebrew language

## Technical Background

- Uses Arch Linux
- Uses MemPalace for AI memory management
- Uses Hermes as an AI agent
- Uses Vigilia as development environment
- Familiar with CLI tools and programming
EOF

# Wake-up context
cat > "$INSTALL_DIR/memories/wakeup.txt" << 'EOF'
## L0 — IDENTITY

Name: Willian (also called Walbarellos on Linux)
Age: 30 years old
Origin: Brazil

## L1 — ESSENTIAL STORY

- Speaks: Portuguese (BR), English (US), Hebrew, Spanish
- Passionate about: Software Engineering, Anime/Manga, Video Games, Cryptocurrencies, Israel, Judaism, Hebrew
- Uses: Arch Linux, OpenCode, MemPalace, Hermes Agent, Vigilia
- CLI and programming expert
EOF

# Create HTML visualizer
cat > "$INSTALL_DIR/index.html" << 'HTMLEOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Willian's Memory Network</title>
    <script src="https://d3js.org/d3.v7.min.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #fff;
            min-height: 100vh;
        }
        .header {
            background: rgba(0,0,0,0.3);
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .header h1 { font-size: 1.5rem; color: #e94560; }
        .header .subtitle { color: #888; font-size: 0.9rem; }
        .controls {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        .search-box {
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.2);
            padding: 8px 15px;
            border-radius: 20px;
            color: #fff;
            width: 250px;
        }
        .search-box::placeholder { color: #888; }
        .filter-btn {
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.2);
            padding: 8px 15px;
            border-radius: 20px;
            color: #fff;
            cursor: pointer;
            transition: all 0.3s;
        }
        .filter-btn:hover, .filter-btn.active {
            background: #e94560;
            border-color: #e94560;
        }
        #graph {
            width: 100%;
            height: calc(100vh - 100px);
        }
        .node {
            cursor: pointer;
            transition: all 0.3s;
        }
        .node:hover { filter: brightness(1.3); }
        .node-label {
            font-size: 11px;
            fill: #fff;
            text-anchor: middle;
            pointer-events: none;
        }
        .link {
            stroke-opacity: 0.4;
        }
        .tooltip {
            position: absolute;
            background: rgba(0,0,0,0.9);
            border: 1px solid #e94560;
            padding: 15px;
            border-radius: 10px;
            max-width: 300px;
            display: none;
            z-index: 1000;
        }
        .tooltip h3 { color: #e94560; margin-bottom: 10px; }
        .tooltip p { color: #ccc; font-size: 0.9rem; line-height: 1.5; }
        .legend {
            position: fixed;
            bottom: 20px;
            left: 20px;
            background: rgba(0,0,0,0.7);
            padding: 15px;
            border-radius: 10px;
            font-size: 0.85rem;
        }
        .legend-item { display: flex; align-items: center; gap: 10px; margin: 5px 0; }
        .legend-dot { width: 12px; height: 12px; border-radius: 50%; }
        .stats {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: rgba(0,0,0,0.7);
            padding: 15px;
            border-radius: 10px;
            font-size: 0.85rem;
        }
        .stats span { color: #e94560; font-weight: bold; }
    </style>
</head>
<body>
    <div class="header">
        <div>
            <h1>🧠 Willian's Memory Network</h1>
            <p class="subtitle">MemPalace Memory Visualizer</p>
        </div>
        <div class="controls">
            <input type="text" class="search-box" id="search" placeholder="Search memories...">
            <button class="filter-btn active" data-filter="all">All</button>
            <button class="filter-btn" data-filter="identity">Identity</button>
            <button class="filter-btn" data-filter="language">Languages</button>
            <button class="filter-btn" data-filter="interest">Interests</button>
            <button class="filter-btn" data-filter="tech">Tech</button>
        </div>
    </div>
    
    <svg id="graph"></svg>
    
    <div class="tooltip" id="tooltip"></div>
    
    <div class="legend">
        <div class="legend-item"><div class="legend-dot" style="background:#4ade80"></div> Identity</div>
        <div class="legend-item"><div class="legend-dot" style="background:#60a5fa"></div> Languages</div>
        <div class="legend-item"><div class="legend-dot" style="background:#c084fc"></div> Interests</div>
        <div class="legend-item"><div class="legend-dot" style="background:#fb923c"></div> Technologies</div>
    </div>
    
    <div class="stats">
        <p>Nodes: <span id="nodeCount">0</span></p>
        <p>Connections: <span id="linkCount">0</span></p>
    </div>

    <script>
        const width = window.innerWidth;
        const height = window.innerHeight - 100;
        
        const svg = d3.select("#graph")
            .attr("width", width)
            .attr("height", height);
        
        const g = svg.append("g");
        
        // Zoom behavior
        const zoom = d3.zoom()
            .scaleExtent([0.1, 4])
            .on("zoom", (event) => g.attr("transform", event.transform));
        
        svg.call(zoom);
        
        // Memory data
        const data = {
            nodes: [
                // Identity
                { id: "Willian", group: "identity", label: "Willian", desc: "Full name: Willian. Also known as Walbarellos on Linux systems. 30 years old from Brazil." },
                { id: "Brazil", group: "identity", label: "🇧🇷 Brazil", desc: "Country of origin. Located in South America." },
                { id: "Age30", group: "identity", label: "30 years old", desc: "Born approximately in 1996." },
                
                // Languages
                { id: "PT-BR", group: "language", label: "🇧🇷 Portuguese", desc: "Native language. Portuguese from Brazil." },
                { id: "EN-US", group: "language", label: "🇺🇸 English", desc: "Fluent in American English." },
                { id: "Hebrew", group: "language", label: "🇮🇱 Hebrew", desc: "Speaks Hebrew (interest related to Israel and Judaism)." },
                { id: "ES", group: "language", label: "🇪🇸 Spanish", desc: "Fluent in Spanish." },
                
                // Interests
                { id: "SoftwareEng", group: "interest", label: "💻 Software Eng.", desc: "Passionate about software engineering. Expert level." },
                { id: "Anime", group: "interest", label: "🎌 Anime", desc: "Loves anime and manga culture." },
                { id: "Manga", group: "interest", label: "📚 Manga", desc: "Enjoys reading manga." },
                { id: "Games", group: "interest", label: "🎮 Video Games", desc: "Passionate gamer." },
                { id: "Crypto", group: "interest", label: "₿ Crypto", desc: "Interested in cryptocurrencies and blockchain." },
                { id: "Israel", group: "interest", label: "🇮🇱 Israel", desc: "Deep interest in Israeli culture and country." },
                { id: "Judaism", group: "interest", label: "✡️ Judaism", desc: "Practicing or studying Judaism." },
                { id: "HebrewLang", group: "interest", label: "עברית Hebrew", desc: "Studying Hebrew language ( עברית )." },
                
                // Technologies
                { id: "Arch", group: "tech", label: "🟢 Arch Linux", desc: "Uses Arch Linux as primary OS." },
                { id: "OpenCode", group: "tech", label: "⚡ OpenCode", desc: "Uses OpenCode AI coding assistant." },
                { id: "MemPalace", group: "tech", label: "🏛️ MemPalace", desc: "Uses MemPalace for AI memory management." },
                { id: "Hermes", group: "tech", label: "🤖 Hermes", desc: "Uses Hermes Agent for AI tasks." },
                { id: "Vigilia", group: "tech", label: "🔮 Vigilia", desc: "Development environment setup." },
                { id: "CLI", group: "tech", label: "⌨️ CLI Expert", desc: "Expert in command-line interfaces." }
            ],
            links: [
                // Identity connections
                { source: "Willian", target: "Brazil" },
                { source: "Willian", target: "Age30" },
                { source: "Willian", target: "PT-BR" },
                { source: "Willian", target: "EN-US" },
                { source: "Willian", target: "Hebrew" },
                { source: "Willian", target: "ES" },
                { source: "Willian", target: "SoftwareEng" },
                { source: "Willian", target: "Arch" },
                
                // Language connections
                { source: "PT-BR", target: "Brazil" },
                { source: "Hebrew", target: "Israel" },
                { source: "Hebrew", target: "HebrewLang" },
                { source: "Hebrew", target: "Judaism" },
                
                // Interest connections
                { source: "SoftwareEng", target: "CLI" },
                { source: "SoftwareEng", target: "OpenCode" },
                { source: "SoftwareEng", target: "MemPalace" },
                { source: "SoftwareEng", target: "Hermes" },
                { source: "Anime", target: "Manga" },
                { source: "Games", target: "SoftwareEng" },
                { source: "Crypto", target: "SoftwareEng" },
                { source: "Israel", target: "Judaism" },
                { source: "Judaism", target: "HebrewLang" },
                
                // Tech connections
                { source: "Arch", target: "CLI" },
                { source: "Arch", target: "OpenCode" },
                { source: "OpenCode", target: "MemPalace" },
                { source: "OpenCode", target: "Hermes" },
                { source: "MemPalace", target: "Vigilia" },
                { source: "Hermes", target: "Vigilia" },
                { source: "MemPalace", target: "Hermes" }
            ]
        };
        
        // Color scale
        const color = d3.scaleOrdinal()
            .domain(["identity", "language", "interest", "tech"])
            .range(["#4ade80", "#60a5fa", "#c084fc", "#fb923c"]);
        
        // Size scale based on connections
        const nodeSize = d3.scaleOrdinal()
            .domain([0, 1, 2, 3, 4])
            .range([8, 12, 16, 20, 25]);
        
        // Simulation
        const simulation = d3.forceSimulation(data.nodes)
            .force("link", d3.forceLink(data.links).id(d => d.id).distance(100))
            .force("charge", d3.forceManyBody().strength(-300))
            .force("center", d3.forceCenter(width/2, height/2))
            .force("collision", d3.forceCollide().radius(40));
        
        // Links
        const link = g.append("g")
            .selectAll("line")
            .data(data.links)
            .join("line")
            .attr("class", "link")
            .attr("stroke", "#fff")
            .attr("stroke-width", 1.5);
        
        // Nodes
        const node = g.append("g")
            .selectAll("g")
            .data(data.nodes)
            .join("g")
            .attr("class", "node")
            .call(d3.drag()
                .on("start", dragstarted)
                .on("drag", dragged)
                .on("end", dragended));
        
        node.append("circle")
            .attr("r", d => {
                const count = data.links.filter(l => l.source.id === d.id || l.target.id === d.id).length;
                return nodeSize(Math.min(count, 4));
            })
            .attr("fill", d => color(d.group))
            .attr("stroke", "#fff")
            .attr("stroke-width", 2);
        
        node.append("text")
            .attr("class", "node-label")
            .attr("dy", d => {
                const count = data.links.filter(l => l.source.id === d.id || l.target.id === d.id).length;
                return nodeSize(Math.min(count, 4)) + 15;
            })
            .text(d => d.label);
        
        // Tooltip
        const tooltip = d3.select("#tooltip");
        
        node.on("mouseover", (event, d) => {
            tooltip.style("display", "block")
                .style("left", (event.pageX + 15) + "px")
                .style("top", (event.pageY - 15) + "px")
                .html(`<h3>${d.label}</h3><p>${d.desc}</p>`);
        })
        .on("mouseout", () => tooltip.style("display", "none"));
        
        // Update positions
        simulation.on("tick", () => {
            link
                .attr("x1", d => d.source.x)
                .attr("y1", d => d.source.y)
                .attr("x2", d => d.target.x)
                .attr("y2", d => d.target.y);
            
            node.attr("transform", d => `translate(${d.x},${d.y})`);
        });
        
        // Drag functions
        function dragstarted(event) {
            if (!event.active) simulation.alphaTarget(0.3).restart();
            event.subject.fx = event.subject.x;
            event.subject.fy = event.subject.y;
        }
        
        function dragged(event) {
            event.subject.fx = event.x;
            event.subject.fy = event.y;
        }
        
        function dragended(event) {
            if (!event.active) simulation.alphaTarget(0);
            event.subject.fx = null;
            event.subject.fy = null;
        }
        
        // Search functionality
        const searchBox = document.getElementById("search");
        searchBox.addEventListener("input", (e) => {
            const query = e.target.value.toLowerCase();
            node.style("opacity", d => {
                if (!query) return 1;
                return d.label.toLowerCase().includes(query) || d.desc.toLowerCase().includes(query) ? 1 : 0.2;
            });
            link.style("opacity", d => {
                if (!query) return 0.4;
                const sourceMatch = d.source.label.toLowerCase().includes(query);
                const targetMatch = d.target.label.toLowerCase().includes(query);
                return sourceMatch || targetMatch ? 0.8 : 0.1;
            });
        });
        
        // Filter buttons
        document.querySelectorAll(".filter-btn").forEach(btn => {
            btn.addEventListener("click", () => {
                document.querySelectorAll(".filter-btn").forEach(b => b.classList.remove("active"));
                btn.classList.add("active");
                
                const filter = btn.dataset.filter;
                node.style("opacity", d => {
                    if (filter === "all") return 1;
                    return d.group === filter ? 1 : 0.2;
                });
                link.style("opacity", d => {
                    if (filter === "all") return 0.4;
                    return d.source.group === filter || d.target.group === filter ? 0.8 : 0.1;
                });
            });
        });
        
        // Update stats
        document.getElementById("nodeCount").textContent = data.nodes.length;
        document.getElementById("linkCount").textContent = data.links.length;
        
        // Center view
        svg.call(zoom.transform, d3.zoomIdentity.translate(width/4, height/4).scale(0.8));
    </script>
</body>
</html>
HTMLEOF

# Copy to memories backup
cp ~/opencode-memory/memories/user_info.md "$INSTALL_DIR/memories/"

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓ Instalação concluída com sucesso!${NC}"
echo ""
echo -e "${BLUE}Local de instalação:${NC} $INSTALL_DIR"
echo ""
echo -e "${YELLOW}Próximos passos:${NC}"
echo "  1. Abra o visualizador: xdg-open $INSTALL_DIR/index.html"
echo "  2. Configure suas memórias no MemPalace"
echo "  3. Use: opencode run 'sua pergunta'"
echo ""
echo -e "${RED}Para desinstalar:${NC}"
echo "  rm -rf $INSTALL_DIR"
echo "  rm -rf ~/.mempalace"
echo "  rm -rf ~/.hermes"
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
