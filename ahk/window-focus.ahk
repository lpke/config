#Requires AutoHotkey v2.0

; ==== DEVELOPMENT SHORTCUTS ====
; # win, + shift, ^ ctrl, ! alt
; Reload this script
#+r:: {
  Reload
}
; Get active window position data
#+t:: {
  aID := WinGetID("A")
  WinGetFullPos(&aXL, &aXR, &aYT, &aYB, &aW, &aH, aID)
  discounted := WinIsDiscounted(aID, &visible, &desktop, &taskbar)

  MsgBox(
    "XL:  " aXL "`n"
    "XR:  " aXR "`n"
    "YT:  " aYT "`n"
    "YB:  " aYB "`n"
    "W:  "  aW  "`n"
    "H:  "  aH  "`n"
    "`n"
    "ID:  " aID "`n"
    "`n"
    "Visible:  " visible "`n"
    "Desktop:  " desktop "`n"
    "Taskbar:  " taskbar "`n"
    "`n"
    "Discounted:  " discounted
  )
}
; ==== /DEVELOPMENT SHORTCUTS ====

WinGetFullPos(&xl, &xr, &yt, &yb, &w, &h, id) {
  WinGetPos(&xl, &yt, &w, &h, id)
  xr := xl + w
  yb := yt + h
  return
}

OverlapAxis(axis, padding, aXL, aXR, aYT, aYB, tXL, tXR, tYT, tYB) {
  if (axis = "Y" && (tYB >= (aYT + padding) && (tYT + padding) <= aYB))
    return true
  if (axis = "X" && (tXR >= (aXL + padding) && (tXL + padding) <= aXR))
    return true
  return false
}

WinIsDiscounted(id, &visible, &desktop, &taskbar) {
  wclass := WinGetClass(id)
  wstyle := WinGetStyle("ahk_id" id)
  WS_VISIBLE := 0x10000000

  visible := (wstyle & WS_VISIBLE) ? true : false
  desktop := (wclass = "Progman" || wclass = "WorkerW")
  taskbar := (wclass = "Shell_TrayWnd" || wclass = "Shell_SecondaryTrayWnd")

  return !visible || desktop || taskbar
}

; Constants
min_past := 20 ; min distance target window must be past active window to be considered

; focus left
#h:: {
  ; get id of active window
  aID := WinGetID("A")
  
  ; get position and size of active window
  WinGetFullPos(&aXL, &aXR, &aYT, &aYB, &aW, &aH, aID)
  
  ; get all window IDs (returns array of id strings)
  ids_arr := WinGetList()

  closest_id := ""
  closest_distance := 999999999

  ; loop through all windows
  for (tID in ids_arr) {
    ; get position and size of target window
    WinGetFullPos(&tXL, &tXR, &tYT, &tYB, &tW, &tH, tID)

    ; get whether there is Y axis overlap between window positions
    overlap := OverlapAxis("Y", min_past, aXL, aXR, aYT, aYB, tXL, tXR, tYT, tYB)

    ; check whether window is a discounted type
    discounted := WinIsDiscounted(tID, &visible, &desktop, &taskbar)

    ; skip if: is active window, is discounted type, no Y axis overlap, not far enough past edge
    if ((tID == aID) || (discounted) || (!overlap) || (aXL - tXL < min_past))
      continue

    distance := aXL - tXR

    ; update closest values if window is closer and to the left
    if (distance < closest_distance) {
        closest_id := tID
        closest_distance := distance
    }
  }
  
  ; activate closest window
  if (closest_id)
    WinActivate("ahk_id" closest_id)

  return
}

; focus down
#j:: {
  return
}

; focus up
#k:: {
  return
}

; focus right
#l:: {
  return
}
