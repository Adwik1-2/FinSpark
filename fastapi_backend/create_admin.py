#!/usr/bin/env python3
"""Create admin user in the database"""

from database import SessionLocal
from models import User
from datetime import datetime
import bcrypt

def hash_password(password: str) -> str:
    """Hash password using bcrypt directly"""
    salt = bcrypt.gensalt()
    return bcrypt.hashpw(password.encode(), salt).decode()

def create_admin_user():
    """Create default admin user"""
    db = SessionLocal()
    
    try:
        # Check if admin already exists and delete
        existing_admin = db.query(User).filter(User.email == "admin@finspark.com").first()
        
        if existing_admin:
            db.delete(existing_admin)
            db.commit()
            print("🗑️  Deleted existing admin user")
        
        # Create admin user with direct bcrypt hashing
        admin_user = User(
            email="admin@finspark.com",
            full_name="Administrator",
            hashed_password=hash_password("Admin@123"),
            is_verified=True,
            is_active=True,
            created_at=datetime.utcnow(),
            last_login=datetime.utcnow()
        )
        
        db.add(admin_user)
        db.commit()
        db.refresh(admin_user)
        
        print(f"✅ Admin user created successfully!")
        print(f"   Email: admin@finspark.com")
        print(f"   Password: Admin@123")
        
    except Exception as e:
        print(f"❌ Error creating admin user: {e}")
        db.rollback()
    finally:
        db.close()

if __name__ == "__main__":
    create_admin_user()
