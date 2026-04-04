# FinSpark Authentication System

Complete authentication system with email/OTP verification and database storage.

## 🎯 Features

✅ **Email-based Authentication**
- Send OTP verification code to email
- 6-digit OTP with 10-minute expiration
- Automatic OTP resend functionality
- Rate limiting (5 attempts max per OTP)

✅ **Two Authentication Flows**
1. **Signup with OTP**: Create account with email + password
2. **Login with OTP**: Verify existing user via OTP
3. **Login with Password**: Traditional email/password login

✅ **Secure Password Management**
- BCrypt password hashing
- Password strength validation:
  - Minimum 8 characters
  - Must contain uppercase letter
  - Must contain lowercase letter
  - Must contain number
  - Must contain special character

✅ **Session Management**
- JWT-like token authentication
- 7-day session expiration
- Automatic session tracking
- Logout functionality

✅ **Database Storage**
- SQLite database (default, can switch to PostgreSQL)
- User profiles with verification status
- OTP verification history
- Login session tracking

## 📁 File Structure

### Backend (FastAPI)

```
fastapi_backend/
├── main.py              # Application entry point
├── database.py          # Database configuration & session management
├── models.py            # SQLAlchemy ORM models
├── schemas.py           # Pydantic request/response schemas
├── auth.py              # Authentication service
├── auth_routes.py       # API endpoints for authentication
├── requirements.txt     # Python dependencies
└── finspark.db          # SQLite database (auto-created)
```

### Frontend (React)

```
FinSpark-Integration-Orchestrator/src/
├── pages/
│   └── Login.tsx              # Login/Signup page
├── components/
│   └── ProtectedRoute.tsx      # Route protection wrapper
├── context/
│   └── AuthContext.tsx         # Authentication state management
└── (existing app pages remain protected)
```

## 🚀 API Endpoints

All endpoints are prefixed with `/api/auth`

### 1. Send OTP
```
POST /api/auth/send-otp
Content-Type: application/json

{
  "email": "user@example.com"
}

Response:
{
  "success": true,
  "message": "OTP sent successfully to user@example.com"
}
```

### 2. Verify OTP (Login)
```
POST /api/auth/verify-otp
Content-Type: application/json

{
  "email": "user@example.com",
  "otp": "123456"
}

Response:
{
  "success": true,
  "message": "Email verified successfully",
  "access_token": "token_here",
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "full_name": "John Doe",
    "is_verified": true,
    ...
  }
}
```

### 3. Signup with OTP Verification
```
POST /api/auth/signup-verify
Content-Type: application/json

{
  "email": "user@example.com",
  "otp": "123456",
  "full_name": "John Doe",
  "password": "SecurePass123!"
}

Response:
{
  "success": true,
  "message": "Account created and verified successfully",
  "access_token": "token_here",
  "user": { ... }
}
```

### 4. Login with Password
```
POST /api/auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "SecurePass123!"
}

Response:
{
  "access_token": "token_here",
  "token_type": "bearer",
  "user": { ... }
}
```

### 5. Get Current User Profile
```
GET /api/auth/me
Authorization: Bearer {access_token}

Response:
{
  "id": "uuid",
  "email": "user@example.com",
  "full_name": "John Doe",
  "is_verified": true,
  "verification_method": "email",
  "created_at": "2024-01-01T00:00:00",
  ...
}
```

### 6. Logout
```
POST /api/auth/logout
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "token": "token_here"
}

Response:
{
  "success": true,
  "message": "Logged out successfully"
}
```

### 7. Refresh Token
```
POST /api/auth/refresh-token
Authorization: Bearer {access_token}

Response:
{
  "access_token": "new_token_here",
  "token_type": "bearer"
}
```

## 🔧 Setup Instructions

### 1. Backend Setup

**Install Dependencies:**
```bash
cd fastapi_backend
pip install -r requirements.txt
```

**Configure Environment:**
Create `.env` file in `fastapi_backend/`:

