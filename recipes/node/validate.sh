#!/bin/bash
set -e

echo "🔍 Validating Node.js DevContainer..."

# Check Node.js
echo -n "Checking Node.js... "
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    echo "✓ $NODE_VERSION"
else
    echo "✗ Not found"
    exit 1
fi

# Check npm
echo -n "Checking npm... "
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm --version)
    echo "✓ v$NPM_VERSION"
else
    echo "✗ Not found"
    exit 1
fi

# Check Git
echo -n "Checking Git... "
if command -v git &> /dev/null; then
    GIT_VERSION=$(git --version)
    echo "✓ $GIT_VERSION"
else
    echo "✗ Not found"
    exit 1
fi

# Test npm package installation
echo -n "Testing npm package installation... "
mkdir -p /tmp/npm-test
cd /tmp/npm-test
npm init -y > /dev/null 2>&1
npm install lodash > /dev/null 2>&1
if [ -d "node_modules/lodash" ]; then
    echo "✓"
else
    echo "✗ Failed"
    exit 1
fi
cd - > /dev/null
rm -rf /tmp/npm-test

echo ""
echo "✅ All validations passed!"
