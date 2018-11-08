;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Tooltips :
;;;;;;;;;;;;

AHK_ToggleToolTip:
AHK_ToggleToolTip()
Menu, Options, Show
Return

^+#t::
AHK_ToggleToolTip()
, TRY_ShowTrayTip("Tooltips " . (AHK_ToolTipsEnabled ? "enabled" : "disabled"), (AHK_ToolTipsEnabled ? 1 : 2))
Return

AHK_ToggleToolTip() {
	Global
	AHK_ToolTipsEnabled := !AHK_ToolTipsEnabled
	, TRY_UpdateMenus()
	, AHK_SaveIniFile()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_ToggleTrayTip:
AHK_ToggleTrayTip()
Menu, Options, Show
Return

^+#b::
AHK_ToggleTrayTip()
, TRY_ShowTrayTip("Tray tips: " . (TRY_TrayTipEnabled ? "Enabled" : "Disabled"))
Return

AHK_ToggleTrayTip() {
	Global
	TRY_TrayTipEnabled := !TRY_TrayTipEnabled
	, TRY_UpdateMenus()
	, AHK_SaveIniFile()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_ShowToolTip(PRM_ToolTipText = "", PRM_ToolTipSeconds = 0.75, PRM_Transparency = 180, PRM_ToolTipX = 99999, PRM_ToolTipY = 99999, PRM_ToolTipWidth = 0, PRM_ToolTipHeight = 0, PRM_Bold = true) {
	Global AHK_ToolTipsEnabled, SCR_VirtualScreenX, SCR_VirtualScreenY, SCR_VirtualScreenWidth, SCR_VirtualScreenHeight
	Static STA_ToolTipBuffered = false
	If (AHK_ToolTipsEnabled) {
		If (PRM_ToolTipText) {
			LOC_CurrentGUI := (STA_ToolTipBuffered ? 45 : 44)
			, LOC_NextGUI := (STA_ToolTipBuffered ? 44 : 45)
			, LOC_NextGUITitle := (STA_ToolTipBuffered ? "GUI_ToolTip" : "GUI_BufferedToolTip")
			Gui, %LOC_NextGUI%:Destroy ; GUI_ToolTip | GUI_BufferedToolTip
			Gui, %LOC_NextGUI%:+AlwaysOnTop -Caption +Border -Resize +ToolWindow +Disabled +LastFound
			Gui, %LOC_NextGUI%:Color, FFFFDF, 000000
			Gui, %LOC_NextGUI%:Margin, 5, 5
			If (PRM_Bold) {
				Gui, %LOC_NextGUI%:Font, Bold
			}
			Gui, %LOC_NextGUI%:Add, Text, , %PRM_ToolTipText%
			Gui, %LOC_NextGUI%:Show, % "x" . (SCR_VirtualScreenX + SCR_VirtualScreenWidth) . " y" . (SCR_VirtualScreenY + SCR_VirtualScreenHeight) . " AutoSize NA NoActivate", %LOC_NextGUITitle%
			Try {
				WinSet, Transparent, %PRM_Transparency%
				WinSet, ExStyle, +0x00000020
			}
			WinGetPos, , , LOC_Width, LOC_Height
			CoordMode, Mouse, Screen
			MouseGetPos, LOC_MouseX, LOC_MouseY
			LOC_ToolTipX := min(max(PRM_ToolTipX != 99999 ? PRM_ToolTipX : LOC_MouseX + 24, SCR_VirtualScreenX), SCR_VirtualScreenX + SCR_VirtualScreenWidth - LOC_Width)
			, LOC_ToolTipY := min(max(PRM_ToolTipY != 99999 ? PRM_ToolTipY : LOC_MouseY + 34, SCR_VirtualScreenY), SCR_VirtualScreenY + SCR_VirtualScreenHeight - LOC_Height)
			If (LOC_ToolTipX != ""
				&& LOC_ToolTipY != "") { ; sometimes values are not affected : why ???
				Gui, %LOC_NextGUI%:Show, % "x" . LOC_ToolTipX . " y" . LOC_ToolTipY . (PRM_ToolTipWidth > 0 ? " w" . PRM_ToolTipWidth : "") . (PRM_ToolTipHeight > 0 ? " h" . PRM_ToolTipHeight : "") . " NA NoActivate", %LOC_NextGUITitle%
				Gui, %LOC_CurrentGUI%:Destroy
				If (PRM_ToolTipSeconds) {
					SetTimer, AHK_HideToolTipTimer, % - PRM_ToolTipSeconds * 1000
				}
			}
			STA_ToolTipBuffered := !STA_ToolTipBuffered
		} Else {
			AHK_HideToolTip()
		}
	}
	Return
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_HideToolTipTimer:
AHK_HideToolTip()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_HideToolTip() {
	Gui, 44:Destroy ; GUI_ToolTip
	Gui, 45:Destroy ; GUI_BufferedToolTip
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_ShowWindowToolTip(PRM_X, PRM_Y, PRM_Width, PRM_Height, PRM_Prefix = "", PRM_Suffix = "", PRM_Text = "", PRM_HiddenWindowEnabled = false, PRM_Transparency = 180, PRM_Distance = false) {

	Global 	SCR_VirtualScreenX, SCR_VirtualScreenY, SCR_VirtualScreenWidth, SCR_VirtualScreenHeight, ZZZ_HideWindowToolTipTimer
	Static STA_Width41 = 0, STA_Height41 = 0, STA_Width42 = 0, STA_Height42 = 0, STA_Width43 = 0, STA_Height43 = 0, STA_Margin = 10, STA_LeftTop, STA_WidthHeight, STA_RightBottom, STA_Prefix = "", STA_Suffix = "", STA_Text = "", STA_Distance = false, STA_Initializing := false

	LOC_Prefix := (PRM_Prefix ? PRM_Prefix . ": " : "")
	, LOC_Suffix := (PRM_Suffix ? " " . PRM_Suffix : "")
	SetTimer, AHK_HideWindowToolTip, Off
	If (STA_Width41 == 0) {
		If (STA_Initializing) {
			Return
		}
		STA_Initializing := true
		Gui, 41:+AlwaysOnTop -Caption +Border -Resize +ToolWindow +Disabled +LastFound ; GUI_LeftTopToolTip
		Gui, 41:Color, FFFFDF, 000000
		Gui, 41:Margin, 0, 5
		Gui, 41:Font, Bold
		Gui, 41:Add, Text, Center vSTA_LeftTop, % "(mmmm, mmmm)"
		Gui, 41:Show, % "AutoSize NoActivate y200 x" . (SCR_VirtualScreenX + SCR_VirtualScreenWidth), GUI_LeftTopToolTip
		WinSet, Transparent, %PRM_Transparency%
		WinSet, ExStyle, +0x00000020
		WinGetPos, , , STA_Width41, STA_Height41

		LOC_PixelUnit := (PRM_Distance ? "px" : "")
		Gui, 42:+AlwaysOnTop -Caption +Border -Resize +ToolWindow +Disabled +LastFound ; GUI_WidthHeightToolTip
		Gui, 42:Color, FFFFDF, 000000
		Gui, 42:Margin, 5, 5
		Gui, 42:Font, Bold
		Gui, 42:Add, Text, % (PRM_Text ? "" : "Center ") . "vSTA_WidthHeight", % LOC_Prefix . (PRM_Distance ? "mmmm px × mmmm px     –     [mm.m cm × mm.m cm]`nÐ = mmmm px     –     [mm.m cm]     –     mmm %" : "mmmm × mmmm") . LOC_Suffix
		If (PRM_Text) {
			Gui, 42:Add, Text, , %PRM_Text%
		}
		Gui, 42:Show, % "AutoSize NoActivate y400 x" . (SCR_VirtualScreenX + SCR_VirtualScreenWidth), GUI_WidthHeightToolTip
		WinSet, Transparent, %PRM_Transparency%
		WinSet, ExStyle, +0x00000020
		WinGetPos, , , STA_Width42, STA_Height42

		Gui, 43:+AlwaysOnTop -Caption +Border -Resize +ToolWindow +Disabled +LastFound ; GUI_RightBottomToolTip
		Gui, 43:Color, FFFFDF, 000000
		Gui, 43:Margin, 0, 5
		Gui, 43:Font, Bold
		Gui, 43:Add, Text, Center vSTA_RightBottom, % "(mmmm, mmmm)"
		Gui, 43:Show, % "AutoSize NoActivate y600 x" . (SCR_VirtualScreenX + SCR_VirtualScreenWidth), GUI_RightBottomToolTip
		WinSet, Transparent, %PRM_Transparency%
		WinSet, ExStyle, +0x00000020
		WinGetPos, , , STA_Width43, STA_Height43

		STA_Distance := PRM_Distance
		, STA_Prefix := PRM_Prefix
		, STA_Suffix := PRM_Suffix
		, STA_Initializing := false
	} Else
	
	If (PRM_Text != STA_Text
		|| STA_Distance != PRM_Distance
		|| PRM_Prefix != STA_Prefix
		|| PRM_Suffix != STA_Suffix) {
		Gui, 42:Destroy ; GUI_WidthHeightToolTip
		Gui, 42:+AlwaysOnTop -Caption +Border -Resize +ToolWindow +Disabled +LastFound
		Gui, 42:Color, FFFFDF, 000000
		Gui, 42:Margin, 5, 5
		Gui, 42:Font, Bold
		Gui, 42:Add, Text, % (PRM_Text ? "" : "Center ") . "vSTA_WidthHeight", % LOC_Prefix . (PRM_Distance ? "mmmm px × mmmm px     –     [mm.m cm × mm.m cm]`nÐ = mmmm px     –     [mm.m cm]     –     mmm %" : "mmmm × mmmm") . LOC_Suffix
		If (PRM_Text) {
			Gui, 42:Add, Text, , %PRM_Text%
		}
		Gui, 42:Show, % "AutoSize NoActivate y400 x" . (SCR_VirtualScreenX + SCR_VirtualScreenWidth), GUI_WidthHeightToolTip
		WinSet, Transparent, %PRM_Transparency%
		WinSet, ExStyle, +0x00000020
		WinGetPos, , , STA_Width42, STA_Height42

		STA_Text := PRM_Text
		, STA_Distance := PRM_Distance
		, STA_Prefix := PRM_Prefix
		, STA_Suffix := PRM_Suffix
	}

	LOC_X41 := (PRM_Width > 0 ? PRM_X + STA_Margin : PRM_X - STA_Width41 - STA_Margin)
	, LOC_Y41 := (PRM_Height > 0 ? PRM_Y + STA_Margin : PRM_Y - STA_Height41 - STA_Margin)
	, LOC_X43 := (PRM_Width > 0 ? PRM_X + PRM_Width - STA_Width43 - STA_Margin : PRM_X + PRM_Width + STA_Margin)
	, LOC_Y43 := (PRM_Height > 0 ? PRM_Y + PRM_Height - STA_Height43 - STA_Margin : PRM_Y + PRM_Height + STA_Margin)

	Loop, 3 {
		If (A_Index != 2) {
			LOC_X4%A_Index% := min(max(LOC_X4%A_Index%, SCR_VirtualScreenX + STA_Margin), SCR_VirtualScreenX + SCR_VirtualScreenWidth - STA_Width4%A_Index% - STA_Margin)
			, LOC_Y4%A_Index% := min(max(LOC_Y4%A_Index%, SCR_VirtualScreenY + STA_Margin), SCR_VirtualScreenY + SCR_VirtualScreenHeight - STA_Height4%A_Index% - STA_Margin)
		}
	}

	If ((LOC_Y41 - LOC_Y43) * PRM_Height > 0
		|| Abs(LOC_Y43 - LOC_Y41) - (PRM_Height > 0 ? STA_Height41 : STA_Height43) <= STA_Height42 + 1
			&& Abs(LOC_X43 - LOC_X41) - (PRM_Width > 0 ? STA_Width41 : STA_Width43) <= STA_Width42 + 1) {
		LOC_Y41 := (PRM_Height > 0 ? PRM_Y - STA_Height41 - STA_Margin : PRM_Y + STA_Margin)
		, LOC_Y43 := (PRM_Height > 0 ? PRM_Y + PRM_Height + STA_Margin : PRM_Y + PRM_Height - STA_Height43 - STA_Margin)
		Loop, 3 {
			If (A_Index != 2) {
				LOC_Y4%A_Index% := min(max(LOC_Y4%A_Index%, SCR_VirtualScreenY + STA_Margin), SCR_VirtualScreenY + SCR_VirtualScreenHeight - STA_Height4%A_Index% - STA_Margin)
			}
		}
	}

	If ((LOC_X41 - LOC_X43) * PRM_Width > 0
		|| Abs(LOC_X43 - LOC_X41) - (PRM_Width > 0 ? STA_Width41 : STA_Width43) <= STA_Width42 + 1
			&& Abs(LOC_Y43 - LOC_Y41) - (PRM_Height > 0 ? STA_Height41 : STA_Height43) <= STA_Height42 + 1) {
		LOC_X41 := (PRM_Width > 0 ? PRM_X - STA_Width41 - STA_Margin : PRM_X + STA_Margin)
		, LOC_X43 := (PRM_Width > 0 ? PRM_X + PRM_Width + STA_Margin : PRM_X + PRM_Width - STA_Width43 - STA_Margin)
		Loop, 3 {
			If (A_Index != 2) {
				LOC_X4%A_Index% := min(max(LOC_X4%A_Index%, SCR_VirtualScreenX + STA_Margin), SCR_VirtualScreenX + SCR_VirtualScreenWidth - STA_Width4%A_Index% - STA_Margin)
			}
		}
	}

	LOC_X42 := (LOC_X43 > LOC_X41 ? LOC_X41 + (LOC_X43 + STA_Width43 - LOC_X41 - STA_Width42) // 2 : LOC_X43 + (LOC_X41 + STA_Width41 - LOC_X43 - STA_Width42) // 2)
	, LOC_Y42 := (LOC_Y43 > LOC_Y41 ? LOC_Y41 + (LOC_Y43 + STA_Height43 - LOC_Y41 - STA_Height42) // 2 : LOC_Y43 + (LOC_Y41 + STA_Height41 - LOC_Y43 - STA_Height42) // 2)
	LOC_X42 := min(max(LOC_X42, SCR_VirtualScreenX + STA_Margin), SCR_VirtualScreenX + SCR_VirtualScreenWidth - STA_Width42 - STA_Margin)
	, LOC_Y42 := min(max(LOC_Y42, SCR_VirtualScreenY + STA_Margin), SCR_VirtualScreenY + SCR_VirtualScreenHeight - STA_Height42 - STA_Margin)
	, LOC_Width := Abs(PRM_Width)
	, LOC_Height := Abs(PRM_Height)
	, LOC_Distance := Round(Sqrt(PRM_Width * PRM_Width + PRM_Height * PRM_Height))
	

	If ((Abs(LOC_X43 - LOC_X41) > STA_Width41 + STA_Width42 + 1
			|| Abs(LOC_Y43 - LOC_Y41) > STA_Height41 + STA_Height42 + 1)
		&& (PRM_HiddenWindowEnabled
			|| STA_Width42 < Abs(PRM_Width) - 20
			|| STA_Height42 < Abs(PRM_Height) - 20)) {
		GuiControl, 41:, STA_LeftTop, % "(" . (PRM_X + 0) . ", " . (PRM_Y + 0) . ")"
		GuiControl, 42:, STA_WidthHeight, % LOC_Prefix . (PRM_Distance ? LOC_Width . " px × " . LOC_Height . " px     –     [" . AHK_Px2Cm(LOC_Width) . " × " . AHK_Px2Cm(LOC_Height) . "]`nÐ = " . LOC_Distance . " px     –     [" . AHK_Px2Cm(LOC_Distance) . "]     –     " . (LOC_Height ? Round(100 * LOC_Width / LOC_Height) . " %" : "") : LOC_Width . " × " . LOC_Height) . LOC_Suffix
		
		GuiControl, 43:, STA_RightBottom, % "(" . (PRM_X + PRM_Width) . ", " . (PRM_Y + PRM_Height) . ")"
		AHK_HideToolTip()
		Try {
			Gui, 41:Show, x%LOC_X41% y%LOC_Y41% w%STA_Width41% h%STA_Height41% NoActivate, GUI_LeftTopToolTip
			Gui, 42:Show, x%LOC_X42% y%LOC_Y42% w%STA_Width42% h%STA_Height42% NoActivate, GUI_WidthHeightToolTip
			Gui, 43:Show, x%LOC_X43% y%LOC_Y43% w%STA_Width43% h%STA_Height43% NoActivate, GUI_RightBottomToolTip
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "AHK_ShowWindowToolTip", PRM_X, PRM_Y, PRM_Width, PRM_Height, PRM_Prefix, PRM_Suffix, PRM_Text, PRM_HiddenWindowEnabled, PRM_Transparency, PRM_Distance)
		}
		SetTimer, AHK_HideWindowToolTip, %ZZZ_HideWindowToolTipTimer%
	} Else {
		Gui, 41:Hide
		Gui, 42:Hide
		Gui, 43:Hide
		LOC_ToolTipText := LOC_Prefix . "(" . PRM_X . ", " . PRM_Y . ") » (" . (PRM_X + PRM_Width) . ", " . (PRM_Y + PRM_Height) . ")`n"
			. (PRM_Distance ? "`n" : "") . LOC_Width . " px × " . LOC_Height . " px     –     [" . AHK_Px2Cm(LOC_Width) . " × " . AHK_Px2Cm(LOC_Height) . "]" . LOC_Suffix
			. (PRM_Distance ? "`nÐ = " . LOC_Distance . " px     –     [" . AHK_Px2Cm(LOC_Distance) . "]     –     " . (LOC_Height ? Round(100 * LOC_Width / LOC_Height) . " %" : "") : "")
			. (PRM_Text ? "`n`n" . PRM_Text : "")
		, AHK_ShowToolTip(LOC_ToolTipText, PRM_Seconds := 1, PRM_Transparency)
	}
}

AHK_Px2Cm(PRM_Pixels, PRM_Suffix = " cm") {
	Global SCR_PixelsPerMillimeter
	LOC_Millimeters := Round(Abs(PRM_Pixels) / SCR_PixelsPerMillimeter)
	Return, (LOC_Millimeters > 9 ? SubStr(LOC_Millimeters, 1, StrLen(LOC_Millimeters) - 1) : "0") . "." . SubStr(LOC_Millimeters, 0) . PRM_Suffix
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_HideWindowToolTip:
AHK_HideWindowToolTip()
Return

AHK_HideWindowToolTip() {
	Gui, 41:Hide ; GUI_LeftTopToolTip
	Gui, 42:Hide ; GUI_WidthHeightToolTip
	Gui, 43:Hide ; GUI_RightBottomToolTip
	AHK_HideToolTip()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Generic AHK Trace :
;;;;;;;;;;;;;;;;;;;;;

AHK_Trace(PRM_SecondLevelLog = false, PRM_String1 = "", PRM_String2 = "", PRM_String3 = "", PRM_String4 = "", PRM_String5 = "", PRM_String6 = "", PRM_String7 = "", PRM_String8 = "", PRM_String9 = "") {
	
	Global AHK_LogsEnabled, AHK_DebugEnabled, ZZZ_HideDebugTimer
	Static STA_QueryPerformanceCounter := AHK_GetFunction("kernel32", "QueryPerformanceCounter"), STA_Frequency := 0, STA_CounterInit := false
	
	If (!STA_CounterInit) {
		DllCall("kernel32.dll\QueryPerformanceFrequency", "Int64*", STA_Frequency)
		, STA_Frequency /= 1000
		, STA_CounterInit := true
	}

	; Log :
	If (AHK_LogsEnabled
		|| AHK_DebugEnabled) {
		LOC_FormatedLog := LOC_RawLog := LOC_Debug := ""
		Loop, 9 {
			If (IsObject(PRM_String%A_Index%)) {
				LOC_String := ""
				For LOC_Key, LOC_Value In PRM_String%A_Index%
				{
					LOC_String .= (LOC_String == "" ? "[`t" : ",`n`t") . LOC_Key . " => " . LOC_Value
				}
				LOC_String .= (LOC_String ? " ]" : "")
			} Else {
				LOC_String := PRM_String%A_Index%
			}
			If (LOC_String != "") {
				If (LOC_RawLog != "") {
					LOC_LastChar := SubStr(LOC_RawLog, 0)
					If LOC_LastChar Not In %A_Space%,`t,`n,`r,`v,`f
					{
						LOC_RawLog .= " "
					}
				}
				LOC_Debug := LOC_RawLog .= LOC_String
			}
		}

		FormatTime, LOC_Time, , % "dd/MM/yyyy HH:mm:ss"
		If (STA_Frequency) {
			DllCall(STA_QueryPerformanceCounter, "Int64*", LOC_Counter)
			, LOC_Time .= "." . SubStr(Round(LOC_Counter / STA_Frequency), -2)
		}
		LOC_Time .= " - "
		If (LOC_RawLog == "") { 
			LOC_RawLog := "`n"
		}
		Loop, Parse, LOC_RawLog, `n, `r
		{
			LOC_FormatedLog .= LOC_Time . A_LoopField . "`r`n"
		}
		Try {
			FileAppend, % LOC_FormatedLog, % A_ScriptDir . "\conf\" . A_Username . ".log"
		}
	}
	
	; Debug :
	If (AHK_DebugEnabled
		&& PRM_SecondLevelLog
		&& LOC_Debug != "") {
		ToolTip, %LOC_Debug%, , , 20
		SetTimer, ZZZ_HideDebugTimer, %ZZZ_HideDebugTimer%
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; AHK Log :
;;;;;;;;;;;

AHK_Log(PRM_String1 = "", PRM_String2 = "", PRM_String3 = "", PRM_String4 = "", PRM_String5 = "", PRM_String6 = "", PRM_String7 = "", PRM_String8 = "", PRM_String9 = "") {

	AHK_Trace(PRM_SecondLevelLog := false, PRM_String1, PRM_String2, PRM_String3, PRM_String4, PRM_String5, PRM_String6, PRM_String7, PRM_String8, PRM_String9)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_ToggleLogs:
AHK_ToggleLogs()
Menu, Options, Show
Return

^+#g::
AHK_ToggleLogs()
, TRY_ShowTrayTip("Logs: " . (AHK_LogsEnabled ? "Enabled" : "Disabled"))
Return

AHK_ToggleLogs() {
	Global
	AHK_LogsEnabled := !AHK_LogsEnabled
	, TRY_UpdateMenus()
	, AHK_SaveIniFile()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; AHK_Debug :
;;;;;;;;;;;;;

AHK_ToggleDebug:
AHK_ToggleDebug()
Menu, Options, Show
Return

^+#o::
AHK_ToggleDebug()
, TRY_ShowTrayTip("Debug: " . (AHK_DebugEnabled ? "Enabled" : "Disabled"))
Return

AHK_ToggleDebug() {
	Global
	AHK_DebugEnabled := !AHK_DebugEnabled
	, TRY_UpdateMenus()
	, AHK_SaveIniFile()
}

AHK_Debug(PRM_String1 = "", PRM_String2 = "", PRM_String3 = "", PRM_String4 = "", PRM_String5 = "", PRM_String6 = "", PRM_String7 = "", PRM_String8 = "", PRM_String9 = "") {

	AHK_Trace(PRM_SecondLevelLog := true, PRM_String1, PRM_String2, PRM_String3, PRM_String4, PRM_String5, PRM_String6, PRM_String7, PRM_String8, PRM_String9)
}

ZZZ_HideDebugTimer:
ToolTip, , , , 20
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; AHK_Catch :
;;;;;;;;;;;;;

AHK_Catch(PRM_Exception, PRM_FunctionName, PRM_Parameter1 = "<noValue>", PRM_Parameter2 = "<noValue>", PRM_Parameter3 = "<noValue>", PRM_Parameter4 = "<noValue>", PRM_Parameter5 = "<noValue>", PRM_Parameter6 = "<noValue>", PRM_Parameter7 = "<noValue>", PRM_Parameter8 = "<noValue>", PRM_Parameter9 = "<noValue>", PRM_Parameter10 = "<noValue>") {
	
	Global AHK_DebugEnabled
	LOC_Parameters := ""
	Loop, 10 {
		If (PRM_Parameter%A_Index% != "<noValue>") {
			LOC_Parameters .= (A_Index > 1 ? ", " : "") . PRM_Parameter%A_Index%
		} Else {
			Break
		}
	}
	LOC_File := PRM_Exception["File"]
	SplitPath, LOC_File, LOC_File
	LOC_Message := "! " . PRM_FunctionName . "(" . LOC_Parameters . ") : Exception on " . PRM_Exception["What"] . " in " . LOC_File . " (" . PRM_Exception["Line"] . ")"
	AHK_Debug(LOC_Message)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Min(PRM_X, PRM_Y) {
	Return, (PRM_X < PRM_Y ? PRM_X : PRM_Y)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Max(PRM_X, PRM_Y) {
	Return, (PRM_X > PRM_Y ? PRM_X : PRM_Y)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Pow(PRM_X, PRM_n) {
	Transform, LOC_Return, Pow, PRM_X, PRM_n
	Return LOC_Return
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_AdjustString(PRM_String, PRM_Length, PRM_Alignement = true, PRM_Char = "") {

	; PRM_Alignement : true : left-aligned, false : right-aligned
	LOC_Char := (StrLen(PRM_Char) == 0 ? " " : SubStr(PRM_Char, 1, 1))
	, LOC_Length := StrLen(PRM_String)
	, LOC_String := PRM_String

	; Right length :
	If (LOC_Length == PRM_Length) {
		Return, LOC_String
	}

	; Length to increase :
	If (LOC_Length < PRM_Length) {
		Loop, % PRM_Length - LOC_Length
		{
			If (PRM_Alignement) {
				LOC_String .= LOC_Char
			} Else {
				LOC_String := LOC_Char . LOC_String
			}
		}
	} Else

	; Length to decrease :
	If (LOC_Length > PRM_Length) {
		LOC_String := SubStr(LOC_String, 1 + (PRM_Alignement ? 0 : LOC_Length - PRM_Length), PRM_Length)
	}

	Return, LOC_String
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_KeyWait(PRM_Key1 = false, PRM_Key2 = false, PRM_Key3 = false, PRM_Key4 = false, PRM_Key5 = false, PRM_Key6 = false, PRM_Key7 = false, PRM_Key8 = false, PRM_Key9 = false) {

	Loop, 9 {
		If (PRM_Key%A_Index% == false) {
			Continue
		}
		If PRM_Key%A_Index% contains #,!,+,^
		{
			LOC_Keys := PRM_Key%A_Index%
			Loop, % StrLen(LOC_Keys)
			{
				LOC_Char := Substr(LOC_Keys, %A_Index%, 1)
				If (LOC_Char == "#") {
					KeyWait, LWin
					KeyWait, RWin
					Continue
				}
				If (LOC_Char == "!") {
					KeyWait, LAlt
					KeyWait, RAlt
					KeyWait, Alt
					Continue
				}
				If (LOC_Char == "+") {
					KeyWait, LShift
					KeyWait, RShift
					KeyWait, Shift
					Continue
				}
				If (LOC_Char == "^") {
					KeyWait, LCtrl
					KeyWait, RCtrl
					KeyWait, Ctrl
					Continue
				}
				KeyWait, % LOC_Char
			}
		} Else {
			KeyWait, % PRM_Key%A_Index%
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_RGBToBGR(PRM_RGB) {
	If (StrLen(PRM_RGB) != 6) {
		Return, false
	}

	Loop, Parse, PRM_RGB
	{
		If A_LoopField Not In 0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,a,b,c,d,e,f
		Return, false
	}

	StringMid, LOC_R, PRM_RGB, 1, 2
	StringMid, LOC_G, PRM_RGB, 3, 2
	StringMid, LOC_B, PRM_RGB, 5, 2

	Return, LOC_B . LOC_G . LOC_R
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_MsgBox(PRM_Value1 = "", PRM_Value2 = "", PRM_Value3 = "", PRM_Value4 = "", PRM_Value5 = "", PRM_Value6 = "", PRM_Value7 = "", PRM_Value8 = "", PRM_Value9 = "") {
	LOC_Text := ""
	Loop, 9 {
		If (IsObject(PRM_Value%A_Index%)) {
			For LOC_Index, LOC_Value in PRM_Value%A_Index%
			{
				LOC_Text .= (LOC_Text != "" ? "`n" : "") . LOC_Index . " --> " . LOC_Value
			}
		} Else If (PRM_Value%Index% != "") {
			LOC_Text .= (LOC_Text != "" ? "`n" : "") . PRM_Value%A_Index%
		}
	}
	MsgBox, %LOC_Text%
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_NotInArray(ByRef PRM_Text, PRM_Object) {
	For LOC_Key, LOC_Value In PRM_Object {
		If (LOC_Value == PRM_Text) {
			Return, false
		}
	}
	Return, true
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_PointerDelta(PRM_Pointer, PRM_Delta) {
	Return, NumGet(NumGet(PRM_Pointer + 0, "Ptr") + PRM_Delta * A_PtrSize, "Ptr")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_GetFunction(PRM_DLL, PRM_Function) {
	Static STA_GetProcAddressFunction := false, STA_LoadLibraryFunction := false, STA_GetModuleHandleFunction := false
	If (!STA_GetProcAddressFunction) {
		STA_GetProcAddressFunction := DllCall("kernel32.dll\GetProcAddress", "Ptr", DllCall("kernel32.dll\GetModuleHandle", "Str", "kernel32"), "AStr", "GetProcAddress")
	}
	If (!DllCall("kernel32.dll\GetModuleHandle", "Str", PRM_DLL, "Ptr")) {
		DllCall("kernel32.dll\LoadLibrary", "Str", PRM_DLL)
	}
	Return, DllCall(STA_GetProcAddressFunction, "Ptr", DllCall("kernel32.dll\GetModuleHandle", "Str", PRM_DLL), "AStr", PRM_Function)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_AdjustListView(PRM_FinalWidth, PRM_ColumnsNumber, PRM_ColumnsToAdjust := false, PRM_ListViewIndex = 1, PRM_WindowID = false) {

	; PRM_ColumnsToAdjust : indexes, separated by '|'

	LOC_CurrentWidth := 0
	Loop, %PRM_ColumnsNumber% {
		LV_ModifyCol(A_Index, "AutoHdr")
	}

	LOC_ColumnsToKeepA := {}
	, LOC_ColumnsToAdjust := PRM_ColumnsToAdjust
	Loop, %PRM_ColumnsNumber% {
		SendMessage, 0x1000+29, A_Index - 1, 0, SysListView32%PRM_ListViewIndex%, % (PRM_WindowID ? "ahk_id " . PRM_WindowID : "A")
		If (ErrorLevel == "FAIL") {
			Break
		}
		LOC_Width%A_Index% := ErrorLevel
		, LOC_CurrentWidth += LOC_Width%A_Index%
		, LOC_ColumnsToKeepA[A_Index] := true
		If (!PRM_ColumnsToAdjust) {
			LOC_ColumnsToAdjust .= "|" . A_Index
		}
	}

	LOC_TotalWidthToAdjust := 0
	Loop, Parse, PRM_ColumnsToAdjust, |
	{
		If (LOC_ColumnsToKeepA[A_LoopField]) {
			LOC_ColumnsToKeepA[A_LoopField] := false
			, LOC_TotalWidthToAdjust += LOC_Width%A_LoopField%
		}
	}

	If (LOC_CurrentWidth > PRM_FinalWidth) {
		For LOC_ColumnIndex In LOC_ColumnsToKeepA
		{
			If (!LOC_ColumnsToKeepA[LOC_ColumnIndex]) {
				LV_ModifyCol(LOC_ColumnIndex, LOC_Width%LOC_ColumnIndex% * LOC_TotalWidthToAdjust // LOC_CurrentWidth)
				AHK_Debug("LV_ModifyCol(" . LOC_ColumnIndex . ", " . LOC_Width%LOC_ColumnIndex% . " * " . LOC_TotalWidthToAdjust . " // " . LOC_CurrentWidth . ")")
			}
		}
		If (LOC_ColumnsToKeepA[PRM_ColumnsNumber]) {
			LV_ModifyCol(PRM_ColumnsNumber, "AutoHdr")
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_CreateBMPGradient(PRM_ToFile, PRM_RGB1, PRM_RGB2, PRM_Vertical = true) {

	Global ZZZ_CloseHandleFunction
	Static STA_WriteFileFunction := AHK_GetFunction("kernel32", "WriteFile")
	LOC_BGR1 := AHK_RGBToBGR(PRM_RGB1)
	, LOC_BGR2 := AHK_RGBToBGR(PRM_RGB2)
	If (!LOC_BGR1
		|| !LOC_BGR2) {
		AHK_Debug("Error < AHK_CreateBMPGradient(" . PRM_ToFile . ", " . PRM_RGB1 . ", " . PRM_RGB2 . ", " . PRM_Vertical . ")")
		Return, false
	}
	LOC_Handler := DllCall("kernel32.dll\CreateFile", "Str", PRM_ToFile, "UInt", 0x40000000, "UInt", 0, "UInt", 0, "UInt", 4, "UInt", 0, "UInt", 0)
	, LOC_FileString := "424d3e00000000000000360000002800000" . (PRM_Vertical ? "0010000000200000" : "0020000000100000") . "001001800000000000800000000000000000000000000000000000000" . LOC_BGR1 . (PRM_Vertical ? "00" : "") . LOC_BGR2 . (PRM_Vertical ? "00" : "0000")

	Loop, 62 {
		StringLeft, LOC_HexaChar, LOC_FileString, 2
		StringTrimLeft, LOC_FileString, LOC_FileString, 2
		LOC_HexaChar := "0x" . LOC_HexaChar
		DllCall(STA_WriteFileFunction, "UInt", LOC_Handler, "UChar *", LOC_HexaChar, "UInt", 1, "UInt *", LOC_Unused, "UInt", 0)
	}

	DllCall(ZZZ_CloseHandleFunction, "UInt", LOC_Handler)
	Return, PRM_ToFile
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Do Nothing :
;;;;;;;;;;;;;;

AHK_DoNothing:
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; File Windows information :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_GetFileInfo(PRM_File) {
;	FileDescription — v<ProductVersion> — © CompanyName

	Static STA_GetFileVersionInfoSizeAFunction := AHK_GetFunction("Version", "GetFileVersionInfoSizeA")
	, STA_GetFileVersionInfoAFunction := AHK_GetFunction("Version", "GetFileVersionInfoA")
	, STA_VerQueryValueAFunction := AHK_GetFunction("Version", "VerQueryValueA")
	, STA_sprintfFunction := AHK_GetFunction("msvcrt", "sprintf")
	, STA_lstrlenFunction := AHK_GetFunction("kernel32", "lstrlen")
	, STA_lstrcpyFunction := AHK_GetFunction("kernel32", "lstrcpy")
	LOC_Size := DllCall(STA_GetFileVersionInfoSizeAFunction, "Str", PRM_File, "UInt", 0)
	If (LOC_Size < 1)
	{
		Return, ""
	}
	VarSetCapacity(LOC_FileVersionInfo, LOC_Size, 0)
	, VarSetCapacity(LOC_Translation, 8)
	, DllCall(STA_GetFileVersionInfoAFunction, "Str", PRM_File, "Int", 0, "Int", LOC_Size, "UInt", &LOC_FileVersionInfo)
	If (!DllCall(STA_VerQueryValueAFunction, "UInt", &LOC_FileVersionInfo, "Str", "\VarFileInfo\Translation", "UIntP", LOC_Translation, "UInt", 0)
		|| !DllCall(STA_sprintfFunction, "Str", LOC_Translation, "Str", "%08X", "UInt", NumGet(LOC_Translation + 0)))
	{
		Return, ""
	}
	LOC_ReturnedInfos := ""
	, LOC_Infos := "FileDescription|ProductVersion|CompanyName"
	, LOC_InfoPointer := 0
	, LOC_SubBlock := "\StringFileInfo\" . SubStr(LOC_Translation, -3) . SubStr(LOC_Translation, 1, 4)
	Loop, Parse, LOC_Infos, |
	{
		If (!DllCall(STA_VerQueryValueAFunction, "UInt", &LOC_FileVersionInfo, "Str", LOC_SubBlock . "\" . A_LoopField, "UIntP", LOC_InfoPointer, "UInt", 0)) {
			Return, ""
		}
		VarSetCapacity(LOC_Info, DllCall(STA_lstrlenFunction, "UInt", LOC_InfoPointer))
		, DllCall(STA_lstrcpyFunction, "Str", LOC_Info, "UInt", LOC_InfoPointer)
		If (LOC_Info) {
			If (A_Index == 2) {
				LOC_ReturnedInfos .= "—  v"
			} Else
			If (A_Index == 3) {
				LOC_ReturnedInfos .= "—  © "
			}
			LOC_ReturnedInfos .= LOC_Info . "  "
		}
	}
	Return, LOC_ReturnedInfos
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_GetFormattedNumber(PRM_Number) {
	LOC_Number := "" . PRM_Number
	, LOC_FormattedNumber := ""
	While ((LOC_Length := StrLen(LOC_Number)) > 3) {
		LOC_FormattedNumber := " " . SubStr(LOC_Number, -2, 3) . LOC_FormattedNumber
		, LOC_Number := SubStr(LOC_Number, 1, LOC_Length - 3)
	}
	LOC_FormattedNumber := LOC_Number . LOC_FormattedNumber
	Return, LOC_FormattedNumber
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_GetLineCount(PRM_Text) {
	
	StringReplace, LOC_Text, PRM_Text, ž, , All
	StringReplace, LOC_Text, PRM_Text, `r`n, ž, All
	StringReplace, LOC_Text, LOC_Text, `n`r, ž, All
	StringReplace, LOC_Text, LOC_Text, `n, ž, All
	StringReplace, LOC_Text, LOC_Text, `r, ž, All
	LOC_Count := 1
	Loop, Parse, LOC_Text
	{
		If (A_LoopField == "ž") {
			LOC_Count++
		}
		LOC_LastChar := A_LoopField
	}
	If (LOC_LastChar == "ž") {
		LOC_Count--
	}
	Return, %LOC_Count%
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

