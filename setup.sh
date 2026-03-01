#!/bin/bash
# setup.sh — Run this after setting your API URL
# Usage: bash setup.sh https://your-backend.onrender.com

API_URL=${1:-http://localhost:8000}

echo "🔧 Injecting API URL: $API_URL into all portals..."

for portal in portal-management portal-worker portal-legal portal-academic; do
  sed -i "s|REPLACE_WITH_API_URL|$API_URL|g" "$portal/index.html"
  echo "  ✅ $portal/index.html updated"
done

echo ""
echo "🚀 All portals configured!"
echo "   Main landing: open index.html in browser"
echo "   Or run: docker compose up --build"
