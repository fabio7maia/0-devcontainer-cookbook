# Examples

This document provides real-world examples of using DevContainer Cookbook recipes.

## Node.js + Express API

```bash
# Create new project
mkdir my-express-api
cd my-express-api

# Initialize npm project
npm init -y

# Add devcontainer
dc use node .

# Install Express
npm install express

# Create simple server
cat > index.js << 'EOF'
const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.json({ message: 'Hello from DevContainer!' });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
EOF

# Open in VS Code and reopen in container
code .
```

## Python Flask Application

```bash
# Create project
mkdir my-flask-app
cd my-flask-app

# Add devcontainer
dc use python .

# Create requirements.txt
cat > requirements.txt << 'EOF'
flask==3.0.0
python-dotenv==1.0.0
EOF

# Create app
cat > app.py << 'EOF'
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def hello():
    return jsonify(message='Hello from Flask in DevContainer!')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
EOF

# Open in container
code .
# In container: pip install -r requirements.txt && python app.py
```

## Go REST API

```bash
# Create project
mkdir my-go-api
cd my-go-api

# Add devcontainer
dc use go .

# Initialize Go module
go mod init github.com/username/my-go-api

# Create main.go
cat > main.go << 'EOF'
package main

import (
    "encoding/json"
    "log"
    "net/http"
)

type Response struct {
    Message string `json:"message"`
}

func handler(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(Response{Message: "Hello from Go DevContainer!"})
}

func main() {
    http.HandleFunc("/", handler)
    log.Println("Server starting on :8080")
    log.Fatal(http.ListenAndServe(":8080", nil))
}
EOF

# Open in container and run
code .
# In container: go run main.go
```

## Fullstack App with Database

```bash
# Create project
mkdir my-fullstack-app
cd my-fullstack-app

# Add devcontainer
dc use fullstack .

# Create package.json
cat > package.json << 'EOF'
{
  "name": "my-fullstack-app",
  "version": "1.0.0",
  "dependencies": {
    "express": "^4.18.2",
    "pg": "^8.11.3",
    "redis": "^4.6.10"
  }
}
EOF

# Create app with database connection
cat > index.js << 'EOF'
const express = require('express');
const { Client } = require('pg');
const redis = require('redis');

const app = express();
const PORT = 3000;

// PostgreSQL client
const pgClient = new Client({
  connectionString: process.env.DATABASE_URL
});

// Redis client
const redisClient = redis.createClient({
  url: process.env.REDIS_URL
});

app.get('/health', async (req, res) => {
  try {
    // Test PostgreSQL
    await pgClient.query('SELECT NOW()');
    
    // Test Redis
    await redisClient.ping();
    
    res.json({ 
      status: 'healthy',
      database: 'connected',
      cache: 'connected'
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

async function start() {
  await pgClient.connect();
  await redisClient.connect();
  
  app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
  });
}

start();
EOF

# Open in container
code .
# In container: npm install && node index.js
```

## Playwright E2E Testing

```bash
# Create test project
mkdir my-e2e-tests
cd my-e2e-tests

# Add devcontainer
dc use playwright .

# Initialize Playwright
npx create-playwright

# Run tests
npx playwright test

# Run with UI
npx playwright test --ui

# Generate tests
npx playwright codegen https://example.com
```

## TypeScript + React

```bash
# Create React app with TypeScript
npx create-react-app my-react-app --template typescript
cd my-react-app

# Add devcontainer
dc use node .

# Open in container
code .
# In container: npm start
```

## Python Data Science

```bash
# Create project
mkdir my-data-project
cd my-data-project

# Add devcontainer
dc use python .

# Create requirements.txt
cat > requirements.txt << 'EOF'
pandas==2.1.0
numpy==1.24.0
matplotlib==3.7.0
jupyter==1.0.0
EOF

# Create analysis script
cat > analysis.py << 'EOF'
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Sample data analysis
data = pd.DataFrame({
    'x': np.random.randn(100),
    'y': np.random.randn(100)
})

print(data.describe())
EOF

# Open in container
code .
# In container: pip install -r requirements.txt && python analysis.py
```

## Tips

### Combining Recipes

You can start with one recipe and add tools from another:

```bash
# Start with Node.js
dc use node ./my-project

# Manually add Python to devcontainer.json
# Or copy specific tools from python recipe
```

### Custom Configuration

After copying a recipe, customize it:

1. Edit `.devcontainer/devcontainer.json`
2. Add your preferred extensions
3. Modify port forwarding
4. Add custom post-create commands

### Using with Existing Projects

```bash
# Add devcontainer to existing project
cd existing-project
dc use <recipe> .

# Commit the .devcontainer folder
git add .devcontainer DEVCONTAINER.md
git commit -m "Add devcontainer configuration"
```
