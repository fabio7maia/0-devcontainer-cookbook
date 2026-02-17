#!/bin/bash
set -e

echo "🔍 Validating Fullstack DevContainer..."

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

# Check PostgreSQL connection
echo -n "Checking PostgreSQL connection... "
if command -v psql &> /dev/null; then
    # Wait for PostgreSQL to be ready
    for i in {1..30}; do
        if psql -h localhost -U postgres -d devdb -c "SELECT 1" > /dev/null 2>&1; then
            echo "✓ Connected"
            break
        fi
        if [ $i -eq 30 ]; then
            echo "✗ Connection timeout"
            exit 1
        fi
        sleep 1
    done
else
    echo "⚠ psql client not found, skipping PostgreSQL check"
fi

# Check Redis connection
echo -n "Checking Redis connection... "
if command -v redis-cli &> /dev/null; then
    # Wait for Redis to be ready
    for i in {1..30}; do
        if redis-cli -h localhost ping > /dev/null 2>&1; then
            echo "✓ Connected"
            break
        fi
        if [ $i -eq 30 ]; then
            echo "✗ Connection timeout"
            exit 1
        fi
        sleep 1
    done
else
    echo "⚠ redis-cli not found, skipping Redis check"
fi

# Check environment variables
echo -n "Checking environment variables... "
if [ -n "$DATABASE_URL" ] && [ -n "$REDIS_URL" ]; then
    echo "✓ Set"
else
    echo "✗ Missing"
    exit 1
fi

echo ""
echo "✅ All validations passed!"
echo ""
echo "📊 Service URLs:"
echo "  - PostgreSQL: $DATABASE_URL"
echo "  - Redis: $REDIS_URL"
