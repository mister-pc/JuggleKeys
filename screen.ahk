;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_Init() {
	Global 	SCR_VirtualScreenX, SCR_VirtualScreenY, SCR_VirtualScreenWidth, SCR_VirtualScreenHeight, SCR_VisibleScreenX, SCR_VisibleScreenY, SCR_VisibleScreenWidth, SCR_VisibleScreenHeight, ZZZ_HexaColorPicked, ZZZ_RGBColorPicked, ZZZ_UIAutomation

	ZZZ_HexaColorPicked := ZZZ_RGBColorPicked := 0

	SysGet, SCR_VirtualScreenX, 76
	SysGet, SCR_VirtualScreenY, 77
	SysGet, SCR_VirtualScreenWidth, 78
	SysGet, SCR_VirtualScreenHeight, 79
	SysGet, LOC_MonitorCount, MonitorCount
	Loop, %LOC_MonitorCount% {
		SysGet, LOC_Monitor, MonitorWorkArea, %A_Index%
		If (A_Index == 1) {
			SCR_VisibleScreenX := LOC_MonitorLeft
			, SCR_VisibleScreenY := LOC_MonitorTop
			, SCR_VisibleScreenWidth := LOC_MonitorRight - LOC_MonitorLeft
			, SCR_VisibleScreenHeight := LOC_MonitorBottom - LOC_MonitorTop
		} Else {
			If (LOC_MonitorLeft >= SCR_VisibleScreenX + SCR_VisibleScreenWidth
				|| LOC_MonitorRight <= SCR_VisibleScreenX) {
				; Monitor to the left or right
				SCR_VisibleHeight := Min(SCR_VisibleHeight, LOC_MonitorBottom - SCR_VisibleScreenY)
				SCR_VisibleScreenY := Max(SCR_VisibleScreenY, LOC_MonitorTop)
				SCR_VisibleScreenWidth += LOC_MonitorRight - LOC_MonitorLeft
				If (LOC_MonitorRight <= SCR_VisibleScreenX) { ; monitor to the left
					SCR_VisibleScreenX := LOC_MonitorLeft
				}
			} Else {
				; Monitor to the top or bottom
				SCR_VisibleWidth := Min(SCR_VisibleWidth, LOC_MonitorRight - SCR_VisibleScreenX)
				SCR_VisibleScreenX := Max(SCR_VisibleScreenX, LOC_MonitorLeft)
				SCR_VisibleScreenHeight += LOC_MonitorBottom - LOC_MonitorTop
				If (LOC_MonitorBottom <= SCR_VisibleScreenY) { ; monitor to the bottom
					SCR_VisibleScreenY := LOC_MonitorTop
				}
			}
		}
	}

	ZZZ_UIAutomation := ComObjCreate("{ff48dba4-60ef-4201-aa87-54103eef594e}", "{30cbe57d-d9d0-452a-ab13-7ac5ac4825ee}")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Brightness { Win + AltGr + Wheel } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_LighterBrightness:
<^>!#WheelUp::
WIN_LighterBrightness()
Return

WIN_LighterBrightness() {
	WIN_AdjustBrightness(PRM_Delta := +12.75)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_DarkerBrightness:
<^>!#WheelDown::
WIN_DarkerBrightness()
Return

WIN_DarkerBrightness() {
	WIN_AdjustBrightness(PRM_Delta := -12.75)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_SetBrightness(PRM_Brightness = 128) {

	Static STA_RtlMoveMemoryFunction := AHK_GetFunction("kernel32", "RtlMoveMemory"), STA_SetDeviceGammaRampFunction := AHK_GetFunction("gdi32", "SetDeviceGammaRamp"), STA_GetDCFunction := AHK_GetFunction("user32", "GetDC"), STA_ReleaseDCFunction := AHK_GetFunction("user32", "ReleaseDC")

	Loop, % VarSetCapacity(LOC_GR, 1536) / 6
	{
		NumPut((LOC_Value := (PRM_Brightness + 128) * (A_Index - 1)) > 65535 ? 65535 : LOC_Value, LOC_GR, 2 * (A_Index - 1), "UShort")
	}
	DllCall(STA_RtlMoveMemoryFunction, "UInt", &LOC_GR + 512,  "UInt", &LOC_GR, "UInt", 512)
	, DllCall(STA_RtlMoveMemoryFunction, "UInt", &LOC_GR + 1024, "UInt", &LOC_GR, "UInt", 512)
	, DllCall(STA_SetDeviceGammaRampFunction, "UInt", DllCall(STA_GetDCFunction, "UInt", 0), "UInt", &LOC_GR)
	, DllCall(STA_ReleaseDCFunction, "UInt", 0, "UInt", 0)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_SetBrightness2(PRM_Brightness = 128) {

	Static STA_RtlMoveMemoryFunction := AHK_GetFunction("kernel32", "RtlMoveMemory"), STA_SetDeviceGammaRampFunction := AHK_GetFunction("gdi32", "SetDeviceGammaRamp"), STA_GetDCFunction := AHK_GetFunction("user32", "GetDC"), STA_ReleaseDCFunction := AHK_GetFunction("user32", "ReleaseDC")

	Loop, % VarSetCapacity(LOC_BGR, 1536) / 6
	{
		NumPut((LOC_Value := (PRM_Brightness + 128) * (A_Index - 1)) > 65535 ? 65535 : LOC_Value, LOC_BGR, 2 * (A_Index - 1), "UShort")
	}
	DllCall(STA_RtlMoveMemoryFunction, "UInt", &LOC_BGR,  "UInt", &LOC_BGR, "UInt", 512) ; blue
	, DllCall(STA_RtlMoveMemoryFunction, "UInt", &LOC_BGR + 512,  "UInt", &LOC_BGR, "UInt", 512) ; green
	, DllCall(STA_RtlMoveMemoryFunction, "UInt", &LOC_BGR + 1024, "UInt", &LOC_BGR, "UInt", 512) ; red
	, DllCall(STA_SetDeviceGammaRampFunction, "UInt", DllCall(STA_GetDCFunction, "UInt", 0), "UInt", &LOC_BGR)
	, DllCall(STA_ReleaseDCFunction, "UInt", 0, "UInt", 0)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_AdjustBrightness(PRM_Delta = 0) {
	Global WIN_Brightness
	AHK_Log("> WIN_AdjustBrightness(" . PRM_Delta . ")")
	WIN_Brightness := Round(Min(Max(0, WIN_Brightness + PRM_Delta), 255))
	, WIN_SetBrightness(WIN_Brightness)
	If (PRM_Delta != 0) {
		AHK_ShowToolTip("Brightness : " . Round(WIN_Brightness / 255 * 100) . "%")
	}
	If (PRM_Delta != 0) {
		AHK_SaveIniFile()
	}
	AHK_Log("< WIN_AdjustBrightness(" . PRM_Delta . ")")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Rulers :
;;;;;;;;;;

WIN_HorizontalRuler:
#NumpadDot::
WIN_Ruler()
Return

WIN_VerticalRuler:
^#NumpadDot::
#+NumpadDot::
!#NumpadDot::
<^>!#NumpadDot::
WIN_Ruler(false)
Return

WIN_Ruler(PRM_Horizontal = true) {
	
	Global SCR_PixelsPerMillimeter, SCR_VisibleScreenWidth, SCR_VisibleScreenHeight
	LOC_GuiThickness := (PRM_Horizontal ? 50 : 60)
	, LOC_Margin := 10
	, LOC_Gui := (PRM_Horizontal ? 8 : 9)
	, LOC_RulerScreenLength := (PRM_Horizontal ? SCR_VisibleScreenWidth : SCR_VisibleScreenHeight) - 4 * LOC_Margin
	, LOC_RulerMillimetersLength := LOC_RulerScreenLength // SCR_PixelsPerMillimeter
	Gui, %LOC_Gui%:Destroy
	Gui, %LOC_Gui%:-Caption -Resize +Owner +AlwaysOnTop +Border +LastFound
	
	Gui, %LOC_Gui%:Font, s1
	Loop, %LOC_RulerMillimetersLength% {
		LOC_Index := A_Index - 1
		LOC_Delta := (LOC_Index / 10 == LOC_Index // 10
						? 0
						: (LOC_Index / 5 == LOC_Index // 5
							? 5
							: 10))
					
		If (PRM_Horizontal) {
			Gui, %LOC_Gui%:Add, Text, % "X" . Round(LOC_Margin + A_Index * SCR_PixelsPerMillimeter) . " Y0 W1 H" . Round(LOC_GuiThickness - 2.5 * LOC_Margin - LOC_Delta) . " 0x7"
		} Else {
			Gui, %LOC_Gui%:Add, Text, % "X" . Round(3.5 * LOC_Margin + LOC_Delta) . " Y" . Round(LOC_Margin + A_Index * SCR_PixelsPerMillimeter) . " W" . Round(LOC_GuiThickness - 3.5 * LOC_Margin - LOC_Delta) . "H1 0x7"
		}
	}
	
	Gui, %LOC_Gui%:Font, s8 Bold, Courier New
	Loop, % LOC_RulerMillimetersLength // 10 + 1
	{
		If (PRM_Horizontal) {
			Gui, %LOC_Gui%:Add, Text, % "X" . Round(LOC_Margin + 10 * (A_Index - 1) * SCR_PixelsPerMillimeter - (A_Index > 10 ? 3 : 0)) . " Y" . LOC_GuiThickness - 2 * LOC_Margin . " W60 H30", % (A_Index - 1) . (A_Index == 1 ? "cm": "")
		} Else {
			Gui, %LOC_Gui%:Add, Text, % "X" . LOC_Margin . " Y" Round(LOC_Margin + 10 * (A_Index - 1) * SCR_PixelsPerMillimeter - 3) . " W20 H30 Right", % (A_Index - 1) . (A_Index == 1 ? "cm": "")
		}
	}
	
	WinSet, Transparent, 190
	LOC_GuiX := (PRM_Horizontal ? "Center" : LOC_Margin)
	, LOC_GuiY := (PRM_Horizontal ? SCR_VisibleScreenHeight - LOC_GuiThickness : LOC_Margin)
	, LOC_GuiWidth := (PRM_Horizontal ? SCR_VisibleScreenWidth - 2 * LOC_Margin : LOC_GuiThickness)
	, LOC_GuiHeight := (PRM_Horizontal ? LOC_GuiThickness : SCR_VisibleScreenHeight - 2 * LOC_Margin)
	Gui, %LOC_Gui%:Show, % "X" . LOC_GuiX . " Y" . LOC_GuiY . " W" . LOC_GuiWidth . " H" . LOC_GuiHeight, % (PRM_Horizontal ? "GUI_HorizontalRuler" : "GUI_VerticalRuler")
}

8GuiEscape:
8GuiClose:
Gui, 8:Destroy
Return

9GuiEscape:
9GuiClose:
Gui, 9:Destroy
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Mouse axis lock { AltGr } { Right-Control + AltGr } { Right-Shift + AltGr } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_MouseAxisLockPeriodicTimer:
SCR_MouseAxisLockPeriodicTimer()
Return

SCR_MouseAxisLockPeriodicTimer(PRM_Destroy = false, PRM_DistancesEnabledChanged = false) {

	; PRM_Destroy only used with shortcuts AltGr + PrintScreen
	Global SCR_VirtualScreenX, SCR_VirtualScreenY, SCR_VirtualScreenWidth, SCR_VirtualScreenHeight, ZZZ_MouseAxisLockPeriodicTimer, ZZZ_MouseAxisUnlockPeriodicTimer
	Static STA_AltGrDown := false, STA_StartX := SCR_VirtualScreenX, STA_StartY := SCR_VirtualScreenY, STA_EndX := SCR_VirtualScreenX, STA_EndY := SCR_VirtualScreenY, STA_DistancesEnabled := false, STA_RtlFillMemoryFunction := AHK_GetFunction("kernel32", "RtlFillMemory"), STA_ClipCursorFunction := AHK_GetFunction("user32", "ClipCursor"), STA_MouseTracesEnabled := SCR_MouseTracesEnabled

	LOC_AltGrState := (GetKeyState("RAlt", "P") 
		&& !GetKeyState("LWin", "P") 
		&& !GetKeyState("RWin", "P") 
		&& !GetKeyState("PrintScreen", "P"))
	If (LOC_AltGrState
		&& !PRM_Destroy) {
		CoordMode, Mouse, Screen

		; Init axes :
		;;;;;;;;;;;;;
		If (!STA_AltGrDown) {
			MouseGetPos, STA_StartX, STA_StartY
			STA_AltGrDown := true
			, STA_EndX := STA_StartX
			, STA_EndY := STA_StartY
			Gui, 11:Color, C0C0C1 ; GUI_MouseLockStartXAxis
			Gui, 11:+Lastfound -Caption -Border -Resize +AlwaysOnTop +ToolWindow +Disabled
			Gui, 11:Show, x%SCR_VirtualScreenX% y%STA_StartY% w%SCR_VirtualScreenWidth% h1 NA, GUI_MouseLockStartXAxis
			WinSet, Transparent, 100
			
			Gui, 12:Color, C0C0C1 ; GUI_MouseLockStartYAxis
			Gui, 12:+Lastfound -Caption -Border -Resize +AlwaysOnTop +ToolWindow +Disabled
			Gui, 12:Show, x%STA_StartX% y%SCR_VirtualScreenY% w1 h%SCR_VirtualScreenHeight% NA, GUI_MouseLockStartYAxis
			WinSet, Transparent, 100
			
			Gui, 13:Color, FF0074 ; GUI_MouseLockStartPoint
			Gui, 13:+Lastfound -Caption -Border -Resize +AlwaysOnTop +ToolWindow +Disabled
			Gui, 13:Show, % "x" . (STA_StartX - 2) . " y" . (STA_StartY - 2) . " w5 h5 NA", GUI_MouseLockStartPoint
			WinSet, Transparent, 150
			
			Gui, 14:Color, C0C0C1 ; GUI_MouseLockEndXAxis
			Gui, 14:+Lastfound -Caption -Border -Resize +AlwaysOnTop +ToolWindow +Disabled
			Gui, 14:Show, x%SCR_VirtualScreenX% y%STA_EndY% w%SCR_VirtualScreenWidth% h1 NA, GUI_MouseLockEndXAxis
			WinSet, Transparent, 0
			
			Gui, 15:Color, C0C0C1 ; GUI_MouseLockEndYAxis
			Gui, 15:+Lastfound -Caption -Border -Resize +AlwaysOnTop +ToolWindow +Disabled
			Gui, 15:Show, x%STA_EndX% y%SCR_VirtualScreenY% w1 h%SCR_VirtualScreenHeight% NA, GUI_MouseLockEndYAxis
			Gui, 16:Color, 004080
			WinSet, Transparent, 0
			
			Gui, 16:+Lastfound -Caption -Border -Resize +AlwaysOnTop +ToolWindow +Disabled ; GUI_MouseLockEndPoint
			Gui, 16:Show, % "x" . (STA_EndX - 2) . " y" . (STA_EndY - 2) . " w5 h5 NA", GUI_MouseLockEndPoint
			WinSet, Transparent, 0
		} Else {
			If (PRM_DistancesEnabledChanged) {
				STA_DistancesEnabled := !STA_DistancesEnabled
				If (STA_DistancesEnabled) {
					Gui, 14:Show, x%SCR_VirtualScreenX% y%STA_EndY% w%SCR_VirtualScreenWidth% h1 NA, GUI_MouseLockEndXAxis
					Gui, 15:Show, x%STA_EndX% y%SCR_VirtualScreenY% w1 h%SCR_VirtualScreenHeight% NA, GUI_MouseLockEndYAxis
					Gui, 16:Show, % "x" . (STA_EndX - 2) . " y" . (STA_EndY - 2) . " w5 h5 NA", GUI_MouseLockEndPoint
				} Else {
					STA_StartX := STA_EndX
					, STA_StartY := STA_EndY
					Gui, 11:Show, x%SCR_VirtualScreenX% y%STA_StartY% w%SCR_VirtualScreenWidth% h1 NA, GUI_MouseLockStartXAxis
					Gui, 12:Show, x%STA_StartX% y%SCR_VirtualScreenY% w1 h%SCR_VirtualScreenHeight% NA, GUI_MouseLockStartYAxis
					Gui, 13:Show, % "x" . (STA_StartX - 2) . " y" . (STA_StartY - 2) . " w5 h5 NA", GUI_MouseLockStartPoint
					STA_DistancesEnabled := true
				}
				Gui, 14:+LastFound
				WinSet, Transparent, % (STA_DistancesEnabled ? 255 : 0)
				Gui, 15:+LastFound
				WinSet, Transparent, % (STA_DistancesEnabled ? 255 : 0)
				Gui, 16:+LastFound
				WinSet, Transparent, % (STA_DistancesEnabled ? 150 : 0)
				GoSub, AHK_HideWindowToolTip
			}
		}

		LOC_PointMoved := false
		, LOC_RectangleLeft := SCR_VirtualScreenX
		, LOC_RectangleRight := SCR_VirtualScreenX + SCR_VirtualScreenWidth
		, LOC_RectangleTop := SCR_VirtualScreenY
		, LOC_RectangleBottom := SCR_VirtualScreenY + SCR_VirtualScreenHeight
		MouseGetPos, LOC_MouseX, LOC_MouseY

		Gui, % (STA_DistancesEnabled ? 14 : 11) . ":+Lastfound" ; GUI_MouseLockEndXAxis : GUI_MouseLockStartXAxis
 		If (GetKeyState("RShift", "P")) {
			WinSet, Transparent, 100
			LOC_RectangleLeft := STA_EndX - 1
			, LOC_RectangleRight := STA_EndX + 1
		} Else {
			WinSet, Transparent, 255
			WinSet, Transparent, Off
			LOC_PointMoved |= (STA_EndX != LOC_MouseX)
			, STA_EndX := LOC_MouseX
		}

		Gui, % (STA_DistancesEnabled ? 15 : 12) . ":+Lastfound" ; GUI_MouseLockEndYAxis : GUI_MouseLockStartYAxis
 		If (GetKeyState("RCtrl", "P")) {
			WinSet, Transparent, 100
			LOC_RectangleTop := STA_EndY - 1
			, LOC_RectangleBottom := STA_EndY + 1
		} Else {
			WinSet, Transparent, 255
			WinSet, Transparent, Off
			LOC_PointMoved |= (STA_EndY != LOC_MouseY)
			, STA_EndY := LOC_MouseY
		}

		MouseMove, %STA_EndX%, %STA_EndY%
		If (LOC_PointMoved) {
			VarSetCapacity(LOC_Rectangle, 16)
			Loop, 4 {
			  DllCall(STA_RtlFillMemoryFunction, "UInt", &LOC_Rectangle + A_Index - 1, "UInt", 1, "UChar", LOC_RectangleLeft   >> 8 * A_Index - 8)
			  , DllCall(STA_RtlFillMemoryFunction, "UInt", &LOC_Rectangle +  4 + A_Index - 1, "UInt", 1, "UChar", LOC_RectangleTop    >> 8 * A_Index - 8)
			  , DllCall(STA_RtlFillMemoryFunction, "UInt", &LOC_Rectangle +  8 + A_Index - 1, "UInt", 1, "UChar", LOC_RectangleRight  >> 8 * A_Index - 8)
			  , DllCall(STA_RtlFillMemoryFunction, "UInt", &LOC_Rectangle + 12 + A_Index - 1, "UInt", 1, "UChar", LOC_RectangleBottom >> 8 * A_Index - 8)
			}
			DllCall(STA_ClipCursorFunction, "UInt", &LOC_Rectangle)
			If (STA_DistancesEnabled) {
				Gui, 14:Show, x%SCR_VirtualScreenX% y%STA_EndY% w%SCR_VirtualScreenWidth% h1 NA, GUI_MouseLockEndXAxis
				Gui, 15:Show, x%STA_EndX% y%SCR_VirtualScreenY% w1 h%SCR_VirtualScreenHeight% NA, GUI_MouseLockEndYAxis
				Gui, 16:Show, % "x" . (STA_EndX - 2) . " y" . (STA_EndY - 2) . " w5 h5 NA", GUI_MouseLockEndPoint
			} Else {
				STA_StartX := STA_EndX
				, STA_StartY := STA_EndY
				Gui, 11:Show, x%SCR_VirtualScreenX% y%STA_StartY% w%SCR_VirtualScreenWidth% h1 NA, GUI_MouseLockStartXAxis
				Gui, 12:Show, x%STA_StartX% y%SCR_VirtualScreenY% w1 h%SCR_VirtualScreenHeight% NA, GUI_MouseLockStartYAxis
				Gui, 13:Show, % "x" . (STA_StartX - 2) . " y" . (STA_StartY - 2) . " w5 h5 NA", GUI_MouseLockStartPoint
			}
		}
		If (STA_DistancesEnabled) {
			AHK_ShowWindowToolTip(PRM_X := STA_StartX, PRM_Y := STA_StartY, PRM_Width := STA_EndX - STA_StartX, PRM_Height := STA_EndY - STA_StartY, , , PRM_Text := "   Left-Click`t: new origin`n+ Right-Control`t: horizontal lock`n+ Right-Shift`t: vertical lock`n+ NumPad`t: fine move", PRM_HiddenWindowEnabled := true, , PRM_Distance := true)
		} Else {
			AHK_ShowToolTip(PRM_ToolTipText := "(" . STA_StartX . ", " . STA_StartY . ")`n`n   Left-Click`t: origin lock`n+ Right-Control`t: horizontal lock`n+ Right-Shift`t: vertical lock`n+ NumPad`t: fine move")
		}
		SetTimer, SCR_MouseAxisLockPeriodicTimer, %ZZZ_MouseAxisUnlockPeriodicTimer%
	} Else {
		If (STA_AltGrDown) {
			Gui, 11:Destroy ; GUI_MouseLockStartXAxis
			Gui, 12:Destroy ; GUI_MouseLockStartYAxis
			Gui, 14:Destroy ; GUI_MouseLockEndXAxis
			Gui, 15:Destroy ; GUI_MouseLockEndYAxis
			Gui, 13:Destroy ; GUI_MouseLockStartPoint
			Gui, 16:Destroy ; GUI_MouseLockEndPoint
			STA_AltGrDown := STA_DistancesEnabled := false
			, DllCall(STA_ClipCursorFunction)
			GoSub, AHK_HideWindowToolTip
		}
		SetTimer, SCR_MouseAxisLockPeriodicTimer, %ZZZ_MouseAxisLockPeriodicTimer%
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

<^>!LButton::
<^>!NumPad5::
<^>!>+LButton::
<^>^>!LButton::
<^>^>!>+LButton::
SCR_AltGrClick()
Return

SCR_AltGrClick() {
	IfWinExist, GUI_MouseLockStartXAxis ahk_class AutoHotkeyGUI
	{
		SCR_MouseAxisLockPeriodicTimer(, PRM_DistancesEnabledChanged := true)
	} Else {
		If (A_ThisHotKey == "<^>!LButton") {
			SendInput, {LControl Down}{RAlt Down}{Click}{LControl Up}{RAlt Up}
		} Else
		If (A_ThisHotKey == "<^>!>+LButton") {
			SendInput, {LControl Down}{RAlt Down}{RShift Down}{Click}{LControl Up}{RAlt Up}{RShift Up}
		} Else
		If (A_ThisHotKey == "<^>^>!LButton") {
			SendInput, {Control Down}{RAlt Down}{Click}{Control Up}{RAlt Up}
		} Else
		If (A_ThisHotKey == "<^>^>!>+LButton") {
			SendInput, {Control Down}{RAlt Down}{RShift Down}{Click}{Control Up}{RAlt Up}{RShift Up}
		} Else
		If (A_ThisHotKey == "<^>!LButton") {
			SendInput, {LControl Down}{RAlt Down}5{LControl Up}{RAlt Up}
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Capture entire desktop { [ Alt + ] PrintScreen } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_TrayMenuDesktopClipBoardShot:
Sleep, 300

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_DesktopClipBoardShot:
#IfWinNotActive, SnagIt ahk_class SnagIt5UI
PrintScreen::
SCR_DesktopClipBoardShot()
Return

SCR_DesktopClipBoardShot() {
	SCR_CaptureManager(PRM_EntireDesktop := 0, PRM_Cursor := false, PRM_SaveToFile := false)
}
#IfWinNotActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_TrayMenuDesktopFileShot:
Sleep, 300
SCR_DesktopFileShot:
<!PrintScreen::
SCR_DesktopFileShot()
Return

SCR_DesktopFileShot() {
	SCR_CaptureManager(PRM_EntireDesktop := 0, PRM_Cursor := false, PRM_SaveToFile := true)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Capture entire desktop with cursor { [ Alt + ] Shift + PrintScreen } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_TrayMenuDesktopCursorClipBoardShot:
Sleep, 300
SCR_DesktopCursorClipBoardShot:
+PrintScreen::
SCR_DesktopCursorClipBoardShot()
Return

SCR_DesktopCursorClipBoardShot() {
	SCR_CaptureManager(PRM_EntireDesktop := 0, PRM_Cursor := true, PRM_SaveToFile := false, PRM_SecondsToWait := 3)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_TrayMenuDesktopCursorFileShot:
Sleep, 300
SCR_DesktopCursorFileShot:
<!+PrintScreen::
SCR_DesktopCursorFileShot()
Return

SCR_DesktopCursorFileShot() {
	SCR_CaptureManager(PRM_EntireDesktop := 0, PRM_Cursor := true, PRM_SaveToFile := true, PRM_SecondsToWait := 3)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Capture active window { Win + [ Alt + ] PrintScreen } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_TrayMenuWindowClipBoardShot:
Sleep, 300
SCR_WindowClipBoardShot:
#PrintScreen::
SCR_WindowClipBoardShot()
Return

SCR_WindowClipBoardShot() {
	SCR_CaptureManager(PRM_ActiveWindow := 1, PRM_Cursor := false, PRM_SaveToFile := false)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_TrayMenuWindowFileShot:
Sleep, 300
SCR_WindowFileShot:
SCR_WindowFileShot()
Return

SCR_WindowFileShot() {
	SCR_CaptureManager(PRM_ActiveWindow := 1, PRM_Cursor := false, PRM_SaveToFile := true)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Capture active window with cursor { Win + [ Alt + ] Shift + PrintScreen } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_TrayMenuWindowCursorClipBoardShot:
Sleep, 300
SCR_WindowCursorClipBoardShot:
+#PrintScreen::
SCR_WindowCursorClipBoardShot()
Return

SCR_WindowCursorClipBoardShot() {
	SCR_CaptureManager(PRM_ActiveWindow := 1, PRM_Cursor := true, PRM_SaveToFile := false, PRM_SecondsToWait := 3)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_TrayMenuWindowCursorFileShot:
Sleep, 300
SCR_WindowCursorFileShot:
#<!+PrintScreen::
SCR_WindowCursorFileShot()
Return

SCR_WindowCursorFileShot() {
	SCR_CaptureManager(PRM_ActiveWindow := 1, PRM_Cursor := true, PRM_SaveToFile := true, PRM_SecondsToWait := 3)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Capture zone { Ctrl + [ Alt + ] + PrintScreen } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_ZoneClipBoardShot:
^PrintScreen::
SCR_ZoneClipBoardShot()
Return

SCR_ZoneClipBoardShot() {
	If ((LOC_Rectangle := SCR_DrawRectangle("Screenshot > Clipboard")) != "canceled") {
		SCR_CaptureManager(LOC_Rectangle, PRM_Cursor := false, PRM_SaveToFile := false)
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_ZoneFileShot:
<^<!PrintScreen::
SCR_ZoneFileShot()
Return

SCR_ZoneFileShot() {
	If ((LOC_Rectangle := SCR_DrawRectangle("Screenshot > File")) != "canceled") {
		SCR_CaptureManager(LOC_Rectangle, PRM_Cursor := false, PRM_SaveToFile := true)
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Capture zone with cursor { Ctrl + [ Alt + ] Shift + PrintScreen } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_ZoneCursorClipBoardShot:
^+PrintScreen::
SCR_ZoneCursorClipBoardShot()
Return

SCR_ZoneCursorClipBoardShot() {
	If ((LOC_Rectangle := SCR_DrawRectangle("Screenshot (+ Cursor) > Clipboard")) != "canceled") {
		Sleep, 500
		SCR_CaptureManager(LOC_Rectangle, PRM_Cursor := true, PRM_SaveToFile := false, PRM_SecondsToWait := 3)
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_ZoneCursorFileShot:
<^<!+PrintScreen::
SCR_ZoneCursorFileShot()
Return

SCR_ZoneCursorFileShot() {
	If ((LOC_Rectangle := SCR_DrawRectangle("Screenshot (+ Cursor) > File")) != "canceled") {
		Sleep, 500
		SCR_CaptureManager(LOC_Rectangle, PRM_Cursor := true, PRM_SaveToFile := true, PRM_SecondsToWait := 3)
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Screenshot region rectangle :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_DrawRectangle(PRM_Title = "") {
	Global SCR_VirtualScreenX, SCR_VirtualScreenWidth, SCR_VirtualScreenY, SCR_VirtualScreenHeight, AHK_LeftMouseButtonHookEnabled
	Hotkey, LButton, Off
	CoordMode, Mouse, Screen
	Gui, 24:Destroy ; GUI_ScreenshotFlash
	Gui, 40:Destroy ; { Unicode | ASCII } Art Capture
	Gui, 20:Color, C0C0C1 ; GUI_ScreenshotStartXAxis
	Gui, 20:+Lastfound -Caption -Border -Resize +AlwaysOnTop +ToolWindow +Disabled

	Gui, 21:Color, C0C0C1 ; GUI_ScreenshotStartYAxis
	Gui, 21:-Caption -Border -Resize +AlwaysOnTop +ToolWindow +Disabled
	While (!GetKeyState("LButton", "P")) {
		If (GetKeyState("Esc", "P")) {
			Gui, 20:Destroy
			Gui, 21:Destroy
			AHK_HideToolTip()
			Hotkey, LButton, % (AHK_LeftMouseButtonHookEnabled ? "On" : "Off")
			Return, "canceled"
		}
		MouseGetPos, LOC_X, LOC_Y
		Gui, 20:Show, x%SCR_VirtualScreenX% y%LOC_Y% w%SCR_VirtualScreenWidth% h1, % "GUI_ScreenshotStartXAxis"
		Gui, 21:Show, x%LOC_X% y%SCR_VirtualScreenY% w1 h%SCR_VirtualScreenHeight%, % "GUI_ScreenshotStartYAxis"
		AHK_ShowToolTip((PRM_Title ? PRM_Title . ": " : "") . "(" . LOC_X . ", " . LOC_Y . ")`n`n Press down the mouse button to start the capture,` `n Drag the mouse to define the region")
		Sleep, 20
	}
	Gui, 20:Destroy ; GUI_ScreenshotStartXAxis
	Gui, 21:Destroy ; GUI_ScreenshotStartYAxis
	Gui, 22:+Lastfound -Caption +Border -Resize +AlwaysOnTop +ToolWindow +Disabled ; GUI_ScreenshotRectangle
	Gui, 22:Color, C0C0C1  ; Creates a grey colored drag zone
	WinSet, TransColor, C0C0C0 100
	LOC_FirstX := LOC_X
	, LOC_FirstY := LOC_Y
	Loop
	{
		If (GetKeyState("Esc", "P")) {
			Gui, 22:Destroy ; GUI_ScreenshotRectangle
			AHK_HideToolTip()
			Hotkey, LButton, % (AHK_LeftMouseButtonHookEnabled ? "On" : "Off")
			Return, "canceled"
		}
		MouseGetPos, LOC_X, LOC_Y
		LOC_StartX := Min(LOC_X, LOC_FirstX)
		, LOC_StartY := Min(LOC_Y, LOC_FirstY)
		, LOC_Width := abs(LOC_FirstX - LOC_X)
		, LOC_Height := abs(LOC_FirstY - LOC_Y)
		Gui, 22:Show, x%LOC_StartX% y%LOC_StartY% w%LOC_Width% h%LOC_Height%, GUI_ScreenshotRectangle
		LOC_Width++
		, LOC_Height++
		AHK_ShowWindowToolTip(LOC_StartX, LOC_StartY, LOC_Width, LOC_Height, PRM_Prefix := PRM_Title, , "`n Drag the mouse to define the region,`n Release the mouse button to finish the capture ` ")

		If (!GetKeyState("LButton", "P")) {
			Break
		}
		Sleep, 100
	}
	Loop, 5	{
		Gui, % (19 + A_Index) . ":Destroy" ; GUI_ScreenshotRectangle
	}
	AHK_HideWindowToolTip()
	Hotkey, LButton, % (AHK_LeftMouseButtonHookEnabled ? "On" : "Off")
	Return, LOC_StartX . ", " . LOC_StartY . ", " . (LOC_StartX + LOC_Width) . ", " . (LOC_StartY + LOC_Height)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Screenshot result :
;;;;;;;;;;;;;;;;;;;;;

SCR_DisplayPicture(PRM_File, PRM_Left, PRM_Top, PRM_Width, PRM_Height) {

	Global AHK_AudioEnabled, SCR_VirtualScreenX, SCR_VirtualScreenY, SCR_VirtualScreenWidth, SCR_VirtualScreenHeight
	Gui, 24:-Caption -Border -Resize +AlwaysOnTop +ToolWindow +Disabled +MinSize%SCR_VirtualScreenWidth%x%SCR_VirtualScreenHeight% ; GUI_ScreenshotFlash
	Gui, 24:Color, FFFFED
	Gui, 24:Show, x%SCR_VirtualScreenX% y%SCR_VirtualScreenY% w%SCR_VirtualScreenWidth% h%SCR_VirtualScreenHeight%, GUI_ScreenshotFlash
	Sleep, 5
	Gui, 24:Destroy
	If (AHK_AudioEnabled) {
		Try {
			SoundPlay, %A_ScriptDir%\media\screenshot.wav
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "SCR_DisplayPicture", PRM_File, PRM_Left, PRM_Top, PRM_Width, PRM_Height)
		}
	}

	LOC_MinimumWidth := 220
	Gui, 25:Destroy ; Screenshot
	Gui, 25:+Border -MaximizeBox -MinimizeBox -Resize +LastFound +HwndLOC_WindowID
	LOC_ScreenShotTooSmall := (PRM_Width < LOC_MinimumWidth)
	If (LOC_ScreenShotTooSmall) {
		LOC_WindowWidth := Max(PRM_Width, LOC_MinimumWidth)
		, LOC_X := (LOC_WindowWidth - PRM_Width) // 2
		, LOC_FinalRatio := 1
		Gui, 25:Add, Picture, x%LOC_X% y0 w%PRM_Width% h%PRM_Height%, %PRM_File%
	} Else {
		LOC_Ratio := max(0.1, Round(min(min(PRM_Width, SCR_VirtualScreenWidth // 1.5) / PRM_Width
							, min(PRM_Height, SCR_VirtualScreenHeight // 1.5) / PRM_Height), 1))
		, LOC_FinalWidth := Round(PRM_Width * LOC_Ratio)
		, LOC_FinalHeight := Round(PRM_Height * LOC_Ratio)
		Gui, 25:Add, Picture, x0 y0 w%LOC_FinalWidth% h%LOC_FinalHeight%, %PRM_File%
	}
	Gui, 25:Margin, 0, 0
	Gui, 25:Add, StatusBar, , % "(" . PRM_Left . ", " . PRM_Top . ") » (" . (PRM_Left + PRM_Width) . ", " . (PRM_Top + PRM_Height) . ")     " . PRM_Width . " × " . PRM_Height . (LOC_Ratio < 1 ? "     [" . Round(LOC_Ratio * 100) . " %]" : "") . "  "
	Gui, 25:Show, AutoSize Center, Screenshot
	If (LOC_ScreenShotTooSmall) {
		Gui, 25:Show, w%LOC_WindowWidth% Center, Screenshot
	}
}

25GuiClose:
25GuiEscape:
Gui, 25:Destroy
Return

22GuiClose:
22GuiEscape:
Gui, 22:Destroy
GoSub, AHK_HideWindowToolTip
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Screenshot file selection dialog :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_SelectFile() {

	Global AHK_ScriptInfo
	Loop
	{
		FileSelectFile, LOC_File, S, %A_Desktop%\screenshot.jpg, Save screenshot, Images (*.bmp; *.jpg; *.png; *.gif; *.tif)
		If (LOC_File && FileExist(LOC_File)) {
			MsgBox, 51, Save screenshot - %AHK_ScriptInfo%, The selected file '%LOC_File%' already exists.`nDo you want to overwrite it ? ; Yes/No/Cancel buttons
			IfMsgBox, Yes
			{
				Break
			}
		} Else {
			Break
		}
	}
	If (LOC_File != "") {
		LOC_Extension := SubStr(LOC_File, InStr(PRM_Haystack := LOC_File, PRM_Needle := ".", PRM_CaseSensitive := false, PRM_StartingPos := 0) + 1)
		, LOC_Extensions := "bmp|jpg|png|gif|tif"
		Loop, Parse, LOC_Extensions, |
		{
			If (A_LoopField == LOC_Extension) {
				LOC_Extensions := ""
				Break
			}
		}
		If (LOC_Extensions != "") {
			LOC_File .= ".jpg"
		}
	}
	Return, LOC_File
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Screenshot capture :
;;;;;;;;;;;;;;;;;;;;;;

SCR_CaptureManager(PRM_Rectangle = 0, PRM_Cursor = false, PRM_SaveToFile = false, PRM_SecondsToWait = 0) {
	/*
	1) If PRM_Rectangle is 0/1/2/3, captures 0:entire desktop / 1:active window / 2:active client area / 3:active monitor.
		 PRM_Rectangle can be comma delimited sequence of coordinates, e.g., "Left, Top, Right, Bottom" or "Left, Top, Right, Bottom, Width_Zoomed, Height_Zoomed".
		 In this case, only that portion of the rectangle will be captured. Additionally, in the latter case, resized to the new Width_Zoomed/Height_Zoomed.
	2) If the optional parameter PRM_Cursor is True, captures the cursor too.
	3) If the optional parameter PRM_SaveToFile is true, save the image to a file (BMP/JPG/PNG/GIF/TIF), else set it to the ClipBoard.
	4) The optional parameter PRM_Quality is applicable only when PRM_SaveToFile is JPG. Set it to the desired quality level of the resulting JPG, an integer between 0 - 100.
	5) PRM_SecondsToWait displays a countdown before taking picture.
	Examples:
	CaptureScreen(0)
	CaptureScreen(1)
	CaptureScreen(2)
	CaptureScreen(3)
	CaptureScreen("100, 100, 200, 200")
	CaptureScreen("100, 100, 200, 200, 400, 400")   ; Zoomed
	*/
	Global AHK_ScriptName
	Static STA_SecondsToWait := 0
	If (PRM_Rectangle == "canceled") {
		Return
	}
	Gui, 24:Destroy ; GUI_ScreenshotFlash
	If (PRM_SecondsToWait = 0) {
		Sleep, 1000
	} Else {
		Gui, 23:+LastFound -Caption +Border +Resize +AlwaysOnTop +ToolWindow +Disabled +E0x00000100L ; GUI_ScreenshotCountdown
		Gui, 23:Margin, 20, 20
		Gui, 23:Color, EEEEEE
		WinSet, TransColor, EEEEED 200
		Gui, 23:Font, s48 Bold w1000 cRed
		Gui, 23:Add, Text, BackgroundTrans vSTA_SecondsToWait, %PRM_SecondsToWait%
		Gui, 23:Show, AutoSize Center, GUI_ScreenshotCountdown
		Loop, % PRM_SecondsToWait * 10
		{
			If (A_Index / 10 == Round(A_Index / 10)) {
				GuiControl, 23:Text, STA_SecondsToWait, % (PRM_SecondsToWait - A_Index / 10)
			}
			Sleep, 100
		}
		Sleep, 250
		Gui, 23:Destroy
	}

	If  (!PRM_Rectangle) {
		SysGet, LOC_Left, 76
		SysGet, LOC_Top, 77
		SysGet, LOC_Width, 78
		SysGet, LOC_Height, 79
	} Else If (PRM_Rectangle == 1) {
		WinGetPos, LOC_Left, LOC_Top, LOC_Width, LOC_Height, A
	} Else If (PRM_Rectangle == 2) {
		WinGet, LOC_ActiveWindowID, ID, A
		VarSetCapacity(rt, 16, 0)
		, DllCall("user32.dll\GetClientRect" , "UInt", LOC_ActiveWindowID, "UInt", &rt)
		, DllCall("user32.dll\ClientToScreen", "UInt", LOC_ActiveWindowID, "UInt", &rt)
		, LOC_Left := NumGet(rt, 0, "Int")
		, LOC_Top := NumGet(rt, 4, "Int")
		, LOC_Width := NumGet(rt, 8)
		, LOC_Height := NumGet(rt, 12)
	} Else If (PRM_Rectangle == 3) {
		VarSetCapacity(mi, 40, 0)
		, DllCall("user32.dll\GetCursorPos", "Int64P", pt)
		, DllCall("user32.dll\GetMonitorInfo", "UInt", DllCall("user32.dll\MonitorFromPoint", "Int64", pt, "UInt", 2), "UInt", NumPut(40, mi) - 4)
		, LOC_Left := NumGet(mi, 4, "Int")
		, LOC_Top := NumGet(mi, 8, "Int")
		LOC_Width := NumGet(mi,12, "Int") - LOC_Left
		, LOC_Height := NumGet(mi,16, "Int") - LOC_Top
	} Else {
		StringSplit, LOC_Rectangle, PRM_Rectangle, `,, %A_Space%%A_Tab%
		LOC_Left := LOC_Rectangle1
		, LOC_Top := LOC_Rectangle2
		, LOC_Width := LOC_Rectangle3 - LOC_Rectangle1
		, LOC_Height := LOC_Rectangle4 - LOC_Rectangle2
		, LOC_WidthZoomed := LOC_Rectangle5
		, LOC_HeightZoomed := LOC_Rectangle6
	}

	mDC := DllCall("gdi32.dll\CreateCompatibleDC", "UInt", 0)
	, LOC_BitMap := SCR_CreateDIBSection(LOC_Width, LOC_Height, mDC)
	, oBM := DllCall("gdi32.dll\SelectObject", "UInt", mDC, "UInt", LOC_BitMap)
	, LOC_DeviceContext := DllCall("user32.dll\GetDC", "UInt", 0)
	, DllCall("gdi32.dll\BitBlt", "UInt", mDC, "Int", 0, "Int", 0, "Int", LOC_Width, "Int", LOC_Height, "UInt", LOC_DeviceContext, "Int", LOC_Left, "Int", LOC_Top, "UInt", 0x40000000 | 0x00CC0020)
	, DllCall("user32.dll\ReleaseDC", "UInt", 0, "UInt", LOC_DeviceContext)
	If  (PRM_Cursor) {
		SCR_CaptureCursor(mDC, LOC_Left, LOC_Top)
	}
	DllCall("gdi32.dll\SelectObject", "UInt", mDC, "UInt", oBM)
	, DllCall("gdi32.dll\DeleteDC", "UInt", mDC)
	If  (LOC_WidthZoomed
		&& LOC_HeightZoomed) {
		LOC_BitMap := SCR_Zoomer(LOC_BitMap, LOC_Width, LOC_Height, LOC_WidthZoomed, LOC_HeightZoomed)
	}

	LOC_File := A_ScriptDir . "\media\" . AHK_ScriptName . ".bmp"
	, SCR_Convert(LOC_BitMap, LOC_File)
	, SCR_DisplayPicture(LOC_File, LOC_Left, LOC_Top, LOC_Width, LOC_Height)
	Try {
		FileDelete, %LOC_File%
	} Catch LOC_Exception {
		AHK_Catch(LOC_Exception, "SCR_CaptureManager", PRM_Rectangle, PRM_Cursor, PRM_SaveToFile, PRM_SecondsToWait)
	}

	If (PRM_SaveToFile) {
		LOC_File := SCR_SelectFile()
		If (LOC_File) {
			SCR_Convert(LOC_BitMap, LOC_File, SubStr(LOC_File, Strlen(LOC_File) - 4, 4) == ".jpg" ? PRM_Quality : "")
		}
	} Else {
		;SCR_SetClipBoardData(hBM)
		SCR_SetClipBoardData(LOC_BitMap)
	}

	; DllCall("gdi32.dll\DeleteObject", "UInt", LOC_BitMap)
	; DllCall("gdi32.dll\DeleteObject", "UInt", hBM)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Screenshot cursor capture :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_CaptureCursor(PRM_DeviceContext, PRM_Left, PRM_Top) {
	VarSetCapacity(mi, 20, 0)
	, mi := Chr(20)
	, DllCall("user32.dll\GetCursorInfo", "UInt", &mi)
	, bShow   := NumGet(mi, 4)
	, hCursor := NumGet(mi, 8)
	, xCursor := NumGet(mi, 12)
	, yCursor := NumGet(mi, 16)

	If  (bShow
		&& hCursor := DllCall("user32.dll\CopyIcon", "UInt", hCursor)) {
		VarSetCapacity(ni, 20, 0)
		, DllCall("user32.dll\GetIconInfo", "UInt", hCursor, "UInt", &ni)
		, bIcon    := NumGet(ni, 0)
		, xHotspot := NumGet(ni, 4)
		, yHotspot := NumGet(ni, 8)
		, hBMMask  := NumGet(ni, 12)
		, hBMColor := NumGet(ni, 16)

		, DllCall("user32.dll\DrawIcon", "UInt", PRM_DeviceContext, "Int", xCursor - xHotspot - PRM_Left, "Int", yCursor - yHotspot - PRM_Top, "UInt", hCursor)
		, DllCall("user32.dll\DestroyIcon", "UInt", hCursor)
		If  (hBMMask) {
			DllCall("gdi32.dll\DeleteObject", "UInt", hBMMask)
		}
		If  (hBMColor) {
			DllCall("gdi32.dll\DeleteObject", "UInt", hBMColor)
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_Zoomer(hBM, PRM_Width, PRM_Height, PRM_WidthZoomed, PRM_HeightZoomed) {
	mDC1 := DllCall("gdi32.dll\CreateCompatibleDC", "UInt", 0)
	, mDC2 := DllCall("gdi32.dll\CreateCompatibleDC", "UInt", 0)
	, zhBM := SCR_CreateDIBSection(PRM_WidthZoomed, PRM_HeightZoomed, mDC2)
	, oBM1 := DllCall("gdi32.dll\SelectObject", "UInt", mDC1, "UInt",  hBM)
	, oBM2 := DllCall("gdi32.dll\SelectObject", "UInt", mDC2, "UInt", zhBM)
	, DllCall("gdi32.dll\SetStretchBltMode", "UInt", mDC2, "Int", 4)
	, DllCall("gdi32.dll\StretchBlt", "UInt", mDC2, "Int", 0, "Int", 0, "Int", PRM_WidthZoomed, "Int", PRM_HeightZoomed, "UInt", mDC1, "Int", 0, "Int", 0, "Int", PRM_Width, "Int", PRM_Height, "UInt", 0x00CC0020)
	, DllCall("gdi32.dll\SelectObject", "UInt", mDC1, "UInt", oBM1)
	, DllCall("gdi32.dll\SelectObject", "UInt", mDC2, "UInt", oBM2)
	, DllCall("gdi32.dll\DeleteDC", "UInt", mDC1)
	, DllCall("gdi32.dll\DeleteDC", "UInt", mDC2)
	, DllCall("gdi32.dll\DeleteObject", "UInt", hBM)
	Return, zhBM
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_Convert(PRM_FileFrom = "", PRM_FileTo = "", PRM_Quality = "") {

	nSize := pToken := 0
	If (PRM_FileTo == "") {
		PRM_FileTo := A_ScriptDir . "\media\screen.bmp"
	}
	SplitPath, PRM_FileTo, , sDirTo, sExtTo, sNameTo

	VarSetCapacity(si, 16, 0), si := Chr(1)
	, DllCall("gdiplus.dll\GdiplusStartup", "UIntP", pToken, "UInt", &si, "UInt", 0)

	If (!PRM_FileFrom) {
		DllCall("user32.dll\OpenClipBoard", "UInt", 0)
		If (DllCall("user32.dll\IsClipBoardFormatAvailable", "UInt", 2)
			&& hBM := DllCall("user32.dll\GetClipBoardData", "UInt", 2)) {
			DllCall("gdiplus.dll\GdipCreateBitmapFromHBITMAP", "UInt", hBM, "UInt", 0, "UIntP", pImage)
		}
		DllCall("user32.dll\CloseClipBoard")
	}
	Else If (PRM_FileFrom Is Integer) {
		DllCall("gdiplus.dll\GdipCreateBitmapFromHBITMAP", "UInt", PRM_FileFrom, "UInt", 0, "UIntP", pImage) ; TODO : Drôle de fonction !!
	} Else {
		DllCall("gdiplus.dll\GdipLoadImageFromFile", "UInt", SCR_Unicode4Ansi(wFileFr, PRM_FileFrom), "UIntP", pImage)
	}

	DllCall("gdiplus.dll\GdipGetImageEncodersSize", "UIntP", nCount, "UIntP", nSize)
	, VarSetCapacity(ci, nSize, 0)
	, DllCall("gdiplus.dll\GdipGetImageEncoders", "UInt", nCount, "UInt", nSize, "UInt", &ci)
	Loop, %nCount% {
		If  (InStr(SCR_Ansi4Unicode(NumGet(ci,76 * (A_Index - 1) + 44)), "." . sExtTo)) {
			pCodec := &ci + 76 * (A_Index - 1)
			Break
		}
	}
	If  (InStr(".JPG.JPEG.JPE.JFIF", "." . sExtTo)
		&& PRM_Quality != "" && pImage && pCodec)
	{
		DllCall("gdiplus.dll\GdipGetEncoderParameterListSize", "UInt", pImage, "UInt", pCodec, "UIntP", nSize)
		, VarSetCapacity(pi, nSize, 0)
		, DllCall("gdiplus.dll\GdipGetEncoderParameterList", "UInt", pImage, "UInt", pCodec, "UInt", nSize, "UInt", &pi)
		Loop, % NumGet(pi)
		{
			If  (NumGet(pi, 28 * (A_Index - 1) + 20) = 1
				&& NumGet(pi, 28 * (A_Index - 1) + 24) = 6)
			{
				pParam := &pi + 28 * (A_Index - 1)
				, NumPut(PRM_Quality, NumGet(NumPut(4, NumPut(1, pParam + 0) + 20)))
				Break
			}
		}
	}

	If  (pImage) {
		pCodec	? DllCall("gdiplus.dll\GdipSaveImageToFile", "UInt", pImage, "UInt", SCR_Unicode4Ansi(wFileTo,PRM_FileTo), "UInt", pCodec, "UInt", pParam)
				: DllCall("gdiplus.dll\GdipCreateHBITMAPFromBitmap", "UInt", pImage, "UIntP", hBitmap, "UInt", 0) . SCR_SetClipBoardData(hBitmap), DllCall("gdiplus.dll\GdipDisposeImage", "UInt", pImage)
	}

	DllCall("gdiplus.dll\GdiplusShutdown" , "UInt", pToken)
	;, DllCall("kernel32.dll\FreeLibrary", "UInt", hGdiPlus)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_CreateDIBSection(PRM_Width, PRM_Height, PRM_DeviceContext = "", ByRef pBits = "") {
	LOC_DeviceContext := (PRM_DeviceContext ? PRM_DeviceContext : DllCall("GetDC", "UInt", 0))
	NumPut(VarSetCapacity(LOC_BitmapInfo, 40, 0), LOC_BitmapInfo)
	, NumPut(PRM_Width, LOC_BitmapInfo, 4)
	, NumPut(PRM_Height, LOC_BitmapInfo, 8)
	, NumPut(32, NumPut(1, LOC_BitmapInfo, 12, "UShort"), 0, "UShort")
	, NumPut(0, LOC_BitmapInfo, 16)
	LOC_DIBSection := DllCall("gdi32.dll\CreateDIBSection", "UInt", LOC_DeviceContext, "UInt", &LOC_BitmapInfo, "UInt", 0, "UIntP", pBits, "UInt", 0, "UInt", 0)
	If (!PRM_DeviceContext) {
		DllCall("user32.dll\ReleaseDC", "UInt", 0, "UInt", LOC_DeviceContext)
	}
	Return, LOC_DIBSection
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_SaveBitmapToFile(PRM_Bitmap, PRM_File) {
	Global ZZZ_CloseHandleFunction
	Static STA_WriteFileFunction := false
	If (!STA_WriteFileFunction) {
		STA_WriteFileFunction := AHK_GetFunction("kernel32", "WriteFile")
	}
	DllCall("gdi32.dll\GetObject", "UInt", PRM_Bitmap, "Int", VarSetCapacity(oi, 84, 0), "UInt", &oi)
	, LOC_FileHandler := DllCall("kernel32.dll\CreateFile", "UInt", &PRM_File, "UInt", 0x40000000, "UInt", 0, "UInt", 0, "UInt", 2, "UInt", 0, "UInt", 0)
	, DllCall(STA_WriteFileFunction, "UInt", LOC_FileHandler, "Int64P", 0x4D42 | 14 + 40 + NumGet(oi, 44) << 16, "UInt", 6, "UIntP", 0, "UInt", 0)
	, DllCall(STA_WriteFileFunction, "UInt", LOC_FileHandler, "Int64P", 54 << 32, "UInt", 8, "UIntP", 0, "UInt", 0)
	, DllCall(STA_WriteFileFunction, "UInt", LOC_FileHandler, "UInt", &oi + 24, "UInt", 40, "UIntP", 0, "UInt", 0)
	, DllCall(STA_WriteFileFunction, "UInt", LOC_FileHandler, "UInt", NumGet(oi, 20), "UInt", NumGet(oi, 44), "UIntP", 0, "UInt", 0)
	, DllCall(ZZZ_CloseHandleFunction, "UInt", LOC_FileHandler)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_SetClipBoardData(PRM_Bitmap) {
	DllCall("gdi32.dll\GetObject", "UInt", PRM_Bitmap, "Int", VarSetCapacity(oi, 84, 0), "UInt", &oi)
	, hDIB := DllCall("kernel32.dll\GlobalAlloc", "UInt", 2, "UInt", 40 + NumGet(oi, 44))
	, pDIB := DllCall("kernel32.dll\GlobalLock", "UInt", hDIB)
	, DllCall("kernel32.dll\RtlMoveMemory", "UInt", pDIB, "UInt", &oi + 24, "UInt", 40)
	, DllCall("kernel32.dll\RtlMoveMemory", "UInt", pDIB + 40, "UInt", NumGet(oi, 20), "UInt", NumGet(oi, 44))
	, DllCall("kernel32.dll\GlobalUnlock", "UInt", hDIB)
	, DllCall("gdi32.dll\DeleteObject", "UInt", PRM_Bitmap)
	, DllCall("user32.dll\OpenClipBoard", "UInt", 0)
	, DllCall("user32.dll\EmptyClipBoard")
	, DllCall("user32.dll\SetClipBoardData", "UInt", 8, "UInt", hDIB)
	, DllCall("user32.dll\CloseClipBoard")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_Unicode4Ansi(ByRef wString, sString) {
	nSize := DllCall("kernel32.dll\MultiByteToWideChar", "UInt", 0, "UInt", 0, "UInt", &sString, "Int", -1, "UInt", 0, "Int", 0)
	, VarSetCapacity(wString, nSize * 2)
	, DllCall("kernel32.dll\MultiByteToWideChar", "UInt", 0, "UInt", 0, "UInt", &sString, "Int", -1, "UInt", &wString, "Int", nSize)
	Return  &wString
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_Ansi4Unicode(pString) {
	nSize := DllCall("kernel32.dll\WideCharToMultiByte", "UInt", 0, "UInt", 0, "UInt", pString, "Int", -1, "UInt", 0, "Int",  0, "UInt", 0, "UInt", 0)
	, VarSetCapacity(sString, nSize)
	, DllCall("kernel32.dll\WideCharToMultiByte", "UInt", 0, "UInt", 0, "UInt", pString, "Int", -1, "str", sString, "Int", nSize, "UInt", 0, "UInt", 0)
	Return  sString
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Random wallpaper :
;;;;;;;;;;;;;;;;;;;;

SCR_InitWallpapers:
SCR_InitWallpapers()
Return

SCR_ReinitWallpapers:
SCR_InitWallpapers(SCR_WallpaperFolder)
Return

SCR_InitWallpapers(PRM_DefaultFolder = false) {
	Global
	AHK_Log("> SCR_InitWallpapers(" . (PRM_DefaultFolder ? PRM_DefaultFolder : "false") . ")")

	ZZZ_WallpaperA := [ ]
	If (SCR_WallpaperRotationEnabled) {
		If (SCR_WallpaperFolder
			&& !PRM_DefaultFolder
			&& InStr(FileExist(SCR_WallpaperFolder), "D")) {
			Loop, Files, %SCR_WallpaperFolder%\*.*, FR
			{
				If A_LoopFileExt In jpg,jpeg,bmp
				{
					ZZZ_WallpaperA.Insert(A_LoopFileLongPath)
					; TODO : insérer l'image trouvée dans les possibilités de login si ses dims sont OK
				}
			}
			If (ZZZ_WallpaperA.MaxIndex()) {
				SetTimer, SCR_ChangeWallPaperTimer, -1
			} Else {
				MsgBox, , No wallpaper found - %AHK_ScriptInfo%, The wallpaper folder '%SCR_WallpaperFolder%' doesn't contain any image.`nPlease select another one.
				SetTimer, SCR_ReinitWallpapers, -1
			}
		} Else {
			FileSelectFolder, SCR_WallpaperFolder, % (PRM_DefaultFolder ? PRM_DefaultFolder : A_MyDocuments), 6, % "Select wallpaper root folder..."
			If (SCR_WallpaperFolder) {
				SetTimer, SCR_InitWallpapers, -1
			} Else {
				SCR_ToggleWallpaperRotation()
			}
		}
	}
	AHK_Log("< SCR_InitWallpapers(" . (PRM_DefaultFolder ? PRM_DefaultFolder : "false") . ")")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_ChangeWallPaperTimer:
^#z::
SCR_ChangeWallpaper()
If (SCR_WallpaperRotationEnabled) {
	SetTimer, SCR_ChangeWallPaperTimer, % -1000 * SCR_ChangeWallPaperTimer
} Else {
	SendInput, %A_ThisHotkey%
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_ChangeWallpaper:
SCR_ChangeWallpaper()
Return

SCR_ChangeWallpaper() {

	Global
	Static STA_Init := false, STA_InitRunning := false
	If (!STA_Init) {
		If (STA_InitRunning) {
			Return
		}
		STA_InitRunning := true
		, SCR_InitWallpapers()
		, STA_Init := true
	}
	Local LOC_Random, LOC_WallpaperPath, LOC_Token
	If (ZZZ_WallpaperA.MaxIndex()) {
		Random, LOC_Random, 1, ZZZ_WallpaperA.MaxIndex()
		LOC_WallpaperPath := A_WinDir . "\wallpaper.bmp"
		, SCR_CreateWallpaperBitmap(ZZZ_WallpaperA[LOC_Random], LOC_WallpaperPath, A_ScreenWidth, A_ScreenHeight, "Pixels")

		RegWrite REG_SZ, HKCU, Control Panel\Desktop, OriginalWallpaper, % ZZZ_WallpaperA[LOC_Random]
		RegWrite REG_SZ, HKCU, Control Panel\Desktop, Wallpaper, %LOC_WallpaperPath%
		RegWrite REG_SZ, HKCU, Control Panel\Desktop, TileWallpaper, 0
		RegWrite REG_SZ, HKCU, Control Panel\Desktop, WallpaperStyle, 0
		DllCall("user32.dll\SystemParametersInfoA", "Int", 20, "Int", 0, "Int", &LOC_WallpaperPath, "Int", 3)
		SendMessage, 0x001A, , , , ahk_id 0xFFFF ; 0x001A is WM_SETTINGCHANGE ; 0xFFFF is HWND_BROADCAST
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_ToggleWallpaperRotation:
SCR_ToggleWallpaperRotation()
Menu, Options, Show
Return

^+#z::
SCR_ToggleWallpaperRotation()
, TRY_ShowTrayTip("Wallpaper rotation " . (SCR_WallpaperRotationEnabled ? "enabled" : "disabled"))
Return

SCR_ToggleWallpaperRotation() {
	Global
	SCR_WallpaperRotationEnabled := !SCR_WallpaperRotationEnabled
	If (SCR_WallpaperRotationEnabled) {
		SetTimer, SCR_InitWallpapers, -1
	} Else {
		ZZZ_WallpaperA := [ ]
	}
	TRY_UpdateMenus()
	, AHK_SaveIniFile()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; SCR_CreateWallpaperBitmap() by Tariq Porter (tic) 04/05/08
; Version:      1.01
;
; PRM_InputFile:  Location of the input file to be converted. May be of filetype jpg,bmp,png,tiff,gif
; PRM_OutputFile: Location to save the converted file. Extension determines the output filetype jpg,bmp,png,tiff,gif
; Width:          Width either in pixels or percentage (depending on Method) to save the converted file
; Height:         Height either in pixels or percentage (depending on Method) to save the converted file
;                 With Percent method, Width or Height may also be -1 to keep the aspect ratio the same
;                 Pixels method always keeps ratio the same
; Method:         Can either be "Percent" or "Pixels" to determine the width and height of the converted file
; Return:          0: Success
;                 -1: Could not create a bitmap from file
;                 -2: Source file has no width or height
;                 -3: Resize method must be either Precentage or Pixels
;                 -4: Error resizing image
;                 -5: Could not get a list of filetype encoders on the system
;                 -6: Could not find matching codec
;                 -7: Wide file output could not be created
;                 -8: File could not be written to disk

SCR_CreateWallpaperBitmap(PRM_InputFile, PRM_OutputFile, PRM_Width = "", PRM_Height = "", PRM_Method = "Percent") {

	Static STA_MultiByteToWideCharFunction := AHK_GetFunction("kernel32", "MultiByteToWideChar"), STA_WideCharToMultiByteFunction := AHK_GetFunction("kernel32", "WideCharToMultiByte")
	Static STA_GdiplusStartupFunction, STA_GdipCreateBitmapFromFileFunction, STA_GdipGetImageWidthFunction, STA_GdipGetImageHeightFunction, STA_GdipDisposeImageFunction, STA_GdiplusShutdownFunction
	If (!STA_GdiplusStartupFunction) {
		STA_GdiplusStartupFunction := AHK_GetFunction("gdiplus", "GdiplusStartup")
		, STA_GdipCreateBitmapFromFileFunction := AHK_GetFunction("gdiplus", "GdipCreateBitmapFromFile")
		, STA_GdipGetImageWidthFunction := AHK_GetFunction("gdiplus", "GdipGetImageWidth")
		, STA_GdipGetImageHeightFunction := AHK_GetFunction("gdiplus", "GdipGetImageHeight")
		, STA_GdipDisposeImageFunction := AHK_GetFunction("gdiplus", "GdipDisposeImage")
		, STA_GdiplusShutdownFunction := AHK_GetFunction("gdiplus", "GdiplusShutdown")
	}
	VarSetCapacity(si, 16, 0)
	, si := Chr(1)
	, pToken := pBitmap := LOC_SourceWidth := LOC_SourceHeight := FpBitmap := G := LOC_ImageAttributes := nCount := nSize := 0
	, DllCall(STA_GdiplusStartupFunction, "UInt*", pToken, "UInt", &si, "UInt", 0)
	, VarSetCapacity(si, 0)

	StringSplit, OutputArray, PRM_OutputFile, .
	Extension := "." OutputArray%OutputArray0%

	VarSetCapacity(wInput, 1023)
	, DllCall(STA_MultiByteToWideCharFunction, "UInt", 0, "UInt", 0, "UInt", &PRM_InputFile, "Int", -1, "UInt", &wInput, "Int", 512)
	, DllCall(STA_GdipCreateBitmapFromFileFunction, "UInt", &wInput, "UInt*", pBitmap)
	If (!pBitmap) {
		DllCall(STA_GdiplusShutdownFunction, "UInt", pToken)
		Return, -1
	}

	If (PRM_Width && PRM_Height) {
		DllCall(STA_GdipGetImageWidthFunction, "UInt", pBitmap, "UInt*", LOC_SourceWidth)
		DllCall(STA_GdipGetImageHeightFunction, "UInt", pBitmap, "UInt*", LOC_SourceHeight)
		If !(LOC_SourceWidth && LOC_SourceHeight) {
			DllCall(STA_GdipDisposeImageFunction, "UInt", pBitmap)
			, DllCall(STA_GdiplusShutdownFunction, "UInt", pToken)
			Return, -2
		}

		If (PRM_Method == "Percent") {
			PRM_Width := (PRM_Width == -1) ? PRM_Height : PRM_Width
			, PRM_Height := (PRM_Height == -1) ? PRM_Width : PRM_Height
			, LOC_DestinationWidth := Round(LOC_SourceWidth * (PRM_Width / 100))
			, LOC_DestinationHeight := Round(LOC_SourceHeight * (PRM_Height / 100))
			, sx := 0
			, sy := 0
		} Else If (PRM_Method = "Pixels") {
			LOC_DestinationWidth := PRM_Width
			, LOC_DestinationHeight := PRM_Height
			If (LOC_SourceHeight / LOC_SourceWidth > PRM_Height / PRM_Width) { ; source more high than large
				sx := 0
				LOC_SourceRealHeight := Round(PRM_Height * LOC_SourceWidth / PRM_Width)
				sy := (abs(LOC_SourceHeight - LOC_SourceRealHeight)) // 2
				LOC_SourceHeight := LOC_SourceRealHeight
			} Else { ; source more large than high
				LOC_SourceRealWidth := Round(PRM_Width * LOC_SourceHeight / PRM_Height)
				sx := (abs(LOC_SourceWidth - LOC_SourceRealWidth)) // 2,
				LOC_SourceWidth := LOC_SourceRealWidth
				sy := 0
			}
		} Else {
			DllCall(STA_GdipDisposeImageFunction, "UInt", pBitmap)
			, DllCall(STA_GdiplusShutdownFunction, "UInt", pToken)
			Return, -3
		}

		DllCall("gdiplus.dll\GdipCreateBitmapFromScan0", "Int", LOC_DestinationWidth, "Int", LOC_DestinationHeight, "Int", 0, "Int", 0x26200A, "UInt", 0, "UInt*", FpBitmap)
		, DllCall("gdiplus.dll\GdipGetImageGraphicsContext", "UInt", FpBitmap, "UInt*", G)
		, DllCall("gdiplus.dll\GdipSetInterpolationMode", "UInt", G, "Int", 7)

		, E := DllCall("gdiplus.dll\GdipDrawImageRectRectI", "UInt", G, "UInt", pBitmap ; Graphics, Image
						, "Int", 0, "Int", 0, "Int", LOC_DestinationWidth, "Int", LOC_DestinationHeight ; destX, destY, destWidth, destHeight
						, "Int", sx, "Int", sy, "Int", LOC_SourceWidth, "Int", LOC_SourceHeight ; sourceX, sourceY, sourceWidth, sourceHeight
						, "Int", 2, "UInt", LOC_ImageAttributes, "UInt", 0, "UInt", 0) ; unit, attributes, callback, callbackData

		, DllCall("gdiplus.dll\GdipDeleteGraphics", "UInt", G)
		, DllCall(STA_GdipDisposeImageFunction, "UInt", pBitmap)
		, pBitmap := FpBitmap

		If (E) {
			DllCall(STA_GdipDisposeImageFunction, "UInt", pBitmap)
			, DllCall(STA_GdiplusShutdownFunction, "UInt", pToken)
			Return, -4
		}
	}

	DllCall("gdiplus.dll\GdipGetImageEncodersSize", "UInt*", nCount, "UInt*", nSize)
	, VarSetCapacity(ci, nSize)
	, DllCall("gdiplus.dll\GdipGetImageEncoders", "UInt", nCount, "UInt", nSize, "UInt", &ci)
	If (!(nCount && nSize)) {
		DllCall(STA_GdipDisposeImageFunction, "UInt", pBitmap)
		, DllCall(STA_GdiplusShutdownFunction, "UInt", pToken)
		Return, -5
	}

	Loop, %nCount% {
		nSize := DllCall(STA_WideCharToMultiByteFunction, "UInt", 0, "UInt", 0, "UInt", NumGet(ci, 76*(A_Index-1)+44), "Int", -1, "UInt", 0, "Int",  0, "UInt", 0, "UInt", 0)
		, VarSetCapacity(sString, nSize)
		, DllCall(STA_WideCharToMultiByteFunction, "UInt", 0, "UInt", 0, "UInt", NumGet(ci, 76 * (A_Index - 1) + 44), "Int", -1, "Str", sString, "Int", nSize, "UInt", 0, "UInt", 0)

		If (!InStr(sString, Extension)) {
			Continue
		}
		pCodec := &ci + 76 * (A_Index - 1)
		Break
	}

	If (!pCodec) {
		DllCall(STA_GdipDisposeImageFunction, "UInt", pBitmap)
		, DllCall(STA_GdiplusShutdownFunction, "UInt", pToken)
		Return, -6
	}

	nSize := DllCall(STA_MultiByteToWideCharFunction, "UInt", 0, "UInt", 0, "UInt", &PRM_OutputFile, "Int", -1, "UInt", 0, "Int", 0)
	, VarSetCapacity(wOutput, nSize * 2)
	, DllCall(STA_MultiByteToWideCharFunction, "UInt", 0, "UInt", 0, "UInt", &PRM_OutputFile, "Int", -1, "UInt", &wOutput, "Int", nSize)
	, VarSetCapacity(wOutput, -1)
	If (!VarSetCapacity(wOutput)) {
		DllCall(STA_GdipDisposeImageFunction, "UInt", pBitmap)
		, DllCall(STA_GdiplusShutdownFunction, "UInt", pToken)
		Return, -7
	}

	E := DllCall("gdiplus.dll\GdipSaveImageToFile", "UInt", pBitmap, "UInt", &wOutput, "UInt", pCodec, "UInt", 0)
	, DllCall(STA_GdipDisposeImageFunction, "UInt", pBitmap)
	;If (E) {
	;	DllCall(STA_GdipDisposeImageFunction, "UInt", pBitmap)
	;}
	DllCall(STA_GdiplusShutdownFunction, "UInt", pToken)
	Return, (E ? -8 : 0)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Screen Magnifier { Win + PrintScreen | Ctrl + Shift + Wheel } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_InitMagnifier() {
	Global
	ZZZ_MagnifierZoom := ZZZ_InitialMagnifierZoom := 200
	, ZZZ_MagnifierXRadius := ZZZ_InitialMagnifierXRadius := SCR_VirtualScreenWidth // 10
	, ZZZ_MagnifierYRadius := ZZZ_InitialMagnifierYRadius := (SCR_VirtualScreenHeight * ZZZ_InitialMagnifierXRadius) // SCR_VirtualScreenWidth
	ZZZ_MagnifiedZoneXRadius := 100 * ZZZ_InitialMagnifierXRadius // ZZZ_InitialMagnifierZoom
	, ZZZ_MagnifiedZoneYRadius := 100 * ZZZ_InitialMagnifierYRadius // ZZZ_InitialMagnifierZoom
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_Magnifier:
<^<!#PrintScreen::
SCR_Magnifier()
Return

SCR_Magnifier() {
	SCR_DisplayMagnifier(PRM_AltState := true)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_ResizeMagnifier:
^+Up::
^+Down::
^+WheelUp::
^!+WheelUp::
^+WheelDown::
^!+WheelDown::
SCR_ResizeMagnifierEvent()
Return

SCR_ResizeMagnifierEvent() {
	If (!WinActive("Rayman Origins ahk_class RaymanOrigins")) {
		SCR_ResizeMagnifier(A_ThisHotKey, PRM_Resized := true)
		SetTimer, SCR_DestroyMagnifierTimer, -1
		Return
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_DisplayMagnifier(PRM_AltState = false) {

	Global
	Local LOC_WindowID, PRM_Resized, PRM_Init
	Gui, 26:Destroy ; GUI_Magnifier
	Gui, 26:+AlwaysOnTop -Resize -Caption +ToolWindow +Border +Disabled  +LastFound -SysMenu +0x00000020 +HwndLOC_WindowID
	Gui, 26:Add, StatusBar
	Gui, 26:Show, % "w" . Max(375, Round(2 * ZZZ_MagnifierXRadius)) . " h" . Round(2 * ZZZ_MagnifierYRadius) . " x" . SCR_VirtualScreenWidth . " y" . SCR_VirtualScreenHeight . " NoActivate", % "GUI_Magnifier"
	WinSet, Transparent, 255
	WinSet, ExStyle, +0x00000020
	Hotkey, LButton, Off
	Gui, 26:Default
	SB_SetParts(90, 110)
	SB_SetText("` Press Esc to exit", 1)
	SB_SetText("Press Alt for anti-alias", 2)

	ZZZ_ScreenDeviceContext := DllCall("user32.dll\GetDC", "UInt", 0)
	, ZZZ_MagnifierDeviceContext := DllCall("user32.dll\GetDC", "UInt", LOC_WindowID)
	, ZZZ_ScreenDeviceContextBuffer := DllCall("gdi32.dll\CreateCompatibleDC", "UInt", LOC_WindowID)
	, ZZZ_ScreenDeviceBitMapBuffer := DllCall("gdi32.dll\CreateCompatibleBitmap", "UInt", LOC_WindowID, "Int", SCR_VirtualScreenWidth, "Int", SCR_VirtualScreenHeight)
	, DllCall("gdi32.dll\SetStretchBltMode", "UInt", ZZZ_MagnifierDeviceContext, "Int", PRM_AltState || ZZZ_MagnifierZoom < 100 ? 4 : 0) ; Anti-aliasing
	, SCR_ResizeMagnifier(A_ThisHotKey, PRM_Resized := false)
	, SCR_RepaintMagnifier(PRM_Init := true)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_ResizeMagnifier(PRM_ThisHotKey = "", PRM_Resized = true) {

	Global
	Local LOC_WindowID, LOC_ZoomFactors, LOC_LowerFactor, LOC_UpperFactor, LOC_FactorFound, LOC_AltState := GetKeyState("LAlt"), PRM_Init
	WinGet, LOC_WindowID, ID, % "GUI_Magnifier ahk_class AutoHotkeyGUI"
	If (!LOC_WindowID) {
		SCR_DisplayMagnifier(LOC_AltState)
		; WinGet, LOC_WindowID, ID, % "GUI_Magnifier ahk_class AutoHotkeyGUI"
	} Else If (PRM_Resized) {
		LOC_ZoomFactors := "33,40,50,75,100,150,200,300,400,600,800"
		, LOC_LowerFactor := false
		, LOC_UpperFactor := false
		, LOC_FactorFound := false
		Loop, Parse, LOC_ZoomFactors, `,
		{
			If (LOC_FactorFound) {
				LOC_UpperFactor := A_LoopField
				Break
			} Else {
				If (A_LoopField >= ZZZ_MagnifierZoom) {
					If (!LOC_LowerFactor) {
						LOC_LowerFactor := A_LoopField
					}
					LOC_UpperFactor := A_LoopField
					, LOC_FactorFound := true
				} Else {
					LOC_LowerFactor := A_LoopField
				}
			}
		}
		IfInString, PRM_ThisHotKey, % "Up"
		{
			ZZZ_MagnifierZoom := LOC_UpperFactor
		} Else {
			 ZZZ_MagnifierZoom := LOC_LowerFactor
		}

		DllCall("gdi32.dll\SetStretchBltMode", "UInt", ZZZ_MagnifierDeviceContext, "Int", LOC_AltState || ZZZ_MagnifierZoom < 100 ? 4 : 0) ; Anti-aliasing
		, ZZZ_MagnifierXRadius := ZZZ_InitialMagnifierXRadius * (1 + ZZZ_MagnifierZoom / ZZZ_InitialMagnifierZoom / 5)
		, ZZZ_MagnifierYRadius := ZZZ_InitialMagnifierYRadius * (1 + ZZZ_MagnifierZoom / ZZZ_InitialMagnifierZoom / 5)
		ZZZ_MagnifiedZoneXRadius := 100 * ZZZ_MagnifierXRadius // ZZZ_MagnifierZoom
		, ZZZ_MagnifiedZoneYRadius := 100 * ZZZ_MagnifierYRadius // ZZZ_MagnifierZoom
		, SCR_RepaintMagnifier(PRM_Init := true)
	}
	Gui, 26:Default
	SB_SetText("Zoom (" . ZZZ_MagnifierZoom . "%) : Ctrl + Shift + Wheel` ", 3)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ZZZ_RepaintMagnifierTimer:
SCR_RepaintMagnifier()
Return

SCR_RepaintMagnifier(PRM_ForcedRefresh = false) {

	Global ZZZ_MagnifierZoom, ZZZ_MagnifierXRadius, ZZZ_MagnifiedZoneXRadius, ZZZ_MagnifierYRadius, ZZZ_MagnifiedZoneYRadius, ZZZ_ScreenDeviceContext, ZZZ_MagnifierDeviceContext, ZZZ_RepaintMagnifierTimer
	Static STA_AltState := false, STA_MouseX, STA_MouseY, STA_MagnifierID := false
		, STA_StrechBltFunction := AHK_GetFunction("gdi32", "StretchBlt"), STA_SetStretchBltModeFunction := AHK_GetFunction("gdi32", "SetStretchBltMode")

	CoordMode, Mouse, Screen
	MouseGetPos, LOC_MouseX, LOC_MouseY
	If (PRM_ForcedRefresh) {
		STA_MouseX := LOC_MouseX
		, STA_MouseY := LOC_MouseY
		WinGet, STA_MagnifierID, ID, GUI_Magnifier ahk_class AutoHotkeyGUI
	}
	LOC_AltState := GetKeyState("LAlt")

	If (PRM_ForcedRefresh
		|| !A_Is64bitOS
		|| LOC_MouseX != STA_MouseX
		|| LOC_MouseY != STA_MouseY
		|| LOC_AltState != STA_AltState) {
		STA_MouseX := LOC_MouseX
		, STA_MouseY := LOC_MouseY
		If (LOC_AltState != STA_AltState) {
			DllCall(STA_SetStretchBltModeFunction, "UInt", ZZZ_MagnifierDeviceContext, "Int", LOC_AltState || ZZZ_MagnifierZoom < 100 ? 4 : 0) ; Anti-aliasing
			, STA_AltState := LOC_AltState
		}
		LOC_WindowX := LOC_MouseX - ZZZ_MagnifierXRadius
		, LOC_WindowY := LOC_MouseY - ZZZ_MagnifierYRadius
		WinMove, ahk_id %STA_MagnifierID%, , %LOC_WindowX%, %LOC_WindowY%, % Max(375, 2 * ZZZ_MagnifierXRadius), % 2 * ZZZ_MagnifierYRadius + 25
		If (A_Is64bitOS) {
			WinSet, Transparent, 0, ahk_id %STA_MagnifierID%
		}
		
		DllCall(STA_StrechBltFunction ; "gdi32.dll\StretchBlt"
			, "UInt", ZZZ_MagnifierDeviceContext ; Destination
			, "Int", Max(0, 375 // 2 - ZZZ_MagnifierXRadius), "Int", 0
			, "Int", 2 * ZZZ_MagnifierXRadius, "Int", 2 * ZZZ_MagnifierYRadius

			, "UInt", ZZZ_ScreenDeviceContext ; Source
			, "UInt", LOC_MouseX - ZZZ_MagnifiedZoneXRadius + 1, "UInt", LOC_MouseY - ZZZ_MagnifiedZoneYRadius + 1
			, "Int", 2 * ZZZ_MagnifiedZoneXRadius, "Int", 2 * ZZZ_MagnifiedZoneYRadius
			, "UInt", 0xCC0020)
		If (A_Is64bitOS) {
			WinSet, Transparent, 255, ahk_id %STA_MagnifierID%
		}
	}
	SetTimer, ZZZ_RepaintMagnifierTimer, %ZZZ_RepaintMagnifierTimer%
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_DestroyMagnifierTimer:
SCR_DestroyMagnifierTimer()
Return

SCR_DestroyMagnifierTimer() {
	Global ZZZ_DestroyMagnifierTimer
	Static STA_DestroyAfterNoMoreKeyDown := true
	If (GetKeyState("Shift", "P")) {
		STA_DestroyAfterNoMoreKeyDown := GetKeyState("Ctrl", "P")
		SetTimer, SCR_DestroyMagnifierTimer, %ZZZ_DestroyMagnifierTimer%
	} Else {
		If (GetKeyState("Ctrl", "P")) {
			STA_DestroyAfterNoMoreKeyDown := true
			SetTimer, SCR_DestroyMagnifierTimer, %ZZZ_DestroyMagnifierTimer%
		} Else {
			If (STA_DestroyAfterNoMoreKeyDown) {
				SCR_DestroyMagnifier()
			}
			STA_DestroyAfterNoMoreKeyDown := true
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_DestroyMagnifier() {

	Global AHK_LeftMouseButtonHookEnabled, ZZZ_ScreenDeviceBitMapBuffer, ZZZ_ScreenDeviceContextBuffer, ZZZ_ScreenDeviceContext, ZZZ_MagnifierDeviceContext
	SetTimer, ZZZ_RepaintMagnifierTimer, Off
	WinGet, LOC_WindowID, ID, % "GUI_Magnifier ahk_class AutoHotkeyGUI"
	If (LOC_WindowID) {
		SetTimer, ZZZ_RepaintMagnifierTimer, Off
		DllCall("gdi32.dll\DeleteObject", "UInt", ZZZ_ScreenDeviceBitMapBuffer)
		, DllCall("gdi32.dll\DeleteDC", "UInt", ZZZ_ScreenDeviceContextBuffer)
		, DllCall("gdi32.dll\DeleteDC", "UInt", ZZZ_MagnifierDeviceContext)
		, DllCall("gdi32.dll\DeleteDC", "UInt", ZZZ_ScreenDeviceContext)
		Gui, 26:Destroy
		Hotkey, LButton, % (AHK_LeftMouseButtonHookEnabled ? "On" : "Off")
		Return, true
	}
	Return, false
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

26GuiClose:
26GuiEscape:
SCR_DestroyMagnifier()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Hexa color picker { Ctrl + Win +       C } :
; RGB  color picker {        Win + Alt + C } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_TrayMenuHexaColorPicker:
^#c::
SCR_TrayMenuHexaColorPicker()
Return

SCR_TrayMenuHexaColorPicker() {
	SCR_ColorPicker(PRM_ColorPickerMode := "Hexa")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_TrayMenuRGBColorPicker:
#!c::
SCR_TrayMenuRGBColorPicker()
Return

SCR_TrayMenuRGBColorPicker() {
	SCR_ColorPicker(PRM_ColorPickerMode := "RGB")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_ColorPicker(PRM_ColorPickerMode = "Hexa") {

	Global ZZZ_RGBColorPicked, ZZZ_HexaColorPicked, ZZZ_PixelColor, SCR_VirtualScreenX, SCR_VirtualScreenY, SCR_VirtualScreenWidth, SCR_VirtualScreenHeight
	Static STA_ColorLabel
	IfWinExist, Color Chooser ahk_class #32770
	{
		WinKill
	}
	AHK_SetCursor("Cross")
	If (PRM_ColorPickerMode == "Hexa") {
		ZZZ_RGBColorPicked := 0
		, ZZZ_HexaColorPicked := -1
	} Else {
		ZZZ_RGBColorPicked := -1
		, ZZZ_HexaColorPicked := 0
	}

	LOC_MouseX := LOC_MouseY = -1
	, LOC_LightLabelColor := 0
	Gui, 17:Font, c000000 ; GUI_ColorPicker
	Gui, 17:-Caption +ToolWindow +AlwaysOnTop +Border +Disabled
	Gui, 17:Add, StatusBar, , ` ` Click or Press Esc
	Gui, 17:Add, Text, Center vSTA_ColorLabel, ` ` Click or Press Esc
	LOC_InitPickedColor := true
	While (ZZZ_HexaColorPicked != 1 && ZZZ_RGBColorPicked != 1)
	{
		CoordMode, Mouse, Screen
		MouseGetPos, LOC_NewMouseX, LOC_NewMouseY
		If (LOC_NewMouseX == LOC_MouseX
			&& LOC_NewMouseY == LOC_MouseY
			&& !LOC_InitPickedColor) {
			Continue
		}
		LOC_InitPickedColor := false
		, LOC_MouseX := LOC_NewMouseX
		, LOC_MouseY := LOC_NewMouseY
		PixelGetColor, ZZZ_PixelColor, LOC_MouseX, LOC_MouseY, RGB
		StringRight, ZZZ_PixelColor, ZZZ_PixelColor, 6 ; Removes 0x prefix
		LOC_RedColor := "0x" . SubStr(ZZZ_PixelColor, 1, 2)
		, LOC_RedColor := LOC_RedColor + 0
		, LOC_GreenColor := "0x" . SubStr(ZZZ_PixelColor, 3, 2)
		, LOC_GreenColor := LOC_GreenColor + 0
		, LOC_BlueColor := "0x" . SubStr(ZZZ_PixelColor, 5, 2)
		, LOC_BlueColor := LOC_BlueColor + 0
		, LOC_MiddleColor := (LOC_RedColor + LOC_GreenColor + LOC_BlueColor) / 3
		If (LOC_MiddleColor < 128
				&& LOC_LightLabelColor == 0
			|| LOC_MiddleColor > 127
				&& LOC_LightLabelColor == 1) {
			Gui, 17:Destroy ; GUI_ColorPicker
			If (LOC_LightLabelColor == 0) {
				LOC_LightLabelColor := 1
				Gui, 17:Font, cFFFFFF
			} Else {
				LOC_LightLabelColor := 0
				Gui, 17:Font, c000000
			}
			Gui, 17:-Caption +ToolWindow +AlwaysOnTop +Border -Resize +Disabled ; GUI_ColorPicker
			Gui, 17:Add, StatusBar, Center, ` ` Click or Press Esc
			Gui, 17:Add, Text, Center vSTA_ColorLabel, ` ` Click or Press Esc
		}
		Gui, 17:Color, %ZZZ_PixelColor%, %ZZZ_PixelColor%
		If (PRM_ColorPickerMode = "Hexa") {
			GuiControl, 17:Text, STA_ColorLabel, #%ZZZ_PixelColor%
		} Else {
			GuiControl, 17:Text, STA_ColorLabel, (%LOC_RedColor%, %LOC_GreenColor%, %LOC_BlueColor%)
		}

		CoordMode, Pixel
		LOC_ColorPickerSize := 30
		, LOC_ColorPickerMouseDelta := 10
		, LOC_ColorPickerX := LOC_MouseX + LOC_ColorPickerMouseDelta
		If (LOC_ColorPickerX + LOC_ColorPickerSize > SCR_VirtualScreenWidth) {
			LOC_ColorPickerX := LOC_MouseX - LOC_ColorPickerMouseDelta - LOC_ColorPickerSize
		}
		LOC_ColorPickerY := LOC_MouseY + LOC_ColorPickerMouseDelta
		If (LOC_ColorPickerY + LOC_ColorPickerSize > SCR_VirtualScreenHeight) {
			LOC_ColorPickerY := LOC_MouseY - LOC_ColorPickerMouseDelta - LOC_ColorPickerSize
		}
		Gui, 17:Show, NoActivate X%LOC_ColorPickerX% Y%LOC_ColorPickerY%, GUI_ColorPicker ; W%LOC_ColorPickerSize% H%LOC_ColorPickerSize%
	}

	Gui, 17:Destroy ; GUI_ColorPicker
	AHK_ResetCursor()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; LButton:: Called in windows.awk at WIN_Roll
SCR_ColorPicked() {

	Global ZZZ_HexaColorPicked, ZZZ_RGBColorPicked, ZZZ_PixelColor
	If (ZZZ_HexaColorPicked == -1) {
		ZZZ_HexaColorPicked := 1
		, ZZZ_RGBColorPicked := 0
	} Else If (ZZZ_RGBColorPicked = -1) {
		ZZZ_HexaColorPicked := 0
		, ZZZ_RGBColorPicked := 1
	}
	If (ZZZ_PixelColor == "") {
		Return
	}
	If (ZZZ_HexaColorPicked == 1) {
		StringRight, ZZZ_PixelColor, ZZZ_PixelColor, 6
		ZZZ_PixelColor := "#" . ZZZ_PixelColor
	} Else {
		LOC_RedColor := "0x" . SubStr(ZZZ_PixelColor, 1, 2)
		, LOC_RedColor := LOC_RedColor + 0
		, LOC_GreenColor := "0x" . SubStr(ZZZ_PixelColor, 3, 2)
		, LOC_GreenColor := LOC_GreenColor + 0
		, LOC_BlueColor := "0x" . SubStr(ZZZ_PixelColor, 5, 2)
		, LOC_BlueColor := LOC_BlueColor + 0
		, ZZZ_PixelColor := "(" . LOC_RedColor . ", " . LOC_GreenColor . ", " . LOC_BlueColor . ")"
	}
	TXT_SetClipBoard(ZZZ_PixelColor)
	, TRY_ShowTrayTip("Color " . ZZZ_PixelColor . " copied")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Esc::
SCR_Escape()
Return

SCR_Escape() {

	Global ZZZ_HexaColorPicked, ZZZ_RGBColorPicked
	If (!WinActive("GUI_BSOD ahk_class AutoHotkeyGUI")) {
		IfWinActive, Color Chooser ahk_class #32770
		{
			WinClose
			AUD_Beep()
		}

		If (ZZZ_HexaColorPicked == -1) {
			ZZZ_HexaColorPicked := 1
			, ZZZ_RGBColorPicked := 0
			Return
		}

		If (ZZZ_RGBColorPicked == -1) {
			ZZZ_HexaColorPicked := 0
			, ZZZ_RGBColorPicked := 1
			Return
		}

		IfWinExist, GUI_Magnifier ahk_class AutoHotkeyGUI
		{
			SCR_DestroyMagnifier()
			Return
		}

		SendInput, {Esc}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Hexa Color chooser { Ctrl + Win +       Shift + C }
; RGB  Color chooser {        Win + Alt + Shift + C } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_HexaColorChooser:
^+#c::
SCR_ColorChooser()
Return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_RGBColorChooser:
!+#c::
SCR_ColorChooser("RGB")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_ColorChooser(PRM_ColorChooserMode = "Hexa") {

	Global ZZZ_RGBColorPicked, ZZZ_HexaColorPicked, ZZZ_PixelColor
	If (PRM_ColorChooserMode == "Hexa") {
		ZZZ_RGBColorPicked := 0
		, ZZZ_HexaColorPicked := -1
	} Else {
		ZZZ_RGBColorPicked := -1
		, ZZZ_HexaColorPicked := 0
	}
	Gui, 17:Destroy ; GUI_ColorPicker
	AHK_ResetCursor()
	If (ZZZ_PixelColor == "") {
		ZZZ_PixelColor := "0x000000"
	}
	SetTimer, SCR_SetAlwaysOnTopColorChooserTimer, -250
	IfWinNotExist, Color Chooser ahk_class #32770
	{
		ZZZ_PixelColor := SCR_ShowColorChooser(PRM_InitHexaColor := ZZZ_PixelColor)
	}
	SCR_ColorPicked()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_SetAlwaysOnTopColorChooserTimer:
IfWinExist, Color Chooser ahk_class #32770
{
	WinActivate
	WinWaitActive, , , 0
	WinShow
	SetTimer, SCR_SetAlwaysOnTopColorChooserTimer, Off
} Else {
	SetTimer, SCR_SetAlwaysOnTopColorChooserTimer, -100
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_ShowColorChooser(PRM_InitHexaColor = 0x0, PRM_ParentWindow = 0x0, PRM_PosX = -1, PRM_PosY = -1, PRM_DialogTitle = "Color Chooser", PRM_CustomColors = 0) {

; PRM_InitHexaColor  : Dialog initialization color
; PRM_ParentWindow   : Parent Window ID : if passed, makes the dialog 'Modal', else dialog Always-On-Top
; PRM_PosX, PRM_PosY : Coordinates for Dialog placement : if PRM_ParentWindow not specified, refers to screen
; PRM_DialogTitle    : Dialog Title
; PRM_CustomColors   : Pipe-delimited list of 16 custom colors :
;                      selectively over-ride custom hexa colors by using blanks in the list,
;                      like in 402040|||||||FF5522||||||||FECADE

	Global SCR_VirtualScreenWidth, SCR_VirtualScreenHeight
	Static STA_ChosenColor := "", STA_ChosenHexaColor := "000000"
	If !(VarSetCapacity(STA_ChosenColor)) {
		LOC_ChooseColorCustomColorsDialogTemplate = ; Choosecolor 36 Bytes + CustomColors 64 Bytes + DialogTemplate 576 Bytes
		( LTrim Join
			2400000000000000000000000000000000000000470000000000000000000000000000000000000080000000
			0080000080800000000080008000800000808000C0C0C00080808000FF00000000FF0000FFFF00000000FF00
			FF00FF0000FFFF00FFFFFF00C020C880000000001B00020000002A01B8000000000043006F006C006F007200
			20002000200020002000200020002000200020002000200020002000200020002000000008004D0053002000
			5300680065006C006C00200044006C00670000000000025000000000040004008C000900FFFFFFFF82002600
			42006100730069006300200063006F006C006F00720073003A000000000000000B0003500000000004000E00
			8C005600D002FFFF8200000000000000000002500000000004006A008C000900FFFFFFFF8200260043007500
			730074006F006D00200063006F006C006F00720073003A00000000000B00035000000000040074008C001C00
			D102FFFF82000000000000000000035000000000040096008C000E00CF02FFFF800026004400650066006900
			6E006500200043007500730074006F006D00200043006F006C006F007200730020003E003E00000000000000
			01000350000000000400A6002C000E000100FFFF80004F004B0000000000000000000350000000003400A600
			2C000E000200FFFF8000430061006E00630065006C0000000000000000000350000000006400A6002C000E00
			0E04FFFF80002600480065006C007000000000000B100050000000009800040076007400C602FFFF82000000
			000000000B100050000000001801040008007400BE02FFFF82000000000000000B1000500000000098007C00
			28001A00C502FFFF820000000000000000000350000000002C01C80004000E00C902FFFF800026006F000000
			0000000002000250000000009800970014000900DA02FFFF820043006F006C006F0072000000000000000250
			00000000AC00970014000900DB02FFFF82007C00530026006F006C0069006400000000000200025000000000
			C2007E0014000900D302FFFF820048007500260065003A00000000000000835000000000D8007C0012000C00
			BF02FFFF81000000000000000200025000000000C2008C0014000900D402FFFF820026005300610074003A00
			000000000000835000000000D8008A0012000C00C002FFFF81000000000000000200025000000000C2009A00
			14000900D502FFFF820026004C0075006D003A00000000000000835000000000D800980012000C00C102FFFF
			81000000000000000200025000000000F3007E0018000900D602FFFF820026005200650064003A0000000000
			00008350000000000D017C0012000C00C202FFFF81000000000000000200025000000000F3008C0018000900
			D702FFFF8200260047007200650065006E003A000000000000008350000000000D018A0012000C00C302FFFF
			81000000000000000200025000000000F3009A0018000900D802FFFF820042006C002600750065003A000000
			0000000000008350000000000D01980012000C00C402FFFF810000000000000000000350000000009800A600
			8E000E00C802FFFF80002600410064006400200074006F00200043007500730074006F006D00200043006F00
			6C006F007200730000000000
		)
		Loop, % VarSetCapacity(STA_ChosenColor, StrLen(LOC_ChooseColorCustomColorsDialogTemplate) // 2, 0)
		{
			NumPut("0x" . SubStr(LOC_ChooseColorCustomColorsDialogTemplate, 2 * A_Index - 1, 2), STA_ChosenColor, A_Index - 1, "Char")
		}
	}
	Numput(&STA_ChosenColor + 100, STA_ChosenColor, 8), NumPut(&STA_ChosenColor + 36, STA_ChosenColor, 16) ; Pointers to CustomColors & DialogTemplate
	If (PRM_CustomColors != 0) {
		Loop, Parse, CustomColors, | ; Applying Custom Colors
		{
			_ := (A_LoopField != ""
					&& A_Index < 17)
						? NumPut("0x" A_LoopField, STA_ChosenColor, 36 + (4 * (A_Index - 1)))
						: 0
		}
	}
	If (PRM_DialogTitle
		&& (PRM_DialogTitle := SubStr(PRM_DialogTitle . "                      ", 1, 22)))
	, A_IsUnicode   ? DllCall("kernel32.dll\RtlMoveMemory", "UInt", &STA_ChosenColor + 122, "Str", PRM_DialogTitle, "UInt", StrLen(Title) * 2)
					: DllCall("kernel32.dll\MultiByteToWideChar", "Int", 0, "Int", 0, "Str", PRM_DialogTitle, "UInt", 22, "UInt", &STA_ChosenColor + 122, "UInt", 44)
	If (PRM_PosX == -1
		&& PRM_PosY == -1
		&& PRM_ParentWindow == 0) {
		PRM_PosX := (SCR_VirtualScreenWidth - 453) / 2
		, PRM_PosY := (SCR_VirtualScreenHeight - 327) / 2
		Transform, PRM_PosX, Round, PRM_PosX
		Transform, PRM_PosY, Round, PRM_PosY
	}
	NumPut(PRM_PosY, STA_ChosenColor, 112, "UShort"), NumPut(PRM_PosX, STA_ChosenColor, 110, "UShort"), NumPut(PRM_ParentWindow, STA_ChosenColor, 4) ; Y, X, Parent ID
	, NumPut((((PRM_InitHexaColor & 0xFF) << 16) | (PRM_InitHexaColor & 0xFF00) | ((PRM_InitHexaColor & 0xFF0000) >> 16)), STA_ChosenColor, 12)
	If (!DllCall("comdlg32.dll\ChooseColor" (A_IsUnicode ? "W" : "A"), "UInt", &STA_ChosenColor)
		|| ErrorLevel) {
		Return
	}
	DllCall("msvcrt.dll\s" (A_IsUnicode ? "w" : "") "printf", "Str", STA_ChosenHexaColor, "Str", "%06X", "UInt", ((((LOC_InitialHexaColor := Numget(STA_ChosenColor, 12)) & 0xFF) << 16) | (LOC_InitialHexaColor & 0xFF00) | ((LOC_InitialHexaColor & 0xFF0000) >> 16)))
	Return, STA_ChosenHexaColor
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; ASCII Art capture { AltGr + Win + PrintScreen } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_CaptureUnicode:
<^>!#PrintScreen::
SCR_CaptureUnicode()
Return

SCR_CaptureUnicode() {
	SCR_CharArt(PRM_Unicode := true)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_CaptureASCII:
<^>!+#PrintScreen::
SCR_CaptureASCII()
Return

SCR_CaptureASCII() {
	SCR_CharArt(PRM_Unicode := false)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_CharArt(PRM_Unicode = true, PRM_Destination = false, PRM_GuiTextWidth = false, PRM_GuiTextHeight = false) {

	Static STA_ArtChars := "Û²±° ", STA_ButtonWidth := 110, STA_ButtonHeight := 25, STA_Text, STA_ClipBoardButton, STA_FileButton, STA_CancelButton, STA_GuiID

	If (PRM_Destination == "Clipboard") {
		GuiControlGet, STA_Text
		TXT_SetClipboard(STA_Text)
		MsgBox, %STA_Text%
		Return
	}

	If (PRM_Destination) {
		Try {
			FileSelectFile, LOC_File, S16, % A_MyDocuments . "\" . (PRM_Unicode ? "UnicodeArt.txt" : "ASCIIArt.nfo"), Save to file...
			If (!ErrorLevel) {
				If (FileExist(LOC_File)) {
					FileDelete, %LOC_File%
				}
				GuiControlGet, STA_Text
				FileAppend, %STA_Text%, %LOC_File%, % (PRM_Unicode ? "UTF-8" : "")
			}
			Return
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "SCR_CharArt", PRM_Unicode, PRM_Destination, PRM_GuiTextWidth, PRM_GuiTextHeight)
			MsgBox, An error has occured while saving to file...
			Return
		}
	}

	LOC_ArtType := (PRM_Unicode ? "Unicode" : "ASCII")
	If (PRM_GuiTextWidth
		&& PRM_GuiTextHeight) {
		If (PRM_GuiTextWidth < 3 * STA_ButtonWidth + 20) { ; 2 * Margin (10)
			Gui, 40:Show, % "w" . (3 * STA_ButtonWidth + 20), %LOC_ArtType% Art Capture ; { Unicode | ASCII } Art Capture
		} Else {
			GuiControl, 40:Move, STA_Text, % "x0 y0 w" . PRM_GuiTextWidth . " h" . (PRM_GuiTextHeight - STA_ButtonHeight)
			GuiControl, 40:Move, STA_ClipBoardButton, % "y" . (PRM_GuiTextHeight - STA_ButtonHeight)
			GuiControl, 40:Move, STA_FileButton, % "y" . (PRM_GuiTextHeight - STA_ButtonHeight)
			GuiControl, 40:Move, STA_CancelButton, % "y" . (PRM_GuiTextHeight - STA_ButtonHeight)
		}
		Return
	}

	If ((LOC_Rectangle := SCR_DrawRectangle(LOC_ArtType . " Art")) != "canceled") {
		StringSplit, LOC_Rectangle, LOC_Rectangle, `,, %A_Space%%A_Tab%
		LOC_X := LOC_Left := LOC_Rectangle1
		, LOC_Y := LOC_Top := LOC_Rectangle2
		, LOC_Right := LOC_Rectangle3
		, LOC_Bottom := LOC_Rectangle4
		, LOC_ArtCharCount := StrLen(STA_ArtChars)
		, LOC_ArtCharString := ""
		Loop
		{
			If (LOC_X > LOC_Right) {
				LOC_X := LOC_Left
				, LOC_Y++
				, LOC_ArtCharString .= "`r`n"
				If (LOC_Y > LOC_Bottom) {
					Break
				}
			} Else {
				LOC_X++
			}

			CoordMode, Pixel, Screen
			PixelGetColor, LOC_Color, %LOC_X%, %LOC_Y%
			LOC_Blue := LOC_Color >> 16
			LOC_Green := (LOC_Color >> 8) & 0xFF
			LOC_Red := LOC_Color & 0xFF

			LOC_Char := Round(Round(0.299 * LOC_Red + 0.587 * LOC_Green + 0.114 * LOC_Blue) / 255 * LOC_ArtCharCount)
			StringMid, LOC_Char, STA_ArtChars, LOC_Char, 1
			LOC_ArtCharString .= LOC_Char
		}

		Gui, 40:Destroy ; { Unicode | ASCII } Art Capture
		Gui, 40:+Resize -MaximizeBox +LastFound
		Gui, 40:Margin, 10, 10
		Gui, 40:Font, s5, Terminal
		Gui, 40:Add, Edit, -Wrap +HScroll +VScroll +WantTab +WantReturn vSTA_Text, %LOC_ArtCharString%
		Gui, 40:Add, Button, y+1 w%STA_ButtonWidth% h%STA_ButtonHeight% +Center -Wrap gSCR_%LOC_ArtType%ArtToClipBoard vSTA_ClipBoardButton, &Copy to Clipboard
		Gui, 40:Add, Button, x+1 w%STA_ButtonWidth% h%STA_ButtonHeight% +Center -Wrap gSCR_%LOC_ArtType%ArtToFile vSTA_FileButton, &Save to File...
		Gui, 40:Add, Button, x+1 w%STA_ButtonWidth% h%STA_ButtonHeight% +Center -Wrap gSCR_CharArtCancel vSTA_CancelButton, Ca&ncel
		Gui, 40:Show, AutoSize, %LOC_ArtType% Art Capture
		ControlFocus, Button3
		WinGet, STA_GuiID, ID
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_UnicodeArtToClipBoard:
SCR_UnicodeArtToClipBoard()
Return

SCR_UnicodeArtToClipBoard() {
	SCR_CharArt(PRM_Unicode := true, "Clipboard")
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_UnicodeArtToFile:
SCR_UnicodeArtToFile()
Return

SCR_UnicodeArtToFile() {
	SCR_CharArt(PRM_Unicode := true, PRM_FileDestination := true)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_ASCIIArtToClipBoard:
SCR_ASCIIArtToClipBoard()
Return

SCR_ASCIIArtToClipBoard() {
	SCR_CharArt(PRM_Unicode := false, PRM_Destination := "Clipboard")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_ASCIIArtToFile:
SCR_ASCIIArtToFile()
Return

SCR_ASCIIArtToFile() {
	SCR_CharArt(PRM_Unicode := false, PRM_FileDestination := true)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCR_CharArtCancel:
Gui, 40:Destroy
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

40GuiSize:
40GuiSize()
Return

40GuiSize() {
	If (!ErrorLevel
		&& A_GuiWidth
		&& A_GuiHeight) {
		SCR_CharArt(, , A_GuiWidth, A_GuiHeight)
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

40GuiClose:
40GuiEscape:
Gui, 40:Destroy ; { Unicode | ASCII } Art Capture
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
