#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const RECIPES_DIR = path.join(__dirname, '..', 'recipes');
const AVAILABLE_RECIPES = ['node', 'python', 'go', 'fullstack', 'playwright'];

function showHelp() {
  console.log(`
DevContainer Cookbook CLI

Usage:
  dc use <recipe> <directory>     Copy a devcontainer recipe to a directory
  dc list                         List available recipes
  dc help                         Show this help message

Available Recipes:
  - node       : Node.js development environment
  - python     : Python development environment
  - go         : Go development environment
  - fullstack  : Fullstack with Node.js, PostgreSQL, and Redis
  - playwright : Playwright testing environment

Examples:
  dc use node ./my-project
  dc use fullstack ./my-app
  dc list
`);
}

function listRecipes() {
  console.log('\n📦 Available DevContainer Recipes:\n');
  AVAILABLE_RECIPES.forEach(recipe => {
    const recipePath = path.join(RECIPES_DIR, recipe);
    const readmePath = path.join(recipePath, 'README.md');
    
    if (fs.existsSync(readmePath)) {
      const readme = fs.readFileSync(readmePath, 'utf8');
      const firstLine = readme.split('\n').find(line => line.startsWith('## Overview'));
      const description = readme.split('\n')[readme.split('\n').indexOf(firstLine) + 1] || '';
      console.log(`  ${recipe.padEnd(15)} - ${description.trim()}`);
    } else {
      console.log(`  ${recipe.padEnd(15)} - DevContainer recipe`);
    }
  });
  console.log('');
}

function findNextAvailablePort(startPort, usedPorts) {
  let port = startPort;
  while (usedPorts.has(port)) {
    port++;
  }
  return port;
}

function adjustPorts(configContent, usedPorts = new Set()) {
  const config = JSON.parse(configContent);
  
  if (config.forwardPorts && Array.isArray(config.forwardPorts)) {
    const newPorts = config.forwardPorts.map(port => {
      if (usedPorts.has(port)) {
        const newPort = findNextAvailablePort(port, usedPorts);
        console.log(`  ℹ️  Port ${port} is in use, using ${newPort} instead`);
        usedPorts.add(newPort);
        return newPort;
      }
      usedPorts.add(port);
      return port;
    });
    config.forwardPorts = newPorts;
  }
  
  return JSON.stringify(config, null, 2);
}

function copyRecipe(recipe, targetDir) {
  if (!AVAILABLE_RECIPES.includes(recipe)) {
    console.error(`\n❌ Error: Recipe '${recipe}' not found.`);
    console.error(`\nAvailable recipes: ${AVAILABLE_RECIPES.join(', ')}\n`);
    process.exit(1);
  }

  const recipePath = path.join(RECIPES_DIR, recipe);
  if (!fs.existsSync(recipePath)) {
    console.error(`\n❌ Error: Recipe directory not found: ${recipePath}\n`);
    process.exit(1);
  }

  // Create target directory if it doesn't exist
  if (!fs.existsSync(targetDir)) {
    fs.mkdirSync(targetDir, { recursive: true });
  }

  const targetDevcontainerDir = path.join(targetDir, '.devcontainer');
  const sourceDevcontainerDir = path.join(recipePath, '.devcontainer');

  // Check if .devcontainer already exists
  if (fs.existsSync(targetDevcontainerDir)) {
    console.error(`\n❌ Error: .devcontainer already exists in ${targetDir}`);
    console.error(`Please remove it first or choose a different directory.\n`);
    process.exit(1);
  }

  console.log(`\n🚀 Setting up ${recipe} devcontainer in ${targetDir}...\n`);

  // Copy .devcontainer directory
  copyDirectory(sourceDevcontainerDir, targetDevcontainerDir);

  // Adjust ports in devcontainer.json
  const devcontainerJsonPath = path.join(targetDevcontainerDir, 'devcontainer.json');
  if (fs.existsSync(devcontainerJsonPath)) {
    const originalContent = fs.readFileSync(devcontainerJsonPath, 'utf8');
    const adjustedContent = adjustPorts(originalContent);
    fs.writeFileSync(devcontainerJsonPath, adjustedContent);
  }

  // Copy README if it exists
  const sourceReadme = path.join(recipePath, 'README.md');
  const targetReadme = path.join(targetDir, 'DEVCONTAINER.md');
  if (fs.existsSync(sourceReadme)) {
    fs.copyFileSync(sourceReadme, targetReadme);
    console.log(`  ✓ Copied documentation to DEVCONTAINER.md`);
  }

  // Copy validation script if it exists
  const sourceValidate = path.join(recipePath, 'validate.sh');
  const targetValidate = path.join(targetDir, '.devcontainer', 'validate.sh');
  if (fs.existsSync(sourceValidate)) {
    fs.copyFileSync(sourceValidate, targetValidate);
    fs.chmodSync(targetValidate, '755');
    console.log(`  ✓ Copied validation script`);
  }

  console.log(`  ✓ Copied devcontainer configuration`);
  console.log(`\n✅ Done! DevContainer is ready.`);
  console.log(`\nNext steps:`);
  console.log(`  1. Open ${targetDir} in VS Code`);
  console.log(`  2. Press F1 and select "Dev Containers: Reopen in Container"`);
  console.log(`  3. Wait for the container to build`);
  console.log(`\nFor more information, see DEVCONTAINER.md\n`);
}

function copyDirectory(source, target) {
  if (!fs.existsSync(target)) {
    fs.mkdirSync(target, { recursive: true });
  }

  const files = fs.readdirSync(source);
  files.forEach(file => {
    const sourcePath = path.join(source, file);
    const targetPath = path.join(target, file);
    const stat = fs.statSync(sourcePath);

    if (stat.isDirectory()) {
      copyDirectory(sourcePath, targetPath);
    } else {
      fs.copyFileSync(sourcePath, targetPath);
    }
  });
}

// Main CLI logic
const args = process.argv.slice(2);
const command = args[0];

if (!command || command === 'help' || command === '--help' || command === '-h') {
  showHelp();
  process.exit(0);
}

if (command === 'list') {
  listRecipes();
  process.exit(0);
}

if (command === 'use') {
  const recipe = args[1];
  const targetDir = args[2];

  if (!recipe || !targetDir) {
    console.error('\n❌ Error: Missing arguments\n');
    console.error('Usage: dc use <recipe> <directory>\n');
    process.exit(1);
  }

  const resolvedTarget = path.resolve(targetDir);
  copyRecipe(recipe, resolvedTarget);
  process.exit(0);
}

console.error(`\n❌ Error: Unknown command '${command}'\n`);
showHelp();
process.exit(1);
