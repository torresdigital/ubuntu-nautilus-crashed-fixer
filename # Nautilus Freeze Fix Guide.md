# Nautilus Freeze Fix Guide

## Problem Description
Nautilus (Files) was freezing when launched and only worked with `sudo`, which created permission issues.

## Root Cause
The issue was caused by:
1. **Tracker service timeouts** - The file indexing service was failing to start
2. **Root-owned files** - Running Nautilus with `sudo` created files owned by root in the user directory
3. **Corrupted cache files** - Nautilus cache became corrupted due to permission issues

## Solution Steps

### 1. Kill Nautilus Processes
```bash
sudo killall -9 nautilus
```
Terminates any hanging Nautilus processes.

### 2. Disable Tracker Services
```bash
systemctl --user stop tracker-miner-fs.service
systemctl --user disable tracker-miner-fs.service
systemctl --user mask tracker-miner-fs.service
systemctl --user stop tracker-extract.service
systemctl --user disable tracker-extract.service
systemctl --user mask tracker-extract.service
```
Tracker was causing timeouts and preventing Nautilus from starting properly.

### 3. Remove Corrupted Files
```bash
sudo rm -rf ~/.cache/nautilus
sudo rm -rf ~/.config/nautilus
sudo rm -rf ~/.cache/tracker*
sudo rm -rf ~/.local/share/tracker*
sudo rm -rf ~/.config/tracker*
```
Removes all corrupted configuration and cache files.

### 4. Fix File Ownership
```bash
sudo chown -R $USER:$USER $HOME
```
Fixes any root-owned files created by running Nautilus with sudo.

### 5. Launch Nautilus
```bash
nautilus --no-desktop --browser
```
Starts Nautilus without desktop integration to avoid conflicts.

## Prevention Tips

- **Never run GUI applications with sudo** (like `sudo nautilus`)
- If you need root file access, use: `sudo -H nautilus` or better yet, use command line tools
- Regular system updates can prevent Tracker issues
- If you don't need file search, keep Tracker disabled

## Re-enabling Tracker (Optional)
If you want file search functionality back:
```bash
systemctl --user unmask tracker-miner-fs.service
systemctl --user enable tracker-miner-fs.service
systemctl --user start tracker-miner-fs.service
```

## Files Created/Modified
- Removes: `~/.cache/nautilus`, `~/.config/nautilus`, Tracker files
- Creates: Fresh Nautilus configuration on next launch
- Fixes: File ownership in home directory

## Success Indicators
- Nautilus opens without freezing
- Files icon in dock works properly
- No permission errors in terminal
- File manager responds normally