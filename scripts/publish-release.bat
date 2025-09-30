@echo off
setlocal enabledelayedexpansion

if "%1"=="" (
    echo Usage: %0 ^<version^> (e.g., %0 1.0.0)
    exit /b 1
)

set VERSION=%1

echo Preparing to release version %VERSION%

echo Updating backend version...
cd backend
npm version %VERSION% --no-git-tag-version
cd ..

echo Updating frontend version...
cd frontend
npm version %VERSION% --no-git-tag-version
cd ..

echo Creating git tag...
git add .
git commit -m "Release version %VERSION%"
git tag -a "v%VERSION%" -m "Release version %VERSION%"

echo Pushing to GitHub...
git push origin main
git push origin "v%VERSION%"

echo Release %VERSION% has been published!
echo Docker images will be automatically built and pushed to DockerHub.
echo GitHub release will be created automatically.