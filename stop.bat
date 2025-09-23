@echo off
echo Stopping Dormdeal Project containers...
echo.

REM Stop development containers
echo Stopping development containers...
docker-compose -f docker-compose.dev.yml down

REM Stop production containers
echo Stopping production containers...
docker-compose down

echo.
echo All containers stopped successfully!
echo.

pause