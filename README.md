# Tweaks and Quality of Life hacks
Sometimes out-of-the-box just doesn't cut it. This is my place to store tweaks in the form of files, notes, code, and anything else I need in case I need to start from scratch again.

## Custom Firefox Style Guide
To add user styles to the Firefox UI, you need two things:
1. User styles enabled in Firefox's settings
2. A userChrome.css file for Firefox to reference

### Enabling User Styles in Firefox
1. In the url bar, go to ```about:config```
2. Search ```stylesheets``` and then find ```toolkit.legacyUserProfileCustomizations.stylesheets```
3. Set this property to ```true``` and restart your browser

### Adding userChrome.css
1. In Firefox, type ```about:support``` in the URL bar
2. Under 'Application Basics', find the table row for 'Profile Folder'
3. Click the button to go to the active profile in Firefox (for me if ended in .default-release)
4. Within this folder, add a new folder and name it 'chrome'
5. Inside the new 'chrome' folder, create a ```userChrome.css``` file and add applicable styles

### Tweaking styles
Within firefox, you can use the shortcut command+option+shift+i (on a mac) to open an inspector for the Firefox UI. Use this to determine element names, IDs, etc for your styling needs.
