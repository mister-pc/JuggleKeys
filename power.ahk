;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Screen off { Win + Shift + L } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PWR_ScreenOff:
^+#l Up::
IfWinNotActive, GUI_BSOD ahk_class AutoHotkeyGUI
{
	PWR_SetMonitorOff(1, 1000)
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Screensaver { Ctrl + Win + L } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PWR_Screensaver:
^#l up::
IfWinNotActive, GUI_BSOD ahk_class AutoHotkeyGUI
{
	PWR_SetMonitorOff(2, 1000)
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Countdown lock station { Win + L } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PWR_CountdownLockStation:
#l::
IfWinNotActive, GUI_BSOD ahk_class AutoHotkeyGUI
{
	AHK_ResetCursor()
	, PWR_SetMonitorOff(3, 5000)
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Forced lock station { Win + Shift + L } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PWR_LockStation:
#+l::
; AHK_SetCursor("Wait")
IfWinNotActive, GUI_BSOD ahk_class AutoHotkeyGUI
{
	; AHK_ResetCursor()
	PWR_SetMonitorOff(3, 1000)
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PWR_SetMonitorOff(PRM_Status, PRM_MilliSecondsToScreenOff = 0) {

	;  Monitor off : 1
	;  Screensaver : 2
	;         Lock : 3

	Global SCR_VirtualScreenX, SCR_VirtualScreenY, SCR_VirtualScreenWidth, SCR_VirtualScreenHeight
	SetTimer, PWR_SetMonitorOffTimer, Off
	KeyWait, Shift
	KeyWait, LWin
	KeyWait, RWin
	KeyWait, Ctrl

	; Init dark background :
	Gui, 3:Destroy ; GUI_FadeOutBackground
	Gui, 3:-MaximizeBox -MinimizeBox -Resize -ToolWindow -Caption -Border +Owner +AlwaysOnTop +LastFound
	Gui, 3:Color, 000000
	Gui, 3:Default
	WinSet, TransColor, FFFFFF 0
	Gui, 3:Show, x%SCR_VirtualScreenX% y%SCR_VirtualScreenY% w%SCR_VirtualScreenWidth% h%SCR_VirtualScreenHeight%, GUI_FadeOutBackground
	PWR_SetMonitorOffTimer(PRM_Status, PRM_MilliSecondsToScreenOff)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PWR_SetMonitorOffTimer:
PWR_SetMonitorOffTimer()
Return

PWR_SetMonitorOffTimer(PRM_Status = 0, PRM_MilliSecondsToScreenOff = 0) {

	; PRM_Status : 0 = Default
	;              1 = Monitor off
	;              2 = Screensaver
	;              3 = Lock

	Global SCR_VirtualScreenX, SCR_VirtualScreenY, SCR_VirtualScreenWidth, SCR_VirtualScreenHeight, LOG_DomainLogin, LOG_DomainEncryptedPassword, ZZZ_SetMonitorOffTimer
	Static STA_MilliSecondsToScreenOff := 0, STA_InitialMilliSecondsToScreenOff := 0, STA_Status := 0, STA_InitialMouseX, STA_InitialMouseY, STA_InitialTimer

	SetTimer, PWR_SetMonitorOffTimer, Off
	CoordMode, Mouse, Screen
	If (PRM_Status != 0) {
		STA_Status := PRM_Status
		, STA_InitialMilliSecondsToScreenOff := STA_MilliSecondsToScreenOff := PRM_MilliSecondsToScreenOff
		, STA_InitialTimer := A_TimeIdlePhysical
		MouseGetPos, STA_InitialMouseX, STA_InitialMouseY
	} Else {
		MouseGetPos, LOC_MouseX, LOC_MouseY
		If (A_TimeIdlePhysical < STA_InitialTimer
			|| Pow(STA_InitialMouseX - LOC_MouseX, 2) + Pow(STA_InitialMouseX - LOC_MouseX, 2) > 50 * 50) {
			Gui, 3:Destroy ; GUI_FadeOutBackground
			STA_InitialTimer := 0
			Return
		}
	}

	If (STA_MilliSecondsToScreenOff > 0) {
		STA_MilliSecondsToScreenOff := Max(STA_MilliSecondsToScreenOff + ZZZ_SetMonitorOffTimer, 0)
		WinSet, TransColor, % "FFFFFF " . (255 * (STA_InitialMilliSecondsToScreenOff - STA_MilliSecondsToScreenOff) // STA_InitialMilliSecondsToScreenOff), GUI_FadeOutBackground ahk_class AutoHotkeyGUI
		SetTimer, PWR_SetMonitorOffTimer, %ZZZ_SetMonitorOffTimer%
		Return
	}

	AUD_Beep()
	If (STA_Status == 1) {
		SendMessage, 0x112, 0xF170, 2, , Program Manager ; 0x112 is WM_SYSCOMMAND ; 0xF170 is ???
		PWR_EscapeUnlocksScreenOff()
	}
	If (STA_Status == 2) {
		Try {
			RegRead, LOC_ScreenSaverFullPath, HKEY_CURRENT_USER, Control Panel\Desktop, SCRNSAVE.EXE
			If (ErrorLevel == 0
				&& LOC_ScreenSaverFullPath) {
				SendMessage, 0x112, 0xF140, 0, , Program Manager ; 0x112 is WM_SYSCOMMAND ; 0xF140 is SC_SCREENSAVE
				KeyWait, Ctrl
				KeyWait, LWin
				KeyWait, RWin
				SplitPath, LOC_ScreenSaverFullPath, LOC_ScreenSaverFileName
				Process, Wait, %LOC_ScreenSaverFileName%, 5
			} Else {
				TRY_ShowTrayTip("No screensaver specified", 3)
			}
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "PWR_SetMonitorOffTimer", PRM_Status, PRM_MilliSecondsToScreenOff)
			, TRY_ShowTrayTip("No screensaver specified", 3)
		}
	}
	If (STA_Status == 3) {
		Try {
			APP_RunAs()
			Run, "%A_WinDir%\system32\rundll32.exe" user32.dll`, LockWorkStation, %A_WinDir%\system32, Hide UseErrorLevel ; Lock workstation
			SendMessage, 0x112, 0xF170, 2, , Program Manager ; 0x112 is WM_SYSCOMMAND ; 0xF170 is SC_SCREENOFF
			RunAs
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "PWR_SetMonitorOffTimer", PRM_Status, PRM_MilliSecondsToScreenOff)
			TRY_ShowTrayTip("Unable to lock workstation", 3)
			RunAs
		}
	}
	Sleep, 1000
	Gui, 3:Destroy
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PWR_EscapeUnlocksScreenOff() {

	LOC_Timestamp := A_TickCount
	, LOC_KeyCount := 0
	BlockInput, MouseMove
	Loop
	{
		; Previous or next tune on MediaMonkey :
		LOC_Direction := (GetKeyState("XButton1", "P") ? "Left" : (GetKeyState("XButton2", "P") ? "Right" : ""))
 		If (LOC_Direction) {
			IfWinExist, MediaMonkey ahk_class TFMainWindow
			{
 				ControlSend, ahk_parent, {RAlt Down}{%LOC_Direction%}{RAlt Up}
			}
		}

		Input, LOC_Char, L1 T0.5
		LOC_InputDone := (ErrorLevel != "TimeOut")
		If (A_TickCount - LOC_Timestamp < 1000) {
			LOC_KeyCount++
		} Else {
			LOC_Timestamp := A_TickCount
			, LOC_KeyCount := 1
		}
		If (LOC_KeyCount >= 3
			|| Asc(LOC_Char) == 27) { ; Escape
			Break
		}
		If (LOC_InputDone) {
			SendMessage, 0x112, 0xF170, 2, , Program Manager ; 0x112 is WM_SYSCOMMAND ; 0xF170 is SC_SCREENOFF
		}
	}
	BlockInput, MouseMoveOff
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, GUI_FadeOutBackground ahk_class AutoHotkeyGUI
WheelUp::
+WheelUp::
^WheelUp::
^+WheelUp::
WheelDown::
+WheelDown::
^WheelDown::
^+WheelDown::
AUD_Level(A_ThisHotKey, false)
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suspend { Ctrl + Win + Alt + L } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PWR_Suspend:
^!#l::
PWR_Suspend()
Return

PWR_Suspend() {
	PRM_PowerManager(PRM_Submit := false, PRM_State := 1)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Hibernate { Ctrl + Win + Alt + Shift + L } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PWR_Hibernate:
^!+#l::
PWR_Hibernate()
Return

PWR_Hibernate() {
	PRM_PowerManager(PRM_Submit := false, PRM_State := 1, PRM_ForcedActionEnabled := true)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Log off { Ctrl + Win + F12 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PWR_LogOff:
^#F12::
PWR_LogOff()
Return

PWR_LogOff() {
	PRM_PowerManager(PRM_Submit := false, PRM_State := 2)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Force log off { Ctrl + Win + Shift + F12 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PWR_ForceLogOff:
^+#F12::
PWR_ForceLogOff()
Return

PWR_ForceLogOff() {
	PRM_PowerManager(PRM_Submit := false, PRM_State := 2, PRM_ForcedActionEnabled := true)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Shutdown { Alt + Win + F12 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PWR_Shutdown:
!#F12::
PWR_Shutdown()
Return

PWR_Shutdown() {
	PRM_PowerManager(PRM_Submit := false, PRM_State := 3, , PRM_YesDefaultButton := false)
}

PWR_DelayedShutdown:
^!#F12::
^!+#F12::
PWR_DelayedShutdown()
Return

PWR_DelayedShutdown(PRM_Action = 0) {
	
	; PRM_Action == -2 : Checkbox
	; PRM_Action == -1 : 1 minute countdown
	; PRM_Action ==  0 : Display
	; PRM_Action ==  1 : Apply
	; PRM_Action ==  2 : Close
	
	Global AHK_ScriptInfo
	Static STA_MinutesLeft := 0, STA_WindowID := 0, STA_Checked := true
	
	; Checkbox :
	;;;;;;;;;;;;
	If (PRM_Action == -2) {
		STA_Checked := !STA_Checked
		Return
	}
	
	; 1 minute countdown :
	;;;;;;;;;;;;;;;;;;;;;;
	If (PRM_Action == -1) {
		STA_MinutesLeft--
		If (WinExist("ahk_id " . STA_WindowID)) {
			ControlSetText, Edit1, %STA_MinutesLeft%
		} Else {
			STA_WindowID := 0
		}
		If (STA_MinutesLeft <= 5) {
			LOC_Level := 1
			If (STA_MinutesLeft <= 3) {
				LOC_Level := 2
				If (STA_MinutesLeft <= 1) {
					LOC_Level := 3
					If (STA_MinutesLeft == 0) {
						PRM_PowerManager(PRM_Submit := false, PRM_State := 3, PRM_ForcedActionEnabled := true)
					}
				}
			}
			LOC_Tooltip := "Delayed shutdown in " . STA_MinutesLeft . " minute" . (STA_MinutesLeft > 1 ? "s" : "")
			TRY_ShowTrayTip(LOC_Tooltip, LOC_Level)
			Menu, Tray, Tip, %AHK_ScriptInfo%`n%LOC_Tooltip%
			If (STA_MinutesLeft) {
				SetTimer, PWR_DelayedShutdownTimer, -60000 ; countdown every minute
			}
		}
		Return
	}
		
	; Display :
	;;;;;;;;;;;
	If (PRM_Action == 0) {
		Gui, 49:Destroy ; Delayed Shutdown
		Gui, 49:Default
		Gui, 49:+LastFound -MaximizeBox -MinimizeBox -Resize +Owner +ToolWindow +Border +HwndSTA_WindowID
		Gui, 49:Margin, 20, 15
		Gui, 49:Add, Checkbox, % (STA_Checked ? "Checked " : "") . "xm+20 ym+15 vSTA_Checked gPWR_DelayedShutdownCheckbox", Shutdown computer in
		Gui, 49:Add, Edit, x+1 yp-3 Center Number vSTA_MinutesLeft, 999
		Gui, 49:Add, UpDown, x+1 yp+0 Range1-999, % (STA_MinutesLeft ? STA_MinutesLeft : 60)
		Gui, 49:Add, Text, x+1 yp+3, %A_Space%minute(s)
		Gui, 49:Add, Button, Default xm+0 y+30 w95 h25 gPWR_DelayedShutdownOK, &OK
		Gui, 49:Add, Button, x+10 yp+0 w95 h25 g49GuiEscape, &Cancel
		Gui, 49:Add, Button, x+10 yp+0 w95 h25 gPWR_DelayedShutdownApply, &Apply
		Gui, 49:Show, Center AutoSize, Delayed Shutdown
		ControlFocus, Edit2, ahk_id %LOC_WindowID%
		Return
	}
		
	; Apply / Close :
	;;;;;;;;;;;;;;;;;
	If (PRM_Action == 1
		|| PRM_Action == 2) {
		ControlGetText, STA_MinutesLeft, Edit1, ahk_id %STA_WindowID%
		LOC_Tooltip := "Delayed shutdown " . (STA_Checked ? "in " . STA_MinutesLeft . " minute" . (STA_MinutesLeft > 1 ? "s" : "") : "deactivated")
		TRY_ShowTrayTip(LOC_Tooltip, STA_Checked ? 2 : 1)
		If (STA_Checked) {
			Menu, Tray, Tip, %AHK_ScriptInfo%`n%LOC_Tooltip%
			SetTimer, PWR_DelayedShutdownTimer, -60000 ; countdown every minute
		} Else {
			Menu, Tray, Tip, %AHK_ScriptInfo%
			SetTimer, PWR_DelayedShutdownTimer, Off
		}
		If (PRM_Action == 2) {
			Gui, 49:Destroy ; Delayed Shutdown
		}
		Return
	}
}

PWR_DelayedShutdownCheckbox:
PWR_DelayedShutdown(-2)
Return

PWR_DelayedShutdownTimer:
PWR_DelayedShutdown(-1)
Return

PWR_DelayedShutdownApply:
PWR_DelayedShutdown(1)
Return

PWR_DelayedShutdownOK:
PWR_DelayedShutdown(2)
Return

49GuiClose:
49GuiEscape:
Gui, 49:Destroy
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Forced shutdown { Alt + Win + Shift + F12 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PWR_ForceShutdown:
!+#F12::
PWR_ForceShutdown()
Return

PWR_ForceShutdown() {
	PRM_PowerManager(PRM_Submit := false, PRM_State := 3, PRM_ForcedActionEnabled := true, PRM_YesDefaultButton := false)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Restart { Win + F12] :
;;;;;;;;;;;;;;;;;;;;;;;;

PWR_Restart:
#F12::
PWR_Restart()
Return

PWR_Restart() {
	PRM_PowerManager(PRM_Submit := false, PRM_State := 4, , PRM_YesDefaultButton := false)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Forced restart { Win + Shift + F12 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PWR_ForceRestart:
PWR_ForceRestart()
Return

PWR_ForceRestart() {
	PRM_PowerManager(PRM_Submit := false, PRM_State := 4, PRM_ForcedActionEnabled := true, PRM_YesDefaultButton := false)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PRM_PowerManager(PRM_Submit = true, PRM_State = 0, PRM_ForcedActionEnabled = false, PRM_YesDefaultButton = true, PRM_Delay = 0) {

; PRM_State ==  Default : -1
;                Cancel : 0
;               Suspend : 1, false - Hibernate : 0, true
;               Log off : 2
;              Shutdown : 3
;              Restart  : 4

	Global SCR_VirtualScreenX, SCR_VirtualScreenY, SCR_VirtualScreenWidth, SCR_VirtualScreenHeight, LOG_DomainLogin, LOG_DomainEncryptedPassword

	Static STA_SavedState := -1
	, STA_SavedForced := false
	, STA_SavedYes := true
	, STA_AlreadySuspending := false

	Gui, 4:Destroy
	SetTimer, ZZZ_DisplayConfirmationTimer, Off

	; Submit :
	If (PRM_Submit) {

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; Cancel :
		If (PRM_State == -1) {
			STA_SavedState := -1
			, STA_SavedForced := false
			, STA_SavedYes := true
			Gui, 3:Destroy ; GUI_FadeOutBackground
			Return
		}

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; Suspend / Hibernate :
		If (STA_SavedState == 1) {
			STA_SavedState := -1
			, LOC_Forced := STA_SavedForced
			, STA_SavedForced := false
			If (!STA_AlreadySuspending) {
				STA_AlreadySuspending := true
				, LOC_ProcessesToKill := "Palemoon|Thunderbird|PuTTY"
				Loop, Parse, LOC_ProcessesToKill, |
				{
					LOC_LoopField := A_LoopField
					Loop
					{
						Process, Exist, %LOC_LoopField%.exe
						If (ErrorLevel) {
							LOC_%LOC_LoopField% := ErrorLevel
							Process, Close, %LOC_LoopField%.exe
							Try {
								APP_RunAs()
								Run, % """" . A_WinDir . "\system32\TaskKill.exe"" /F /PID " . LOC_%LOC_LoopField%, , Hide UseErrorLevel
							} Catch LOC_Exception {
								AHK_Catch(LOC_Exception, "PRM_PowerManager", PRM_Submit, PRM_State, PRM_ForcedActionEnabled, PRM_YesDefaultButton)
							}
							RunAs
						} Else {
							Break
						}

					}
				}
				Gui, 3:Destroy ; GUI_FadeOutBackground
				DllCall("PowrProf.dll\SetSuspendState", "Int", (LOC_Forced ? 1 : 0), "Int", 1, "Int", 0)
				SetTimer, TRY_HideTrayTipTimer, -1
				Sleep, 5000
				STA_AlreadySuspending := false
				Loop, Parse, LOC_ProcessesToKill, |
				{
					If (LOC_%A_LoopField%) {
						If (A_LoopField == "Palemoon") {
							APP_FirefoxManager()
						}
						If (A_LoopField == "Thunderbird") {
							APP_MailManager()
						}
					}
				}
				SYS_TaskbarClockPeriodicTimer(PRM_ForceDisplay := true)
			}
			Return
		}

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; Log off :
		If (STA_SavedState == 2) {
			STA_SavedState := -1
			, LOC_Forced := STA_SavedForced
			, STA_SavedForced := false
			Gui, 3:Destroy ; GUI_FadeOutBackground
			Shutdown, (LOC_Forced ? 4 : 0)
			Return
		}

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; Shutdown :
		If (STA_SavedState == 3) {
			STA_SavedState := -1
			, LOC_Forced := STA_SavedForced
			, STA_SavedForced := false
			, OnMessage(0x11, "")
			, AHK_SetCursor("Wait")
			Gui, 3:Destroy ; GUI_FadeOutBackground
			Shutdown, (LOC_Forced ? 13 : 9)
			Return
		}

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; Restart :
		If (STA_SavedState == 4) {
			STA_SavedState := -1
			, LOC_Forced := STA_SavedForced
			, STA_SavedForced := false
			, OnMessage(0x11, "")
			, AHK_SetCursor("Wait")
			Gui, 3:Destroy ; GUI_FadeOutBackground
			Shutdown, (LOC_Forced ? 6 : 2)
			Return
		}

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; Cancel :
		STA_SavedState := -1
		, STA_SavedForced := false
		, STA_SavedYes := true
		Gui, 3:Destroy ; GUI_FadeOutBackground
		Return
	}

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	STA_SavedState := PRM_State
	, STA_SavedForced := PRM_ForcedActionEnabled
	, STA_SavedYes := PRM_YesDefaultButton
	Gui, 3:Destroy ; GUI_FadeOutBackground

	If (PRM_State == 1) {
		If (PRM_ForcedActionEnabled) {
			LOC_Title := "Hibernate computer"
			, LOC_Message := "Do you really want to hibernate the computer ?"
			, LOC_ToolTip := "Asking computer hibernation"
		} Else {
			LOC_Title := "Suspend computer"
			, LOC_Message := " Do you really want to suspend the computer ?"
			, LOC_ToolTip := "Asking computer suspend"
		}
	} Else

	If (PRM_State == 2) {
		If (PRM_ForcedActionEnabled) {
			LOC_Title := "Force log off"
			, LOC_Message := "Do you really want to force log off ?"
			, LOC_ToolTip := "Forcing log off"
		} Else {
			LOC_Title := "Log off"
			, LOC_Message := " Do you really want to log off ?"
			, LOC_ToolTip := "Asking log off"
		}
	} Else

	If (PRM_State == 3) {
		If (PRM_ForcedActionEnabled) {
			LOC_Title := "Forcing computer shutdown"
			, LOC_Message := "Do you really want to force the computer to shutdown ?"
			, LOC_ToolTip := "Forcing computer shutdown"
		} Else {
			LOC_Title := "Shutdown computer"
			, LOC_Message := "Do you really want to shutdown the computer ?"
			, LOC_ToolTip := "Asking computer shutdown"
		}
	} Else

	If (PRM_State == 4) {
		If (PRM_ForcedActionEnabled) {
			LOC_Title := "Forcing computer restart"
			, LOC_Message := "Do you really want to force the computer to restart ?"
			, LOC_ToolTip := "Forcing computer restart"
		} Else {
			LOC_Title := "Restart computer"
			, LOC_Message := "Do you really want to restart the computer ?"
			, LOC_ToolTip := "Asking computer restart"
		}

	} Else {
		STA_SavedState := -1
		, STA_SavedForced := false
		, STA_SavedYes := true
		Return
	}

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Display GUI :
	GroupAdd, PWR_RebootPopUps, %LOC_Title% ahk_class AutoHotkeyGUI
	Gui, 3:-MaximizeBox -MinimizeBox -Resize -ToolWindow -Caption -Border +Owner +AlwaysOnTop +LastFound ; GUI_FadeOutBackground
	Gui, 3:Color, 000000
	WinSet, TransColor, FFFFFF 0
	Gui, 3:Show, x%SCR_VirtualScreenX% y%SCR_VirtualScreenY% w%SCR_VirtualScreenWidth% h%SCR_VirtualScreenHeight%, GUI_FadeOutBackground
	TRY_ShowTrayTip(LOC_ToolTip, 2)
	WinGet, LOC_BackgroundID, ID
	Gui, 4:-MaximizeBox -MinimizeBox -Resize +Caption +Border +Owner +AlwaysOnTop +LastFound ; { Hibernate computer | Suspend computer | Force log off | Log off | Forcing computer shutdown | Shutdown computer | Forcing computer restart | Restart computer }
	Gui, 4:Margin, 20, 20
	Gui, 4:Add, Text, , % LOC_Message
	Gui, 4:Add, Button, % (PRM_YesDefaultButton ? "Default" : "") . " gPWR_DisplayConfirmationYes w80 r2 xp+50 yp+35", % " &Yes "
	Gui, 4:Add, Button, % (PRM_YesDefaultButton ? "" : "Default") . " gPWR_DisplayConfirmationNo w80 r2 xp+120", % " &No "
	GuiControl, 4:+Default, % (PRM_YesDefaultButton ? " &Yes " : " &No ")
	Gui, 4:Show, AutoSize, % LOC_Title
	WinSet, AlwaysOnTop
	If (!PRM_YesDefaultButton) {
		SendInput, {Tab}
		ControlFocus, Button2
	}
	ZZZ_DisplayConfirmationTimer(PRM_NewTimer := true, PRM_BackgroundID := LOC_BackgroundID)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ZZZ_DisplayConfirmationTimer:
ZZZ_DisplayConfirmationTimer()
Return

ZZZ_DisplayConfirmationTimer(PRM_NewTimer = false, PRM_BackgroundID = false) {

	Global ZZZ_DisplayConfirmationTimer
	Static STA_Count := 0, STA_BackgroundID := false
	If (PRM_BackgroundID) {
		STA_BackgroundID := PRM_BackgroundID
	}
	If (PRM_NewTimer) {
		STA_Count := 30
	} Else {
		STA_Count--
	}
	IfWinNotActive, ahk_group PWR_RebootPopUps
	{
		PRM_PowerManager(, PRM_State := -1)
		Return
	}
	If (STA_Count == 0) {
		PRM_PowerManager(, PRM_State := -1)
	} Else {
		SetTimer, ZZZ_DisplayConfirmationTimer, %ZZZ_DisplayConfirmationTimer%
	}
	WinSet, TransColor, % "FFFFFF " . Min(240, 240 * (30 - STA_Count) / 15), ahk_id %STA_BackgroundID%
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PWR_DisplayConfirmationYes:
PWR_DisplayConfirmationYes()
Return

PWR_DisplayConfirmationYes() {
	PRM_PowerManager()
}

PWR_DisplayConfirmationNo:
PWR_DisplayConfirmationNo()
Return

PWR_DisplayConfirmationNo() {
	PRM_PowerManager(, PRM_State := -1)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, ahk_group PWR_RebootPopUps
PWR_RebootPopUpsEscape()
Esc::PWR_RebootPopUpsEscape()

PWR_RebootPopUpsEscape() {
	PRM_PowerManager(, PRM_State := -1)
}

Left::
Right::
SendInput, {Tab}
Return

Enter::
PWR_DisplayConfirmationEnter()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PWR_DisplayConfirmationEnter() {
	Gui, 4:Default ; { Hibernate computer | Suspend computer | Force log off | Log off | Forcing computer shutdown | Shutdown computer | Forcing computer restart | Restart computer }
	ControlGetFocus, LOC_FocusedButton, A
	If (LOC_FocusedButton == "Button1") {
		PRM_PowerManager()
	} Else {
		PRM_PowerManager(, PRM_State := -1)
	}
}

#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Blue Screen Of Death { Win + ScrollLock } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PWR_BSOD:
#ScrollLock::
PWR_BSOD()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PWR_BSOD() {

	Global SCR_VirtualScreenX, SCR_VirtualScreenY, SCR_VirtualScreenWidth, SCR_VirtualScreenHeight
	SCR_DestroyMagnifier()
	, AHK_KeyWait("ScrollLock", "#")
	Sleep, 500
	SysGet, LOC_MonitorCount, 80
	LOC_MonitorCount := Max(LOC_MonitorCount, 1)
	BlockInput, MouseMove
	MouseGetPos, LOC_MouseX, LOC_MouseY
	MouseMove, 2 * SCR_VirtualScreenWidth, 2 * SCR_VirtualScreenHeight
	Loop, %LOC_MonitorCount% {
		SysGet, LOC_Monitor, Monitor, %A_Index%
		LOC_Width := LOC_MonitorRight - LOC_MonitorLeft
		, LOC_Height := LOC_MonitorBottom - LOC_MonitorTop
		, LOC_MonitorIndex := 68 + A_Index
		Gui, %LOC_MonitorIndex%:+AlwaysOnTop -Border -Caption +ToolWindow +LastFound ; GUI_BSOD
		Gui, %LOC_MonitorIndex%:Color, 0000FF
		Gui, %LOC_MonitorIndex%:Font, % "s" . (LOC_Width // 70 + 2) . " w700", Courier New
		Gui, %LOC_MonitorIndex%:Add, Text, cwhite, A problem has been detected and Windows has been shut down to prevent damage`nto your computer.`n`nThe problem seems to be caused by the following file: fcsybc02.sys`nPCI\VEN_1002&DEV_94B3&SUBSYS_0D001002&REV_00\4&1B44A02&0&0008`n`nIf this is the first time you see this error screen, restart your computer.`nIf this screen appears again, follow these steps:`n`nCheck to make sure any new hardware or software is properly installed.`nIf this is a new installation, ask your hardware or software manufacturer`nfor any Windows updates you might need.`n`nIf problems continue, remove any newly installed hardware or software.`nDisable BIOS memory options such as caching or shadowing.`nIf you need to use Safe Mode to remove or disable components,`nrestart your computer and press F8 to select Advanced Startup Options.`n`nTechnical information:`n`n*** STOP 0x00000024 (0x402daba6,0x70588b22,0x77e1a238,0x36a7faa0)`n*** fcsybc02.sys - Address 0x70e5181f base at 0x0ef130a4, Datestamp 101bc94e`n`nCollecting data for crash dump...`nPress ENTER to restart computer...
		Gui, %LOC_MonitorIndex%:Show, X%LOC_MonitorLeft% Y%LOC_MonitorTop% W%LOC_Width% H%LOC_Height%, GUI_BSOD
	}
	AHK_SetCursor()
	Input, LOC_Char, , {Enter}
	Sleep, 1000
	Loop, %LOC_MonitorCount% {
		SysGet, LOC_Monitor, Monitor, %A_Index%
		LOC_Width := LOC_MonitorRight - LOC_MonitorLeft
		, LOC_Height := LOC_MonitorBottom - LOC_MonitorTop
		, LOC_PreviousMonitorIndex := 68 + A_Index
		, LOC_MonitorIndex := 68 + LOC_MonitorCount + A_Index
		Gui, %LOC_MonitorIndex%:+AlwaysOnTop -Border -Caption +ToolWindow +LastFound ; GUI_BSOD
		Gui, %LOC_MonitorIndex%:Color, 0000FF
		Gui, %LOC_MonitorIndex%:Font, % "s" . (LOC_Width // 70 + 2) . " w700", Courier New
		Gui, %LOC_MonitorIndex%:Add, Text, cwhite, A problem has been detected and Windows has been shut down to prevent damage`nto your computer.`n`nThe problem seems to be caused by the following file: fcsybc02.sys`nPCI\VEN_1002&DEV_94B3&SUBSYS_0D001002&REV_00\4&1B44A02&0&0008`n`nIf this is the first time you see this error screen, restart your computer.`nIf this screen appears again, follow these steps:`n`nCheck to make sure any new hardware or software is properly installed.`nIf this is a new installation, ask your hardware or software manufacturer`nfor any Windows updates you might need.`n`nIf problems continue, remove any newly installed hardware or software.`nDisable BIOS memory options such as caching or shadowing.`nIf you need to use Safe Mode to remove or disable components,`nrestart your computer and press F8 to select Advanced Startup Options.`n`nTechnical information:`n`n*** STOP 0x00000024 (0x402daba6,0x70588b22,0x77e1a238,0x36a7faa0)`n*** fcsybc02.sys - Address 0x70e5181f base at 0x0ef130a4, Datestamp 101bc94e`n`nCollecting data for crash dump...`nComputer restarting...
		Gui, %LOC_MonitorIndex%:Show, X%LOC_MonitorLeft% Y%LOC_MonitorTop% W%LOC_Width% H%LOC_Height%, GUI_BSOD
		Gui, %LOC_PreviousMonitorIndex%:Destroy
	}
	SoundBeep
	Sleep, 3000
	MouseMove, LOC_MouseX, LOC_MouseY
	BlockInput, MouseMoveOff
	Loop, %LOC_MonitorCount% {
		LOC_MonitorIndex := 68 + LOC_MonitorCount + A_Index
		Gui, %LOC_MonitorIndex%:Destroy
	}
	AHK_ResetCursor()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, GUI_BSOD ahk_class AutoHotkeyGUI
!Tab::
!+Tab::
^!Delete::
LWin Up::
RWin Up::
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
