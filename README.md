# FinSpark Integration Orchestrator 🚀

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Status](https://img.shields.io/badge/status-active-brightgreen)

A comprehensive financial document processing and API integration platform powered by AI. FinSpark automates the analysis of Business Requirements Documents (BRDs) and financial documents, extracting key APIs and orchestrating integrations with minimal manual intervention.

## 🎯 Project Overview

FinSpark combines advanced AI capabilities with a modern full-stack architecture to streamline financial document processing. The platform:

- **Processes Financial Documents**: Upload BRDs, PDFs, and financial documents
- **Extracts APIs Intelligently**: Auto-detects financial APIs from document content
- **Generates Documentation**: Creates comprehensive API integration documentation
- **Executes Pipelines**: Simulates and monitors integration workflows
- **Manages Authentication**: Secure user authentication with OTP verification

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    EXTERNAL DOCUMENTS (BRD, PDFs)               │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│                    FRONTEND (React + Vite)                       │
│                   FinSpark-Integration-Orchestrator              │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────┐  │
│  │  File Upload     │  │ Process Docs     │  │ Execute      │  │
│  │  Drag & Drop     │  │ Visualization    │  │ Mock Loans   │  │
│  │  Analysis        │  │ Flow Diagram     │  │              │  │
│  └──────────────────┘  └──────────────────┘  └──────────────┘  │
└──────────────────────────┬──────────────────────────────────────┘
                           │  (HTTP REST Calls)
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│                   FASTAPI BACKEND                                │
│              http://127.0.0.1:8001                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────┐  │
│  │ Engine.py    │→ │ Analyzer.py  │→ │ Main.py Endpoints    │  │
│  │ (Parse)      │  │ (Detect APIs)│  │ (Process & Generate) │  │
│  └──────────────┘  └──────────────┘  └──────────────────────┘  │
└────────────────────────┬─────────────────────────────────────────┘
                         │
        ┌────────────────┼────────────────┐
        ▼                ▼                ▼
    ┌────────────┐  ┌────────────┐  ┌────────────┐
    │ AI Engine  │  │ File Cache │  │ JSON      │
    │ Llama 3.1  │  │ (PDFs,     │  │ History   │
    │ HF API     │  │  Docs)     │  │ Storage   │
    └────────────┘  └────────────┘  └────────────┘
```

## 📦 Project Structure

```
fins/
├── fastapi_backend/                 # FastAPI Backend Application
│   ├── main.py                      # Application entry point
│   ├── engine.py                    # Document parsing engine
│   ├── ai_mapper.py                 # AI-powered API detection
│   ├── requirement_analyzer.py      # BRD analysis module
│   ├── auth.py                      # Authentication service
│   ├── auth_routes.py               # Auth API endpoints
│   ├── admin_routes.py              # Admin API endpoints
│   ├── database.py                  # Database configuration
│   ├── models.py                    # SQLAlchemy ORM models
│   ├── schemas.py                   # Pydantic schemas
│   ├── requirements.txt             # Python dependencies
│   ├── pipeline_history/            # API processing history
│   └── README.md                    # Backend documentation
│
├── FinSpark-Integration-Orchestrator/  # React Frontend Application
│   ├── src/
│   │   ├── components/              # Reusable React components
│   │   │   ├── AIAssistant.tsx      # AI chat interface
│   │   │   ├── Header.tsx           # App header
│   │   │   ├── Sidebar.tsx          # Navigation sidebar
│   │   │   ├── dashboard/           # Dashboard components
│   │   │   ├── wizard/              # Multi-step wizard
│   │   │   └── ChatBot/             # Chatbot components
│   │   ├── pages/                   # Page components
│   │   │   ├── Home.tsx
│   │   │   ├── Dashboard.tsx
│   │   │   ├── Login.tsx
│   │   │   ├── NewIntegration.tsx
│   │   │   └── AdminDashboard.tsx
│   │   ├── context/                 # React Context API
│   │   ├── utils/                   # Utility functions
│   │   └── App.tsx                  # Main app component
│   ├── tsconfig.json
│   ├── vite.config.ts
│   ├── package.json
│   └── README.md                    # Frontend documentation
│
├── AUTHENTICATION_README.md         # Auth system documentation
├── SYSTEM_GUIDE.md                  # Complete system architecture guide
├── LOGIN_ADMIN_SETUP.md             # Admin setup instructions
├── DEMO_VIDEO_SCRIPT.md             # Demo walkthrough script
└── README.md                        # This file
```

## 🚀 Quick Start

### Prerequisites

- **Node.js** 16+ and npm/yarn
- **Python** 3.8+
- **Git**

### Backend Setup

```bash
cd fastapi_backend

# Install dependencies
pip install -r requirements.txt

# Run the server
python main.py
```

Server will start at: `http://127.0.0.1:8001`

### Frontend Setup

```bash
cd FinSpark-Integration-Orchestrator

# Install dependencies
npm install

# Start development server
npm run dev
```

Frontend will be available at: `http://localhost:5176`

## 🔐 Authentication

FinSpark includes a comprehensive authentication system:

- **Email-based OTP verification**
- **Secure password hashing** with BCrypt
- **JWT token-based authentication**
- **Session management** with configurable expiration
- **Admin access controls**

See [AUTHENTICATION_README.md](AUTHENTICATION_README.md) for detailed authentication setup and usage.

## 📋 Key Features

### 🔍 Document Processing
- Upload and parse financial documents (BRDs, PDFs)
- Intelligent content extraction
- Automatic field detection
- Document history tracking

### 🤖 AI-Powered API Detection
- Automatic detection of 8+ financial API patterns
- Natural language processing with Llama 3.1
- Context-aware API mapping
- Integration recommendations

### 📊 Dashboard & Visualization
- Real-time processing status
- Interactive pipeline workflows
- Metrics and performance tracking
- Historical data management

### 💬 AI Assistant
- Intelligent chatbot powered by AI
- Natural language queries
- Real-time assistance
- Knowledge base integration

### 🔌 API Registry
- Centralized API configuration management
- Integration endpoints documentation
- Webhook management
- API usage tracking

## 🛠️ Technology Stack

### Frontend
- **React 18** - UI framework
- **TypeScript** - Type safety
- **Vite** - Build tool
- **Tailwind CSS** - Styling
- **Context API** - State management

### Backend
- **FastAPI** - Web framework
- **SQLAlchemy** - ORM
- **SQLite/PostgreSQL** - Database
- **Pydantic** - Data validation
- **JWT** - Authentication

### AI/ML
- **Llama 3.1** - Language model
- **Hugging Face API** - Model inference
- **LangChain** - AI orchestration

## 📚 Documentation

- [AUTHENTICATION_README.md](AUTHENTICATION_README.md) - Authentication system documentation
- [SYSTEM_GUIDE.md](SYSTEM_GUIDE.md) - Complete system architecture and workflow
- [LOGIN_ADMIN_SETUP.md](LOGIN_ADMIN_SETUP.md) - Admin user setup guide
- [DEMO_VIDEO_SCRIPT.md](DEMO_VIDEO_SCRIPT.md) - Demo walkthrough script
- [fastapi_backend/README.md](fastapi_backend/README.md) - Backend API documentation
- [FinSpark-Integration-Orchestrator/README.md](FinSpark-Integration-Orchestrator/README.md) - Frontend documentation

## 🌐 Production Deployment

Deploy FinSpark to production with ease:

- **[QUICK_DEPLOY_VERCEL.md](QUICK_DEPLOY_VERCEL.md)** - ⚡ 3-minute Vercel deployment guide
- **[VERCEL_DEPLOYMENT.md](VERCEL_DEPLOYMENT.md)** - 📖 Complete deployment guide with all options

### Quick Deployment Options

**Frontend** - Deploy to **Vercel** (Recommended)
```bash
# Already configured - just connect GitHub repo to Vercel
# See QUICK_DEPLOY_VERCEL.md for 3-minute setup
```

**Backend** - Deploy to **Heroku** or **Railway.app**
```bash
# Procfile and runtime.txt already included
# See VERCEL_DEPLOYMENT.md for detailed backend setup
```

**Automated Deployment** - Run deployment script
```bash
# Linux/Mac
./deploy.sh

# Windows
.\deploy.ps1
```

## 🔄 API Endpoints

### Core Endpoints

#### `POST /process/`
Process and analyze a document
- **Description**: Upload document for AI analysis
- **Request**: `multipart/form-data` with `file` field
- **Response**: JSON with extracted APIs and analysis results

#### `POST /generate-doc/`
Generate comprehensive integration documentation
- **Description**: Create API integration docs based on analysis
- **Request**: Document analysis results
- **Response**: Formatted integration documentation

#### `POST /execute-pipeline/`
Execute integration pipeline
- **Description**: Run simulated loan processing pipeline
- **Request**: Pipeline configuration
- **Response**: Execution results and metrics

### Authentication Endpoints

- `POST /auth/signup` - User registration with OTP
- `POST /auth/verify-otp` - OTP verification
- `POST /auth/login` - User login
- `POST /auth/logout` - User logout
- `GET /auth/profile` - User profile

### Admin Endpoints

- `GET /admin/users` - List all users
- `POST /admin/assign-role` - Assign user roles
- `DELETE /admin/users/{userId}` - Remove user

## 🔑 Environment Configuration

Create a `.env` file in `fastapi_backend/`:

```env
# Database
DATABASE_URL=sqlite:///./finspark.db

# Email Service (for OTP)
EMAIL_SERVICE_API_KEY=your_email_api_key
EMAIL_FROM=noreply@finspark.com

# AI/ML
HUGGING_FACE_API_KEY=your_huggingface_key
LLAMA_MODEL=llama-3.1-70b

# Authentication
SECRET_KEY=your_secret_key_here
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_DAYS=7

# CORS
FRONTEND_URL=http://localhost:5176

# Admin
ADMIN_EMAIL=admin@finspark.com
ADMIN_PASSWORD=your_secure_admin_password
```

## 🧪 Testing

### Backend Tests
```bash
cd fastapi_backend
pytest test_*.py -v
```

### Frontend Tests
```bash
cd FinSpark-Integration-Orchestrator
npm run test
```

## 📈 Workflow Overview

1. **Upload Document** - User uploads BRD or financial document
2. **Parse Document** - Engine extracts sections and fields
3. **Detect APIs** - AI analyzer identifies financial APIs
4. **Generate Documentation** - System creates integration docs
5. **Execute Pipeline** - Simulate and test integrations
6. **Monitor & Track** - Dashboard shows real-time status

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 Code Standards

- **Python**: Follow PEP 8
- **TypeScript/React**: Use ESLint configuration
- **Documentation**: Keep README files updated
- **Commits**: Use meaningful commit messages
- **Testing**: Maintain >80% code coverage

## 🐛 Troubleshooting

### Backend Connection Issues
```bash
# Test backend server
curl http://127.0.0.1:8001/health
```

### Frontend Build Issues
```bash
# Clear cache and reinstall
rm -rf node_modules package-lock.json
npm install
```

### Database Issues
```bash
# Reset database
rm fastapi_backend/finspark.db
# Restart backend to reinitialize
```

## 📞 Support

For issues, questions, or suggestions:
- Check existing documentation in the `docs/` folder
- Review [SYSTEM_GUIDE.md](SYSTEM_GUIDE.md) for detailed workflows
- Check authentication setup in [AUTHENTICATION_README.md](AUTHENTICATION_README.md)

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Team

FinSpark Development Team

---

**Last Updated**: April 2026  
**Version**: 1.0.0  
**Status**: Production Ready ✅
