# 🚀 FinSpark Setup Guide

Simple setup guide for running FinSpark locally.

## Prerequisites

- **Node.js** 16+ and npm
- **Python** 3.8+
- **Git**

## Backend Setup

### 1. Navigate to backend directory

```bash
cd fastapi_backend
```

### 2. Create virtual environment (optional but recommended)

```bash
# Windows
python -m venv venv
venv\Scripts\activate

# Mac/Linux
python -m venv venv
source venv/bin/activate
```

### 3. Install dependencies

```bash
pip install -r requirements.txt
```

### 4. Create .env file

Copy `.env.example` to `.env` and add your API keys:

```bash
HUGGING_FACE_API_KEY=your_key_here
```

### 5. Run the server

```bash
python main.py
```

Server will start at: **http://127.0.0.1:8001**

## Frontend Setup

### 1. Navigate to frontend directory

```bash
cd FinSpark-Integration-Orchestrator
```

### 2. Install dependencies

```bash
npm install
```

### 3. Start development server

```bash
npm run dev
```

Frontend will be available at: **http://localhost:5176**

## Running Together

1. Start backend:
   ```bash
   cd fastapi_backend
   python main.py
   ```

2. In another terminal, start frontend:
   ```bash
   cd FinSpark-Integration-Orchestrator
   npm run dev
   ```

3. Open **http://localhost:5176** in your browser

## Verify Setup

- Backend health check: http://127.0.0.1:8001/health
- Frontend loads at: http://localhost:5176
- Check browser console for any errors

## Project Structure

```
fins/
├── fastapi_backend/          Backend API server
├── FinSpark-Integration-Orchestrator/  Frontend React app
├── SYSTEM_GUIDE.md           Architecture documentation
└── README.md                 Main project README
```

## Troubleshooting

**Backend won't start:**
- Check Python version: `python --version` (should be 3.8+)
- Check port 8001 is available
- Verify all dependencies: `pip install -r requirements.txt`

**Frontend won't build:**
- Check Node.js version: `node --version` (should be 16+)
- Clear node_modules: `rm -rf node_modules package-lock.json && npm install`

**API connection errors:**
- Ensure backend is running on http://127.0.0.1:8001
- Check browser console for CORS errors
- Verify frontend environment variables

## Next Steps

1. Read [SYSTEM_GUIDE.md](SYSTEM_GUIDE.md) for architecture overview
2. Review [fastapi_backend/README.md](fastapi_backend/README.md) for API details
3. Check [FinSpark-Integration-Orchestrator/README.md](FinSpark-Integration-Orchestrator/README.md) for frontend details
