# OpenCode Memory Setup

Quick setup script to install OpenCode with my personalized memory system on any Linux machine.

## Features

- **OpenCode** - AI coding assistant (https://opencode.ai)
- **MemPalace** - AI memory management (https://github.com/milla-jovovich/mempalace)
- **Personalized Memories** - Pre-configured with my profile and interests
- **Memory Network Visualizer** - HTML page to visualize memories as an interactive graph

## Supported Distros

- Arch Linux
- Ubuntu / Debian

## Installation

```bash
# Clone the repository
git clone git@github.com:walbarellos/opencode-memory.git
cd opencode-memory

# Run the installer
chmod +x install.sh
./install.sh
```

The installer will:
1. Ask you to choose your distribution (Arch or Ubuntu)
2. Install all dependencies
3. Set up OpenCode
4. Configure MemPalace with your memories
5. Copy the memory network visualizer

## Quick Install (One-liner)

```bash
curl -fsSL https://raw.githubusercontent.com/walbarellos/opencode-memory/main/install.sh | bash
```

## Uninstallation

Simply delete the installation folder:

```bash
rm -rf ~/.opencode-memory/
rm -rf ~/.mempalace/
rm -rf ~/.hermes/
```

## Repository Structure

```
opencode-memory/
├── index.html          # Memory network visualizer
├── install.sh         # Installation script
├── memories/          # Personal memories backup
│   ├── user_info.md   # User profile
│   └── wakeup.txt     # Wake-up context
└── README.md
```

## User Profile

- **Name:** Willian (Walbarellos)
- **Age:** 30
- **Origin:** Brazil
- **Languages:** Portuguese (BR), English (US), Hebrew, Spanish
- **Interests:** Software Engineering, Anime/Manga, Video Games, Cryptocurrencies, Israel, Judaism, Hebrew
- **OS:** Arch Linux

## Tools Configured

- OpenCode v1.4.1+
- MemPalace (via Vigilia)
- Hermes Agent
- Vigilia Development Environment

## License

MIT License
