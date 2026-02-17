#!/bin/bash
set -e

echo "🔍 Validating Playwright DevContainer..."

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

# Check Playwright
echo -n "Checking Playwright... "
if command -v playwright &> /dev/null; then
    PLAYWRIGHT_VERSION=$(playwright --version)
    echo "✓ $PLAYWRIGHT_VERSION"
else
    echo "✗ Not found"
    exit 1
fi

# Check browsers
echo "Checking browsers..."
for browser in chromium firefox webkit; do
    echo -n "  - $browser: "
    if playwright install --dry-run $browser 2>&1 | grep -q "is already installed"; then
        echo "✓ Installed"
    else
        echo "✗ Not installed"
        exit 1
    fi
done

# Test Playwright execution
echo -n "Testing Playwright execution... "
mkdir -p /tmp/playwright-test
cd /tmp/playwright-test
cat > test.spec.js << 'EOF'
const { test, expect } = require('@playwright/test');
test('basic test', async ({ page }) => {
  await page.goto('https://playwright.dev/');
  await expect(page).toHaveTitle(/Playwright/);
});
EOF

# Create a simple config
cat > playwright.config.js << 'EOF'
module.exports = {
  testDir: '.',
  timeout: 30000,
  use: {
    headless: true,
  },
};
EOF

if npx playwright test > /dev/null 2>&1; then
    echo "✓"
else
    echo "✗ Failed"
    exit 1
fi
cd - > /dev/null
rm -rf /tmp/playwright-test

echo ""
echo "✅ All validations passed!"
