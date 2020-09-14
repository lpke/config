# Keyboard Remapping on Linux
The files in this folder are designed to serve as custom keyboard layouts as an alternative to using a third party tool like AutoKey etc.
My understanding of this topic is shaky but here's what works on PopOS 20.04 running Gnome.

## Guide
1. To get mac-like control+alt positions, use `Gnome Tweaks`. Install then open it.

2. Under `keyboard > additional layout options` select:
   * Ctrl position: `Left Alt as Ctrl, Left Ctrl as Win, Left Win as Left Alt`
   * Caps lock behavior: `Make unmodified Caps Lock an additional Esc, but...`
   * Key to choose the 3rd level: `Right Alt`

3. Open a terminal window and type:
```zsh
cd /usr/share/X11/xkb/symbols
```
This is where the layouts and mappings for the keyboard are defined. To avoid extra hassle, edit an existing profile that extends a base layout.
Perfect example is `au`. It extends the US layout and does nothing else, but will always have a definition and settings pre-provided to the OS.

4. Create a backup of the existing layout:
```zsh
sudo cp /usr/share/X11/xkb/symbols/au /usr/share/X11/xkb/symbols/au.bak
```

5. Edit the file to include the following:
```
key <AC06> { [ h, H, Left, Left ] };
key <AC07> { [ j, J, Down, Down ] };
key <AC08> { [ k, K, Up, Up ] };
key <AC09> { [ l, L, Right, Right ] };
```
**NOTE:** This may need to be repeated after every distribution update.

6. Finally, make sure `English (Australian)` is selected under language/keyboard preferences in Gnome's main settings.

7. Reload the window session. Log out and back in again. The new assignments should be working.

## Some Useful Info
Xkb is complicated, but here are some useful keycodes if you want to change the settings in future in different ways:
Keep in mind that if keys are swapped as in the first steps of this guide, it may not play nicely with advanced custom remaps.

### left:
113 = <LEFT>
"Left", 0xff51

## down:
116 = <DOWN>
"Down", 0xff54

## up:
111 = <UP>
"Up", 0xff52

## right:
114 = <RGHT>
"Right", 0xff53

## left ctrl (originally alt):
64 = <LWIN>
"Control_L", 0xffe3

## left alt (origianlly win/meta):
133 = <LALT>
"Alt_L", 0xffe9
