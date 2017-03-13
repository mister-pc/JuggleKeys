;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Audio level { [ Ctrl + ] [ Alt + ] Win + [ Shift + ] { Up | Down | Wheel in full screen media applications } } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AUD_Level:
#Up::
+#Up::
^#Up::
^+#Up::
!#Up::
<^>!#Up::
!+#Up::
<^>!+#Up::
^!#Up::
>^<^>!#Up::
^!+#Up::
>^<^>!+#Up::
#Down::
+#Down::
^#Down::
^+#Down::
!#Down::
<^>!#Down::
!+#Down::
<^>!+#Down::
^!#Down::
>^<^>!#Down::
^!+#Down::
>^<^>!+#Down::
AUD_Level(A_ThisHotKey)
Return

Volume_Up::
+Volume_Up::
^Volume_Up::
^+Volume_Up::
!Volume_Up::
<^>!Volume_Up::
<^>!+Volume_Up::
^!Volume_Up::
>^<^>!Volume_Up::
^!+Volume_Up::
>^<^>!+Volume_Up::
Volume_Down::
+Volume_Down::
^Volume_Down::
^+Volume_Down::
!Volume_Down::
<^>!Volume_Down::
!+Volume_Down::
<^>!+Volume_Down::
^!Volume_Down::
>^<^>!Volume_Down::
^!+Volume_Down::
>^<^>!+Volume_Down::
AUD_Level(A_ThisLabel)
Return

