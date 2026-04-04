# FinSpark FastAPI Backend

Simple FastAPI backend for file processing with CORS enabled.

## Setup

### 1. Install Dependencies

```bash
pip install -r requirements.txt
```

### 2. Run the Server

```bash
python main.py
```

Or with uvicorn directly:

```bash
uvicorn main:app --host 127.0.0.1 --port 8000 --reload
```

The server will start at: **http://127.0.0.1:8000**

### 3. API Endpoints

**POST /process/**
- Accepts file upload
- Returns analysis results
- Request: `multipart/form-data` with `file` field
- Response: JSON with extracted fields and analysis

**GET /**
- Health check

**GET /health**
- Detailed health status

## CORS

CORS is enabled for:
- http://localhost:5173
- http://localhost:5174
- http://127.0.0.1:3000
- http://127.0.0.1:5173
- http://127.0.0.1:5174

## Frontend

Frontend is running on: http://localhost:5174

Navigate to "New Integration" → upload a file → click "Analyze Documents"

The backend will return mock data with extracted fields and analysis results.
