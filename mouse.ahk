;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Hovering scroll :
;;;;;;;;;;;;;;;;;;;

SYS_InitWheel() {
	Global ZZZ_ScrollAcceleration := 1
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SYS_WheelAccelerate() {
	
	Global ZZZ_ScrollAcceleration, SYS_ScroolBoost, SYS_ScrollLimit, SYS_ScrollTimeOut
	Static STA_ScrollDistance := 0, STA_ScrollMaxAcceleration := 1

	LOC_TimeSincePriorHotkey := A_TimeSincePriorHotkey
	If (A_PriorHotkey == A_ThisHotkey
		&& LOC_TimeSincePriorHotkey < SYS_ScrollTimeOut
		&& !WinActive("Pale Moon ahk_class MozillaWindowClass")) {
		
		; Remember how many times we've scrolled in the current direction
		STA_ScrollDistance++

		; Calculate acceleration factor using a 1/x curve
		, ZZZ_ScrollAcceleration := (1 < LOC_TimeSincePriorHotkey && LOC_TimeSincePriorHotkey < 80) ? (250.0 / LOC_TimeSincePriorHotkey) - 1 : 1
		MouseGetPos, , , , LOC_ControlClass
		If (SubStr(LOC_ControlClass, 1, 17) == "dopus.filedisplay") {
			ZZZ_ScrollAcceleration := min(ZZZ_ScrollAcceleration, 3)
		}

		; Apply boost
		If (SYS_ScroolBoost > 1
			&& STA_ScrollDistance > SYS_ScroolBoost) {
			; Hold onto the highest speed we've achieved during this boost
			If (ZZZ_ScrollAcceleration > STA_ScrollMaxAcceleration) {
				STA_ScrollMaxAcceleration := ZZZ_ScrollAcceleration
			} Else {
				ZZZ_ScrollAcceleration := STA_ScrollMaxAcceleration
			}
			ZZZ_ScrollAcceleration *= STA_ScrollDistance / SYS_ScroolBoost
		}

		; Validate
		ZZZ_ScrollAcceleration := (ZZZ_ScrollAcceleration > 1) ? ((ZZZ_ScrollAcceleration > SYS_ScrollLimit) ? SYS_ScrollLimit : Floor(ZZZ_ScrollAcceleration)) : 1
		If (ZZZ_ScrollAcceleration > 1) {
			AHK_ShowToolTip("× " . ZZZ_ScrollAcceleration)
		}
	} Else {
		STA_ScrollDistance := 0
		, ZZZ_ScrollAcceleration := STA_ScrollMaxAcceleration := 1
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SYS_WheelUp(PRM_Cancel = false) {
	Global ZZZ_ScrollAcceleration
	Static STA_Cancel := false
	STA_Cancel := PRM_Cancel
	If (PRM_Cancel) {
		Return
	}

	MouseGetPos, LOC_MouseX, LOC_MouseY, LOC_HoveredWindowID, LOC_ControlClass
	WinGetClass, LOC_WindowClass, ahk_id %LOC_HoveredWindowID%
	WinGetTitle, LOC_WindowTitle, ahk_id %LOC_HoveredWindowID%
	SYS_WheelAccelerate()
	, SYS_WheelDown(PRM_Cancel := true)
	, LOC_UltraEdit := (SubStr(LOC_WindowClass, 1, 4) == "Afx:" && InStr(LOC_WindowTitle, "UltraEdit") == "")
	Loop, %ZZZ_ScrollAcceleration% {
		If (STA_Cancel) {
			Return
		}
		If (LOC_UltraEdit) {
			ControlSend, %LOC_ControlClass%, {WheelUp}, ahk_id %LOC_HoveredWindowID%
		} Else {
			PostMessage, 0x20A, 120 << 16, (LOC_MouseY << 16) | (LOC_MouseX & 0xFFFF), %LOC_ControlClass%, ahk_id %LOC_HoveredWindowID%
			Sleep, 10
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SYS_WheelDown(PRM_Cancel = false) {
	Global ZZZ_ScrollAcceleration
	Static STA_Cancel := false
	STA_Cancel := PRM_Cancel
	If (PRM_Cancel) {
		Return
	}
	
	MouseGetPos, LOC_MouseX, LOC_MouseY, LOC_HoveredWindowID, LOC_ControlClass
	WinGetClass, LOC_WindowClass, ahk_id %LOC_HoveredWindowID%
	WinGetTitle, LOC_WindowTitle, ahk_id %LOC_HoveredWindowID%
	SYS_WheelAccelerate()
	, SYS_WheelUp(PRM_Cancel := true)
	, LOC_UltraEdit := (SubStr(LOC_WindowClass, 1, 4) == "Afx:" && InStr(LOC_WindowTitle, "UltraEdit") == "")
	Loop, %ZZZ_ScrollAcceleration% {
		If (STA_Cancel) {
			Return
		}
		If (LOC_UltraEdit) {
			ControlSend, %LOC_ControlClass%, {WheelDown}, ahk_id %LOC_HoveredWindowID%
		} Else {
			PostMessage, 0x20A, -120 << 16, (LOC_MouseY << 16) | (LOC_MouseX & 0xFFFF), %LOC_ControlClass%, ahk_id %LOC_HoveredWindowID%
			Sleep, 10
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WheelLeft::
^WheelUp::
SYS_WheelLeft()
Return

SYS_WheelLeft(PRM_Cancel = false) {
	Global ZZZ_ScrollAcceleration
	Static STA_Cancel := false
	STA_Cancel := PRM_Cancel
	If (PRM_Cancel) {
		Return
	}
	
	MouseGetPos, , , LOC_HoveredWindowID, LOC_ControlClass
	SYS_WheelAccelerate()
	, SYS_WheelRight(PRM_Cancel := true)
	Loop, %ZZZ_ScrollAcceleration% {
		If (STA_Cancel) {
			Return
		}
		SendMessage, 0x114, 0, 0, %LOC_ControlClass%, ahk_id %LOC_HoveredWindowID%
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WheelRight::
^WheelDown::
SYS_WheelRight()
Return

SYS_WheelRight(PRM_Cancel = false) {
	Global ZZZ_ScrollAcceleration
	Static STA_Cancel := false
	STA_Cancel := PRM_Cancel
	If (PRM_Cancel) {
		Return
	}
	
	MouseGetPos, , , LOC_HoveredWindowID, LOC_ControlClass
	SYS_WheelAccelerate()
	, SYS_WheelLeft(PRM_Cancel := true)
	Loop, %ZZZ_ScrollAcceleration% {
		If (STA_Cancel) {
			Return
		}
		SendMessage, 0x114, 1, 0, %LOC_ControlClass%, ahk_id %LOC_HoveredWindowID%
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Keyboard moving mouse :
;;;;;;;;;;;;;;;;;;;;;;;;;

#NumPad1::
^#NumPad1::
<^>!NumPad1::
#NumPad2::
^#NumPad2::
<^>!NumPad2::
#NumPad3::
^#NumPad3::
<^>!NumPad3::
#NumPad4::
^#NumPad4::
<^>!NumPad4::
#NumPad6::
^#NumPad6::
<^>!NumPad6::
#NumPad7::
^#NumPad7::
<^>!NumPad7::
#NumPad8::
^#NumPad8::
<^>!NumPad8::
#NumPad9::
^#NumPad9::
<^>!NumPad9::
SCR_KeyboardMoveMouse(A_ThisHotKey)
Return

SCR_KeyboardMoveMouse(PRM_HotKey = false) {
	
	If (PRM_HotKey) {
		LOC_Delta := (InStr(PRM_HotKey, "^") ? 1 : 5)
		LOC_AltGrDown := InStr(PRM_HotKey, "<^>!")
	}
	LOC_Direction := SubStr(PRM_HotKey, 0)
	If (LOC_Direction == 2) {
		MouseMove, 0, LOC_Delta, , R
	} Else If (LOC_Direction == 1) {
		MouseMove, -LOC_Delta, LOC_Delta, , R
	} Else If (LOC_Direction == 3) {
		MouseMove, LOC_Delta, LOC_Delta, , R
	} Else If (LOC_Direction == 4) {
		MouseMove, -LOC_Delta, 0, , R
	} Else If (LOC_Direction == 6) {
		MouseMove, LOC_Delta, 0, , R
	} Else If (LOC_Direction == 7) {
		MouseMove, -LOC_Delta, -LOC_Delta, , R
	} Else If (LOC_Direction == 8) {
		MouseMove, 0, -LOC_Delta, , R
	} Else If (LOC_Direction == 9) {
		MouseMove, LOC_Delta, -LOC_Delta, , R
	}
	If (!LOC_AltGrDown) {
		CoordMode, Mouse, Screen
		MouseGetPos, LOC_MouseX, LOC_MouseY
		AHK_SetCursor("Arrow")
		SetTimer, SCR_ResetMouseCursor, -1000 ; display mouse position for 1 second (cursor + tooltip)
		AHK_ShowToolTip(LOC_MouseX . ", " . LOC_MouseY)
	}
}

SCR_ResetMouseCursor:
AHK_ResetCursor()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Mouse rings :
;;;;;;;;;;;;;;;

SCR_MouseRingManager: 
SCR_MouseRingManager()
Return

SCR_MouseRingManager(PRM_Action := 2, PRM_Index := 0) {

	; PRM_Action == -2 : hide rings
	;            == -1 : delete rings
	;            ==  0 : init rings
	;            ==  1 : new ring
	;            ==  2 : move rings

	Global SCR_MouseRings, SCR_MouseTracesEnabled, SCR_VirtualScreenX, SCR_VirtualScreenY, SCR_VirtualScreenWidth, SCR_VirtualScreenHeight
	Static STA_RingCount := 10, STA_RingMinimumSize := 5, STA_RingMaximumSize := 20, STA_NoMoveTimer := 0
		, STA_Token := Gdip_Startup(), STA_DIBSection := false, STA_CompatibleDC := DllCall("gdi32.dll\CreateCompatibleDC", "UInt", 0)
		, STA_GraphicsClearFunction := AHK_GetFunction("gdiplus", "GdipGraphicsClear"), STA_UpdateLayeredWindowFunction := AHK_GetFunction("user32", "UpdateLayeredWindow")
		, STA_DrawEllipseFunction := AHK_GetFunction("gdiplus", "GdipDrawEllipse"), STA_FillEllipseFunction := AHK_GetFunction("gdiplus", "GdipFillEllipse")
		, STA_CreatePenFunction := AHK_GetFunction("gdiplus", "GdipCreatePen1"), STA_DeletePenFunction := AHK_GetFunction("gdiplus", "GdipDeletePen")
		, STA_CreateSolidFillFunction := AHK_GetFunction("gdiplus", "GdipCreateSolidFill"), STA_DeleteBrushFunction := AHK_GetFunction("gdiplus", "GdipDeleteBrush")
		, STA_Graphics := false, STA_OBM := false, STA_WindowID := false, STA_MouseX := false, STA_MouseY := false, STA_UpdateGraphics := false
		, STA_ColorA := Object(), STA_ThicknessA := Object(), STA_TransparencyA := Object(), STA_RingTypeA := Object(), STA_VisibilityA := Object()
		, STA_PosXA := Object(), STA_PosYA := Object(), STA_WidthA := Object(), STA_HeightA := Object(), STA_DeltaXA := Object(), STA_DeltaYA := Object()

	; Init rings :
	;;;;;;;;;;;;;;
	If (PRM_Action == 0) {
		Gui, 50:-Caption +E0x80000 +LastFound +OwnDialogs +Owner +AlwaysOnTop +Disabled +HwndSTA_WindowID ; GUI_MouseRings
		Gui, 50:Show, NA, GUI_MouseRings
		WinSet, ExStyle, +0x00000020, ahk_id %STA_WindowID%
		STA_DIBSection := SCR_CreateDIBSection(SCR_VirtualScreenWidth, SCR_VirtualScreenHeight)
		, STA_OBM := DllCall("gdi32.dll\SelectObject", "UInt", STA_CompatibleDC, "UInt", STA_DIBSection)
		, DllCall("gdiplus\GdipCreateFromHDC", "UInt", STA_CompatibleDC, "UInt*", STA_Graphics)
		CoordMode, Mouse, Screen
		MouseGetPos, STA_MouseX, STA_MouseY

		Loop, %STA_RingCount% { 
			SCR_MouseRingManager(PRM_Action := 1, PRM_Index := A_Index)
		}
		DllCall("gdiplus.dll\GdipSetSmoothingMode", "UInt", STA_Graphics, "Int", 4)
		If (SCR_MouseTracesEnabled) {
			SetTimer, SCR_MouseRingManager, %SCR_MouseRings%
		}
		Return
	}
	
	; New ring :
	;;;;;;;;;;;;
	If (PRM_Action == 1) {
		Random, LOC_Hexa, 50, 170
		Random, LOC_HexaRed, 100, 255
		Random, LOC_HexaGreen, 100, 255
		Random, LOC_HexaBlue, 100, 255
		SetFormat, Integer, Hex
		LOC_Hexa += 0
		, LOC_HexaRed += 0
		, LOC_HexaGreen += 0
		, LOC_HexaBlue += 0
		SetFormat, Integer, D
		STA_TransparencyA[PRM_Index] := LOC_Hexa + 0
		, STA_ColorA[PRM_Index] := SubStr(LOC_HexaRed, -1) . SubStr(LOC_HexaGreen, -1) . SubStr(LOC_HexaBlue, -1)
		CoordMode, Mouse, Screen
		MouseGetPos, LOC_X, LOC_Y
		STA_PosXA[PRM_Index] := LOC_X
		, STA_PosYA[PRM_Index] := LOC_Y
		
		If ((STA_MouseX - STA_PosXA[PRM_Index]) * (STA_MouseX - STA_PosXA[PRM_Index]) + (STA_MouseY - STA_PosYA[PRM_Index]) * (STA_MouseY - STA_PosYA[PRM_Index]) < 16
			|| WinExist("GUI_Magnifier ahk_class AutoHotkeyGUI")
			|| (GetKeyState("RAlt", "P") 
				&& !GetKeyState("LWin", "P") 
				&& !GetKeyState("RWin", "P") 
				&& !GetKeyState("PrintScreen", "P"))) {
			If (STA_NoMoveTimer < 30000) {
				STA_TransparencyA[PRM_Index] := 10
				STA_VisibilityA[PRM_Index] := false
				, STA_NoMoveTimer++
			}
		} Else {
			STA_VisibilityA[PRM_Index] := true
			, STA_NoMoveTimer := 0
		}
		STA_MouseX := LOC_X
		, STA_MouseY := LOC_Y

		Random, LOC_Random, -0.5, 0.5
		STA_DeltaXA[PRM_Index] := LOC_Random
		Random, LOC_Random, -0.8, 0.5
		STA_DeltaYA[PRM_Index] := LOC_Random
		Random, LOC_Random, 0, 1
		STA_RingTypeA[PRM_Index] := LOC_Random
		Random, LOC_Random, STA_RingMinimumSize, STA_RingMaximumSize
		STA_PosXA[PRM_Index] -= (LOC_Random / 2)
		, STA_PosYA[PRM_Index] -= (LOC_Random / 2)
		, STA_WidthA[PRM_Index] := STA_HeightA[PRM_Index] := LOC_Random

		Random, LOC_Random, 1, LOC_Random
		STA_ThicknessA[PRM_Index] := LOC_Random
		Return
	}
	
	; Move rings :
	;;;;;;;;;;;;;;
	If (PRM_Action == 2) {
		If (STA_UpdateGraphics) {
			DllCall(STA_GraphicsClearFunction, "UInt", STA_Graphics, "Int", 0x00ffffff)
			, STA_UpdateGraphics := false
		}
		Loop, %STA_RingCount% {
			If (STA_TransparencyA[A_Index] >= 10) {
				Random, LOC_FadeOut, 5, 10
				STA_TransparencyA[A_Index] -= LOC_FadeOut
				, STA_PosXA[A_Index] += STA_DeltaXA[A_Index]
				, STA_PosYA[A_Index] += STA_DeltaYA[A_Index]
			} Else {
				SCR_MouseRingManager(PRM_Action := 1, PRM_Index := A_Index)
			}

			LOC_HexaTransparency := STA_TransparencyA[A_Index]
			SetFormat, Integer, Hex
			LOC_HexaTransparency += 0
			SetFormat, Integer, D
			LOC_ARGB := LOC_HexaTransparency . STA_ColorA[A_Index]
			, STA_UpdateGraphics |= STA_VisibilityA[A_Index]
			
			If (STA_VisibilityA[A_Index]) {
				If (STA_RingTypeA[A_Index] == 0) {
					DllCall(STA_CreatePenFunction, "Int", LOC_ARGB, "Float", STA_ThicknessA[A_Index], "Int", 2, "UInt*", LOC_Pen)
					, DllCall(STA_DrawEllipseFunction, "UInt", STA_Graphics, "UInt", LOC_Pen, "Float", STA_PosXA[A_Index], "Float", STA_PosYA[A_Index], "Float", STA_WidthA[A_Index], "Float", STA_HeightA[A_Index])
					, DllCall(STA_DeletePenFunction, "UInt", LOC_Pen)
				} Else {
					DllCall(STA_CreateSolidFillFunction, "Int", LOC_ARGB, "UInt*", LOC_Brush)
					, DllCall(STA_FillEllipseFunction, "UInt", STA_Graphics, "UInt", LOC_Brush, "Float", STA_PosXA[A_Index], "Float", STA_PosYA[A_Index], "Float", STA_WidthA[A_Index], "Float", STA_HeightA[A_Index])
					, DllCall(STA_DeleteBrushFunction, "UInt", LOC_Brush)
				}
			}
		}
		If (STA_UpdateGraphics) {
			VarSetCapacity(LOC_Pointer, 8), NumPut(0, LOC_Pointer, 0), NumPut(0, LOC_Pointer, 4)
			, DllCall(STA_UpdateLayeredWindowFunction
				, "UInt", STA_WindowID
				, "UInt", 0
				, "UInt", &LOC_Pointer
				, "Int64*", SCR_VirtualScreenWidth | SCR_VirtualScreenHeight << 32
				, "UInt", STA_CompatibleDC
				, "Int64*", 0
				, "UInt", 0
				, "UInt*", 255 << 16 | 1 << 24
				, "UInt", 2)
		}
		Return
	}

	; Delete rings :
	;;;;;;;;;;;;;;;;
	If (PRM_Action == -1) {
		DllCall("gdi32.dll\SelectObject", "UInt", STA_CompatibleDC, "UInt", STA_OBM)
		DllCall("gdi32.dll\DeleteObject", "UInt", STA_DIBSection)
		DllCall("gdi32.dll\DeleteDC", "UInt", STA_CompatibleDC)
		DllCall("gdiplus.dll\GdipDeleteGraphics", "UInt", STA_Graphics)
		Gdip_Shutdown(STA_Token)
		Return
	}

	; Hide rings :
	;;;;;;;;;;;;;;
	If (PRM_Action == -2) {
		DllCall(STA_GraphicsClearFunction, "UInt", STA_Graphics, "Int", 0x00ffffff)
		, STA_UpdateGraphics := false
		Loop, %STA_RingCount% {
			STA_VisibilityA[A_Index] := false
		}
		Return
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Gdip_Startup() {
	if !DllCall("GetModuleHandle", "Str", "gdiplus")
		DllCall("LoadLibrary", "Str", "gdiplus")
	VarSetCapacity(si, 16, 0), si := Chr(1)
	DllCall("gdiplus\GdiplusStartup", "UInt*", pToken, "UInt", &si, "UInt", 0)
	Return, pToken
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Gdip_Shutdown(pToken) {
	DllCall("gdiplus\GdiplusShutdown", "UInt", pToken)
	if hModule := DllCall("GetModuleHandle", "Str", "gdiplus")
		DllCall("FreeLibrary", "UInt", hModule)
	Return, 0
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; X-Window switching focus (focus follows mouse) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/**
 * Provided a 'X Window' like focus switching by mouse cursor movement. After
 * activation of this feature (by using the responsible entry in the Tray icon
 * menu) the focus will follow the mouse cursor with a delayed focus change
 * (after movement end) of 500 milliseconds (half a second). This feature is
 * disabled per default to avoid any confusion due to the new user-interface-flow.
 */

WIN_ToggleFocusFollowsMouse:
WIN_ToggleFocusFollowsMouse()
Menu, Options, Show
Return
^+#f::
WIN_ToggleFocusFollowsMouse()
, TRY_ShowTrayTip("X-Mouse focus: " . (WIN_FocusFollowsMouseEnabled ? "On" : "Off"), 2)
Return

WIN_ToggleFocusFollowsMouse() {
	Global
	WIN_FocusFollowsMouseEnabled := !WIN_FocusFollowsMouseEnabled
	, WIN_SetFocusFollowsMouse()
	, AHK_SaveIniFile()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_SetFocusFollowsMouse() {
	Global WIN_FocusFollowsMouseEnabled, ZZZ_XWindowFocusPeriodicTimer
	If (WIN_FocusFollowsMouseEnabled) {
		SetTimer, WIN_XWindowFocusPeriodicTimer, %ZZZ_XWindowFocusPeriodicTimer%
	} Else {
		SetTimer, WIN_XWindowFocusPeriodicTimer, Off
	}
	TRY_UpdateMenus()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_XWindowFocusPeriodicTimer:
WIN_XWindowFocus()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_XWindowFocus() {
	Global ZZZ_XWindowFocusPeriodicTimer
	Static STA_FocusRequest := false, STA_MouseX := -1, STA_MouseY := -1, STA_MouseMovedTickCount := 0
	CoordMode, Mouse, Screen
	MouseGetPos, LOC_MouseX, LOC_MouseY, LOC_HoveredWindowID
	If (!LOC_HoveredWindowID) {
		Return
	}

	If (LOC_MouseX != STA_MouseX
		|| LOC_MouseY != STA_MouseY) {
		STA_FocusRequest := !WinActive("ahk_id " . LOC_HoveredWindowID)
		, STA_MouseX := LOC_MouseX
		, STA_MouseY := LOC_MouseY
		, STA_MouseMovedTickCount := A_TickCount
	} Else {
		If (STA_FocusRequest
			&& A_TickCount - STA_MouseMovedTickCount > ZZZ_XWindowFocusPeriodicTimer) {
			WinGetClass, LOC_WindowClass, ahk_id %LOC_HoveredWindowID%
			If (AHK_SystemWindowClass(LOC_WindowClass)) {
				Return
			}


			; checks wheter the selected window is a popup menu
			; (WS_POPUP) && !(WS_DLGFRAME | WS_SYSMENU | WS_THICKFRAME)
			WinGet, LOC_WindowStyle, Style, ahk_id %LOC_HoveredWindowID%
			If ((LOC_WindowStyle & 0x80000000)
				&& !(LOC_WindowStyle & 0x4C0000)) {
				Return
			}

			IfWinNotActive, ahk_id %LOC_HoveredWindowID%
			{
				WinActivate, ahk_id %LOC_HoveredWindowID%
				WinWaitActive, ahk_id %LOC_HoveredWindowID%, , 0
				WinShow, ahk_id %LOC_HoveredWindowID%
			}

			STA_FocusRequest := false
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

