# Node.js DevContainer Recipe

## Overview
A ready-to-use development container for Node.js projects with essential tools and extensions.

## What's Included
- **Base Image**: Node.js 20 (LTS)
- **Tools**: Git, npm
- **VS Code Extensions**:
  - ESLint for code linting
  - Prettier for code formatting
  - TypeScript support
  - NPM IntelliSense

## Default Ports
- `3000`: Development server (React, Express, etc.)
- `8080`: Alternative web server

## Usage

### With CLI (Recommended)
```bash
dc use node ./my-project
```

### Manual Setup
1. Copy the `.devcontainer` folder to your project root
2. Open the project in VS Code
3. When prompted, click "Reopen in Container"

## Customization

### Changing Ports
Edit the `forwardPorts` array in `.devcontainer/devcontainer.json`:
```json
"forwardPorts": [3000, 8080]
```

### Adding Extensions
Add extension IDs to the `extensions` array:
```json
"extensions": [
  "dbaeumer.vscode-eslint",
  "your.extension.id"
]
```

### Custom Scripts
Add a `postCreateCommand` to run setup scripts:
```json
"postCreateCommand": "npm install && npm run setup"
```

## Validation
Run the validation script to ensure the container is working:
```bash
./validate.sh
```
