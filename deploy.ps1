# Custom deployment script for GitHub Pages
# This script manually deploys the dist folder to the gh-pages branch

Write-Host "Building project..." -ForegroundColor Cyan
npm run build

if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "Deploying to gh-pages..." -ForegroundColor Cyan

# Remove existing gh-pages branch from remote
git push origin --delete gh-pages 2>$null

# Navigate to dist folder
Set-Location dist

# Remove existing git repo if it exists
if (Test-Path .git) {
    Remove-Item -Recurse -Force .git
}

# Initialize new git repo
git init
git remote add origin https://github.com/Vaibh607/CakeShopTest.git
git checkout -b gh-pages
git add .
git commit -m "Deploy updated app - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git push -f origin gh-pages

# Return to project root
Set-Location ..

Write-Host "Deployment complete!" -ForegroundColor Green
Write-Host "Your site should be available at: https://Vaibh607.github.io/CakeShopTest" -ForegroundColor Yellow

