# 🏠 โครงการ Dormdeal

แอปพลิเคชันตลาดกลางแบบเต็มรูปแบบสำหรับผู้อยู่หอพักในการซื้อขายสินค้า พัฒนาด้วย React และ Node.js

## 📋 สารบัญ

- [ฟีเจอร์](#-ฟีเจอร์)
- [เทคโนโลยีที่ใช้](#-เทคโนโลยีที่ใช้)
- [โครงสร้างโครงการ](#-โครงสร้างโครงการ)
- [การตั้งค่า Docker](#-การตั้งค่า-docker)
- [เริ่มต้นใช้งาน](#-เริ่มต้นใช้งาน)
- [ตัวแปรสภาพแวดล้อม](#-ตัวแปรสภาพแวดล้อม)
- [เอกสาร API](#-เอกสาร-api)
- [การพัฒนา](#-การพัฒนา)
- [การใช้งานจริง](#-การใช้งานจริง)
- [แก้ไขปัญหา](#-แก้ไขปัญหา)
- [การมีส่วนร่วม](#-การมีส่วนร่วม)
- [DockerHub Images](#-dockerhub-images)

## ✨ ฟีเจอร์

- **ระบบสมาชิก** - Firebase Authentication
- **ตลาดสินค้า** - ซื้อขายสินค้าในหอพัก
- **แชทแบบเรียลไทม์** - ระบบข้อความผ่าน Socket.io
- **จัดการหมวดหมู่** - จัดหมวดหมู่สินค้าอย่างเป็นระบบ
- **แผงผู้ดูแลระบบ** - ควบคุมการจัดการ
- **ระบบให้คะแนน** - ให้คะแนนผู้ใช้และสินค้า
- **รายการโปรด** - บันทึกสินค้าที่ชื่นชอบ
- **ระบบชำระเงิน** - ชำระเงินผ่าน PromptPay QR code
- **อัปโหลดไฟล์** - เชื่อมต่อกับ Cloudinary
- **ออกแบบตอบสนอง** - ใช้งานได้บนมือถือ

## 🛠 เทคโนโลยีที่ใช้

### Frontend
- **React 19.0.0** - UI framework
- **Vite 6.1.0** - Build tool และ dev server
- **Tailwind CSS 4.0.8** - CSS framework
- **DaisyUI 5.0.0** - Component library
- **Socket.io Client** - การสื่อสารแบบเรียลไทม์
- **React Router** - การจัดการ routing
- **Axios** - HTTP client
- **Firebase** - Authentication และ storage

### Backend
- **Node.js** - Runtime environment
- **Express.js** - Web framework
- **MongoDB** - ฐานข้อมูล (MongoDB Atlas)
- **Mongoose** - ODM สำหรับ MongoDB
- **Socket.io** - การสื่อสารแบบเรียลไทม์
- **Firebase Admin** - Firebase ฝั่งเซิร์ฟเวอร์
- **JWT** - Authentication tokens
- **Cloudinary** - เก็บไฟล์รูปภาพ
- **Multer** - อัปโหลดไฟล์
- **Swagger** - เอกสาร API

### DevOps & Tools
- **Docker** - Containerization
- **Docker Compose** - จัดการ Multi-container
- **Nginx** - Web server สำหรับ production
- **Redis** - Session storage และ caching
- **Nodemon** - Auto-restart ในโหมดพัฒนา

## 📁 โครงสร้างโครงการ

```
Dormdeal-Project/
├── backend/                 # Node.js API server
│   ├── configs/            # ไฟล์กำหนดค่า
│   ├── controllers/        # ตัวควบคุมเส้นทาง
│   ├── middlewares/        # Middlewares
│   ├── models/            # โมเดลฐานข้อมูล
│   ├── routers/           # เส้นทาง API
│   ├── libs/              # ไลบรารีเสริม
│   ├── docs/              # เอกสาร Swagger
│   ├── Dockerfile         # Docker image สำหรับ production
│   ├── Dockerfile.dev     # Docker image สำหรับ development
│   └── package.json       # Dependencies และ scripts
├── frontend/               # แอปพลิเคชัน React
│   ├── src/
│   │   ├── components/    # Component ที่ใช้ซ้ำได้
│   │   ├── pages/         # Page components
│   │   ├── layouts/       # Layout components
│   │   ├── services/      # API services
│   │   ├── configs/       # ไฟล์กำหนดค่า
│   │   └── stores/        # การจัดการ state
│   ├── public/            # Static assets
│   ├── Dockerfile         # Docker image สำหรับ production
│   ├── Dockerfile.dev     # Docker image สำหรับ development
│   ├── nginx.conf         # การกำหนดค่า Nginx
│   └── package.json       # Dependencies และ scripts
├── docker-compose.yml      # Container สำหรับ production
├── docker-compose.dev.yml  # Container สำหรับ development
├── README.Docker.md        # เอกสาร Docker
├── start-dev.bat          # สคริปต์เริ่มต้น development
├── start-prod.bat         # สคริปต์เริ่มต้น production
└── stop.bat               # สคริปต์หยุด containers
```

## 🐳 การตั้งค่า Docker

โครงการนี้ใช้ Docker แบบครบถ้วนสำหรับทั้งสภาพแวดล้อมการพัฒนาและการใช้งานจริง

### Services

| Service | Development Port | Production Port | คำอธิบาย |
|---------|------------------|-----------------|----------|
| Frontend | 5173 | 80 | แอปพลิเคชัน React |
| Backend | 5001 | 5001 | เซิร์ฟเวอร์ API Node.js |
| MongoDB | 27017 | 27017 | ฐานข้อมูล |
| Redis | 6379 | 6379 | Session storage |

### Images

- **Development**: `dormdeal-backend:dev`, `dormdeal-frontend:dev`
- **Production**: `dormdeal-backend:latest`, `dormdeal-frontend:latest`

### ใช้ Docker Images ที่สร้างไว้แล้ว

ดูคู่มือการใช้ Docker images ที่สร้างไว้แล้วได้ที่ [README.Docker.md](README.Docker.md)

## 🚀 เริ่มต้นใช้งาน

### สิ่งที่ต้องมีก่อน

- **Docker Desktop** - [ดาวน์โหลดที่นี่](https://www.docker.com/products/docker-desktop)
- **Git** - [ดาวน์โหลดที่นี่](https://git-scm.com/)

### เริ่มต้นอย่างรวดเร็ว

1. **โคลน repository**
   ```bash
   git clone <repository-url>
   cd Dormdeal-Project
   ```

2. **เริ่มต้นสภาพแวดล้อมการพัฒนา**
   ```bash
   # Windows
   start-dev.bat
   
   # หรือทำด้วยตนเอง
   docker-compose -f docker-compose.dev.yml up --build
   ```

3. **เข้าใช้งานแอปพลิเคชัน**
   - Frontend: http://localhost:5173
   - Backend API: http://localhost:5001
   - เอกสาร API: http://localhost:5001/api-docs

## 🔐 ตัวแปรสภาพแวดล้อม

### Backend (.env)

สร้างไฟล์ `.env` ในโฟลเดอร์ `backend/`:

```
# การกำหนดค่าเซิร์ฟเวอร์
NODE_ENV=development
PORT=5000
BASE_URL=http://localhost:5173

# ฐานข้อมูล
DB_URL=mongodb://your_connection_string

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

### Frontend (.env)

สร้างไฟล์ `.env` ในโฟลเดอร์ `frontend/`:

```
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

**⚠️ หมายเหตุ:** ไม่ควรแชร์ไฟล์ .env หรือเผยแพร่ข้อมูลสำคัญในที่สาธารณะ

## 📚 เอกสาร API

เอกสาร API สามารถดูได้ผ่าน Swagger UI เมื่อ backend ทำงาน:

- **URL**: http://localhost:5001/api-docs
- **แบบโต้ตอบ**: ทดสอบ endpoints ได้จากเบราว์เซอร์
- **ครบถ้วน**: เอกสาร API endpoints ทั้งหมดพร้อมตัวอย่าง

### API Endpoints หลัก

```
การยืนยันตัวตน:
POST   /api/v1/user/register
POST   /api/v1/user/login
POST   /api/v1/user/logout

สินค้า:
GET    /api/v1/post
POST   /api/v1/post
PUT    /api/v1/post/:id
DELETE /api/v1/post/:id

หมวดหมู่:
GET    /api/v1/maincategory
GET    /api/v1/subcategory

แชท:
GET    /api/v1/message
POST   /api/v1/message
GET    /api/v1/chatroom

ผู้ดูแลระบบ:
GET    /api/v1/admin
POST   /api/v1/admin
```

## 👨‍💻 การพัฒนา

### โหมดการพัฒนา

```bash
# เริ่มต้น services ทั้งหมดพร้อม hot reload
docker-compose -f docker-compose.dev.yml up --build

# เริ่มต้น service เฉพาะ
docker-compose -f docker-compose.dev.yml up backend-dev
docker-compose -f docker-compose.dev.yml up frontend-dev

# ดู logs
docker-compose -f docker-compose.dev.yml logs -f backend-dev
docker-compose -f docker-compose.dev.yml logs -f frontend-dev

# รันคำสั่งใน containers
docker-compose -f docker-compose.dev.yml exec backend-dev npm install
docker-compose -f docker-compose.dev.yml exec frontend-dev npm install

# เข้าสู่ container shell
docker-compose -f docker-compose.dev.yml exec backend-dev sh
```

### Hot Reload

ทั้ง frontend และ backend รองรับ hot reload ในโหมดการพัฒนา:
- **Frontend**: Vite dev server พร้อม HMR
- **Backend**: Nodemon รีสตาร์ทอัตโนมัติเมื่อไฟล์เปลี่ยน

### การจัดการฐานข้อมูล

```bash
# เข้าสู่ MongoDB shell
docker-compose -f docker-compose.dev.yml exec mongodb mongosh -u admin -p password123

# ดูฐานข้อมูล
docker-compose -f docker-compose.dev.yml exec mongodb mongosh -u admin -p password123 --eval "show dbs"
```

## 🏭 การใช้งานจริง

### โหมด Production

```bash
# เริ่มต้นสภาพแวดล้อม production
docker-compose up --build -d

# ดู logs
docker-compose logs -f

# หยุด services
docker-compose down
```

### ฟีเจอร์ Production

- **Nginx**: การให้บริการไฟล์แบบเหมาะสม
- **Gzip Compression**: ลดการใช้ bandwidth
- **Security Headers**: เสริมความปลอดภัย
- **Health Checks**: ตรวจสอบ container
- **Multi-stage Builds**: ลดขนาด image

## 🔧 แก้ไขปัญหา

### ปัญหาที่พบบ่อย

1. **Port ชนกัน**
   ```bash
   # ตรวจสอบการใช้ port
   netstat -ano | findstr :5001
   
   # หยุด containers
   docker-compose down
   ```

2. **ปัญหาการเชื่อมต่อฐานข้อมูล**
   ```bash
   # ตรวจสอบ MongoDB logs
   docker-compose logs mongodb
   
   # ตรวจสอบ connection string ใน .env
   ```

3. **Build ล้มเหลว**
   ```bash
   # ล้าง build cache
   docker builder prune
   
   # Build ใหม่แบบ force
   docker-compose build --no-cache
   ```

4. **Frontend เข้าไม่ได้**
   - ตรวจสอบว่า Vite ตั้งค่าด้วย `host: '0.0.0.0'`
   - ตรวจสอบว่า container bind กับ interface ทั้งหมด

### Health Checks

```bash
# ตรวจสอบสุขภาพ container
docker-compose ps

# ดู health check logs
docker inspect container_name | grep -A 10 Health
```

### การติดตามประสิทธิภาพ

```bash
# ติดตามการใช้ทรัพยากร
docker stats

# ข้อมูลระบบ
docker system df
docker system info
```

## 🤝 การมีส่วนร่วม

1. **Fork repository**
2. **สร้าง feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Commit การเปลี่ยนแปลง**
   ```bash
   git commit -m 'เพิ่มฟีเจอร์ที่น่าตื่นตาตื่นใจ'
   ```
4. **Push ไป branch**
   ```bash
   git push origin feature/amazing-feature
   ```
5. **เปิด Pull Request**

### แนวทางการพัฒนา

- ปฏิบัติตาม React hooks best practices
- ใช้ TypeScript เพื่อความปลอดภัยของข้อมูล (เมื่อเหมาะสม)
- เขียน commit messages ที่มีความหมาย
- เพิ่ม tests สำหรับฟีเจอร์ใหม่
- อัปเดตเอกสารตามที่จำเป็น

## 📄 ลิขสิทธิ์

โครงการนี้อยู่ภายใต้ลิขสิทธิ์ ISC License - ดูไฟล์ [LICENSE](LICENSE) สำหรับรายละเอียด

## 👥 ทีม

- **นักพัฒนา**: ทีม Dormdeal
- **ประเภทโครงการ**: วิชาการ/เชิงพาณิชย์
- **เวอร์ชัน**: 1.0.0

## 🐳 DockerHub Images

Docker images สำหรับโปรเจกต์นี้มีให้ใช้งานผ่าน DockerHub:

- Backend: `your-dockerhub-username/dormdeals-project-backend:latest`
- Frontend: `your-dockerhub-username/dormdeals-project-frontend:latest`

### ดึง Docker Images

```bash
docker pull your-dockerhub-username/dormdeals-project-backend:latest
docker pull your-dockerhub-username/dormdeals-project-frontend:latest
```

### ใช้งานผ่าน Docker Compose

1. สร้างไฟล์ `.env` ที่ระดับ root ของโปรเจกต์:

```env
DOCKERHUB_USERNAME=your-dockerhub-username
```

2. รันด้วยคำสั่ง:

```
docker-compose -f docker-compose.prod.yml up -d
```

ดูข้อมูลเพิ่มเติมเกี่ยวกับการตั้งค่า DockerHub ได้ที่ [DOCKERHUB.md](DOCKERHUB.md)

## 🆘 การสนับสนุน

สำหรับการสนับสนุน ส่งอีเมลไปที่ support@dormdeal.com หรือสร้าง issue ใน repository นี้

---

## 📱 ภาพหน้าจอ

*เพิ่มภาพหน้าจอของแอปพลิเคชันที่นี่*

## 🔮 การพัฒนาในอนาคต

- แอปพลิเคชันมือถือ (React Native)
- ระบบค้นหาและกรองขั้นสูง
- ระบบแนะนำด้วย Machine Learning
- เชื่อมต่อกับผู้ให้บริการชำระเงินเพิ่มเติม
- รองรับหลายภาษา
- การแจ้งเตือนแบบ Push notifications

---

**สร้างด้วย ❤️ โดยทีม Dormdeal**