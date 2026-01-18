#!/usr/bin/env bash
set -e

echo "== ByteWhere Publish =="

cd "$(dirname "$0")"

echo "Pulling latest..."
git pull --rebase

echo "Installing deps..."
cd site
npm install

echo "Building site..."
npm run build
cd ..

echo "Checking changes..."
if git diff --quiet && git diff --cached --quiet; then
  echo "No changes to publish."
  exit 0
fi

echo "Committing..."
git add .
git commit -m "Publish: $(date '+%Y-%m-%d %H:%M')"

echo "Pushing..."
git push

echo "Done. GitHub Actions will deploy."

