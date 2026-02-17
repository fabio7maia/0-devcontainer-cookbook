# Go DevContainer Recipe

## Overview
A ready-to-use development container for Go projects with language server and debugging support.

## What's Included
- **Base Image**: Go 1.21
- **Tools**: Git, gopls (language server), delve (debugger)
- **VS Code Extensions**:
  - Go extension with IntelliSense
  - Makefile tools

## Default Ports
- `8080`: HTTP server
- `9090`: Metrics/monitoring server

## Usage

### With CLI (Recommended)
```bash
dc use go ./my-project
```

### Manual Setup
1. Copy the `.devcontainer` folder to your project root
2. Open the project in VS Code
3. When prompted, click "Reopen in Container"

## Customization

### Go Version
Change the image tag in `.devcontainer/devcontainer.json`:
```json
"image": "mcr.microsoft.com/devcontainers/go:1.22"
```

### Additional Tools
Modify the `postCreateCommand` to install more tools:
```json
"postCreateCommand": "go install golang.org/x/tools/gopls@latest && go install your/tool@latest"
```

### Module Setup
Add module initialization:
```json
"postCreateCommand": "go mod download"
```

## Debugging
The delve debugger is pre-installed. Use VS Code's debug panel to set breakpoints and debug your Go applications.

## Validation
Run the validation script to ensure the container is working:
```bash
./validate.sh
```
