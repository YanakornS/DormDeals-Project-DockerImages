#!/bin/bash

# Script to help with releasing new versions

set -e  # Exit on any error

if [ $# -eq 0 ]; then
    echo "Usage: $0 <version> (e.g., $0 1.0.0)"
    exit 1
fi

VERSION=$1

echo "Preparing to release version $VERSION"

# Update version in backend package.json
echo "Updating backend version..."
cd backend
npm version $VERSION --no-git-tag-version
cd ..

# Update version in frontend package.json
echo "Updating frontend version..."
cd frontend
npm version $VERSION --no-git-tag-version
cd ..

# Update version in README.md
echo "Updating README.md..."
sed -i "s/เวอร์ชัน: [0-9]*\.[0-9]*\.[0-9]*/เวอร์ชัน: $VERSION/" README.md

# Update version in CHANGELOG.md
echo "Updating CHANGELOG.md..."
sed -i "s/## \[Unreleased\]/## \[Unreleased\]\n\n## [$VERSION] - $(date +'%Y-%m-%d')/" CHANGELOG.md

echo "Creating git tag..."
git add .
git commit -m "Release version $VERSION"
git tag -a "v$VERSION" -m "Release version $VERSION"

echo "Pushing to GitHub..."
git push origin main
git push origin "v$VERSION"

echo "Release $VERSION has been published!"
echo "Docker images will be automatically built and pushed to DockerHub."
echo "GitHub release will be created automatically."