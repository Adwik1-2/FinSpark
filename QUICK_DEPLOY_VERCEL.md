# 🚀 Quick Start: Deploy on Vercel Now

## 3-Minute Deployment Guide

### Step 1: Deploy Frontend to Vercel (2 minutes)

1. Go to **[Vercel Dashboard](https://vercel.com/dashboard)**
2. Click **"Add New..."** → **"Project"**
3. Click **"Import Git Repository"**
4. Search for and select **`Adwik1-2/FinSpark`**
5. Configure:
   - **Root Directory**: `./FinSpark-Integration-Orchestrator`
   - **Framework**: `Vite`
6. Add Environment Variable:
   - **Key**: `VITE_API_BASE_URL`
   - **Value**: `http://localhost:8001` (for now)
7. Click **"Deploy"** → Wait 2-3 minutes ✅

**Your frontend is now live at**: `https://finspark.vercel.app`

---

### Step 2: Deploy Backend (Choose One)

#### Option A: Heroku (Recommended)

```bash
# Install Heroku CLI from: https://devcenter.heroku.com/articles/heroku-cli

# Login to Heroku
heroku login

# Create app
heroku create finspark-backend

# Deploy
cd fastapi_backend
git push heroku main

# Set environment variables
heroku config:set HUGGING_FACE_API_KEY="your_key" SECRET_KEY="your_secret"

# View logs
heroku logs -a finspark-backend --tail
```

**Backend URL**: `https://finspark-backend.herokuapp.com`

#### Option B: Railway.app (Easier)

1. Go to **[Railway.app](https://railway.app)**
2. Click **"New Project"** → **"Deploy from GitHub repo"**
3. Select `Adwik1-2/FinSpark` and directory: `fastapi_backend`
4. Add environment variables in dashboard
5. Deploy automatically ✅

**Backend URL**: `https://your-app.railway.app`

---

### Step 3: Connect Frontend to Backend

1. Go to **Vercel Dashboard** → Your Project
2. **Settings** → **Environment Variables**
3. Update `VITE_API_BASE_URL`:
   - Change from `http://localhost:8001`
   - To: `https://finspark-backend.herokuapp.com` (or your Railway URL)
4. **Redeploy** (click Deploy or push to GitHub)

---

## ✅ Verification Checklist

- [ ] Frontend deployed on Vercel (`https://finspark.vercel.app`)
- [ ] Backend deployed on Heroku/Railway
- [ ] Environment variables configured
- [ ] Frontend loads without errors
- [ ] API calls work (check browser console)
- [ ] Database initialized on backend

---

## 🎯 What Was Set Up

✅ **vercel.json** - Vercel build configuration  
✅ **Procfile** - Heroku deployment settings  
✅ **railway.toml** - Railway.app deployment settings  
✅ **Updated CORS** - Supports production domains  
✅ **Deployment Scripts** - `deploy.sh` and `deploy.ps1`  
✅ **Complete Guide** - `VERCEL_DEPLOYMENT.md`

---

## 🔗 Your Repository

**GitHub**: https://github.com/Adwik1-2/FinSpark

All deployment files are already configured and pushed to GitHub!

---

## 💡 Common Issues

**Frontend shows blank page?**
- Check browser DevTools Console for errors
- Verify `VITE_API_BASE_URL` environment variable

**API calls fail (CORS error)?**
- Update Vercel domain in backend CORS config
- Redeploy backend

**Backend won't start?**
- Check logs: `heroku logs -a finspark-backend`
- Verify all environment variables are set

---

## 📚 Full Documentation

For complete setup guide, environment variables, troubleshooting, and advanced options:
→ See [VERCEL_DEPLOYMENT.md](VERCEL_DEPLOYMENT.md)

---

## 🚀 You're Ready!

Your FinSpark application is configured for Vercel deployment. Start deploying now! 🎉
