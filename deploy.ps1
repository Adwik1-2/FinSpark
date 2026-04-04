# FinSpark Quick Deployment Script (Windows)
# Deploys frontend to Vercel and backend to Heroku

Write-Host "🚀 FinSpark Deployment Script (Windows)" -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Cyan

# Check prerequisites
function Check-Prerequisites {
    Write-Host "📋 Checking prerequisites..." -ForegroundColor Yellow
    
    $tools = @("vercel", "heroku", "git")
    
    foreach ($tool in $tools) {
        $exists = $null -ne (Get-Command $tool -ErrorAction SilentlyContinue)
        if (-not $exists) {
            Write-Host "❌ $tool not found. Please install it first." -ForegroundColor Red
            exit 1
        } else {
            Write-Host "✅ $tool found" -ForegroundColor Green
        }
    }
    
    Write-Host "✅ All prerequisites installed" -ForegroundColor Green
}

# Deploy frontend to Vercel
function Deploy-Frontend {
    Write-Host "" -NoNewline
    Write-Host "📦 Deploying frontend to Vercel..." -ForegroundColor Cyan
    Write-Host "====================================" -ForegroundColor Cyan
    
    Push-Location FinSpark-Integration-Orchestrator
    vercel --prod
    Pop-Location
    
    Write-Host "✅ Frontend deployed to Vercel" -ForegroundColor Green
}

# Deploy backend to Heroku
function Deploy-Backend {
    Write-Host "" -NoNewline
    Write-Host "🔌 Deploying backend to Heroku..." -ForegroundColor Cyan
    Write-Host "===================================" -ForegroundColor Cyan
    
    Push-Location fastapi_backend
    
    # Create Heroku app if it doesn't exist
    heroku create finspark-backend 2>$null
    
    # Add remote if not exists
    $remoteExists = git remote | Select-String -Pattern "heroku"
    if (-not $remoteExists) {
        heroku git:remote -a finspark-backend
    }
    
    git push heroku main
    
    Write-Host "✅ Backend deployed to Heroku" -ForegroundColor Green
    
    Pop-Location
}

# Main execution
function Main {
    Check-Prerequisites
    
    Write-Host "" -NoNewline
    Write-Host "Choose deployment option:" -ForegroundColor Yellow
    Write-Host "1) Deploy frontend only (Vercel)"
    Write-Host "2) Deploy backend only (Heroku)"
    Write-Host "3) Deploy both (frontend + backend)"
    Write-Host ""
    
    $choice = Read-Host "Enter choice (1-3)"
    
    switch ($choice) {
        1 {
            Deploy-Frontend
        }
        2 {
            Deploy-Backend
        }
        3 {
            Deploy-Frontend
            Deploy-Backend
        }
        default {
            Write-Host "Invalid choice" -ForegroundColor Red
            exit 1
        }
    }
    
    Write-Host "" -NoNewline
    Write-Host "🎉 Deployment complete!" -ForegroundColor Green
    Write-Host "" -NoNewline
    Write-Host "📊 Check deployment status:" -ForegroundColor Yellow
    Write-Host "Frontend: vercel ls"
    Write-Host "Backend: heroku apps"
}

Main
