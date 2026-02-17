# Playwright DevContainer Recipe

## Overview
A ready-to-use development container for end-to-end testing with Playwright, including all browsers pre-installed.

## What's Included
- **Base Image**: Playwright official image with all browsers (Chromium, Firefox, WebKit)
- **Node.js**: Version 20
- **Tools**: Git, npm, Playwright browsers
- **VS Code Extensions**:
  - Playwright Test for VS Code
  - ESLint
  - Prettier

## Default Ports
- `3000`: Development server for app under test
- `9323`: Playwright Inspector

## Usage

### With CLI (Recommended)
```bash
dc use playwright ./my-test-project
```

### Manual Setup
1. Copy the `.devcontainer` folder to your project root
2. Open the project in VS Code
3. When prompted, click "Reopen in Container"

## Getting Started

### Initialize Playwright
```bash
npm init playwright@latest
```

### Run Tests
```bash
# Run all tests
npx playwright test

# Run tests in headed mode
npx playwright test --headed

# Run specific test file
npx playwright test tests/example.spec.ts

# Run tests in debug mode
npx playwright test --debug
```

### View Test Report
```bash
npx playwright show-report
```

## Customization

### Browser Configuration
Edit `playwright.config.ts` to configure browsers:
```typescript
export default {
  projects: [
    { name: 'chromium', use: { ...devices['Desktop Chrome'] } },
    { name: 'firefox', use: { ...devices['Desktop Firefox'] } },
    { name: 'webkit', use: { ...devices['Desktop Safari'] } },
  ],
}
```

### Parallel Execution
Configure workers in `playwright.config.ts`:
```typescript
export default {
  workers: process.env.CI ? 1 : 4,
}
```

### Screenshots and Videos
```typescript
export default {
  use: {
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',
  },
}
```

## Features

### Visual Testing
Playwright supports visual regression testing with screenshots:
```javascript
await expect(page).toHaveScreenshot();
```

### API Testing
Test APIs directly:
```javascript
const response = await request.get('/api/users');
expect(response.status()).toBe(200);
```

### Debugging
- Use Playwright Inspector: `npx playwright test --debug`
- Use VS Code extension for interactive debugging
- View trace files: `npx playwright show-trace trace.zip`

## Validation
Run the validation script to ensure the container is working:
```bash
./validate.sh
```
