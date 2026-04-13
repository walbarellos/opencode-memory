# OpenCode Memory Setup

🧠 Sistema de configuração rápida para OpenCode + MemPalace com rede neural de memórias.

## ⚠️ Privacidade

Este repositório contém apenas **memórias demo/genéricas**. Suas memórias pessoais devem estar em um **repositório privado** separado (`opencode-memory-private`).

### Estrutura de Repositórios

```
├── opencode-memory (ESTE REPO - PÚBLICO)
│   ├── install.sh       # Script de instalação
│   ├── index.html      # Visualizador de rede neural 3D
│   ├── memories/        # Apenas memórias DEMO
│   └── README.md
│
└── opencode-memory-private (REPO PRIVADO - SUAS MEMÓRIAS)
    ├── memories/        # Suas memórias reais
    ├── hermes/         # Config Hermes
    └── mempalace/      # Config MemPalace
```

## Características

- ✅ **Visualizador 3D** - Rede neural de memórias com Three.js
- ✅ **Multi-distro** - Suporte para Arch e Ubuntu
- ✅ **Modo Demo** - Sem dados pessoais
- ✅ **Modo Privado** - Inclui suas memórias seguras
- ✅ **Fácil uninstall** - Script de desinstalação limpo

## Tecnologias do Visualizador

| Tecnologia | Uso |
|------------|-----|
| **Three.js** | Renderização 3D WebGL |
| **D3.js** | Física do grafo (2D) |
| **GSAP** | Animações premium |
| **Particles.js** | Efeitos de fundo |
| **Phosphor Icons** | Ícones modernos |
| **CSS Glassmorphism** | Design futurista |
| **Orbitron Font** | Tipografia cyberpunk |

## Instalação Rápida

```bash
# Clone o repositório
git clone git@github.com:walbarellos/opencode-memory.git
cd opencode-memory

# Torne executável e rode
chmod +x install.sh
./install.sh
```

### Opções de Instalação

1. **Demo Mode** - Instala com memórias genéricas (sem dados pessoais)
2. **Full Mode** - Clone seu repo privado e inclua suas memórias
3. **Custom URL** - Especifique a URL do seu repo privado

## Variáveis de Ambiente

```bash
# Para usar com repo privado
export PRIVATE_REPO_URL="git@github.com:walbarellos/opencode-memory-private.git"
./install.sh
```

## Quick Install (One-liner Demo)

```bash
curl -fsSL https://raw.githubusercontent.com/walbarellos/opencode-memory/main/install.sh | bash
```

## Estrutura de Diretórios Após Instalação

```
~/.opencode-memory/
├── index.html          # Visualizador de rede neural 3D
├── install.sh         # Script de instalação
├── uninstall.sh       # Script de desinstalação
├── memories/          # Arquivos de memória
│   ├── demo_user.md  # Template de perfil
│   └── demo_wakeup.txt
└── README.md
```

## Segurança

- ⚠️ Nunca commite memórias pessoais em repos públicos
- ✅ Use o repo privado para dados sensíveis
- ✅ Use `.gitignore` para proteger arquivos locais
- ✅ Configure GitHub como repo privado

## Desinstalação

```bash
# Opção 1: Use o script
~/.opencode-memory/uninstall.sh

# Opção 2: Manual
rm -rf ~/.opencode-memory
rm -rf ~/.mempalace
rm -rf ~/.hermes
```

## Visualizador 3D

O `index.html` oferece:

- 🌐 Network 3D/2D interativo
- 🔍 Busca em tempo real
- 📊 Categorias filtráveis
- 🎯 Detalhes de nós
- ✨ Animações suaves
- 📱 Responsivo
- 🌙 Dark mode elegante

## Screenshots

```
┌─────────────────────────────────────────────────────────────┐
│  🧠 MEMORY PALACE - Neural Network Visualizer              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│                    ┌─────┐                                 │
│               ┌────┤User ├────┐                             │
│               │    └─────┘    │                             │
│           ┌───┴───┐       ┌───┴───┐                         │
│           │Languages     │Tech   │                          │
│           └───────┘       └───────┘                         │
│               │           │                                 │
│           ┌───┴───┐   ┌───┴───┐                             │
│           │Interest│   │Tools  │                            │
│           └───────┘   └───────┘                             │
│                                                             │
├─────────────────────────────────────────────────────────────┤
│  Nodes: 24  │  Connections: 35  │  Categories: 4            │
└─────────────────────────────────────────────────────────────┘
```

## Contribuir

1. Fork o repositório
2. Crie uma branch (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -m 'Add nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

## Licença

MIT License - Use livremente, mas sem garantias.

---

Feito com 💜 por **Willian (Walbarellos)**
