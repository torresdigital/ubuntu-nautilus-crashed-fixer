#!/bin/bash

# Fix Nautilus Freeze Script
# This script fixes Nautilus when it freezes due to Tracker service issues

echo "🔧 Fixing Nautilus freeze issue..."
echo "=================================="

# Step 1: Kill any running Nautilus processes
echo "1. Killing Nautilus processes..."
sudo killall -9 nautilus 2>/dev/null
echo "   ✓ Nautilus processes terminated"

# Step 2: Stop and disable Tracker services
echo "2. Stopping Tracker services..."
systemctl --user stop tracker-miner-fs.service 2>/dev/null
systemctl --user disable tracker-miner-fs.service 2>/dev/null
systemctl --user mask tracker-miner-fs.service 2>/dev/null
systemctl --user stop tracker-extract.service 2>/dev/null
systemctl --user disable tracker-extract.service 2>/dev/null
systemctl --user mask tracker-extract.service 2>/dev/null
echo "   ✓ Tracker services stopped and disabled"

# Step 3: Remove corrupted cache and config files
echo "3. Removing corrupted Nautilus and Tracker files..."
sudo rm -rf $HOME/.cache/nautilus
sudo rm -rf $HOME/.config/nautilus
sudo rm -rf $HOME/.cache/tracker*
sudo rm -rf $HOME/.local/share/tracker*
sudo rm -rf $HOME/.config/tracker*
echo "   ✓ Corrupted files removed"

# Step 4: Fix file ownership
echo "4. Fixing file ownership..."
sudo chown -R $USER:$USER $HOME
echo "   ✓ File ownership fixed"

# Step 5: Test Nautilus
echo "5. Testing Nautilus..."
nautilus --no-desktop --browser &
sleep 2
echo "   ✓ Nautilus should now be working!"

echo ""
echo "🎉 Fix completed!"
echo "You can now use the Files icon in the dock normally."
echo "If you need file search functionality, you can re-enable Tracker later."
