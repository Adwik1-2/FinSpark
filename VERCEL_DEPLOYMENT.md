# Vercel Deployment Guide 🚀

Complete guide to deploy FinSpark on Vercel.

## 📋 Prerequisites

- [Vercel Account](https://vercel.com/signup) (free tier available)
- GitHub account with FinSpark repository pushed
- FastAPI backend deployed elsewhere (Heroku, Railway, etc.) or running locally

## 🌐 Deployment Architecture

```
┌──────────────────────────────────────┐
│      Vercel (Frontend - React)       │
│   FinSpark-Integration-Orchestrator   │
│      https://finspark.vercel.app     │
└────────────────┬─────────────────────┘
                 │  API Calls (REST)
                 ▼
┌──────────────────────────────────────┐
│   Backend Server (Deployed Elsewhere) │
│         FastAPI Backend              │
│                                      │
│  Options:                            │
│  - Heroku (easiest for FastAPI)      │
│  - Railway.app                       │
│  - AWS, Google Cloud, Azure          │
│  - DigitalOcean                      │
│  - Local machine (development)       │
└──────────────────────────────────────┘
```

## 🔧 Option 1: Deploy Frontend to Vercel (Recommended)

### Step 1: Connect GitHub Repository

1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Click **"Add New..."** → **"Project"**
3. Select **"Import Git Repository"**
4. Search for **`Adwik1-2/FinSpark`**
5. Click **"Import"**

### Step 2: Configure Project Settings

1. **Project Name**: `finspark` (or your preferred name)
2. **Framework Preset**: Select **"Vite"**
3. **Root Directory**: Set to `./FinSpark-Integration-Orchestrator`
4. Leave other settings as default

### Step 3: Add Environment Variables

In **Environment Variables** section, add:

```
VITE_API_BASE_URL=https://your-backend-url.com
```

Replace `https://your-backend-url.com` with your actual backend URL.

**Example:**
- Development: `http://localhost:8001`
- Production: `https://api.finspark.com`

### Step 4: Deploy

Click **"Deploy"** and wait for the build to complete. Your frontend will be live at:
- **`https://finspark.vercel.app`** (or custom domain)

## 🔄 Deploy Backend to Heroku (Recommended for FastAPI)

### Step 1: Create Heroku Account

1. Sign up at [Heroku](https://www.heroku.com)
2. Install [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli)

### Step 2: Create Heroku App

```bash
heroku login
heroku create finspark-backend
```

### Step 3: Create Procfile

Create `fastapi_backend/Procfile`:

```
web: uvicorn main:app --host 0.0.0.0 --port $PORT
```

### Step 4: Create runtime.txt

Create `fastapi_backend/runtime.txt`:

```
python-3.11.7
```

### Step 5: Deploy to Heroku

```bash
cd fastapi_backend
heroku git:remote -a finspark-backend
git push heroku main
```

### Step 6: Set Environment Variables

```bash
heroku config:set -a finspark-backend \
  DATABASE_URL="postgresql://..." \
  HUGGING_FACE_API_KEY="your_key" \
  SECRET_KEY="your_secret" \
  EMAIL_SERVICE_API_KEY="your_email_key"
```

Backend will be available at: `https://finspark-backend.herokuapp.com`

## 🔄 Deploy Backend to Railway.app (Easy Alternative)

### Step 1: Connect Repository

1. Go to [Railway.app](https://railway.app)
2. Click **"New Project"** → **"Deploy from GitHub repo"**
3. Select your FinSpark repository
4. Select **`fastapi_backend`** directory

### Step 2: Configure Build

Railway auto-detects Python and installs from `requirements.txt`.

Add this to a `railway.toml` file:

```toml
[build]
builder = "nixpacks"
buildCommand = "pip install -r requirements.txt"

[deploy]
startCommand = "uvicorn main:app --host 0.0.0.0 --port $PORT"
```

### Step 3: Add Environment Variables

In Railway dashboard:
- `DATABASE_URL`: PostgreSQL connection string
- `HUGGING_FACE_API_KEY`: Your API key
- `SECRET_KEY`: JWT secret
- `EMAIL_SERVICE_API_KEY`: Email service key

Backend URL: `https://your-app.railway.app`

## 📝 Update Frontend Environment

Once backend is deployed, update `.env` in frontend:

Create `FinSpark-Integration-Orchestrator/.env.production`:

```env
VITE_API_BASE_URL=https://finspark-backend.herokuapp.com
VITE_API_TIMEOUT=30000
```

## 🔗 Configure CORS on Backend

Update `fastapi_backend/main.py`:

```python
from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:5176",
        "https://finspark.vercel.app",  # Your Vercel domain
        "https://your-custom-domain.com",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

## 🚀 Deployment Checklist

- [ ] Frontend pushed to GitHub
- [ ] Vercel project created and linked
- [ ] Environment variables set on Vercel
- [ ] Backend deployed (Heroku/Railway/Custom)
- [ ] CORS configured on backend
- [ ] Environment variables set on backend
- [ ] Frontend `.env` updated with backend URL
- [ ] Test API connectivity from deployed frontend
- [ ] SSL/TLS certificates configured
- [ ] Custom domain configured (optional)

## 🧪 Test Deployment

1. Visit your Vercel frontend: `https://finspark.vercel.app`
2. Navigate to a page that calls the API
3. Check browser Console (DevTools) for any CORS errors
4. Verify data loads correctly

## 🐛 Troubleshooting

### Frontend builds but shows blank page
- Check browser console for errors
- Verify environment variables set on Vercel
- Check VITE_API_BASE_URL is correct

### API calls fail with CORS error
- Vercel domain must be added to backend CORS allow_origins
- Check backend is running and accessible
- Verify backend URL is correct

### 502 Bad Gateway on Backend
- Check Heroku/Railway logs: `heroku logs -a finspark-backend`
- Verify all dependencies installed
- Check environment variables are set
- Ensure database is initialized

### Database connection issues
- Verify DATABASE_URL environment variable
- Test local database connection first
- For PostgreSQL on Heroku: `heroku addons:create heroku-postgresql:hobby-dev`

## 🔐 Security Best Practices

1. **Never commit `.env` files**
   - Keep `.env` in `.gitignore` ✅

2. **Use Environment Variables for Secrets**
   - Add to Vercel Project Settings
   - Add to Heroku/Railway config vars

3. **Enable HTTPS**
   - Vercel: Automatic ✅
   - Heroku: Automatic ✅
   - Railway: Automatic ✅

4. **Rotate API Keys Regularly**
   - Especially exposed keys (HuggingFace token)
   - After any breach or security incident

5. **Database Security**
   - Use strong passwords
   - Restrict access by IP
   - Enable SSL for database connection

## 📊 Monitoring

### Vercel Analytics
- Dashboard shows deployment history
- Real-time function execution logs
- Performance metrics

### Heroku/Railway Logs
```bash
# Heroku
heroku logs -a finspark-backend --tail

# Railway - use dashboard
railway logs
```

## 💡 Tips

- **Cold Starts**: Free tier may experience slow initial requests
- **Build Time**: Keep dependencies minimal to reduce build time
- **Database**: Use managed database services (recommended vs file-based)
- **Caching**: Enable Vercel edge caching for static assets
- **API Rate Limiting**: Add rate limiting to backend API

## 🎯 Next Steps

1. Deploy frontend to Vercel
2. Deploy backend to Heroku/Railway
3. Configure custom domain (optional)
4. Set up monitoring and alerts
5. Configure automated deployments on push

## 📚 Additional Resources

- [Vercel Documentation](https://vercel.com/docs)
- [Heroku FastAPI Guide](https://devcenter.heroku.com/articles/deploying-python)
- [Railway Documentation](https://docs.railway.app/)
- [Environment Variables Best Practices](https://12factor.net/config)

---

**Need Help?**
- Check deployment logs for errors
- Verify all environment variables are set
- Test backend API locally first
- Review CORS configuration

Happy deploying! 🚀
