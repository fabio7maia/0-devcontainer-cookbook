# Fullstack DevContainer Recipe

## Overview
A complete development environment for fullstack applications with Node.js, PostgreSQL, and Redis.

## What's Included
- **App Container**: Node.js 20 with development tools
- **Database**: PostgreSQL 15
- **Cache**: Redis 7
- **VS Code Extensions**:
  - ESLint & Prettier
  - TypeScript support
  - PostgreSQL client
  - SQL Tools

## Default Configuration
- **Node.js Server**: Port 3000
- **PostgreSQL**: Port 5432
  - User: `postgres`
  - Password: `postgres`
  - Database: `devdb`
- **Redis**: Port 6379

## Environment Variables
The following environment variables are automatically set:
- `DATABASE_URL`: `postgresql://postgres:postgres@localhost:5432/devdb`
- `REDIS_URL`: `redis://localhost:6379`

## Usage

### With CLI (Recommended)
```bash
dc use fullstack ./my-project
```

### Manual Setup
1. Copy the `.devcontainer` folder to your project root
2. Open the project in VS Code
3. When prompted, click "Reopen in Container"

## Working with Database

### Connect to PostgreSQL
```bash
psql $DATABASE_URL
```

### Run Migrations
```bash
npm run migrate  # or your migration command
```

### Access pgAdmin (Optional)
Add pgAdmin service to `docker-compose.yml` if needed.

## Working with Redis

### Connect to Redis CLI
```bash
redis-cli
```

### Test Redis Connection
```javascript
const redis = require('redis');
const client = redis.createClient({ url: process.env.REDIS_URL });
await client.connect();
```

## Customization

### Change Database Credentials
Edit the `db` service in `docker-compose.yml`:
```yaml
environment:
  POSTGRES_USER: myuser
  POSTGRES_PASSWORD: mypassword
  POSTGRES_DB: mydb
```

### Add More Services
Add new services to `docker-compose.yml`:
```yaml
services:
  mongodb:
    image: mongo:6
    ports:
      - "27017:27017"
```

### Persist Data
Data is automatically persisted in Docker volumes:
- `postgres-data`: PostgreSQL data
- `redis-data`: Redis data

## Validation
Run the validation script to ensure all services are working:
```bash
./validate.sh
```
