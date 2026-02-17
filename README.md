# DevContainer Cookbook 🐳

A curated collection of production-ready DevContainer recipes for various tech stacks. Get started with development containers in seconds, with pre-configured tools, extensions, and best practices.

[![Validate DevContainers](https://github.com/fabio7maia/0-devcontainer-cookbook/actions/workflows/validate.yml/badge.svg)](https://github.com/fabio7maia/0-devcontainer-cookbook/actions/workflows/validate.yml)

## 🚀 Quick Start

### Using the CLI (Recommended)

```bash
# Install globally
npm install -g devcontainer-cookbook

# Use a recipe
dc use node ./my-project
```

### Manual Installation

```bash
# Clone the repository
git clone https://github.com/fabio7maia/0-devcontainer-cookbook.git

# Use the CLI locally
cd 0-devcontainer-cookbook
node cli/dc.js use node /path/to/your/project
```

## 📦 Available Recipes

### Node.js
Modern Node.js development environment with TypeScript support, ESLint, and Prettier.
```bash
dc use node ./my-node-project
```
**Includes**: Node.js 20, npm, ESLint, Prettier, TypeScript

### Python
Python development environment with linting, formatting, and testing tools.
```bash
dc use python ./my-python-project
```
**Includes**: Python 3.11, pip, Black, Flake8, pytest

### Go
Go development environment with language server and debugging support.
```bash
dc use go ./my-go-project
```
**Includes**: Go 1.21, gopls, delve debugger

### Fullstack
Complete fullstack environment with Node.js, PostgreSQL, and Redis.
```bash
dc use fullstack ./my-fullstack-app
```
**Includes**: Node.js 20, PostgreSQL 15, Redis 7, pgAdmin extensions

### Playwright
End-to-end testing environment with Playwright and all browsers pre-installed.
```bash
dc use playwright ./my-test-project
```
**Includes**: Playwright, Chromium, Firefox, WebKit, Node.js 20

## 🛠️ CLI Usage

### Commands

```bash
# List all available recipes
dc list

# Use a recipe in a directory
dc use <recipe> <directory>

# Show help
dc help
```

### Examples

```bash
# Create a new Node.js project
mkdir my-app && dc use node my-app

# Add devcontainer to existing project
dc use python ./existing-project

# Set up fullstack environment
dc use fullstack ./my-fullstack-app
```

## 📖 How to Use

1. **Choose a recipe** that matches your tech stack
2. **Run the CLI** to copy the devcontainer to your project
3. **Open in VS Code** and reopen in container when prompted
4. **Start coding** with all tools pre-configured!

### First Time Setup

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop)
2. Install [VS Code](https://code.visualstudio.com/)
3. Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Opening in Container

1. Open your project in VS Code
2. Press `F1` and select **"Dev Containers: Reopen in Container"**
3. Wait for the container to build (first time only)
4. Start developing!

## 🔧 Customization

Each recipe can be customized to fit your needs:

### Changing Ports
Edit `forwardPorts` in `.devcontainer/devcontainer.json`:
```json
"forwardPorts": [3000, 8080]
```

### Adding Extensions
Add VS Code extension IDs to the `extensions` array:
```json
"extensions": [
  "dbaeumer.vscode-eslint",
  "your.extension.id"
]
```

### Modifying Post-Create Commands
Edit the `postCreateCommand` to run custom setup:
```json
"postCreateCommand": "npm install && npm run setup"
```

## ✅ Validation

Each recipe includes a validation script to ensure everything is working correctly:

```bash
# Inside the devcontainer
./.devcontainer/validate.sh
```

## 🏗️ Repository Structure

```
.
├── recipes/                 # DevContainer recipes
│   ├── node/               # Node.js recipe
│   │   ├── .devcontainer/
│   │   │   └── devcontainer.json
│   │   ├── README.md
│   │   └── validate.sh
│   ├── python/             # Python recipe
│   ├── go/                 # Go recipe
│   ├── fullstack/          # Fullstack recipe
│   └── playwright/         # Playwright recipe
├── cli/                    # CLI tool
│   └── dc.js
├── .github/
│   └── workflows/
│       └── validate.yml    # CI/CD validation
├── package.json
└── README.md
```

## 🔄 CI/CD

This repository uses GitHub Actions to:
- ✅ Build and validate each devcontainer recipe
- ✅ Run smoke tests in containers
- ✅ Validate JSON configuration files
- ✅ Test CLI functionality

The CI pipeline ensures all recipes are working and up-to-date.

## 🤝 Contributing

Contributions are welcome! To add a new recipe:

1. Create a new folder in `recipes/`
2. Add `.devcontainer/devcontainer.json`
3. Add `README.md` with documentation
4. Add `validate.sh` for smoke testing
5. Update the CLI to include the new recipe
6. Submit a pull request

## 📝 License

MIT

## 🙏 Acknowledgments

Built with [DevContainers](https://containers.dev/) and inspired by the developer community.

---

**Happy Coding!** 🚀