# FinSpark Integration Orchestrator 🚀

A financial document processing and API integration platform powered by AI.

## 🎯 Overview

FinSpark automates the analysis of financial documents (BRDs, PDFs) and intelligently detects financial APIs for seamless integration.

## 🏗️ Architecture

```
Frontend (React)          Backend (FastAPI)
├─ Components            ├─ Document Parser
├─ Pages                 ├─ AI Analyzer  
└─ Utils                 └─ API Detection
    ↓                           ↓
    └──────────────────────────┘
         HTTP REST API
```

## 📦 Project Structure

```
fins/
├── fastapi_backend/              # FastAPI Backend
│   ├── main.py                   # Entry point
│   ├── engine.py                 # Document parsing
│   ├── ai_mapper.py              # API detection
│   ├── database.py               # Database config
│   ├── models.py                 # Data models
│   ├── requirements.txt          # Dependencies
│   └── README.md                 # Backend docs
│
├── FinSpark-Integration-Orchestrator/  # React Frontend
│   ├── src/
│   │   ├── components/           # React components
│   │   ├── pages/                # Page components
│   │   ├── utils/                # Utilities
│   │   └── App.tsx               # Main app
│   ├── package.json              # Dependencies
│   └── README.md                 # Frontend docs
│
├── SYSTEM_GUIDE.md               # System architecture
└── README.md                     # This file
```

## 🚀 Quick Start

### Prerequisites

- **Node.js** 16+ & npm
- **Python** 3.8+
- **Git**

### Backend Setup

```bash
cd fastapi_backend
pip install -r requirements.txt
python main.py
```

Server runs at: `http://127.0.0.1:8001`

### Frontend Setup

```bash
cd FinSpark-Integration-Orchestrator
npm install
npm run dev
```

Frontend runs at: `http://localhost:5176`

For detailed setup instructions, see [SETUP_GUIDE.md](SETUP_GUIDE.md)

## 📋 Key Features

- **Document Processing** - Parse financial documents (BRDs, PDFs)
- **AI-Powered API Detection** - Identify financial APIs automatically
- **API Documentation Generation** - Create integration docs
- **Pipeline Execution** - Test and simulate integrations

## 🛠️ Technology Stack

**Frontend:** React 18, TypeScript, Vite, Tailwind CSS  
**Backend:** FastAPI, SQLAlchemy, Pydantic  
**AI:** Llama 3.1, Hugging Face API

## 📚 Documentation

- [SYSTEM_GUIDE.md](SYSTEM_GUIDE.md) - Architecture & workflow
- [fastapi_backend/README.md](fastapi_backend/README.md) - Backend setup
- [FinSpark-Integration-Orchestrator/README.md](FinSpark-Integration-Orchestrator/README.md) - Frontend setup

## 📝 License

MIT
