;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_Init() {
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Mouse, DoubleClickHeight, 4
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Mouse, DoubleClickSpeed, 500
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Mouse, DoubleClickWidth, 4
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Mouse, MouseSensitivity, 18
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Mouse, MouseSpeed, 1
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Mouse, MouseTrails, 2
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Mouse, SnapToDefaultButton, 1
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Keyboard, InitialKeyboardIndicators, 2
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Keyboard, KeyboardDelay, 1
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Keyboard, KeyboardSpeed, 31
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Keyboard, KeyboardDataQueueSize, 65536
	SendMessage, 0x001A, , , , ahk_id 0xFFFF ; 0x001A is WM_SETTINGCHANGE ; 0xFFFF is HWND_BROADCAST
	KBD_InitSpeedUpForSpecialHotKeys()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Delay for special keys :
;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_DelayForSpecialKeys:
F1::
KBD_DelayForSpecialKeys("F1")
Return

Insert::
KBD_DelayForSpecialKeys("Insert")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_DelayForSpecialKeys(PRM_Hotkey) {
	IfInString, PRM_Hotkey, % "$"
	{
		StringTrimLeft, PRM_Hotkey, PRM_Hotkey, 1
	}
	IfWinActive, MediaMonkey ahk_class TFMainWindow
	{
		If (PRM_Hotkey == "Insert") {
			SendInput, {Insert}
			PRM_Hotkey := ""
			Return
		}
	}
	LOC_Counter := 4
	While (LOC_Counter != 0 && GetKeyState(PRM_Hotkey, "P"))
	{
		Sleep, 50
		LOC_Counter -= 1
	}
	If (LOC_Counter == 0) {
		If (PRM_Hotkey == "F1") {
			SendInput, {%PRM_Hotkey%}
		} Else If (PRM_Hotkey == "Insert") {
			SendInput, {%PRM_Hotkey%}
			TRY_ShowTrayTip("Insert toggled")
		} Else {
			GetKeyState, LOC_KeyState, %PRM_Hotkey%, T
			If (PRM_Hotkey == "ScrollLock") {
				If (LOC_KeyState == "U") {
					SetScrollLockState, On
					TRY_ShowTrayTip("ScrollLock activated")
				} Else {
					SetScrollLockState, Off
					TRY_ShowTrayTip("ScrollLock desactivated")
				}
			}
		}
	} Else {
		APP_ShowQuickHelpTooltip()
	}
	KeyWait, %PRM_Hotkey%
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Speed up special keys :
;;;;;;;;;;;;;;;;;;;;;;;;;
KBD_InitSpeedUpForSpecialHotKeys() {

	; SC033 is ";", SC034 is ":", SC035 is "!", SC02B is "*" :
	LOC_HotKeys := "Up|^Up|+Up|!+Up|Down|^Down|+Down|!+Down|Left|+Left|!+Left|Right|+Right|!+Right|Space|BackSpace|Delete|NumPadMult|NumPadDiv|NumPadAdd|NumPadSub|NumPadDot|NumPadDel|.|;|SC033|SC034|SC035|SC02B"
	Loop, Parse, LOC_HotKeys, |
	{
		Hotkey, ~%A_LoopField%, KBD_ActivateSpeedForSpecialKeys, On B0
		Hotkey, ~%A_LoopField% Up, KBD_ReleaseSpeedForSpecialKeys, On B0
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_ActivateSpeedForSpecialKeys:
KBD_ActivateSpeedForSpecialKeys()
Return

KBD_ActivateSpeedForSpecialKeys() {
	KBD_SpeedForSpecialKeys(A_ThisHotkey, PRM_Down := true)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_ReleaseSpeedForSpecialKeys:
KBD_ReleaseSpeedForSpecialKeys()
Return

KBD_ReleaseSpeedForSpecialKeys() {
	KBD_SpeedForSpecialKeys(A_ThisHotkey, PRM_Down := false)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_SpeedForSpecialKeys(PRM_HotKey, PRM_Down = true) {

	Static STA_Down := false, STA_HotKey := ""
	IfWinActive, ahk_class Console_2_main
	{
		Return
	}
	LOC_FirstKeyDelay := 300, LOC_InterKeysDelay := 23

	If (PRM_Down) {
		LOC_Modifiers := LOC_HotKey := ""
		Loop, Parse, PRM_HotKey, , ~
		{
			If A_LoopField In !,+,^
			{
				LOC_Modifiers .= A_LoopField
			} Else {
				LOC_HotKey .= A_LoopField
			}
		}


		If (!STA_Down) {
			STA_Down := true
			, LOC_Count := 0
			Loop
			{
				LOC_Count++
				Sleep, % (LOC_Count == 1 ? LOC_FirstKeyDelay : LOC_InterKeysDelay)
				If (LOC_Count // 10 == LOC_Count / 10) {
					STA_Down := GetKeyState(LOC_HotKey)
				}
				If (!STA_Down) {
					Break
				}
				SendInput, %LOC_Modifiers%{%LOC_HotKey%}
			}
		}
	} Else {
		STA_Down := false
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Lock keyboard { Ctrl + Win + Shift + K } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_LockManager:
^#+k::
KBD_LockManager()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_LockManager(PRM_StateChanged = false, PRM_ValueChanged = false, PRM_Close = false, PRM_RefreshOnly = false) {

	Global SCR_VirtualScreenX, SCR_VirtualScreenY, SCR_VirtualScreenWidth, SCR_VirtualScreenHeight
	Static STA_LockState := false, STA_Slider, STA_Value := 4, STA_GuiID := false, STA_BackgroundGuiID := false, STA_Label, STA_ChangeLockStateButton, STA_SecondsLeft := 0

	; Lock/Unlock :
	If (PRM_StateChanged) {
		STA_LockState := (PRM_StateChanged > 0)
		If (STA_LockState) {
			STA_SecondsLeft := STA_Value * 15
			, LOC_FinalTimestamp := A_TickCount + STA_SecondsLeft * 1000
			, KBD_RefreshLockLabels()
			IfWinNotExist, ahk_id %STA_BackgroundGuiID%
			{
				Gui, 28:Destroy ; GUI_LockKeyboardBackground
				Gui, 28:-MaximizeBox -MinimizeBox +Disabled -Resize -ToolWindow -Caption -Border +Owner +LastFound +HwndSTA_BackgroundGuiID
				Gui, 28:Color, 000000
				Gui, 28:Show, x%SCR_VirtualScreenX% y%SCR_VirtualScreenY% w%SCR_VirtualScreenWidth% h%SCR_VirtualScreenHeight%, % "GUI_LockKeyboardBackground"
				WinSet, Transparent, 150, ahk_id %STA_BackgroundGuiID%
			} Else {
				Gui, 28:Show
			}
			While (A_TickCount < LOC_FinalTimestamp
				&& STA_LockState) {
				IfWinNotActive, ahk_id %STA_GuiID%
				{
					WinActivate
				}
				LOC_SecondsLeft := Round((LOC_FinalTimestamp - A_TickCount) / 1000)
				If (STA_SecondsLeft != LOC_SecondsLeft) {
					STA_SecondsLeft := LOC_SecondsLeft
					If (STA_SecondsLeft == 0) {
						Break
					}
					KBD_RefreshLockLabels()
				}
				Sleep, 100
			}
		}
		STA_LockState := false
		, STA_SecondsLeft := 0
		, KBD_RefreshLockLabels()
		Gui, 28:Hide
		Return
	}

	; Close :
	If (PRM_Close) {
		Gui, 27:Destroy ; { Unl | L } ock Keyboard
		Gui, 28:Destroy ; GUI_LockKeyboardBackground
		STA_LockState := false
		, STA_SecondsLeft := 0
		Return
	}

	; Slider value :
	If (PRM_ValueChanged) {
		GuiControlGet, STA_Value, 27:, STA_Slider
	}
	LOC_Minutes := STA_Value // 4
	LOC_Fraction := 100 * STA_Value / 4 - 100 * LOC_Minutes
	If (LOC_Fraction == 25) {
		LOC_Fraction := "¼ "
	} Else If (LOC_Fraction == 50) {
		LOC_Fraction := "½ "
	} Else If (LOC_Fraction == 75) {
		LOC_Fraction := "¾ "
	} Else {
		LOC_Fraction := ""
	}
	If (PRM_ValueChanged) {
		GuiControl, 27:, STA_Label, % "Lock keyboard for " . (LOC_Minutes > 0 ? LOC_Minutes : "") . LOC_Fraction . " minute" . (LOC_Minutes > 1 ? "s" : "")
		Return
	}

	IfWinNotExist, ahk_id %STA_GuiID%
	{
		Gui, 27:Destroy ; { Unl | L } ock Keyboard
		Gui, 27:+ToolWindow +LastFound +HwndSTA_GuiID
		Gui, 27:Margin, 10, 0
		Gui, 27:Add, Slider, ym+10 w120 h30 AltSubmit Left Range1-20 Line1 TickInterval1 ToolTip vSTA_Slider gKBD_LockTimeSliderChanged, %STA_Value%
		Gui, 27:Add, Button, % "xp+130 yp+0 w110 h30 +Center +Default vSTA_ChangeLockStateButton g" . (STA_LockState ? "KBD_SetUnlockState": "KBD_SetLockState"), % (STA_LockState ? "Unlock" : "Lock")
		Gui, 27:Add, Button, xm+250 yp+0 w110 h30 +Center +Default gKBD_LockClose, % "Close "
		Gui, 27:Add, Text, xm+0 ym+50 w280 h20 +Center vSTA_Label, % (STA_LockState ? "Keyboard locked for " . STA_SecondsLeft . " second" . (STA_SecondsLeft > 1 ? "s" : "") : "Lock keyboard for " . (LOC_Minutes > 0 ? LOC_Minutes : "") . LOC_Fraction . " minute" . (LOC_Minutes > 1 ? "s" : ""))
		Gui, 27:Show, AutoSize Center, % (STA_LockState ? "Unlock Keyboard" : "Lock Keyboard")
	} Else {
		GuiControl, 27:, STA_Label, % (STA_LockState ? "Keyboard locked for " . STA_SecondsLeft . " second" . (STA_SecondsLeft > 1 ? "s" : "") : "Lock keyboard for " . (LOC_Minutes > 0 ? LOC_Minutes : "") . LOC_Fraction . " minute" . (LOC_Minutes > 1 ? "s" : ""))
		GuiControl, 27:, STA_ChangeLockStateButton, % (STA_LockState ? "Unlock" : "Lock")
		GuiControl, % "27:+g" . (STA_LockState ? "KBD_SetUnlockState": "KBD_SetLockState"), STA_ChangeLockStateButton
		If (!PRM_RefreshOnly) {
			Gui, 27:Show, , % (STA_LockState ? "Unlock Keyboard" : "Lock Keyboard")
		}
	}
	GuiControl, % "27:" . (STA_LockState ? "Disable" : "Enable"), STA_Slider
	GuiControl, % "27:+g" . (STA_LockState ? "KBD_SetUnlockState": "KBD_SetLockState"), STA_ChangeLockStateButton
	WinSet, AlwaysOnTop, % (STA_LockState ? "On" : "Off"), ahk_id %STA_GuiID%
	WinSetTitle, ahk_id %STA_GuiID%, , % (STA_LockState ? "Unlock Keyboard" : "Lock Keyboard")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_RefreshLockLabels() {
	KBD_LockManager(, , , PRM_RefreshOnly := true)
}

KBD_LockTimeSliderChanged:
KBD_LockTimeSliderChanged()
Return

KBD_LockTimeSliderChanged() {
	KBD_LockManager(, PRM_ValueChanged := true)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_SetUnlockState:
KBD_ChangeLockState(false)
Return

KBD_SetLockState:
SetTimer, KBD_SetLockStateTimer, -1
Return

KBD_SetLockStateTimer:
KBD_ChangeLockState(true)
Return

KBD_ChangeLockState(PRM_LockState = true) {
	KBD_LockManager(PRM_StateChanged := (PRM_LockState ? 1 : -1))
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_LockClose:
KBD_LockClose()
Return

KBD_LockClose() {
	KBD_LockManager(, , PRM_Close := true)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, Lock Keyboard ahk_class AutoHotkeyGUI
Esc::
Gui, 28:Destroy ; GUI_LockKeyboardBackground
Gui, 27:Destroy ; { Unl | L } ock Keyboard
Return
Up::
Down::
PgUp::
PgDn::
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, Unlock Keyboard ahk_class AutoHotkeyGUI
LWin::
*LWin::
RWin::
*RWin::
Esc::
*Esc::
Tab::
*Tab::
Space::
*Space::
Enter::
*Enter::
NumpadEnter::
*NumpadEnter::
Left::
*Left::
Right::
*Right::
Up::
*Up::
Down::
^Down::
*Down::
PgUp::
*PgUp::
PgDn::
*PgDn::
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; History keys { Browser Back / Forward } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Browser_Back::
KBD_BackForward(false)
Return

Browser_Forward::
KBD_BackForward(true)
Return

KBD_BackForward(PRM_Direction = true) {
	If (!(KBD_CheckBackForward(PRM_Direction, PRM_ActiveWindows := "ahk_class SciTEWindow|UltraEdit|UEStudio|Notepad++|Microsoft Word ahk_class OpusApp|Microsoft Excel ahk_class XLMAIN|Adobe Photoshop ahk_class Photoshop", PRM_BackwardAction := "{Esc}^z", PRM_ForwardAction := "{Esc}^y", PRM_BackToolTip := "Undo", PRM_ForwardToolTip := "Redo")
		|| KBD_CheckBackForward(PRM_Direction, PRM_ActiveWindows := "ahk_class ShockwaveFlashFullScreen|Visionneuse de photos Picasa ahk_class ytWindow", PRM_BackwardAction := "{Left}", PRM_ForwardAction := "{Right}")
		|| KBD_CheckBackForward(PRM_Direction, PRM_ActiveWindows := "Lecteur Windows Media ahk_class WMPlayerApp|Lecteur Windows Media ahk_class WMP Skin Host", PRM_BackwardAction := "^b", PRM_ForwardAction := "^f", PRM_BackToolTip := "Previous", PRM_ForwardToolTip := "Next")
		|| KBD_CheckBackForward(PRM_Direction, PRM_ActiveWindows := "ahk_class dopus.lister|ahk_class HH Parent", PRM_BackwardAction := "!{Left}", PRM_ForwardAction := "!{Right}", PRM_BackToolTip := "Previous", PRM_ForwardToolTip := "Next")
		|| KBD_CheckBackForward(PRM_Direction, PRM_ActiveWindows := "- Eclipse ahk_class SWT_Window0", PRM_BackwardAction := "{Esc}^{Tab}", PRM_ForwardAction := "{Esc}^+{Tab}")
		|| KBD_CheckBackForward(PRM_Direction, PRM_ActiveWindows := "MediaMonkey ahk_class TFMainWindow", PRM_BackwardAction := "!{Left}", PRM_ForwardAction := "!{Right}", PRM_BackToolTip := "Previous track", PRM_ForwardToolTip := "Next track")
		|| KBD_CheckBackForward(PRM_Direction, PRM_ActiveWindows := "ahk_class DSUI:PDFXCViewer|Mozilla Thunderbird ahk_class MozillaWindowClass", PRM_BackwardAction := "{Esc}^+{Tab}", PRM_ForwardAction := "{Esc}^{Tab}")
		|| KBD_CheckBackForward(PRM_Direction, PRM_ActiveWindows := "Pale Moon ahk_class MozillaWindowClass|Mozilla Firefox ahk_class MozillaWindowClass", PRM_BackwardAction := "{Esc}{BackSpace}", PRM_ForwardAction := "{Esc}+{BackSpace}", PRM_BackToolTip := "Previous", PRM_ForwardToolTip := "Next") )) {
		If (WinActive("The Many Faces of Go - [")) {
			WinMenuSelectItem, , , Go To, % (PRM_Direction ? "Forward 1 Move" : "Back 1 Move")
			AHK_ShowToolTip(PRM_Direction ? "Next move" : "Previous move")
			Return
		}
		SendInput, % (PRM_Direction ? "Browser_Forward" : "Browser_Back")
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_CheckBackForward(PRM_Direction, PRM_ActiveWindows, PRM_BackwardAction = "", PRM_ForwardAction = "", PRM_BackToolTip = "", PRM_ForwardToolTip = "") {

	LOC_Active := false
	Loop, Parse, PRM_ActiveWindows, |
	{
		If (WinActive(A_LoopField)) {
			LOC_Active := true
			Break
		}
	}
	If (LOC_Active) {
		If (PRM_Direction && PRM_ForwardAction
			|| !PRM_Direction && PRM_BackwardAction) {
			SendInput, % (PRM_Direction ? PRM_ForwardAction : PRM_BackwardAction)
			LOC_ToolTip := (PRM_Direction ? PRM_ForwardToolTip : PRM_BackToolTip)
			If (LOC_ToolTip) {
				AHK_ShowToolTip(LOC_ToolTip)
			}
		}
		Return, true
	}
	Return, false
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Zoom { Zoom keys } :
;;;;;;;;;;;;;;;;;;;;;;


KBD_ZoomIn:
SC10B::
!SC10B::
KBD_Zoom()
Return

KBD_ZoomOut:
SC111::
!SC111::
KBD_Zoom(false)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_Zoom(PRM_ZoomIn = true) {

	Global ZZZ_KeyboardInterruption

	If (KBD_CheckZoom(PRM_ZoomIn, PRM_ActiveWindows := "ahk_class dopus.lister", PRM_ZoomInAction := "{Esc}!{Enter}")
		|| KBD_CheckZoom(PRM_ZoomIn, PRM_ActiveWindows := "UltraEdit|UEStudio|Notepad++", PRM_ZoomInAction := "{Esc}!{Up}", PRM_ZoomOutAction := "{Esc}!{Down}")
		|| KBD_CheckZoom(PRM_ZoomIn, PRM_ActiveWindows := "MediaMonkey ahk_class TFMainWindow", PRM_ZoomInAction := "{Esc}+{Enter}")
		|| KBD_CheckZoom(PRM_ZoomIn, PRM_ActiveWindows := "- Mp3 Editor Pro ahk_class TMainForm", PRM_ZoomInAction := "{Esc}{Alt Down}v{Alt Up}z", PRM_ZoomOutAction := "{Esc}{Alt Down}v{Alt Up}o")
		|| KBD_CheckZoom(PRM_ZoomIn, PRM_ActiveWindows := "ahk_class DSUI:PDFXCViewer|Pale Moon ahk_class MozillaWindowClass|Mozilla Firefox ahk_class MozillaWindowClass|Windows Internet Explorer ahk_class IEFrame|Google Chrome ahk_class Chrome_WidgetWin_1", PRM_ZoomInAction := "{Esc}^{NumPadAdd}", PRM_ZoomOutAction := "{Esc}^{NumPadSub}")
		|| KBD_CheckZoom(PRM_ZoomIn, PRM_ActiveWindows := "- Visionneuse de photos Picasa ahk_class ytWindow", PRM_ZoomInAction := "{WheelUp}", PRM_ZoomOutAction := "{WheelDown}")
		|| KBD_CheckZoom(PRM_ZoomIn, PRM_ActiveWindows := "Mozilla Thunderbird ahk_class MozillaWindowClass", PRM_ZoomInAction := "{Up}", PRM_ZoomOutAction := "{Down}")
		|| KBD_CheckZoom(PRM_ZoomIn, PRM_ActiveWindows := "Rédaction ahk_class MozillaWindowClass", PRM_ZoomInAction := "^{NumPadAdd}", PRM_ZoomOutAction := "^{NumPadSub}")
		|| KBD_CheckZoom(PRM_ZoomIn, PRM_ActiveWindows := "Lecteur Windows Media ahk_class WMPlayerApp|Lecteur Windows Media ahk_class WMP Skin Host", PRM_ZoomInAction := "!{Enter}", PRM_ZoomOutAction := "{Esc}")
		|| KBD_CheckZoom(PRM_ZoomIn, PRM_ActiveWindows := "Internet Explorer ahk_class IEFrame|ahk_class SciTEWindow", PRM_ZoomInAction := "^{NumPadAdd}", PRM_ZoomOutAction := "^{NumPadSub}")
		|| KBD_CheckZoom(PRM_ZoomIn, PRM_ActiveWindows := "ahk_class WMPTransition|ahk_class ShockwaveFlashFullScreen", , PRM_ZoomOutAction := "{Esc}")
		|| KBD_CheckZoom(PRM_ZoomIn, PRM_ActiveWindows := "KGS ahk_class SunAwtFrame", PRM_ZoomInAction := "{Left 10}", PRM_ZoomOutAction := "{Right 10}")
		|| KBD_CheckZoom(PRM_ZoomIn, PRM_ActiveWindows := "ahk_class TGoGameDieAndLiveForm", PRM_ZoomInAction := "{Esc}{Alt Down}s{Alt Up}b", PRM_ZoomOutAction := "{Esc}{Alt Down}s{Alt Up}ho")
 		|| KBD_CheckZoom(PRM_ZoomIn, PRM_ActiveWindows := "ahk_class SciTEWindow", PRM_ZoomInAction := "{Esc}^{NumpadAdd}", PRM_ZoomOutAction := "{Esc}^{NumpadSub}")
 		|| KBD_CheckZoom(PRM_ZoomIn, PRM_ActiveWindows := "The Many Faces of Go - [", PRM_ZoomInAction := "{Up}", PRM_ZoomOutAction := "{Down}", PRM_ZommInToolTip := "Next variation", PRM_ZoomOutToolTip := "Variation")
		|| KBD_CheckZoom(PRM_ZoomIn, PRM_ActiveWindows := "Word ahk_class OpusApp|ahk_class XLMAIN|PowerPoint ahk_class PP11FrameClass|Mozilla Thunderbird ahk_class MozillaWindowClass", PRM_ZoomInAction := "{Esc}^{WheelUp}", PRM_ZoomOutAction := "{Esc}^{WheelDown}")
		|| KBD_CheckZoom(PRM_ZoomIn, PRM_ActiveWindows := "Adobe Photoshop ahk_class Photoshop", PRM_ZoomInAction := "{Esc}^{NumPadAdd}", PRM_ZoomOutAction := "{Esc}^{NumPadSub}")) {
		If (WinActive("The Many Faces of Go - [")) {
			WinMenuSelectItem, , , Go To, % (PRM_ZoomIn ? "Variation" : "Next variation")
			AHK_ShowToolTip(PRM_ZoomIn ? "Variation" : "Next variation")
			Return
		}
		Return
	}

	If (WinActive("GUI_FadeOutBackground ahk_class AutoHotkeyGUI")) {
		ZZZ_KeyboardInterruption := true
		Return
	}

	SCR_ResizeMagnifier(PRM_ZoomIn ? "+WheelUp" : "+WheelDown", PRM_Resized := true)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_CheckZoom(PRM_ZoomIn, PRM_ActiveWindows, PRM_ZoomInAction = "", PRM_ZoomOutAction = "", PRM_ZommInToolTip = "", PRM_ZoomOutToolTip = "") {

	LOC_Active := false
	Loop, Parse, PRM_ActiveWindows, |
	{
		If (WinActive(A_LoopField)) {
			If (PRM_ZoomIn && PRM_ZoomInAction
				|| !PRM_ZoomIn && PRM_ZoomOutAction) {
				SendInput, % (PRM_ZoomIn ? PRM_ZoomInAction : PRM_ZoomOutAction)
				LOC_ToolTip := (PRM_ZoomIn ? PRM_ZoomInToolTip : PRM_ZoomOutToolTip)
				If (LOC_ToolTip) {
					AHK_ShowToolTip(LOC_ToolTip)
				}
			}
			Return, true
		}
	}
	Return, false
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; AutoHotKey Memo { My Favorites } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_Favorites:
SC178::
If (WinActive("GUI_FadeOutBackground ahk_class AutoHotkeyGUI")) {
	ZZZ_KeyboardInterruption := true
	Return
}
ADM_Memo()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SC178 Up:: ; "My favorites" key
ADM_Memo(false)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Process Explorer { Favorite 1 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_Favorite1:
SC173::
If (WinActive("GUI_FadeOutBackground ahk_class AutoHotkeyGUI")) {
	ZZZ_KeyboardInterruption := true
	Return
}
SendInput, {Ctrl Down}{Shift Down}{Esc}{Shift Up}{Ctrl Up}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Directory Opus { Favorite 2 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_Favorite2:
SC174::
If (WinActive("GUI_FadeOutBackground ahk_class AutoHotkeyGUI")) {
	ZZZ_KeyboardInterruption := true
	Return
}
IfWinExist, ahk_class dopus.lister
{
	WinActivate
	WinWaitActive, , , 0
} Else {
	APP_DOpus()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; UltraEdit { Favorite 3 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_Favorite3:
SC175::
If (WinActive("GUI_FadeOutBackground ahk_class AutoHotkeyGUI")) {
	ZZZ_KeyboardInterruption := true
	Return
}
GoSub, APP_UltraEdit
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Edit AHK Scripts { Favorite 4 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_Favorite4:
SC176::
Suspend, Permit
ADM_Edit()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Reload or suspend AHK { Favorite 5 [ + Control | + Alt | + Shift ] } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_Favorite5:
SC177::
Suspend, Permit
If (WinActive("GUI_FadeOutBackground ahk_class AutoHotkeyGUI")) {
	ZZZ_KeyboardInterruption := true
	Return
}
If (GetKeyState("Shift", "P")
	|| GetKeyState("Ctrl", "P")) {
	ADM_Reload()
} Else {
	GoSub, AHK_ToggleSuspend
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_MetaFavorite5:
^SC177::
+SC177::
!SC177::
If (WinActive("GUI_FadeOutBackground ahk_class AutoHotkeyGUI")) {
	ZZZ_KeyboardInterruption := true
	Return
}
ADM_Reload()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Thunderbird { Mail } :
;;;;;;;;;;;;;;;;;;;;;;;;

Launch_Mail::
KBD_LaunchMail("Launch_Mail")
Return
+Launch_Mail::
KBD_LaunchMail("+Launch_Mail")
Return
!Launch_Mail::
KBD_LaunchMail("!Launch_Mail")
Return
!+Launch_Mail::
KBD_LaunchMail("!+Launch_Mail")
Return

KBD_LaunchMail(PRM_ThisHotKey) {
	If (WinActive("GUI_FadeOutBackground ahk_class AutoHotkeyGUI")) {
		ZZZ_KeyboardInterruption := true
		Return
	}
	APP_MailManager(PRM_ThisHotKey)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Firefox { [Ctrl + ] [ Shift + ] Web } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Browser_Home::
KBD_BrowserHome("Browser_Home")
Return
+Browser_Home::
KBD_BrowserHome("+Browser_Home")
Return
^Browser_Home::
KBD_BrowserHome("^Browser_Home")
Return
^+Browser_Home::
KBD_BrowserHome("^+Browser_Home")
Return

KBD_BrowserHome(PRM_ThisHotKey) {
	If (WinActive("GUI_FadeOutBackground ahk_class AutoHotkeyGUI")) {
		ZZZ_KeyboardInterruption := true
		Return
	}
	AHK_KeyWait("!+", "Browser_Home")
	APP_FirefoxManager(PRM_ThisHotKey, PRM_Selection := TXT_GetSelectedText(), PRM_AlreadyLaunchedWarning := false)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; IE { Alt + [ Shift + ] Web } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
!Browser_Home::
If (WinActive("GUI_FadeOutBackground ahk_class AutoHotkeyGUI")) {
	ZZZ_KeyboardInterruption := true
	Return
}
APP_IE()
Return

!+Browser_Home::
If (WinActive("GUI_FadeOutBackground ahk_class AutoHotkeyGUI")) {
	ZZZ_KeyboardInterruption := true
	Return
}
APP_ShiftIE()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Search { Search } :
;;;;;;;;;;;;;;;;;;;;;

Browser_Search::
KBD_BrowserSearch()
Return

KBD_BrowserSearch() {
	WinGetClass, LOC_WindowClass, A
	If (LOC_WindowClass == "SciTEWindow") { ; SciTE editor
		SendInput, ^+f
		Return
	}
	SendInput, ^f
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; MediaMonkey { Messenger } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SC105::
SC105()
Return

SC105() {
	Global ZZZ_KeyboardInterruption, APP_MediaMonkeyPath
	If (WinActive("GUI_FadeOutBackground ahk_class AutoHotkeyGUI")) {
		ZZZ_KeyboardInterruption := true
		Return
	}
	APP_Run("MediaMonkey", APP_MediaMonkeyPath, "/NoSplash " . APP_AreFilesSelected(), A_MyDocuments, , PRM_WindowIdentification := "ahk_class TFMainWindow", PRM_AlreadyLaunchedWarning := false)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Calculator { Favorite Application 2 }
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Launch_App2::
Launch_App2()
Return

Launch_App2() {
	Global ZZZ_KeyboardInterruption
	If (WinActive("GUI_FadeOutBackground ahk_class AutoHotkeyGUI")) {
		ZZZ_KeyboardInterruption := true
		Return
	}
	APP_Run("Calculator", A_WinDir . "\system32\calc.exe", , , PRM_Maximized := false, , PRM_AlreadyLaunchedWarning := false)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Microsoft 4000 ergonomic keyboard :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AppsKey::RWin

;<^>!::
;Goto, !Volume_Up
;Return

<^>!AppsKey::
^AppsKey::
SendInput, {AppsKey}
Return

KBD_InitMicrosoftErgonomicKeyboard() {
	
	Global AHK_ScriptInfo
	Gui, 51:+Disabled +HwndLOC_GuiID ; GUI_ErgonomicKeyboard
	Gui, 51:Show, Hide, GUI_ErgonomicKeyboard

	OnMessage(WM_INPUT := 0x00FF, "KBD_ErgonomicKeyboard")
	, VarSetCapacity(LOC_RawDevice, 12)
	, NumPut(0x00000100, LOC_RawDevice, 4)
	, NumPut(WinExist("ahk_id " . LOC_GuiID), LOC_RawDevice, 8)
	, NumPut(12, LOC_RawDevice, 0, "UShort")
	, NumPut(1, LOC_RawDevice, 2, "UShort")     

	If (DllCall("RegisterRawInputDevices", "UInt", &LOC_RawDevice, "UInt", 1, "UInt", 12) == 0) {
		MsgBox, 48, Microsoft 4000 Ergonomic Keyboard - %AHK_ScriptInfo%, Registration for the Microsoft 4000 Ergonomic Keyboard failed., 3
		Return, false
	}
	Return, true
}

KBD_ErgonomicKeyboard(PRM_WParam, PRM_LParam) {

	Global AHK_ScriptInfo
	Static STA_KeyCodeLabels := false, STA_GetRawInputDataFunction := AHK_GetFunction("user32", "GetRawInputData")
	If (!STA_KeyCodeLabels) {

		STA_KeyCodeLabels := { "K0100000000050000": "KBD_Favorite1" ; Favorite1
			, "K0100000000090000": "KBD_Favorite2" ; Favorite2
			, "K0100000000110000": "KBD_Favorite3" ; Favorite3
			, "K0100000000210000": "KBD_Favorite4" ; Favorite4
			, "K0100000000410000": "KBD_Favorite5" ; Favorite5
			, "K0100000000410001": "KBD_MetaFavorite5" ; ^Favorite5
			, "K0100000000410002": "KBD_MetaFavorite5" ; +Favorite5
			, "K0100000000410004": "KBD_MetaFavorite5" ; !Favorite5
			, "K0100006700010000": "KBD_NumPadEqual" ; NumPadEqual
			, "K010000B600010000": "KBD_NumpadOpenParenthesis" ; NumPadOpenParenthesis
			, "K010000B600010001": "KBD_NumpadOpenBracket" ; ^NumPadOpenParenthesis
			, "K010000B600010002": "KBD_NumpadOpenBrace" ; +NumPadOpenParenthesis
			, "K010000B600010003": "KBD_NumpadOpenBrace" ; ^+NumPadOpenParenthesis
			, "K010000B600010004": "KBD_NumPadLookOpeningParenthesis" ; !NumPadOpenParenthesis
			, "K010000B600010005": "KBD_NumPadLookOpeningBracket" ; ^!NumPadOpenParenthesis
			, "K010000B600010006": "KBD_NumPadLookOpeningBrace" ; !+NumPadOpenParenthesis
			, "K010000B600010007": "KBD_NumPadLookOpeningBrace" ; ^!+NumPadOpenParenthesis
			, "K010000B700010000": "KBD_NumPadCloseParenthesis" ; NumPadCloseParenthesis
			, "K010000B700010001": "KBD_NumPadCloseBracket" ; ^NumPadCloseParenthesis
			, "K010000B700010002": "KBD_NumPadCloseBrace" ; +NumPadCloseParenthesis
			, "K010000B700010003": "KBD_NumPadCloseBrace" ; ^+NumPadCloseParenthesis
			, "K010000B700010004": "KBD_NumPadLookClosingParenthesis" ; !NumPadCloseParenthesis
			, "K010000B700010005": "KBD_NumPadLookClosingBracket" ; ^!NumPadCloseParenthesis
			, "K010000B700010006": "KBD_NumPadLookClosingBrace" ; !+NumPadCloseParenthesis
			, "K010000B700010007": "KBD_NumPadLookClosingBrace" ; ^!+NumPadCloseParenthesis
			, "K0121020000010000": "Browser_Search" ; Browser_Search
			, "K0123020000010000": "Browser_Home" ; Browser_Home
			, "K0123020000010001": "^Browser_Home" ; ^Browser_Home
			, "K0123020000010004": "!Browser_Home" ; !Browser_Home
			, "K0123020000010005": "^!Browser_Home" ; ^!Browser_Home
			, "K0123020000010006": "!+Browser_Home" ; !+Browser_Home
			, "K0123020000010007": "^!+Browser_Home" ; ^!+Browser_Home
			, "K0123020000010040": "!Browser_Home" ; !Browser_Home
			, "K0123020000010041": "^!Browser_Home" ; ^!Browser_Home
			, "K0123020000010060": "!+Browser_Home" ; !+Browser_Home
			, "K0123020000010070": "^!+Browser_Home" ; ^!+Browser_Home
			, "K0124020000010000": "Browser_Back" ; Browser_Back
			, "K0124020000010001": "^Browser_Back" ; ^Browser_Back
			, "K0125020000010000": "Browser_Forward" ; Browser_Forward
			, "K0125020000010001": "^Browser_Forward" ; ^Browser_Forward
			, "K012D020000010000": "KBD_ZoomIn" ; ZoomIn
			, "K012E020000010000": "KBD_ZoomOut" ; ZoomOut
			, "K0182010000010000": "KBD_Favorites" ; Favorites
			, "K018A010000010000": "Launch_Mail" ; Launch_Mail
			, "K018A010000010002": "+Launch_Mail" ; +Launch_Mail
			, "K018A010000010004": "!Launch_Mail" ; !Launch_Mail
			, "K018A010000010005": "!+Launch_Mail" ; !+Launch_Mail
			, "K0192010000010000": "Launch_App2" ; Launch_App2
			, "K01CD000000010000": "Media_Play_Pause" ; Media_Play_Pause
			, "K01CD000000010001": "APP_MediaMonkey" ; ^Media_Play_Pause
			, "K01E2000000010000": "Volume_Mute" ; Volume_Mute
			, "K01E9000000010000": "Volume_Up" ; Volume_Up
			, "K01E9000000010001": "^Volume_Up" ; ^Volume_Up
			, "K01E9000000010002": "+Volume_Up" ; +Volume_Up
			, "K01E9000000010003": "^+Volume_Up" ; ^+Volume_Up
			, "K01E9000000010004": "!Volume_Up" ; !Volume_Up
			, "K01E9000000010005": "^!Volume_Up" ; ^!Volume_Up
			, "K01E9000000010006": "!+Volume_Up" ; !+Volume_Up
			, "K01E9000000010007": "^!+Volume_Up" ; ^!+Volume_Up
			, "K01E9000000010040": "!Volume_Up" ; >!Volume_Up
			, "K01E9000000010042": "!+Volume_Up" ; <+>!Volume_Up
			, "K01E9000000010060": "!+Volume_Up" ; >!+Volume_Up
			, "K01EA000000010000": "Volume_Down" ; Volume_Down
			, "K01EA000000010001": "^Volume_Down" ; ^Volume_Down
			, "K01EA000000010002": "+Volume_Down" ; +Volume_Down
			, "K01EA000000010003": "^+Volume_Down" ; ^+Volume_Down
			, "K01EA000000010004": "!Volume_Down" ; !Volume_Down
			, "K01EA000000010005": "^!Volume_Down" ; ^!Volume_Down
			, "K01EA000000010006": "!+Volume_Down" ; !+Volume_Down
			, "K01EA000000010007": "^!+Volume_Down" ; ^!+Volume_Down
			, "K01EA000000010040": "!Volume_Down" ; >!Volume_Down
			, "K01EA000000010041": "^!Volume_Down" ; <^>!Volume_Down
			, "K01EA000000010042": "!+Volume_Down" ; <+>!Volume_Down
			, "K01EA000000010050": "^!Volume_Down" ; >^>!Volume_Down
			, "K01EA000000010060": "!+Volume_Down" } ; >!+Volume_Down

		LOC_NoFLockKeyCodeLabels := Array()
		For LOC_Code, LOC_Label In STA_KeyCodeLabels
		{
			LOC_NoFLockKeyCodeLabels[SubStr(LOC_Code, 1, 12) . (SubStr(LOC_Code, 13, 1) - 1) . SubStr(LOC_Code, 14)] := LOC_Label
		}
		For LOC_NoFLockCode, LOC_Label In LOC_NoFLockKeyCodeLabels
		{
			STA_KeyCodeLabels["" . LOC_NoFLockCode] := LOC_Label
		}
		
		LOC_FunctionPrefixs := [ "K01950000000000", "K011A0200000000", "K01790200000000" ; F1, F2, F3
			, "K01010200000000", "K01020200000000", "K01030200000000" ; F4, F5, F6
			, "K01890200000000", "K018B0200000000", "K018C0200000000" ; F7; F8, F9
			, "K01AB0100000000", "K01070200000000", "K01080200000000" ] ; F10, F11, F12
		, LOC_MetaCombinations := { "00": ""
			, "01": "^" ; <^
			, "02": "+" ; <+
			, "03": "^+"
			, "04": "!" ; <!
			, "05": "^!"
			, "06": "!+"
			, "07": "^!+"
			, "08": "#"
			, "09": "^#"
			, "0A": "+#"
			, "0B": "^+#"
			, "0C": "!#"
			, "0D": "^!#"
			, "0E": "!+#"
			, "0F": "^!+#"
			, "10": "^" ; >^
			, "11": "^"
			, "12": "^+"
			, "13": "^+"
			, "14": "^!"
			, "15": "^!"
			, "16": "^!+"
			, "17": "^!+"
			, "18": "^#"
			, "19": "^#"
			, "1A": "^+#"
			, "1B": "^+#"
			, "1C": "^!#"
			, "1D": "^!#"
			, "1E": "^!+#"
			, "1F": "^!+#"
			, "20": "+" ; >+
			, "21": "^+"
			, "22": "+"
			, "23": "^+"
			, "24": "!+"
			, "25": "^!+"
			, "26": "!+"
			, "27": "^!+"
 			, "28": "+#"
			, "29": "^+#"
			, "2A": "+#"
			, "2B": "^+#"
			, "2C": "!+#"
			, "2D": "^+!#"
			, "2E": "!+#"
			, "2F": "^!+#"
			, "30": "^+" ; >^>+
			, "31": "^+" ;
			, "32": "^+"
			, "33": "^+"
			, "34": "^!+"
			, "35": "^!+"
			, "36": "^!+"
			, "37": "^!+"
			, "38": "^+#"
			, "39": "^+#"
			, "3A": "^+#"
			, "3B": "^+#"
			, "3C": "^!+#"
			, "3D": "^+!#"
			, "3E": "^!+#"
			, "3F": "^!+#" }
			; , "40": "<^>!" ; <^>!
		For LOC_FunctionIndex, LOC_FunctionPrefix in LOC_FunctionPrefixs
		{
			For LOC_MetaSuffix, LOC_MetaCombination in LOC_MetaCombinations
			{
				STA_KeyCodeLabels[LOC_FunctionPrefix . LOC_MetaSuffix] := LOC_MetaCombination . "F" . LOC_FunctionIndex
			}
		}
	}
	
	DllCall(STA_GetRawInputDataFunction, "UInt", PRM_LParam, "UInt", 0x10000003, "UInt", 0, "UInt *", LOC_Size, "UInt", 16)
	, VarSetCapacity(LOC_Buffer, LOC_Size)
	, DllCall(STA_GetRawInputDataFunction, "UInt", PRM_LParam, "UInt", 0x10000003, "UInt", &LOC_Buffer, "UInt *", LOC_Size, "UInt", 16)
	, LOC_Type := NumGet(LOC_Buffer, 0)

	If (LOC_Type == 2) {
		LOC_SizeHID := NumGet(LOC_Buffer, 16)
		, LOC_InputCount := NumGet(LOC_Buffer, 20)
		Loop, %LOC_InputCount% {
			LOC_Address := &LOC_Buffer + 24 + ((A_Index - 1) * LOC_SizeHID)
			, LOC_KeyCode := "K" . KBD_MemoryToHexa(LOC_Address, LOC_SizeHID)
			, LOC_13KeyCode := SubStr(LOC_KeyCode, 1, 13)
			If (LOC_13KeyCode == "K010000000000"
				|| LOC_13KeyCode == "K010000000001") {
				Continue
			}
			If (LOC_KeyCode == "K0100000000020000"
				|| LOC_KeyCode == "K0100000000030000") { ; F-Lock key
				TRY_ShowTrayTip("F-Lock key pressed", 2)
				OnMessage(WM_INPUT := 0x00FF, "")
				PostMessage, 0x00FF, PRM_WParam, PRM_LParam, KBD_ErgonomicKeyboard ahk_class AutoHotkeyGUI
				Sleep, 500
				OnMessage(WM_INPUT := 0x00FF, "KBD_ErgonomicKeyboard")
				Return
			}
			LOC_Label := STA_KeyCodeLabels[LOC_KeyCode]
			If (LOC_Label) {
				If (IsLabel(LOC_Label)) {
					GoSub, % LOC_Label
				} Else {
					SendInput, {%LOC_Label%}
				}
			} Else {
				TXT_SetClipBoard(LOC_KeyCode)
				MsgBox, 64, Microsoft 4000 Ergonomic Keyboard - %AHK_ScriptInfo%, Hotkey code %LOC_KeyCode% still not configured :`nit has been copied to the clipboard., 3
			}
		}
	}
}

KBD_MemoryToHexa(PRM_Pointer, PRM_Length) {
	
	LOC_FormatInteger := A_FormatInteger
	SetFormat, Integer, Hex
	Loop, %PRM_Length% {
		LOC_Hexa := *PRM_Pointer + 0
		StringReplace, LOC_Hexa, LOC_Hexa, 0x, 0x0
		StringRight LOC_Hexa, LOC_Hexa, 2
		LOC_HexaDump .= LOC_Hexa
		, PRM_Pointer++
	}
	SetFormat, Integer, %LOC_FormatInteger%
	StringUpper, LOC_HexaDump, LOC_HexaDump
	Return, LOC_HexaDump
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Numpad extensions :
;;;;;;;;;;;;;;;;;;;;;

KBD_NumPadEqual: ; { NumpadEqual }
SendInput, =
Return

KBD_NumPadOpenParenthesis: ; { NumpadOpenParenthesis }
SendInput, (){Left}
Return

KBD_NumPadLookOpeningParenthesis: ; { Alt + NumPadOpenParenthesis }
; TODO
Return

KBD_NumPadCloseParenthesis: ; { NumPadCloseParenthesis }
SendInput, )
Return

KBD_NumPadLookClosingParenthesis: ; { Alt + NumPadCloseParenthesis }
; TODO
Return

KBD_NumPadOpenBracket: ; { Ctrl + NumpadOpenParenthesis }
SendInput, []{Left}
Return

KBD_NumPadLookOpeningBracket: ; { Ctrl + Alt + NumPadOpenParenthesis }
; TODO
Return

KBD_NumPadCloseBracket: ; { Ctrl + NumPadCloseParenthesis }
SendInput, ]
Return

KBD_NumPadLookClosingBracket: ; { Ctrl + Alt + NumPadCloseParenthesis }
; TODO
Return

KBD_NumPadOpenBrace: ; { Shift + NumpadOpenParenthesis }
SendInput, {{}{}}{Left}
Return

KBD_NumPadLookOpeningBrace: ; { Alt + Shift + NumPadOpenParenthesis }
; TODO
Return

KBD_NumPadCloseBrace: ; { Shift + NumPadCloseParenthesis }
SendInput, {}}
Return

KBD_NumPadLookClosingBrace: ; { Alt + Shift + NumPadCloseParenthesis }
; TODO
Return

KBD_BackSlash: ; { Ctrl + NumPadDiv }
^NumpadDiv::
SendInput, \
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Lock station or Hibernate :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SC116::
If (WinActive("GUI_FadeOutBackground ahk_class AutoHotkeyGUI")) {
	ZZZ_KeyboardInterruption := true
	Return
}
GoSub, PWR_LockStation
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^SC116::
+SC116::
If (WinActive("GUI_FadeOutBackground ahk_class AutoHotkeyGUI")) {
	ZZZ_KeyboardInterruption := true
	Return
}
GoSub, PWR_Hibernate
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/* Hibernate (doesn't work) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SC15F::
Sleep::
GoSub, PWR_Hibernate
Return
*/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Modified French keyboard layout :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; First row :

SC029::SendInput, {Raw}¹        ;                              ² => ¹
+SC029::SendInput, {Raw}²       ;                      Shift + ² => ²
#SC029::SendInput, {Raw}³       ;        Win +               + ² => ³
+#SC029::SendInput, {Raw}ª      ;        Win +         Shift + ² => ª
<!SC029::SendInput, {Raw}¼      ;              Alt             ² => 1/4
<^<!SC029::SendInput, {Raw}¼    ; Ctrl +       Alt             ² => 1/4
<^>!SC029::SendInput, {Raw}¼    ;              AltGr +         ² => 1/4
<!+SC029::SendInput, {Raw}½     ;              Alt   + Shift + ² => 1/2
<^<!+SC029::SendInput, {Raw}½   ; Ctrl +       Alt   + Shift + ² => 1/2
<^>!+SC029::SendInput, {Raw}½   ;              AltGr + Shift + ² => 1/2

>!&::SendInput, {Raw}¼          ;              Alt   +         1 => 1/4
<^<!&::SendInput, {Raw}¼        ; Ctrl +       Alt   +         1 => 1/4
<^>!&::SendInput, {Raw}¼        ;              AltGr +         1 => 1/4
<!+&::SendInput, {Raw}¾         ;              Alt   + Shift + 1 => 3/4
<^<!+&::SendInput, {Raw}¾       ; Ctrl +       Alt   + Shift + 1 => 3/4
<^>!+&::SendInput, {Raw}¾       ;              AltGr + Shift + 1 => 3/4
+#&::SendInput, {Raw}¾          ;        Win +         Shift + 1 => 3/4

#é::SendInput, {Raw}É           ;        Win +                 é => É
<!é::SendInput, {Raw}~%A_Space% ;              Alt   +         é => ~
<^<!é::SendInput, {Raw}~        ; Ctrl +       Alt   +         é => ~
<!+é::SendInput, {Raw}½         ;              Alt   + Shift + 2 => 1/2
<^<!+é::SendInput, {Raw}½       ; Ctrl +       Alt   + Shift + 2 => 1/2
<^>!+é::SendInput, {Raw}½       ;              AltGr + Shift + 2 => 1/2
+#é::SendInput, {Raw}½          ;        Win +         Shift + 2 => 1/2

#"::SendInput, {Raw}“           ;        Win +                 " => “
<!"::SendInput, {Raw}#          ;              Alt   +         " => #
<^<!"::SendInput, {Raw}#        ; Ctrl +       Alt   +         " => #
<!+"::SendInput, {Raw}”         ;              Alt   + Shift + " => ”
<^<!+"::SendInput, {Raw}”       ; Ctrl +       Alt   + Shift + " => ”
<^>!+"::SendInput, {Raw}”       ;              AltGr + Shift + " => ”
+#"::SendInput, {Raw}”          ;        Win +         Shift + " => ”

#'::SendInput, {Raw}‘           ;        Win +                 ' => ‘
<!'::SendInput, {Raw}{          ;              Alt   +         ' => {
<^<!'::SendInput, {Raw}{        ; Ctrl +       Alt   +         ' => {
<^>!+'::SendInput, {Raw}’       ;              AltGr + Shift + ' => ’
<^<!+'::SendInput, {Raw}’       ; Ctrl +       Alt   + Shift + ' => ’
<!+'::SendInput, {Raw}’         ;              Alt   + Shift + ' => ’
+#'::SendInput, {Raw}’          ;        Win +         Shift + ' => ’

#(::SendInput, {Raw}[           ;        Win +                 ( => [
<!(::SendInput, {Raw}[          ;              Alt   +         ( => [
<^<!(::SendInput, {Raw}[        ; Ctrl +       Alt   +         ( => [
<^>!+(::SendInput, {Raw}{       ;              AltGr + Shift + [ => {
<^<!+(::SendInput, {Raw}{       ; Ctrl +       Alt   + Shift + [ => {
<!+(::SendInput, {Raw}{         ;              Alt   + Shift + [ => {
+#(::SendInput, {Raw}{          ;        Win +         Shift + [ => {

#-::SendInput, {Raw}–           ;        Win +                 - = > –
<!-::SendInput, {Raw}|          ;              Alt   +         - = > |
<^<!-::SendInput, {Raw}|        ; Ctrl +       Alt   +         - = > |
+#-::SendInput, {Raw}—          ;        Win +         Shift + - = > —
<!+-::SendInput, {Raw}¦         ;              Alt   + Shift + - = > ¦
<^<!+-::SendInput, {Raw}¦       ; Ctrl +       Alt   + Shift + - = > ¦
<^>!+-:SendInput, {Raw}¦        ;              AltGr + Shift + - = > ¦

#è::SendInput, {Raw}È           ;        Win +                 è => È
<^<!è::SendInput, {Raw}``       ; Ctrl +       Alt   +         è => `
+#è::                           ;        Win +         Shift + è => `
<!è::                           ;              Alt   +         è => `
<^>!+è::                        ;              AltGr + Shift + è => `
<!+è::                          ;              Alt   + Shift + è => `
<^<!+è::                        ; Ctrl +       Alt   + Shift + è => `
SendInput, {Raw}````
SendInput, {BackSpace}
Return

#_::SendInput, {Raw}¯           ;        Win +                 _ => ¯
<!_::SendInput, {Raw}\          ;              Alt   +         _ => \
<^<!_::SendInput, {Raw}\        ; Ctrl +       Alt   +         _ => \
<!+_::                          ;              Alt   + Shift + \ => ´
<^<!+_::                        ; Ctrl +       Alt   + Shift + \ => ´
<^>!+_::                        ;              AltGr + Shift + \ => ´
+#_::                           ;        Win +         Shift + \ => ´
SendInput, {Raw}´´
SendInput, {BackSpace}
Return

#ç::SendInput, {Raw}Ç           ;        Win +                 ç => Ç
<!ç::SendInput, {Raw}^          ;              Alt   +         ç => ^
<^<!ç::SendInput, {Raw}^        ; Ctrl +       Alt   +         ç => ^
<!+ç::SendInput, {Raw}¬         ;              Alt   + Shift + ç => ¬
<^<!+ç::SendInput, {Raw}¬       ; Ctrl +       Alt   + Shift + ç => ¬
<^>!+ç::SendInput, {Raw}¬       ;              AltGr + Shift + ç => ¬
+#ç::SendInput, {Raw}¬          ;        Win +         Shift + ç => ¬

#à::SendInput, {Raw}À           ;        Win +                 à => À
<!à::SendInput, {Raw}^          ;              Alt   +         à => @
<^<!à::SendInput, {Raw}^        ; Ctrl +       Alt   +         à => @
<!+à::SendInput, {Raw}@         ;              Alt   + Shift + @ => @
<^<!+à::SendInput, {Raw}@       ; Ctrl +       Alt   + Shift + @ => @
<^>!+à::SendInput, {Raw}@       ;              AltGr + Shift + @ => @
+#à::SendInput, {Raw}@          ;        Win +         Shift + @ => @

#)::SendInput, {Raw}]           ;        Win +                 ) => ]
<^<!)::SendInput, {Raw}]        ; Ctrl +       Alt   +         ) => ]
<!)::SendInput, {Raw}]          ;              Alt   +         ) => ]
<^>!)::SendInput, {Raw}]        ;              AltGr +         ) => ]
<!+)::SendInput, {Raw}}         ;              Alt   + Shift + ] => }
<^<!+)::SendInput, {Raw}}       ; Ctrl +       Alt   + Shift + ] => }
<^>!+)::SendInput, {Raw}}       ;              AltGr + Shift + ] => }
+#)::SendInput, {Raw}}          ;        Win +         Shift + ] => }

#=::SendInput, {Raw}±           ;        Win +                 = => ±
<!=::SendInput, {Raw}}          ;              Alt   +         = => }
<^<!=::SendInput, {Raw}}        ; Ctrl +       Alt   +         = => }
<!+=::SendInput, {Raw}±         ;              Alt   + Shift + = => ±
<^<!+=::SendInput, {Raw}±       ; Ctrl +       Alt   + Shift + = => ±
<^>!+=::SendInput, {Raw}±       ;              AltGr + Shift + = => ±
+#=::SendInput, {Raw}‡          ;        Win +         Shift + = => ‡

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Second row :

<^>!a::SendInput, {Raw}æ       ;              AltGr +         a => æ
<^>!+a::SendInput, {Raw}Æ      ;              AltGr + Shift + A => Æ

<^>!z::SendInput, {Raw}ž       ;              AltGr +         z => ž
<^>!+z::SendInput, {Raw}Ž      ;              AltGr + Shift + Z => Ž

<^>!e::SendInput, {Raw}€       ;              AltGr +         e => €
<^>!+e::SendInput, {Raw}€      ;              AltGr + Shift + E => €

<^>!r::SendInput, {Raw}®       ;              AltGr +         r => ®
<^>!+r::SendInput, {Raw}®      ;              AltGr + Shift + R => ®

<^>!t::SendInput, {Raw}™       ;              AltGr +         t => ™
<^>!+t::SendInput, {Raw}™      ;              AltGr + Shift + T => ™

<^>!y::SendInput, {Raw}¥       ;              AltGr +         y => ¥
<^>!+y::SendInput, {Raw}¥      ;              AltGr + Shift + Y => ¥

<^>!u::SendInput, {Raw}û       ;              AltGr +         u => û
<^>!+u::SendInput, {Raw}Û      ;              AltGr + Shift + U => Û

<^>!i::SendInput, {Raw}î       ;              AltGr +         i => î
<^>!+i::SendInput, {Raw}Î      ;              AltGr + Shift + I => Î

#o::SendInput, {Raw}ø          ;        Win +                 o => ø
+#o::SendInput, {Raw}Ø         ;        Win +         Shift + O => Ø
<^>!o::SendInput, {Raw}œ       ;              AltGr +         o => œ
<^>!+o::SendInput, {Raw}Œ      ;              AltGr + Shift + O => Œ

<^>!p::SendInput, {Raw}¶       ;              AltGr +         p => ¶
<^>!+p::SendInput, {Raw}¶      ;              AltGr + Shift + p => ¶

#$::SendInput, {Raw}€          ;        Win +                 $ => €
<^>!+$::SendInput, {Raw}¥      ;              AltGr + Shift + $ => ¥

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Third row :

<^>!q::SendInput, {Raw}cul     ;              AltGr +         q => cul
<^>!+q::SendInput, {Raw}Cul    ;              AltGr + Shift + Q => Cul

<^>!#s::SendInput, {Raw}ß      ;        Win + AltGr +         s => ß
<^>!s::SendInput, {Raw}š       ;        Win + AltGr +         s => š
<^>!+s::SendInput, {Raw}Š      ;        Win + AltGr + Shift + S => Š

<^>!d::SendInput, {Raw}d       ;              AltGr +       + d => d (same)
<^>!+d::SendInput, {Raw}Ð      ;              AltGr + Shift + D => Ð

<^>!f::SendInput, {Raw}ƒ       ;              AltGr +       + f => ƒ
<^>!+f::SendInput, {Raw}ƒ      ;              AltGr + Shift + F => ƒ

<^>!g::SendInput, {Raw}j'ai    ;              AltGr +         g => j'ai
<^>!+g::SendInput, {Raw}J'ai   ;              AltGr + Shift + G => J'ai

<^>!h::SendInput, {Raw}hein    ;              AltGr +         h => hein
<^>!+h::SendInput, {Raw}Hein   ;              AltGr + Shift + H => Hein

<^>!j::SendInput, {Raw}j'y     ;              AltGr +         j => j'y
<^>!+j::SendInput, {Raw}J'y    ;              AltGr + Shift + J => J'y

<^>!k::SendInput, {Raw}cas     ;              AltGr +         k => cas
<^>!+k::SendInput, {Raw}Cas    ;              AltGr + Shift + K => Cas

<^>!l::SendInput, {Raw}elle    ;              AltGr +         l => elle
<^>!+l::SendInput, {Raw}Elle   ;              AltGr + Shift + L => Elle

<^>!m::SendInput, {Raw}même    ;              AltGr +         m => même
<^>!+m::SendInput, {Raw}Même   ;              AltGr + Shift + M => Même

#ù::                           ;        Win +                 ù => Ù
<^>!ù::                        ;              AltGr +         ù => û
<^>!+ù::                       ;              AltGr + Shift + % => ‰
<^>!#ù::                       ;        Win + AltGr +         ù => Û
If (GetKeyState("RAlt", "P")) {
	If (GetKeyState("Lwin", "P")
		|| GetKeyState("RWin", "P")) {
		SendInput, {Raw}Û
	} Else If (GetKeyState("Shift", "P")) {
		SendInput, {Raw}‰
	} Else {
		SendInput, {Raw}û
	}
} Else {
	SendInput, {ASC 0217} ; Ù
}
Return

<^>!SC02B::SendInput, {Raw}×     ;               AltGr +         * => ×
<^>!+SC02B::SendInput, {Raw}÷    ;               AltGr + Shift + * => ÷

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Fourth row :

#<::SendInput, {Raw}‹            ;        Win +                 < => ‹
<^<!<::SendInput, {Raw}‹         ; Ctrl +       Alt   +         < => ‹
+#<::SendInput, {Raw}›           ;        Win +         Shift + > => ›
<^<!+<::SendInput, {Raw}›        ; Ctrl +       Alt   +         > => ›
<^>!<::SendInput, {Raw}«         ;              AltGr +         < => «
<^>!+>::SendInput, {Raw}»        ;              AltGr + Shift + > => »

<^>!w::SendInput, {Raw}week-end  ;              AltGr +         w => week-end
<^>!+w::SendInput, {Raw}Week-end ;              AltGr + Shift + W => Week-end

<^>!x::SendInput, {Raw}×         ;              AltGr +         x => ×
<^>!+x::SendInput, {Raw}×        ;              AltGr + Shift + x => ×

<^>!c::SendInput, {Raw}¢         ;              AltGr +         c => ¢
<^>!+c::SendInput, {Raw}©        ;              AltGr +         c => ©

<^>!v::SendInput, {Raw}oui       ;              AltGr +         v => oui
<^>!+v::SendInput, {Raw}Oui      ;              AltGr + Shift + V => Oui

<^>!b::SendInput, {Raw}Þ         ;              AltGr +         b => Þ
<^>!+b::SendInput, {Raw}þ        ;              AltGr + Shift + B => þ

<^>!n::SendInput, {Raw}ñ         ;              AltGr +         n => ñ
<^>!+n::SendInput, {Raw}Ñ        ;              AltGr + Shift + N => Ñ

<^>!,::SendInput, {Raw}¸         ;              AltGr +         , => ¸
#,::SendInput, {Raw}¿            ;        Win +                 ? => ¿
<^>!+,::SendInput, {Raw}¿        ;              AltGr + Shift + ? => ¿

#;::SendInput, {Raw}…            ;        Win +                 . => …
<^<!;::SendInput, {Raw}…         ; Ctrl +       Alt   +         . => …
<^>!;::SendInput, {Raw}·         ;              AltGr +       + . => ·
<^>!+;::SendInput, {Raw}•        ;              AltGr + Shift + . => •

#SC034::SendInput, {Raw}…        ;        Win +                 : => …
<^>!SC034::SendInput, {Raw}†     ;              AltGr +         : => †
<^>!+SC034::SendInput, {Raw}‡    ;              AltGr + Shift + : => ‡

#SC035::SendInput, {Raw}¡        ;        Win +                 ! => ¡
<^>!SC035::SendInput, {Raw}¡     ;              AltGr +         ! => ¡
<^>!+SC035::SendInput, {Raw}§    ;              AltGr + Shift + § => §

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Fifth row :

<^>!Space::SendInput, % " "

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Numpad :
!NumPadAdd::SendInput, plus
!+NumPadAdd::SendInput, Plus
!NumPadSub::SendInput, moins
!+NumPadSub::SendInput, Moins
!NumPadMult::SendInput, fois
!+NumPadMult::SendInput, Fois
!NumPadDiv::SendInput, par
!+NumPadDiv::SendInput, Par
!NumPad0::SendInput, zéro
!+NumPad0::SendInput, Zéro
!NumPad1::SendInput, un
!+NumPad1::SendInput, Un
!NumPad2::SendInput, deux
!+NumPad2::SendInput, Deux
!NumPad3::SendInput, trois
!+NumPad3::SendInput, Trois
!NumPad4::SendInput, quatre
!+NumPad4::SendInput, Quatre
!NumPad5::SendInput, cinq
!+NumPad5::SendInput, Cinq
!NumPad6::SendInput, six
!+NumPad6::SendInput, Six
!NumPad7::SendInput, sept
!+NumPad7::SendInput, Sept
!NumPad8::SendInput, huit
!+NumPad8::SendInput, Huit
!NumPad9::SendInput, neuf
!+NumPad9::SendInput, Neuf
!NumpadEnter:SendInput, entrée
!+NumpadEnter::SendInput, Entrée

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
