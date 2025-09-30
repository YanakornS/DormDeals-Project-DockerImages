# DockerHub Integration

This document explains how to set up DockerHub integration for automatic image building and publishing.

## Prerequisites

1. DockerHub account
2. GitHub repository with the code
3. GitHub personal access token with appropriate permissions

## Setting up DockerHub

1. Create a DockerHub account at https://hub.docker.com/
2. Create two repositories:
   - `dormdeals-project-backend`
   - `dormdeals-project-frontend`

## Setting up GitHub Secrets

To enable automatic publishing to DockerHub, you need to set up secrets in your GitHub repository:

1. Go to your GitHub repository
2. Click on "Settings" tab
3. Click on "Secrets and variables" in the left sidebar
4. Click on "Actions" tab
5. Add the following secrets:
   - `DOCKERHUB_USERNAME`: Your DockerHub username
   - `DOCKERHUB_TOKEN`: Your DockerHub access token

To generate a DockerHub access token:
1. Log in to DockerHub
2. Go to Account Settings
3. Click on "Security" tab
4. Click "New Access Token"
5. Give it a name (e.g., "GitHub Actions")
6. Copy the generated token and add it as `DOCKERHUB_TOKEN` in GitHub secrets

## How it works

The GitHub Actions workflow in [.github/workflows/docker-publish.yml](.github/workflows/docker-publish.yml) will:

1. Build Docker images for both backend and frontend when:
   - Code is pushed to the main branch
   - A tag starting with 'v' is pushed
   - A pull request is created against the main branch

2. Push images to DockerHub when:
   - Code is pushed to the main branch
   - A tag is pushed
   - (Pull requests will only build but not push)

3. Tag images appropriately:
   - For main branch: `latest` tag
   - For tags: version tag (e.g., `v1.0.0` becomes `1.0.0`)
   - For pull requests: PR-specific tags

## Using the published images

Once the workflow runs successfully, you can use the published images:

```bash
# Pull the images
docker pull your-dockerhub-username/dormdeals-project-backend:latest
docker pull your-dockerhub-username/dormdeals-project-frontend:latest

# Or use a specific version
docker pull your-dockerhub-username/dormdeals-project-backend:1.0.0
docker pull your-dockerhub-username/dormdeals-project-frontend:1.0.0
```

## Using with docker-compose.prod.yml

You can use the [docker-compose.prod.yml](docker-compose.prod.yml) file which is configured to use the published images:

1. Create a `.env` file at the root of the project:
   ```
   DOCKERHUB_USERNAME=your-dockerhub-username
   ```

2. Run with Docker Compose:
   ```bash
   docker-compose -f docker-compose.prod.yml up -d
   ```

## Publishing a new release

To publish a new release:

1. Update the version in package.json files
2. Update CHANGELOG.md
3. Run the publish script:
   ```bash
   # On Linux/Mac
   ./scripts/publish-release.sh 1.0.0
   
   # On Windows
   .\scripts\publish-release.bat 1.0.0
   ```

This will:
- Create a git tag
- Push the tag to GitHub
- Trigger the GitHub Actions workflows
- Build and publish Docker images
- Create a GitHub release