```env
# Database
DATABASE_URL=sqlite:///./finspark.db
# For PostgreSQL: postgresql://user:password@localhost:5432/finspark

# Email Configuration (Gmail example)
SENDER_EMAIL=your-email@gmail.com
SENDER_PASSWORD=your-app-password  # Use Gmail App Password, not regular password
SMTP_SERVER=smtp.gmail.com
SMTP_PORT=587

# Security
SECRET_KEY=your-secret-key-change-this
ALGORITHM=HS256

# Environment
ENVIRONMENT=development
```

**Gmail Setup for Email:**
1. Enable 2-Factor Authentication on your Gmail account
2. Generate App Password at: https://myaccount.google.com/apppasswords
3. Use the generated 16-character password as SENDER_PASSWORD

**Start Backend:**
```bash
python main.py
# Server runs on http://localhost:8001
```

### 2. Frontend Setup

**Install Dependencies:**
```bash
cd FinSpark-Integration-Orchestrator
npm install
```

**Start Frontend:**
```bash
npm run dev
# Server runs on http://localhost:5173
```

## 🔐 Authentication Flow

### Signup Flow
```
User enters email
    ↓
Send OTP → Email sent to user
    ↓
User enters OTP & password
    ↓
Verify OTP + Create Account + Set Session
    ↓
User logged in & redirected to dashboard
```

### Login with OTP Flow
```
User enters email
    ↓
Send OTP → Email sent to user
    ↓
User enters OTP
    ↓
Verify OTP + Set Session
    ↓
User logged in & redirected to dashboard
```

### Login with Password Flow
```
User enters email & password
    ↓
Verify credentials
    ↓
Set Session
    ↓
User logged in & redirected to dashboard
```

## 💾 Database Schema

### Users Table
```sql
CREATE TABLE users (
  id VARCHAR PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  full_name VARCHAR(255),
  hashed_password VARCHAR(255),
  is_verified BOOLEAN DEFAULT FALSE,
  verification_method VARCHAR(50),  -- 'email', 'google'
  is_active BOOLEAN DEFAULT TRUE,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW(),
  last_login DATETIME,
  google_id VARCHAR(255) UNIQUE,
  profile_picture VARCHAR(500)
)
```

### OTP Verifications Table
```sql
CREATE TABLE otp_verifications (
  id VARCHAR PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  otp_code VARCHAR(6) NOT NULL,
  is_used BOOLEAN DEFAULT FALSE,
  attempt_count INTEGER DEFAULT 0,
  created_at DATETIME DEFAULT NOW(),
  expires_at DATETIME,  -- 10 minutes from creation
  verified_at DATETIME
)
```

### Login Sessions Table
```sql
CREATE TABLE login_sessions (
  id VARCHAR PRIMARY KEY,
  user_id VARCHAR NOT NULL,
  token VARCHAR(500) UNIQUE NOT NULL,
  is_active BOOLEAN DEFAULT TRUE,
  created_at DATETIME DEFAULT NOW(),
  expires_at DATETIME,  -- 7 days from creation
  ip_address VARCHAR(50),
  user_agent VARCHAR(500)
)
```

## 🎨 UI Features

### Login Page
- **Responsive Design**: Works on mobile, tablet, desktop
- **Two Tabs**: Login & Sign Up
- **OTP Input**: 6-digit numeric input with letter-spacing
- **Error Handling**: Clear error messages
- **Loading States**: Visual feedback during API calls
- **Welcome Email**: Sent after successful signup

### Protected Routes
- All main app routes protected behind authentication
- Automatic redirect to login for unauthenticated users
- Session persistence using localStorage
- Logout clears session data

### User Profile
- User name & email displayed in header
- Dropdown menu with profile options
- Logout button with confirmation

## 🧪 Testing Authentication

### Test Signup
1. Go to http://localhost:5173
2. Click "Sign Up" tab
3. Fill in:
   - Full Name: John Doe
   - Email: test@example.com
   - Password: TestPass123!
4. Click "Sign Up with OTP"
5. Check email for OTP (check spam folder)
6. Enter OTP and verify

