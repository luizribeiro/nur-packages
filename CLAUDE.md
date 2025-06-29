# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a NUR (Nix User Repository) package collection that provides Nix packages not yet available in nixpkgs. It uses modern Nix flakes and integrates with uptix for automated version tracking.

## Architecture

The repository follows the standard NUR structure:
- `pkgs/`: Individual package definitions, each in its own directory with a `default.nix`
- `ci.nix`: Filters packages for CI builds based on platform compatibility
- `uptix.nix`: Configuration for automatic upstream version tracking
- Package sources are tracked in `uptix.lock` for GitHub-based packages

## Common Commands

### Building Packages
```bash
# Build a specific package
nix build .#packageName

# Build all packages (filtered by CI)
nix build -f ci.nix cacheOutputs

# Enter development shell with uptix
nix develop
```

### Package Management with uptix
```bash
# Update all tracked packages
uptix update-all

# Update specific package
uptix update packageName

# Add new GitHub-tracked package
uptix track owner/repo
```

### Testing Changes
```bash
# Evaluate all packages (check for syntax errors)
nix flake check

# Build specific package for testing
nix build .#packageName --print-build-logs
```

## Key Development Patterns

1. **Adding New Packages**: Create a directory under `pkgs/` with a `default.nix` file. Follow the existing package structure.

2. **Platform Support**: Packages should specify their supported platforms in `meta.platforms`. The CI automatically filters based on this.

3. **Version Tracking**: For GitHub releases, add the package to `uptix.nix` to enable automatic version updates.

4. **Binary Caching**: Packages built by CI are cached to Cachix under the "luizribeiro" cache name.

## Important Notes

- The repository supports x86_64 and aarch64 for both Linux and Darwin (macOS)
- CI runs on push to main/master and daily at 3:10 AM
- The `broken` attribute in package metadata prevents CI from attempting to build
- Some packages like `bambu-studio` are filtered from CI builds via `dontRecurseIntoAttrs`