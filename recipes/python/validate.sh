#!/bin/bash
set -e

echo "🔍 Validating Python DevContainer..."

# Check Python
echo -n "Checking Python... "
if command -v python &> /dev/null; then
    PYTHON_VERSION=$(python --version)
    echo "✓ $PYTHON_VERSION"
else
    echo "✗ Not found"
    exit 1
fi

# Check pip
echo -n "Checking pip... "
if command -v pip &> /dev/null; then
    PIP_VERSION=$(pip --version | awk '{print $2}')
    echo "✓ v$PIP_VERSION"
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

# Check Black
echo -n "Checking Black formatter... "
if command -v black &> /dev/null; then
    BLACK_VERSION=$(black --version | head -n1)
    echo "✓ $BLACK_VERSION"
else
    echo "✗ Not found"
    exit 1
fi

# Check Flake8
echo -n "Checking Flake8... "
if command -v flake8 &> /dev/null; then
    FLAKE8_VERSION=$(flake8 --version | head -n1)
    echo "✓ $FLAKE8_VERSION"
else
    echo "✗ Not found"
    exit 1
fi

# Check pytest
echo -n "Checking pytest... "
if command -v pytest &> /dev/null; then
    PYTEST_VERSION=$(pytest --version | head -n1)
    echo "✓ $PYTEST_VERSION"
else
    echo "✗ Not found"
    exit 1
fi

# Test pip package installation
echo -n "Testing pip package installation... "
pip install requests > /dev/null 2>&1
if python -c "import requests" 2>/dev/null; then
    echo "✓"
else
    echo "✗ Failed"
    exit 1
fi

echo ""
echo "✅ All validations passed!"
