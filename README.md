# GenoGrove Conda Recipe

This repository contains the conda recipe for building and distributing [GenoGrove](https://github.com/genogrove/genogrove) via Bioconda.

## Building Locally

To build the conda package locally:

```bash
conda install conda-build
conda build recipe/
```

## GitHub Actions Workflow

The repository includes a GitHub Actions workflow that:
- **On push/PR**: Tests the conda build on Linux, macOS, and Windows
- **On release**: Builds and optionally uploads to Anaconda.org

### Setting up Anaconda.org Upload

To enable automatic uploads to Anaconda.org on releases:

1. Create an account on [Anaconda.org](https://anaconda.org)
2. Generate an API token:
   ```bash
   anaconda auth --create --name github-actions --scopes "api:write api:read"
   ```
3. Add the token as a GitHub secret:
   - Go to your repository's Settings → Secrets and variables → Actions
   - Add a new secret named `ANACONDA_TOKEN` with the token value

## Submitting to Bioconda

To submit this package to Bioconda:

1. **Fork the bioconda-recipes repository**:
   ```bash
   git clone https://github.com/bioconda/bioconda-recipes.git
   cd bioconda-recipes
   ```

2. **Create a new branch**:
   ```bash
   git checkout -b genogrove
   ```

3. **Copy the recipe**:
   ```bash
   mkdir -p recipes/genogrove
   cp path/to/this/repo/recipe/* recipes/genogrove/
   ```

4. **Update the recipe-maintainers** in `meta.yml`:
   ```yaml
   extra:
     recipe-maintainers:
       - your-github-username
   ```

5. **Test the recipe**:
   ```bash
   # Install bioconda-utils
   conda install -c conda-forge bioconda-utils

   # Run linting
   bioconda-utils lint --git-range master recipes/genogrove

   # Build and test
   bioconda-utils build --docker --mulled-test recipes/genogrove
   ```

6. **Commit and push**:
   ```bash
   git add recipes/genogrove
   git commit -m "Add genogrove recipe"
   git push origin genogrove
   ```

7. **Create a Pull Request** to [bioconda-recipes](https://github.com/bioconda/bioconda-recipes)

## Bioconda Requirements

This recipe follows Bioconda guidelines:
- ✅ Uses release tarball with SHA256 hash
- ✅ GPL-3.0-or-later license
- ✅ Includes test commands
- ✅ C++ compiler requirements specified
- ✅ Cross-platform build scripts (Unix & Windows)

## Package Information

- **Name**: genogrove
- **Version**: 0.3.0
- **License**: GPL-3.0-or-later
- **Home**: https://github.com/genogrove/genogrove
- **Documentation**: https://www.genogrove.com

## Updating the Recipe

When a new version is released:

1. Download the new release tarball and calculate SHA256:
   ```bash
   curl -L https://github.com/genogrove/genogrove/archive/refs/tags/vX.Y.Z.tar.gz -o genogrove.tar.gz
   sha256sum genogrove.tar.gz
   ```

2. Update `meta.yml`:
   - Change `{% set version = "X.Y.Z" %}`
   - Update the `sha256` hash
   - Increment the `build: number` (or reset to 0 for new versions)

3. Test the build locally before pushing