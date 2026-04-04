# FinSpark Login & Admin Setup Guide

## 🔧 Quick Setup (5 minutes)

### Step 1: Configure Email for OTP (REQUIRED)

**Why:** Without email configuration, OTP codes cannot be sent for email verification.

#### For Gmail:

1. **Enable 2-Factor Authentication:**
   - Go to: https://myaccount.google.com
   - Click "Security" in left menu
   - Enable "2-Step Verification"

2. **Generate App Password:**
   - Go to: https://myaccount.google.com/apppasswords
   - Select "Mail" and "Windows Computer" (or your device)
   - Click "Generate"
   - Copy the 16-character password (without spaces)

3. **Update .env file:**
   ```bash
   # File: fastapi_backend/.env
   
   SENDER_EMAIL=your-gmail@gmail.com
   SENDER_PASSWORD=xxxx xxxx xxxx xxxx  # Your app password (remove spaces!)
   SMTP_SERVER=smtp.gmail.com
   SMTP_PORT=587
   ```

**⚠️ DO NOT use your regular Gmail password - use the App Password!**

---

## 👥 User Authentication System

### **Three Login Methods:**

### 1. **Email + Password (Traditional)**
```
Flow:
  User enters email + password
     ↓
  Backend verifies credentials
     ↓
  Creates session token
     ↓
  Redirects to dashboard
```

**Requirements:**
- User must have already signed up
- Password must be saved in database

---

### 2. **Email + OTP (New Users & Login)**
```
Flow:
  User enters email
     ↓
  Click "Send OTP"
     ↓
  Backend generates 6-digit code
     ↓
  Email sent to user
     ↓
  User enters OTP + password (for signup)
     ↓
  User verified and logged in
```

**What Happens:**
- OTP expires after 10 minutes
- Max 5 failed attempts per OTP
- New OTP can be generated anytime

---

### 3. **Admin Portal**
```
Flow:
  Admin enters credentials
     ↓
  Email: admin@finspark.com
  Password: Admin@123
     ↓
  Access admin panel
     ↓
  View system stats & user management
```

**What Admin Can Do:**
- View dashboard statistics
- Manage users
- Monitor system health
- Export reports

---

## 🎨 UI Changes (Dashboard-Style Colors)

The login page now matches the dashboard dark theme:

- **Background:** Dark slate (slate-950, slate-900)
- **Text:** Light slate for readability
- **Input Text:** Black text for better contrast
- **Accent Colors:** 
  - Cyan for user login/signup
  - Violet for admin panel
- **Buttons:** Gradient effects
- **Cards:** Dark with subtle borders

---

## 🧪 Test Authentication

### Test 1: Create User Account

1. Go to **http://localhost:5173/login**
2. Click **"Sign Up"** tab
3. Enter:
   - Full Name: `Test User`
   - Email: `testuser@example.com`
   - Password: `TestPass123!` (must have: upper, lower, number, special)
4. Click **"Sign Up with OTP"**
5. Check your email for OTP code
6. Enter OTP and verify
7. ✅ Should redirect to dashboard

### Test 2: Login with OTP

1. Go to login page
2. Click **"Login"** tab
3. Enter email: `testuser@example.com`
4. Click **"Login with OTP"**
5. Check email for OTP
6. Enter OTP code
7. ✅ Should redirect to dashboard

### Test 3: Login with Password

1. Go to login page
2. Enter email: `testuser@example.com`
3. Enter password: `TestPass123!`
4. Click **"Login with Password"**
5. ✅ Should redirect to dashboard

### Test 4: Admin Access

1. Go to login page
2. Click **"Admin"** tab
3. Enter:
   - Email: `admin@finspark.com`
   - Password: `Admin@123`
4. Click **"Access Admin Panel"**
5. ✅ Should show admin dashboard at `/admin`

---

## 📧 Email Configuration Troubleshooting

### OTP Not Arriving?

**Check 1: Email Settings**
```bash
# In fastapi_backend/.env, verify:
SENDER_EMAIL=your-email@gmail.com      # Must be Gmail
SENDER_PASSWORD=xxxx xxxx xxxx xxxx    # Must be App Password (not regular password)
SMTP_SERVER=smtp.gmail.com             # Correct server
SMTP_PORT=587                          # Correct port
```

**Check 2: Gmail App Password**
- Make sure you have 2-Factor Auth enabled
- Check if App Password was actually generated
- Regenerate new App Password if needed
- Remove spaces from password

**Check 3: Check Spam Folder**
- Gmail sometimes marks automated emails as spam
- Add sender email to contacts to whitelist

**Check 4: Verify Backend is Running**
```bash
# Terminal should show:
# 🚀 Starting FinSpark Processing Engine...
# INFO: Uvicorn running on http://127.0.0.1:8001
```

