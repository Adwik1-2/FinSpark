#!/bin/bash

# FinSpark Quick Deployment Script
# Deploys frontend to Vercel and backend to Heroku

set -e

echo "🚀 FinSpark Deployment Script"
echo "================================"

# Check prerequisites
check_prerequisites() {
    echo "📋 Checking prerequisites..."
    
    if ! command -v vercel &> /dev/null; then
        echo "❌ Vercel CLI not found. Install with: npm i -g vercel"
        exit 1
    fi
    
    if ! command -v heroku &> /dev/null; then
        echo "❌ Heroku CLI not found. Install from: https://devcenter.heroku.com/articles/heroku-cli"
        exit 1
    fi
    
    if ! command -v git &> /dev/null; then
        echo "❌ Git not found"
        exit 1
    fi
    
    echo "✅ All prerequisites installed"
}

# Deploy frontend to Vercel
deploy_frontend() {
    echo ""
    echo "📦 Deploying frontend to Vercel..."
    echo "====================================="
    
    cd FinSpark-Integration-Orchestrator
    vercel --prod
    cd ..
    
    echo "✅ Frontend deployed to Vercel"
}

# Deploy backend to Heroku
deploy_backend() {
    echo ""
    echo "🔌 Deploying backend to Heroku..."
    echo "===================================="
    
    cd fastapi_backend
    
    # Check if remote exists
    if git remote | grep -q heroku; then
        echo "Converting to Heroku remote..."
        git remote remove heroku
    fi
    
    heroku create finspark-backend 2>/dev/null || true
    heroku git:remote -a finspark-backend
    git push heroku main
    
    echo "✅ Backend deployed to Heroku"
    
    cd ..
}

# Main execution
main() {
    check_prerequisites
    
    echo ""
    echo "Choose deployment option:"
    echo "1) Deploy frontend only (Vercel)"
    echo "2) Deploy backend only (Heroku)"
    echo "3) Deploy both (frontend + backend)"
    echo ""
    read -p "Enter choice (1-3): " choice
    
    case $choice in
        1)
            deploy_frontend
            ;;
        2)
            deploy_backend
            ;;
        3)
            deploy_frontend
            deploy_backend
            ;;
        *)
            echo "Invalid choice"
            exit 1
            ;;
    esac
    
    echo ""
    echo "🎉 Deployment complete!"
    echo ""
    echo "📊 Check deployment status:"
    echo "Frontend: vercel ls"
    echo "Backend: heroku apps"
}

main
