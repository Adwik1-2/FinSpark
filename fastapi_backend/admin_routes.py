from fastapi import APIRouter, HTTPException, status
from pydantic import BaseModel

router = APIRouter(prefix="/api/admin", tags=["admin"])

# Demo admin credentials (change in production)
ADMIN_CREDENTIALS = {
    "email": "admin@finspark.com",
    "password": "Admin@123"
}

class AdminLoginRequest(BaseModel):
    email: str
    password: str

@router.post("/login")
async def admin_login(request: AdminLoginRequest):
    """Admin login endpoint"""
    if request.email == ADMIN_CREDENTIALS["email"] and request.password == ADMIN_CREDENTIALS["password"]:
        return {
            "success": True,
            "message": "Admin login successful",
            "access_token": "admin_token_demo",
            "admin": {
                "email": request.email,
                "role": "admin",
                "permissions": ["read", "write", "delete"]
            }
        }
    else:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid admin credentials"
        )

@router.get("/dashboard")
async def admin_dashboard():
    """Get admin dashboard data"""
    return {
        "total_users": 0,
        "total_documents": 0,
        "total_integrations": 0,
        "system_status": "operational"
    }

@router.get("/users")
async def list_users():
    """List all users"""
    return {
        "users": [],
        "total": 0
    }

@router.get("/documents")
async def list_documents():
    """List all documents"""
    return {
        "documents": [],
        "total": 0
    }