### Test Login (OTP)
1. Go to http://localhost:5173/login
2. Click "Login" tab
3. Enter email address
4. Toggle to "Login with OTP"
5. Check email for OTP
6. Enter OTP and verify

### Test Login (Password)
1. Go to http://localhost:5173/login
2. Click "Login" tab
3. Enter email & password
4. Click "Login with Password"

## 🔄 Frontend State Management

### useAuth Hook
```typescript
const { 
  user,                    // Current user object
  token,                   // Auth token
  isAuthenticated,         // Boolean
  isLoading,              // Loading state
  error,                  // Error messages
  login,                  // Login function
  signup,                 // Signup function
  sendOTP,                // Send OTP function
  verifyOTP,              // Verify OTP function
  logout,                 // Logout function
  clearError              // Clear error messages
} = useAuth()
```

### Usage Example
```typescript
import { useAuth } from '../context/AuthContext'

export default function MyComponent() {
  const { user, logout, isAuthenticated } = useAuth()
  
  if (!isAuthenticated) return <Navigate to="/login" />
  
  return (
    <div>
      Welcome, {user?.full_name}!
      <button onClick={logout}>Logout</button>
    </div>
  )
}
```

## 🔌 Email Customization

Edit `auth.py` to customize email templates:

1. **OTP Email**: `AuthService.send_otp_email()`
2. **Welcome Email**: `AuthService.send_welcome_email()`

## 🚨 Error Codes

| Error | Status | Meaning |
|-------|--------|---------|
| Invalid email format | 400 | Email doesn't match pattern |
| User already exists | 400 | Email already registered |
| User not found | 404 | Email not in database |
| Invalid OTP | 400 | OTP code incorrect |
| OTP expired | 400 | OTP older than 10 minutes |
| Too many attempts | 400 | >5 failed OTP attempts |
| Invalid token | 401 | Session expired/invalid |
| Not authenticated | 401 | No auth token provided |

## 📱 Storage

### Frontend (localStorage)
```javascript
localStorage.setItem('auth_token', token)      // 7-day session token
localStorage.setItem('auth_user', userJSON)    // User profile
```

### Backend (SQLite)
- All user data persisted in `finspark.db`
- OTP codes stored with expiration times
- Session tokens tracked for security
- Automatic cleanup of expired OTPs/sessions

## 🔄 Future Enhancements

- [ ] Google OAuth integration
- [ ] Two-factor authentication (TOTP)
- [ ] Password reset via email
- [ ] Social login (GitHub, Microsoft)
- [ ] Email verification for registration
- [ ] User profile picture upload
- [ ] Account deletion/deactivation
- [ ] Login history & device management
- [ ] CSRF protection
- [ ] Rate limiting per IP

## 📚 Documentation

- **Backend**: FastAPI auto-generated docs at `http://localhost:8001/docs`
- **Frontend**: React components self-documented with TypeScript
- **Database**: SQLAlchemy models fully typed

## ⚠️ Security Notes

1. **Never commit `.env` file** - Add to `.gitignore`
2. **Change SECRET_KEY** in production
3. **Use HTTPS** in production
4. **Set secure cookie flags** for real deployments
5. **Implement rate limiting** for production
6. **Use strong email credentials**
7. **Consider CSRF tokens** for form submissions
8. **Validate all inputs** on backend

## 🐛 Troubleshooting

### OTP not sending
- Check `.env` file has correct email credentials
- Verify Gmail App Password is set (not regular password)
- Check spam folder
- Ensure SMTP settings are correct

### Login redirects to /login repeatedly
- Clear browser cache and localStorage
- Check if auth_token is valid
- Verify backend is running

### "Module not found" errors
- Ensure all dependencies installed: `pip install -r requirements.txt`
- Use correct Python version (3.8+)
- Run from correct directory

### Database locked error
- SQLite doesn't handle concurrent writes well
- For production, switch to PostgreSQL
- Restart backend if locked

## 📞 Support

For issues or questions:
1. Check error messages in browser console
2. Check backend logs in terminal
3. Review database with `sqlite3 finspark.db`
4. Verify all environment variables are set

---

**🎉 Authentication system is now live and ready for use!**
