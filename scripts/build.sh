#!/bin/bash
# =============================================================================
# Sophia OS Build Script
# Build ISO menggunakan Debian live-build
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
BUILD_DIR="$PROJECT_DIR/build"

# Warna output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}"
echo "  ____              _     _         ___  ____  "
echo " / ___|  ___  _ __ | |__ (_) __ _  / _ \/ ___| "
echo " \___ \ / _ \| '_ \| '_ \| |/ _\` | | | \___ \ "
echo "  ___) | (_) | |_) | | | | | (_| | |_| |___) |"
echo " |____/ \___/| .__/|_| |_|_|\__,_|\___/|____/ "
echo "             |_|                                "
echo -e "${NC}"
echo "Sophia OS Build System"
echo "IDEASOPHIA — Ideas Grow Like Leaves Under Sunlight"
echo "============================================="
echo ""

# Cek apakah running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Error: Script ini harus dijalankan sebagai root (sudo)${NC}"
    exit 1
fi

# Cek dependensi
echo -e "${YELLOW}[1/5] Memeriksa dependensi...${NC}"
for cmd in lb debootstrap; do
    if ! command -v $cmd &> /dev/null; then
        echo -e "${RED}Error: '$cmd' tidak ditemukan. Install dengan: sudo apt install live-build debootstrap${NC}"
        exit 1
    fi
done
echo -e "${GREEN}  ✓ Semua dependensi tersedia${NC}"

# Setup build directory
echo -e "${YELLOW}[2/5] Menyiapkan build directory...${NC}"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# Clean previous build
if [ -d ".build" ] || [ -f "*.iso" ]; then
    echo "  Membersihkan build sebelumnya..."
    lb clean --purge 2>/dev/null || true
fi

# Configure live-build
echo -e "${YELLOW}[3/5] Mengkonfigurasi live-build...${NC}"
lb config \
    --distribution bookworm \
    --architectures amd64 \
    --binary-images iso-hybrid \
    --bootloaders "grub-efi" \
    --debian-installer live \
    --archive-areas "main contrib non-free non-free-firmware" \
    --apt-recommends true \
    --security true \
    --updates true \
    --backports true \
    --cache true \
    --iso-application "Sophia OS" \
    --iso-publisher "IDEASOPHIA" \
    --iso-volume "SophiaOS-1.0-Merapi"

echo -e "${GREEN}  ✓ Konfigurasi selesai${NC}"

# Copy custom configs
echo -e "${YELLOW}[4/5] Menyalin konfigurasi custom...${NC}"
if [ -d "$PROJECT_DIR/config/package-lists" ]; then
    cp -r "$PROJECT_DIR/config/package-lists/"* "$BUILD_DIR/config/package-lists/" 2>/dev/null || true
fi
if [ -d "$PROJECT_DIR/config/hooks" ]; then
    cp -r "$PROJECT_DIR/config/hooks/"* "$BUILD_DIR/config/hooks/" 2>/dev/null || true
fi
if [ -d "$PROJECT_DIR/config/includes.chroot" ]; then
    cp -r "$PROJECT_DIR/config/includes.chroot/"* "$BUILD_DIR/config/includes.chroot/" 2>/dev/null || true
fi
echo -e "${GREEN}  ✓ Konfigurasi custom disalin${NC}"

# Build
echo -e "${YELLOW}[5/5] Memulai build ISO (ini akan memakan waktu lama)...${NC}"
echo "  Start time: $(date)"
lb build 2>&1 | tee "$BUILD_DIR/build.log"

# Done
echo ""
echo -e "${GREEN}=============================================${NC}"
echo -e "${GREEN}Build selesai!${NC}"
echo -e "${GREEN}ISO tersedia di: $BUILD_DIR/*.iso${NC}"
echo -e "${GREEN}Build log: $BUILD_DIR/build.log${NC}"
echo -e "${GREEN}End time: $(date)${NC}"
echo -e "${GREEN}=============================================${NC}"
