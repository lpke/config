# Config, Tweaks and QoL hacks
Sometimes out-of-the-box just doesn't cut it. This is my place to store tweaks in the form of files, notes, code, and anything else I need in case I need to start from scratch again.

## Keyboard Shortcuts
I prefer mac-like keyboard shortcuts. If on linux, these are the changes I make:
* alt -> ctrl
* meta/windows -> alt
* ctrl -> meta/windows

Note: My VSCode shortcuts for linux ensure that they positions required to complete the commands mirror macOS, except using the above mappings.

For a better experience with Vim:
* Make CAPS key an escape key
* If an option, shift+caps to actually toggle caps is nice
* If not, then old esc as caps works too

---

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
