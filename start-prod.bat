@echo off
echo Starting Dormdeal Project in Production Mode...
echo.

REM Check if Docker is running
docker info >nul 2>&1
if errorlevel 1 (
    echo ERROR: Docker is not running. Please start Docker Desktop first.
    pause
    exit /b 1
)

echo Building and starting production containers...
docker-compose -f docker-compose.prod.yml up --build -d

echo.
echo Services started successfully!
echo Frontend: http://localhost:5173
echo Backend API: http://localhost:5001
echo MongoDB: localhost:27017
echo.
echo To view logs: docker-compose logs -f
echo To stop services: docker-compose down
echo.

pause