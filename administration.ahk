;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; AutoHotKey Memo { Win + F1 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_InitMemo() {

	Global AHK_ScriptName
	AHK_Log("> ADM_InitMemo()")
	Gui, 2:+AlwaysOnTop -Caption +Border -Resize +ToolWindow ; GUI_Memo
	Gui, 2:Color, FFFFDF, 000000
	
	;  text  : red bold
	; _text_ : underscored
	; \text\ : italic normal black
	; <text> : normal black
	; [text] : italic bold red (inside option)
	; (text) : normal gray
	LOC_Text =
	( LTrim
		 
		_Hotstrings_ : { Capslock    }     { A(nt) | (a)B(le) | E(nce) | (a)G(e) | (c)H(ie) | J : <gie> | (e)L(le) | (is)M(e) | N(aison) | (ti)O(n) | (i)Q(ue) | (eu)R | (e)S(se) | (emen)T | Y : <aille> | Z : <euse> }
		_Login_      : { Win + Enter }     [ Ctrl  \: <No Enter> | Shift : <Windows Login> |  Ctrl + Shift \: <Windows domain Login> ]
		_Bank_       : { Win + B     }     { Ctrl  \: Personal   | Alt   \: Pro\           | Shift ] \: CB\ }
		_Case_       : { Win + F8    }     [ Shift : \To uppercase\    | Ctrl : \Sentence first letter\ | Ctrl + Shift : \Words first letter\ ] [ Alt ] \: Invert\
		 
		_Clipboard_   : { Ctrl } { C | X | V }     [ Alt ] \: To alternate buffer\     [ Shift ] \: Plain text mode\     [ { Shift } { Insert <or> Delete } ] \: Append mode\
		_Audio level_ : { Win  } { Up | Down }     [ Alt ] \: Wave volume\             [ Ctrl  ] \: Fine steps\          [ Shift ] \: Large steps\     _Audio on/off_ : { ScrollLock }
		 
		_Screen saver_ : { Ctrl +       Win + L   }     [ Shift ] \: Screen off\
		_Lock Station_ : {              Win + L   }     [ Shift ] \: Force\
		_Suspend_      : { Ctrl + Alt + Win + L   }     [ Shift ] \: Hibernate\
		_Log off_      : { Ctrl +       Win + F12 }     [ Shift ] \: Force\
		_Shutdown_     : {              Win + F12 }     [ Shift ] \: Force\     [ Alt ] \: Restart\
		_BSOD_         : { Win + ScrollLock }
		 
		_Magnifier_       : { Ctrl + Alt + Win + PrintScreen | Ctrl + Shift + Wheel }
		_Color selection_ : { Win + C }         { Ctrl : <Hexa mode> | Alt : <RGB mode> }     [ Shift ] \: Color chooser\
		_Screenshot_      : { PrintScreen }     [ Win : \Active window\ | Ctrl : \Zone\ ]     [ Shift ] \: Include cursor\     [ Alt ] \: To file\     [ AltGr ] \: Text mode\
		 
		_Always on top_   : { Win + Click }`t_Transparency_ : { Win + Wheel }`t_Priority_ : { Ctrl + Win + Wheel }`t_Brightness_ : { Win + AltGr + Wheel }
		_Roll | minimize_ : { RightClick + LeftClick }`t{ <On> TitleBar : <Roll> | "Elsewhere" : <Minimize> }`t_Alt-Tab switch_ : { RightClick + Wheel }
		_9-square resize_ : { RightDrag }`t`t        [ Ctrl ] \: Force\`t[ Alt ] \: Propotionnally\`t[ Win ] \: Centering\`t[ Shift ] \: Large steps\
		_Resize_          : { Win }`t`t`t     { PageUp : <Increase> | PageDown : <Decrease> | Enter : <Restore> }`t          [ Shift ] \: Maximize | Minimize\
		_Resize_          : { Alt + NumPad ± }`t           [ Win ] \: Centering\`t     _Resize proportionnally_ : { Alt + Wheel }
		 
		_Close_     : { F4 | MiddleClick }`t{ Ctrl : <Close inner window> | Alt : <Close window> | Win : <Kill window> }
		_Systray_   : { Win }`t{ End : <Minimize> | Home : <Restore> }
		_Title bar_ : { MiddleClick }`t{ <On> Minimize : <Systray> | <On> Maximize : <All screens> [ Alt : \Next screen\ | Shift : \Full screens\ ]  | <On> Close : <Kill> | "Elsewhere" : <Close> } 
		 
		_Remove programs_     : { Ctrl + Win + Delete }     _Empty recycle bin_ : { Ctrl + Win + Shift + Delete }     _Rootkit Unhooker_ : { Win + Shift + Escape }
		_System applications_ : { Ctrl + Win          }     { A(dministration) | D(isks) | E(xplorer) | H(ardware) [ Shift : \Rescan\ ] | I(E) | R(egistry) | S(tartup) | (e)V(ents) }
		_User applications_   : { Win }     { C(alculator) | E (DirectoryOpus) | J(MP) | N(otes) | P(uTTY) | (S)Q(LDeveloper) <or> Q(uintessential) | T(hunderbird) | U(ltraEdit) }
		                      { Win }     { BackSpace : <SnagIt> | Ctrl + BackSpace : <MP3 Editor> | Ctrl + Alt + BackSpace : <Photoshop> }
		                      { Win }     { M(ediaMonkey) | W(MP) | I(nternet) | K(GS) | µ(Torrent) }
		 
		_%AHK_ScriptName% Options_ : { Ctrl + Win + Shift }`t{ (X-Mouse )F(ocus) | 1..5 : <Mouse button hook> | Q : <Tray Icon> }
		_%AHK_ScriptName% Options_ : { Ctrl + Win + Shift }`t{ A(udio) | B(alloon messages) | T(ooltips) | (Transparenc)Y | Z(ap wallpaper) }
		_%AHK_ScriptName% Tools_   :      { Ctrl + Win + Shift }`t{ H(otstring) | R(ecorder) | (Window)S(py) | X : <Winspector> }
		_%AHK_ScriptName% Scripts_ :   { Ctrl + Win + Shift }`t{ E(dit) | D(ebug) | Escape : <Suspend> | F5 <or> Pause : <Reload> }
		_Help_ :`t`t  { Win }`t`t            { F1 : <Memo> | Ctrl + F1 : <AHK help> [ Shift : \About\ ] | Ctrl + W(ebsite) }
		 
		_Other functionnalities_ : Personalized hotstrings            Longer keypress for F1 and Insert      Web search with selected text     NumLock always active
		                           Hovering variable speed scroll     Multiple facilities in WMP             Improved consoles                 Non-modal windows
		                           Time synchronization and chime     Automatic closing of boring popups     Automatic reload after script modification
	)
	LOC_NewLine := false
	Loop, Parse, LOC_Text, `n
	{
		LOC_NewLine |= ADM_ParseMemoText(A_LoopField, LOC_NewLine)
	}
	AHK_Log("< ADM_InitMemo()")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_Memo:
ADM_Memo()
Return

#F1::
ADM_Memo()
ADM_HideMemo(true)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_HideMemo:
ADM_HideMemo()
Return

ADM_HideMemo(PRM_Reinit = false) {
	Global ZZZ_HideMemoTimer
	Static STA_HideAfterNoMoreKeyDown := true
	If (PRM_Reinit) {
		STA_HideAfterNoMoreKeyDown := true
	}
	If (GetKeyState("F1", "P")) {
		STA_HideAfterNoMoreKeyDown := GetKeyState("LWin", "P") || GetKeyState("RWin", "P")
		SetTimer, ADM_HideMemo, %ZZZ_HideMemoTimer%
	} Else {
		If (GetKeyState("LWin", "P") || GetKeyState("RWin", "P")) {
			STA_HideAfterNoMoreKeyDown := true
			SetTimer, ADM_HideMemo, %ZZZ_HideMemoTimer%
		} Else {
			If (STA_HideAfterNoMoreKeyDown) {
				ADM_Memo(PRM_Visible := false)
			}
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_Memo(PRM_Visible = true) {

	Global AHK_ScriptInfo, SCR_VirtualScreenX, SCR_VirtualScreenY, SCR_VirtualScreenWidth, SCR_VirtualScreenHeight
	Static STA_Visible := false, STA_Init := false, STA_InitRunning := false

	If (!STA_Init) {
		If (STA_InitRunning) {
			Return
		}
		STA_InitRunning := true
		, ADM_InitMemo()
		, STA_Init := true
	}

	If (!PRM_Visible) {
		SetTimer, ADM_HideMemo, Off
		STA_Visible := false
		Gui, 2:Hide ; GUI_Memo
		Return
	}

	IfWinExist, GUI_Memo ahk_class AutoHotkeyGUI
	{
		If (!STA_Visible) {
			WinShow
		}
	} Else {
		Gui, 2:+LastFound
		Gui, 2:Show, AutoSize X%SCR_VirtualScreenWidth% Y%SCR_VirtualScreenHeight%, GUI_Memo
		WinGetPos, , , LOC_Width, LOC_Height
		Gui, 2:Show, % "AutoSize X" . (SCR_VirtualScreenWidth + SCR_VirtualScreenX - LOC_Width - 50) . " Y" . (SCR_VirtualScreenHeight + SCR_VirtualScreenY - LOC_Height - 50), GUI_Memo
	}
	STA_Visible := true
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_ParseMemoText(PRM_Line, PRM_NewLine, PRM_Normal = false, PRM_Italic = false, PRM_Underlined = false, PRM_Mandatory = false, PRM_Optional = false, PRM_Parenthesis = false) {

	LOC_Text := LOC_Variable := ""
	, PRM_NormalCount := PRM_ItalicCount := PRM_UnderlinedCount := PRM_MandatoryCount := PRM_OptionalCount := PRM_ParenthesisCount := 0
	, LOC_UnderlinedCount := LOC_ItalicCount := LOC_NormalCount := LOC_MandatoryCount := LOC_OptionalCount := LOC_ParenthesisCount := 0
	, LOC_TextWritten := LOC_SectionFound := false

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	Loop, Parse, PRM_Line
	{
		LOC_Char := A_LoopField

	    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; Set Variable name :
		LOC_Variable := ""
		If (LOC_Char == "_")	{
			LOC_Variable := "Underlined"
		} Else If (LOC_Char == "\") {
			LOC_Variable := "Italic"
		} Else If LOC_Char In <,>
		{
			LOC_Variable := "Normal"
		} Else If LOC_Char In {,}
		{
			LOC_Variable := "Mandatory"
		} Else If LOC_Char In [,]
		{
			LOC_Variable := "Optional"
		} Else If LOC_Char In (,)
		{
			LOC_Variable := "Parenthesis"
		}

	    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; Opening section ? :
		If LOC_Char In <,\,_,{,[,(
		{
			If (LOC_SectionFound) {
				If (LOC_Char != "_"
					&& LOC_Char != "\"
					|| LOC_%LOC_Variable%Count == 0) {
					LOC_Text .= LOC_Char
					If (LOC_%LOC_Variable%Count > 0) {
						LOC_%LOC_Variable%Count++
					}
					Continue
				}
			} Else {
				LOC_SectionFound := true
				, LOC_%LOC_Variable%Count := 1
				If (LOC_Text != "") {
					ADM_SetMemoFont(PRM_Normal, PRM_Italic, PRM_Underlined, PRM_Mandatory, PRM_Optional, PRM_Parenthesis)
				}
				LOC_TextWritten |= ADM_PrintMemoText(LOC_Text, PRM_NewLine)
				If LOC_Char In {,[
				{
					LOC_Text := LOC_Char
					, ADM_SetMemoFont(PRM_Normal, PRM_Italic, PRM_Underlined, PRM_Mandatory || LOC_Variable == "Mandatory", PRM_Optional || LOC_Variable == "Optional", PRM_Parenthesis, true)
					, LOC_TextWritten |= ADM_PrintMemoText(LOC_Text, PRM_NewLine)
					, ADM_SetMemoFont(PRM_Normal || LOC_Variable == "Normal", PRM_Italic || LOC_Variable == "Optional", PRM_Underlined || LOC_Variable == "Underlined", PRM_Mandatory || LOC_Variable == "Mandatory", PRM_Optional || LOC_Variable == "Optional", PRM_Parenthesis || LOC_Variable == "Parenthesis")
				}
				Continue
			}
		}

	    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; Closing section ? :
		If LOC_Char In >,\,_,},],)
		{
			If (LOC_SectionFound
				&& LOC_%LOC_Variable%Count > 0) {
				LOC_%LOC_Variable%Count--
				If (LOC_%LOC_Variable%Count == 0) {
					LOC_TextParsed := ADM_ParseMemoText(LOC_Text, PRM_NewLine, LOC_Variable == "Normal", PRM_Italic || LOC_Variable == "Italic", PRM_Underlined || LOC_Variable == "Underlined", LOC_Variable == "Mandatory", LOC_Variable == "Optional", LOC_Variable == "Parenthesis")
					, PRM_NewLine &= !LOC_TextParsed
					, LOC_TextWritten |= LOC_TextParsed
					, LOC_Text := ""
					If LOC_Char In },]
					{
						LOC_Text := LOC_Char
						, ADM_SetMemoFont(PRM_Normal, PRM_Italic, PRM_Underlined, PRM_Mandatory || LOC_Variable == "Mandatory", PRM_Optional || LOC_Variable == "Optional", PRM_Parenthesis, true)
						, LOC_TextWritten |= ADM_PrintMemoText(LOC_Text, PRM_NewLine)
					}
					ADM_SetMemoFont(PRM_Normal || LOC_Variable == "Normal", PRM_Italic || LOC_Variable == "Optional", PRM_Underlined || LOC_Variable == "Underlined", PRM_Mandatory || LOC_Variable == "Mandatory", PRM_Optional || LOC_Variable == "Optional", PRM_Parenthesis || LOC_Variable == "Parenthesis")
					, LOC_SectionFound := false
				} Else {
					LOC_Text .= LOC_Char
				}
			} Else {
				LOC_Text .= LOC_Char
			}
			Continue
		}

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; Symbol :
		If LOC_Char In |,+,:
		{
			If (!LOC_SectionFound) {
				ADM_SetMemoFont(PRM_Normal, PRM_Italic, PRM_Underlined, PRM_Mandatory, PRM_Optional, PRM_Parenthesis, false)
				, LOC_TextWritten |= ADM_PrintMemoText(LOC_Text, PRM_NewLine)
				, ADM_SetMemoFont(PRM_Normal, PRM_Italic, PRM_Underlined, PRM_Mandatory, PRM_Optional, PRM_Parenthesis, true)
				; , LOC_Text := (LOC_Char == "|" ? " | " : LOC_Char)
				, LOC_TextWritten |= ADM_PrintMemoText(LOC_Char, PRM_NewLine)
				, ADM_SetMemoFont(PRM_Normal, PRM_Italic, PRM_Underlined, PRM_Mandatory, PRM_Optional, PRM_Parenthesis)
				Continue
			}
		}

	    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; Any other char :
		LOC_Text .= LOC_Char
	}
	If (LOC_Text != "") {
		ADM_SetMemoFont(PRM_Normal, PRM_Italic, PRM_Underlined, PRM_Mandatory, PRM_Optional, PRM_Parenthesis)
	}
	Return, ADM_PrintMemoText(LOC_Text, PRM_NewLine) || LOC_TextWritten
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_SetMemoFont(PRM_Normal = false, PRM_Italic = false, PRM_Underlined = false, PRM_Mandatory = false, PRM_Optional = false, PRM_Parenthesis = false, PRM_Symbol = false) {
	LOC_FontAttributes := "Norm cBlack s8"
	If (!PRM_Normal) {
		If (PRM_Mandatory
			&& !PRM_Parenthesis) {
			LOC_FontAttributes .= " w700 cRed"
		}
		If (PRM_Optional
			&& !PRM_Parenthesis) {
			LOC_FontAttributes .= " w700 cRed"
		}
		If (PRM_Parenthesis) {
			LOC_FontAttributes .= " cGray"
		}
		If (PRM_Symbol) {
			LOC_FontAttributes .= " w700 cNavy"
		}
		If (PRM_Underlined) {
			LOC_FontAttributes .= " Underline"
			If (!PRM_Parenthesis) {
				LOC_FontAttributes .= " w700"
			}
		}
		If (PRM_Optional || PRM_Italic) {
			LOC_FontAttributes .= " Italic"
		}
	}
	Gui, 2:Font, % LOC_FontAttributes, % "Consolas"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_PrintMemoText(ByRef PRM_Text, ByRef PRM_NewLine) {

	If (PRM_Text != "") {
		If (PRM_NewLine) {
			Gui, 2:Add, Text, xm+10 yp+15, % PRM_Text ; GUI_Memo
		} Else {
			Gui, 2:Add, Text, x+1, % PRM_Text
		}
		PRM_Text := ""
		, PRM_NewLine := false
		Return, true
	}
	Return, false
}

2GuiClose:
2GuiEscape:
#IfWinActive, GUI_Memo ahk_class AutoHotkeyGUI
LButton::
ADM_Memo(false)
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; AutoHotKey Help { Ctrl + Win + F1 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_Help:
^#F1::
Suspend, Permit
ADM_Help()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_Help() {

	Global ZZZ_ProgramFiles64
	AHK_KeyWait("#^", "F1")
	LOC_Selection := TXT_GetSelectedText()
	IfWinExist, AutoHotkey Help ahk_class HH Parent
	{
		WinActivate
		WinWaitActive, , , 0
		WinShow
	}
	Else {
		Run, %A_WinDir%\hh.exe "%ZZZ_ProgramFiles64%\AutoHotkey\AutoHotkey.chm", , UseErrorLevel
		If (ErrorLevel == "ERROR") {
			TRY_ShowTrayTip("AutoHotKey help not launched", 3)
		} Else {
			WinWait, Help ahk_class HH Parent, , 10
			WinActivate
			WinWaitActive, , , 0
			WinMaximize
			WinShow
			TRY_ShowTrayTip("AutoHotKey help launched")
		}
	}
	If (LOC_Selection != "") {
		LOC_MuteVolume := AUD_SoundGet("", "Mute")
		If (LOC_MuteVolume == "Off") {
			AUD_SoundSet(1, , "Mute")
		}
		SendInput, !r ; select Rechercher tab
		ControlFocus, Edit1
		SendInput, {Home}+{End}
		TXT_SendRaw(LOC_Selection)
		SendInput, {Enter}
		Sleep, 100
		ControlSend, SysListView321, {Enter}
		If (LOC_MuteVolume == "Off") {
			Sleep, 300
			AUD_SoundSet(0, , "Mute")
		}
	} Else {
		TRY_ShowTrayTip("AutoHotKey help already launched", 2)
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Edit scripts with SciTE { Ctrl + Win + Shift + E} :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_Edit:
^+#e::
Suspend, Permit
ADM_Edit()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_Edit() {
	Global APP_SciTEPath
	If (APP_SciTEPath) {
		;~ LOC_AHKFiles := ""
		;~ Loop, Files, %A_ScriptDir%\*.ahk
		;~ {
			;~ LOC_AHKFiles = %LOC_AHKFiles%`"%A_LoopFileLongPath%`"`n
		;~ }
		;~ Sort, LOC_AHKFiles, \ U Z
		;~ StringReplace, LOC_AHKFiles, LOC_AHKFiles, `n, %A_Space%, All
		LOC_AHKFiles := """" . A_ScriptDir . "\JuggleKeys.ahk"" """ . A_ScriptDir . "\tools.ahk"" """ . A_ScriptDir . "\administration.ahk"" """ . A_ScriptDir . "\system.ahk"" """ . A_ScriptDir . "\screen.ahk"" """  . A_ScriptDir . "\power.ahk"" """ . A_ScriptDir . "\audio.ahk"" """ . A_ScriptDir . "\keyboard.ahk"" """ . A_ScriptDir . "\mouse.ahk"" """ . A_ScriptDir . "\windows.ahk"" """ . A_ScriptDir . "\applications.ahk"" """ . A_ScriptDir . "\login.ahk"" """ . A_ScriptDir . "\text.ahk"" """ . A_ScriptDir . "\hotstrings.ahk"" """ . A_ScriptDir . "\tray.ahk"""
		LOC_AHKFiles := ""
		Run, "%APP_SciTEPath%" %LOC_AHKFiles%, , UseErrorLevel
		If (ErrorLevel == "ERROR") {
			TRY_ShowTrayTip("AutoHotKey editor not launched", 3)
		} Else {
			TRY_ShowTrayTip("AutoHotKey editor launched")
		}
	} Else {
		TRY_ShowTrayTip("AutoHotKey editor not found", 3)
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, ahk_class SciTEWindow

; SciTE search { [ Shift + ] F3 }, { Ctrl + [ Shift + ] K }, { Ctrl + Shift + S } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_SciTESearch:
F3::
+F3::
^k::
^+k::
APP_SciTESearch(A_ThisHotkey)
Return

APP_SciTESearch(PRM_Hotkey) {
	LOC_ClipBoardAll := ClipBoardAll
	If (LOC_ClipBoard := TXT_SelectToClipBoard(PRM_Copy := 1)) {
		SendInput, ^f ; PostMessage, 0x111, 320 ?
		WinWaitActive, Find ahk_class #32770, Match &whole word only, 1
		If (!ErrorLevel) {
			ControlFocus, Edit1
			SendInput, {End}+{Home}
			TXT_SendRaw(LOC_ClipBoard)

			IfInString, PRM_Hotkey , % "+"
			{
				SendInput, !u ; PostMessage, 0x111, 234 ?
			} Else {
				SendInput, !d ; PostMessage, 0x111, 23 ?
			}
			SendInput, {Enter} ; PostMessage, 0x111, 1 ?
		}
	} Else {
		IfInString, PRM_Hotkey , % "+"
		{
			SendInput, +{F3}
		} Else {
			SendInput, {F3}
		}
	}
	TXT_SetClipBoard(LOC_ClipBoardAll)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^+f::
APP_SciTEFindInFiles()
Return

APP_SciTEFindInFiles() {
	
	SendMessage, 0x111, 215, 0, , SciTE4AutoHotkey ahk_class SciTEWindow
	WinWaitActive, Dans les fichiers ahk_class #32770, Case sensiti&ve, 0
	WinGet, LOC_WindowID, ID, Dans les fichiers ahk_class #32770, Case sensiti&ve
	If (!LOC_WindowID) {
		WinWaitActive, Find in Files ahk_class #32770, Match &whole word only, 0.5
		WinGet, LOC_WindowID, ID, Find in Files ahk_class #32770, Match &whole word only
	}
	If (LOC_WindowID) {
		ControlFocus, Edit2, ahk_id %LOC_WindowID%
		SendInput, {Raw}*.ahk
		Sleep, 50
		ControlFocus, Edit1, ahk_id %LOC_WindowID%
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; SciTE Save all :
;;;;;;;;;;;;;;;;;;

~^s::
SetTimer, AHK_CheckModificationsTimer, %ZZZ_CheckModificationsTimer%
Return

^+s::
AHK_KeyWait("^+")
, APP_SciTESaveAll()
Return

APP_SciTESaveAll() {

	Global ZZZ_CheckModificationsTimer
	SetTimer, AHK_CheckModificationsTimer, Off
	WinGetActiveTitle, LOC_InitialTitle
	If (InStr(LOC_InitialTitle, " * "))
	{
		SendMessage, 0x111, 106 ; SendInput, ^s
		Loop
		{
			Sleep, 50
			WinGetActiveTitle, LOC_InitialTitle
		} Until (!InStr(LOC_InitialTitle, " * "))

	}

	Loop
	{
		SendMessage, 0x111, 502 ; SendInput, {F6}
		WinGetActiveTitle, LOC_Title
		If (LOC_Title == LOC_InitialTitle) {
			Break
		}
		If (InStr(LOC_Title, " * ")) {
			SendMessage, 0x111, 106 ; SendInput, ^s
			Loop
			{
				Sleep, 50
				WinGetActiveTitle, LOC_Title
			} Until (!InStr(LOC_Title, " * "))
		}
	}
	AHK_ShowToolTip("Save all files")
	SetTimer, AHK_CheckModificationsTimer, -1
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; SciTE If expression auto-string { Alt + i } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
!i::
SendInput, {Raw}If () {
SendInput, {Enter}
SendInput, {Raw}} Else {
SendInput, {Enter}
SendInput, {Raw}}
SendInput, {Enter}
SendInput, {Up 3}{Right 4}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; SciTE current/all folder toggle { Ctrl | Shift | Ctrl + Shift } + { NumPadAdd | NumPadSub } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

NumpadSub::
SendInput, -
Return

NumpadAdd::
SendInput, {+}
Return

; Toggle current fold :
^NumpadAdd::
^NumpadSub::
+NumpadAdd::
+NumpadSub::
SendInput, {Esc}{Alt Down}v{Alt Up}c
AHK_ShowToolTip("Toggle current fold")
Return

; Toogle all folds :
^+NumpadAdd::
^+NumpadSub::
SendInput, {Esc}{Alt Down}v{Alt Up}a
AHK_ShowToolTip("Toggle all folds")
Return

#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Record script { Ctrl + Win + Shift + R } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_Recorder:
^+#r::
Suspend, Permit
ADM_Recorder()
Return

ADM_Recorder() {
	Global APP_AutoScriptWriterPath
	APP_Run("Recorder", APP_AutoScriptWriterPath, , , PRM_Maximized := false)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Debug script { Ctrl + Win + Shift + D } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_Debug:
^+#d::
Suspend, Permit
ListVars
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Reload scripts { Ctrl + Win + Shift + F5 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_Reload:
^+#F5::
^<!+F5::
^>!+F5::
+Pause::
^+#CtrlBreak::
Suspend, Permit
ADM_Reload()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_Reload() {
	Global
	; Reload
	Run, "%A_ScriptFullPath%", %A_ScriptDir%, UseErrorLevel
	TRY_ShowTrayTip(AHK_ScriptInfo . " reloaded")
	ADM_Exit()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Exit AHK { Ctrl + Win + Shift + F4 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^#+F4::
Suspend, Permit
ADM_Exit()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_Exit() {
	Global AHK_ScriptInfo
	TRY_ShowTrayTip("Exiting " . AHK_ScriptInfo, 2)
	Sleep, 1000
	AHK_Exit()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Mouse hooks { Ctrl + Win + Shift + <n> } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^+#0::
^+#Numpad0::
TRY_ShowTrayTip("Mouse traces " . (SCR_MouseTracesEnabled ? "disabled" : "enabled"))
AHK_ToggleMouseTraces()
Return

AHK_ToggleMouseTraces:
AHK_ToggleMouseTraces()
, TRY_UpdateMenus()
, AHK_SaveIniFile()

Menu, Options, Show
Return

AHK_ToggleMouseTraces() {
	Global
	Local PRM_Action
	SCR_MouseTracesEnabled := !SCR_MouseTracesEnabled
	SetTimer, SCR_MouseRingManager, % (SCR_MouseTracesEnabled ? SCR_MouseRings : "Off")
	If (!SCR_MouseTracesEnabled) {
		SCR_MouseRingManager(PRM_Action = -2)
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^+#1::
^+#Numpad1::
Suspend, Permit
If (AHK_LeftMouseButtonHookEnabled) {
	TRY_ShowTrayTip("Left mouse button actions disabled", 2)
} Else {
	TRY_ShowTrayTip("Left mouse button actions enabled")
}
AHK_ToggleLeftMouseButton()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_ToggleLeftMouseButton:
AHK_ToggleLeftMouseButton()
Menu, Options, Show
Return

AHK_ToggleLeftMouseButton() {
	Global
	AHK_LeftMouseButtonHookEnabled := !AHK_LeftMouseButtonHookEnabled
	, ADM_ApplyMouseHooks(1)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^+#2::
^+#Numpad2::
Suspend, Permit
If (AHK_MiddleMouseButtonHookEnabled) {
	TRY_ShowTrayTip("Middle mouse button actions disabled", 2)
} Else {
	TRY_ShowTrayTip("Middle mouse button actions enabled")
}
AHK_ToggleMiddleMouseButton()
Return

AHK_ToggleMiddleMouseButton:
AHK_ToggleMiddleMouseButton()
Menu, Options, Show
Return

AHK_ToggleMiddleMouseButton() {
	Global
	AHK_MiddleMouseButtonHookEnabled := !AHK_MiddleMouseButtonHookEnabled
	, ADM_ApplyMouseHooks(2)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^+#3::
^+#Numpad3::
Suspend, Permit
If (AHK_RightMouseButtonHookEnabled) {
	TRY_ShowTrayTip("Right mouse button actions disabled", 2)
} Else {
	TRY_ShowTrayTip("Right mouse button actions enabled")
}
AHK_ToggleRightMouseButton()
Return

AHK_ToggleRightMouseButton:
AHK_ToggleRightMouseButton()
Menu, Options, Show
Return

AHK_ToggleRightMouseButton() {
	Global
	AHK_RightMouseButtonHookEnabled := !AHK_RightMouseButtonHookEnabled
	, ADM_ApplyMouseHooks(3)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^+#4::
^+#Numpad4::
Suspend, Permit
If (AHK_FourthMouseButtonHookEnabled) {
	TRY_ShowTrayTip("4th mouse button actions disabled", 2)
} Else {
	TRY_ShowTrayTip("4th mouse button actions enabled")
}
AHK_Toggle4thMouseButton()
Return

AHK_Toggle4thMouseButton:
AHK_Toggle4thMouseButton()
Menu, Options, Show
Return

AHK_Toggle4thMouseButton() {
	Global
	AHK_FourthMouseButtonHookEnabled := !AHK_FourthMouseButtonHookEnabled
	, ADM_ApplyMouseHooks(4)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^+#5::
^+#Numpad5::
Suspend, Permit
If (AHK_FifthMouseButtonHookEnabled) {
	TRY_ShowTrayTip("5th mouse button actions disabled", 2)
} Else {
	TRY_ShowTrayTip("5th mouse button actions enabled")
}
AHK_Toggle5thMouseButton()
Return

AHK_Toggle5thMouseButton:
AHK_Toggle5thMouseButton()
Menu, Options, Show
Return

AHK_Toggle5thMouseButton() {
	Global
	AHK_FifthMouseButtonHookEnabled := !AHK_FifthMouseButtonHookEnabled
	, ADM_ApplyMouseHooks(5)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_ApplyMouseHooks(PRM_ButtonNumber = 0) {

	Global AHK_MouseButtonNumber, AHK_LeftMouseButtonHookEnabled, AHK_MiddleMouseButtonHookEnabled, AHK_RightMouseButtonHookEnabled, AHK_FourthMouseButtonHookEnabled, AHK_FifthMouseButtonHookEnabled
	AHK_Log("> ADM_ApplyMouseHooks(" . PRM_ButtonNumber . ")")
	If (AHK_MouseButtonNumber >= 1
		&& (PRM_ButtonNumber == 0 || PRM_ButtonNumber == 1)) {
		If (AHK_LeftMouseButtonHookEnabled) {
			LOC_LeftMouseButtonHookState := "On"
			, TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + 1`t&Left Mouse Button")
		} Else {
			LOC_LeftMouseButtonHookState := "Off"
			, TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + 1`t&Left Mouse Button", false)
		}
		Hotkey, ~LButton, %LOC_LeftMouseButtonHookState%
		Hotkey, <!LButton, %LOC_LeftMouseButtonHookState%
		Hotkey, <+LButton, %LOC_LeftMouseButtonHookState%
		Hotkey, #LButton, %LOC_LeftMouseButtonHookState%
	} Else {
		Hotkey, ^+#1, Off
	}

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	If (AHK_MouseButtonNumber >= 2
		&& (PRM_ButtonNumber == 0 || PRM_ButtonNumber == 2)) {
		If (AHK_MiddleMouseButtonHookEnabled) {
			LOC_MiddleMouseButtonHookState := "On"
		} Else {
			LOC_MiddleMouseButtonHookState := "Off"
		}
		TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + 2`t&Middle Mouse Button", AHK_MiddleMouseButtonHookEnabled)
		Hotkey, #MButton, %LOC_MiddleMouseButtonHookState%
		Hotkey, ^#MButton, %LOC_MiddleMouseButtonHookState%
		Hotkey, !#MButton, %LOC_MiddleMouseButtonHookState%
		Hotkey, ^!#MButton, %LOC_MiddleMouseButtonHookState%
		Hotkey, !MButton, %LOC_MiddleMouseButtonHookState%
		Hotkey, +MButton, %LOC_MiddleMouseButtonHookState%
		Hotkey, MButton, %LOC_MiddleMouseButtonHookState%
	} Else {
		Hotkey, ^+#2, Off
	}

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	If (AHK_MouseButtonNumber >= 3
		&& (PRM_ButtonNumber == 0 || PRM_ButtonNumber == 3)) {
		If (AHK_RightMouseButtonHookEnabled) {
			LOC_RightMouseButtonHookState := "On"
			, TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + 3`t&Right Mouse Button")
		} Else {
			LOC_RightMouseButtonHookState := "Off"
			, TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + 3`t&Right Mouse Button", false)
		}
		Hotkey, RButton, %LOC_RightMouseButtonHookState%
		Hotkey, +RButton, %LOC_RightMouseButtonHookState%
		Hotkey, !+RButton, %LOC_RightMouseButtonHookState%
		Hotkey, ^+RButton, %LOC_RightMouseButtonHookState%
		Hotkey, +#RButton, %LOC_RightMouseButtonHookState%
		Hotkey, ^!+RButton, %LOC_RightMouseButtonHookState%
		Hotkey, !+#RButton, %LOC_RightMouseButtonHookState%
		Hotkey, ^+#RButton, %LOC_RightMouseButtonHookState%
		Hotkey, ^!+#RButton, %LOC_RightMouseButtonHookState%
		Hotkey, !RButton, %LOC_RightMouseButtonHookState%
		Hotkey, ^!RButton, %LOC_RightMouseButtonHookState%
		Hotkey, !#RButton, %LOC_RightMouseButtonHookState%
		Hotkey, ^!#RButton, %LOC_RightMouseButtonHookState%
		Hotkey, ^RButton, %LOC_RightMouseButtonHookState%
		Hotkey, ^#RButton, %LOC_RightMouseButtonHookState%
		Hotkey, #RButton, %LOC_RightMouseButtonHookState%
	} Else {
		Hotkey, ^+#3, Off
	}

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	If (AHK_MouseButtonNumber >= 4
		&& (PRM_ButtonNumber == 0 || PRM_ButtonNumber == 4)) {
		If (AHK_FourthMouseButtonHookEnabled) {
			LOC_FourthMouseButtonHookState := "On"
			, TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + 4`t&4th Mouse Button")
		} Else {
			LOC_FourthMouseButtonHookState := "Off"
			, TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + 4`t&4th Mouse Button", false)
		}
		Hotkey, XButton1, %LOC_FourthMouseButtonHookState%
	} Else {
		Hotkey, ^+#4, Off
	}

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	If (AHK_MouseButtonNumber >= 5
		&& (PRM_ButtonNumber == 0 || PRM_ButtonNumber == 5)) {
		If (AHK_FifthMouseButtonHookEnabled) {
			LOC_FifthMouseButtonHookState := "On"
		} Else {
			LOC_FifthMouseButtonHookState := "Off"
		}
		TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + 5`t&5th Mouse Button", AHK_FifthMouseButtonHookEnabled)
		Hotkey, XButton2, %LOC_FifthMouseButtonHookState%
	} Else {
		Hotkey, ^+#5, Off
	}

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	TRY_UpdateMenus()
	, AHK_SaveIniFile()
	, AHK_Log("< ADM_ApplyMouseHooks(" . PRM_ButtonNumber . ")")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Window Spy { Ctrl + Win + Shift + S } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_TrayMenuWindowSpy:
WIN_FocusLastWindow()

^+#s::
Suspend, Permit
ADM_WindowSpy(true)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_WindowSpyRefreshTimer:
ADM_WindowSpy()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_WindowSpy(PRM_Show = false, PRM_ListViewToActivate = false) {

	Global SCR_VirtualScreenX, SCR_VirtualScreenWidth, SCR_VirtualScreenY, SCR_VirtualScreenHeight, AHK_ScriptName, AHK_ScriptInfo, ZZZ_CloseHandleFunction, ZZZ_WindowSpyRefreshTimer
	Static STA_WindowClass, STA_WindowID, STA_WindowProcess, STA_WindowPID, STA_Performance, STA_Description, STA_Windows, STA_WindowIDA, STA_HiddenWindows
		, STA_SuperTitle, STA_WindowTitle, STA_WindowBounds, STA_WindowSize, STA_HoveredColor, STA_ColoredZone, STA_ColorGuiX, STA_ColorGuiY, STA_MousePosition
		, STA_WindowStyles, STA_ExtendedWindowStyles, STA_ControlClass, STA_WindowStatusBar, STA_WindowText := "", STA_WindowControls := "", STA_ScreenBounds, STA_ScreenSize, STA_Monitors
		, STA_IdleTime, STA_CPUTick, STA_KernelTime, STA_UserTime, STA_PerformanceCount := 0
		, STA_GuiID := 0, STA_ProcessorCount := 0, STA_PredefinedWindowStyles := 0, STA_WindowStyleLabels := 0, STA_PredefinedExtendedWindowStyles := 0, STA_ExtendedWindowStyleLabels := 0
		, STA_IsStylesTooltip := false, STA_IsExtendedStylesTooltip  := false, STA_AltDown := false, STA_Suspended := false
		, STA_LabelWidth := 90, STA_EditionWidth := 735, STA_LengthVariables := "Left|Top|Right|Bottom|Width|Height"
		, STA_GetSystemTimesFunction := AHK_GetFunction("kernel32", "GetSystemTimes")
		, STA_OpenProcessFunction := AHK_GetFunction("kernel32", "OpenProcess")
		, STA_GetProcessMemoryInfoFunction := AHK_GetFunction("psapi", "GetProcessMemoryInfo")
		, STA_GetProcessTimesFunction := AHK_GetFunction("kernel32", "GetProcessTimes")
		, STA_GetProcessHandleCountFunction := AHK_GetFunction("kernel32", "GetProcessHandleCount")
		, STA_NtQuerySystemInformationFunction := AHK_GetFunction("ntdll", "NtQuerySystemInformation")
		, STA_StrFormatByteSize64AFunction := AHK_GetFunction("shlwapi", "StrFormatByteSize64A")

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	If (!STA_ProcessorCount) {
		EnvGet, STA_ProcessorCount, NUMBER_OF_PROCESSORS

		STA_PredefinedWindowStyles := { WS_BORDER: 0x00800000
			, WS_CAPTION: 0x00C00000
			, WS_CHILDWINDOW: 0x40000000
			, WS_CLIPCHILDREN: 0x02000000
			, WS_CLIPSIBLINGS: 0x04000000
			, WS_DISABLED: 0x08000000
			, WS_DLGFRAME: 0x00400000
			, WS_GROUP: 0x00020000
			, WS_HSCROLL: 0x00100000
			, WS_MAXIMIZE: 0x01000000
			, WS_MAXIMIZEBOX: 0x00010000
			, WS_MINIMIZE: 0x20000000
			, WS_MINIMIZEBOX: 0x00020000
			, WS_OVERLAPPED: 0x00000000
			, WS_OVERLAPPEDWINDOW: 0
			, WS_POPUP: 0x80000000
			, WS_POPUPWINDOW: 0
			, WS_SIZEBOX: 0x00040000
			, WS_SYSMENU: 0x00080000
			, WS_TABSTOP: 0x00010000
			, WS_VISIBLE: 0x10000000
			, WS_VSCROLL: 0x00200000 }
		, STA_PredefinedWindowStyles[WS_OVERLAPPEDWINDOW] := STA_PredefinedWindowStyles[WS_OVERLAPPED] | STA_PredefinedWindowStyles[WS_CAPTION]
		, STA_PredefinedWindowStyles[WS_OVERLAPPEDWINDOW] |= STA_PredefinedWindowStyles[WS_SYSMENU] | STA_PredefinedWindowStyles[WS_THICKFRAME]
		, STA_PredefinedWindowStyles[WS_OVERLAPPEDWINDOW] |= STA_PredefinedWindowStyles[WS_MINIMIZEBOX] | STA_PredefinedWindowStyles[WS_MAXIMIZEBOX]
		, STA_PredefinedWindowStyles[WS_POPUPWINDOW] := STA_PredefinedWindowStyles[WS_POPUP] | STA_PredefinedWindowStyles[WS_BORDER] | STA_PredefinedWindowStyles[WS_SYSMENU]
		, STA_PredefinedWindowStyles[WS_TILEDWINDOW] := STA_PredefinedWindowStyles[WS_OVERLAPPED] | STA_PredefinedWindowStyles[WS_CAPTION]
		, STA_PredefinedWindowStyles[WS_TILEDWINDOW] |= STA_PredefinedWindowStyles[WS_SYSMENU] | STA_PredefinedWindowStyles[WS_THICKFRAME]
		, STA_PredefinedWindowStyles[WS_TILEDWINDOW] |= STA_PredefinedWindowStyles[WS_MINIMIZEBOX] | STA_PredefinedWindowStyles[WS_MAXIMIZEBOX]

		, STA_WindowStyleLabels := { WS_BORDER: "`t`t`tThe window has a thin-line border."
			, WS_CAPTION: "`t`t`tThe window has a title bar (includes the WS_BORDER style)."
			, WS_CHILDWINDOW: "`t`tThe window is a child window."
			, WS_CLIPCHILDREN: "`t`tExcludes the area occupied by child windows when drawing occurs within the parent window."
			, WS_CLIPSIBLINGS: "`t`tClips child windows relative to each other`r`n`t`t`t`tthat is, when a particular child window receives a WM_PAINT message,`r`n`t`t`t`tthis style clips all other overlapping child windows out of the region of the child window to be updated."
			, WS_DISABLED: "`t`t`tThe window is initially disabled. A disabled window cannot receive input from the user."
			, WS_DLGFRAME: "`t`tThe window has a border of a style typically used with dialog boxes."
			, WS_GROUP: "`t`t`tThe window is the first control of a group of controls.`r`n`t`t`t`tThe group consists of this first control and all controls defined after it,`r`n`t`t`t`tup to the next control with the WS_GROUP style.`r`n`t`t`t`tThe first control in each group usually has the WS_TABSTOP style`r`n`t`t`t`tso that the user can move from group to group.`r`n`t`t`t`tThe user can subsequently change the keyboard focus from one control in the group`r`n`t`t`t`tto the next control in the group by using the direction keys."
			, WS_HSCROLL: "`t`t`tThe window has a horizontal scroll bar."
			, WS_MAXIMIZE: "`t`t`tThe window is initially maximized."
			, WS_MAXIMIZEBOX: "`t`tThe window has a maximize button."
			, WS_MINIMIZE: "`t`t`tThe window is initially minimized."
			, WS_MINIMIZEBOX: "`t`tThe window has a minimize button."
			, WS_OVERLAPPED: "`t`tThe window is an overlapped window.`r`n`t`t`t`tAn overlapped window has a title bar and a border."
			, WS_OVERLAPPEDWINDOW: "`tThe window is an overlapped window."
			, WS_POPUP: "`t`t`tThe windows is a pop-up window."
			, WS_POPUPWINDOW: "`t`tThe window is a pop-up window."
			, WS_SIZEBOX: "`t`t`tThe window has a sizing border."
			, WS_SYSMENU: "`t`t`tThe window has a window menu on its title bar."
			, WS_TABSTOP: "`t`t`tThe window is a control that can receive the keyboard focus when the user presses the TAB key.`r`n`t`t`t`tPressing the TAB key changes the keyboard focus to the next control with the WS_TABSTOP style."
			, WS_VISIBLE: "`t`t`tThe window is initially visible."
			, WS_VSCROLL: "`t`t`tThe window has a vertical scroll bar." }

		, STA_PredefinedExtendedWindowStyles := { WS_EX_ACCEPTFILES: 0x00000010
			, WS_EX_APPWINDOW: 0x00040000
			, WS_EX_CLIENTEDGE: 0x00000200
			, WS_EX_COMPOSITED: 0x02000000
			, WS_EX_CONTEXTHELP: 0x00000400
			, WS_EX_CONTROLPARENT: 0x00010000
			, WS_EX_DLGMODALFRAME: 0x00000001
			, WS_EX_LAYERED: 0x00080000
			, WS_EX_LAYOUTRTL: 0x00400000
			, WS_EX_LEFT: 0x00000000
			, WS_EX_LEFTSCROLLBAR: 0x00004000
			, WS_EX_LTRREADING: 0x00000000
			, WS_EX_MDICHILD: 0x00000040
			, WS_EX_NOACTIVATE: 0x08000000
			, WS_EX_NOINHERITLAYOUT: 0x00100000
			, WS_EX_NOPARENTNOTIFY: 0x00000004
			, WS_EX_NOREDIRECTIONBITMAP: 0x00200000
			, WS_EX_OVERLAPPEDWINDOW: 0
			, WS_EX_PALETTEWINDOW: 0
			, WS_EX_RIGHT: 0x00001000
			, WS_EX_RIGHTSCROLLBAR: 0x00000000
			, WS_EX_RTLREADING: 0x00002000
			, WS_EX_STATICEDGE: 0x00020000
			, WS_EX_TOOLWINDOW: 0x00000080
			, WS_EX_TOPMOST: 0x00000008
			, WS_EX_TRANSPARENT: 0x00000020
			, WS_EX_WINDOWEDGE: 0x00000100 }
		STA_PredefinedExtendedWindowStyles[WS_EX_PALETTEWINDOW] := STA_PredefinedExtendedWindowStyles[WS_EX_WINDOWEDGE] | STA_PredefinedExtendedWindowStyles[WS_EX_TOOLWINDOW] | STA_PredefinedExtendedWindowStyles[WS_EX_TOPMOST]
		, STA_PredefinedExtendedWindowStyles[WS_EX_OVERLAPPEDWINDOW] := STA_PredefinedExtendedWindowStyles[WS_EX_WINDOWEDGE] | STA_PredefinedExtendedWindowStyles[WS_EX_CLIENTEDGE]

		, STA_ExtendedWindowStyleLabels := { WS_EX_ACCEPTFILES: "`t`t`tThe window accepts drag-drop files."
			, WS_EX_APPWINDOW: "`t`t`tForces a top-level window onto the taskbar when the window is visible. "
			, WS_EX_CLIENTEDGE: "`t`t`tThe window has a border with a sunken edge."
			, WS_EX_COMPOSITED: "`t`t`tPaints all descendants of a window in bottom-to-top painting order using double-buffering."
			, WS_EX_CONTEXTHELP: "`t`tThe title bar of the window includes a question mark.`r`n`t`t`t`t`tWhen the user clicks the question mark, the cursor changes to a question mark with a pointer."
			, WS_EX_CONTROLPARENT: "`t`tThe window itself contains child windows that should take part in dialog box navigation:`r`n`t`t`t`t`tthe dialog manager recurses into children of this window when performing navigation operations`r`n`t`t`t`t`tsuch as handling the TAB key, an arrow key, or a keyboard mnemonic."
			, WS_EX_DLGMODALFRAME: "`t`tThe window has a double border."
			, WS_EX_LAYERED: "`t`t`tThe window is a layered window."
			, WS_EX_LAYOUTRTL: "`t`t`tIf the shell language is Hebrew, Arabic, or another language that supports reading order alignment,`r`n`t`t`t`t`tthe horizontal origin of the window is on the right edge.`r`n`t`t`t`t`tIncreasing horizontal values advance to the left."
			, WS_EX_LEFT: "`t`t`t`tThe window has generic left-aligned properties."
			, WS_EX_LEFTSCROLLBAR: "`t`tIf the shell language is Hebrew, Arabic, or another language that supports reading order alignment,`r`n`t`t`t`t`tthe vertical scroll bar (if present) is to the left of the client area."
			, WS_EX_LTRREADING: "`t`t`tThe window text is displayed using left-to-right reading-order properties."
			, WS_EX_MDICHILD: "`t`t`tThe window is a MDI child window."
			, WS_EX_NOACTIVATE: "`t`t`tA top-level window created with this style does not become the foreground window when the user clicks it.`r`n`t`t`t`t`tThe system does not bring this window to the foreground`r`n`t`t`t`t`twhen the user minimizes or closes the foreground window."
			, WS_EX_NOINHERITLAYOUT: "`t`tThe window does not pass its window layout to its child windows."
			, WS_EX_NOPARENTNOTIFY: "`t`tThe child window created with this style does not send the WM_PARENTNOTIFY message`r`n`t`t`t`t`tto its parent window when it is created or destroyed."
			, WS_EX_NOREDIRECTIONBITMAP: "`tThe window does not render to a redirection surface.`r`n`t`t`t`t`tThis is for windows that do not have visible content`r`n`t`t`t`t`tor that use mechanisms other than surfaces to provide their visual."
			, WS_EX_OVERLAPPEDWINDOW: "`tThe window is an overlapped window."
			, WS_EX_PALETTEWINDOW: "`t`tThe window is palette window, which is a modeless dialog box that presents an array of commands. "
			, WS_EX_RIGHT: "`t`t`t`tThe window has generic right-aligned properties. This depends on the window class.`r`n`t`t`t`t`tThis style has an effect only if the shell language is Hebrew, Arabic,`r`n`t`t`t`t`tor another language that supports reading-order alignment."
			, WS_EX_RIGHTSCROLLBAR: "`t`tThe vertical scroll bar (if present) is to the right of the client area."
			, WS_EX_RTLREADING: "`t`t`tIf the shell language is Hebrew, Arabic, or another language that supports reading-order alignment,`r`n`t`t`t`t`tthe window text is displayed using right-to-left reading-order properties."
			, WS_EX_STATICEDGE: "`t`t`tThe window has a three-dimensional border style intended to be used`r`n`t`t`t`t`tfor items that do not accept user input."
			, WS_EX_TOOLWINDOW: "`t`tThe window is intended to be used as a floating toolbar.`r`n`t`t`t`t`tA tool window has a title bar that is shorter than a normal title bar,`r`n`t`t`t`t`tand the window title is drawn using a smaller font.`r`n`t`t`t`t`tA tool window does not appear in the taskbar or in the dialog that appears`r`n`t`t`t`t`twhen the user presses ALT+TAB.`r`n`t`t`t`t`tIf a tool window has a system menu, its icon is not displayed on the title bar.`r`n`t`t`t`t`tHowever, you can display the system menu by right-clicking or by typing ALT+SPACE. "
			, WS_EX_TOPMOST: "`t`t`tThe window should be placed above all non-topmost windows and should stay above them,`r`n`t`t`t`t`teven when the window is deactivated."
			, WS_EX_TRANSPARENT: "`t`tThe window should not be painted until siblings beneath the window`r`n`t`t`t`t`t(that were created by the same thread) have been painted.`r`n`t`t`t`t`tThe window appears transparent`r`n`t`t`t`t`tbecause the bits of underlying sibling windows have already been painted."
			, WS_EX_WINDOWEDGE: "`t`tThe window has a border with a raised edge." }
	}

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Build GUI :
	;;;;;;;;;;;;;
	If (!STA_GuiID) {
		Gui, 30:Destroy ; WindowSpy
		Gui, 30:Default
		Gui, 30:+AlwaysOnTop +LastFound -Resize -MaximizeBox +Border +Caption +HwndSTA_GuiID

		Gui, 30:Color, Silver, White
		Gui, 30:Font, s12 Bold
		Gui, 30:Add, Text, % "yp+10 BackgroundTrans vSTA_SuperTitle Center W" . (STA_LabelWidth + STA_EditionWidth), Hovered window

		Gui, 30:Font, s7 Bold
		Gui, 30:Add, Text, xm+0 yp+35 W%STA_LabelWidth% Right BackgroundTrans, Title : 
		Gui, 30:Font, s7, Courier New
		Gui, 30:Add, Edit, x+1 yp-1 TabStop W%STA_EditionWidth% H15 vSTA_WindowTitle

		Gui, 30:Font
		Gui, 30:Font, Bold
		Gui, 30:Add, Text, xm+0 yp+17 W%STA_LabelWidth% Right BackgroundTrans, Description : 
		Gui, 30:Font, s7, Courier New
		Gui, 30:Add, Edit, x+1 yp-1 TabStop W%STA_EditionWidth% H15 vSTA_Description

		Gui, 30:Font
		Gui, 30:Font, Bold
		Gui, 30:Add, Text, xm+0 yp+17 W%STA_LabelWidth% Right BackgroundTrans, Identification : 
		Gui, 30:Font, s7, Courier New
		Gui, 30:Add, Edit, % "x+1 yp-1 TabStop W" . (STA_EditionWidth - 101) . " H15 vSTA_WindowClass"
		Gui, 30:Add, Edit, x+1 TabStop W100 H15 vSTA_WindowID

		Gui, 30:Font
		Gui, 30:Font, Bold
		Gui, 30:Add, Text, xm+0 yp+22 W%STA_LabelWidth% Right BackgroundTrans, Styles : 
		Gui, 30:Font, s7, Courier New
		Gui, 30:Add, Edit, x+1 yp-1 TabStop W%STA_EditionWidth% H15 vSTA_WindowStyles

		Gui, 30:Font
		Gui, 30:Font, Bold
		Gui, 30:Add, Text, xm+0 yp+17 W%STA_LabelWidth% Right BackgroundTrans, Ext. Styles : 
		Gui, 30:Font, s7, Courier New
		Gui, 30:Add, Edit, x+1 yp-1 TabStop W%STA_EditionWidth% H15 vSTA_ExtendedWindowStyles

		Gui, 30:Font
		Gui, 30:Font, Bold
		Gui, 30:Add, Text, xm+0 yp+22 W%STA_LabelWidth% Right BackgroundTrans, Process : 
		Gui, 30:Font, s7, Courier New
		Gui, 30:Add, Edit, % "x+1 yp-1 TabStop W" . (STA_EditionWidth - 101) . " H15 vSTA_WindowProcess"
		Gui, 30:Add, Edit, x+1 TabStop W100 H15 vSTA_WindowPID

		Gui, 30:Font
		Gui, 30:Font, Bold
		Gui, 30:Add, Text, xm+0 yp+17 W%STA_LabelWidth% Right BackgroundTrans, Performance : 
		Gui, 30:Font, s7, Courier New
		Gui, 30:Add, Edit, x+1 yp-1 TabStop W%STA_EditionWidth% H15 vSTA_Performance

		Gui, 30:Font
		Gui, 30:Font, Bold
		Gui, 30:Add, Text, xm+0 yp+22 W%STA_LabelWidth% Right BackgroundTrans, Bounds : 
		Gui, 30:Font, s7, Courier New
		Gui, 30:Add, Edit, x+1 yp-1 TabStop W150 H15 vSTA_WindowBounds
		Gui, 30:Add, Edit, x+1 TabStop W70 H15 vSTA_WindowSize

		Gui, 30:Font
		Gui, 30:Font, Bold
		Gui, 30:Add, Text, x+1 yp+1 W%STA_LabelWidth% Right BackgroundTrans, Screen : 
		Gui, 30:Font, s7, Courier New
		Gui, 30:Add, Edit, x+1 yp-1 TabStop W150 H15 vSTA_ScreenBounds, % "(" . SCR_VirtualScreenX . ", " . SCR_VirtualScreenY . ") » (" . (SCR_VirtualScreenX + SCR_VirtualScreenWidth) . ", " . (SCR_VirtualScreenY + SCR_VirtualScreenHeight) . ")"
		Gui, 30:Add, Edit, x+1 TabStop W70 H15 vSTA_ScreenSize, %SCR_VirtualScreenWidth% × %SCR_VirtualScreenHeight%
		Gui, 30:Font
		Gui, 30:Font, Bold
		Gui, 30:Add, Text, % "x+1 yp+1 Right W" . (STA_EditionWidth - (151 + 71 + STA_LabelWidth + 1 + 151 + 71 + 71 + 71)) . " BackgroundTrans", Mouse : 
		Gui, 30:Font, s7, Courier New
		Gui, 30:Add, Edit, x+1 yp-1 TabStop W70 H15 vSTA_MousePosition
		Gui, 30:Add, Edit, x+1 TabStop W50 H15 vSTA_HoveredColor
		Gui, 30:Add, Edit, xp+49 -TabStop W21 H15 vSTA_ColoredZone

		Gui, 30:Font
		Gui, 30:Font, Bold
		LOC_ControlTextWidth := STA_EditionWidth - (151 + 71 + STA_LabelWidth + 1 + 151 + 71 + 71 + 71)
		Gui, 30:Add, Text, xm+0 yp+17 W%STA_LabelWidth% Right BackgroundTrans, Status bar : 
		Gui, 30:Font, s7, Courier New
		Gui, 30:Add, Edit, % "x+1 yp-1 TabStop W" . (STA_EditionWidth - (LOC_ControlTextWidth + 1 + 142)) . " H15 vSTA_WindowStatusBar"
		Gui, 30:Font
		Gui, 30:Font, Bold
		Gui, 30:Add, Text, x+1 yp+1 W%LOC_ControlTextWidth% Right BackgroundTrans, Control : 
		Gui, 30:Font, s7, Courier New
		Gui, 30:Add, Edit, x+1 yp-1 TabStop W141 H15 vSTA_ControlClass

		Gui, 30:Font
		Gui, 30:Font, s7, Courier New
		Gui, 30:Add, ListView, % "xm+0 yp+22 TabStop VScroll Grid -Multi +Hdr +ReadOnly -WantF2 Count50 +LV0x10 +LV0x20 vSTA_WindowText gADM_WindowSpyListViewManager H150 W" . STA_LabelWidth + STA_EditionWidth, Text

		Gui, 30:Font
		Gui, 30:Font, s7, Courier New
		Gui, 30:Add, ListView, % "xm+0 yp+157 TabStop VScroll Grid -Multi +Hdr +ReadOnly -WantF2 Count50 +LV0x10 +LV0x20 gADM_WindowSpyListViewManager vSTA_WindowControls H150 W" . STA_LabelWidth + STA_EditionWidth, Control|Text|Bounds|Dimension
		Gui, 30:Font

		SysGet, LOC_MonitorCount, MonitorCount
		If (LOC_MonitorCount > 1) {
			Loop, Parse, STA_LengthVariables, |
			{
				LOC_Monitor%A_LoopField%A := []
				, LOC_Monitor%A_LoopField%Length := 0
			}
			Loop, %LOC_MonitorCount% {
				SysGet, LOC_Monitor, Monitor, %A_Index%
				LOC_MonitorIndex := A_Index
				, LOC_MonitorWidth := LOC_MonitorRight - LOC_MonitorLeft
				, LOC_MonitorHeight := LOC_MonitorBottom - LOC_MonitorTop
				Loop, Parse, STA_LengthVariables, |
				{
					LOC_Monitor%A_LoopField%A[LOC_MonitorIndex] := LOC_Monitor%A_LoopField%
					, LOC_Monitor%A_LoopField%Length := max(LOC_Monitor%A_LoopField%Length, StrLen(LOC_Monitor%A_LoopField%))
				}
			}
			LOC_Monitors := ""
			Loop, %LOC_MonitorCount% {
				LOC_Monitors .= (A_Index // 2 == A_Index / 2 ? "    –    " : (A_Index == 1 ? "" : "`r`n")) . A_Index . ": ("
				LOC_Monitors .= AHK_AdjustString(LOC_MonitorLeftA[A_Index], LOC_MonitorLeftLength, PRM_Alignement := false) . ", " . AHK_AdjustString(LOC_MonitorTopA[A_Index], LOC_MonitorTopLength) . ") » (" . AHK_AdjustString(LOC_MonitorRightA[A_Index], LOC_MonitorRightLength, PRM_Alignement := false) . ", " . AHK_AdjustString(LOC_MonitorBottomA[A_Index], LOC_MonitorBottomLength) . ")    "
				LOC_Monitors .= AHK_AdjustString(LOC_MonitorWidthA[A_Index], LOC_MonitorWidthLength, PRM_Alignement := false) . " × " . AHK_AdjustString(LOC_MonitorHeightA[A_Index], LOC_MonitorHeightLength)
			}
			Gui, 30:Font
			Gui, 30:Font, Bold
			Gui, 30:Add, Text, xm+0 yp+162 W%STA_LabelWidth% Right BackgroundTrans, Monitors : 
			Gui, 30:Font, s7, Courier New
			Gui, 30:Add, Edit, % "x+1 yp-1 TabStop W" . STA_EditionWidth . " H" . (15 * (LOC_MonitorCount // 2)) . " vSTA_Monitors", %LOC_Monitors%
			Gui, 30:Font
			Gui, 30:Font, s7, Courier New
			Gui, 30:Add, ListView, % "xm+0 yp+" . (15 * (LOC_MonitorCount // 2) + 2) . " W" . STA_LabelWidth + STA_EditionWidth . " TabStop VScroll Grid -Multi +Hdr +ReadOnly -WantF2 Count50 +LV0x10 +LV0x20 gADM_WindowSpyListViewManager vSTA_Windows H150", Window|Title|ID|Bounds|Dimension
		} Else {
			Gui, 30:Font
			Gui, 30:Font, s7, Courier New
			Gui, 30:Add, ListView, % "xm+0 yp+162 W" . STA_LabelWidth + STA_EditionWidth . " TabStop VScroll Grid -Multi +Hdr +ReadOnly -WantF2 Count50 +LV0x10 +LV0x20 gADM_WindowSpyListViewManager vSTA_Windows H150", Window|Title|ID|Bounds|Dimension
		}

		Gui, 30:Font
		Gui, 30:Font, s7, Courier New
		Gui, 30:Font

		Gui, 30:Font
		Gui, 30:Font, s7, Courier New
		Gui, 30:Add, ListView, % "xm+0 yp+157 TabStop VScroll Grid -Multi +Hdr +ReadOnly -WantF2 Count50 +LV0x10 +LV0x20 gADM_WindowSpyListViewManager vSTA_HiddenWindows H150 W" . STA_LabelWidth + STA_EditionWidth, Hidden Window|Title|ID
		Gui, 30:Font

		Gui, 30:Add, StatusBar, , Press Right-Shift to track the hovered windows
		Gui, 30:Default
		SB_SetParts(250, 250)
		SB_SetText(" Press Alt to freeze display", 2)
		SB_SetText(" Press Esc to exit", 3)
		Gui, 30:Show, AutoSize Center NoActivate, WindowSpy
		
		Gui, 31:Destroy ; GUI_WindowSpyHoveredColor
		Gui, 31:+AlwaysOnTop -Caption -SysMenu -Resize +ToolWindow +Disabled

		WinGetPos, LOC_GuiX, LOC_GuiY, , , ahk_id %STA_GuiID%
		ControlGetPos, LOC_ColoredZoneX, LOC_ColoredZoneY, LOC_ColoredZoneWidth, LOC_ColoredZoneHeight, Edit16, ahk_id %STA_GuiID%
		STA_ColorGuiX := LOC_GuiX + LOC_ColoredZoneX + 1
		, STA_ColorGuiY := LOC_GuiY + LOC_ColoredZoneY + 1
		Gui, 31:Show, % "X" . STA_ColorGuiX . " Y" . STA_ColorGuiY . " W" . (LOC_ColoredZoneWidth - 2) . " H" . (LOC_ColoredZoneHeight - 2) . " NoActivate", GUI_WindowSpyHoveredColor
	}

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	If (PRM_ListViewIndexToActivate) {
		Gui, 30:ListView, %PRM_ListViewIndexToActivate%
		Return
	}

	; Window ID :
	;;;;;;;;;;;;;
	LOC_RightShift := GetKeyState("RShift", "P")
	CoordMode, Mouse, Screen
	MouseGetPos, LOC_MouseX, LOC_MouseY, LOC_WindowID, LOC_HoveredControlClass
	If (LOC_RightShift) {
		LOC_ControlClass := LOC_HoveredControlClass
	} Else {
		WinGet, LOC_WindowID, ID, A
		ControlGetFocus, LOC_ControlClass, ahk_id %LOC_WindowID%
		If (LOC_WindowID == STA_GuiID) {
			LOC_WindowID := STA_WindowID
			ControlGetFocus, LOC_ControlClass, ahk_id %STA_WindowID%
		}
	}
	LOC_NewWindow := (STA_WindowID != LOC_WindowID)
	If (LOC_NewWindow) {
		STA_PerformanceCount := 0
	}

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	LOC_Refresh := PRM_Show
	, LOC_AltDown := GetKeyState("LAlt", "P")
	If (LOC_AltDown != STA_AltDown) {
		If (LOC_AltDown) {
			STA_Suspended := !STA_Suspended
			, LOC_Refresh := true
			If (STA_Suspended) {
				GuiControl, 30:, STA_SuperTitle, Frozen display
			}
		}
		STA_AltDown := LOC_AltDown
	}
	If (PRM_Show) {
		STA_Suspended := false
		Gui, 30:Show, NoActivate
		Gui, 31:Show, NoActivate
	}
	If (LOC_Refresh) {
		Gui, 30:Default
		LOC_Command := (STA_Suspended ? "Enable" : "Disable")
		GuiControl, %LOC_Command%, STA_WindowTitle
		GuiControl, %LOC_Command%, STA_Description
		GuiControl, %LOC_Command%, STA_WindowClass
		GuiControl, %LOC_Command%, STA_WindowID
		GuiControl, %LOC_Command%, STA_WindowStyles
		GuiControl, %LOC_Command%, STA_ExtendedWindowStyles
		GuiControl, %LOC_Command%, STA_WindowProcess
		GuiControl, %LOC_Command%, STA_WindowPID
		GuiControl, %LOC_Command%, STA_Performance
		GuiControl, %LOC_Command%, STA_WindowBounds
		GuiControl, %LOC_Command%, STA_WindowSize
		GuiControl, %LOC_Command%, STA_ScreenBounds
		GuiControl, %LOC_Command%, STA_ScreenSize
		GuiControl, %LOC_Command%, STA_MousePosition
		GuiControl, %LOC_Command%, STA_HoveredColor
		GuiControl, %LOC_Command%, STA_WindowStatusBar
		GuiControl, %LOC_Command%, STA_ControlClass
		GuiControl, %LOC_Command%, STA_Monitors
		SB_SetText(STA_Suspended ? " Press Alt to refresh display" : " Press Alt to freeze display", 2)
		; TODO : SB_SetIcon(A_ScriptDir . "\media\" . AHK_ScriptName . ".icl", <icon number>, 2)
	}
	WinGetPos, LOC_GuiX, LOC_GuiY, , , ahk_id %STA_GuiID%
	ControlGetPos, LOC_ColoredZoneX, LOC_ColoredZoneY, , , Edit16, ahk_id %STA_GuiID%
	If (STA_ColorGuiX != LOC_GuiX + LOC_ColoredZoneX + 1
		|| STA_ColorGuiY != LOC_GuiY + LOC_ColoredZoneY + 1) {
		STA_ColorGuiX := LOC_GuiX + LOC_ColoredZoneX + 1
		, STA_ColorGuiY := LOC_GuiY + LOC_ColoredZoneY + 1
		Try {
			Gui, 31:Show, % "X" . STA_ColorGuiX . " Y" . STA_ColorGuiY . " NA", GUI_WindowSpyHoveredColor
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "ADM_WindowSpy")
		}
	}

	WinExist("ahk_id " . LOC_WindowID)
	If (STA_Suspended) {
		Loop, 8	{
			Gui, % (31 + A_Index) . ":Destroy" ; GUI_WindowSpyHoveredWindow* & GUI_WindowSpyHoveredControl*
		}
	} Else {

		; Title, Class, Description :
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		If (LOC_RightShift) {
			Gui, 30:Default ; WindowSpy
			SB_SetText(" Press Right-Shift to track the active window")
			GuiControl, 30:, STA_SuperTitle, Hovered window
		} Else {
			Gui, 30:Default
			SB_SetParts(250, 250)
			SB_SetText(" Press Right-Shift to track the hovered window")
			GuiControl, 30:, STA_SuperTitle, Active window
		}
		WinGetTitle, LOC_WindowTitle
		WinGetClass, LOC_WindowClass
		WinGet, LOC_WindowPID, PID
		For LOC_Win32Process In ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process where ProcessID = " . LOC_WindowPID) {
			LOC_WindowProcess := LOC_Win32Process.CommandLine
			LOC_WindowProcessTime := A_Now
			EnvSub, LOC_WindowProcessTime, % SubStr(LOC_Win32Process.CreationDate, 1, 14), Seconds
			Break
		}
		WinGet, LOC_WindowProcessPath, ProcessPath
		If (!LOC_WindowProcess) {
			LOC_WindowProcess := LOC_WindowProcessPath
		}
		If (LOC_NewWindow) {
			GuiControl, 30:, STA_WindowID
			GuiControl, 30:, STA_Description, % ADM_GetFileInfo(LOC_WindowProcessPath)
		}

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; Styles :
		;;;;;;;;;;
		LOC_IsStylesTooltip := false
		If (LOC_HoveredControlClass == "Edit5"
			&& !LOC_RightShift) {
			MouseGetPos, , , LOC_HoveredWindowID
			WinGetClass, LOC_HoveredWindowClass, ahk_id %LOC_HoveredWindowID%
			WinGetTitle, LOC_HoveredWindowTitle, ahk_id %LOC_HoveredWindowID%
			If (LOC_HoveredWindowClass == "AutoHotkeyGUI"
				&& InStr(LOC_HoveredWindowTitle, "WindowSpy")) {
				LOC_IsStylesTooltip := true
			}
		}
		LOC_WindowStyles := LOC_Tooltip := ""
		WinGet, LOC_Style, Style
		For LOC_Key, LOC_Value In STA_PredefinedWindowStyles
		{
			If (LOC_Style & LOC_Value) {
				LOC_WindowStyles .= LOC_Key . "  "
				If (LOC_IsStylesTooltip) {
					LOC_Tooltip .= (LOC_Tooltip ? "`r`n" : "") . LOC_Key . ": " . STA_WindowStyleLabels[LOC_Key]
				}
			}
		}

		; Extended styles :
		;;;;;;;;;;;;;;;;;;;
		LOC_IsExtendedStylesTooltip := false
		If (!LOC_IsStylesTooltip
			&& !LOC_RightShift
			&& LOC_HoveredControlClass == "Edit6") {
			MouseGetPos, , , LOC_HoveredWindowID
			WinGetClass, LOC_HoveredWindowClass, ahk_id %LOC_HoveredWindowID%
			WinGetTitle, LOC_HoveredWindowTitle, ahk_id %LOC_HoveredWindowID%
			If (LOC_HoveredWindowClass == "AutoHotkeyGUI"
				&& InStr(LOC_HoveredWindowTitle, "WindowSpy")) {
				LOC_IsExtendedStylesTooltip := true
			}
		}
		LOC_ExtendedWindowStyles := ""
		WinGet, LOC_ExStyle, ExStyle
		For LOC_Key, LOC_Value In STA_PredefinedExtendedWindowStyles
		{
			If (LOC_ExStyle & LOC_Value) {
				LOC_ExtendedWindowStyles .= LOC_Key . "  "
				If (LOC_IsExtendedStylesTooltip) {
					LOC_Tooltip .= (LOC_Tooltip ? "`r`n" : "") . LOC_Key . ": " . STA_ExtendedWindowStyleLabels[LOC_Key]
				}
			}
		}

		; Transparency :
		;;;;;;;;;;;;;;;;
		WinGet, LOC_Transparency, Transparent
		If (LOC_Transparency
			&& LOC_Transparency != 255) {
			LOC_ExtendedWindowStyles .= (100 - 100 * LOC_Transparency // 255) . "% Transparent"
		} Else {
			LOC_ExtendedWindowStyles .= "Opaque"
		}

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		If (STA_PerformanceCount <= 0) {

			STA_PerformanceCount := 4

			; Memory :
			;;;;;;;;;;
			LOC_ProcessHandler := DllCall(STA_OpenProcessFunction, "UInt", 0x10|0x400, "Int", 0, "UInt", LOC_WindowPID)
			, VarSetCapacity(LOC_MemoryCounters, 40, 0)
			, DllCall(STA_GetProcessMemoryInfoFunction, "UInt", LOC_ProcessHandler, "UInt", &LOC_MemoryCounters, "UInt", 40)
			, VarSetCapacity(LOC_MemoryString, 16, 0)
			, DllCall(STA_StrFormatByteSize64AFunction, "Int64", NumGet(LOC_MemoryCounters, 12, "UInt"), "Str", LOC_MemoryString, "UInt", 16)
			, VarSetCapacity(LOC_MaxMemoryString, 16, 0)
			, DllCall(STA_StrFormatByteSize64AFunction, "Int64", NumGet(LOC_MemoryCounters, 8, "UInt"), "Str", LOC_MaxMemoryString, "UInt", 16)
			, LOC_Performance := "Memory: " .  LOC_MemoryString . " / " . LOC_MaxMemoryString . "  –  "

			; CPU :
			;;;;;;;
			DllCall(STA_GetProcessTimesFunction, "UInt", LOC_ProcessHandler, "Int64P", LOC_CreationTime, "Int64P", LOC_ExitTime, "Int64P", LOC_KernelTime, "Int64P", LOC_UserTime)
			, LOC_CPUProcessLoad := Min(99, Round((LOC_KernelTime - STA_KernelTime + LOC_UserTime - STA_UserTime) / (100000 * STA_ProcessorCount)))
			, STA_KernelTime := LOC_KernelTime
			, STA_UserTime := LOC_UserTime
			, LOC_OldIdleTime := STA_IdleTime
			, LOC_OldCPUTick := STA_CPUTick
			, VarSetCapacity(LOC_IdleTicks, 8, 0)
			, DllCall(STA_GetSystemTimesFunction, "UInt", &LOC_IdleTicks, "UInt", 0, "UInt", 0)
			, STA_IdleTime := *(&LOC_IdleTicks)
			Loop, 7 {
				STA_IdleTime += *(&LOC_IdleTicks + A_Index) << (8 * A_Index)
			}
			STA_CPUTick := A_TickCount
			SetFormat, Integer, D
			LOC_CPUTotalLoad := 100 - Max(1, Round((STA_IdleTime - LOC_OldIdleTime) / (STA_CPUTick - LOC_OldCPUTick)) // (100 * STA_ProcessorCount))
			If (StrLen(LOC_CPUTotalLoad) < 2) {
				LOC_CPUTotalLoad  := " " . LOC_CPUTotalLoad
			}
			LOC_Performance .= "CPU: " . (LOC_CPUProcessLoad < 10 ? " " : "") . LOC_CPUProcessLoad . " % / " . LOC_CPUTotalLoad . " %  –  "

			; Priority :
			;;;;;;;;;;;;
			LOC_Priority := SYS_ProcessPriority(, !LOC_RightShift)
			If (LOC_Priority) {
				LOC_Performance .= "Priority: " . SYS_ProcessPriority(0, !LOC_RightShift) . "  –  "
			}

			; Handles :
			;;;;;;;;;;;
			VarSetCapacity(LOC_HandleCount, 4, 0)
			, DllCall(STA_GetProcessHandleCountFunction, "Ptr", LOC_ProcessHandler, "PtrP", LOC_HandleCount)
			, DllCall(ZZZ_CloseHandleFunction, "UInt", LOC_ProcessHandler)

			; Threads :
			;;;;;;;;;;;
			VarSetCapacity(LOC_ProcessesInformation, 0, 0)
			, VarSetCapacity(LOC_BufferSize, A_PtrSize, 0)
			, DllCall(STA_NtQuerySystemInformationFunction, "UInt", 0x5, "Ptr", &LOC_ProcessesInformation, "UInt", 0, "Ptr", &LOC_BufferSize)
			, VarSetCapacity(LOC_ProcessesInformation, NumGet(LOC_BufferSize), 0)
			, DllCall(STA_NtQuerySystemInformationFunction, "UInt", 0x5, "Ptr", &LOC_ProcessesInformation, "UInt", NumGet(LOC_BufferSize), "Ptr", &LOC_BufferSize)
			LOC_Process := NumGet(&LOC_ProcessesInformation, 0, "UInt")
			While (NumGet(&LOC_ProcessesInformation + LOC_Process, 0, "UInt")) {
				If (NumGet(&LOC_ProcessesInformation + LOC_Process, (A_PtrSize == 8 ? "80" : "68"), "Ptr") == LOC_WindowPID) {
					LOC_Performance .= "Threads: " . NumGet(&LOC_ProcessesInformation + LOC_Process, 4, "UInt") . "  –  "
					Break
				}
				LOC_Process += NumGet(&LOC_ProcessesInformation + LOC_Process, 0, "UInt")
			}

			LOC_Seconds := Mod(LOC_WindowProcessTime, 60)
			, LOC_WindowProcessTime := Floor(LOC_WindowProcessTime / 60)
			, LOC_SinceTime := (LOC_Seconds < 10 ? "0" : "") . LOC_Seconds . " sec"
			If (LOC_WindowProcessTime > 0) {
				LOC_Minutes := Mod(LOC_WindowProcessTime, 60)
				, LOC_WindowProcessTime := Floor(LOC_WindowProcessTime / 60)
				, LOC_SinceTime := (LOC_Minutes < 10 ? "0" : "") . LOC_Minutes . " min " . LOC_SinceTime
				If (LOC_WindowProcessTime > 0) {
					LOC_Hours := Mod(LOC_WindowProcessTime, 24)
					, LOC_WindowProcessTime := Floor(LOC_WindowProcessTime / 24)
					, LOC_SinceTime := LOC_Hours . " hour" . (LOC_Hours > 1 ? "s " : " ") . LOC_SinceTime
					If (LOC_WindowProcessTime > 0) {
						LOC_SinceTime := LOC_WindowProcessTime . " day" . (LOC_WindowProcessTime > 1 ? "s " : " ") . LOC_SinceTime
					}
				}
			}
			LOC_Performance .= "Handles: " . LOC_HandleCount . "  –  Since: " . LOC_SinceTime
		} Else {
			LOC_Performance := STA_Performance
			, STA_PerformanceCount--
		}
		LOC_WindowPID := "ahk_pid " . LOC_WindowPID

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; Bounds :
		;;;;;;;;;;
		WinGetPos, LOC_WindowX, LOC_WindowY, LOC_WindowWidth, LOC_WindowHeight
		LOC_WindowBounds := "(" . LOC_WindowX . ", " . LOC_WindowY . ") » (" . (LOC_WindowX + LOC_WindowWidth) . ", " . (LOC_WindowY + LOC_WindowHeight) . ")"
		LOC_WindowSize := LOC_WindowWidth . " × " . LOC_WindowHeight

		; Mouse :
		;;;;;;;;;
		LOC_MousePosition := "(" . LOC_MouseX . ", " . LOC_MouseY . ")"
		CoordMode, Pixel, Screen

		; Color :
		;;;;;;;;;
		PixelGetColor, LOC_HoveredColor, LOC_MouseX, LOC_MouseY, RGB
		StringReplace, LOC_HoveredColor, LOC_HoveredColor, 0x, #
		If (STA_HoveredColor != LOC_HoveredColor) {
			Gui, 31:Color, % "0x" . SubStr(LOC_HoveredColor, 2) ; GUI_WindowSpyHoveredColor
		}

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; Text :
		;;;;;;;;
		ControlGetFocus, LOC_FocusedControl, ahk_id %STA_GuiID%
		If (LOC_FocusedControl != "SysListView321") {
			DetectHiddenText, On
			VarSetCapacity(LOC_WindowText, 4096)
			WinGetText, LOC_WindowText
			DetectHiddenText, Off
			If (LOC_WindowText != STA_WindowText) {
				STA_WindowText := LOC_WindowText
				Gui, 30:ListView, STA_WindowText
				LOC_ListViewCount := LV_GetCount()
				, LOC_TextCount := 0
				Sort, LOC_WindowText, CL
				Loop, Parse, LOC_WindowText, `n`v`f, `r
				{
					Try {
						LOC_Text := Trim(RegExReplace(A_LoopField, "[  \t\r\n]+", " "))
					} Catch LOC_Exception {
						AHK_Catch(LOC_Exception, "ADM_WindowSpy")
						, LOC_Text := A_LoopField
					}
					LOC_Length := StrLen(LOC_Text)
					If (LOC_Length == 0) {
						Continue
					}
					LOC_TextCount++
					, LOC_Text := (LOC_Length > 159 ? SubStr(LOC_Text, 1, 158) . "…" : LOC_Text)
					If (LOC_ListViewCount < LOC_TextCount) {
						LV_Add()
					}
					LV_Modify(PRM_RowIndex := LOC_TextCount, PRM_Options := "", LOC_Text)
				}
				If (LOC_ListViewCount > LOC_TextCount) {
					Loop, % LOC_ListViewCount - LOC_TextCount {
						LV_Delete(PRM_RowIndex := LOC_ListViewCount - A_Index + 1)
					}
				}

				AHK_AdjustListView(PRM_FinalWidth := STA_LabelWidth + STA_EditionWidth, PRM_ColumnsNumber := 1, PRM_ColumnToAdjust := "1", PRM_ListViewIndex := 1, PRM_WindowID := STA_GuiID)
			}
		}

		; Status bar :
		;;;;;;;;;;;;;;
		LOC_WindowStatusBar := ""
		, LOC_WindowStatusBarParts := ""
		Loop
		{
			StatusBarGetText, LOC_WindowStatusBarPart, %A_Index%
			LOC_WindowStatusBarPart := Trim(LOC_WindowStatusBarPart)
			If (LOC_WindowStatusBarPart) {
				LOC_WindowStatusBar .= (LOC_WindowStatusBar ? " | " : "") . (LOC_WindowStatusBarParts ? LOC_WindowStatusBarParts . "| " : "") . LOC_WindowStatusBarPart
				, LOC_WindowStatusBarParts := ""
			} Else {
				If (A_Index > 10) {
					Break
				}
				LOC_WindowStatusBarParts .= (LOC_WindowStatusBarParts ? "| " : " ")
			}
		}

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; Controls :
		;;;;;;;;;;;;
		If (LOC_FocusedControl != "SysListView322") {
			LOC_ControlCount := LOC_ActiveControlIndex := 0
			, LOC_WindowControls := ""

			WinGet, LOC_ControlsList, ControlList
			Loop, Parse, LOC_ControlsList, `r`n
			{
				LOC_Class := A_LoopField
				Try {
					ControlGet, LOC_ControlTextList, List, %LOC_ControlClass%
				} Catch LOC_Exception {
					; AHK_Catch(LOC_Exception, "ADM_WindowSpy")
					LOC_ControlTextList := ""
				}
				If (LOC_ControlTextList) {
					Loop, Parse, LOC_ControlTextList, `n
					{
						Try {
							LOC_ControlText := Trim(RegExReplace(A_LoopField, "[  \t\r\n]+", " "))
						} Catch LOC_Exception {
							AHK_Catch(LOC_Exception, "ADM_WindowSpy")
							, LOC_ControlText := Trim(A_LoopField)
						}
						LOC_TextLength := StrLen(LOC_ControlText)
						, LOC_ControlText := (LOC_TextLength > 96 ? SubStr(LOC_ControlText, 1, 95) . "…" : LOC_ControlText)
						, LOC_WindowControls .= LOC_Class . "`t" . LOC_ControlText . "`n"
						, LOC_ControlCount++
					}
				} Else {
					Try {
						ControlGetText, LOC_ControlText, %LOC_Class%
						LOC_ControlText := Trim(RegExReplace(LOC_ControlText, "[  \t\r\n]+", " "))
						, LOC_TextLength := StrLen(LOC_ControlText)
						, LOC_ControlText := (LOC_TextLength > 96 ? SubStr(LOC_ControlText, 1, 95) . "…" : LOC_ControlText)
						, LOC_WindowControls .= LOC_Class . "`t" . LOC_ControlText . "`n"
					}
					LOC_ControlCount++
				}

				If (LOC_Class == LOC_ControlClass) {
					LOC_ActiveControlIndex := LOC_ControlCount
				}
			}
			Sort, LOC_WindowControls, CL

			If (LOC_WindowControls != STA_WindowControls) {
				STA_WindowControls := LOC_WindowControls
				, LOC_ControlClassA := {}
				, LOC_ControlTextA := {}
				Loop, Parse, STA_LengthVariables, |
				{
					LOC_Control%A_LoopField%MaxLength := 0
					, LOC_Control%A_LoopField%A := {}
				}
				Loop, Parse, LOC_WindowControls, `n
				{
					Loop, Parse, A_LoopField, `t
					{
						LOC_Field%A_Index% := A_LoopField
					}
					LOC_ControlIndex := A_Index
					LOC_ControlClassA[LOC_ControlIndex] := LOC_Field1
					, LOC_ControlTextA[LOC_ControlIndex] := LOC_Field2
					ControlGetPos, LOC_ControlX, LOC_ControlY, LOC_ControlWidth, LOC_ControlHeight, %LOC_Field1%
					LOC_ControlLeftA[LOC_ControlIndex] := LOC_WindowX + LOC_ControlX
					, LOC_ControlTopA[LOC_ControlIndex] := LOC_WindowY + LOC_ControlY
					, LOC_ControlRightA[LOC_ControlIndex] := LOC_WindowX + LOC_ControlX + LOC_ControlWidth
					, LOC_ControlBottomA[LOC_ControlIndex] := LOC_WindowY + LOC_ControlY + LOC_ControlHeight
					, LOC_ControlWidthA[LOC_ControlIndex] := LOC_ControlWidth
					, LOC_ControlHeightA[LOC_ControlIndex] := LOC_ControlHeight
					Loop, Parse, STA_LengthVariables, |
					{
						LOC_Control%A_LoopField%MaxLength := max(LOC_Control%A_LoopField%MaxLength, StrLen(LOC_Control%A_LoopField%A[LOC_ControlIndex]))
					}
				}

				Gui, 30:ListView, STA_WindowControls
				LOC_LinesNumber := LV_GetCount()
				If (LOC_LinesNumber < LOC_ControlCount) {
					Loop, % LOC_ControlCount - LOC_LinesNumber
					{
						LV_Add()
					}
				} Else If (LOC_ControlCount < LOC_LinesNumber) {
					Loop, % LOC_LinesNumber - LOC_ControlCount
					{
						LV_Delete(PRM_RowIndex := LOC_LinesNumber - A_Index + 1)
					}
				}

				For LOC_Index In LOC_ControlClassA
				{
					LV_Modify(PRM_RowIndex := A_Index, PRM_Options := (A_Index == LOC_ActiveControlIndex ? "Select Vis" : ""), LOC_ControlClassA[A_Index], LOC_ControlTextA[A_Index], "(" . AHK_AdjustString(LOC_ControlLeftA[A_Index], LOC_ControlLeftMaxLength, false) . ", " . AHK_AdjustString(LOC_ControlTopA[A_Index], LOC_ControlTopMaxLength) . ") » (" . AHK_AdjustString(LOC_ControlRightA[A_Index], LOC_ControlRightMaxLength, PRM_Alignement := false) . ", " . AHK_AdjustString(LOC_ControlBottomA[A_Index], LOC_ControlBottomMaxLength) . ")", AHK_AdjustString(LOC_ControlWidthA[A_Index], LOC_ControlWidthMaxLength, PRM_Alignement := false) . " × " . LOC_ControlHeightA[A_Index])
				}
				AHK_AdjustListView(PRM_FinalWidth := STA_LabelWidth + STA_EditionWidth, PRM_ColumnsNumber := 4, PRM_ColumnToAdjust := "2", PRM_ListViewIndex := 2, PRM_WindowID := STA_GuiID)
			}
		}

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; Windows :
		;;;;;;;;;;;
		If (LOC_FocusedControl != "SysListView323") {
			DetectHiddenWindows, Off
			WinGet, LOC_WindowsIDs, List, , , Program Manager
			LOC_Windows := ""
			, LOC_WindowsCount := 0
			Loop, %LOC_WindowsIDs% {
				StringTrimRight, LOC_ID, LOC_WindowsIDs%A_Index%, 0
				WinGetClass, LOC_Class, ahk_id %LOC_ID%
				WinGetTitle, LOC_Title, ahk_id %LOC_ID%
				If ((LOC_Class != "AutoHotkeyGUI"
						|| LOC_Title != "GUI_LeftTopToolTip"
							&& LOC_Title != "GUI_WidthHeightToolTip"
							&& LOC_Title != "GUI_RightBottomToolTip"
							&& LOC_Title != "GUI_ToolTip"
							&& LOC_Title != "GUI_BufferedToolTip"
							&& LOC_Title != "GUI_DisplayFusionColoredTaskbar"
							&& LOC_Title != "GUI_WindowSpyHoveredColor"
							&& LOC_Title != AHK_ScriptInfo)
					&& LOC_Class != "tooltips_class32"
					&& LOC_Class != "SysShadow") {
					StringReplace, LOC_Class, LOC_Class, `t, %A_Space%, All
					StringReplace, LOC_Title, LOC_Title, `t, %A_Space%, All
					LOC_Windows .= LOC_Class . "`t" . LOC_Title . "`t" . LOC_ID . "`n"
					, LOC_WindowsCount++
				}
			}
			Sort, LOC_Windows, CL
			If (STA_Windows != LOC_Windows) {
				STA_Windows := LOC_Windows
				, LOC_TitleA := {}
				, LOC_ClassA := {}
				, STA_WindowIDA := {}
				Loop, Parse, STA_LengthVariables, |
				{
					LOC_Window%A_LoopField%MaxLength := 0
					, LOC_Window%A_LoopField%A := {}
				}
				Loop, Parse, LOC_Windows, `n
				{
					Loop, Parse, A_LoopField, `t
					{
						LOC_Field%A_Index% := A_LoopField
					}
					WinGetPos, LOC_X, LOC_Y, LOC_Width, LOC_Height, ahk_id %LOC_Field3%
					LOC_ID := "0x" . AHK_AdjustString(SubStr(LOC_Field3, 3), PRM_Length := 7, PRM_Alignement := false, PRM_CompletionChar := "0")
					, LOC_ClassA[LOC_ID] := LOC_Field1
					, LOC_TitleA[LOC_ID] := LOC_Field2
					, STA_WindowIDA[LOC_ID] := "" . LOC_ID
					, LOC_WindowLeftA[LOC_ID] := LOC_X
					, LOC_WindowTopA[LOC_ID] := LOC_Y
					, LOC_WindowRightA[LOC_ID] := LOC_X + LOC_Width
					, LOC_WindowBottomA[LOC_ID] := LOC_Y + LOC_Height
					, LOC_WindowWidthA[LOC_ID] := LOC_Width
					, LOC_WindowHeightA[LOC_ID] := LOC_Height
					Loop, Parse, STA_LengthVariables, |
					{
						LOC_Window%A_LoopField%MaxLength := max(LOC_Window%A_LoopField%MaxLength, StrLen(LOC_Window%A_LoopField%A[LOC_ID]))
					}
				}
				Gui, 30:ListView, STA_Windows
				LOC_LinesNumber := LV_GetCount()
				If (LOC_LinesNumber < LOC_WindowsCount) {
					Loop, % LOC_WindowsCount - LOC_LinesNumber
					{
						LV_Add()
					}
				}
				If (LOC_WindowsCount < LOC_LinesNumber) {
					Loop, % LOC_LinesNumber - LOC_WindowsCount
					{
						LV_Delete(PRM_RowIndex := LOC_LinesNumber - A_Index + 1)
					}
				}

				For LOC_Index, LOC_ID In STA_WindowIDA
				{
					LV_Modify(PRM_RowIndex := A_Index, PRM_Options := (LOC_Index == STA_WindowID ? "Select Vis" : ""), LOC_ClassA[LOC_Index], LOC_TitleA[LOC_Index], LOC_ID, "(" . AHK_AdjustString(LOC_WindowLeftA[LOC_Index], LOC_WindowLeftMaxLength, PRM_Alignement := false) . ", " . AHK_AdjustString(LOC_WindowTopA[LOC_Index], LOC_WindowTopMaxLength) . ") » (" . AHK_AdjustString(LOC_WindowRightA[LOC_Index], LOC_WindowRightMaxLength, PRM_Alignement := false) . ", " . AHK_AdjustString(LOC_WindowBottomA[LOC_Index], LOC_WindowBottomMaxLength) . ")", AHK_AdjustString(LOC_WindowWidthA[LOC_Index], LOC_WindowWidthMaxLength, PRM_Alignement := false) . " × " . LOC_WindowHeightA[LOC_Index])
				}

				AHK_AdjustListView(PRM_FinalWidth := STA_LabelWidth + STA_EditionWidth, PRM_ColumnsNumber := 5, PRM_ColumnsToAdjust := "1|2", PRM_ListViewIndex := 3, PRM_WindowID := STA_GuiID)
			}
		}

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; Hidden windows :
		;;;;;;;;;;;;;;;;;;
		If (LOC_FocusedControl != "SysListView324") {
			DetectHiddenWindows, On
			WinGet, LOC_HiddenWindowsIDs, List, , , Program Manager
			LOC_HiddenWindows := ""
			, LOC_HiddenWindowsCount := 0
			Loop, %LOC_HiddenWindowsIDs% {
				StringTrimRight, LOC_HiddenID, LOC_HiddenWindowsIDs%A_Index%, 0
				LOC_HiddenID := "0x" . AHK_AdjustString(SubStr(LOC_HiddenID, 3), PRM_Length := 7, PRM_Alignement := false, PRM_CompletionChar := "0")
				If (STA_WindowIDA[LOC_HiddenID]) {
					Continue
				}
				WinGetTitle, LOC_HiddenTitle, ahk_id %LOC_HiddenID%
				WinGetClass, LOC_HiddenClass, ahk_id %LOC_HiddenID%

				If ((LOC_HiddenTitle != "GUI_LeftTopToolTip"
							&& LOC_HiddenTitle != "GUI_WidthHeightToolTip"
							&& LOC_HiddenTitle != "GUI_RightBottomToolTip"
							&& LOC_HiddenTitle != "GUI_ToolTip"
							&& LOC_HiddenTitle != "GUI_BufferedToolTip"
							&& LOC_HiddenTitle != "GUI_WindowSpyHoveredColor"
						|| LOC_HiddenClass != "AutoHotkeyGUI")
					&& LOC_HiddenClass != "tooltips_class32"
					&& LOC_HiddenClass != "TPUtilWindow"
					&& LOC_HiddenClass != "IME"
					&& LOC_HiddenClass != "MSCTFIME UI"
					&& LOC_HiddenClass != "#43"
					&& LOC_HiddenClass != "ComboLBox"
					&& LOC_HiddenClass != "REListBox20W"
					&& LOC_HiddenClass != "BaseBar"
					&& LOC_HiddenClass != "SysPager"
					&& LOC_HiddenClass != "rctrl_renwnd32"
					&& SubStr(LOC_HiddenClass, 1, 5) != "DDEML"
					&& LOC_HiddenClass != "GDI+ Hook Window Class"
					&& LOC_HiddenClass != "WorkerW") {
					StringReplace, LOC_HiddenClass, LOC_HiddenClass, `t, %A_Space%, All
					StringReplace, LOC_HiddenTitle, LOC_HiddenTitle, `t, %A_Space%, All
				LOC_HiddenWindows .= LOC_HiddenClass . "`t" . LOC_HiddenTitle . "`t" . LOC_HiddenID . "`n"
					, LOC_HiddenWindowsCount++
				}
			}
			Sort, LOC_HiddenWindows, CL
			If (STA_HiddenWindows != LOC_HiddenWindows) {
				STA_HiddenWindows := LOC_HiddenWindows
				, LOC_HiddenTitleA := {}
				, LOC_HiddenClassA := {}
				, LOC_HiddenIDA := {}
				Loop, Parse, LOC_HiddenWindows, `n
				{
					Loop, Parse, A_LoopField, `t
					{
						LOC_Field%A_Index% := A_LoopField
					}
					LOC_HiddenTitleA[LOC_Field3] := LOC_Field2
					, LOC_HiddenClassA[LOC_Field3] := LOC_Field1
					, LOC_HiddenIDA[LOC_Field3] := "" . LOC_Field3
				}
				Gui, 30:ListView, STA_HiddenWindows
				LOC_LinesNumber := LV_GetCount()
				If (LOC_LinesNumber < LOC_HiddenWindowsCount) {
					Loop, % LOC_HiddenWindowsCount - LOC_LinesNumber
					{
						LV_Add()
					}
				}
				If (LOC_HiddenWindowsCount < LOC_LinesNumber) {
					Loop, % LOC_LinesNumber - LOC_HiddenWindowsCount
					{
						LV_Delete(PRM_RowIndex := LOC_LinesNumber - A_Index + 1)
					}
				}

				For LOC_Index, LOC_HiddenID In LOC_HiddenIDA
				{
					LV_Modify(PRM_RowIndex := A_Index, PRM_Options := "", LOC_HiddenClassA[LOC_Index], LOC_HiddenTitleA[LOC_Index], "" . LOC_HiddenID)
				}

				AHK_AdjustListView(PRM_FinalWidth := STA_LabelWidth + STA_EditionWidth, PRM_ColumnsNumber := 3, PRM_ColumnsToAdjust := "2", PRM_ListViewIndex := 4, PRM_WindowID := STA_GuiID)
			}
		}

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; Refresh data :
		;;;;;;;;;;;;;;;;
		If (STA_HoveredColor != LOC_HoveredColor) {
			GuiControl, % "31:+Background" . SubStr(LOC_HoveredColor, 2), STA_ColoredZone ; GUI_WindowSpyHoveredColor
		}
		LOC_Variables := "WindowTitle|WindowClass|WindowID|WindowStyles|ExtendedWindowStyles|WindowProcess|WindowPID|Performance|WindowBounds|WindowSize|MousePosition|HoveredColor|WindowStatusBar|ControlClass"
		Loop, Parse, LOC_Variables, |
		{
			If (STA_%A_LoopField% != LOC_%A_LoopField%) {
				STA_%A_LoopField% := LOC_%A_LoopField%
				GuiControl, 30:, STA_%A_LoopField%, % (A_LoopField == "WindowID" ? "ahk_id " : (A_LoopField == "WindowClass" ? "ahk_class " : "")) . LOC_%A_LoopField%
			}
		}

		If (LOC_Tooltip) {
			AHK_ShowTooltip(LOC_Tooltip, PRM_Seconds := 0.5, PRM_Transparency := 255)
		} Else If (STA_IsStylesTooltip
			|| STA_IsExtendedStylesTooltip) {
			AHK_HideToolTip()
		}
		STA_IsStylesTooltip := LOC_IsStylesTooltip
		, STA_IsExtendedStylesTooltip := LOC_IsExtendedStylesTooltip

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; Hovered control :
		;;;;;;;;;;;;;;;;;;;
		If (LOC_RightShift) {
			WinGetPos, LOC_WindowX, LOC_WindowY, LOC_WindowWidth, LOC_WindowHeight
		} Else {
			Gui, 30:ListView, STA_Windows
				LOC_SelectedRow := LV_GetNext(0, "Focused")
			If (LOC_SelectedRow) {
				LV_GetText(LOC_HoveredControlID, LOC_SelectedRow, 3)
				WinGetPos, LOC_WindowX, LOC_WindowY, LOC_WindowWidth, LOC_WindowHeight, ahk_id %LOC_HoveredControlID%
			} Else {
				LOC_WindowWidth := 0
			}
		}
		If (LOC_WindowWidth
			&& (LOC_WindowClass != "AutoHotkeyGUI"
				|| SubStr(LOC_WindowTitle, 1, 20) != "GUI_WindowSpyHovered")) {
			
			; Hovered window border :
			If (!WinExist("GUI_WindowSpyHoveredWindowTop ahk_class AutoHotkeyGUI")) {
				Loop, 4	{ ; GUI_WindowSpyHoveredWindow*
					LOC_GuiIndex := 31 + A_Index
					Gui, %LOC_GuiIndex%:Destroy
					Gui, %LOC_GuiIndex%:-Caption -SysMenu -Border -Resize +AlwaysOnTop +ToolWindow +Owner +Disabled
					Gui, %LOC_GuiIndex%:Color, FB7737
				}
			}
			Gui, 32:Show, % "x" . LOC_WindowX . " y" . (LOC_WindowY - 1) . " w" . (LOC_WindowWidth + 1) . " h3 NoActivate", GUI_WindowSpyHoveredWindowTop
			Gui, 33:Show, % "x" . (LOC_WindowX - 1) . " y" . LOC_WindowY . " w3 h" . (LOC_WindowHeight + 1) . " NoActivate", GUI_WindowSpyHoveredWindowLeft
			Gui, 34:Show, % "x" . LOC_WindowX . " y" . (LOC_WindowY + LOC_WindowHeight - 1) . " w" . (LOC_WindowWidth + 2) . " h3 NoActivate", GUI_WindowSpyHoveredWindowBottom
			Gui, 35:Show, % "x" . (LOC_WindowX + LOC_WindowWidth - 1) . " y" . LOC_WindowY . " w3 h" . (LOC_WindowHeight + 2) . "NoActivate", GUI_WindowSpyHoveredWindowRight
			
			; Hovered control border :
			If (LOC_RightShift) {
				ControlGetPos, LOC_ControlX, LOC_ControlY, LOC_ControlWidth, LOC_ControlHeight, %LOC_HoveredControlClass%, ahk_id %LOC_WindowID%
			} Else {
				Gui, 30:ListView, STA_WindowControls
				LOC_SelectedRow := LV_GetNext(0, "Focused")
				If (LOC_SelectedRow) {
					LV_GetText(LOC_HoveredControlClass, LOC_SelectedRow)
					ControlGetPos, LOC_ControlX, LOC_ControlY, LOC_ControlWidth, LOC_ControlHeight, %LOC_HoveredControlClass%, ahk_id %LOC_WindowID%
				} Else {
					LOC_HoveredControlClass := ""
					, LOC_ControlWidth := 0
				}
			}
			If (LOC_HoveredControlClass
				&& LOC_ControlWidth) {
				WinGetPos, LOC_WindowX, LOC_WindowY, LOC_WindowWidth, LOC_WindowHeight
				If (!WinExist("GUI_WindowSpyHoveredControlTop ahk_class AutoHotkeyGUI")) {
					Loop, 4	{ ; GUI_WindowSpyHoveredControl*
						LOC_GuiIndex := 35 + A_Index
						Gui, %LOC_GuiIndex%:Destroy
						Gui, %LOC_GuiIndex%:-Caption -SysMenu -Border -Resize +AlwaysOnTop +ToolWindow +Owner +Disabled
						Gui, %LOC_GuiIndex%:Color, FFFF00
					}
				}
				Gui, 36:Show, % "x" . (LOC_WindowX + LOC_ControlX) . " y" . (LOC_WindowY + LOC_ControlY - 1) . " w" . (LOC_ControlWidth + 1) . " h3 NoActivate", GUI_WindowSpyHoveredControlTop
				Gui, 37:Show, % "x" . (LOC_WindowX + LOC_ControlX - 1) . " y" . (LOC_WindowY + LOC_ControlY) . " w3 h" . (LOC_ControlHeight + 1) . " NoActivate", GUI_WindowSpyHoveredControlLeft
				Gui, 38:Show, % "x" . (LOC_WindowX + LOC_ControlX) . " y" . (LOC_WindowY + LOC_ControlY + LOC_ControlHeight - 1) . " w" . (LOC_ControlWidth + 2) . " h3 NoActivate", GUI_WindowSpyHoveredControlBottom
				Gui, 39:Show, % "x" . (LOC_WindowX + LOC_ControlX + LOC_ControlWidth - 1) . " y" . (LOC_WindowY + LOC_ControlY) . " w3 h" . (LOC_ControlHeight + 2) . " NoActivate", GUI_WindowSpyHoveredControlRight
				;VarSetCapacity(LOC_HoveredControlText, 65)
				;Try {
				;	ControlGetText, LOC_HoveredControlText, %LOC_HoveredControlClass%, ahk_id %LOC_WindowID%
				;	LOC_HoveredControlText := Trim(RegExReplace(LOC_HoveredControlText, "[  \t\r\n]+", " "))
				;} Catch {
				;	LOC_HoveredControlText := ""
				;}
				;LOC_HoveredControlTextLength := StrLen(LOC_HoveredControlText)
				;LOC_HoveredControlText := (LOC_HoveredControlTextLength > 64 ? SubStr(LOC_HoveredControlText, 1, 63) . "…" : LOC_HoveredControlText)
				;AHK_ShowToolTip(LOC_ControlText . (LOC_HoveredControlTextLength > 0 ? " " : "") . "ahk_class " . LOC_HoveredControlClass . "    [ " . (LOC_WindowTitle ? LOC_WindowTitle . "   " : "") . "ahk_class " . LOC_WindowClass . " ]", PRM_Seconds := 0.5, PRM_Transparency := 255)
				If (LOC_RightShift) {
					AHK_ShowToolTip(LOC_HoveredControlClass . "    [ " . (LOC_WindowTitle ? LOC_WindowTitle . "   " : "") . "ahk_class " . LOC_WindowClass . " ]", PRM_Seconds := 0.5, PRM_Transparency := 255)
				}
			} Else {
				Gui, 36:Destroy
				Gui, 37:Destroy
				Gui, 38:Destroy
				Gui, 39:Destroy
				AHK_ShowToolTip("[ " . (LOC_WindowTitle ? LOC_WindowTitle . "   " : "") . "ahk_class " . LOC_WindowClass . " ]", PRM_Seconds := 0.5, PRM_Transparency := 255)
			}
		} Else {
			Loop, 8 {
				Gui, % (31 + A_Index) . ":Destroy"
			}
		}
	}

	DetectHiddenWindows, Off
	If (WinExist("ahk_id " . STA_GuiID)) {
		SetTimer, ADM_WindowSpyRefreshTimer, %ZZZ_WindowSpyRefreshTimer%
	} Else {
		Gui, 31:Hide ; GUI_WindowSpyHoveredColor
		Gui, 30:Hide ; WindowSpy
	}
	DetectHiddenWindows, On
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

30GuiClose:
30GuiEscape:
ADM_HideWindowSpy()
Return

ADM_HideWindowSpy() {
	SetTimer, ADM_WindowSpyRefreshTimer, Off
	Loop, 10 {
		Gui, % 40 - A_Index . ":Hide"
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_WindowSpyListViewManager:
ADM_WindowSpyListViewManager()
Return

ADM_WindowSpyListViewManager() {

	Global TXT_ClipBoard, ZZZ_ClipBoardInitialized
	If (A_GuiEvent == "DoubleClick") {
		Critical, On
		ADM_WindowSpy(PRM_Show = true, PRM_ListViewToActivate := A_GuiControl)
		If (A_GuiControl == "STA_WindowText") {
			LV_GetText(LOC_Text, A_EventInfo, 1)
			If (StrLen(LOC_Text) == 0) {
				Return
			}
			LOC_Class := ""
		} Else {
			LV_GetText(LOC_Class, A_EventInfo, 1)
			, LV_GetText(LOC_Text, A_EventInfo, 2)
			, LOC_Class := (StrLen(LOC_Text) > 0 ? " " : "") . "ahk_class " . LOC_Class
		}

		LOC_ClipBoard := LOC_Text . LOC_Class
		, LOC_Alternate := GetKeyState("Alt")
		, LOC_AppendMode := GetKeyState("Ctrl")

		LOC_LengthIndication := StrLen(LOC_ClipBoard) . " chars copied [" . (StrLen(LOC_Text) > 64 ? SubStr(LOC_Text, 1, 63) . "…" : LOC_Text) . LOC_Class . "]"

		; Set append separator :
		If (LOC_AppendMode) {
			LOC_ContentAlreadyMemorized := (LOC_Alternate ? TXT_ClipBoard : ClipBoard) . ""
			StringRight, LOC_Separator, LOC_ContentAlreadyMemorized, 1
			If (StrLen(LOC_ContentAlreadyMemorized) > 0
				&&LOC_Separator != ""
				&& LOC_Separator != A_Space
				&& LOC_Separator != "`n"
				&& LOC_Separator != "`r"
				&& LOC_Separator != "`v"
				&& LOC_Separator != "`f"
				&& LOC_Separator != "`t") {
				LOC_ClipBoard := LOC_ContentAlreadyMemorized . " " . LOC_ClipBoard
			} Else {
				LOC_ClipBoard := LOC_ContentAlreadyMemorized . LOC_ClipBoard
			}
		}

		If (LOC_Alternate) {
			TXT_ClipBoard := LOC_ClipBoard
			TXT_ClipBoardHistoryManager(PRM_SetOperation := 1, PRM_AlternateClipBoard := true, PRM_Append := false)
			SetTimer, TXT_SaveAlternateClipBoard, -1
		} Else {
			TXT_SetClipBoard(LOC_ClipBoard)
			If (!ZZZ_ClipBoardInitialized) {
				TXT_ClipBoard := LOC_ClipBoard
				SetTimer, TXT_SaveAlternateClipBoard, -1
			}
		}
		AHK_ShowToolTip((LOC_Alternate ? "Alternate clipboard <" : "Clipboard <") . (LOC_AppendMode ? "< " : " ") . LOC_LengthIndication)
		Critical, Off
		Return
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; WinSpector { Ctrl + Win + Shift + X } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_WinSpector:
Suspend, Permit
^+#x::
ADM_WinSpector()
Return

ADM_WinSpector() {
	Global APP_WinSpectorPath
	APP_Run("WinSpector", APP_WinSpectorPath, , , PRM_Maximized := false)
	If (WinActive("Winspector -")) {
		WinGetClass, LOC_WindowClass
		If (StrLen(LOC_WindowClass) == 29
			&& SubStr(LOC_WindowClass, 1, 21) == "Afx:400000:8:10011:0:") {
			WinSet, AlwaysOnTop, On
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Visit website { Ctrl + Win + Shift + W } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_Website:
^+#w::
Run, http://www.autohotkey.com, , UseErrorLevel
If (ErrorLevel == "ERROR") {
	TRY_ShowTrayTip("AutoHotKey website disabled", 3)
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; About { Ctrl + Win + Shift + F1 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_InitAboutLinks() {
	Global
	ZZZ_AboutLinks =
	( LTrim Join`,
		Nifty>http://www.enovatic.org/products/niftywindows/introduction/
		Start>http://www.autohotkey.com/board/topic/7611-start-button-clock-cpu-and-memory-usage-mod-of-laszlos/#entry47095
		Lock>http://www.donationcoder.com/Software/Skrommel/index.html#DragLock
		Drag>http://www.autohotkey.com/community/viewtopic.php?t=59726
		Accelerate>http://www.autohotkey.com/forum/viewtopic.php?p=323193
		Nav>http://www.donationcoder.com/Software/Skrommel#FastNavKeys
		Zoomer>http://www.autohotkey.com/community/viewtopic.php?t=18167
		Reader>http://www.autohotkey.com/board/topic/94619-ahk-l-screen-reader-a-tool-to-get-text-anywhere/?hl=screenreader
		ASCII>http://www.autohotkey.com/board/topic/2619-capture-from-screen-to-ascii-art/
		Picker>http://www.autohotkey.com/community/viewtopic.php?p=57968#57968
		Magnifier>http://www.autohotkey.com/community/viewtopic.php?t=18167
		Colorette>http://www.autohotkey.com/community/viewtopic.php?t=69559
		Taskbar>http://www.donationcoder.com/Software/Skrommel/
		Pack>http://www.autohotkey.com/board/topic/53052-script-tomoe-ueharas-home-made/page-3
		Community>http://www.autohotkey.com/community/viewforum.php?f=2
		AutoHotKey>http://www.autohotkey.com/docs/Tutorial.htm
		Tray>http://www.autohotkey.com/community/viewtopic.php?t=33263
		Paste>http://www.autohotkey.com/community/viewtopic.php?t=11427
		Sound>http://www.autohotkey.com/community/viewtopic.php?t=61411
		Cursor>http://www.autohotkey.com/board/topic/8394-changing-the-mouse-cursor/
		Capture>http://www.autohotkey.com/community/viewtopic.php?f=2&t=18146
		Image>http://www.autohotkey.com/community/viewtopic.php?t=14941
		Console>http://sourceforge.net/projects/console/
		Dialogs>http://www.donationcoder.com/Software/Skrommel/index.html#ShowDialogsToo
		Crypt>http://www.autohotkey.com/board/topic/94631-encrypt-password-protected-powerful-text-encryption/
		jugglemaster>http://www.jugglemaster.fr/
	) ; To work, each word has to appear in the corresponding link label
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_About:
^+#F1::
AHK_KeyWait("^+#", "F1")
ADM_About()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_About() {

	Global ZZZ_ActiveTrayIcon, AHK_ScriptInfo

	Gui, 1:Destroy ; About
	Gui, 1:-MaximizeBox -MinimizeBox -Resize +Owner +ToolWindow
	Gui, 1:Margin, 90, 20

	Gui, 1:Font, Bold
	Gui, 1:Add, Text, cWhite y+15 BackgroundTrans, %AHK_ScriptInfo%
	Gui, 1:Add, Text, cBlack xp-1 yp-1 BackgroundTrans, %AHK_ScriptInfo%
	Gui, 1:Font
	Gui, 1:Add, Text, yp+20, Compilation of AHK Scripts (and much more... :-)

	Gui, 1:Font, Underline
	Gui, 1:Add, Text, yp+35 xp+50 cBlue, Nifty Windows
	Gui, 1:Font
	Gui, 1:Add, Text, x+1, `, by Enovatic-Solutions

	LOC_Text =
	( LTrim
		Drag To Scroll|by Cheek
		Drag Lock|by Skrommel
		Accelerated Scrolling|by BoffinbraiN
		Fast Nav Keys|by Skrommel
		Screen Capture|by Sean
		Show Script Image|by PhiLho
		Capture From Screen To ASCII Art|by Tinypig
		Screen Reader|by Nepter
		Screen Magnifier|by Sean
		Fun Pack|by Tomoe Uehara
		Color Taskbar|by Skrommel
		Color Zoomer/Picker|by Skan
		Color Picker GENIE|by Skan
		Colorette|by Sumon
		Paste Plain Text|by Laszlo
		Sound! Fade In, Fade Out!|by TheSoupMeat
		Start Button Clock|by Laszlo
		Changing the mouse cursor|by Skrommel
		Show Dialogs Too|by Skrommel
		Win Traymin|by Sean
		Console|by Bozho
		Crypt|by Avi Aryan
	)
	Loop, Parse, LOC_Text, `n
	{
		StringSplit, LOC_Item, A_LoopField, % "|"
		Gui, 1:Font, Underline
		Gui, 1:Add, Text, cBlue xm+50 yp+20, % LOC_Item1
		Gui, 1:Font
		Gui, 1:Add, Text, x+1, % "`, " . LOC_Item2
	}

	Gui, 1:Add, Text, xm+50 yp+20, and many others... by the `
	Gui, 1:Font, Underline
	Gui, 1:Add, Text, cBlue x+1, AutoHotKey Community
	Gui, 1:Font
	Gui, 1:Add, Text, x+1, ` !

	Gui, 1:Add, Text, yp+35 xm-0, This tool was made using the powerful` `
	Gui, 1:Font, Underline
	Gui, 1:Add, Text, cBlue x+1, AutoHotKey

	Gui, 1:Font
	Gui, 1:Font, Bold
	Gui, 1:Add, Text, xm+1 yp+21 cWhite BackgroundTrans, Please visit me at` `
	Gui, 1:Add, Text, xp-1 yp-1 cBlack BackgroundTrans, Please visit me at` `
	Gui, 1:Font
	Gui, 1:Font, CBlue Underline
	Gui, 1:Add, Text, x+1, www.jugglemaster.fr
	Gui, 1:Font

	Gui, 1:Add, StatusBar, , Press Esc to exit
	SB_SetParts(85, 500)

	; TODO : chargement de l'icône About ne marche pas !
	LOC_TrayIconHandle := DllCall("user32.dll\CreateIconFromResourceEx", "UInt", &ZZZ_ActiveTrayIcon + 22, "UInt", NumGet(ZZZ_ActiveTrayIcon, 14), "Int", 1, "UInt", 0x30000, "Int", 16, "Int", 16, "UInt", 0)
	SendMessage, 0x80, 0, LOC_TrayIconHandle

	Gui, 1:Show, , About
	OnMessage(0x200, "ADM_SetLinkCursor")
	, OnMessage(0x202, "ADM_GoToLink")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_SetLinkCursor(wParam, lParam) {
	IfWinActive, About ahk_class AutoHotkeyGUI
	{
		CoordMode, Mouse, Screen
		MouseGetPos, , , , LOC_ControlName
		If (LOC_ControlName != "") {
			Try {
				ControlGetText, LOC_ControlText, %LOC_ControlName%
			} Catch LOC_Exception {
				AHK_Catch(LOC_Exception, "ADM_SetLinkCursor", wParam, lParam)
				, AHK_ResetCursor()
				Return
			}

			Global ZZZ_AboutLinks
			Loop, Parse, ZZZ_AboutLinks, `,
			{
				StringSplit, LOC_NameAndLink, A_LoopField, >
				IfInString, LOC_ControlText, % LOC_NameAndLink1
				{
					AHK_SetCursor("Hand")
					Gui, 1:Default
					SB_SetText(LOC_NameAndLink2, 2)
					Return
				}
			}
		}
	}
	Gui, 1:Default
	SB_SetText("", 2)
	AHK_ResetCursor()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ADM_GoToLink(wParam, lParam) {
	IfWinActive, About ahk_class AutoHotkeyGUI
	{
		CoordMode, Mouse, Screen
		MouseGetPos, , , , LOC_ControlName
		If (LOC_ControlName != "") {
			Try {
				ControlGetText, LOC_ControlText, %LOC_ControlName%
			} Catch LOC_Exception {
				AHK_Catch(LOC_Exception, "ADM_GoToLink", wParam, lParam)
				Return
			}

			Global ZZZ_AboutLinks
			Loop, Parse, ZZZ_AboutLinks, `,
			{
				StringSplit, LOC_NameAndLink, A_LoopField, >
				IfInString, LOC_ControlText, % LOC_NameAndLink1
				{
					Run, %LOC_NameAndLink2%, , UseErrorLevel
					If (ErrorLevel == "ERROR") {
						TRY_ShowTrayTip(LOC_NameAndLink1 . " not launched", 3)
					}
					OnMessage(0x200, "")
					, OnMessage(0x202, "")
					Gui, 1:Destroy
					AHK_ResetCursor()
					Return
				}
			}
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Close About dialog { Enter | Escape } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

1GuiClose:
Gui, 1:Destroy
OnMessage(0x200, "")
, OnMessage(0x202, "")
, AHK_ResetCursor()
Return

#IfWinActive, About ahk_class AutoHotkeyGUI
Enter::
Gui, 1:Destroy
OnMessage(0x200, "")
, OnMessage(0x202, "")
, AHK_ResetCursor()
Return
Esc::
Gui, 1:Destroy
OnMessage(0x200, "")
, OnMessage(0x202, "")
, AHK_ResetCursor()
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