### Still Not Working?

1. **Check backend logs:**
   ```
   Look for "OTP sent successfully" or error messages
   ```

2. **Test email manually in Python:**
   ```python
   import smtplib
   from email.mime.text import MIMEText
   
   msg = MIMEText("Test")
   msg['Subject'] = "FinSpark Test"
   msg['From'] = "your-email@gmail.com"
   
   with smtplib.SMTP_SSL("smtp.gmail.com", 587) as server:
       server.login("your-email@gmail.com", "your-app-password")
       server.sendmail("your-email@gmail.com", "recipient@example.com", msg.as_string())
   ```

---

## 🔐 Password Requirements

Passwords must be at least 8 characters and contain:
- ✓ Uppercase letter (A-Z)
- ✓ Lowercase letter (a-z)
- ✓ Number (0-9)
- ✓ Special character (!@#$%^&*)

**Examples:**
- ✅ `SecurePass123!` - Valid
- ❌ `password123` - Missing uppercase & special char
- ❌ `Pass123` - Only 7 characters
- ✅ `MyPassword@2026` - Valid

---

## 💾 Database Storage

All data stored in SQLite: `fastapi_backend/finspark.db`

### Tables Created:
```
users                   - User accounts & verification status
otp_verifications      - OTP codes with expiration times
login_sessions         - Active session tokens
```

### Database Location:
```
C:\Users\Adwik\OneDrive\Desktop\fins\fastapi_backend\finspark.db
```

---

## 🚀 Verifying Setup

After starting servers, verify with these commands:

**Check Backend Running:**
```bash
curl http://localhost:8001/docs
# Should show: FastAPI Swagger documentation
```

**Check Auth Endpoints:**
```bash
curl http://localhost:8001/api/auth/send-otp -X POST
# Should show: OTP sent successfully
```

**Check Frontend:**
```
http://localhost:5173/login
# Should show login page with dark theme
```

---

## ❌ Common Issues

| Issue | Solution |
|-------|----------|
| "Invalid email or password" | Check if user exists, verify password is correct |
| "OTP has expired" | Generate new OTP (expires after 10 minutes) |
| "Too many attempts" | Wait or generate new OTP |
| No OTP email arriving | Configure .env with Gmail credentials |
| Input text is hard to see | Should be black text now (updated) |
| Admin login not working | Use: admin@finspark.com / Admin@123 |
| Backend not responding | Ensure Python server running on port 8001 |
| Frontend blank | Ensure Node server running on port 5173 |

---

## 📊 User Flow Diagram

```
┌─────────────────────────────────────────────┐
│           FinSpark Login System              │
└─────────────────────────────────────────────┘

         ┌─────────────┬──────────────┬──────────┐
         │   LOGIN     │    SIGNUP    │  ADMIN   │
         └──────┬──────┴──────┬───────┴────┬─────┘
                │             │            │
          ┌─────▼─────┐   ┌───▼────┐  ┌────▼─────┐
          │ Email+Pass │   │OTP+Pass│  │ Hard-    │
          │    ▼       │   │   ▼    │  │ coded    │
          │ Verify DB  │   │Send OTP│  │ Creds    │
          │    ▼       │   │   ▼    │  │   ▼      │
          │ Create     │   │ Verify │  │ Create   │
          │ Session    │   │Session │  │ Session  │
          │    ▼       │   │   ▼    │  │   ▼      │
          └────┬────────┬──┴────┬───────┴────┬─────┘
               │        │       │            │
               └────────┴───┬───┴────────────┘
                            ▼
                    ✅ Logged In
                    📊 Dashboard Access
                    🛡️ Authenticated Session
```

---

## 🔒 Security Notes

1. **Never commit .env to git** - Add to `.gitignore`
2. **Change SECRET_KEY** in production
3. **Use HTTPS** in production
4. **Enable CSRF protection** for real deployments
5. **Rate limit** login attempts in production
6. **Add email verification** for signup in production
7. **Rotate admin credentials** regularly

---

## 📞 Support

For issues:
1. Check terminal for error messages
2. Review logs in backend terminal
3. Clear browser cache: Ctrl+Shift+Delete
4. Check localStorage: F12 → Application → Storage
5. Verify backend running: http://localhost:8001/docs

---

## ✅ Checklist

- [ ] Gmail App Password generated
- [ ] .env file configured with email
- [ ] Backend running on port 8001
- [ ] Frontend running on port 5173
- [ ] Can see login page at http://localhost:5173/login
- [ ] Input text is black (readable)
- [ ] Can test signup flow
- [ ] Can test OTP flow
- [ ] Can test admin login
- [ ] Database file exists: `fastapi_backend/finspark.db`

---

**🎉 Setup Complete! Your FinSpark authentication system is ready to use.**
