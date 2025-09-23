@echo off
echo Starting Dormdeal Project in Development Mode...
echo.

REM Check if Docker is running
docker info >nul 2>&1
if errorlevel 1 (
    echo ERROR: Docker is not running. Please start Docker Desktop first.
    pause
    exit /b 1
)

echo Building and starting development containers...
docker-compose -f docker-compose.dev.yml up --build

pause