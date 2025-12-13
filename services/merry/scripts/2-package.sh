#!/bin/bash
set -e

echo "=========================================="
echo "STEP 2: CREATE TAR PACKAGE"
echo "=========================================="
echo ""

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

VERSION="1.0.0"
APP_NAME="merry"
TAR_NAME="${APP_NAME}-v${VERSION}.tar.gz"

# Create package directory
PACKAGE_DIR="$PROJECT_ROOT/dist/${APP_NAME}-v${VERSION}"
rm -rf "$PACKAGE_DIR"
mkdir -p "$PACKAGE_DIR"/{application,config}

echo -e "${BLUE}→ Adding WAR file...${NC}"
cp "$PROJECT_ROOT/target/merry.war" "$PACKAGE_DIR/application/"

echo -e "${BLUE}→ Adding config...${NC}"
cp "$PROJECT_ROOT/config/app.properties" "$PACKAGE_DIR/config/"

echo -e "${BLUE}→ Creating manifest...${NC}"
cat > "$PACKAGE_DIR/MANIFEST.txt" << EOF
Application: $APP_NAME
Version: $VERSION
Created: $(date)
Contents:
  - application/merry.war
  - config/app.properties
EOF

echo -e "${BLUE}→ Creating TAR...${NC}"
cd "$PROJECT_ROOT/dist"
tar -czf "$TAR_NAME" "$(basename $PACKAGE_DIR)"

echo ""
echo "=========================================="
echo -e "${GREEN}✓ PACKAGE CREATED!${NC}"
echo "=========================================="
echo ""
echo "TAR file:"
ls -lh "$PROJECT_ROOT/dist/$TAR_NAME"
echo ""
echo "Contents:"
tar -tzf "$TAR_NAME" | head -10
echo ""
echo "Next: Run ./scripts/3-deploy.sh"
echo ""