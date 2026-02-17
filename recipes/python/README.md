# Python DevContainer Recipe

## Overview
A ready-to-use development container for Python projects with linting, formatting, and testing tools.

## What's Included
- **Base Image**: Python 3.11
- **Tools**: Git, pip, black, flake8, pytest
- **VS Code Extensions**:
  - Python language support
  - Pylance for IntelliSense
  - Black formatter
  - Flake8 linter
  - isort for import sorting

## Default Ports
- `5000`: Flask/FastAPI development server
- `8000`: Django/alternative server

## Usage

### With CLI (Recommended)
```bash
dc use python ./my-project
```

### Manual Setup
1. Copy the `.devcontainer` folder to your project root
2. Open the project in VS Code
3. When prompted, click "Reopen in Container"

## Customization

### Python Version
Change the image tag in `.devcontainer/devcontainer.json`:
```json
"image": "mcr.microsoft.com/devcontainers/python:3.12"
```

### Adding Packages
Modify the `postCreateCommand`:
```json
"postCreateCommand": "pip install -r requirements.txt"
```

### Virtual Environment
For virtual environment support, add:
```json
"postCreateCommand": "python -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt"
```

## Validation
Run the validation script to ensure the container is working:
```bash
./validate.sh
```
