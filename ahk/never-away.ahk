; number of minutes between idlecheck runs
checkInterval := 1

; number of minutes afk before moving mouse
afkTime := 4

; run afkCheck periodically
SetTimer(afkCheck, checkInterval * 60 * 1000)
return

afkCheck() {
  ; if user is considered AFK
  if (A_TimeIdle > afkTime * 60 * 1000) {
    ; Uncomment to debug this script:
    ; MsgBox("You have been AFK for: " . A_TimeIdle . "ms", "AFK Debug", "T2")
    MouseMove(10, 0, 20, "R")
    sleep(1000)
    MouseMove(-10, 0, 20, "R")
  }
}