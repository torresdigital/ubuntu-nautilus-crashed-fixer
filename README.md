# Ubuntu Nautilus Crashed Fixer 🛠️

![ubuntu-nautilus-crashed-fixer-social](https://github.com/user-attachments/assets/9ff26ec4-9566-464e-aeff-b7685ca9388b)


A comprehensive solution for fixing Nautilus (Files) freezing issues on Ubuntu systems.

## 🚨 Problem Description

Nautilus freezes when clicking the Files icon in the dock and only works when run with `sudo`, creating permission issues that make the problem worse.

## 🔍 Root Cause

The issue is primarily caused by:

1. **Tracker Service Failure** - GNOME's file indexing service times out
2. **Permission Problems** - Running Nautilus with `sudo` creates root-owned files
3. **Corrupted Cache Files** - Invalid configuration prevents normal startup
4. **File Ownership Issues** - Mixed user/root ownership in home directory

## ⚡ Quick Fix

Run our automated script:

```bash
# Download and run the fix script
wget https://raw.githubusercontent.com/atorresbr/ubuntu-nautilus-crashed-fixer/main/fix-nautilus-freeze.sh
chmod +x fix-nautilus-freeze.sh
./fix-nautilus-freeze.sh
```

Or clone the repository:

```bash
git clone https://github.com/atorresbr/ubuntu-nautilus-crashed-fixer.git
cd ubuntu-nautilus-crashed-fixer
chmod +x fix-nautilus-freeze.sh
./fix-nautilus-freeze.sh
```

## 🔧 Manual Fix Steps

If you prefer to fix manually:

```bash
# 1. Kill hanging Nautilus processes
sudo killall -9 nautilus

# 2. Stop problematic Tracker services
systemctl --user stop tracker-miner-fs.service
systemctl --user disable tracker-miner-fs.service
systemctl --user mask tracker-miner-fs.service
systemctl --user stop tracker-extract.service
systemctl --user disable tracker-extract.service
systemctl --user mask tracker-extract.service

# 3. Remove corrupted files
sudo rm -rf ~/.cache/nautilus
sudo rm -rf ~/.config/nautilus
sudo rm -rf ~/.cache/tracker*
sudo rm -rf ~/.local/share/tracker*
sudo rm -rf ~/.config/tracker*

# 4. Fix file ownership
sudo chown -R $USER:$USER $HOME

# 5. Test Nautilus
nautilus --no-desktop --browser
```

## 📋 What the Fix Does

- ✅ **Terminates** hanging Nautilus processes
- ✅ **Disables** problematic Tracker services that cause timeouts
- ✅ **Removes** corrupted cache and configuration files
- ✅ **Fixes** file ownership issues in home directory
- ✅ **Launches** Nautilus in a stable mode
- ✅ **Restores** dock integration functionality

## 🚫 Prevention Tips

- **Never run** `sudo nautilus` - this creates the permission problems
- Use command-line tools for root file operations instead
- Keep your system updated to prevent Tracker issues
- Monitor disk space (full disks can cause Tracker failures)

## 📖 Technical Details

For a comprehensive explanation of why this happens and how the fix works, see our detailed guide:
[Nautilus-Freeze-Fix-Guide.md](Nautilus-Freeze-Fix-Guide.md)

## ✅ Success Indicators

After running the fix, you should see:
- Nautilus opens without freezing
- Files icon in dock works properly
- No permission errors in terminal
- File manager responds normally

## 🔄 Re-enabling Search (Optional)

If you want file search functionality back after the fix:

```bash
systemctl --user unmask tracker-miner-fs.service
systemctl --user enable tracker-miner-fs.service
systemctl --user start tracker-miner-fs.service
```

## 🆘 Still Having Issues?

If the fix doesn't work:

1. Check disk space: `df -h`
2. Verify file permissions: `ls -la ~`
3. Check for hardware issues: `sudo fsck -f /`
4. Try alternative file manager: `sudo apt install nemo && nemo`

## 📁 Repository Contents

- `fix-nautilus-freeze.sh` - Automated fix script
- `Nautilus-Freeze-Fix-Guide.md` - Detailed technical explanation
- `README.md` - This summary document

## 🤝 Contributing

Found this helpful? Please ⭐ star the repository!

Have improvements or found other solutions? Feel free to open an issue or submit a pull request.

## 📜 License

This project is open source and available under the [MIT License](LICENSE).

---

**Created by:** [@atorresbr](https://github.com/atorresbr)  
**Repository:** [ubuntu-nautilus-crashed-fixer](https://github.com/atorresbr/ubuntu-nautilus-crashed-fixer)
