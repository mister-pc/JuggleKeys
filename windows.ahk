;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_Init() {

	Global
	ZZZ_AlwaysOnTopWindowIDs := ZZZ_RolledWindowIDs := ZZZ_TransparencyWindowIDs := ""
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Close Object { MiddleClick } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MButton::
+MButton::
!MButton::
WIN_MiddleButton()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_MiddleButton() {

	Global SCR_VirtualScreenX, SCR_VirtualScreenY, SCR_VirtualScreenWidth, SCR_VirtualScreenHeight
	WinGet, LOC_ActiveWindowID, ID
	MouseGetPos, LOC_MouseX, LOC_MouseY, LOC_WindowID, LOC_ControlClass
	If (LOC_WindowID) {
		WinActivate, ahk_id %LOC_WindowID%
		WinWaitActive, ahk_id %LOC_WindowID%
	} Else {
		LOC_WindowID := LOC_ActiveWindowID
	}
	WinActive("A")
	WinGetClass, LOC_WindowClass
	WinGetTitle, LOC_WindowTitle
	WinGet, LOC_ProcessName, ProcessName
	CoordMode, Mouse, Screen
	LOC_TitleBarClickZone := WIN_GetTitleBarClickZone()

	; Close window after title bar click :
	If (LOC_TitleBarClickZone == "t") {
		If (LOC_WindowClass == "TConversationForm") { ; Skype
			SendInput, {Ctrl Up}{Esc}
		} Else If (LOC_WindowClass == "tSkMainForm") { ; Skype
			SendInput, {Alt Down}s{Alt Up}f
		} Else If (LOC_WindowClass == "AutoHotkey" && InStr(LOC_WindowTitle, A_ScriptFullPath . " - AutoHotkey")) { ; AutoHotKey debug window
			WinMinimize
		;~ } Else 	If (LOC_WindowClass == "CommunicatorMainWindowClass") { ; Lync main window
			;~ WinHide
		} Else {
			WinClose
			LOC_WindowTitle := WIN_GetWindowTitle(LOC_WindowID)
			TRY_ShowTrayTip(LOC_WindowTitle . " closed")
			, AUD_Beep()
		}
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; Minimize to tray after minimize click :
	If (LOC_TitleBarClickZone == "m") {
		WIN_MinimizeToTray(LOC_WindowID)
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; Maximize window after maximize click :
	If (LOC_TitleBarClickZone == "M") {
		If (A_ThisHotkey == "+MButton") {
			WIN_MaximizeOnAllScreens()
		} Else If (A_ThisHotkey == "!MButton") {
			WIN_MaximizeOnNextScreen()
		} Else If (A_ThisHotKey == "MButton") {
			Win_MaximizeVertically()
		}
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; Kill window after title bar click :
	If (LOC_TitleBarClickZone == "x") {
		If (AHK_SystemWindowClass(LOC_WindowClass)) {
			PRM_PowerManager(PRM_Submit := false, PRM_State := 3, , PRM_YesDefaultButton := false)
			Return
		}
		WinGet, LOC_KillWindowPID, PID
		LOC_WindowTitle := WIN_GetWindowTitle(LOC_WindowID)
		WinKill
		Process, Close, %LOC_ActiveWindowPID%
		SendMessage, 0x02
		AUD_Beep()
		, TRY_ShowTrayTip(LOC_WindowTitle . " killed", 2)
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; Kill window from everywhere { Shift | Alt } + { Middle Button } :
	If (A_ThisHotkey == "!MButton"
		|| A_ThisHotkey == "+MButton") {
		WIN_Close()
		, AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; Defined actions :
	;;;;;;;;;;;;;;;;;;;
	
	; Escape action :
	If (LOC_WindowClass == "ytWindow" && LOC_ProcessName == "PicasaPhotoViewer.exe" ; Picasa
		|| LOC_WindowClass == "WMPTransition" ; WMP
		|| LOC_WindowClass == "ShockwaveFlashFullScreen" ; Flash
		|| LOC_WindowClass == "#32770" && LOC_WindowTitle == "Process Explorer Search" ; Process Explorer search
		|| LOC_WindowClass == "#32770" && LOC_WindowTitle == "Rechercher - Directory Opus" ; Directory Opus search
		|| LOC_WindowClass == "screenClass" && InStr(LOC_WindowTitle, "PowerPoint") ; PowerPoint
		|| LOC_WindowClass == "TFNewPlayer") { ; MediaMonkey player
		SendInput, {Esc}
		AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; Hide window action :
	If (LOC_WindowClass == "CommunicatorMainWindowClass") { ; Lync main window
		WinHide
		AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; Control-W action :
	If (LOC_WindowClass == "CabinetWClass" ; Shell
		|| LOC_WindowClass == "PSDocC" ; Photoshop
		|| LOC_WindowClass == "Photoshop" && LOC_WindowTitle != "Adobe Photoshop" ; Photoshop
		|| LOC_WindowClass == "XLMAIN" && LOC_WindowTitle != "Excel (Utilisation non commerciale)" && LOC_WindowTitle != "Excel" && LOC_WindowTitle != "Microsoft Excel" && LOC_WindowTitle != "Microsoft Excel (Échec de l’activation du produit)" && LOC_WindowTitle != "Excel (Échec de l’activation du produit)" ; Excel
		|| LOC_WindowClass == "Notepad++") { ; Notepad++
		SendInput, ^w
		AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; Control-F4 action :
	If (LOC_WindowClass == "IEFrame" ; IE
		|| LOC_WindowClass == "Console_2_Main" ; Console²
		|| LOC_WindowClass == "PPTFrameClass" && LOC_WindowTitle != "PowerPoint" && LOC_WindowTitle != "PowerPoint (Échec de l’activation du produit)" ; PowerPoint
		|| LOC_WindowClass == "SnagIt9Editor" && LOC_WindowTitle != "Editeur Snagit" ; Snag-It document
		|| LOC_WindowClass == "SciTEWindow" ; SCiTE editor
		|| LOC_WindowClass == "SunAwtFrame" && InStr(LOC_WindowTitle, "SQL Developer") ; SQL Developer
		|| LOC_WindowClass == "Maxthon3Cls_MainFrm") { ; Maxthon
		SendInput, ^{F4}
		AUD_Beep()
		; AHK_Debug("Ctrl-F4 sur " . LOC_WindowTitle . " ahk_class " . LOC_WindowClass)
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; Alt-F4 action :
	If (LOC_WindowClass == "SunAwtFrame" && ((LOC_KGSTitle := SubStr(LOC_WindowTitle, 1, 6)) == "KGS : " || LOC_KGSTitle == "CGoban") ; KGS
		|| LOC_WindowClass == "PlayerCanvas" && (InStr(LOC_WindowTitle, "QMP") || LOC_WindowTitle == "Quintessential Media Player") ; Quintessential
		|| LOC_WindowClass == "ExtPlayerCanvas" ; Quintessential
		|| LOC_WindowClass == "PROCEXPL" ; Process Explorer
		|| LOC_WindowClass == "ProcessHacker" ; Process Hacker
		|| LOC_WindowClass == "TMainForm" ; Media Monkey
		|| LOC_WindowClass == "TFMainWindow" ; Media Monkey
		|| LOC_WindowClass == "TFImage" ; Media Monkey album image
		|| LOC_WindowClass == "wxWindowNR" ; FileZilla
		|| LOC_WindowClass == "TkTopLevel" ; GitK
		|| LOC_WindowClass == "HH Parent" ; Windows CHTML file
		|| LOC_WindowClass == "AutoHotkeyGUI" ; AHK self windows
			&& (LOC_WindowTitle == "WindowSpy"
				|| LOC_WindowTitle == "About"
				|| LOC_WindowTitle == "GUI_Memo"
				|| LOC_WindowTitle == "GUI_Magnifier"
				|| LOC_WindowTitle == "Lock Keyboard"
				|| LOC_WindowTitle == "Unlock Keyboard"
				|| LOC_WindowTitle == "Text Capture"
				|| LOC_WindowTitle == "Unicode Art Capture"
				|| LOC_WindowTitle == "ASCII Art Capture"
				|| LOC_WindowTitle == "Clipboard history")
		|| LOC_WindowClass == "MMCMainFrame" ; Management console
		|| LOC_WindowClass == "mintty" ; Git-bash
		|| LOC_WindowClass == "TAppForm" && InStr(LOC_WindowTitle, "Registrar Registry Manager") ; Registry Manager
		|| LOC_WindowClass == "MozillaWindowClass" && (LOC_WindowTitle == "Enregistrement des mots de passe" || LOC_WindowTitle == "Carnet d'adresses" || SubStr(LOC_WindowTitle, 1, 12) == "Diaporama - " || SubStr(LOC_WindowTitle, 1, 12) == "Source de : " || SubStr(LOC_WindowTitle, 1, 11) == "Source of: ")
		|| LOC_WindowClass == "OpusApp" && (LOC_WindowTitle == "Word" || LOC_WindowTitle == "Microsoft Word" || LOC_WindowTitle == "Microsoft Word (Échec de l’activation du produit)" || LOC_WindowTitle == "Word (Échec de l’activation du produit)") ; Word
		|| LOC_WindowClass == "XLMAIN" && (LOC_WindowTitle == "Excel" || LOC_WindowTitle == "Excel (Utilisation non commerciale)" || LOC_WindowTitle == "Microsoft Excel" || LOC_WindowTitle == "Microsoft Excel (Échec de l’activation du produit)" || LOC_WindowTitle == "Excel (Échec de l’activation du produit)") ; Excel
		|| LOC_WindowClass == "PPTFrameClass" && (LOC_WindowTitle == "PowerPoint" || LOC_WindowTitle == "PowerPoint (Échec de l’activation du produit)") ; PowerPoint
		|| LOC_WindowClass == "SnagIt9Editor" && LOC_WindowTitle == "Editeur Snagit" ; Snag-It Editor with no more document
		|| LOC_WindowClass == "SnagIt5UI" && LOC_WindowTitle == "Snagit" ; Snag-It
		|| LOC_WindowClass == "CisMainWizard" ; Comodo
		|| LOC_ProcessName == "Startup Delayer.exe"
		|| LOC_ProcessName == "DuplicateCleaner.exe" ; Duplicate Cleaner
		|| LOC_WindowClass == "Photoshop" && LOC_WindowTitle == "Adobe Photoshop" ; Photoshop
		|| LOC_ProcessName == "screamer.exe" ; Screamer Radio
		|| LOC_WindowClass == "MozillaWindowClass" && LOC_WindowTitle == "Bibliothèque" ; Firefox history
		|| LOC_WindowClass == "CalcFrame"
		|| LOC_WindowClass == "PuTTY" ; PuTTY
		|| LOC_WindowClass == "AU3Reveal" ; Window Spy
		|| LOC_WindowClass == "TAIDA64" ; Aida 64
		|| LOC_WindowClass == "rctrl_renwnd32" ; Outlook message view
		|| LOC_WindowClass == "IMWindowClass" ; Lync chat window
		|| LOC_WindowClass == "SWT_Window0" && InStr(LOC_WindowTitle, "IBM Lotus Sametime Connect") ; Sametime
		|| LOC_WindowClass == "tSkMainForm" ; Skype
		|| LOC_WindowClass == "TConversationForm") { ; Skype
		SendInput, !{F4}
		AUD_Beep()
		AHK_Debug("Alt-F4 sur " . LOC_WindowTitle . " ahk_class " . LOC_WindowClass)
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}
	
	; Close window action :
	If (LOC_WindowClass == "WMPlayerApp" ; WMP
		|| LOC_WindowClass == "WMP Skin Host" ; WMP
		|| LOC_ProcessName == "uTorrent.exe" ; µTorrent
		|| LOC_WindowTitle == "Freemake Video Converter" && SubStr(LOC_WindowClass, 1, 26) == "HwndWrapper[FreemakeVC.exe" ; Video Converter
		|| LOC_WindowClass == "AutoHotkey" && SubStr(LOC_WindowTitle, 1, StrLen(A_ScriptFullPath)) == A_ScriptFullPath ; Debug
		|| LOC_WindowClass == "NativeHWNDHost" && InStr(LOC_WindowTitle, "Ajouter ou supprimer des programmes")) { ; Ajout/Suppression de programmes
		WinClose
		AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; Kill window action :
	If (LOC_WindowClass == "PlatformViewClassSession0" && LOC_WindowTitle == "Uplay" ; Rayman
		|| LOC_WindowClass == "uplay_main" && LOC_WindowTitle == "Uplay" ; Rayman
		|| LOC_WindowClass == "uplay_spotlight" && LOC_WindowTitle == "Spotlight" ; Rayman
		|| LOC_WindowClass == "SunAwtFrame" && LOC_WindowTitle == "CGoban : Fenêtre Principale" ; KGS
		|| InStr(LOC_WindowTitle, "DAMN NFO Viewer")) { ; NFO viewer
		WinKill
		AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; Specific defined actions :
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	; Systray :
	If (LOC_WindowClass == "Shell_TrayWnd") {
		SendInput, ^+{Esc}
		Return
	}
	
	; Directory Opus :
	If (LOC_WindowClass == "dopus.lister") {
		If (LOC_WindowTitle == "Corbeille"
			|| LOC_WindowTitle == "Ordinateur") {
			SendInput, {Ctrl Up}{Esc}^{F4}
		} Else If (InStr(LOC_ControlClass, "dopus.filedisplay")
			|| InStr(LOC_ControlClass, "dopus.iconfiledisplay")) {
			ControlGet, LOC_SecondFileDisplayID, Hwnd, , dopus.filedisplay2
			If (LOC_SecondFileDisplayID) {
				SendInput, {Ctrl Up}{Esc}^{F4}
			} Else {
				SendInput, {Ctrl Up}{Esc}!{F4}
			}
		} Else If (InStr(LOC_ControlClass, "RICHEDIT") ; Viewer txt
			|| InStr(LOC_ControlClass, "SysListView") ; Viewer zip
			|| InStr(LOC_ControlClass, "dopus.viewpic") ; Viewer images
			|| InStr(LOC_ControlClass, "dopus.listerviewpane") ; Viewer images
			|| InStr(LOC_ControlClass, "dopusviewerplugin.liv.viewer") ; Viewer gif
			|| InStr(LOC_ControlClass, "_WwG") ; Viewer docx
			|| InStr(LOC_ControlClass, "EVRVideoHandler") ; Viewer video
			|| InStr(LOC_ControlClass, "Internet Explorer_Server") ; Viewer html & xml
			|| InStr(LOC_ControlClass, "EXCEL7") ; Viewer video
			|| InStr(LOC_ControlClass, "childclass") ; Viewer ppt
			|| InStr(LOC_ControlClass, "PDFPreview")) { ; Viewer pdf
			CoordMode, Mouse, Relative
			MouseGetPos, LOC_MouseX, LOC_MouseY
			ControlGetPos, LOC_ControlX, LOC_ControlY, LOC_ControlWidth, , dopus.listerviewpane1
			If (LOC_ControlWidth) {
				LOC_ClickX := LOC_ControlX + LOC_ControlWidth - 10
				, LOC_ClickY := LOC_ControlY + 10
				Click, %LOC_ClickX%, %LOC_ClickY%
				MouseMove, LOC_MouseX, LOC_MouseY
			} Else {
				Click, % SubStr(A_ThisHotkey, 1, 1)
			}
		} Else {
			Click, % SubStr(A_ThisHotkey, 1, 1)
		}
		AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; Firefox & Chrome :
	If (LOC_WindowClass == "MozillaWindowClass"
			&& (LOC_ProcessName == "firefox.exe"
				|| LOC_ProcessName == "palemoon.exe")
		|| LOC_WindowClass == "Chrome_WidgetWin_1") {
		If (InStr(LOC_WindowTitle, "- Ecosia -")) {
			SendInput, %A_Space%^w
		} Else If (SubStr(LOC_ControlClass, 1, 5) == "DSUI:" ; PDF X-Change plug-in
			|| InStr(LOC_WindowTitle, "WeTransfer")) {
			WinActivate, ahk_class Shell_TrayWnd
			WinActivate, ahk_id %LOC_WindowID%
			SendInput, ^{F4}
		} Else {
			WinGetPos, LOC_X, LOC_Y, LOC_Width, LOC_Height
			If (LOC_Width == SCR_VirtualScreenWidth
				&& LOC_Height == SCR_VirtualScreenHeight) { ; Full video screen
				SendInput, {Esc}
			} Else {
				MouseClick, Left, LOC_X + 10, LOC_Y + 2 * LOC_Height // 3
				Sleep, 10
				SendInput, ^w
				MouseMove, LOC_MouseX, LOC_MouseY
			}
		}
		AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; Thunderbird :
	If (LOC_WindowClass == "MozillaWindowClass"
		&& LOC_ProcessName == "thunderbird.exe") {
		If (LOC_WindowTitle == "Agenda - Mozilla Thunderbird") { ; calendar
			Return
		}
		If (RegExMatch(LOC_WindowTitle, "^[0-9]{1,} rappels?$")) { ; Thunderbird meeting recall
			WinClose
			AUD_Beep()
			WinActivate, ahk_id %LOC_ActiveWindowID%
			Return
		}
		If (RegExMatch(LOC_WindowTitle, "^Rédaction")) { ; mail edition to close
			SendInput, ^w
			AUD_Beep()
			WinActivate, ahk_id %LOC_ActiveWindowID%
			Return
		}
		
		SendInput, {Esc}^{F4}
		Sleep, 500
		WinGet, LOC_NewProcessName, ProcessName, A
		WinGetTitle, LOC_NewWindowTitle, A
		If (LOC_NewProcessName == LOC_ProcessName
			&& LOC_NewWindowTitle == LOC_WindowTitle) { ; Still the same panel open ? Then it's not a single mail window => delete mail
			SendInput, {Esc}{Delete}
			AHK_ShowToolTip("Mail deleted")
		}
		AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; PDF Exchange 5.5 :
	Try {
		If (InStr(LOC_WindowTitle, "PDF-XChange Editor")
			&& RegExMatch(LOC_WindowClass, "PXE:\{[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}\}")) {
			If (LOC_ControlClass != "UIX:Window1") {
				SendInput, {Ctrl Up}{Esc 2}^w
				TRY_ShowTrayTip("PDF closed")
			} Else {
				SendInput, {Ctrl Up}{Esc 2}!{F4}
				TRY_ShowTrayTip("PDF application closed")
			}
			AUD_Beep()
			Sleep, 50
			WinActivate, ahk_id %LOC_ActiveWindowID%
			Return
		}
	} Catch LOC_Exception {
		AHK_Catch(LOC_Exception, "WIN_MiddleButton")
	}
	
	; PDF Exchange 5.0 & UltraEdit :
	Try {
		If (LOC_WindowClass == "DSUI:PDFXCViewer" ; PDF X-Change 5.0
			|| RegExMatch(LOC_WindowClass, "PXE:{[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}}") && InStr(LOC_WindowTitle, "PDF-XChange Editor")
			|| RegExMatch(LOC_WindowClass, "S)^Afx:[0-9]{16}:8:[0-9]{16}:0000000000000000:[A-F0-9]{16}$")) { ; UltraEdit
			If (LOC_ControlClass == "MDIClient1") {
				SendInput, {Ctrl Up}{Esc 2}!{F4}
			} Else {
				SendInput, {Ctrl Up}{Esc 2}^{F4}
			}
			AUD_Beep()
			WinActivate, ahk_id %LOC_ActiveWindowID%
			Return
		}
	} Catch LOC_Exception {
		AHK_Catch(LOC_Exception, "WIN_MiddleButton")
	}

	; UltraEdit :
	If (WinActive("UltraEdit ahk_class #32770", "Enregistrer les modifications apportées à...")
		|| WinActive("recharger le fichier ahk_class #32770")) {
 		SendInput, !n
		AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; WinMerge :
	If (LOC_WindowClass == "WinMergeWindowClassW") {
		ControlGet, LOC_Edit1ID, Hwnd, , Edit1
		If (LOC_Edit1ID) {
			SendInput, ^{F4}
		} Else {
			WinClose
		}
		AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; Araxis Merge :
	If (InStr(LOC_WindowTitle, "Araxis Merge")) {
		If (LOC_WindowTitle == "Araxis Merge") {
			SendInput, !{F4}
		} Else {
			SendInput, ^{F4}
		}
		AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}
	
	; Many Faces of Go :
	If (SubStr(LOC_WindowTitle, 1, 20) == "The Many Faces of Go" 
		&& RegExMatch(LOC_WindowClass, "S)^Afx:00400000:8:00010003:00000000:[A-F0-9]{8}$")) {
		If (SubStr(LOC_WindowTitle, 21, 4) == " - [") {
			SendInput, ^{F4}
		} Else {
			WinClose
		}
		AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}
	
	; Nox :
	If (LOC_WindowTitle == "Nox App Player" 
		&& LOC_WindowClass == "Qt5QWindowIcon") {
		SetTimer, APP_AndroidActivityTimer, Off
		Loop, 5 { ; GUI_AndroidActivity*
			LOC_GuiID := 51 + A_Index
			Gui, %LOC_GuiID%:Destroy
		}
		SendInput, !{F4}
		WinWait, Dialog ahk_class Qt5QWindowIcon, , 3
		If (!ErrorLevel) {
			WinActivate
			SendInput, {Enter}
		}
		AHK_HideToolTip()
		, AUD_Beep()
		, AHK_ResetCursor()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; MPC :
	If (LOC_WindowClass == "MediaPlayerClassicW") {
		WinGetPos, , , LOC_Width, LOC_Height, A
		If (LOC_Width == SCR_VirtualScreenWidth
			&& LOC_Height == SCR_VirtualScreenHeight) {
			SendInput, {Esc}
		} Else {
			SendInput, !x
		}
		AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}
	
	; VLC :
	If (WinActive("Lecteur multimédia VLC ahk_class QWidget")) {
		WinGetPos, LOC_X, LOC_Y, LOC_Width, LOC_Height
		If (LOC_X == SCR_VirtualScreenX
			&& LOC_Y == SCR_VirtualScreenY
			&& LOC_Width == SCR_VirtualScreenWidth
			&& LOC_Height == SCR_VirtualScreenHeight) {
			SendInput, {Esc}
		} Else {
			SendInput, !{F4}
		}
		AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; Registry Manager :
	If (LOC_WindowClass == "TEditDockForm"
		&& LOC_WindowTitle == "Registry and Tool Windows") {
		WinGet, LOC_WindowPID, PID
		WinKill
		Process, Close, %LOC_WindowPID%
		AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; Video Converter :
	If (SubStr(LOC_WindowClass, 1, 28) == "HwndWrapper[FreemakeVC.exe;;") {
		If (LOC_WindowTitle != "Freemake Video Converter"
			&& SubStr(LOC_WindowTitle, -9) != "% terminés") {
			WinKill
			AUD_Beep()
			WinActivate, ahk_id %LOC_ActiveWindowID%
			Return
		}
	}
	
	; Window Spy :
	If (LOC_WindowClass == "AutoHotkeyGUI"
		&& LOC_WindowTitle == "WindowSpy — by BeLO.") {
		SetTimer, ADM_WindowSpyRefreshTimer, Off
		Gui, 31:Hide ; GUI_WindowSpyHoveredColor
		Gui, 30:Hide ; Window Spy
		AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; AHK Calendar :
	If (LOC_WindowClass == "AutoHotkeyGUI"
		&& LOC_WindowTitle == "GUI_Calendar") {
		SYS_TaskbarCalendarPeriodicTimer(PRM_Hide := true)
		, AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}
	
	; Ruler :
	If (LOC_WindowClass == "AutoHotkeyGUI"
		&& LOC_WindowTitle == "GUI_HorizontalRuler") {
		Gui, 8:Destroy
		AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}
	If (LOC_WindowClass == "AutoHotkeyGUI"
		&& LOC_WindowTitle == "GUI_VerticalRuler") {
		Gui, 9:Destroy
		AUD_Beep()
		WinActivate, ahk_id %LOC_ActiveWindowID%
		Return
	}

	; No defined action :
	Click, % SubStr(A_ThisHotkey, 1, 1)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Close window { [ Ctrl + ] [ Alt + ] Win + F4 } or { Win + Esc } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#Esc::
WIN_EscKill()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_EscKill() {

	Global 	AHK_AudioEnabled
	WinActive("A")
	WinGet, LOC_ActiveWindowID, ID
	If (LOC_ActiveWindowID) {
		WinGetClass, LOC_WindowClass
		If (AHK_SystemWindowClass(LOC_WindowClass)) {
			SendInput, {LWin Down}{Esc}{LWin Up}
		} Else {
			LOC_WindowTitle := WIN_GetWindowTitle(LOC_ActiveWindowID)
			If (LOC_WindowClass == "MozillaWindowClass"
				|| LOC_WindowClass == "IEFrame"
				|| LOC_WindowClass == "Photoshop"
				|| LOC_WindowClass == "dopus.lister") {
				SendInput, ^{F4}
			} Else {
				WinClose
				AUD_Beep()
				TRY_ShowTrayTip(LOC_WindowTitle . " closed")
			}
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TrayMenuKill:
WIN_FocusLastWindow()
#F4::
^#F4::
!#F4::
^!#F4::
Suspend, Permit
WIN_F4Kill()
Return

WIN_F4Kill() {

	Global AHK_AudioEnabled
	WinGet, LOC_KillWindowID, ID, A
	WinGetClass, LOC_WindowClass, ahk_id %LOC_KillWindowID%
	If (AHK_SystemWindowClass(LOC_WindowClass)) {
		PRM_PowerManager(PRM_Submit := false, PRM_State := 3, , PRM_YesDefaultButton := false)
		Return
	}
	WinGet, LOC_KillWindowPID, PID, ahk_id %LOC_KillWindowID%
	LOC_WindowTitle := WIN_GetWindowTitle(LOC_KillWindowID)
	WinKill, ahk_id %LOC_KillWindowID%
	Process, Close, %LOC_KillWindowPID%
	SendMessage, 0x02
	If (LOC_WindowClass == "Rayman Legends") {
		WinKill, Uplay ahk_class PlatformView
	}
	AUD_Beep()
	TRY_ShowTrayTip(LOC_WindowTitle . " killed", 2)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_MiddleButtonCombinations:
#MButton::
^#MButton::
#!MButton::
^#!MButton::
WIN_MiddleButtonCombinations()
Return

WIN_MiddleButtonCombinations() {

	Global AHK_AudioEnabled
	MouseGetPos, , , LOC_KillWindowID
	If (LOC_KillWindowID) {
		WinGetClass, LOC_WindowClass, ahk_id %LOC_KillWindowID%
		If (AHK_SystemWindowClass(LOC_WindowClass)) {
			PRM_PowerManager(PRM_Submit := false, PRM_State := 3, , PRM_YesDefaultButton := false)
		} Else {
			WinGet, LOC_KillWindowPID, PID, ahk_id %LOC_KillWindowID%
			LOC_WindowTitle := WIN_GetWindowTitle(LOC_KillWindowID)
			WinKill, ahk_id %LOC_KillWindowID%
			Process, Close, %LOC_KillWindowPID%
			SendMessage, 0x02,
			AUD_Beep()
			, TRY_ShowTrayTip(LOC_WindowTitle . " killed", 2)
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TrayMenuClose:
WIN_FocusLastWindow()
!F4::
WIN_Close()
Return

WIN_Close() {

	Global AHK_AudioEnabled
	IfInString, A_ThisHotkey, % "MButton"
	{
		MouseGetPos, , , LOC_CloseWindowID
	} Else
	IfInString, A_ThisHotkey, % "XButton"
	{
		MouseGetPos, , , LOC_CloseWindowID
	} Else {
		WinGet, LOC_CloseWindowID, ID, A
	}

	If (LOC_CloseWindowID) {
		WinGetClass, LOC_WindowClass, ahk_id %LOC_CloseWindowID%
		If (AHK_SystemWindowClass(LOC_WindowClass)) {
			PRM_PowerManager(PRM_Submit := false, PRM_State := 1, PRM_ForcedActionEnabled := true, PRM_YesDefaultButton := false)
			Return
		}
		LOC_WindowTitle := WIN_GetWindowTitle(LOC_KillWindowID)
		If ((LOC_WindowTitle == "Visionneuse de photos Picasa" && LOC_WindowClass == "ytWindow")
			|| LOC_WindowClass == "WMPTransition"
			|| LOC_WindowClass == "ShockwaveFlashFullScreen") {
			ControlSend, , {Ctrl Up}{Esc}, ahk_id %LOC_CloseWindowID%
		} Else {
			WinClose, ahk_id %LOC_CloseWindowID%
		}
		SendMessage, 0x02,
		AUD_Beep()
		, TRY_ShowTrayTip(LOC_WindowTitle . " closed")
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TrayMenuCloseInside:
WIN_FocusLastWindow()
^F4 Up::
WIN_CloseInside()
Return

WIN_CloseInside() {
	WinGet, LOC_CloseWindowID, ID, A
	If (LOC_CloseWindowID) {
		WinGetClass, LOC_WindowClass, ahk_id %LOC_CloseWindowID%
		If (AHK_SystemWindowClass(LOC_WindowClass)) {
			Return
		}
		WinActivate, ahk_id %LOC_CloseWindowID%
		WinWaitActive, ahk_id %LOC_CloseWindowID%, , 0
		WinShow
		ControlSend, ahk_parent, ^{F4}
		AUD_Beep()
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; No dialog in taskbar :
;;;;;;;;;;;;;;;;;;;;;;;;

WIN_InitGroups() {

	Global AHK_ScriptInfo
	GroupAdd, WIN_NoDialogWindows, ahk_class WorkerW ; Desktop
	GroupAdd, WIN_NoDialogWindows, ahk_class ClassicShell.CMenuContainer ; Start button
	GroupAdd, WIN_NoDialogWindows, ahk_class ClassicShell.CStartButton ; Start button
	GroupAdd, WIN_NoDialogWindows, Démarrer ahk_class Button ; Start button
	GroupAdd, WIN_NoDialogWindows, ahk_class SystemTray_Main ; System tray
	GroupAdd, WIN_NoDialogWindows, Connections Tray ahk_class Connections Tray ; Connection tray
	GroupAdd, WIN_NoDialogWindows, ahk_class Tray Volume ; Volume tray
	GroupAdd, WIN_NoDialogWindows, ahk_class tooltips_class32 ; Tooltips
	GroupAdd, WIN_NoDialogWindows, ahk_class Add/Remove Stub Window ; Add/Remove programs
	GroupAdd, WIN_NoDialogWindows, ahk_class MstscRemoteSessionsMgrWndClass ; Remote Desktop connection
	GroupAdd, WIN_NoDialogWindows, ahk_class Sticky_Notes_Top_Window ; Windows 7 Sticky Notes
	GroupAdd, WIN_NoDialogWindows, ahk_class Sticky_Notes_Note_Window ; Windows 7 Sticky Notes
	GroupAdd, WIN_NoDialogWindows, ahk_class Sticky_Notes_Note_Adornment ; Windows 7 Sticky Notes
	GroupAdd, WIN_NoDialogWindows, taskbarshuffle ahk_class TApplication ; Taskbar shuffle
	GroupAdd, WIN_NoDialogWindows, VistaSwitcher ahk_class VistaSwitcher_SwitcherWnd ; Task switcher
	GroupAdd, WIN_NoDialogWindows, VistaSwitcher ahk_class VistaSwitcher_MainWnd ; Task switcher
	GroupAdd, WIN_NoDialogWindows, ahk_class VistaSwitcher_PreviewWnd ; Task switcher
	GroupAdd, WIN_NoDialogWindows, Changement de tâche ahk_class TaskSwitcherWnd ; Task switcher
	GroupAdd, WIN_NoDialogWindows, ahk_class Internet Explorer_Hidden ; IE
	GroupAdd, WIN_NoDialogWindows, ahk_class SideBar_HTMLHostWindow ; Sidebar widgets
	GroupAdd, WIN_NoDialogWindows, ahk_class WMPTransition ; WMP full screen
	
	GroupAdd, WIN_NoDialogWindows, ahk_class DFTaskbar:10c9aa42-8900-4ca4-8878-302581413079 ; DisplayFusion
	GroupAdd, WIN_NoDialogWindows, ahk_class NeilShadow
	GroupAdd, WIN_NoDialogWindows, ahk_class SysShadow
	GroupAdd, WIN_NoDialogWindows, ahk_class MsoCommandBarShadow
	GroupAdd, WIN_NoDialogWindows, Fin du programme - ahk_class #32770
	GroupAdd, WIN_NoDialogWindows, ahk_class TPUtilWindow
	GroupAdd, WIN_NoDialogWindows, ahk_class GDI+ Hook Window Class
	GroupAdd, WIN_NoDialogWindows, ahk_class IME
	GroupAdd, WIN_NoDialogWindows, ahk_class DV2ControlHost
	GroupAdd, WIN_NoDialogWindows, ahk_class MSCTFIME UI
	GroupAdd, WIN_NoDialogWindows, ahk_class OleDdeWndClass
	GroupAdd, WIN_NoDialogWindows, ahk_class SysPager
	GroupAdd, WIN_NoDialogWindows, ahk_class SysFader
	GroupAdd, WIN_NoDialogWindows, ahk_class TurboDLL.TreeListTipCtrl
	GroupAdd, WIN_NoDialogWindows, ahk_class VBFloatingPalette
	GroupAdd, WIN_NoDialogWindows, MS_WebcheckMonitor ahk_class MS_WebcheckMonitor

	GroupAdd, WIN_NoDialogWindows, PopupSyncId ahk_class Edit ; Comodo
	GroupAdd, WIN_NoDialogWindows, Skype ahk_class tSkMainForm
	GroupAdd, WIN_NoDialogWindows, ahk_class SkyLibPwrEvents
	; GroupAdd, WIN_NoDialogWindows, TClock ahk_class TClockMainClass ; TClock
	; GroupAdd, WIN_NoDialogWindows, ahk_class OutlookAcctMgrNotificationWindow ; Outlook
	; GroupAdd, WIN_NoDialogWindows, ahk_class OutlookFbThreadWnd ; Outlook
	; GroupAdd, WIN_NoDialogWindows, ahk_class Outlook Notification Area Icon Window ; Outlook
	; GroupAdd, WIN_NoDialogWindows, ahk_class McAfeeFramework_NotifyIcon ; McAfee
	GroupAdd, WIN_NoDialogWindows, ahk_class rctrl_renwnd32
	; GroupAdd, WIN_NoDialogWindows, ahk_class Pageant ; PuTTY pageant
	GroupAdd, WIN_NoDialogWindows, PopupMessageWindow ahk_class SunAwtFrame
	GroupAdd, WIN_NoDialogWindows, TrueTransparency ahk_class TrueTransparency
	GroupAdd, WIN_NoDialogWindows, ahk_class TFMainWindow
	; GroupAdd, WIN_NoDialogWindows, Die or live ahk_class TGoGameDieAndLiveForm ; Die or live
	GroupAdd, WIN_NoDialogWindows, ahk_class TTeComboWindow
	GroupAdd, WIN_NoDialogWindows, ahk_class MozillaDialogClass ; Mozilla
	GroupAdd, WIN_NoDialogWindows, ahk_class MozillaDropShadowWindowClass ; Mozilla
	GroupAdd, WIN_NoDialogWindows, ahk_class MozillaHiddenWindowClass ; Mozilla
	GroupAdd, WIN_NoDialogWindows, ahk_class Pale MoonMessageWindow ; Palemoon message
	GroupAdd, WIN_NoDialogWindows, ahk_class ThunderbirdMessageWindow ; Thunderbird message
	GroupAdd, WIN_NoDialogWindows, Weather Watcher Live ahk_class ThunderRT6Main ; Weather watcher
	GroupAdd, WIN_NoDialogWindows, Form1 ahk_class ThunderRT6FormDC ; Weather watcher
	GroupAdd, WIN_NoDialogWindows, IzArc ahk_class TApplication ; IzArc
	GroupAdd, WIN_NoDialogWindows, ahk_class ToolbarWindow32
	GroupAdd, WIN_NoDialogWindows, Boîte à outils Contrôles ahk_class MsoCommandBar ; Word
	GroupAdd, WIN_NoDialogWindows, ahk_class WindowsForms10.Window.8.app.0.11ecf05 ; Startup Delayer
	GroupAdd, WIN_NoDialogWindows, TimeCamp ahk_class wxWindowNR ; TimeCamp
	; GroupAdd, WIN_NoDialogWindows, Take it Easy ahk_class #32770 ; MediaMonkey plugin
	GroupAdd, WIN_NoDialogWindows, Directory Opus ahk_class DOpus.ParentWindow ; Directory Opus
	GroupAdd, WIN_NoDialogWindows, Registry Monitor ahk_class TMonitorForm
	GroupAdd, WIN_NoDialogWindows, ahk_class PSFloatC ; PhotoShop
	GroupAdd, WIN_NoDialogWindows, ahk_class PSViewC ; PhotoShop
	; GroupAdd, WIN_NoDialogWindows, Ouverture du documentveuillez patienter... ahk_class #32770 ; PDF-XChange
	; GroupAdd, WIN_NoDialogWindows, OpenVPN ahk_class OpenVPN-GUI ; OpenVPN
	GroupAdd, WIN_NoDialogWindows, ahk_class ExtPlayerCanvas ; Quintessential playlist
	GroupAdd, WIN_NoDialogWindows, Nox ahk_class Qt5QWindowToolSaveBits

	GroupAdd, WIN_NoDialogWindows, GUI_Memo ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_SplashScreen ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_FadeOutBackground ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_BSOD ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_Calendar ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_HorizontalRuler ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_VerticalRuler ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, Lock Keyboard ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, Unlock Keyboard ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_LockKeyboardBackground ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_ScreenshotStartXAxis ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_ScreenshotStartYAxis ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_ScreenshotRectangle ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_ScreenshotCountdown ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_ScreenshotFlash ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_Magnifier ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_MailAddresses ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_MouseLockStartXAxis ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_MouseLockStartYAxis ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_MouseLockEndXAxis ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_MouseLockEndYAxis ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_MouseLockStartPoint ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_MouseLockEndPoint ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_MouseRings ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_VolumeBar ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_WindowSpyHoveredColor ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_WindowSpyHoveredControlTop ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_WindowSpyHoveredControlBottom ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_WindowSpyHoveredControlLeft ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_WindowSpyHoveredControlRight ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_WindowSpyHoveredWindowTop ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_WindowSpyHoveredWindowBottom ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_WindowSpyHoveredWindowLeft ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_WindowSpyHoveredWindowRight ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_ColoredTaskbar ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_DisplayFusionColoredTaskbar ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_Clock ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_LeftTopToolTip ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_WidthHeightToolTip ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_RightBottomToolTip ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_ToolTip ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, GUI_BufferedToolTip ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, %A_ScriptFullPath% - AutoHotkey v ahk_class AutoHotkey, , , , -
	GroupAdd, WIN_NoDialogWindows, %AHK_ScriptInfo% ahk_class AutoHotkeyGUI
	GroupAdd, WIN_NoDialogWindows, AutoIt v3 ahk_class AutoIt v3

	GroupAdd, WIN_SuspendingWindowsGroup, ahk_class TSSHELLWND ; Terminal Server
	GroupAdd, WIN_SuspendingWindowsGroup, ahk_class RaymanOrigins ; Rayman Origins
	GroupAdd, WIN_SuspendingWindowsGroup, Rayman Legends ahk_class Rayman Legends ; Rayman Legends
	GroupAdd, WIN_SuspendingWindowsGroup, Mount&Blade Warband ahk_class ahk_class MB Window ; Mount & Blade Warband
	GroupAdd, WIN_SuspendingWindowsGroup, Connexion Bureau à distance ahk_class #32770
	GroupAdd, WIN_SuspendingWindowsGroup, Ski Racing 2006 ahk_class CCK ROCKS! ; Ski Racing
	GroupAdd, WIN_SuspendingWindowsGroup, F1 2010 ahk_class NeonClass_41 ; F1 2010
	GroupAdd, WIN_SuspendingWindowsGroup, ahk_class FIFA 2005Class ; FIFA 2005
	GroupAdd, WIN_SuspendingWindowsGroup, Cars 2 ahk_class Octane2 Renderer Window ; Cars 2
	GroupAdd, WIN_SuspendingWindowsGroup, FlatOut Ultimate Carnage ahk_class BDX9 Render Window ; Flat Out
	GroupAdd, WIN_SuspendingWindowsGroup, ahk_class launcher_LoTRBFMe2 ; Battle for the Middle Earth
	GroupAdd, WIN_SuspendingWindowsGroup, ahk_class CryENGINE ; Crysis
	GroupAdd, WIN_SuspendingWindowsGroup, Wolfenstein ahk_class Wolfenstein ; Return to Castle Wolfenstein
	GroupAdd, WIN_SuspendingWindowsGroup, ahk_class Medal of Honor Pacific Assault(tm) ; Pacific Assault
	GroupAdd, WIN_SuspendingWindowsGroup, Divinity2 ahk_class Gamebryo Application ; Divinity II
	GroupAdd, WIN_SuspendingWindowsGroup, ahk_class MAME ; MAME Simulator
	GroupAdd, WIN_SuspendingWindowsGroup, Microsoft Virtual PC 2007 ; Virtual PC
	GroupAdd, WIN_SuspendingWindowsGroup, FUEL ahk_class SDK ; FUEL
	GroupAdd, WIN_SuspendingWindowsGroup, FIFA 10 ahk_class FIFA 10Class ; FIFA 2010
	GroupAdd, WIN_SuspendingWindowsGroup, Infos BàB - Google Sheets ahk_class MozillaWindowClass
	GroupAdd, WIN_SuspendingWindowsGroup, ahk_class GameUnrealWWindowsViewportWindow ; Harry Potter et la chambre des secrets
	GroupAdd, WIN_SuspendingWindowsGroup, Divinity2 ahk_class Gamebryo Application ; Divinity 2
	GroupAdd, WIN_SuspendingWindowsGroup, Doomsday ahk_class QWidget ; Doom
	GroupAdd, WIN_SuspendingWindowsGroup, ahk_class ZDoomMainWindow ; Doom
	GroupAdd, WIN_SuspendingWindowsGroup, ahk_class DragonAge2 ; Dragon Age 2
	
	GroupAdd, WIN_StartMenuGroup, ahk_class BaseBar ; Start menus
	GroupAdd, WIN_StartMenuGroup, ahk_class ClassicShell.CMenuContainer ; Start menu
	GroupAdd, WIN_MenusGroup, ahk_class #32768 ; menus
	
	GroupAdd, WIN_QuintessentialGroup, ahk_class PlayerCanvas
	GroupAdd, WIN_QuintessentialGroup, ahk_class ExtPlayerCanvas
	GroupAdd, WIN_QuintessentialGroup, Chronotron Plugin ahk_class TModuleForm
	GroupAdd, WIN_QuintessentialGroup, A-B Repeat ahk_class #32770
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Show dialogs in taskbar :
;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_ShowDialogsPeriodicTimer:
WIN_ShowDialogsPeriodicTimer()
Return

WIN_ShowDialogsPeriodicTimer() {

	Global APP_DisplayFusionPath
	Static STA_ActiveWindowID := 0
	
	DetectHiddenWindows, Off
	WinGet, LOC_WindowsIDs, List, , , Program Manager
	Loop, %LOC_WindowsIDs% {
		StringTrimRight, LOC_WindowID, LOC_WindowsIDs%A_Index%, 0
		If (WinActive("ahk_id " . LOC_WindowID)) {
			If (STA_ActiveWindowID == LOC_WindowID) {
				Continue
			}
			STA_ActiveWindowID := LOC_WindowID
		}

		WinExist("ahk_id " . LOC_WindowID)
		WinGetClass, LOC_WindowClass
		WinGetTitle, LOC_WindowTitle

		If (LOC_WindowClass == "SunAwtFrame"
			|| LOC_WindowClass == "Photoshop"
			|| (LOC_WindowClass == "#32770" || LOC_WindowClass == "SWT_Window0"	&& LOC_WindowTitle == "")
			|| SubStr(LOC_WindowClass, 1, 14) == "WindowsForms10" && SubStr(LOC_WindowTitle, 1, 15) == "Startup Delayer") {
			Continue
		}
		
		WinGetPos, LOC_WindowX, LOC_WindowY, LOC_WindowWidth, LOC_WindowHeight
		If (LOC_WindowWidth && LOC_WindowHeight
			&& !AHK_SystemWindowClass(LOC_WindowClass)
			&& LOC_WindowClass != "WMP Skin Host") {
			WinGet, LOC_ExStyle, ExStyle
			LOC_VisibleInTaskBar := LOC_ExStyle & 0x40000

			If (APP_DisplayFusionPath
					&& SubStr(LOC_WindowClass, 1, 2) == "DF" ; DisplayFusion window
				|| WinExist("ahk_id " . LOC_WindowID . " ahk_group WIN_NoDialogWindows")) {
				If (LOC_VisibleInTaskBar) {
					WinSet, ExStyle, -0x40000
					WinHide
					WinShow
					; TRY_ShowTrayTip(2)
				}
				Continue
			}
			If (SubStr(LOC_WindowClass, 1, 11) == "MMInfoPopup") {
				WinSet, ExStyle, +0x00000020 ; user transparent
				Continue
			}

			If (LOC_VisibleInTaskBar) {
				If (LOC_WindowWidth == 0
					|| LOC_WindowHeight == 0) {
					WinSet, ExStyle, -0x40000
					WinHide
					; TRY_ShowTrayTip(LOC_WindowTitle . " window hidden")
				}
			} Else {
				If (LOC_WindowWidth > 0
					&& LOC_WindowHeight > 0
					&& WinActive("ahk_id " . LOC_WindowID)) {
					If (SubStr(LOC_WindowClass, 1, 21) != "WindowsForms10.Window") {
						WinSet, ExStyle, +0x40000 ; WS_EX_APPWINDOW : Forces a top-level window onto the taskbar when the window is visible
						WinHide
						WinShow
						;TRY_ShowTrayTip(6)
					}
				}
			}
		}
	}
	DetectHiddenWindows, On
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Resize open/save dialogs :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_OpenSaveDialogsPeriodicTimer:
WIN_OpenSaveDialogsPeriodicTimer()
Return

WIN_OpenSaveDialogsPeriodicTimer() {

	Static STA_DialogID := 0
	If (!WinExist("ahk_id " . STA_DialogID)) {
		STA_DialogID := 0
	}
	WinGet, LOC_DialogID, ID, A
	If (LOC_DialogID == STA_DialogID) {
		Return
	}
	WinExist("ahk_id " . LOC_DialogID)
	WinGetClass, LOC_DialogClass
	WinGetTitle, LOC_DialogTitle

	; Dialog identification :
	LOC_DialogWindow := LOC_FolderDialogWindow := false
	If (LOC_DialogClass == "#32770") {
		LOC_FileDialogControls := "Button1|Button2|Button3|ComboBox1|ComboBox2|Edit1|ListBox1|Static1|Static2|Static3|Static4|SysListView321|ToolbarWindow321"
		Loop, Parse, LOC_FileDialogControls, |
		{
			Try {
				ControlGet, LOC_ControlID, Hwnd, , %A_LoopField%
			} Catch LOC_Exception {
				; AHK_Catch(LOC_Exception, "WIN_OpenSaveDialogsPeriodicTimer")
				LOC_ControlID := 0
			}
			
			If (!LOC_ControlID) {
				If (A_LoopField == "SysListView321") {
					Try {
						ControlGet, LOC_ControlID, Hwnd, , DirectUIHWND2
					} Catch LOC_Exception {
						; AHK_Catch(LOC_Exception, "WIN_OpenSaveDialogsPeriodicTimer")
						LOC_ControlID := 0
					}
					If (LOC_ControlID) {
						Continue
					}
				}
				LOC_FolderDialogControls := "Button1|Button2|Button3|Edit1|SHBrowseForFolder ShellNameSpace Control1|Static1|Static2|Static3|Static4|SysTreeView321"
				Loop, Parse, LOC_FolderDialogControls, |
				{
					Try {
						ControlGet, LOC_ControlID, Hwnd, , %A_LoopField%
					} Catch LOC_Exception {
						; AHK_Catch(LOC_Exception, "WIN_OpenSaveDialogsPeriodicTimer")
						Return
					}
					If (!LOC_ControlID) {
						Return
					}
				}
				LOC_FolderDialogWindow := true
				Break
			}
		}
		LOC_DialogWindow := true
	}
	LOC_IsOfficeDialog := (InStr(LOC_DialogClass, "bosa_sdm") ; Office dialogs
							&& (WinActive("Enregistrer")
								|| WinActive("Save")
								|| WinActive("Ouvrir")
								|| WinActive("Open")))
	, LOC_DialogWindow |= (LOC_IsOfficeDialog
						|| LOC_DialogClass == "TFSelectScanFolders" ; MediaMonkey
						|| LOC_DialogClass == "TFRenameWithMask"
						|| LOC_DialogClass == "TFAccompFiles"
						|| WinActive("Case Checker ahk_class TFormPlus")
						|| (LOC_DialogTitle == "Emplacement de sauvegarde" ; Directory Opus
							&& LOC_DialogClass == "#32770"))
	WinExist("ahk_id " . LOC_DialogID)

	If (LOC_DialogWindow) {
		SysGet, LOC_Monitor, MonitorWorkArea, 1
		LOC_ScreenX := LOC_MonitorLeft
		, LOC_ScreenY := LOC_MonitorTop
		, LOC_ScreenWidth := LOC_MonitorRight - LOC_MonitorLeft
		, LOC_ScreenHeight := LOC_MonitorBottom - LOC_MonitorTop
		, STA_DialogID := LOC_DialogID
		WinGetPos, LOC_OriginalX, LOC_OriginalY, LOC_OriginalWidth, LOC_OriginalHeight
		SysGet, LOC_MonitorCount, MonitorCount
		If (LOC_MonitorCount > 1) {
			Loop, %LOC_MonitorCount% {
				If (A_Index == 1) {
					Continue
				}
				SysGet, LOC_Monitor, MonitorWorkArea, %A_Index%
				If (LOC_MonitorLeft <= LOC_OriginalX
					&& LOC_OriginalX < LOC_MonitorRight
					&& LOC_MonitorTop <= LOC_OriginalY
					&& LOC_OriginalY < LOC_MonitorBottom) {
					LOC_ScreenX := LOC_MonitorLeft
					, LOC_ScreenY := LOC_MonitorTop
					, LOC_ScreenWidth := LOC_MonitorRight - LOC_MonitorLeft
					, LOC_ScreenHeight := LOC_MonitorBottom - LOC_MonitorTop
					Break
				}
			}
		}
		LOC_FinalWidth := Max(LOC_OriginalWidth, Round(LOC_ScreenWidth / 2))
		, LOC_FinalHeight := Max(LOC_OriginalHeight, Round(LOC_ScreenHeight / 1.7))
		If (LOC_OriginalWidth < LOC_FinalWidth
			|| LOC_OriginalHeight < LOC_FinalHeight) {
			WinMove, , , Min(Max(LOC_ScreenX, LOC_OriginalX - (LOC_FinalWidth - LOC_OriginalWidth) // 2), LOC_ScreenX + LOC_ScreenWidth - LOC_FinalWidth), Min(Max(LOC_ScreenY, LOC_OriginalY - (LOC_FinalHeight - LOC_OriginalHeight) // 2), LOC_ScreenY + LOC_ScreenHeight - LOC_FinalHeight), LOC_FinalWidth, LOC_FinalHeight
			WinHide
			WinShow
		} Else {
			LOC_FinalX := LOC_OriginalX
			, LOC_FinalY := LOC_OriginalY
			If (LOC_OriginalX < ScreenX
				|| LOC_OriginalX + LOC_OriginalWidth > LOC_ScreenX + LOC_ScreenWidth) {
				LOC_FinalX := Min(Max(LOC_ScreenX, LOC_OriginalX), LOC_ScreenX + LOC_ScreenWidth - LOC_OriginalWidth)
			}
			If (LOC_OriginalY < ScreenY
				|| LOC_OriginalY + LOC_OriginalHeight > LOC_ScreenY + LOC_ScreenHeight) {
				LOC_FinalY := Min(Max(LOC_ScreenY, LOC_OriginalY), LOC_ScreenY + LOC_ScreenHeight - LOC_OriginalHeight)
			}
			If (LOC_FinalX != LOC_OriginalX
				|| LOC_FinalY != LOC_OriginalY) {
				WinMove, , , LOC_FinalX, LOC_FinalY
			}
		}

		; Extend file selection :
		If (!LOC_FolderDialogWindow) {
			LOC_FileNameControlName := (LOC_IsOfficeDialog ? "RichEdit20W2" : "Edit1")
			Try {
				ControlGet, LOC_FileNameControlID, Hwnd, , %LOC_FileNameControlName%
			} Catch LOC_Exception {
				; AHK_Catch(LOC_Exception, "WIN_OpenSaveDialogsPeriodicTimer")
				LOC_FileNameControlID := 0
			}
			If (LOC_FileNameControlID) {
				Try {
					ControlGetText, LOC_Text, %LOC_FileNameControlName%
				} Catch LOC_Exception {
					; AHK_Catch(LOC_Exception, "WIN_OpenSaveDialogsPeriodicTimer")
					LOC_Text := ""
				}

				; Display details :
				If (!LOC_IsOfficeDialog) {
					Try {
						ControlGet, LOC_ComboBox1, Hwnd, , ComboBox1
						ControlGet, LOC_ToolbarWindow321, Hwnd, , ToolbarWindow321
						If (LOC_ComboBox1
							&& LOC_ToolbarWindow321) {
							ControlFocus, ComboBox1
							SendInput, {Tab}{Left}{Down}
							WinWait, ahk_class #32768, , 0
							ControlSend, , % (InStr(LOC_DialogTitle, "image") ? "s" : "d"), ahk_class #32768 ; thumnailS or Details
							ControlSetText, %LOC_FileNameControlName%, %LOC_Text%
						}
					} Catch LOC_Exception {
						; AHK_Catch(LOC_Exception, "WIN_OpenSaveDialogsPeriodicTimer")
					}
				}

				; Select name without extension :
				CoordMode, Mouse, Relative
				ControlClick, %LOC_FileNameControlName%, , , , , NA
				ControlFocus, %LOC_FileNameControlName%
				SendInput, {Alt Down}n{Alt Up}
				If (LOC_ExtensionPos := InStr(LOC_Text, ".", true, 0)) {
					SendInput, % "{Home}{Shift Down}{Right " . LOC_ExtensionPos - 1 . "}{Shift Up}"
				}
				If (LOC_IsOfficeDialog) {
					SendInput, {Esc}
				}

				; Mouse on the open/save button :
				LOC_Control := (LOC_Text && !LOC_IsOfficeDialog ? "Button1" : "SysListView321")
				ControlGetPos, LOC_X, LOC_Y, LOC_Width, LOC_Height, %LOC_Control%
				If (LOC_Width) {
					Sleep, 200
					MouseMove, Round(LOC_X + LOC_Width / (LOC_Control == "SysListView321" ? 4 : 2)), Round(LOC_Y + LOC_Height / 2)
				}
			}
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Open/Save dialog folder shortcuts :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#IfWinActive, ahk_class #32770
!a::SendInput, {Ctrl Down}a{Ctrl Up}%A_ScriptDir%{Enter}
!b::SendInput, {Ctrl Down}a{Ctrl Up}%A_Desktop%{Enter}
!c::SendInput, {Ctrl Down}a{Ctrl Up}C:\{Enter}
!d::SendInput, {Ctrl Down}a{Ctrl Up}D:\{Enter}
!g::SendInput, {Ctrl Down}a{Ctrl Up}G:\{Enter}
!i::SendInput, {Ctrl Down}a{Ctrl Up}I:\{Enter}
!k::SendInput, {Ctrl Down}a{Ctrl Up}K:\{Enter}
!m::SendInput, {Ctrl Down}a{Ctrl Up}M:\{Enter}
!o::SendInput, {Ctrl Down}a{Ctrl Up}O:\{Enter}
!p::SendInput, {Ctrl Down}a{Ctrl Up}%ZZZ_ProgramFiles64%{Enter}
!s::SendInput, {Ctrl Down}a{Ctrl Up}%A_WinDir%\system32\{Enter}
!t::SendInput, {Ctrl Down}a{Ctrl Up}O:\Téléchargements\{Enter}
!v::SendInput, {Ctrl Down}a{Ctrl Up}V:\{Enter}
!z::SendInput, {Ctrl Down}a{Ctrl Up}Z:\{Enter}
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Alt-tab menu { RightButton + Wheel } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WheelDown::
WIN_AltTabWheelDown()
Return

WIN_AltTabWheelDown() {
	Global ZZZ_RightButtonJustCameDown, AHK_RightMouseButtonHookEnabled
	GetKeyState, LOC_RightButtonState, RButton, P
	If (LOC_RightButtonState == "D"
		&& !ZZZ_RightButtonJustCameDown
		&& AHK_RightMouseButtonHookEnabled) {
		GetKeyState, LOC_LeftAltState, LAlt
		If (LOC_LeftAltState == "U") {
			WIN_SetClickDraggingOff()
			SendInput, {LAlt down}{Tab}
			SetTimer, WIN_AltTabWheelHandlerTimer, 10
		} Else {
			SendInput, {Tab}
		}
	} Else {
		SYS_WheelDown()
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WheelUp::
WIN_AltTabWheelUp()
Return

WIN_AltTabWheelUp() {
	Global ZZZ_RightButtonJustCameDown, AHK_RightMouseButtonHookEnabled
	GetKeyState, LOC_RightButtonState, RButton, P
	If (LOC_RightButtonState == "D"
		&& !ZZZ_RightButtonJustCameDown
		&& AHK_RightMouseButtonHookEnabled) {
		GetKeyState, LOC_LeftAltState, LAlt
		If (LOC_LeftAltState == "U") {
			WIN_SetClickDraggingOff()
			SendInput, {LAlt Down}+{Tab}
			SetTimer, WIN_AltTabWheelHandlerTimer, 10
		} Else {
			SendInput, +{Tab}
		}
	} Else {
		SYS_WheelUp()
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_AltTabWheelHandlerTimer:
WIN_AltTabWheelHandler()
Return

WIN_AltTabWheelHandler() {
	GetKeyState, LOC_RightButtonState, RButton, P
	If (LOC_RightButtonState == "U") {
		SetTimer, WIN_AltTabWheelHandlerTimer, Off
		GetKeyState, LOC_LeftAltState, LAlt
		If (LOC_LeftAltState == "D") {
			SendInput, {LAlt up}
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Maximize window { Shift + Win + PageUp } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TrayMenuMaximize:
If (WIN_FocusLastWindow()) {
	WIN_Maximize()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

+#PgUp::
WIN_Maximize()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_Maximize() {
	If (!WinActive("ahk_class PuTTY")) {
		AHK_SetCursor("SizeAll")
		WinMaximize, A
		AHK_ResetCursor()
		, AHK_ShowToolTip("Window maximized")
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Grow window { Win + PageUp } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TrayMenuIncrease:
If (WIN_FocusLastWindow()) {
	WIN_Increase()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#PgUp::
WIN_Increase()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_Increase() {
	If (!WinActive("ahk_class PuTTY")) {
		AHK_SetCursor("SizeAll")
		WinGet, LOC_WindowState, MinMax, A
		If (LOC_WindowState = -1) {
			WinRestore, A
		} Else {
			WinMaximize, A
		}
		AHK_ResetCursor()
		, AHK_ShowToolTip("Window increased")

	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Restore window { Win + Enter } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TrayMenuRestore:
If (WIN_FocusLastWindow()) {
	WIN_Restore()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#Numpad0::
#NumpadIns::
WIN_Restore()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_Restore() {
	If (!WinActive("ahk_class PuTTY")) {
		AHK_SetCursor("SizeAll")
		WinRestore, A
		AHK_ResetCursor()
		, AHK_ShowToolTip("Window restored")
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Restore all windows { Shift + Win + M } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_RestoreAll:
+#m::
WIN_RestoreAll()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_RestoreAll() {

	DetectHiddenWindows, Off
	WinGet, LOC_WindowsIDs, List, , , Program Manager
	DetectHiddenWindows, On
	Loop, %LOC_WindowsIDs% {
		StringTrimRight, LOC_WindowID, LOC_WindowsIDs%A_Index%, 0
		WinGet, LOC_State, MinMax, ahk_id %LOC_WindowID%,
		If (LOC_State != -1) {
			Continue
		}
		WinGetClass, LOC_Class, ahk_id %LOC_WindowID%
		If (AHK_SystemWindowClass(LOC_Class)) {
			Continue
		}
		IfWinExist, ahk_id %LOC_WindowID%
		{
			WinRestore
		}
	}
	AHK_ShowToolTip("All windows restored")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Decrease window { Win + PageDown } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TrayMenuDecrease:
If (WIN_FocusLastWindow()) {
	WIN_Decrease()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#PgDn::
WIN_Decrease()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_Decrease() {
	If (!WinActive("ahk_class PuTTY")) {
		AHK_SetCursor("SizeAll")
		WinGet, LOC_WindowState, MinMax, A
		If (LOC_WindowState = 1) {
			WinRestore, A
		} Else {
			WinMinimize, A
		}
		AHK_ResetCursor()
		, AHK_ShowToolTip("Window decreased")
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Minimize window { Win + Shift + PageDown } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TrayMenuMinimize:
If (WIN_FocusLastWindow()) {
	WIN_Minimize()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

+#PgDn::
WIN_Minimize()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_Minimize() {
	If (!WinActive("ahk_class PuTTY")) {
		AHK_SetCursor("SizeAll")
		WinMinimize, A
		AHK_ResetCursor()
		, AHK_ShowToolTip("Window minimized")
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Minimize inactive windows { Win + M } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TrayMenuMinimizeInactive:
WIN_FocusLastWindow()
WIN_MinimizeInactive()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^#m::
WIN_MinimizeInactive()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_MinimizeInactive() {

	WinGet, LOC_ActiveWindowID, ID, A
	DetectHiddenWindows, Off
	WinGet, LOC_WindowsIDs, List, , , Program Manager
	DetectHiddenWindows, On
	LOC_Minimized := false
	Loop, %LOC_WindowsIDs% {
		StringTrimRight, LOC_WindowID, LOC_WindowsIDs%A_Index%, 0
		If (LOC_ActiveWindowID == LOC_WindowID) {
			WinGet, LOC_State, MinMax, ahk_id %LOC_WindowID%
			If (LOC_State == 0) {
				Continue
			}
		}
		WinGet, LOC_ExStyle, ExStyle, ahk_id %LOC_WindowID%
		If (LOC_ExStyle & 0x40000) {
			WinGet, LOC_State, MinMax, ahk_id %LOC_WindowID%,
			If (LOC_State == -1) {
				Continue
			}
			WinGetClass, LOC_Class, ahk_id %LOC_WindowID%
			If (AHK_SystemWindowClass(LOC_Class)) {
				Continue
			}
			IfWinExist, ahk_id %LOC_WindowID%
			{
				WinMinimize
				LOC_Minimized := true
			}
		}
	}

	If (!LOC_Minimized) {
		WinGetClass, LOC_Class, ahk_id %LOC_ActiveWindowID%
		If (!AHK_SystemWindowClass(LOC_Class)
			&& WinExist("ahk_id " . LOC_ActiveWindowID)) {
			WinMinimize, ahk_id %LOC_ActiveWindowID%
		}
	}
	AHK_ShowToolTip("Inactive windows minimized")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Minimize/Roll window { RightButton + LeftButton } or Non-modal windows :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

~LButton::
SetTimer, WIN_RollOrNonModal, -1
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_RollOrNonModal:
WIN_RollOrNonModal()
Return

WIN_RollOrNonModal() {

	Global ZZZ_HexaColorPicked, ZZZ_RGBColorPicked, AHK_RightMouseButtonHookEnabled, ZZZ_RightButtonJustCameDown, ZZZ_DraggingWindowID, AHK_ScriptInfo, AHK_Suspended
	If (A_IsSuspended) {
		Return
	}
	IfWinNotExist, Color Chooser ahk_class #32770
	{
		If (ZZZ_HexaColorPicked == -1
			|| ZZZ_RGBColorPicked == -1) {
			SCR_ColorPicked()
			Return
		}
	}
	IfWinActive, ahk_class AutoHotkeyGUI
	{
		Return
	}

	GetKeyState, LOC_RightButtonState, RButton, P
	If (AHK_RightMouseButtonHookEnabled
		&& LOC_RightButtonState == "D"
		&& !ZZZ_RightButtonJustCameDown
		&& !AHK_SystemWindowClass()
		&& !WinActive("ahk_class PuTTY")) {
		
		IfWinActive, ahk_class Shell_TrayWnd
		{
			GoSub, APP_TaskManager
		} Else {
			LOC_ControlState := GetKeyState("Ctrl", "P")
			WinGet, LOC_WindowStyle, Style, ahk_id %ZZZ_DraggingWindowID%
			SysGet, LOC_CaptionHeight, 4 ; SM_CYCAPTION
			SysGet, LOC_BorderHeight, 7 ; SM_CXDLGFRAME
			MouseGetPos, , LOC_MouseY

			If (LOC_MouseY <= LOC_CaptionHeight + LOC_BorderHeight) {
				; Roll window :
				If (LOC_ControlState
					|| (LOC_WindowStyle & 0x40000)) {
					WIN_SetClickDraggingOff()
					, WIN_RollToggle(ZZZ_DraggingWindowID)
				}
			} Else {
				; Minimize window :
				If (LOC_ControlState
					|| (LOC_WindowStyle & 0xCA0000 == 0xCA0000)) {
					WIN_SetClickDraggingOff()
					, AHK_SetCursor("SizeAll")
					WinMinimize, ahk_id %ZZZ_DraggingWindowID%
					AHK_ShowToolTip("Window Minimized")
					, AHK_ResetCursor()
				}
			}
		}
		Return
	}

	; Win non-modal
	MouseGetPos, , , LOC_HoveredWindowID, LOC_HoveredControlID, 2
	WinGet, LOC_WindowStyle, Style, ahk_id %LOC_HoveredWindowID%
	If (!WinActive("ahk_class MozillaWindowClass")
		&& !WinActive("Saisissez le nom du fichier pour l'enregistrement ahk_class #32770")
		&& !WinActive("ahk_class TFSongProperties")
		&& !WinActive("ahk_class TFSelectScanFolders")
		&& !WinActive("ahk_class TFAccompFiles")
		&& !WinActive("eMule ahk_class #32770")) {
		If (LOC_WindowStyle & 0x8000000) {
			WinSet, Enable, , ahk_id %LOC_HoveredWindowID%
			WinSet, AlwaysOnTop, On
			Thread, Priority, 1
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TrayMenuRollToggle:
WIN_TrayMenuRollToggle()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TrayMenuRollToggle() {
	If (WIN_FocusLastWindow()) {
		WinGet, LOC_RollActiveWindowID, ID, A
		WIN_RollToggle(LOC_RollActiveWindowID)
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_RollToggle(PRM_RollActiveWindowID) {

	Global
	Local LOC_WindowHeight
	WIN_CheckRollWindowIDs()
	SetWinDelay, -1
	IfWinNotExist, ahk_id %PRM_RollActiveWindowID%
	{
		Return
	}
	If (AHK_SystemWindowClass()) {
		Return
	}

	IfNotInString, ZZZ_RolledWindowIDs, % "|" . PRM_RollActiveWindowID
	{
		AHK_ShowToolTip("Window Roll: Up")
		, WIN_RollUp(PRM_RollActiveWindowID)
	} Else {
		WinGetPos, , , , LOC_WindowHeight, ahk_id %PRM_RollActiveWindowID%
		If (LOC_WindowHeight == WIN_RolledWindowRolledHeight%PRM_RollActiveWindowID%)  {
			WIN_RollDown(PRM_RollActiveWindowID)
			, AHK_ShowToolTip("Window Roll: Down")
		} Else {
			WIN_RollUp(PRM_RollActiveWindowID)
			, AHK_ShowToolTip("Window Roll: Up")
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_RollUp(PRM_RollActiveWindowID = "") {
	Global
	Local LOC_WindowClass, LOC_WindowHeight, LOC_CaptionHeight, LOC_BorderHeight
	WIN_CheckRollWindowIDs()
	SetWinDelay, -1
	IfWinNotExist, ahk_id %PRM_RollActiveWindowID%
	{
		Return
	}
	WinGetClass, LOC_WindowClass, ahk_id %PRM_RollActiveWindowID%
	If (AHK_SystemWindowClass(LOC_WindowClass)) {
		Return
	}

	WinGetPos, , , , LOC_WindowHeight, ahk_id %PRM_RollActiveWindowID%
	IfInString, ZZZ_RolledWindowIDs, % "|" . PRM_RollActiveWindowID
	{
		If (LOC_WindowHeight == WIN_RolledWindowRolledHeight%PRM_RollActiveWindowID%) {
			Return
		}
	}
	SysGet, LOC_CaptionHeight, 4 ; SM_CYCAPTION
	SysGet, LOC_BorderHeight, 7 ; SM_CXDLGFRAME
	If (LOC_WindowHeight > (LOC_CaptionHeight + LOC_BorderHeight)) {
		AHK_SetCursor("SizeNS")
		IfNotInString, ZZZ_RolledWindowIDs, % "|" . PRM_RollActiveWindowID
		{
			ZZZ_RolledWindowIDs := ZZZ_RolledWindowIDs . "|" . PRM_RollActiveWindowID
		}
		WIN_RolledWindowOriginalHeight%PRM_RollActiveWindowID% := LOC_WindowHeight
		WinMove, ahk_id %PRM_RollActiveWindowID%, , , , , (LOC_CaptionHeight + LOC_BorderHeight)
		WinGetPos, , , , WIN_RolledWindowRolledHeight%PRM_RollActiveWindowID%, ahk_id %PRM_RollActiveWindowID%
		AHK_ResetCursor()
		, AHK_ShowToolTip("Window rolled up")
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_RollDown(PRM_RollActiveWindowID = "") {
	Global
	Local LOC_WindowHeight
	WIN_CheckRollWindowIDs()
	SetWinDelay, -1
	If (!PRM_RollActiveWindowID)
		Return
	IfNotInString, ZZZ_RolledWindowIDs, % "|" . PRM_RollActiveWindowID
		Return
	WinGetPos, , , , LOC_WindowHeight, ahk_id %PRM_RollActiveWindowID%
	If (LOC_WindowHeight == WIN_RolledWindowRolledHeight%PRM_RollActiveWindowID%) {
		AHK_SetCursor("SizeNS")
		WinMove, ahk_id %PRM_RollActiveWindowID%, , , , , WIN_RolledWindowOriginalHeight%PRM_RollActiveWindowID%
		AHK_ResetCursor()
		, AHK_ShowToolTip("Window rolled down")
	}
	StringReplace, ZZZ_RolledWindowIDs, ZZZ_RolledWindowIDs, |%PRM_RollActiveWindowID%, , All
	WIN_RolledWindowOriginalHeight%PRM_RollActiveWindowID% := WIN_RolledWindowRolledHeight%PRM_RollActiveWindowID% := ""
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_RollDownAll() {
	Global ZZZ_RolledWindowIDs
	WIN_CheckRollWindowIDs()
	Loop, Parse, ZZZ_RolledWindowIDs, |
	{
		If (A_LoopField) {
			WIN_RollDown(PRM_RollActiveWindowID := A_LoopField)
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; #^r::
; WIN_RollDownAll()
; AHK_ShowToolTip("Window Roll: ALL DOWN")
; Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_CheckRollWindowIDs() {
	Global
	DetectHiddenWindows, On
	Loop, Parse, ZZZ_RolledWindowIDs, |
	{
		If (A_LoopField) {
			IfWinNotExist, ahk_id %A_LoopField%
			{
				StringReplace, ZZZ_RolledWindowIDs, ZZZ_RolledWindowIDs, |%A_LoopField%, , All
				WIN_RolledWindowOriginalHeight%A_LoopField% := WIN_RolledWindowRolledHeight%A_LoopField% := ""
			}
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Minimize To Tray { Win + End | MiddleClick on Minimize }
; Close                        { MiddleClick on TitleBar }
; Kill                         { MiddleClick on Close    }
; Maximize to the other screen { MiddleClick + Max       } | { Alt + LeftClick + Max } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

<!LButton::
If (!WIN_MaybeMaximizeOnNextScreen()) {
	SendInput, !{Click}
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_MaybeMaximizeOnNextScreen() {
	LOC_GetTitleBarClickZone := WIN_GetTitleBarClickZone()
	If (LOC_GetTitleBarClickZone == "M") {
		WIN_MaximizeOnNextScreen()
		Return, true
	}
	Return, false
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

<+LButton::
If (!WIN_MaybeMaximizeOnAllScreens()) {
	SendInput, +{Click}
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_MaybeMaximizeOnAllScreens() {
	LOC_GetTitleBarClickZone := WIN_GetTitleBarClickZone()
	If (LOC_GetTitleBarClickZone == "M") {
		WIN_MaximizeOnAllScreens()
		Return, true
	}
	Return, false
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TrayMenuMaximizeOnAllScreens:
If (WIN_FocusLastWindow()) {
	WIN_MaximizeOnAllScreens()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_MaximizeOnAllScreens() {
	Global SCR_VisibleScreenX, SCR_VisibleScreenY, SCR_VisibleScreenWidth, SCR_VisibleScreenHeight
	WinGet, LOC_ActiveWindowID, ID, A
	If (LOC_ActiveWindowID) {
		WinGetPos, , , LOC_WindowWidth, LOC_WindowHeight, ahk_id %LOC_ActiveWindowID%
		WinMove, ahk_id %LOC_ActiveWindowID%, , SCR_VisibleScreenX, SCR_VisibleScreenY, SCR_VisibleScreenWidth, SCR_VisibleScreenHeight
		AHK_ShowToolTip("Window maximized on all screens")
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TrayMenuMaximizeVertically:
If (WIN_FocusLastWindow()) {
	WIN_MaximizeVertically()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_MaximizeVertically() {
	Global SCR_VirtualScreenY, SCR_VirtualScreenHeight
	WinGetPos, LOC_X, LOC_Y, LOC_Width, LOC_Height, A

	SysGet, LOC_MonitorCount, MonitorCount
	LOC_ActiveCenterMonitor := LOC_ActiveUpperLeftMonitor := 0
	Loop, % LOC_MonitorCount {
		SysGet, LOC_Monitor, Monitor, %A_Index%
		If (LOC_ActiveCenterMonitor == 0
			&& LOC_MonitorLeft <= (LOC_X + LOC_Width) / 2
			&& (LOC_X + LOC_Width) / 2 <= LOC_MonitorRight
			&& LOC_MonitorTop <= (LOC_Y + LOC_Height) / 2
			&& (LOC_Y + LOC_Height) / 2 <= LOC_MonitorBottom) {
			LOC_ActiveCenterMonitor := A_Index
		} Else If (LOC_ActiveUpperLeftMonitor == 0
			&& LOC_MonitorLeft <= LOC_X
			&& LOC_X <= LOC_MonitorRight
			&& LOC_MonitorTop <= LOC_Y
			&& LOC_Y <= LOC_MonitorBottom) {
			LOC_ActiveUpperLeftMonitor := A_Index
		}
	}

	If (LOC_ActiveCenterMonitor == 0) {
		LOC_ActiveCenterMonitor := Max(LOC_ActiveUpperLeftMonitor, 1)
	}

	SysGet, LOC_Monitor, MonitorWorkArea, % LOC_ActiveCenterMonitor
	WinMove, A, , LOC_X, LOC_MonitorTop, LOC_Width, LOC_MonitorBottom - LOC_MonitorTop
	AHK_ShowToolTip("Window vertically maximized")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TrayMenuMaximizeHorizontally:
If (WIN_FocusLastWindow()) {
	WIN_MaximizeHorizontally()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_MaximizeHorizontally() {
	Global SCR_VirtualScreenX, SCR_VirtualScreenWidth
	WinGetPos, LOC_X, LOC_Y, LOC_Width, LOC_Height, A
	WinMove, A, , SCR_VirtualScreenX, LOC_Y, SCR_VirtualScreenWidth, LOC_Height
	AHK_ShowToolTip("Window horizontally maximized")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TrayMenuMaximizeOnNextScreen:
If (WIN_FocusLastWindow()) {
	WIN_MaximizeOnNextScreen()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_MaximizeOnNextScreen() {

	Global SCR_VirtualScreenWidth, SCR_VirtualScreenHeight
	WinGet, LOC_ActiveWindowID, ID, A
	If (LOC_ActiveWindowID) {
		SysGet, LOC_MonitorCount, MonitorCount
		If (LOC_MonitorCount > 1) {
			WinGetPos, LOC_X, LOC_Y, LOC_WindowWidth, LOC_WindowHeight, ahk_id %LOC_ActiveWindowID%
			LOC_NextMonitor := 0
			, LOC_X := LOC_X + (LOC_WindowWidth // 2), LOC_Y := LOC_Y + (LOC_WindowHeight // 2)
			, LOC_MinDelta := SCR_VirtualScreenWidth * SCR_VirtualScreenWidth + SCR_VirtualScreenHeight * SCR_VirtualScreenHeight
			, LOC_ActiveMonitor := 1
			Loop, %LOC_MonitorCount% {
				SysGet, LOC_MonitorBound, Monitor, %A_Index%
				If (LOC_X < LOC_MonitorBoundLeft) {
					LOC_DeltaX := LOC_MonitorBoundLeft - LOC_X
				} Else If (LOC_X > LOC_MonitorBoundRight) {
					LOC_DeltaX := LOC_X - LOC_MonitorBoundRight
				} Else {
					LOC_DeltaX := 0
				}
				If (LOC_Y < LOC_MonitorBoundTop) {
					LOC_DeltaY := LOC_MonitorBoundTop - LOC_Y
				} Else If (LOC_Y > LOC_MonitorBoundBottom) {
					LOC_DeltaY := LOC_Y - LOC_MonitorBoundBottom
				} Else {
					LOC_DeltaY := 0
				}
				LOC_Delta := LOC_DeltaX * LOC_DeltaX + LOC_DeltaY * LOC_DeltaY
				If (LOC_Delta < LOC_MinDelta) {
					LOC_MinDelta := LOC_Delta
					, LOC_ActiveMonitor := A_Index
				}
			}
			If (LOC_ActiveMonitor < LOC_MonitorCount) {
				LOC_ActiveMonitor++
			} Else {
				LOC_ActiveMonitor := 1
			}
			SysGet, LOC_MonitorBound, MonitorWorkArea, %LOC_ActiveMonitor%
			WinRestore, ahk_id %LOC_ActiveWindowID%
			WinMove, ahk_id %LOC_ActiveWindowID%, , LOC_MonitorBoundLeft, LOC_MonitorBoundTop, LOC_MonitorBoundRight - LOC_MonitorBoundLeft, LOC_MonitorBoundBottom - LOC_MonitorBoundTop
			AHK_ShowToolTip("Window maximized on next screen")
		} Else {
			If (LOC_WindowWidth == SCR_VirtualScreenWidth
				&& LOC_WindowHeight == SCR_VirtualScreenHeight) {
				WinRestore, ahk_id %LOC_ActiveWindowID%
				AHK_ShowToolTip("Window restored")
			} Else {
				WinMaximize, ahk_id %LOC_ActiveWindowID%
			AHK_ShowToolTip("Window maximized")
			}
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TrayMenuMinimizeToTray:
If (WIN_FocusLastWindow()) {
	WIN_MinimizeToTray()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#End::
+#End::
WIN_MinimizeToTray()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_MinimizeToTrayShellHook(wParam, lParam, PRM_MessageNumber) {
	Critical
	If (PRM_MessageNumber == 1028) {
		If (wParam == 1028) {
			Return
		}
;   If (lParam == 0x201
;		|| lParam == 0x205
;		|| lParam == 0x207) {
;     WIN_MinimizeToTray(wParam, 3)
;   }
		If (lParam >= 0x201
				&& lParam <= 0x203
			|| lParam >= 0x207
				&& lParam <= 0x209) {
			WIN_MinimizeToTray(wParam, 3) ; TODO : à checker av la véritable fc
		}
	} Else If (wParam == 1
				|| wParam == 2) {
		WIN_MinimizeToTray(lParam, wParam) ; TODO : à checker av la véritable fc
	}
	Return, 0
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_MinimizeToTray(PRM_WindowID = 0, PRM_Flags = "") {
	 Global AHK_AutoHotKeyID, ZZZ_ShellHook, ZZZ_CloseHandleFunction
	 Static nMsg := nIcons := 0
	 nMsg ? "" : OnMessage(nMsg := 1028, "WIN_MinimizeToTrayShellHook")
	 , NumPut(AHK_AutoHotKeyID, NumPut(VarSetCapacity(ni, 444, 0), ni))
	 If (Not PRM_Flags) {

		If (!((PRM_WindowID += 0)
				|| PRM_WindowID := DllCall("user32.dll\GetForegroundWindow"))
			|| ((h := DllCall("GetWindow", "Uint", PRM_WindowID, "UInt", 4))
					&& DllCall("IsWindowVisible", "UInt", h)
					&& !PRM_WindowID := h)
			|| !(VarSetCapacity(sClass, 15), DllCall("user32.dll\GetClassNameA", "UInt", PRM_WindowID, "Str", sClass, "UInt", VarSetCapacity(sClass) + 1))
			|| AHK_SystemWindowClass(sClass)) {
			Return
		}
		OnMessage(ZZZ_ShellHook, "")
		WinMinimize, ahk_id %PRM_WindowID%
		WinHide, ahk_id %PRM_WindowID%
		Sleep, 100
		OnMessage(ZZZ_ShellHook, "WIN_MinimizeToTrayShellHook")
		, uID := uID_%PRM_WindowID%, uID ? "" : (uID_%PRM_WindowID% := uID := ++nIcons = nMsg ? ++nIcons : nIcons)
		If (!hIcon_%uID%) {
			If (!hIcon_%uID% := DllCall("user32.dll\SendMessage", "UInt", PRM_WindowID, "UInt", 127, "UInt", 2, "UInt", 0, "UInt") and Not hIcon_%uID% := DllCall("user32\SendMessage", "UInt", PRM_WindowID, "UInt", 127, "UInt", 0, "UInt", 0, "UInt")) {
				hIcon_%uID% := DllCall("user32.dll\SendMessage", "Uint", PRM_WindowID, "UInt", 127, "UInt", 1, "UInt", 0, "UInt")
			}
			VarSetCapacity(fi, 352, 0), DllCall("user32.dll\GetWindowThreadProcessId", "UInt", PRM_WindowID, "UIntP", pid), DllCall("psapi.dll\GetModuleFileNameExA", "UInt", hProc := DllCall("kernel32.dll\OpenProcess", "Uint", 0x410, "Int", 0, "UInt", pid), "UInt", 0, "UInt", &fi + 12, "UInt", 260), DllCall(ZZZ_CloseHandleFunction, "UInt", hProc)
		}

		hIcon_%uID% ? "" : (DllCall("shell32.dll\SHGetFileInfoA", "UInt", &fi + 12, "UInt", 0, "UInt", &fi, "UInt", 352, "UInt", 0x101), hIcon_%uID% := NumGet(fi))
		, DllCall("user32.dll\GetWindowTextA", "UInt", PRM_WindowID, "UInt", NumPut(hIcon_%uID%, NumPut(nMsg, NumPut(1 | 2 | 4, NumPut(uID, ni, 8)))), "Int", 64)      Return   hWnd_%uID% := DllCall("shell32.dll\Shell_NotifyIconA", "UInt", hWnd_%uID% ? 1 : 0, "UInt", &ni) ? PRM_WindowID : DllCall("user32.dll\ShowWindow", "UInt", PRM_WindowID, "Int", 5) * 0
	 } Else If (PRM_Flags > 0) {
		If (PRM_Flags == 3
			&& uID := PRM_WindowID) {
			IfWinExist, % "ahk_id " . hWnd_%uID%
			{
				WinShow
				WinRestore
				WinActivate
				WinWaitActive, , , 0
				WinShow
			} Else {
				PRM_Flags := 2
			}
		} Else {
			uID := uID_%PRM_WindowID%
		}
		Return, uID
			? (hWnd_%uID%
				? (DllCall("shell32.dll\Shell_NotifyIconA", "UInt", 2, "UInt", NumPut(uID, ni, 8) - 12), hWnd_%uID% := "")
				: "", PRM_Flags == 2 && hIcon_%uID%
					? (DllCall("user32.dll\DestroyIcon", "UInt", hIcon_%uID%), hIcon_%uID% := "")
					: "")
			: ""
	} Else {
		Loop, %nIcons% {
			hWnd_%A_Index% ? (DllCall("shell32.dll\Shell_NotifyIconA", "UInt", 2, "UInt", NumPut(A_Index, ni, 8) - 12), DllCall("user32.dll\ShowWindow", "UInt", hWnd_%A_Index%, "Int", 5), hWnd_%A_Index% := "") : "", hIcon_%A_Index% ? (DllCall("user32.dll\DestroyIcon", "UInt", hIcon_%A_Index%), hIcon_%A_Index% := "") : ""
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Always on top { Win + LeftButton | Win + Tab } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TrayMenuAlwaysOnTopToggle:
If (WIN_FocusLastWindow()) {
	WIN_AlwaysOnTopToggle()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#Tab::
#LButton::
WIN_AlwaysOnTopToggle()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_AlwaysOnTopToggle() {

	Global ZZZ_AlwaysOnTopActiveWindowID
	WIN_CheckAlwaysOnTopWindowIDs()
	SetWinDelay, -1
	IfInString, A_ThisHotkey, % "LButton"
	{
		MouseGetPos, , , ZZZ_AlwaysOnTopActiveWindowID
		If (!ZZZ_AlwaysOnTopActiveWindowID) {
			Return
		}
		WinGetClass, LOC_WindowClass, ahk_id %ZZZ_AlwaysOnTopActiveWindowID%
		If (AHK_SystemWindowClass(LOC_WindowClass)) {
			SendInput, {LWin Down}{LButton}{LWin Up}
			Return
		}
		IfWinNotActive, ahk_id %ZZZ_AlwaysOnTopActiveWindowID%
		{
			WinActivate
			WinWaitActive, ahk_id %ZZZ_AlwaysOnTopActiveWindowID%, , 0
			WinShow
		}
	} Else {
		WinGet, ZZZ_AlwaysOnTopActiveWindowID, ID, A
	}

	If (!ZZZ_AlwaysOnTopActiveWindowID) {
		Return
	}
	WinGetClass, LOC_WindowClass, ahk_id %ZZZ_AlwaysOnTopActiveWindowID%
	If (AHK_SystemWindowClass(LOC_WindowClass)
		|| LOC_WindowClass == "PuTTY") {
		Return
	}

	WinGet, LOC_WindowAlwaysOnTopStyle, ExStyle, ahk_id %ZZZ_AlwaysOnTopActiveWindowID%
	If (LOC_WindowAlwaysOnTopStyle & 0x8) { ; 0x8 is WS_EX_TOPMOST
		WIN_AlwaysOnTopOff()
		, AHK_ShowToolTip("Always on Top: Off")
	} Else {
		WIN_AlwaysOnTopOn()
		, AHK_ShowToolTip("Always on Top: On")
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_AlwaysOnTopOn() {
	Global
	WIN_CheckAlwaysOnTopWindowIDs()
	SetWinDelay, -1
	IfWinNotExist, ahk_id %ZZZ_AlwaysOnTopActiveWindowID%
	{
		Return
	}
	IfNotInString, ZZZ_AlwaysOnTopWindowIDs, % "|" . ZZZ_AlwaysOnTopActiveWindowID
	{
		ZZZ_AlwaysOnTopWindowIDs := ZZZ_AlwaysOnTopWindowIDs . "|" . ZZZ_AlwaysOnTopActiveWindowID
	}
	WinSet, AlwaysOnTop, On, ahk_id %ZZZ_AlwaysOnTopActiveWindowID%
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_AlwaysOnTopOff() {
	Global
	WIN_CheckAlwaysOnTopWindowIDs()
	SetWinDelay, -1
	IfWinNotExist, ahk_id %ZZZ_AlwaysOnTopActiveWindowID%
	{
		Return
	}
	StringReplace, ZZZ_AlwaysOnTopWindowIDs, ZZZ_AlwaysOnTopWindowIDs, |%A_LoopField%, , All
	WinSet, AlwaysOnTop, Off, ahk_id %ZZZ_AlwaysOnTopActiveWindowID%
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_AlwaysOnTopAllOff() {
	Global
	WIN_CheckAlwaysOnTopWindowIDs()
	Loop, Parse, ZZZ_AlwaysOnTopWindowIDs, |
	{
		If (A_LoopField) {
			ZZZ_AlwaysOnTopActiveWindowID := A_LoopField
			, WIN_AlwaysOnTopOff()
		}
	}
}

#^SC029::
WIN_AlwaysOnTopAllOff()
, AHK_ShowToolTip("Always on Top: All Off")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_CheckAlwaysOnTopWindowIDs() {
	Global
	DetectHiddenWindows, On
	Loop, Parse, ZZZ_AlwaysOnTopWindowIDs, |
	{
		If (A_LoopField) {
			IfWinNotExist, ahk_id %A_LoopField%
			{
				StringReplace, ZZZ_AlwaysOnTopWindowIDs, ZZZ_AlwaysOnTopWindowIDs, |%A_LoopField%, , All
			}
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Transparency { Ctrl + Win + Wheel } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_ClassTransparentable(PRM_Class) {
	Return, (PRM_Class != "MozillaWindowClass"
			&& PRM_Class != "ShockwaveFlashFullScreen"
			&& PRM_Class != "WMPTransition"
			&& PRM_Class != "WMPlayerApp"
			&& PRM_Class != "WMP Skin Host"
			&& !AHK_SystemWindowClass(PRM_Class))
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_InitTransparency() {

	Global APP_DisplayFusionPath
	AHK_Log("> WIN_InitTransparency()")
	If (WIN_TransparencyEnabled) {
		DetectHiddenWindows, Off
		WinGet, LOC_WindowsIDs, List, , , Program Manager
		DetectHiddenWindows, On
		WinGet, LOC_ActiveWindowID, ID, A
		Loop, %LOC_WindowsIDs% {
			StringTrimRight, LOC_WindowID, LOC_WindowsIDs%A_Index%, 0
			WinGetClass, LOC_WindowClass, ahk_id %LOC_WindowID%
			If (LOC_WindowID != LOC_ActiveWindowID
				&& WIN_ClassTransparentable(LOC_WindowClass)) {
				WinSet, Transparent, %WIN_Transparency%, ahk_id %LOC_WindowID%
			}
		}
	}

	WinGet, LOC_ShellTrayID, ID, ahk_class Shell_TrayWnd
	If (LOC_ShellTrayID) {
		WinGetPos, LOC_X, LOC_Y, LOC_Width, LOC_Height, ahk_id %LOC_ShellTrayID%
		ControlGetPos, LOC_StartX, LOC_StartY, LOC_StartWidth, LOC_StartHeight, Button1, ahk_id %LOC_ShellTrayID%
		If (LOC_Width < LOC_Height)	{
			LOC_PixelX := LOC_X + LOC_StartX + LOC_StartWidth / 2
			LOC_PixelY := LOC_Y + LOC_StartY + LOC_StartHeight
		} Else {
			LOC_PixelX := LOC_X + LOC_StartX + LOC_StartWidth + 1
			LOC_PixelY := LOC_Y + LOC_StartY + LOC_StartHeight / 2
		}
		PixelGetColor, LOC_Color, %LOC_PixelX%, %LOC_PixelY%, RGBe
		WinSet, TransColor, %LOC_Color%, ahk_id %LOC_ShellTrayID%
		Gui, 18:-AlwaysOnTop +Disabled +Owner -Caption +ToolWindow -Resize +LastFound ; GUI_ColoredTaskbar
		Gui, 18:Show, x%LOC_X% y%LOC_Y% w%LOC_Width% h%LOC_Height% NoActivate, GUI_ColoredTaskbar
		WinSet, ExStyle, +0x00000020
		If (A_Is64bitOS) {
			WinSet, Transparent, 100
		}
	}

	If (APP_DisplayFusionPath) {
		Process, Exist, DisplayFusion.exe
		If (ErrorLevel) {
			WinGet, LOC_WindowsIDs, List, , , Program Manager
			DetectHiddenWindows, On
			Loop, %LOC_WindowsIDs% {
				StringTrimRight, LOC_ID, LOC_WindowsIDs%A_Index%, 0
				WinGetClass, LOC_Class, ahk_id %LOC_ID%
				If (SubStr(LOC_Class, 1, 10) == "DFTaskbar:") {
					WinGetPos, LOC_X, LOC_Y, LOC_Width, LOC_Height, ahk_id %LOC_ID%
					WinSet, TransColor, %LOC_Color%, ahk_id %LOC_ID%
					Gui, 19:-AlwaysOnTop +Disabled +Owner -Caption +ToolWindow -Resize +LastFound ; GUI_DisplayFusionColoredTaskbar
					Gui, 19:Show, x%LOC_X% y%LOC_Y% w%LOC_Width% h%LOC_Height% NoActivate, GUI_DisplayFusionColoredTaskbar
					; WinSet, ExStyle, +0x00000020 ; TODO : à réactiver si DF apparaît encore ds la barre des tâches
					If (A_Is64bitOS) {
						WinSet, Transparent, 100
					}
					SYS_TaskbarColorPeriodicTimer(PRM_DisplayFusionID := LOC_ID)
					Break
				}
			}
		}
	} Else {
		SYS_TaskbarColorPeriodicTimer()
	}
	AHK_Log("< WIN_InitTransparency()")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TransparencyPeriodicTimer:
WIN_TransparencyPeriodicTimer()
Return

WIN_TransparencyPeriodicTimer(PRM_DisplayFusionID := 0) {

	LOC_InitialDegree := 10, LOC_FinalTransparency := 200
	Global APP_DisplayFusionPath
	Static STA_LastActiveWindowID := 0, STA_SysTrayDegree := LOC_InitialDegree, STA_DisplayFusionID := 0, STA_GetParentFunction := AHK_GetFunction("user32", "GetParent")
	WinGet, LOC_NewActiveWindowID, ID, A
	WinGetClass, LOC_NewActiveClass, ahk_id %LOC_NewActiveWindowID%

	; Display Fusion :
	; If (PRM_DisplayFusionID
	
	; System taskbar :
	STA_SysTrayDegree := (LOC_HoveredClass == "Shell_TrayWnd"
						|| LOC_HoveredClass == "BaseBar"
						|| SubStr(LOC_HoveredClass, 1, 14) == "TaskbarWindow:"
							? min(STA_SysTrayDegree + 3, LOC_InitialDegree)
							: max(STA_SysTrayDegree - 1, 0))
	, LOC_Transparency := Round(LOC_FinalTransparency + STA_SysTrayDegree * (255 - LOC_FinalTransparency) / LOC_InitialDegree)
	WinSet, Transparent, %LOC_Transparency%, ahk_class Shell_TrayWnd

	; DisplayFusion taskbar :
	If (APP_DisplayFusionPath) {
		;~ If (STA_DisplayFusionID > 0
		;~ && !WinExist("ahk_id " . STA_DisplayFusionID)) {
			;~ STA_DisplayFusionID := 0
		;~ }
		If (STA_DisplayFusionID == 0
			&& STA_SysTrayDegree == LOC_InitialDegree) {
			Process, Exist, DisplayFusion.exe
			If (ErrorLevel) {
				DetectHiddenWindows, Off
				WinGet, LOC_WindowsIDs, List, , , Program Manager
				DetectHiddenWindows, On
				Loop, %LOC_WindowsIDs% {
					StringTrimRight, LOC_ID, LOC_WindowsIDs%A_Index%, 0
					WinGetClass, LOC_Class, ahk_id %LOC_ID%
					If LOC_Class Contains TaskbarWindow:
					{
						STA_DisplayFusionID := LOC_ID
						Break
					}
				}
			}
		}
		If (WinExist("ahk_id " . STA_DisplayFusionID)) {
			WinSet, Transparent, %LOC_Transparency%
			WinSet, Top
		}
	}
	STA_LastActiveWindowID := LOC_NewActiveWindowID
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#WheelUp::
#WheelDown::
+#WheelUp::
+#WheelDown::
WIN_Transparency()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_Transparency() {
	Global
	Local LOC_ShiftState, LOC_WindowClass, LOC_TransparencyWindowAlpha, LOC_TransparencyActiveWindowID
	WIN_CheckTransparencyWindowIDs()
	SetWinDelay, -1
	LOC_TransparencyActiveWindowID := ""
	GetKeyState, LOC_ShiftState, Shift, P
	If (LOC_ShiftState == "D") {
		MouseGetPos, , , LOC_TransparencyActiveWindowID
		WinGetClass, LOC_WindowClass, ahk_id %LOC_TransparencyActiveWindowID%
	}
	If (!LOC_TransparencyActiveWindowID) {
		WinGet, LOC_TransparencyActiveWindowID, ID, A
		WinGetClass, LOC_WindowClass, ahk_id %LOC_TransparencyActiveWindowID%
	}
	If (LOC_TransparencyActiveWindowID) {
		If (AHK_SystemWindowClass(LOC_WindowClass)) {
			Return
		}

		LOC_TransparencyWindowAlpha := WIN_TransparencyWindowAlpha%LOC_TransparencyActiveWindowID%
		If (LOC_TransparencyWindowAlpha == "") {
			WIN_TransparencyWindowAlpha%LOC_TransparencyActiveWindowID% := LOC_TransparencyWindowAlpha := 255
		}

		IfNotInString, ZZZ_TransparencyWindowIDs, % "|" . LOC_TransparencyActiveWindowID
		{
			ZZZ_TransparencyWindowIDs := ZZZ_TransparencyWindowIDs . "|" . LOC_TransparencyActiveWindowID
		}

		IfInString, A_ThisHotkey, % "WheelDown"
		{
			LOC_TransparencyWindowAlpha -= 12.75
		} Else {
			LOC_TransparencyWindowAlpha += 12.75
		}
		LOC_TransparencyWindowAlpha := Max(0, Min(LOC_TransparencyWindowAlpha, 255))

		If (LOC_TransparencyWindowAlpha == 255) {
			WIN_TransparencyOff(LOC_TransparencyActiveWindowID)
			, AHK_ShowToolTip("Transparency: Off")
		} Else {
			WIN_TransparencyWindowAlpha%LOC_TransparencyActiveWindowID% := LOC_TransparencyWindowAlpha
			WinSet, Transparent, %LOC_TransparencyWindowAlpha%, ahk_id %LOC_TransparencyActiveWindowID%
			AHK_ShowToolTip("Transparency: " . Round(LOC_TransparencyWindowAlpha * 100 / 255) . " `%")
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TransparencyOff(PRM_TransparencyActiveWindowID = 0) {
	Global
	Local LOC_Transparency
	WIN_CheckTransparencyWindowIDs()
	SetWinDelay, -1
	If (!PRM_TransparencyActiveWindowID) {
		Return
	}
	WinGet, LOC_Transparency, Transparent, ahk_id %PRM_TransparencyActiveWindowID%
	IfInString, ZZZ_TransparencyWindowIDs, % "|" . PRM_TransparencyActiveWindowID
	{
		StringReplace, ZZZ_TransparencyWindowIDs, ZZZ_TransparencyWindowIDs, |%PRM_TransparencyActiveWindowID%, , All
		WIN_TransparencyWindowAlpha%PRM_TransparencyActiveWindowID% := ""
	}

	If (LOC_Transparency) {
		WinSet, Transparent, 255, ahk_id %PRM_TransparencyActiveWindowID%
		WinSet, Transparent, Off, ahk_id %PRM_TransparencyActiveWindowID%
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TransparencyAllOff() {
	Global ZZZ_TransparencyWindowIDs
	WIN_CheckTransparencyWindowIDs()
	Loop, Parse, ZZZ_TransparencyWindowIDs, |
	{
		If (A_LoopField) {
			WIN_TransparencyOff(PRM_TransparencyActiveWindowID := A_LoopField)
		}
	}

	DetectHiddenWindows, Off
	WinGet, LOC_WindowsIDs, List, , , Program Manager
	DetectHiddenWindows, On
	Loop, %LOC_WindowsIDs% {
		StringTrimRight, LOC_WindowID, LOC_WindowsIDs%A_Index%, 0
		WinGetClass, LOC_Class, ahk_id %LOC_WindowID%
		If (!AHK_SystemWindowClass(LOC_Class)) {
			WinGet, LOC_Transparency, Transparent, ahk_id %LOC_WindowID%
			If (LOC_Transparency) {
				WinSet, Transparent, 255, ahk_id %LOC_WindowID%
				WinSet, Transparent, Off, ahk_id %LOC_WindowID%
			}
		}
	}

	If (WinExist("ahk_class Shell_TrayWnd")) {
		WinGet, LOC_Transparency, Transparent
		If (LOC_Transparency) {
			WinSet, Transparent, 255
			WinSet, Transparent, Off
		}
	}
}

; #^t::
; WIN_TransparencyAllOff()
; AHK_ShowToolTip("Transparency: All Off")
; Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_CheckTransparencyWindowIDs() {
	Global
	DetectHiddenWindows, On
	Loop, Parse, ZZZ_TransparencyWindowIDs, |
	{
		If (A_LoopField) {
			IfWinNotExist, ahk_id %A_LoopField%
			{
				StringReplace, ZZZ_TransparencyWindowIDs, ZZZ_TransparencyWindowIDs, |%A_LoopField%, , All
				WIN_TransparencyWindowAlpha%A_LoopField% := ""
			}
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_CheckTransparencyWindowID(PRM_WindowID) {

	Global
	Loop, Parse, ZZZ_TransparencyWindowIDs, |
	{
		If (A_LoopField) {
			If (PRM_WindowID == A_LoopField) {
				Return, WIN_TransparencyWindowAlpha%A_LoopField%
			}
		}
	}
	Return, -1
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Window resizing { [ Ctrl + ] [ Win + ] Alt + [ Shift + ] + Wheel } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!WheelUp::
!+WheelUp::
!^WheelUp::
#!WheelUp::
; ^!+WheelUp:: ; used by Zoomer
!+#WheelUp::
!^#WheelUp::
!+^#WheelUp::
!WheelDown::
!+WheelDown::
!^WheelDown::
#!WheelDown::
; ^!+WheelDown:: ; used by Zoomer
!+#WheelDown::
!^#WheelDown::
!+^#WheelDown::
WIN_WheelResizing()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_WheelResizing() {
	Global ZZZ_Dragging, ZZZ_RightButtonJustCameDown, AHK_ToolTipsEnabled, SCR_VirtualScreenWidth, SCR_VirtualScreenHeight

	If (!GetKeyState("Alt")) {
		If (InStr(A_ThisHotkey, "WheelDown")) {
			WIN_AltTabWheelDown()
		} Else {
			WIN_AltTabWheelUp()
		}
		Return
	}

	If (ZZZ_Dragging
		|| ZZZ_RightButtonJustCameDown) {
		Return
	}

	SetWinDelay, -1
	CoordMode, Mouse, Screen
	WinGet, LOC_ActiveWindowID, ID, A
	If (!LOC_ActiveWindowID) {
		Return
	}
	WinGetClass, LOC_ActiveWindowClass, ahk_id %LOC_ActiveWindowID%
	If (AHK_SystemWindowClass(LOC_ActiveWindowClass)) {
		Return
	}

	WinGetPos, LOC_WindowX, LOC_WindowY, LOC_WindowWidth, LOC_WindowHeight, ahk_id %LOC_ActiveWindowID%

	If (LOC_WindowWidth
		&& LOC_WindowHeight) {
		LOC_WindowSizeRatio := LOC_WindowWidth / LOC_WindowHeight

		IfInString, A_ThisHotkey, % "WheelDown"
		{
			LOC_WheelDirection := 1
		} Else {
			LOC_WheelDirection := -1
		}

		IfInString, A_ThisHotkey, % "+"
		{
			LOC_ResizeFactor := 0.01
		} Else {
			LOC_ResizeFactor := 0.1
		}

		LOC_WindowNewWidth := LOC_WindowWidth + LOC_WheelDirection * LOC_WindowWidth * LOC_ResizeFactor
		, LOC_WindowNewHeight := LOC_WindowHeight + LOC_WheelDirection * LOC_WindowHeight * LOC_ResizeFactor

		IfInString, A_ThisHotkey, % "#"
		{
			LOC_WindowNewX := LOC_WindowX + (LOC_WindowWidth - LOC_WindowNewWidth) / 2
			, LOC_WindowNewY := LOC_WindowY + (LOC_WindowHeight - LOC_WindowNewHeight) / 2
		} Else {
			LOC_WindowNewX := LOC_WindowX
			, LOC_WindowNewY := LOC_WindowY
		}

		If (LOC_WindowNewWidth > SCR_VirtualScreenWidth) {
			LOC_WindowNewWidth := SCR_VirtualScreenWidth
			, LOC_WindowNewHeight := LOC_WindowNewWidth / LOC_WindowSizeRatio
		}
		If (LOC_WindowNewHeight > SCR_VirtualScreenHeight) {
			LOC_WindowNewHeight := SCR_VirtualScreenHeight
			, LOC_WindowNewWidth := LOC_WindowNewHeight * LOC_WindowSizeRatio
		}

		Transform, LOC_WindowNewX, Round, %LOC_WindowNewX%
		Transform, LOC_WindowNewY, Round, %LOC_WindowNewY%
		Transform, LOC_WindowNewWidth, Round, %LOC_WindowNewWidth%
		Transform, LOC_WindowNewHeight, Round, %LOC_WindowNewHeight%
		WinMove, ahk_id %LOC_ActiveWindowID%, , LOC_WindowNewX, LOC_WindowNewY, LOC_WindowNewWidth, LOC_WindowNewHeight

		If (AHK_ToolTipsEnabled) {
			WinGetPos, LOC_WindowX, LOC_WindowY, LOC_WindowWidth, LOC_WindowHeight, ahk_id %LOC_ActiveWindowID%
			AHK_ShowWindowToolTip(LOC_WindowX, LOC_WindowY, LOC_WindowWidth, LOC_WindowHeight, PRM_Prefix := "Window size", , , PRM_HiddenWindowEnabled := true)
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Window dragging { [ Ctrl + ] [ Win + ] [ Alt + ] [ Shift + ] RightButton } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

RButton::
+RButton::
^RButton::
+^RButton::
#RButton::
+#RButton::
^#RButton::
+^#RButton::
!RButton::
+!RButton::
!^RButton::
+!^RButton::
#!RButton::
+#!RButton::
!^#RButton::
+!^#RButton::
WIN_RightButtonDragging()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_RightButtonDragging() {
	Global
	Local LOC_WindowClass, LOC_ClickZone, LOC_WindowStyle, LOC_WindowTitle, LOC_ControlState, LOC_WindowState, LOC_ResizeStep, LOC_Exception

	CoordMode, Mouse, Screen
	MouseGetPos, ZZZ_MouseStartX, ZZZ_MouseStartY, ZZZ_DraggingWindowID
	If (!ZZZ_DraggingWindowID) {
		SendInput, {%A_ThisHotKey%}
		Return
	}
	WinGetClass, LOC_WindowClass, ahk_id %ZZZ_DraggingWindowID%
	If (LOC_WindowClass == "AutoHotkeyGUI") {
		WinGetTitle, LOC_WindowTitle, ahk_id %ZZZ_DraggingWindowID%
		If (LOC_WindowTitle == "GUI_Clock") {
			Try {
				APP_RunAs()
				Run, "%A_WinDir%\system32\rundll32.exe" Shell32.dll`, Control_RunDLL timedate.cpl
				RunAs
			} Catch LOC_Exception {
				AHK_Catch(LOC_Exception, "WIN_RightButtonDragging")
				, TRY_ShowTrayTip("Date and time properties not launched", 3)
			}
			Return
		}
		If (LOC_WindowTitle == "GUI_Calendar") {
			MouseClick
			Return
		}
	}

	If (A_ThisHotkey == "RButton") {
		LOC_ClickZone := WIN_GetTitleBarClickZone()
		If (LOC_ClickZone == "m") { ; Minimize button
			WIN_MinimizeToTray(ZZZ_DraggingWindowID)
			Return
		} Else If (LOC_ClickZone == "M") { ; Maximize button
			WIN_MaximizeHorizontally()
			Return
		}
	}

	If (LOC_WindowClass == "PuTTY") {
		SendInput, {Raw}%ClipBoard%
		Return
	}

	WinGet, LOC_WindowState, MinMax, ahk_id %ZZZ_DraggingWindowID%
	WinGet, LOC_WindowStyle, Style, ahk_id %ZZZ_DraggingWindowID%
	WinGetPos, ZZZ_WindowStartX, ZZZ_WindowStartY, ZZZ_WindowStartWidth, ZZZ_WindowStartHeight, ahk_id %ZZZ_DraggingWindowID%
	GetKeyState, LOC_ControlState, Ctrl, P
	If (LOC_WindowState == 1) {
		LOC_WindowState := 0
		WinMove, ahk_id %ZZZ_DraggingWindowID%, , %ZZZ_WindowStartX%, %ZZZ_WindowStartY%, %ZZZ_WindowStartWidth%, %ZZZ_WindowStartHeight%
		WinRestore, ahk_id %ZZZ_DraggingWindowID%
		WinMove, ahk_id %ZZZ_DraggingWindowID%, , %ZZZ_WindowStartX%, %ZZZ_WindowStartY%, %ZZZ_WindowStartWidth%, %ZZZ_WindowStartHeight%
		WinActivate, ahk_id %ZZZ_DraggingWindowID%
		WinWaitActive, ahk_id %ZZZ_DraggingWindowID%, , 0
		WinShow, ahk_id %ZZZ_DraggingWindowID%
	}

	; The and'ed condition checks for popup window :
	; (WS_POPUP) && !(WS_DLGFRAME | WS_SYSMENU | WS_THICKFRAME)
	ZZZ_RightButtonJustCameDownRequest := (LOC_ControlState == "U"
		&& ((LOC_WindowStyle & 0x80000000)
				&& !(LOC_WindowStyle & 0x4C0000)
			|| LOC_WindowClass == "ExploreWClass"
			|| LOC_WindowClass == "CabinetWClass"
			|| LOC_WindowClass == "IEFrame"
			|| LOC_WindowClass == "MozillaWindowClass"
			|| LOC_WindowClass == "OpWindow"
			|| LOC_WindowClass == "ATL:ExplorerFrame"
			|| LOC_WindowClass == "ATL:ScrapFrame"))
	, ZZZ_RightButtonJustCameDown := false
	, ZZZ_PermitClick := true
	, ZZZ_Dragging := !AHK_SystemWindowClass(LOC_WindowClass)
						&& (LOC_ControlState = "D"
							|| LOC_WindowState != 1
								&& !ZZZ_RightButtonJustCameDownRequest)

	; Checks wheter the window has a sizing border (WS_THICKFRAME)
	If (LOC_ControlState == "D"
		|| (LOC_WindowStyle & 0x40000)) {
		LOC_ResizeStep := 5
		If (ZZZ_MouseStartX >= ZZZ_WindowStartX + ZZZ_WindowStartWidth / LOC_ResizeStep
			&& ZZZ_MouseStartX <= ZZZ_WindowStartX + (LOC_ResizeStep - 1) * ZZZ_WindowStartWidth / LOC_ResizeStep) {
			ZZZ_ResizeX := 0
		} Else {
			If (ZZZ_MouseStartX > ZZZ_WindowStartX + ZZZ_WindowStartWidth / 2) {
				ZZZ_ResizeX := 1
			} Else {
				ZZZ_ResizeX := -1
			}
		}

		If (ZZZ_MouseStartY >= ZZZ_WindowStartY + ZZZ_WindowStartHeight / LOC_ResizeStep
			&& ZZZ_MouseStartY <= ZZZ_WindowStartY + (LOC_ResizeStep - 1) * ZZZ_WindowStartHeight / LOC_ResizeStep) {
			ZZZ_ResizeY := 0
		} Else {
			ZZZ_ResizeY := (ZZZ_MouseStartY > ZZZ_WindowStartY + ZZZ_WindowStartHeight / 2 ? 1 : -1)
		}
	} Else {
		ZZZ_ResizeX := ZZZ_ResizeY := 0
	}

	ZZZ_WindowStartSizeRatio := (ZZZ_WindowStartWidth && ZZZ_WindowStartHeight ? ZZZ_WindowStartWidth / ZZZ_WindowStartHeight : 0)

	If (!(LOC_WindowStyle & 0x80000000) || (LOC_WindowStyle & 0x4C0000)) {
		IfWinNotActive, ahk_id %ZZZ_DraggingWindowID%
		{
			WinActivate, ahk_id %ZZZ_DraggingWindowID%
			WinWaitActive, ahk_id %ZZZ_DraggingWindowID%, , 0
			WinShow, ahk_id %ZZZ_DraggingWindowID%
		}
	}

	Hotkey, Shift, WIN_IgnoreKeyTimer
	Hotkey, Ctrl, WIN_IgnoreKeyTimer
	Hotkey, Alt, WIN_IgnoreKeyTimer
	Hotkey, LWin, WIN_IgnoreKeyTimer
	Hotkey, RWin, WIN_IgnoreKeyTimer
	Hotkey, Shift, On
	Hotkey, Ctrl, On
	Hotkey, Alt, On
	Hotkey, LWin, On
	Hotkey, RWin, On
	SetTimer, WIN_IgnoreKeyTimer, %ZZZ_IgnoreKeyTimer%
	SetTimer, ZZZ_DragWindowResizingTimer, %ZZZ_DragWindowResizingTimer%
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_SetClickDraggingOff() {
	Global
	ZZZ_PermitClick := ZZZ_RightButtonJustCameDownRequest := ZZZ_Dragging := false
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_IgnoreKeyTimer:
WIN_IgnoreKey()
Return

WIN_IgnoreKey() {
	
	Global ZZZ_IgnoreKeyTimer
	GetKeyState, LOC_RightButtonState, RButton, P
	GetKeyState, LOC_ShiftState, Shift, P
	GetKeyState, LOC_ControlState, Ctrl, P
	GetKeyState, LOC_AltState, Alt, P
	GetKeyState, LOC_LeftWinState, LWin, P
	GetKeyState, LOC_RightWinState, RWin, P
	LOC_WinState := (LOC_LeftWinState == "D" || LOC_RightWinState == "D" ? "D" : "U")

	If (LOC_RightButtonState == "U"
		&& LOC_ShiftState == "U"
		&& LOC_ControlState == "U"
		&& LOC_AltState == "U"
		&& LOC_WinState == "U") {
		Hotkey, Shift, Off
		Hotkey, Ctrl, Off
		Hotkey, Alt, Off
		Hotkey, LWin, Off
		Hotkey, RWin, Off
	} ELse {
		SetTimer, WIN_IgnoreKeyTimer, %ZZZ_IgnoreKeyTimer%
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ZZZ_DragWindowResizingTimer:
WIN_DragWindowResizing()
Return

WIN_DragWindowResizing() {

	Global
	Local LOC_WindowX, LOC_WindowY, LOC_WindowWidth, LOC_WindowHeight, LOC_WindowNewX, LOC_WindowNewY, LOC_WindowNewWidth, LOC_WindowNewHeight, LOC_WindowNewSizeRatioWidth, LOC_WindowNewSizeRatioHeight, LOC_RightButtonState, LOC_ShiftState, LOC_AltState, LOC_LeftWinState, LOC_RightWinState, LOC_WinState, LOC_WindowNewRound, LOC_MouseX, LOC_MouseDeltaX, LOC_MouseY, LOC_MouseDeltaY, PRM_Text, PRM_HiddenWindowEnabled, LOC_Prefix, LOC_Suffix

	SetWinDelay, -1
	CoordMode, Mouse, Screen
	MouseGetPos, LOC_MouseX, LOC_MouseY
	WinGetPos, LOC_WindowX, LOC_WindowY, LOC_WindowWidth, LOC_WindowHeight, ahk_id %ZZZ_DraggingWindowID%
	GetKeyState, LOC_RightButtonState, RButton, P
	GetKeyState, LOC_ShiftState, Shift, P
	GetKeyState, LOC_AltState, Alt, P
	GetKeyState, LOC_LeftWinState, LWin, P
	GetKeyState, LOC_RightWinState, RWin, P
	LOC_WinState := (LOC_LeftWinState == "D" || LOC_RightWinState == "D" ? "D" : "U")

	If (LOC_RightButtonState == "U") {
		AHK_ResetCursor()

		If (ZZZ_RightButtonJustCameDown) {
			MouseClick, Right, %LOC_MouseX%, %LOC_MouseY%, , , U
		} Else {
			If (ZZZ_PermitClick
				&& (!ZZZ_Dragging
					|| ZZZ_MouseStartX = LOC_MouseX
						&& ZZZ_MouseStartY = LOC_MouseY)) {
				MouseClick, Right, %ZZZ_MouseStartX%, %ZZZ_MouseStartY%, , , D
				MouseClick, Right, %LOC_MouseX%, %LOC_MouseY%, , , U
			} Else {
				AHK_ResetCursor()
			}
		}

		WIN_SetClickDraggingOff()
		, ZZZ_RightButtonJustCameDown := false
		Return
	}

	LOC_MouseDeltaX := LOC_MouseX - ZZZ_MouseStartX
	, LOC_MouseDeltaY := LOC_MouseY - ZZZ_MouseStartY
	If (LOC_MouseDeltaX
		|| LOC_MouseDeltaY) {
		If (ZZZ_RightButtonJustCameDownRequest
			&& !ZZZ_RightButtonJustCameDown) {
			MouseClick, Right, %ZZZ_MouseStartX%, %ZZZ_MouseStartY%, , , D
			MouseMove, %LOC_MouseX%, %LOC_MouseY%
			ZZZ_RightButtonJustCameDown := true
			, ZZZ_PermitClick := false
		}

		If (ZZZ_Dragging) {
			If (!ZZZ_ResizeX
				&& !ZZZ_ResizeY) {
				LOC_WindowNewX := ZZZ_WindowStartX + LOC_MouseDeltaX
				, LOC_WindowNewY := ZZZ_WindowStartY + LOC_MouseDeltaY
				, LOC_WindowNewWidth := ZZZ_WindowStartWidth
				, LOC_WindowNewHeight := ZZZ_WindowStartHeight
			} Else {
				ZZZ_WindowDeltaWidth := 0
				, ZZZ_WindowDeltaHeight := 0
				If (ZZZ_ResizeX)
					ZZZ_WindowDeltaWidth := ZZZ_ResizeX * LOC_MouseDeltaX
				If (ZZZ_ResizeY)
					ZZZ_WindowDeltaHeight := ZZZ_ResizeY * LOC_MouseDeltaY
				If (LOC_WinState == "D") {
					If (ZZZ_ResizeX)
						ZZZ_WindowDeltaWidth *= 2
					If (ZZZ_ResizeY)
						ZZZ_WindowDeltaHeight *= 2
				}
				LOC_WindowNewWidth := ZZZ_WindowStartWidth + ZZZ_WindowDeltaWidth
				, LOC_WindowNewHeight := ZZZ_WindowStartHeight + ZZZ_WindowDeltaHeight
				If (LOC_WindowNewWidth < 0)
					If (LOC_WinState == "D")
						LOC_WindowNewWidth *= -1
					Else
						LOC_WindowNewWidth := 0
				If (LOC_WindowNewHeight < 0)
					If (LOC_WinState == "D")
						LOC_WindowNewHeight *= -1
					Else
						LOC_WindowNewHeight := 0
				If (LOC_AltState == "D"
					&& ZZZ_WindowStartSizeRatio) {
					LOC_WindowNewSizeRatioWidth := LOC_WindowNewHeight * ZZZ_WindowStartSizeRatio
					, LOC_WindowNewSizeRatioHeight := LOC_WindowNewWidth / ZZZ_WindowStartSizeRatio
					If (LOC_WindowNewWidth < LOC_WindowNewSizeRatioWidth)
						LOC_WindowNewWidth := LOC_WindowNewSizeRatioWidth
					If (LOC_WindowNewHeight < LOC_WindowNewSizeRatioHeight)
						LOC_WindowNewHeight := LOC_WindowNewSizeRatioHeight
				}
				ZZZ_WindowDeltaX := ZZZ_WindowDeltaY := 0
				If (LOC_WinState == "D") {
					ZZZ_WindowDeltaX := ZZZ_WindowStartWidth / 2 - LOC_WindowNewWidth / 2
					, ZZZ_WindowDeltaY := ZZZ_WindowStartHeight / 2 - LOC_WindowNewHeight / 2
				} Else {
					If (ZZZ_ResizeX == -1)
						ZZZ_WindowDeltaX := ZZZ_WindowStartWidth - LOC_WindowNewWidth
					If (ZZZ_ResizeY == -1)
						ZZZ_WindowDeltaY := ZZZ_WindowStartHeight - LOC_WindowNewHeight
				}
				LOC_WindowNewX := ZZZ_WindowStartX + ZZZ_WindowDeltaX
				, LOC_WindowNewY := ZZZ_WindowStartY + ZZZ_WindowDeltaY
			}

			If (LOC_ShiftState == "D")
				LOC_WindowNewRound := -1
			Else
				LOC_WindowNewRound := 0

			Transform, LOC_WindowNewX, Round, %LOC_WindowNewX%, %LOC_WindowNewRound%
			Transform, LOC_WindowNewY, Round, %LOC_WindowNewY%, %LOC_WindowNewRound%
			Transform, LOC_WindowNewWidth, Round, %LOC_WindowNewWidth%, %LOC_WindowNewRound%
			Transform, LOC_WindowNewHeight, Round, %LOC_WindowNewHeight%, %LOC_WindowNewRound%

			If (LOC_WindowNewX != LOC_WindowX
				|| LOC_WindowNewY != LOC_WindowY
				|| LOC_WindowNewWidth != LOC_WindowWidth
				|| LOC_WindowNewHeight != LOC_WindowHeight) {
				WinMove, ahk_id %ZZZ_DraggingWindowID%, , %LOC_WindowNewX%, %LOC_WindowNewY%, %LOC_WindowNewWidth%, %LOC_WindowNewHeight%
				If (AHK_ToolTipsEnabled) {
					WinGetPos, LOC_WindowX, LOC_WindowY, LOC_WindowWidth, LOC_WindowHeight, ahk_id %ZZZ_DraggingWindowID%
					If (ZZZ_ResizeX == -1) {
						If (ZZZ_ResizeY == -1) {
							LOC_Prefix := "|¯"
							, AHK_SetCursor("SizeNWSE")
						} Else
						If (ZZZ_ResizeY == 0) {
							LOC_Prefix := "|—"
							, AHK_SetCursor("SizeWE")
						} Else
						If (ZZZ_ResizeY == 1) {
							LOC_Prefix := "|_"
							, AHK_SetCursor("SizeNESW")
						}
						LOC_Prefix .= " Window Drag"
						, LOC_Suffix := ""
					} Else
					If (ZZZ_ResizeX == 0) {
						If (ZZZ_ResizeY == -1) {
							LOC_Prefix := "¯ Window Drag"
							, LOC_Suffix := "¯"
							, AHK_SetCursor("SizeNS")
						} Else
						If (ZZZ_ResizeY == 0) {
							LOC_Prefix := "Window Move"
							, LOC_Suffix := ""
							, AHK_SetCursor("SizeAll")
						} Else
						If (ZZZ_ResizeY == 1) {
							LOC_Prefix := "_ Window Drag"
							, LOC_Suffix := "_"
							, AHK_SetCursor("SizeNS")
						}
					} Else
					If (ZZZ_ResizeX == 1) {
						LOC_Prefix := "Window Drag"
						If (ZZZ_ResizeY == -1) {
							LOC_Suffix := "¯|"
							, AHK_SetCursor("SizeNESW")
						} Else
						If (ZZZ_ResizeY == 0) {
							LOC_Suffix := "—|"
							, AHK_SetCursor("SizeWE")
						} Else
						If (ZZZ_ResizeY == 1) {
							LOC_Suffix := "_|"
							, AHK_SetCursor("SizeNWSE")
						}
					}
					AHK_ShowWindowToolTip(LOC_WindowX, LOC_WindowY, LOC_WindowWidth, LOC_WindowHeight, LOC_Prefix, LOC_Suffix, , PRM_HiddenWindowEnabled := true)
				}
			}
		}
	}
	SetTimer, ZZZ_DragWindowResizingTimer, %ZZZ_DragWindowResizingTimer%
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Resizing with Keyboard { [ Win | Alt | Win + Alt } + NumPad ± } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_TrayMenuResize:
If (WIN_FocusLastWindow()) {
	SendInput, !{Space}t
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#NumpadAdd::
^#NumpadAdd::
#NumpadSub::
NumpadSub::
^#NumpadSub::
WIN_PadResizing()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_PadResizing() {

	Global ZZZ_Dragging, ZZZ_RightButtonJustCameDown, AHK_ToolTipsEnabled, SCR_VirtualScreenWidth
	If (ZZZ_Dragging
		|| ZZZ_RightButtonJustCameDown) {
		Return
	}

	SetWinDelay, -1
	CoordMode, Mouse, Screen

	WinGet, LOC_ActiveWindowID, ID, A
	If (!LOC_ActiveWindowID) {
		Return
	}
	WinGetClass, LOC_ActiveWindowClass, ahk_id %LOC_ActiveWindowID%
	If (AHK_SystemWindowClass(LOC_ActiveWindowClass)
		|| LOC_ActiveWindowClass == "PuTTY") {
		Return
	}

	WinGetPos, LOC_WindowX, LOC_WindowY, LOC_WindowWidth, LOC_WindowHeight, ahk_id %LOC_ActiveWindowID%

	IfInString, A_ThisHotkey, % "NumpadAdd"
	{
		If (LOC_WindowWidth < 160) {
			LOC_WindowNewWidth := 160
		} Else If (LOC_WindowWidth < 320) {
			LOC_WindowNewWidth := 320
		} Else If (LOC_WindowWidth < 640) {
			LOC_WindowNewWidth := 640
		} Else If (LOC_WindowWidth < 800) {
			LOC_WindowNewWidth := 800
		} Else If (LOC_WindowWidth < 1024) {
			LOC_WindowNewWidth := 1024
		} Else If (LOC_WindowWidth < 1152) {
			LOC_WindowNewWidth := 1152
		} Else If (LOC_WindowWidth < 1280) {
			LOC_WindowNewWidth := 1280
		} Else If (LOC_WindowWidth < 1400) {
			LOC_WindowNewWidth := 1400
		} Else If (LOC_WindowWidth < 1600) {
			LOC_WindowNewWidth := 1600
		} Else {
			LOC_WindowNewWidth := 1920
		}
		LOC_SizeIncreased := true
	} Else {
		If (LOC_WindowWidth <= 320) {
			LOC_WindowNewWidth := 160
		} Else If (LOC_WindowWidth <= 640) {
			LOC_WindowNewWidth := 320
		} Else If (LOC_WindowWidth <= 800) {
			LOC_WindowNewWidth := 640
		} Else If (LOC_WindowWidth <= 1024) {
			LOC_WindowNewWidth := 800
		} Else If (LOC_WindowWidth <= 1152) {
			LOC_WindowNewWidth := 1024
		} Else If (LOC_WindowWidth <= 1280) {
			LOC_WindowNewWidth := 1152
		} Else If (LOC_WindowWidth <= 1400) {
			LOC_WindowNewWidth := 1280
		} Else If (LOC_WindowWidth <= 1600) {
			LOC_WindowNewWidth := 1400
		} Else If (LOC_WindowWidth <= 1920) {
			LOC_WindowNewWidth := 1600
		} Else {
			LOC_WindowNewWidth := 1920
		}
		LOC_SizeIncreased := false
	}

	If (LOC_WindowNewWidth > SCR_VirtualScreenWidth) {
		LOC_WindowNewWidth := SCR_VirtualScreenWidth
	}
	LOC_WindowNewHeight := 3 * LOC_WindowNewWidth / 4
	If (LOC_WindowNewWidth == 1280) {
		LOC_WindowNewHeight := 1024
	}

	IfInString, A_ThisHotkey, % "^"
	{
		LOC_WindowNewX := LOC_WindowX
		, LOC_WindowNewY := LOC_WindowY
	} Else {
		LOC_WindowNewX := LOC_WindowX + (LOC_WindowWidth - LOC_WindowNewWidth) / 2
		, LOC_WindowNewY := LOC_WindowY + (LOC_WindowHeight - LOC_WindowNewHeight) / 2
	}

	Transform, LOC_WindowNewX, Round, %LOC_WindowNewX%
	Transform, LOC_WindowNewY, Round, %LOC_WindowNewY%
	Transform, LOC_WindowNewWidth, Round, %LOC_WindowNewWidth%
	Transform, LOC_WindowNewHeight, Round, %LOC_WindowNewHeight%

	WinMove, ahk_id %LOC_ActiveWindowID%, , LOC_WindowNewX, LOC_WindowNewY, LOC_WindowNewWidth, LOC_WindowNewHeight

	If (AHK_ToolTipsEnabled) {
		WinGetPos, LOC_WindowX, LOC_WindowY, LOC_WindowWidth, LOC_WindowHeight, ahk_id %LOC_ActiveWindowID%
		AHK_ShowWindowToolTip(LOC_WindowX, LOC_WindowY, LOC_WindowWidth, LOC_WindowHeight, PRM_Prefix := "Window " . (LOC_SizeIncreased ? "increased" : "decreased") . " size", , , PRM_HiddenWindowEnabled := true)
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Cancel visual effects { Ctrl + Win + Esc } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_CancelVisualEffects:
^#Esc::
WIN_AlwaysOnTopAllOff()
, WIN_TransparencyAllOff()
, ZZZ_TrayIconHidden := false
, TRY_TrayTipEnabled := true
, TRY_UpdateMenus()
, TRY_ShowTrayTip("Visual effects have been canceled", 2)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Focus previous active window :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_FocusLastWindow() {
	If (A_ThisMenuItem != "") {
		SendInput, !{Tab}
		Sleep, 100
	}
	WinGet, LOC_ActiveWindowID, ID, A
	WinGetClass, LOC_WindowClass, ahk_id %LOC_ActiveWindowID%
	If (AHK_SystemWindowClass(LOC_WindowClass)
		&& LOC_WindowClass != "Progman") {
		LOC_ActiveWindowID := ""
	}

	Return, LOC_ActiveWindowID
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_BoringPopUpsPeriodicTimer:
WIN_BoringPopUpsPeriodicTimer()
Return

WIN_BoringPopUpsPeriodicTimer() {

	Global ZZZ_BoringPopUpsPeriodicTimer

	; Edition :
	;;;;;;;;;;;
	
	; Word :
	Static STA_WordCount := 0
	If (WIN_IfWinActive(STA_WordCount, PRM_ParentTitle := "Word ahk_class OpusApp", PRM_WindowTitle := "Word ahk_class #32770", PRM_WindowText := "Comme ce fichier a été créé dans une version plus récente de Word", PRM_SecondsWaitingForParent := 4, PRM_SecondsWaitingAfterSuccess := 15)) {
		WinClose
		Return
	}

	; Excel
	Static STA_ExcelCount := 0
	If (WIN_IfWinActive(STA_ExcelCount, PRM_ParentTitle := "ahk_class XLMAIN", PRM_WindowTitle := "Excel ahk_class #32770", PRM_WindowText := "The file has been converted to a format you can work with", PRM_SecondsWaitingForParent := 2, PRM_SecondsWaitingAfterSuccess := 15)) {
		WinClose
		Return
	}

	; Office activation :
	Static STA_OfficeActivationCount := 0
	If (WIN_IfWinActive(STA_OfficeActivationCount, PRM_ParentTitles := "Word ahk_class OpusApp|ahk_class XLMAIN|PowerPoint ahk_class PPTFrameClass", PRM_WindowTitle := "Assistant Activation Microsoft Office ahk_class NUIDialog", , PRM_SecondsWaitingForParent := 2, PRM_SecondsWaitingAfterSuccess := 10)) {
		TRY_ShowTrayTip("Microsoft Office Activation wizard closed")
		WinClose
		Return
	}
	
	; UltraEdit :
	Static STA_UltraEditCount := 0
	If (WIN_IfWinActive(STA_UltraEditCount, PRM_ParentTitle := "UltraEdit", PRM_WindowTitle := "UltraEdit ahk_class #32770", PRM_WindowText := "Enregistrer les modifications", PRM_SecondsWaitingForParent := 3)) {
		WinGet, LOC_UltraEditID, ID
		CoordMode, Mouse, Screen
		MouseGetPos, , , LOC_HoveredWindowID
		If (LOC_HoveredWindowID != LOC_UltraEditID) {
			WinGetPos, LOC_UltraEditX, LOC_UltraEditY
			Try {
				ControlGetText, LOC_FileName, Static2
			} Catch LOC_Exception {
				AHK_Catch(LOC_Exception, "WIN_BoringPopUpsPeriodicTimer")
				Return
			}
			ControlGetPos, LOC_ControlX, LOC_ControlY, LOC_ControlWidth, LOC_ControlHeight, % "Button" . (SubStr(LOC_FileName, 1, 4) == "Edit" ? 2 : 1)
			If (LOC_ControlX != "") {
				MouseMove, LOC_UltraEditX + LOC_ControlX + LOC_ControlWidth // 2, LOC_UltraEditY + LOC_ControlY + LOC_ControlHeight // 2
			}
		}
		STA_UltraEditCount := 0
	}
	
	; SciTE for Autohotkey :
	Static STA_SciTECount := 0
	If (WIN_IfWinActive(STA_SciTECount, , PRM_WindowTitle := "SciTE4AutoHotkey ahk_class #32770", PRM_WindowText := "Welcome to SciTE4AutoHotkey", , PRM_SecondsWaitingAfterSuccess := 10)) {
		TRY_ShowTrayTip("SciTE welcome message closed")
		WinClose
		Return
	}


	; Games :
	;;;;;;;;;
	
	; UPlay :
	Static STA_UPlayID := 0, STA_UPlayCount := 0
	If (WIN_IfWinActive(STA_UPlayCount, PRM_ParentTitle := "Uplay ahk_class PlatformView")) {
		WinGet, LOC_UPlayID, ID
		If (LOC_UPlayID != STA_UPlayID) {
			CoordMode, Mouse, Screen
			WinGetPos, LOC_X, LOC_Y, LOC_Width, LOC_Height
			Sleep, 2000
			MouseClick, Left, LOC_X + LOC_Width // 2, LOC_Y + LOC_Height // 2
			STA_UPlayID := LOC_UPlayID
		}
		Return
	}
	
	; Rayman :
	;IfWinActive, Mise à jour disponible! ahk_class #32770, Une ou plusieurs mise(s) a jour ont été trouvées et téléchargées ; Rayman update
	;{
	;	SendInput, {Alt Down}n{Alt Up}
	;	Return
	;}
	
	IfWinActive, FlatOut Ultimate Carnage ahk_class #32770
	{
		SendInput, {Enter}
		Return
	}
	
	IfWinActive, FUEL ahk_class #32770
	{
		SendInput, {Enter}
		Return
	}
	
	IfWinActive, VisionGo ahk_class #32770 ; VisionGo
	{
		WinClose
		Return
	}
	
	; Many Faces of Go :
	Static STA_ManyFacesOfGoCount := 0
	If (WIN_IfWinActive(STA_ManyFacesOfGoCount, PRM_ParentTitle := "The Many Faces of Go", PRM_WindowTitle := "The Many Faces of Go", PRM_WindowText := "Save changes to", PRM_SecondsWaitingForParent := 2)) {
		SendMessage, 0x111, 7 ; No <=> SendInput, !N
		Return
	}
	
	; SGF Files :
	Static STA_SGFCount := 0
	If (WIN_IfWinActive(STA_SGFCount, PRM_ParentTitles := "Pale Moon ahk_class MozillaWindowClass|Firefox ahk_class MozillaWindowClass", PRM_WindowTitle := ".sgf ahk_class MozillaDialogClass", , PRM_SecondsWaitingForParent := 10, PRM_SecondsWaitingAfterSuccess := 3)) {
		WinGetTitle, LOC_FileName
		If (SubStr(LOC_FileName, 1, 12) == "Ouverture de") {
			SendInput, !o
			Sleep, 100
			SendInput, {Enter}
			StringReplace, LOC_FileName, LOC_FileName, Ouverture de%A_Space%
			LOC_FileName := SubStr(LOC_FileName, 1, StrLen(LOC_FileName) - 7) ; because of the appended suffix in the name : game-01.sgf, instead of game.sgf)
			WinWait, The Many Faces of Go - [%LOC_FileName%, , 5
			If (!ErrorLevel) {
				WinActivate
				PostMessage, 0x111, 32806 ; File editable
				PostMessage, 0x111, 32777 ; Go to game end
				PostMessage, 0x111, 32807 ; View Score
				PostMessage, 0x111, 32920 ; View Territories
				PostMessage, 0x111, 32870 ; Move Reasons
				PostMessage, 0x111, 32871 ; Lookahead
			}
			Return
		}
	}
	
	; Java Web Start :
	Static STA_JavaWebStartCount := 0
	If (WIN_IfWinActive(STA_JavaWebStartCount, PRM_ParentTitle := "Web Start", PRM_WindowTitle := "Web Start", PRM_WindowText := "échec de recv", PRM_SecondsWaitingForParent := 2, PRM_SecondsWaitingAfterSuccess := 3)) {
		WinClose
		APP_KGS(PRM_Relaunch := true)
		Return
	}
	
	; KGS :
	Static STA_KGSCount := 0
	If (WIN_IfWinExist(STA_KGSCount, , PRM_WindowTitle := "KGS : Attention ahk_class SunAwtFrame", , PRM_SecondsWaitingForParent := 500, PRM_SecondsWaitingAfterSuccess := 500)) {
		WinGet, LOC_KgsID, ID
		If (!WinExist("ahk_class WMPTransition")
			&& !WinExist("ahk_class ShockwaveFlashFullScreen")
			&& !WinExist("GUI_BSOD ahk_class AutoHotkeyGUI")) {
			CoordMode, Mouse, Screen
			MouseGetPos, LOC_MouseX, LOC_MouseY
			CoordMode, Mouse, Relative
			WinActivate, ahk_id %LOC_KgsID%
			WinWaitActive, , , 0
			WinMove, A, , 0, 0
			MouseClick, Left, 197, 133
			CoordMode, Mouse, Screen
			MouseMove, LOC_MouseX, LOC_MouseY
		}
	}

	Static STA_DiepIoCount := 0
	If (WIN_IfWinActive(STA_DiepIoCount, , PRM_WindowTitle := "diep.io ahk_class MozillaWindowClass", PRM_WindowText := "", , PRM_SecondsWaitingAfterSuccess := 10)) {
		SendInput, ^{F4}
		Return
	}

	; Image :
	;;;;;;;;;
	Static STA_PhotoshopCount := 0
	If (WIN_IfWinActive(STA_PhotoshopCount, PRM_ParentTitle := "ahk_class Photoshop", PRM_WindowTitle := "Profil manquant ahk_class PSFloatC", , PRM_SecondsWaitingForParent := 20)) {
		SendInput, {Enter}
		Return
	}
	If (WIN_IfWinExist(STA_PhotoshopCount, PRM_ParentTitle := "ahk_class Photoshop", PRM_WindowTitle := "Adobe Photoshop ahk_class #32770", PRM_WindowText := "Impossible de démarrer l'utilitaire de mise à jour Adobe. Réinstallez l'application et ses composants.", PRM_SecondsWaitingForParent := 20, PRM_SecondsWaitingAfterSuccess := 20)) {
		SendInput, {Enter}
	}

	; Audio :
	;;;;;;;;;
	Static STA_MediaMonkeyDeadCount := 0
	If (WIN_IfWinActive(STA_MediaMonkeyDeadCount, , PRM_WindowTitle := "MediaMonkey ahk_class #32770", PRM_WindowText := "Access violation at address")) {
		TRY_ShowTrayTip("MediaMonkey access violation notification closed")
		WinClose
		Return
	}
	Static STA_MediaMonkeyCPUCount := 0, STA_MediaMonkeyAffinity := 1
	If (WIN_IfWinExist(STA_MediaMonkeyCPUCount, , PRM_WindowTitle := "MediaMonkey ahk_class TFMainWindow", , , PRM_SecondsWaitingAfterSuccess := 5)) {
		WinGet, LOC_PID, PID
		Process, Priority, %LOC_PID%, Low
		STA_MediaMonkeyAffinity := 3 - STA_MediaMonkeyAffinity
		AHK_SetProcessAffinity(PRM_PID := LOC_PID, PRM_CPU := STA_MediaMonkeyAffinity)
	}
	Static STA_MediaMonkeyAlertCount := 0
	If (WIN_IfWinExist(STA_MediaMonkeyAlertCount, PRM_ParentTitle := "MediaMonkey ahk_class TFMainWindow", PRM_WindowTitle := "Avertissement ahk_class TMessageFormPlus", , PRM_SecondsWaitingForParent := 10, PRM_SecondsWaitingAfterSuccess := 10)) {
		SendInput, i
		Return
	}
	Static STA_MediaMonkeySplashCount := 0
	If (WIN_IfWinExist(STA_MediaMonkeySplashCount, , PRM_WindowTitle := "ahk_class MMSplash", , , PRM_SecondsWaitingAfterSuccess := 30)) {
		TRY_ShowTrayTip("MediaMonkey splash screen closed")
		WinClose
	}
	Static STA_MediaMonkeyCueReadingErrorCount := 0
	If (WIN_IfWinExist(STA_MediaMonkeyCueReadingErrorCount, PRM_ParentTitle := "MediaMonkey ahk_class TFMainWindow", PRM_WindowTitle := "Erreur ahk_class TMessageFormPlus", PRM_WindowText := "Ok", PRM_SecondsWaitingForParent := 10, PRM_SecondsWaitingAfterSuccess := 10)) {
		ControlSend, ahk_parent, {Enter}, Erreur ahk_class TMessageFormPlus
		TRY_ShowTrayTip("MediaMonkey error notification closed")
	}
	Static STA_DecoderSuspension := 50, STA_DecoderPID := 0
	If (STA_DecoderPID > 0) {
		Process, Exist, %STA_DecoderPID%
	} Else {
		Process, Exist, Decoder.exe
	}
	STA_DecoderPID := ErrorLevel
	If (STA_DecoderPID) {
		If (STA_DecoderSuspension / 10.0 == STA_DecoderSuspension // 10) {
			SYS_SuspendProcess(STA_DecoderPID, PRM_Suspend := STA_DecoderSuspension <= 0, PRM_Tooltip := false)
		}
		STA_DecoderSuspension--
		If (STA_DecoderSuspension < -10) {
			STA_DecoderSuspension := 50
		}
	}
	Static STA_MediaMonkeyAutoPlayListCriteriasCount := 0
	If (WIN_IfWinExist(STA_MediaMonkeyAutoPlayListCriteriasCount, PRM_ParentTitle := "MediaMonkey ahk_class TFMainWindow", PRM_WindowTitle := "CritÃ¨re de recherche ahk_class TFQueryCondition", , PRM_SecondsWaitingForParent := 10, PRM_SecondsWaitingAfterSuccess := 10)) {
		WinGetPos, LOC_X, LOC_Y, LOC_Width, LOC_Height
		If (LOC_Height < 300) {
			WinMove, , , LOC_X, LOC_Y, LOC_Width + 316, LOC_Height + 300
			LOC_Controls := "TComboBoxPlus1|TComboBoxPlus2|TSimPanel1|TVirtualStringTree1"
			Loop, Parse, LOC_Controls, |
			{
				ControlGetPos, LOC_ControlX, LOC_ControlY, LOC_ControlWidth, LOC_ControlHeight, %A_LoopField%
				ControlMove, %A_LoopField%, LOC_ControlX, LOC_ControlY, LOC_ControlWidth + 300, LOC_ControlHeight + (A_LoopField == "TSimPanel1" || A_LoopField == "TVirtualStringTree1" ? 300 : 0)
			 }
		}
		STA_MediaMonkeyAutoPlayListCriteriasCount := 10
	}
	Static STA_Mp3EditorCount := 0
	If (WIN_IfWinActive(STA_Mp3EditorCount, PRM_ParentTitle := "Mp3 Editor Pro ahk_class TMainForm", PRM_WindowTitle := "Mp3 Editor Pro ahk_class #32770", PRM_WindowText := "Are you sure you want to exit", PRM_SecondsWaitingForParent := 4, PRM_SecondsWaitingAfterSuccess := 5)) {
		SendInput, !o
		Return
	}

	Static STA_MusicDuplicateRemoverConfirmCount := 0
	If (WIN_IfWinActive(STA_MusicDuplicateRemoverConfirmCount, PRM_ParentTitle := "Music Duplicate Remover", PRM_WindowTitle := "Confirm ahk_class #32770", PRM_WindowText := "&Yes", PRM_SecondsWaitingForParent := 5)) {
		WinGet, LOC_Process, ProcessName
		If (LOC_Process == "music_duplicate.exe") {
			SendInput, !y
			Return
		}
	}

	Static STA_MusicDuplicateRemoverAffinityCount := 0, STA_MusicDuplicateRemoverCPU := 1
	If (WIN_IfWinExist(STA_MusicDuplicateRemoverAffinityCount, PRM_ParentTitle := "Music Duplicate Remover ahk_class Tfm", , , PRM_SecondsWaitingForParent := 15, PRM_SecondsWaitingAfterSuccess := 15)) {
		WinGet, LOC_PID, PID
		Process, Priority, %LOC_PID%, Low
		STA_MusicDuplicateRemoverCPU := 3 - STA_MusicDuplicateRemoverCPU
		AHK_SetProcessAffinity(LOC_PID, STA_MusicDuplicateRemoverCPU)
	}

	Static STA_TableEditCount := 0
	If (WIN_IfWinActive(STA_TableEditCount, , PRM_WindowTitle := "TablEdit ahk_class #32770", PRM_WindowText := "TablEdit Version de démonstration", , PRM_SecondsWaitingAfterSuccess := 5)) {
		TRY_ShowTrayTip("TablEdit demo message closed")
		SendInput, {Enter}
		Return
	}
	
	;~ Static STA_EarMasterConfigurationCount := 0
	;~ If (WIN_IfWinActive(STA_EarMasterConfigurationCount, , PRM_WindowTitle := "Configuration d'EarMaster ahk_class tConfigWizard", , , PRM_SecondsWaitingAfterSuccess := 10)) {
		;~ ControlSend, , {Enter}
		;~ TRY_ShowTrayTip("EarMaster configuration wizard closed")
		;~ Return
	;~ }
	;~ Static STA_EarMasterSplashCount := 0
	;~ If (WIN_IfWinActive(STA_EarMasterSplashCount, , PRM_WindowTitle := "ahk_class TSplashForm")) {
		;~ WinGet, LOC_ProcessName, ProcessName
		;~ If (LOC_ProcessName == "EarMaster Pro 6.dat") {
			;~ WinHide
		;~ }
		;~ Return
	;~ }
	Static STA_GraceNoteCount := 0
	If (WIN_IfWinExist(STA_GraceNoteCount, , PRM_WindowTitle := "ahk_class PoweredByGracenote")) { ; Quintessential popup
		WinKill
	}
	
	; Video :
	;;;;;;;;;
	Static STA_VideoConverterCount := 0, STA_VideoConverterAffinity := 1
	If (WIN_IfWinExist(STA_VideoConverterCount, , PRM_WindowTitle := "Freemake Video Converter", , , PRM_SecondsWaitingAfterSuccess := 15)) { ; Video Converter
		WinGet, LOC_PID, PID
		Process, Priority, %LOC_PID%, Low
		STA_VideoConverterAffinity := 3 - STA_VideoConverterAffinity
		AHK_SetProcessAffinity(PRM_PID := LOC_PID, PRM_CPU := STA_VideoConverterAffinity)
	}
	
	; Communication :
	;;;;;;;;;;;;;;;;;
	Static STA_TorrentCount := 0
	If (WIN_IfWinActive(STA_TorrentCount, PRM_ParentTitle := "Pale Moon ahk_class MozillaWindowClass|Firefox ahk_class MozillaWindowClass", PRM_WindowTitle := ".torrent ahk_class MozillaDialogClass", , PRM_SecondsWaitingForParent := 10, PRM_SecondsWaitingAfterSuccess := 1)) {
		WinGetTitle, LOC_FileName
		If (SubStr(LOC_FileName, 1, 12) == "Ouverture de") {
			SendInput, !o
			Sleep, 100
			SendInput, {Enter}
			Return
		}
	}
	;~ IfWinActive, PuTTY Fatal Error ahk_class #32770, Software caused connection abort
	;~ {
		;~ WinKill
		;~ Return
	;~ }
	;~ IfWinActive, PuTTY Exit Confirmation ahk_class #32770
	;~ {
		;~ ControlClick, Button1, , , , , NA
		;~ Return
	;~ }
	;~ IfWinActive, PuTTY Connection Manager ahk_class #32770, Etes-vous sûr de vouloir fermer toutes les bases de connexions
	;~ {
		;~ SendInput, !o
		;~ Return
	;~ }
	;~ IfWinActive, Confirmer la fermeture ahk_class #32770, La fermeture de la fenêtre de discussion ferme les fenêtres de toutes les discussions actives. Voulez-vous continuer ? ; Sametime
	;~ {
		;~ SendInput, !o
		;~ Return
	;~ }

	Static STA_SchoolCalendarCount := 0
	If (WIN_IfWinActive(STA_SchoolCalendarCount, PRM_ParentTitle := "Pale Moon ahk_class MozillaWindowClass", PRM_WindowTitle := "Cahier de textes ahk_class MozillaWindowClass", PRM_WindowText := "", PRM_SecondsWaitingForParent := 5, PRM_SecondsWaitingAfterSuccess := 15)) {
		Sleep, 500
		SendInput, !d{Tab 6}5{Down}{Enter}
		Return
	}
	
	Static STA_IETridentCount := 0
	If (WIN_IfWinActive(STA_IETridentCount, PRM_ParentTitle := "Internet Explorer ahk_class IEFrame", PRM_WindowTitle := "Windows Internet Explorer ahk_class Internet Explorer_TridentDlgFrame", PRM_SecondsWaitingForParent := 5)) {
		WinKill
		Return
	}
	
	Static STA_ActiveXCount := 0
	If (WIN_IfWinActive(STA_ActiveXCount, PRM_ParentTitle := "Internet Explorer ahk_class IEFrame", PRM_WindowTitle := "Windows Internet Explorer", PRM_WindowText := "Au moins un contrôle ActiveX n’a pas pu être affiché", PRM_SecondsWaitingForParent := 5, PRM_SecondsWaitingAfterSuccess := 1)) {
		WinClose
		Return
	}

	Static STA_TimeCampCount := 0
	If (WIN_IfWinActive(STA_TimeCampCount, , PRM_WindowTitle := "TimeCamp ahk_class wxWindowNR", , PRM_SecondsWaitingForParent := 30, PRM_SecondsWaitingAfterSuccess := 30)) {
		WinSet, AlwaysOnTop, On
		Return
	}

	Static STA_ThunderbirdPriorityCount := 0
	If (WIN_IfWinExist(STA_ThunderbirdPriorityCount, , PRM_WindowTitle := "Mozilla Thunderbird ahk_class MozillaWindowClass", , , PRM_SecondsWaitingAfterSuccess := 5)) {
		WinGet, LOC_PID, PID, %PRM_WindowTitle%
		Process, Priority, %LOC_PID%, % WinActive(PRM_WindowTitle) || WinActive("rappel ahk_class MozillaDialogClass") ? "High" : "Low"
	}
	
	Static STA_MozillaCrashCount := 0
	If (WIN_IfWinExist(STA_MozillaCrashCount, PRM_ParentTitles := "Pale Moon ahk_class MozillaWindowClass|Firefox ahk_class MozillaWindowClass", PRM_WindowTitle := "Gestionnaire de sessions - Restaurer après un crash ahk_class MozillaDialogClass", , PRM_SecondsWaitingForParent := 3, PRM_SecondsWaitingAfterSuccess := 15)) {
		ControlSend, ahk_parent, {Enter}
	}
	
	; Thunderbird error popup :
	;~ IfWinExist, ahk_class MozillaWindowClass
	;~ {
		;~ WinGetTitle, LOC_Title
		;~ If (LOC_Title == "") {
			;~ WinGet, LOC_Style, Style
			;~ If (LOC_Style & 0x80000000) { ; WS_POPUP
				;~ WinGet, LOC_ExStyle, ExStyle
				;~ If (LOC_ExStyle & 0x00000008) { ; WS_EX_TOPMOST
					;~ WinGetPos, , , LOC_Width, LOC_Height
					;~ If (LOC_Width == 341
						;~ && LOC_Height == 110) {
						;~ WinHide
						;~ Return
					;~ }
				;~ }
			;~ }
		;~ } Else If (LOC_Title == "Une erreur est survenue") {
			;~ ControlSend, ahk_parent, {Enter}
			;~ Return
		;~ }
	;~ }

	; Security :
	;;;;;;;;;;;;
	IfWinActive, Comodo Internet Security Premium ahk_class MainDialog
	{
		WinGetPos, , , LOC_Width, LOC_Height
		If (LOC_Width * LOC_Height < 500 * 500) {
		TRY_ShowTrayTip("Comodo message closed")
		WinClose
		}
		Return
	}
	
/* 	IfWinActive, COMODO Message Center ahk_class CisMainWizard
	{
		WinClose
		Return
	}
	
	IfWinActive, COMODO Le centre de messages ahk_class CisMainWizard
	{
		WinClose
		Return
	}
 */	
	;~ IfWinActive, Statistiques d'analyse lors de l'accès ahk_class #32770
	;~ {
		;~ ControlClick, Button8, , , , , NA
		;~ Return
	;~ }
	;~ IfWinActive, Programme de mise à jour de McAfee Agent ahk_class #32770
	;~ {
		;~ WinGet, LOC_ExStyle, ExStyle
		;~ If (LOC_ExStyle & 0x40000) {
			;~ WinSet, ExStyle, -0x40000
			;~ WinMinimize
			;~ WinHide
		;~ }
		;~ Return
	;~ }
	;~ IfWinActive, Notification McAfee VirusScan ahk_class #32770, Analyser
	;~ {
		;~ ControlClick, Button2
		;~ Return
	;~ }
	;~ IfWinActive, Rootkit Unhooker LE, Another RkU instance is running
	;~ {
		;~ WinClose
		;~ Return
	;~ }

	; System :
	;;;;;;;;;;
	
	Static STA_UltraCopierCount := 0
	If (WIN_IfWinExist(STA_UltraCopierCount, , PRM_WindowTitle := "Warning ahk_class Qt5QWindowIcon", , PRM_SecondsWaitingAfterSuccess := 5, PRM_SecondsWaitingAfterSuccess := 5)) {
		WinClose
	}
	
	;~ IfWinActive, Mises à jour automatiques ahk_class #32770, , , Comment voulez-vous installer les mises à jour ?
	;~ {
		;~ WinHide
		;~ WinKill
		;~ Return
	;~ }
	
	;~ DetectHiddenWindows, Off
	;~ If (A_Is64bitOS
		;~ && (WinExist("ahk_class ClassicShell.COwnerWindow")
			;~ || WinExist("Démarrer ahk_class Button"))) {
		;~ WinHide
		;~ Return
	;~ }
	;~ DetectHiddenWindows, On
	
	;~ While (WinActive("RegSvr32 ahk_class #32770")) {
		;~ WinClose
	;~ }
	
	;~ Static STA_DUMoCount := 0
	;~ If (WIN_IfWinActive(STA_DUMoCount, PRM_ParentTitle := "DUMo ahk_class TMainDlg", PRM_WindowTitle := "DUMo ahk_class TShareDlg", PRM_WindowText := "Enter Licence", PRM_SecondsWaitingForParent := 10, PRM_SecondsWaitingAfterSuccess := 10)) {
		;~ WinKill
		;~ Return
	;~ }
	
	;~ IfWinActive, Licence du logiciel ahk_class NativeHWNDHost
	;~ {
		;~ WinKill
		;~ Return
	;~ }
	
	IfWinExist, - Erreur d'application ahk_class #32770 ; Any application down
	{
		TRY_ShowTrayTip("Application error notification closed")
		WinKill
	}

	Static STA_ProcessHackerCount := 0
	If (WIN_IfWinActive(STA_ProcessHackerCount, PRM_ParentTitle := "Process Hacker [FUSION\BeLO]+ ahk_class ProcessHacker", PRM_WindowTitle := "Process Hacker ahk_class #32770", PRM_WindowText := "Terminate", PRM_SecondsWaitingForParent := 3, PRM_SecondsWaitingAfterSuccess := 0)) {
		SendInput, {Left}{Enter}
		Return
	}
	
	;~ IfWinExist, Envoi des mises à jour facultatives - dysfonctionnement ahk_class #32770 
	;~ {
		;~ WinKill
	;~ }
	
	;~ IfWinExist, Assistant Matériel détecté ahk_class #32770, SAMSUNG Android Composite ADB Interface
	;~ {
		;~ ControlSend, ahk_parent, {Enter}
	;~ }
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_IfWinExist(ByRef PRM_Count, PRM_ParentTitles = "", PRM_WindowTitle = "", PRM_WindowText = "", PRM_SecondsWaitingForParent = 1, PRM_SecondsWaitingAfterSuccess = 0) {
	; If (WIN_IfWinExist(PRM_Count := , PRM_ParentTitles := "", PRM_WindowTitle := "", PRM_WindowText := "", PRM_SecondsWaitingForParent := 1PRM_SecondsWaitingAfterSuccess := 1)) {
	Return, WIN_IfWin(PRM_Count, PRM_ParentTitles, PRM_WindowTitle, PRM_WindowText, PRM_SecondsWaitingForParent, PRM_SecondsWaitingAfterSuccess, PRM_Active := false)
}

WIN_IfWinActive(ByRef PRM_Count, PRM_ParentTitles = "", PRM_WindowTitle = "", PRM_WindowText = "", PRM_SecondsWaitingForParent = 1, PRM_SecondsWaitingAfterSuccess = 0) {
	; If (WIN_IfWinActive(PRM_Count := , PRM_ParentTitles := "", PRM_WindowTitle := "", PRM_WindowText := "", PRM_SecondsWaitingForParent := 1PRM_SecondsWaitingAfterSuccess := 1)) {
	Return, WIN_IfWin(PRM_Count, PRM_ParentTitles, PRM_WindowTitle, PRM_WindowText, PRM_SecondsWaitingForParent, PRM_SecondsWaitingAfterSuccess, PRM_Active := true)
}

WIN_IfWin(ByRef PRM_Count, PRM_ParentTitles, PRM_WindowTitle, PRM_WindowText, PRM_SecondsWaitingForParent, PRM_SecondsWaitingAfterSuccess, PRM_Active) {
	
	Global ZZZ_BoringPopUpsPeriodicTimer
	If (PRM_Count <= 0) {
		If (PRM_ParentTitles) {
			Loop, Parse, PRM_ParentTitles, |
			{
				If (PRM_WindowTitle || !PRM_Active
					? WinExist(A_LoopField)
					: WinActive(A_LoopField)) {
					LOC_IfWin := (!PRM_WindowTitle || (PRM_Active ? WinActive(PRM_WindowTitle, PRM_WindowText) : WinExist(PRM_WindowTitle, PRM_WindowText)))
					If (LOC_IfWin) {
						PRM_Count := 1000 * PRM_SecondsWaitingAfterSuccess / ZZZ_BoringPopUpsPeriodicTimer
					}
					Return, LOC_IfWin
				}
			}
			PRM_Count := 1000 * PRM_SecondsWaitingForParent / ZZZ_BoringPopUpsPeriodicTimer
			Return, false
		}
		
		If (PRM_WindowTitle) {
			If (PRM_Active ? WinActive(PRM_WindowTitle, PRM_WindowText) : WinExist(PRM_WindowTitle, PRM_WindowText)) {
				PRM_Count := 1000 * PRM_SecondsWaitingForParent / ZZZ_BoringPopUpsPeriodicTimer
				Return, true
			}
		}
		Return, false
	} Else {
		PRM_Count--
		Return, false
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Excluded system windows :
;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_SystemWindowClass(PRM_WindowClass = "") {
	If (PRM_WindowClass == "") {
		WinGetClass, PRM_WindowClass, A
	}
	Return, (PRM_WindowClass == "Progman"
			|| PRM_WindowClass == "WorkerW"
			|| PRM_WindowClass == "Shell_TrayWnd"
			|| PRM_WindowClass == "VistaSwitcher_SwitcherWnd"
			|| PRM_WindowClass == "ThunderRT6Main")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_GetTitleBarClickZone() {
;	  't' : title
;	  'm' : minimize
;	  'M' : maximize
;	  'x' : close
;	false : other

	CoordMode, Mouse, Screen
	MouseGetPos, LOC_MouseX, LOC_MouseY, LOC_ActiveWindowID
	If (!LOC_ActiveWindowID) {
		Return, false
	}

	WinGetClass, LOC_WindowClass, ahk_id %LOC_ActiveWindowID%
	SendMessage, 0x84, 0, (LOC_MouseX & 0xFFFF) | (LOC_MouseY & 0xFFFF) << 16, , ahk_id %LOC_ActiveWindowID%
	LOC_ErrorLevel := ErrorLevel
	If (LOC_ActiveWindowID && !AHK_SystemWindowClass(LOC_WindowClass)) {
		If (LOC_ErrorLevel == 2) { ; Title bar
			Return, "t"
		}
		If (LOC_ErrorLevel == 3) { ; System menu
			Return, "s"
		}
		If (LOC_ErrorLevel == 8) { ; Minimize button
			Return, "m"
		}
		If (LOC_ErrorLevel == 9) { ; Maximize button
			Return, "M"
		}
		If (LOC_ErrorLevel == 20) { ; Close button
			Return, "x"
		}
		If (LOC_ErrorLevel == 21) { ; Help button
			Return, "h"
		}
	}
	Return false
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WIN_GetWindowTitle(PRM_WindowID) {

	AutoTrim, On
	If (!PRM_WindowID) {
		WinGet, PRM_WindowID, ID, A
	}
	WinGetTitle, LOC_Title, ahk_id %PRM_WindowID%
	LOC_Title = %LOC_Title%
	LOC_LastDash := InStr(LOC_Title, "-", false, 0)
	If (LOC_LastDash) {
		LOC_NewTitle := SubStr(LOC_Title, LOC_LastDash + 1)
		LOC_NewTitle = %LOC_NewTitle%
		If (LOC_NewTitle) {
			LOC_Title := LOC_NewTitle
		}
	}
	If (LOC_Title == "") {
		WinGet, LOC_Title, ProcessName, ahk_id %PRM_WindowID%
		LOC_Dot := InStr(LOC_Title, ".", false, 0)
		If (LOC_Dot) {
			LOC_Title := SubStr(LOC_Title, 1, LOC_Dot - 1)
		}
	}
	If (LOC_Title == "") {
		LOC_Title := "Application"
	}
	Return, LOC_Title
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