#IfWinActive, ahk_group AUD_MediaWindowsGroup
WheelUp::
+WheelUp::
^WheelUp::
^+WheelUp::
!WheelUp::
<^>!WheelUp::
!+WheelUp::
<^>!+WheelUp::
^!WheelUp::
>^<^>!WheelUp::
^!+WheelUp::
>^<^>!+WheelUp::
WheelDown::
+WheelDown::
^WheelDown::
^+WheelDown::
!WheelDown::
<^>!WheelDown::
!+WheelDown::
<^>!+WheelDown::
^!WheelDown::
>^<^>!WheelDown::
^!+WheelDown::
>^<^>!+WheelDown::
AUD_Level((GetKeyState("LButton") ? "^" : "") . A_ThisHotKey)
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AUD_Level(PRM_HotKey, PRM_ShowVolumeBar = true) {

	Global AUD_MasterVolume, AUD_WaveVolume, AUD_Step, AUD_BigStep, AUD_NoMasterVolume
	LOC_AltGrDown := GetKeyState("RAlt")
	, LOC_CtrlDown := LOC_AltGrDown && GetKeyState("RCtrl")
						|| !LOC_AltGrDown && GetKeyState("Ctrl")
	, LOC_Delta := (InStr(PRM_HotKey, "Up") ? "+" : "-")
	
	If (InStr(PRM_HotKey, "+"))	{
		LOC_Delta .= (LOC_CtrlDown ? AUD_Step : AUD_BigStep)
	} Else {
		LOC_Delta .= (LOC_CtrlDown ? 1 : AUD_Step)
	}

	If (AUD_NoMasterVolume
		|| InStr(PRM_HotKey, "!"))	{
		LOC_Component := "Wave"
		, LOC_OtherComponent := "Master"
	} Else {
		LOC_Component := "Master"
		, LOC_OtherComponent := "Wave"
	}

	LOC_InitialMuteState := AUD_SoundGet("", "Mute")
	LOC_Current%LOC_Component%Volume := Round(Max(0, Min(AUD_%LOC_Component%Volume + LOC_Delta, 100)))

	If (LOC_Delta > 0) {
		If (LOC_InitialMuteState == "On") {
			If (AUD_%LOC_OtherComponent%Volume > 0) {
				If (AUD_%LOC_Component%Volume > 0) {
					AUD_SetVolume(LOC_Component, AUD_%LOC_Component%Volume)
				} Else {
					AUD_SetVolume(LOC_Component, LOC_Current%LOC_Component%Volume)
				}
				If (PRM_ShowVolumeBar) {
					AUD_ShowVolumeBar(PRM_MuteState := "Off")
				}
				SetTimer, AUD_MuteTimer, -1
			} Else If (LOC_InitialMuteState == "Off") {
				AUD_SetVolume(LOC_Component, LOC_Current%LOC_Component%Volume)
				If (PRM_ShowVolumeBar) {
					AUD_ShowVolumeBar()
				}
			}
			Return
		}
	} Else {
		If (LOC_Current%LOC_Component%Volume == 0
			&& LOC_InitialMuteState == "Off") {
			AUD_SetVolume(LOC_Component, LOC_Current%LOC_Component%Volume)
			If (PRM_ShowVolumeBar) {
				AUD_ShowVolumeBar(PRM_MuteState := "On")
			}
			SetTimer, AUD_MuteTimer, -1
			Return
		}
	}
	AUD_SetVolume(LOC_Component, LOC_Current%LOC_Component%Volume)
	If (PRM_ShowVolumeBar) {
		AUD_ShowVolumeBar(LOC_InitialMuteState)
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AUD_SetVolume(PRM_Component, PRM_Volume) {

	Global AUD_MasterVolume, AUD_WaveVolume
	PRM_Volume := Round(PRM_Volume)
	AUD_SoundSet(PRM_Volume, PRM_Component)
	Loop
	{
		AUD_%PRM_Component%Volume := AUD_SoundGet(PRM_Component)
		If (AUD_%PRM_Component%Volume == "") {
			Break
		}
		AUD_%PRM_Component%Volume := Round(AUD_%PRM_Component%Volume)
		If (AUD_%PRM_Component%Volume > PRM_Volume) {
			AUD_SoundSet("-1", PRM_Component)
		} Else If (AUD_%PRM_Component%Volume < PRM_Volume) {
			AUD_SoundSet("+1", PRM_Component)
		} Else {
			Break
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Tray icon shortcuts :
;;;;;;;;;;;;;;;;;;;;;;;
AUD_MasterVolumeFineUp:
AUD_Level("^#Up")
Return
AUD_MasterVolumeUp:
AUD_Level("#Up")
Return
AUD_MasterVolumeUpUp:
AUD_Level("+#Up")
Return
AUD_MasterVolumeFineDown:
AUD_Level("^#Down")
Return
AUD_MasterVolumeDown:
AUD_Level("#Down")
Return
AUD_MasterVolumeDownDown:
AUD_Level("+#Down")
Return
AUD_WaveVolumeFineUp:
AUD_Level("^!#Up")
Return
AUD_WaveVolumeUp:
AUD_Level("^#Up")
Return
AUD_WaveVolumeUpUp:
AUD_Level("!+#Up")
Return
AUD_WaveVolumeFineDown:
AUD_Level("^!#Down")
Return
AUD_WaveVolumeDown:
AUD_Level("!#Down")
Return
AUD_WaveVolumeDownDown:
AUD_Level("!+#Down")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AUD_Init() {

	Global
	Local LOC_WaveVolumeBarPosY, LOC_VolumeBarThickness := 20
	GroupAdd, AUD_MediaWindowsGroup, BSPlayer ahk_class BSPVideoWindow
	GroupAdd, AUD_MediaWindowsGroup, ahk_class WMPTransition
	GroupAdd, AUD_MediaWindowsGroup, ahk_class ShockwaveFlashFullScreen
	GroupAdd, AUD_MediaWindowsGroup, GUI_VolumeBar ahk_class AutoHotkeyGUI
	AUD_WaveVolume := Round(AUD_SoundGet("Wave"))
	AUD_MasterVolume := AUD_SoundGet()
	If (AUD_MasterVolume == "") {
		AUD_NoMasterVolume := true
		, AUD_MasterVolume := AUD_WaveVolume
	} Else {
		AUD_NoMasterVolume := false
		, AUD_MasterVolume := Round(AUD_MasterVolume)
	}
	AUD_SoundSet(50, "PCSpeaker")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AUD_ShowVolumeBar(PRM_MuteState = "") {

	Global AUD_MasterVolume, AUD_WaveVolume, AUD_NoMasterVolume, ZZZ_DestroyVolumeBarTimer
	Static STA_MasterBackgroundColor, STA_WaveBackgroundColor, STA_MasterText, STA_WaveText
	LOC_VolumeBarThickness := 20
	If (PRM_MuteState == "") {
		LOC_MuteState := AUD_SoundGet("", "Mute")
		If (ErrorLevel) {
			TRY_ShowTrayTip("Audio: " . ErrorLevel, 2)
			Return
		}
	} Else {
		LOC_MuteState := PRM_MuteState
	}

	SetTimer, AUD_DestroyVolumeBarTimer, Off
	LOC_MasterBackgroundColor := (AUD_MasterVolume == 0 || LOC_MuteState == "On" ? "Silver" : "Gray")
	, LOC_WaveBackgroundColor := (AUD_WaveVolume == 0 || LOC_MuteState == "On" ? "Silver" : "Gray")

	If (LOC_MasterBackgroundColor != STA_MasterBackgroundColor
		|| LOC_WaveBackgroundColor != STA_WaveBackgroundColor
		|| !WinExist("GUI_VolumeBar ahk_class AutoHotkeyGUI")) {
		Gui, 47:Destroy ; GUI_VolumeBar
		Gui, % "47:+AlwaysOnTop -Caption +Disabled -Owner -SysMenu +ToolWindow +LastFound " . (LOC_MuteState == "On" ? "-" : "+") . "Border"
		Gui, 47:Margin, 5, 5
		Gui, 47:Font, s8 Bold, Verdana
		Try {
			If (AUD_NoMasterVolume) {
				Gui, 47:Add, Progress, W200 H40 CNavy Background%LOC_MasterBackgroundColor% vAUD_WaveVolume
				Gui, 47:Add, Text, xp yp+13 W200 H17 CWhite Center BackgroundTrans vSTA_WaveText
			} Else {
				Gui, 47:Add, Progress, W200 H20 CNavy Background%LOC_MasterBackgroundColor% vAUD_MasterVolume
				Gui, 47:Add, Text, xp yp+3 W200 H17 CWhite Center BackgroundTrans vSTA_MasterText
				Gui, 47:Add, Progress, W200 H20 CMaroon Background%LOC_WaveBackgroundColor% vAUD_WaveVolume
				Gui, 47:Add, Text, xp yp+3 W200 H17 CWhite Center BackgroundTrans vSTA_WaveText
			}
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "AUD_ShowVolumeBar", PRM_MuteState ? "true" : "false")
			Gui, 47:Destroy
			Return
		}
		WinSet, ExStyle, +0x00000020
		WinSet, Transparent, 192
		Gui, 47:Show, AutoSize Center NoActivate, % "GUI_VolumeBar"
		STA_MasterBackgroundColor := LOC_MasterBackgroundColor
		, STA_WaveBackgroundColor := LOC_WaveBackgroundColor
	}

	If (AUD_NoMasterVolume) {
		GuiControl, 47:, AUD_WaveVolume, %AUD_WaveVolume%
		GuiControl, 47:, STA_WaveText, % "Volume : " . AUD_WaveVolume . " %"
	} Else {
		GuiControl, 47:, AUD_MasterVolume, %AUD_MasterVolume%
		GuiControl, 47:, STA_MasterText, % "Master : " . AUD_MasterVolume . " %"
		GuiControl, 47:, AUD_WaveVolume, %AUD_WaveVolume%
		GuiControl, 47:, STA_WaveText, % "Wave : " . AUD_WaveVolume . " %"
	}
	Gui, 47:Show, NoActivate
	SetTimer, AUD_DestroyVolumeBarTimer, %ZZZ_DestroyVolumeBarTimer%
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AUD_DestroyVolumeBarTimer:
If (GetKeyState("RWin")
	|| GetKeyState("LWin")) {
	SetTimer, AUD_DestroyVolumeBarTimer, %ZZZ_DestroyVolumeBarTimer%
} Else {
	Gui, 47:Destroy
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Audio mute on/off { ScrollLock } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AUD_Mute:
ScrollLock::
Volume_Mute::
AUD_Mute()
Return

AUD_MuteTimer:
AUD_MuteTimer()
Return

AUD_MuteTimer() {
	AUD_Mute(PRM_TrayTip := false)
}

AUD_Mute(PRM_TrayTip = true) {
	LOC_MuteState := AUD_SoundGet("", "Mute")
	If (ErrorLevel) {
		TRY_ShowTrayTip("Audio: " . ErrorLevel, 2)
		Return
	}
	
	TRY_ShowTrayTip("Audio: " . LOC_MuteState)
	AUD_FadeIn()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AUD_FadeIn() {

	Global AUD_MasterVolume, AUD_WaveVolume
	LOC_MuteState := AUD_SoundGet("", "Mute")
	If (LOC_MuteState == "On") {
		AUD_SoundSet(1, "Wave")
		, AUD_SoundSet(1, "Master")
		, AUD_SoundSet("Off", , "Mute")
		Loop
		{
			LOC_FadeMasterVolume := AUD_SoundGet("Master")
			, LOC_FadeWaveVolume := AUD_SoundGet("Wave")
			If (LOC_FadeMasterVolume == "") {
				Return
			}
			If (LOC_FadeWaveVolume < AUD_WaveVolume
				|| LOC_FadeMasterVolume < AUD_MasterVolume) {
				If (LOC_FadeMasterVolume < AUD_MasterVolume) {
					AUD_SoundSet(LOC_FadeMasterVolume * 1.05, "Master")
				}
				If (LOC_FadeWaveVolume < AUD_WaveVolume) {
					AUD_SoundSet(LOC_FadeWaveVolume * 1.05, "Wave")
				}
				Sleep 10
			} Else {
				AUD_SoundSet(AUD_MasterVolume, "Master")
				, AUD_SoundSet(AUD_WaveVolume, "Wave")
				, TRY_ShowTrayTip()
				Break
			}
		}
	}
	If (LOC_MuteState == "Off") {
		AUD_FadeOut()
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AUD_FadeOut() {

	Global AUD_MasterVolume, AUD_WaveVolume
	LOC_MuteState := AUD_SoundGet("", "Mute")
	If (LOC_MuteState == "On") {
		AUD_FadeIn()
	}
	If (LOC_MuteState == "Off") {
		Loop
		{
			LOC_FadeMasterVolume := AUD_SoundGet("Master")
			LOC_FadeWaveVolume := AUD_SoundGet("Wave")
			If (LOC_FadeMasterVolume == "") {
				Return
			}
			If (LOC_FadeMasterVolume > 1
				|| LOC_FadeWaveVolume > 1) {
				If (LOC_FadeMasterVolume > 1) {
					AUD_SoundSet(LOC_FadeMasterVolume * 0.95, "Master")
				}
				If (LOC_FadeWaveVolume > 1) {
					AUD_SoundSet(LOC_FadeWaveVolume * 0.95, "Wave")
				}
				Sleep 10
			} Else {
				AUD_SoundSet(0, "Master")
				AUD_SoundSet(0, "Wave")
				AUD_SoundSet("+1", , "Mute")
				AUD_SoundSet(AUD_MasterVolume, "Master")
				AUD_SoundSet(AUD_WaveVolume, "Wave")
				Break
			}
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AUD_SoundGet(PRM_Component = "", PRM_Control = "") {
	Global AUD_NoMasterVolume
	LOC_Component := (PRM_Component ? PRM_Component : "Master")
	, LOC_Control := (PRM_Control ? PRM_Control : "Volume")
	StringUpper, LOC_Component, LOC_Component, T
	StringUpper, LOC_Control, LOC_Control, T
	If (AUD_NoMasterVolume
		&& LOC_Component == "Master") {
		LOC_Component := "Wave"
	}
	SoundGet, LOC_SoundGet, %LOC_Component%, %LOC_Control%
	If (ErrorLevel) {
		Return, ""
	}
	Return, %LOC_SoundGet%
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AUD_SoundSet(PRM_Value, PRM_Component = "", PRM_Control = "") {
	Global AUD_NoMasterVolume
	LOC_Component := (PRM_Component ? PRM_Component : "Master")
	, LOC_Control := (PRM_Control ? PRM_Control : "Volume")
	StringUpper, LOC_Component, LOC_Component, T
	StringUpper, LOC_Control, LOC_Control, T
	If (AUD_NoMasterVolume
		&& LOC_Component == "Master") {
		LOC_Component := "Wave"
	}
	SoundSet, %PRM_Value%, %LOC_Component%, %LOC_Control%
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AUD_Beep() {
	Global AHK_AudioEnabled
	If (AHK_AudioEnabled) {
		LOC_MediaFile := A_WinDir . "\Media\" . (A_Is64bitOS ? "Windows Startup.wav" : "start.wav")
		Try {
			SoundPlay, %LOC_MediaFile%
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "AUD_Beep")
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
