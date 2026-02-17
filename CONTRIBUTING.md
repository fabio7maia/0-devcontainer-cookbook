# Contributing to DevContainer Cookbook

Thank you for your interest in contributing! This guide will help you add new recipes or improve existing ones.

## How to Contribute

### Adding a New Recipe

1. **Create Recipe Directory**
   ```bash
   mkdir -p recipes/<recipe-name>/.devcontainer
   ```

2. **Create devcontainer.json**
   - Use existing recipes as templates
   - Include appropriate base image
   - Add relevant VS Code extensions
   - Configure port forwarding
   - Add post-create commands if needed

3. **Write Documentation (README.md)**
   - Overview of the recipe
   - What's included
   - Default configuration
   - Usage instructions
   - Customization examples

4. **Create Validation Script (validate.sh)**
   - Check all required tools are installed
   - Test basic functionality
   - Make it executable: `chmod +x validate.sh`

5. **Update CLI**
   - Add recipe name to `AVAILABLE_RECIPES` in `cli/dc.js`

6. **Test Your Recipe**
   - Build the devcontainer locally
   - Run validation script
   - Test with real projects

### Improving Existing Recipes

- Update dependencies to latest versions
- Add missing VS Code extensions
- Improve documentation
- Enhance validation scripts
- Fix bugs

### Guidelines

- **Follow existing patterns**: Keep consistency with other recipes
- **Test thoroughly**: Ensure everything works before submitting
- **Document clearly**: Help others understand your changes
- **Keep it minimal**: Only include essential tools and extensions
- **Support customization**: Make recipes easy to customize

## Pull Request Process

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-recipe`)
3. Make your changes
4. Test locally
5. Commit with clear messages
6. Push to your fork
7. Open a Pull Request

## Code of Conduct

- Be respectful and constructive
- Help others learn and grow
- Focus on what is best for the community
- Show empathy towards other community members

## Questions?

Open an issue or discussion on GitHub!
