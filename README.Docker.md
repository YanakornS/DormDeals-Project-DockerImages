# Using Pre-built Docker Images

This guide explains how to use the pre-built Docker images from DockerHub instead of building them locally.

## Prerequisites

- Docker Desktop installed
- Internet connection to pull images from DockerHub

## Using Docker Compose with Pre-built Images

The easiest way to use the pre-built images is with our production docker-compose file:

1. Make sure you have the following files from the repository:
   - `docker-compose.prod.yml`
   - Environment file (`.env`)

2. Create a `.env` file at the root of the project:
   ```
   DOCKERHUB_USERNAME=your-dockerhub-username
   ```

3. Run the application:
   ```bash
   docker-compose -f docker-compose.prod.yml up -d
   ```

## Manual Configuration

If you prefer to manually configure the docker-compose file:

1. Edit the `docker-compose.yml` file to use pre-built images:

```yaml
version: '3.8'

services:
  # MongoDB Database
  mongodb:
    image: mongo:7.0
    # ... existing configuration

  # Backend API - Use pre-built image
  backend:
    image: your-dockerhub-username/dormdeals-project-backend:latest
    # Remove the build section and replace with image
    container_name: dormdeal-backend
    restart: unless-stopped
    ports:
      - "5001:5000"
    environment:
      NODE_ENV: production
      PORT: 5000
      DB_URL: mongodb://admin:password123@mongodb:27017/dormdeal?authSource=admin
      BASE_URL: http://localhost:80
    depends_on:
      - mongodb
    networks:
      - dormdeal-network

  # Frontend React App - Use pre-built image
  frontend:
    image: your-dockerhub-username/dormdeals-project-frontend:latest
    # Remove the build section and replace with image
    container_name: dormdeal-frontend
    restart: unless-stopped
    ports:
      - "80:80"
    environment:
      - NODE_ENV=production
    depends_on:
      - backend
    networks:
      - dormdeal-network

  # Redis for session management (optional)
  redis:
    image: redis:7-alpine
    # ... existing configuration

# ... existing volumes and networks
```

3. Create your environment files:

**backend/.env**:
```env
# การกำหนดค่าเซิร์ฟเวอร์
NODE_ENV=production
PORT=5000
BASE_URL=http://localhost:80

# ฐานข้อมูล
DB_URL=mongodb://admin:password123@mongodb:27017/dormdeal?authSource=admin

# JWT
JWT_SECRET=your_jwt_secret_here

# Firebase Admin (ต้องกำหนดค่าตามข้อมูลจริง)
FIREBASE_TYPE=service_account
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_PRIVATE_KEY_ID=your_private_key_id
FIREBASE_PRIVATE_KEY=your_private_key
FIREBASE_CLIENT_EMAIL=your_client_email

# Cloudinary
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret

# ระบบชำระเงิน
REQUIREDAMOUNT_PROMPTPAY_QR=จำนวนเงิน
EXPECTEDNAMEENG_PROMPTPAY_QR=ชื่อผู้รับเงิน
EASYSLIP_API_KEY=your_easyslip_key
```

**frontend/.env**:
```env
# การกำหนดค่า API
VITE_BASE_URL=http://localhost:5001/api/v1
VITE_SOCKET_URL=http://localhost:5001

# Firebase Client (ต้องกำหนดค่าตามข้อมูลจริง)
VITE_APIKEY=your_api_key
VITE_AUTHDOMAIN=your_auth_domain
VITE_PROJECTID=your_project_id
VITE_STORAGEBUCKET=your_storage_bucket
VITE_MESSAGINGSENDERID=your_messaging_sender_id
VITE_APPID=your_app_id
VITE_MEASUREMENTID=your_measurement_id
```

4. Run the application:

```bash
docker-compose up -d
```

## Updating to New Versions

To update to a new version of the application:

1. Update the image tags in `docker-compose.yml`:

```yaml
backend:
  image: your-dockerhub-username/dormdeals-project-backend:1.2.0  # Change to new version

frontend:
  image: your-dockerhub-username/dormdeals-project-frontend:1.2.0  # Change to new version
```

2. Pull the new images:

```bash
docker-compose pull
```

3. Restart the services:

```bash
docker-compose up -d
```

## Using Specific Versions

You can use specific versions of the images by specifying tags:

- `your-dockerhub-username/dormdeals-project-backend:latest` - Latest stable version
- `your-dockerhub-username/dormdeals-project-backend:1.0.0` - Specific version
- `your-dockerhub-username/dormdeals-project-backend:1.0` - Latest patch version in 1.0 series

## Troubleshooting

If you encounter issues:

1. Make sure you've replaced `your-dockerhub-username` with your actual DockerHub username
2. Check that the version tags exist on DockerHub
3. Ensure your environment files are properly configured
4. Check Docker logs for any errors:
   ```bash
   docker-compose logs backend
   docker-compose logs frontend
   ```