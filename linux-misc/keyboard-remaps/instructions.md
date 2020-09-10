# Keyboard Remapping on Linux
The files in this folder are designed to serve as custom keyboard layouts as an alternative to using a third party tool like AutoKey etc.
This works on PopOS/Gnome, unsure whether the process would vary on other distros.

## Guide
1. Create a backup of the existing layout:
```zsh
sudo cp /usr/share/X11/xkb/symbols/us /usr/share/X11/xkb/symbols/us.bak
```

2. Create a new "partial" file. This will include the customisations and will be specified in the main file we backed up in the previous step.
```zsh
sudo vim /usr/share/X11/xkb/symbols/vimify
```

3. Add a reference to the partial to the main file, inside the section `xkb_symbols "basic" { ... }`.
```
include "vimify(global-vim)"
```
**NOTE:** This step needs to be repeated after every distribution update.

4. Reload the window session. Log out and back in again. The new assignments should be working.
