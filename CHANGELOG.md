# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-02-17

### Added
- Initial release of DevContainer Cookbook
- Node.js recipe with TypeScript, ESLint, and Prettier
- Python recipe with Black, Flake8, and pytest
- Go recipe with gopls and delve debugger
- Fullstack recipe with Node.js, PostgreSQL, and Redis
- Playwright recipe with all browsers pre-installed
- CLI tool (`dc`) for easy recipe management
- Validation scripts for all recipes
- GitHub Actions CI/CD pipeline
- Comprehensive documentation

### Features
- `dc use <recipe> <directory>` - Copy recipe to project
- `dc list` - List available recipes
- Automatic port conflict resolution
- VS Code extension recommendations per recipe
- Docker Compose support for fullstack recipe

[1.0.0]: https://github.com/fabio7maia/0-devcontainer-cookbook/releases/tag/v1.0.0
