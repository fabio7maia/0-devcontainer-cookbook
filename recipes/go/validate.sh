#!/bin/bash
set -e

echo "🔍 Validating Go DevContainer..."

# Check Go
echo -n "Checking Go... "
if command -v go &> /dev/null; then
    GO_VERSION=$(go version)
    echo "✓ $GO_VERSION"
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

# Check gopls
echo -n "Checking gopls... "
if command -v gopls &> /dev/null; then
    GOPLS_VERSION=$(gopls version | head -n1)
    echo "✓ $GOPLS_VERSION"
else
    echo "✗ Not found"
    exit 1
fi

# Check delve
echo -n "Checking delve... "
if command -v dlv &> /dev/null; then
    DLV_VERSION=$(dlv version | head -n1)
    echo "✓ $DLV_VERSION"
else
    echo "✗ Not found"
    exit 1
fi

# Test Go compilation
echo -n "Testing Go compilation... "
mkdir -p /tmp/go-test
cd /tmp/go-test
cat > main.go << 'EOF'
package main
import "fmt"
func main() {
    fmt.Println("Hello, World!")
}
EOF
go run main.go > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✓"
else
    echo "✗ Failed"
    exit 1
fi
cd - > /dev/null
rm -rf /tmp/go-test

echo ""
echo "✅ All validations passed!"
