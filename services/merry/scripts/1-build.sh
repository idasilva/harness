#!/bin/bash
set -e

echo "=========================================="
echo "STEP 1: BUILD WAR FILE"
echo "=========================================="
echo ""

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"

echo -e "${BLUE}→ Cleaning...${NC}"
mvn clean -q

echo -e "${BLUE}→ Compiling...${NC}"
mvn compile -q

echo -e "${BLUE}→ Creating WAR...${NC}"
mvn package -q -DskipTests

echo ""
echo "=========================================="
echo -e "${GREEN}✓ BUILD COMPLETE!${NC}"
echo "=========================================="
echo ""
echo "WAR file created:"
ls -lh target/merry.war
echo ""
echo "Next: Run ./scripts/2-package.sh"
echo ""