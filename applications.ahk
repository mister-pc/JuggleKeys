;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Application groups :
;;;;;;;;;;;;;;;;;;;;;;

APP_Init() {
	
    Global ZZZ_ProgramFiles32, ZZZ_ProgramFiles64
    GroupAdd, APP_WMPWindowsGroup, ahk_class WMPlayerApp
    GroupAdd, APP_WMPWindowsGroup, ahk_class WMPTransition
	GroupAdd, APP_WMPWindowsGroup, ahk_class WMP Skin Host
	GroupAdd, APP_WMPWindowsGroup, ahk_class CWmpControlCntr
	GroupAdd, APP_WMPWindowsGroup, ahk_class MediaPlayerClassicW
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Generic application running function :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_Run(PRM_ApplicationName, PRM_Process, PRM_Parameters = "", PRM_WorkingDirectory = "", PRM_Maximized = true, PRM_WindowIdentification = "", PRM_AlreadyLaunchedWarning = true, PRM_RunAs = true) {

; 1. PRM_ApplicationName        : application label
; 2. PRM_Process                : full path to the executable
; 3. PRM_Parameters             : parameters passed to the command
; 4. PRM_WorkingDirectory       : working directory, process' one by default
; 5. PRM_Maximized       		: if true, window maximized
; 6. PRM_WindowIdentification   : if false, no check if the application is already launched
;                                 if "", just activate the window whose process name corresponds to PRM_Process' one (if found)
;                                 if other (usually by ahk_class), just activate the window so identified (if found)
; 7. PRM_AlreadyLaunchedWarning : if true display a warning if application is already started
; 8. PRM_RunAs                  : run as login/password given by shortcuts Win + Shift + Enter

	If (PRM_WindowIdentification
		&& PRM_WindowIdentification != true) {
		IfWinExist, %PRM_WindowIdentification%
		{
			WinActivate
			WinWaitActive, , , 0
			WinShow
			WinGet, LOC_WindowPID, PID

			If (PRM_AlreadyLaunchedWarning) {
				TRY_ShowTrayTip(PRM_ApplicationName . " already launched", 2)
			}
			Return, LOC_WindowPID
		}
	}

	If (PRM_Process) {
		SplitPath, PRM_Process, LOC_ProcessName, LOC_ProcessDirectory
		Process, Exist, %LOC_ProcessName%
		LOC_WindowPID := ErrorLevel
		If (LOC_WindowPID > 0
			&& PRM_WindowIdentification != false) {
			LOC_Activated := false
			If (PRM_WindowIdentification == "") {
				WinActivate, ahk_pid %LOC_WindowPID%
				WinWaitActive, ahk_pid %LOC_WindowPID%, , 0
				LOC_Activated := true
			} Else {
				IfWinExist, %PRM_WindowIdentification%
				{
					WinActivate
					WinWaitActive, , , 0
					LOC_Activated := true
				}
			}
			If (LOC_Activated) {
				WinShow
				If (PRM_AlreadyLaunchedWarning) {
					TRY_ShowTrayTip(PRM_ApplicationName . " already launched", 2)
				}
				Return, LOC_WindowPID
			}
		}
		
		If (FileExist(PRM_Process)) {
			If (PRM_WorkingDirectory == "") {
				PRM_WorkingDirectory := LOC_ProcessDirectory
			}
			PRM_WindowParameters := (PRM_Maximized ? "Max " : "") . "UseErrorLevel"
			If (PRM_RunAs) {
				APP_RunAs()
			}
			If (PRM_Parameters == "") {
				Run, "%PRM_Process%", %PRM_WorkingDirectory%, %PRM_WindowParameters%, LOC_WindowPID
				AHK_Debug("Run, """ . PRM_Process . """, " . PRM_WorkingDirectory . ", " . PRM_WindowParameters . ", " . LOC_WindowPID)
			} Else {
				Run, "%PRM_Process%" %PRM_Parameters%, %PRM_WorkingDirectory%, %PRM_WindowParameters%, LOC_WindowPID
				AHK_Debug("Run, """ . PRM_Process . """ " . PRM_Parameters . ", " . PRM_WorkingDirectory . ", " . PRM_WindowParameters . ", " . LOC_WindowPID)
			}
			RunAs
			TRY_ShowTrayTip(PRM_ApplicationName . (ErrorLevel ? " not" : "") . " launched")
			Return, (ErrorLevel ? false : LOC_WindowPID)
		}
	}

	TRY_ShowTrayTip(PRM_ApplicationName . " (" . PRM_Process . ") not found", 3)
	Return, 0
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_IsFileSelected(PRM_Quotes = """") {
	Return, APP_ArePaths(TXT_GetSelectedText(), , PRM_Quotes, 1, false)
}

APP_AreFilesSelected(PRM_Separator = " ", PRM_Quotes = """") {
	Return, APP_ArePaths(TXT_GetSelectedText(), PRM_Separator, PRM_Quotes, , false)
}

APP_IsDirectorySelected(PRM_Quotes = """") {
	Return, APP_ArePaths(TXT_GetSelectedText(), , PRM_Quotes, 1, true)
}

APP_AreDirectoriesSelected(PRM_Separator = " ", PRM_Quotes = """") {
	Return, APP_ArePaths(TXT_GetSelectedText(), PRM_Separator, PRM_Quotes, , true)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_IsFile(PRM_Text, PRM_Quotes = """") {
	Return, APP_ArePaths(PRM_Text, , PRM_Quotes, 1, false)
}

APP_AreFiles(PRM_Text, PRM_Separator = " ", PRM_Quotes = """") {
	Return, APP_ArePaths(PRM_Text, PRM_Separator, PRM_Quotes, , false)
}

APP_IsDirectory(PRM_Text, PRM_Quotes = """") {
	Return, APP_ArePaths(PRM_Text, , PRM_Quotes, 1, true)
}

APP_AreDirectories(PRM_Text, PRM_Separator = " ", PRM_Quotes = """") {
	Return, APP_ArePaths(PRM_Text, PRM_Separator, PRM_Quotes, , true)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_ArePaths(PRM_Text = "", PRM_Separator = " ", PRM_Quotes = """", PRM_MaxCount = 0, PRM_Directories = false) {
	; Returns the fill path list of the text or selection
	LOC_Text := PRM_Text
	, LOC_FileList := ""
	, LOC_Count := 0
	Loop, Parse, LOC_Text, `r`n
	{
		LOC_Path := Trim(A_LoopField)
		If (LOC_Path) {
			If (FileExist(LOC_Path)) {
				FileGetAttrib, LOC_Attributes, %LOC_Path%
				If (PRM_Directories ^ InStr(LOC_Attributes, "D")) {
					Return, ""
				}
				LOC_FileList .= (LOC_FileList ? PRM_Separator : "") . PRM_Quotes . LOC_Path . PRM_Quotes
				, LOC_Count++
				If (LOC_Count == PRM_MaxCount) {
					Break
				}
			} Else {
				Return, ""
			}
		}
	}
	Return, LOC_FileList
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; ArtIcons :
;;;;;;;;;;;;

#IfWinActive, ArtIcons ahk_class TfmMain
F2::SendInput, {AppsKey}r
^F2::SendInput, !lr{Ctrl Up}
#IfWinActive

; ICL-Icon Extractor :
;;;;;;;;;;;;;;;;;;;;;;
#IfWinActive, ICL-Icon Extractor ahk_class TfmMain
F2::SendInput, {AppsKey}r
#IfWinActive


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Snag It { Win + BackSpace } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_SnagIt:
#BackSpace::
If (APP_SnagItPath) {
	APP_Run("SnagIt", APP_SnagItPath, APP_AreFilesSelected(), A_MyDocuments)
} Else {
	HotKey, #BackSpace, Off
	SendInput, #{BackSpace}
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; MP3 Editor { Ctrl + Win + BackSpace } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_MP3Editor:
^#BackSpace::
If (APP_MP3EditorPath) {
	APP_MP3Editor()
} Else {
	HotKey, ^#BackSpace, Off
	HotKey, IfWinActive, Mp3 Editor Pro ahk_class TMainForm
	HotKey, XButton1, Off
	HotKey, XButton2, Off
	HotKey, XButton1 Up, Off
	HotKey, XButton2 Up, Off
	HotKey, IfWinActive
	SendInput, ^#{BackSpace}
}
Return

APP_MP3Editor() {
	Global APP_MP3EditorPath
	LOC_FilesSelected := APP_AreFilesSelected(PRM_Separator := "|")
	If (LOC_FilesSelected) {
		Loop, Parse, LOC_FilesSelected, |
		{
			If (LOC_WindowPID := APP_Run("MP3Editor", APP_MP3EditorPath, , A_MyDocuments, PRM_Maximized := false, PRM_WindowIdentification := false)) {
				WinWaitActive, ahk_pid %LOC_WindowPID%, , 10
				If (!ErrorLevel) {
					SendInput, {Esc 2}^o
					WinWaitActive, Ouvrir ahk_class #32770, , 5
					If (!ErrorLevel) {
						Sleep, 250
						SendInput, !n
						Sleep, 250
						SendInput, {Raw}%A_LoopField%
						Sleep, 250
						SendInput, !o
						Sleep, 250
						SendInput, {Esc 2}
					}
				}
			} Else {
				Break
			}
		}
	} Else {
		APP_Run("MP3Editor", APP_MP3EditorPath, , A_MyDocuments, PRM_Maximized := false, PRM_WindowIdentification := false)
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, Mp3 Editor Pro ahk_class TMainForm
XButton1::
XButton2::
XButton1 Up::
XButton2 Up::
APP_MP3EditorClick(A_ThisHotKey)
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_MP3EditorClick(PRM_ThisHotKey) {
	Static STA_Down := false, STA_MouseX, STA_MouseY
	CoordMode, Mouse, Screen
	If (Instr(PRM_ThisHotKey, "Up")) {
		STA_Down := false
		Click, Up %STA_MouseX%, %STA_MouseY%
		Return
	}
	If (!STA_Down) {
		MouseGetPos, STA_MouseX, STA_MouseY
		STA_Down := true
	}
	If (WinActive("Mp3 Editor Pro ahk_class TMainForm")) {
		ControlGetPos, LOC_ControlX, LOC_ControlY, LOC_ControlWidth, LOC_ControlHeight, % "TScrollBar" . (A_ThisHotKey == "XButton1" ? 2 : 1)
		If (LOC_ControlWidth) {
			WinGetPos, LOC_WindowX, LOC_WindowY
			Click, % " Down " . LOC_WindowX + LOC_ControlX + (A_ThisHotKey == "XButton1" ? 8 : LOC_ControlWidth - 8) . ", " . LOC_WindowY + LOC_ControlY + LOC_ControlHeight / 2
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Photoshop { Ctrl + Alt + Win + BackSpace } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_Photoshop:
^#!BackSpace::
If (APP_PhotoshopPath) {
	APP_Run("Photoshop", APP_PhotoshopPath, APP_AreFilesSelected(), A_MyDocuments, , false)
} Else {
	HotKey, ^#!BackSpace, Off
	SendInput, ^#!{BackSpace}
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Task Manager { Ctrl + Shift + Esc } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_TaskManager:
SendInput, +^{Esc}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Remove programs { Ctrl + Win + Delete } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_RemovePrograms:
^#Delete::
^#NumpadDel::
IfWinExist, Ajouter ou supprimer des programmes ahk_class NativeHWNDHost
{
	WinActivate
	WinWaitActive, , , 0
	WinShow
	TRY_ShowTrayTip("Program remover already launched", 2)
} Else {
	APP_RunAs()
	If (A_Is64bitOS) {
		Run, "%A_WinDir%\system32\rundll32.exe" Shell32.dll`, Control_RunDLL appwiz.cpl, %A_WinDir%\system32, Max UseErrorLevel
	} Else {
		Run, "%A_WinDir%\system32\rundll32.exe" Shell32.dll`, Control_RunDLL appwiz.cpl`, `, 0, %A_WinDir%\system32, Max UseErrorLevel
	}
	RunAs
	TRY_ShowTrayTip("Program remover launched")
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Empty recycle bin { Ctrl + Win + Shift + Delete } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_EmptyRecycleBin:
+^#Delete::
^+#NumpadDel::
APP_EmptyRecycleBin()
Return

APP_EmptyRecycleBin() {
	TRY_ShowTrayTip("Emptying recycle bin")
	AHK_SetCursor("Wait")
	FileRecycleEmpty
	If (AHK_AudioEnabled) {
		Try {
			SoundPlay, % A_WinDir . "\Media\recycle.wav", Wait
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "APP_EmptyRecycleBin")
		}
	}
	TRY_ShowTrayTip("Recycle bin now empty")
	AHK_ResetCursor()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Administration tools { Ctrl + Win + A } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_Administration:
^#a::
Run, %A_WinDir%\system32\control.exe admintools
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; CD-Burner { Win + B } :
;;;;;;;;;;;;;;;;;;;;;;;;;

; APP_Burner:
; APP_Run("CD Burner", APP_CDBurnerPath, , , false)
; Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Bash console { Win + B } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_Bash:
#b::
APP_Run("Bash", APP_BashPath, "--cd=/g/projects/kamea", , , , false)
MsgBox, Launched ?
Return

#IfWinActive, ahk_class mintty
RButton::
^v::
^+v::
SendInput, +{Insert}
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Calculator { Win + C } :
;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_Calculator:
#c::
APP_Run("Calculator", A_WinDir . "\system32\calc.exe", , , , false)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Comodo :
;;;;;;;;;;

#IfWinActive, COMODO Alerte de redémarrage ahk_class CisMainWizard
Esc::
APP_ComodoRestartAlert()
Return

APP_ComodoRestartAlert() {
	CoordMode, Mouse, Screen
	MouseGetPos, LOC_MouseX, LOC_MouseY
	WinActivate, COMODO Alerte de redémarrage ahk_class CisMainWizard
	CoordMode, Mouse, Window
	MouseClick, , 232, 232
	SendInput, {Down 2}{Tab 2}{Space}
	CoordMode, Mouse, Screen
	MouseMove, LOC_MouseX, LOC_MouseY
}
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Disk manager { Ctrl + Win + D } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_Disks:
^#d::
APP_Run("Disks manager", A_WinDir . "\system32\mmc.exe", """" . A_WinDir . "\system32\diskmgmt.msc""", A_WinDir . "\system32", , "Gestion des disques ahk_class MMCMainFrame", , false)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Directory Opus { Win + E } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
APP_DOpus:
#e::
APP_DOpus()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_DOpus() {
	Global APP_DirectoryOpusPath, APP_DirectoryOpusRTPath
	LOC_SelectedDirectories := APP_AreDirectoriesSelected("|")
	WinGet, LOC_ActiveWindowID, ID, A
	IfWinExist, ahk_class dopus.lister
	{
		WinGet, LOC_DOpusID
		If (LOC_DOpusID != LOC_ActiveWindowID) {
			WinActivate
		} Else {
			If (!LOC_SelectedDirectories) {
				Run, "%APP_DirectoryOpusRTPath%" /cmd Go CURRENT NEWTAB, UseErrorLevel
				Return
			}
		}
	} Else {
		If (APP_DirectoryOpusPath) {
			TRY_ShowTrayTip("Launching Directory Opus")
			APP_RunAs()
			SplitPath, APP_DirectoryOpusPathRT, , LOC_Directory
			Run, "%APP_DirectoryOpusPathRT%", %LOC_Directory%, UseErrorLevel
			SplitPath, APP_DirectoryOpusPath, , LOC_Directory
			Run, "%APP_DirectoryOpusPath%", %LOC_Directory%, Max UseErrorLevel
			RunAs
		} Else {
			TRY_ShowTrayTip("Launching Explorer")
			Run, "%A_WinDir%\explorer.exe", , Max UseErrorLevel
			Return
		}
	}
	
	If (LOC_SelectedDirectories) {
		Loop, Parse, LOC_SelectedDirectories, |
		{
			Run, "%APP_DirectoryOpusPathRT%" /cmd go %A_LoopField% NEWTAB=findexisting, UseErrorLevel
		}
	}
	
	Process, Exist, explorer.exe
	If (!ErrorLevel) {
		Run, %A_WinDir%\explorer.exe, , Hide
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; AltGr-Enter like Alt-Enter :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, ahk_class dopus.lister
<^>!Enter::SendInput, !{Enter}{Ctrl Up}
#IfWinActive

#IfWinActive, Accès au dossier refusé ahk_class #32770
Esc::SendInput, {Right}{Space} ; Accès au dossier refusé ahk_class #32770
#IfWinActive

#IfWinActive, Suppression de fichier - Directory Opus ahk_class #32770
Esc:: ; Suppression de fichier - Directory Opus ahk_class #32770
IfWinExist, Accès au dossier refusé ahk_class #32770
{
	WinActivate
	WinWaitActive
	SendInput, {Right}{Space}
} Else {
	SendInput, {Esc}
}
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Explorer { Ctrl + Win + E } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_Explorer:
<^#e::
APP_Explorer()
Return

APP_Explorer() {
	LOC_Directories := APP_AreDirectoriesSelected("|")
	If (LOC_Directories) {
		Loop, Parse, LOC_Directories, |
		{
			APP_Run("Explorer", A_WinDir . "\explorer.exe", A_LoopField, , false, false)
		}
	} Else {
		APP_Run("Explorer", A_WinDir . "\explorer.exe", , , false, false)
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Group policy { Ctrl + Win + G } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_GroupPolicy:
^#g::
APP_Run("Group policy", A_WinDir . "\system32\mmc.exe", """" . A_WinDir . "\system32\gpedit.msc""", A_WinDir . "\system32", , "Éditeur de stratégie de groupe locale ahk_class MMCMainFrame", , false)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Hardware device manager [Ctrl + Win + H] :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_Hardware:
^#h::
APP_Run("Device manager", A_WinDir . "\system32\mmc.exe", """" . A_WinDir . "\system32\devmgmt.msc""", A_WinDir . "\system32", , "Gestionnaire de périphériques ahk_class MMCMainFrame", , false)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Rescan hardware { Ctrl + Win + Shift + H } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_RescanHardware:
+#h::
TRY_ShowTrayTip("Rescanning hardware")
APP_RunAs()
Run, "%A_WinDir%\system32\devcon.exe" rescan, %A_WinDir%\system32, Min UseErrorLevel
RunAs
TRY_ShowTrayTip("Hardware rescanned")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Firefox { Win + I } [ Ctrl : Safe mode ] [ Shift : Full rights ] :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_TrayMenuFirefox:
APP_TrayMenuFirefox()
Return

APP_TrayMenuFirefox() {
	WIN_FocusLastWindow()
	APP_FirefoxManager(, PRM_Selection := TXT_GetSelectedText())
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#i::
+#i::
^#i::
^+#i::
APP_Firefox()
Return

APP_Firefox() {
	APP_FirefoxManager(PRM_ThisHotKey := A_ThisHotKey, PRM_Selection := TXT_GetSelectedText())
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_FirefoxManager(PRM_ThisHotKey = false, PRM_Selection = "", PRM_AlreadyLaunchedWarning = true) {

	Global APP_FirefoxPath
	LOC_Selection := Trim(PRM_Selection, " `t`r`n`v`f")
	
	; MediaMonkey treatment :
	If (WinActive("MediaMonkey ahk_class TFMainWindow")) {
		LOC_MP3Check := false
		Loop, Parse, LOC_Selection, `r`n`v`f
		{
			StringLower, LOC_File, A_LoopField
			If (A_Index == 1) {
				LOC_FirstLine := A_LoopField
			}
			If (FileExist(A_LoopField)) {
				LOC_DotIndex := InStr(A_LoopField, ".", , 0)
				If (LOC_DotIndex) {
					LOC_Extension := SubStr(A_LoopField, LOC_DotIndex + 1)
					StringLower, LOC_Extension, LOC_Extension
					If LOC_Extension In ape,fla,flac,mp3,mpc,ogg,wav,wma
					{
						LOC_File := A_LoopField
						LOC_MP3Check := true
						Break
					}
				}
			}
		}

		If (LOC_MP3Check) {
			LOC_TempFile := A_ScriptDir . "\conf\" . A_Now . ".tmp"
			APP_RunAs()
			RunWait, %ComSpec% /c ""%A_ScriptDir%\bin\tagReader.exe" "%LOC_File%" --stdout --simple 1>"%LOC_TempFile%"", , Hidden UseErrorLevel
			RunAs
			If (ErrorLevel) {
				FileDelete, %LOC_TempFile%
				StringReplace, LOC_File, LOC_File, M:\INCONNU\, , All
				LOC_SlashIndex := InStr(LOC_File, "\", , 0)
				If (LOC_SlashIndex) {
					LOC_Selection := SubStr(LOC_File, 1, LOC_SlashIndex - 1)
					StringReplace, LOC_File, LOC_File, \, %A_Space%, All
				} Else {
					LOC_DotIndex := InStr(LOC_Selection, ".", , 0)
					If (LOC_DotIndex) {
						LOC_File := SubStr(LOC_File, 1, LOC_DotIndex - 1)
					}
				}
				LOC_Selection := LOC_File
			} Else {
				FileRead, LOC_TempFileContent, %LOC_TempFile%
				FileDelete, %LOC_TempFile%
				RegExMatch(LOC_TempFileContent, "Artist=(.*)", LOC_Artist)
				RegExMatch(LOC_TempFileContent, "Album=(.*)", LOC_Album)
				RegExMatch(LOC_TempFileContent, "Year=(.*)", LOC_Year)
				StringReplace, LOC_Artist, LOC_Artist, Artist=
				StringReplace, LOC_Album, LOC_Album, Album=
				StringReplace, LOC_Year, LOC_Year, Year=
				LOC_Artist := Trim(LOC_Artist)
				, LOC_Album := Trim(LOC_Album)
				, LOC_Year := Trim(LOC_Year)
				StringUpper, LOC_Artist, LOC_Artist, T
				StringUpper, LOC_Album, LOC_Album, T
				LOC_Artist7 := SubStr(LOC_Artist, 1, 7)
				If (LOC_Artist7 == "Inconnu" 
					|| LOC_Artist7 == "Divers"
					|| LOC_Artist7 == "Artiste"
					|| LOC_Artist7 == "Unknown" 
					|| LOC_Artist7 == "Various"
					|| LOC_Artist7 == "Artist"
					|| LOC_Artist7 == "VA"
					|| LOC_Artist == LOC_Album) {
					LOC_Artist := ""
				}
				LOC_Album13 := Substr(LOC_Album, 1, 13)
				If (LOC_Album13 == "Album Inconnu"
					|| LOC_Album13 == "Unknown Album"
					|| LOC_Album13 == "Unknown"
					|| LOC_Album13 == "Various Songs"
					|| LOC_Album13 == "Title"
					|| LOC_Album13 == "Inconnu") {
					LOC_Album := ""
				}
				If (LOC_Artist
					|| LOC_Album) {
					LOC_Selection := LOC_Artist . " " . LOC_Album . " " . LOC_Year
				} Else {
					StringReplace, LOC_Selection, LOC_File, M:\INCONNU\, , All
					LOC_SlashIndex := InStr(LOC_Selection, "\", , 0)
					If (LOC_SlashIndex) {
						LOC_Selection := SubStr(LOC_Selection, 1, LOC_SlashIndex - 1)
						StringReplace, LOC_Selection, LOC_Selection, \, , All
					} Else {
						LOC_DotIndex := InStr(LOC_File, ".", , 0)
						If (LOC_DotIndex) {
							LOC_Selection := SubStr(LOC_File, 1, LOC_DotIndex - 1)
						}
					}
				}
			}
		} Else {
			StringReplace, LOC_Selection, LOC_FirstLine, M:\INCONNU\, , All
			LOC_SlashIndex := InStr(LOC_Selection, "\", , 0)
			If (LOC_SlashIndex) {
				LOC_Selection := SubStr(LOC_Selection, 1, LOC_SlashIndex - 1)
				StringReplace, LOC_Selection, LOC_Selection, \, %A_Space%, All
				StringReplace, LOC_Selection, LOC_Selection, _, %A_Space%, All
			} Else {
				LOC_DotIndex := InStr(LOC_File, ".", , 0)
				If (LOC_DotIndex) {
					LOC_Selection := SubStr(LOC_File, 1, LOC_DotIndex - 1)
				}
			}
		}
	}
	
	If (WinExist("Pale Moon ahk_class MozillaWindowClass")
		|| WinExist("Mozilla Firefox ahk_class MozillaWindowClass")) {
		WinActivate
		WinWaitActive, , , 0
		WinShow
		If (PRM_AlreadyLaunchedWarning) {
			TRY_ShowTrayTip("Firefox already launched", 2)
		}
	} Else {
		If (PRM_ThisHotKey) {
			StringReplace, LOC_Modifiers, PRM_ThisHotKey, % "#i"
			StringReplace, LOC_Modifiers, LOC_Modifiers, % "Browser_Home"
		} Else {
			LOC_Modifiers := ""
		}

		If (FileExist(A_WinDir . "\system32\StripMyRights.exe")) {
			LOC_StripMyRights := """" . A_WinDir . "\system32\StripMyRights.exe"""
		} Else {
			If (!InStr(LOC_Modifiers, "+")) {
				LOC_Modifiers .= "+"
			}
		}
		
		APP_RunAs()
		If (LOC_Modifiers == "") {
			Run, %LOC_StripMyRights% "%APP_FirefoxPath%", %A_Desktop%, Max UseErrorLevel
			TRY_ShowTrayTip("Firefox launched with restricted rights")
		} Else If (LOC_Modifiers == "+") {
			Run, "%APP_FirefoxPath%", %A_Desktop%, Max UseErrorLevel
			TRY_ShowTrayTip("Firefox launched with full rights")
		} Else If (LOC_Modifiers == "^") {
			Run, %LOC_StripMyRights% "%APP_FirefoxPath%" "-safe-mode", %A_Desktop%, Max UseErrorLevel
			TRY_ShowTrayTip("Firefox launched in safe mode with restricted rights")
		} Else If (LOC_Modifiers == "^+") {
			Run, "%APP_FirefoxPath%" "-safe-mode", %A_Desktop%, Max UseErrorLevel
			TRY_ShowTrayTip("Firefox launched in safe mode with full rights")
		}
		RunAs
		If (LOC_Selection != "") {
			WinWaitActive, % (InStr(APP_FirefoxPath, "palemoon") ? "Pale Moon" : "Mozilla Firefox") . " ahk_class MozillaWindowClass", , 10
			WinShow
		}
	}
	If (LOC_Selection != ""
		&& (WinExist("Pale Moon ahk_class MozillaWindowClass")
			|| WinExist("Mozilla Firefox ahk_class MozillaWindowClass"))) {
		WinActivate
		WinWaitActive, , , 0
		WinShow
		AHK_KeyWait("#!+")
		StringLower, LOC_LowerSelection, LOC_Selection
		LOC_LowerSelection := Trim(LOC_LowerSelection, "/\ `t`r`n`v`f")
		, LOC_WebSite := Substr(LOC_LowerSelection, 1, 4) == "http"
							|| Substr(LOC_LowerSelection, 1, 3) == "www"
		If (!LOC_WebSite) {
			LOC_LastDot := InStr(LOC_LowerSelection, ".", true, 0)
			If (LOC_LastDot) {
				LOC_SelectionEnd := SubStr(LOC_LowerSelection, LOC_LastDot + 1)
				, LOC_Length := StrLen(LOC_SelectionEnd)
				, LOC_Extension2 := [ "be", "ch", "de", "es", "eu", "fr", "it", "nl", "pl", "tv", "uk" ]
				, LOC_Extension3 := [ "biz", "com", "org", "net" ]
				, LOC_Extension4 := [ "info" ]
				If (LOC_Extension%LOC_Length%) {
					For LOC_Key, LOC_Extension In LOC_Extension%LOC_Length%
					{
						If (LOC_SelectionEnd == LOC_Extension) {
							LOC_WebSite := true
							Break
						}
					}
				}
			}
		}
		If (LOC_WebSite) {
			SendInput, !d ; or ^l : Adress bar focus.com
		} Else {
			SendInput, ^e ; or ^k : Search bar focus
		}
		TXT_SendRaw(LOC_Selection)
		SendInPut, {Enter}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Rename image name with Folder.jpg { Ctrl + F | Alt + F } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, Enregistrer l'image ahk_class #32770
^f::
!f::
APP_FolderJpg(A_ThisHotKey == "!f")
Return
#IfWinActive, Save Image ahk_class #32770
^f::
!f::
APP_FolderJpg(A_ThisHotKey == "!f")
Return
#IfWinActive, Sélectionner les fichiers image ahk_class #32770
^f::
!f::
APP_FolderJpg(A_ThisHotKey == "!f")
Return
#IfWinActive

APP_FolderJpg(PRM_MoveToUnknownFolderToo = false) {
	ControlGetFocus, LOC_FocusedControl
	ControlFocus, Edit1
	; SendInput, !n
	If (PRM_MoveToUnknownFolderToo) {
		SendInput, ^a
		Sleep, 50
		SendInput, M:\INCONNU{Enter}
		Sleep, 50
	}
	SendInput, ^a
	Sleep, 50
	SendInput, {Raw}Folder.jpg
	Sleep, 50
	ControlFocus, %LOC_FocusedControl%
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, Confirmer l’enregistrement ahk_class #32770, &Non
Esc:: ; Confirmer l’enregistrement ahk_class #32770, &Non
SendInput, n
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Internet Explorer { Alt + Win [ + Shift ] + I } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_TrayMenuIE:
APP_TrayMenuIE()
Return

APP_TrayMenuIE() {
	WIN_FocusLastWindow()
	APP_IE(, PRM_Selection := TXT_GetSelectedText())
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_IE:
<!#i::
>!#i::
AHK_KeyWait("#!+")
, APP_IE("", TXT_GetSelectedText())
Return

APP_ShiftIE:
<!+#i::
>!+#i::
APP_ShiftIE()
Return

APP_ShiftIE() {
	AHK_KeyWait("#!+")
	, APP_IE("+", TXT_GetSelectedText())
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_IE(PRM_ThisHotKey = false, PRM_Selection = "", PRM_AlreadyLaunchedWarning = true) {

	Global APP_InternetExplorerPath, LOG_DomainEncryptedPassword
	LOC_Selection := Trim(PRM_Selection, " `t`r`n`v`f")
	IfWinExist, Internet Explorer ahk_class IEFrame
	{
		WinActivate
		WinWaitActive, , , 0
		WinShow
		If (PRM_AlreadyLaunchedWarning) {
			TRY_ShowTrayTip("IE already launched", 2)
		}
	} Else {
		If (PRM_ThisHotKey) {
			StringReplace, LOC_Modifiers, PRM_ThisHotKey, % "#i"
			StringReplace, LOC_Modifiers, LOC_Modifiers, % "Browser_Home"
		} Else {
			LOC_Modifiers := ""
		}

		If (LOC_Modifiers == "+") {
			Run, "%APP_InternetExplorerPath%", %A_Desktop%, Max
			TRY_ShowTrayTip("IE launched with full rights")
		} Else {
			APP_RunAs()
			Run, "%A_WinDir%\system32\StripMyRights.exe" "%APP_InternetExplorerPath%", %A_Desktop%, Max
			RunAs
			TRY_ShowTrayTip("IE launched with restricted rights")
		}
		If (LOC_Selection != "") {
			WinWaitActive, Internet Explorer ahk_class IEFrame, , 10
			WinShow
		}
	}
	If (LOC_Selection != ""
		&& WinExist("Internet Explorer ahk_class IEFrame")) {
		SendMessage, 0x111, 1 ; SendInput, ^t : New tab
		StringLower, LOC_LowerSelection, LOC_Selection
		LOC_LowerSelection := Trim(LOC_LowerSelection, "/\ `t`r`n`v`f")
		, LOC_WebSite := A_Is64bitOS
							|| Substr(LOC_LowerSelection, 1, 4) == "http"
							|| Substr(LOC_LowerSelection, 1, 3) == "www"
		If (!LOC_WebSite) {
			LOC_LastDot := InStr(LOC_LowerSelection, ".", true, 0)
			If (LOC_LastDot) {
				LOC_SelectionEnd := SubStr(LOC_LowerSelection, LOC_LastDot + 1)
				, LOC_Length := StrLen(LOC_SelectionEnd)
				, LOC_Extension2 := [ "be", "ch", "de", "es", "eu", "fr", "it", "nl", "pl", "tv", "uk" ]
				, LOC_Extension3 := [ "biz", "com", "org", "net" ]
				, LOC_Extension4 := [ "info" ]
				If (LOC_Extension%LOC_Length%) {
					For LOC_Key, LOC_Extension In LOC_Extension%LOC_Length%
					{
						If (LOC_SelectionEnd == LOC_Extension) {
							LOC_WebSite := true
							Break
						}
					}
				}
			}
		}
		If (LOC_WebSite) {
			SendInput, !d ; Adress bar focus - ControlFocus, Edit1 ?
		} Else {
			SendInput, !d{Tab 2} ; Search bar focus
		}
		TXT_SendRaw(LOC_Selection)
		SendInput, {Enter}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; JMP { Win + J } :
;;;;;;;;;;;;;;;;;;;

APP_JMP:
#j::
If (APP_EclipsePath) {
	APP_Run("JMP", APP_EclipsePath, "-vmargs -Xms768m -Xmx768m -XX:PermSize=256m -XX:MaxPermSize=256m -XX:+CMSPermGenSweepingEnabled -XX:+CMSClassUnloadingEnabled", , , "Java EE - ahk_class SWT_Window0")
} Else {
	HotKey, #j, Off
	HotKey, IfWinActive, - Eclipse ahk_class SWT_Window0
	HotKey, +RButton, Off
	HotKey, ^RButton, Off
	HotKey, IfWinActive, Eclipse ahk_class SWT_Window0
	HotKey, F3, Off
	HotKey, +F3, Off
	HotKey, ^r, Off
	HotKey, ^+f, Off
	HotKey, IfWinActive
	SendInput, #j
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Eclipse commmit { Shift + RightClick } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#IfWinActive, - Eclipse ahk_class SWT_Window0
+RButton::
BlockInput, MouseMove
SendInput, {Click Right}ec ; SendMessage, 0x111, 201 ?
WinWaitActive, Commit Files ahk_class #32770, , 10
SendInput, !f{Shift Up}
BlockInput, MouseMoveOff
Return

^RButton::SendInput, {Click Right}eh
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Eclipse search { [ Shift + ] F3 }, { Ctrl + Shift + F }, { Ctrl + R } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_Eclipse:
#IfWinActive, Eclipse ahk_class SWT_Window0
F3::
SendInput, ^k
Return
+F3::
SendInput, ^+k
Return
^r::
SendInput, ^f
Return
^+f::
SendInput, ^h
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; KGS { Win + K } :
;;;;;;;;;;;;;;;;;;;

APP_KGS:
#k::
If (APP_JavaWebStartPath) {
	APP_KGS()
} Else {
	HotKey, #k, Off
	HotKey, IfWinActive, KGS : Information ahk_class SunAwtFrame
	HotKey, Enter, Off
	HotKey, Esc, Off
	HotKey, IfWinActive, KGS : Nouvelle partie ahk_class SunAwtFrame
	HotKey, Enter, Off
	HotKey, Esc, Off
	SendInput, #k
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_KGS(PRM_Relaunch = false) {

	Global APP_JavaWebStartPath, APP_VisionGoPath, LOG_DomainEncryptedPassword
	LOC_AlreadyLaunched := WinExist("KGS : Salles ahk_class SunAwtFrame")
	If (LOC_AlreadyLaunched) {
		WinActivate
		WinWaitActive, , , 0
		WinShow
		TRY_ShowTrayTip("KGS already launched", 2)
	} Else If (!WinExist("CGoban : Fenêtre Principale ahk_class SunAwtFrame")
			&& !WinExist("KGS : Connexion ahk_class SunAwtFrame")) {
		APP_RunAs()
		Run, "%APP_JavaWebStartPath%" http://files.gokgs.com/javaBin/cgoban-nfa.jnlp, , UseErrorLevel
		RunAs
		WinWait, CGoban : Fenêtre Principale ahk_class SunAwtFrame, , 20
		If (!PRM_Relaunch) {
			Run, "%APP_VisionGoPath%", , UseErrorLevel
			SetTimer, APP_KillVisionGo, -5000
			TRY_ShowTrayTip("KGS launched")
		}
		
	}
	
	CoordMode, Mouse, Screen
	MouseGetPos, LOC_MouseX, LOC_MouseY
	CoordMode, Mouse, Window
	If (!LOC_AlreadyLaunched
		&& LOC_MainWindowID := WinExist("CGoban : Fenêtre Principale ahk_class SunAwtFrame")) {
		WinActivate
		MouseClick, Left, 90, 340, 1, 0
		CoordMode, Mouse, Screen
		MouseMove, LOC_MouseX, LOC_MouseY
		WinWait, KGS : Connexion ahk_class SunAwtFrame, , 5
		
		If (WinExist("KGS : Connexion ahk_class SunAwtFrame")) {
			WinActivate
			SendInput, ^a%A_Username%{Tab}
			Sleep, 50
			SendInput, ^a
			SendInput, {Raw}%LOG_DomainEncryptedPassword%
			SendInput, {Enter}
			If (LOC_MainWindowID) {
				WinWait, KGS : Salles ahk_class SunAwtFrame, , 5
				WinClose, ahk_id %LOC_MainWindowID%
				TRY_ShowTrayTip("KGS main window closed")
			}
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_KillVisionGo:
APP_KillVisionGo()
Return

APP_KillVisionGo() {
	Process, Exist, % "VisionGo.exe"
	LOC_VisionGoPID := ErrorLevel
	If (LOC_VisionGoPID > 0) {
		Process, Exist, % "javaw.exe"
		If (ErrorLevel > 0) {
			SetTimer, APP_KillVisionGo, -1000
		} Else {
			WinKill, ahk_pid %LOC_VisionGoPID%
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, KGS : Information ahk_class SunAwtFrame
Enter:: ; KGS : Information ahk_class SunAwtFrame
Esc:: ; KGS : Information ahk_class SunAwtFrame
SendInput, {Space}
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, KGS : Nouvelle partie ahk_class SunAwtFrame
Enter:: ; KGS : Nouvelle partie ahk_class SunAwtFrame
APP_KGSNewGame(true)
Return
Esc:: ; KGS : Nouvelle partie ahk_class SunAwtFrame
APP_KGSNewGame(false)
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_KGSNewGame(PRM_OKOrClose = true) {
	MouseGetPos, LOC_MouseX, LOC_MouseY
	WinGetPos, LOC_X, LOC_Y, LOC_Width, LOC_Height, A
	If (PRM_OKOrClose) {
		MouseClick, Left, % LOC_X + 15, % LOC_Y + LOC_Height - 15
	} Else {
		MouseClick, Left, % LOC_X + LOC_Width // 2, % LOC_Y + LOC_Height - 15
	}
	MouseMove, LOC_MouseX, LOC_MouseY
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; MediaMonkey { Win + M } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_MediaMonkey:
#m::
If (APP_MediaMonkeyPath) {
	APP_MediaMonkey()
} Else {
	APP_DisableMediaMonkey()
	SendInput, #m
}
Return

APP_DisableMediaMonkey() {
	HotKey, #m, Off
	HotKey, #Space, Off
	HotKey, IfWinActive, MediaMonkey ahk_class TFMainWindow
	HotKey, !Enter, Off
	HotKey, <^>!Enter, Off
	HotKey, !i, Off
	HotKey, <^>!i, Off
	HotKey, <^>!g, Off
	HotKey, <^>!l, Off
	HotKey, ^Delete, Off
	HotKey, ^p, Off
	HotKey, ^!+t, Off
	HotKey, ^i, Off
	HotKey, ^+i, Off
	HotKey, ^+a, Off
	HotKey, IfWinActive, Tags-auto depuis les noms de fichier ahk_class TFChooseMask
	HotKey, !a, Off
	HotKey, <^>!a, Off
	HotKey, !b, Off
	HotKey, <^>!b, Off
	HotKey, !t, Off
	HotKey, <^>!t, Off
	HotKey, !n, Off
	HotKey, <^>!n, Off
	HotKey, !p, Off
	HotKey, <^>!p, Off
	HotKey, !r, Off
	HotKey, <^>!r, Off
	HotKey, IfWinActive, ahk_class TFRenameWithMask
	HotKey, !a, Off
	HotKey, <^>!a, Off
	HotKey, !b, Off
	HotKey, <^>!b, Off
	HotKey, !g, Off
	HotKey, <^>!g, Off
	HotKey, !t, Off
	HotKey, <^>!t, Off
	HotKey, !n, Off
	HotKey, <^>!n, Off
	HotKey, !r, Off
	HotKey, <^>!r, Off
	HotKey, !y, Off
	HotKey, <^>!y, Off
	HotKey, IfWinActive, ahk_class TFSongProperties
	HotKey, !t, Off
	HotKey, <^>!t, Off
	HotKey, !a, Off
	HotKey, <^>!a, Off
	HotKey, !g, Off
	HotKey, <^>!g, Off
	HotKey, !b, Off
	HotKey, <^>!b, Off
	HotKey, !+a, Off
	HotKey, <^>!+a, Off
	HotKey, !n, Off
	HotKey, <^>!n, Off
	HotKey, !y, Off
	HotKey, <^>!y, Off
	HotKey, IfWinActive
}

APP_MediaMonkey() {
	Global APP_MediaMonkeyPath
	Process, Exist, MediaMonkey.exe
	LOC_PID := ErrorLevel
	APP_Run("MediaMonkey", APP_MediaMonkeyPath, "/NoSplash " . APP_AreFilesSelected(), A_MyDocuments, PRM_WindowIdentification = false, PRM_AlreadyLaunchedWarning = false)
	If (!LOC_PID) {
		Loop, 2 {
			LOC_Class := (A_Index == 1 ? "Ghost" : "MMSplash")
			Loop, 10 {
				WinWait, ahk_class %LOC_Class% , , 1
				If (!ErrorLevel) {
					WinGetPos, , , LOC_Width, LOC_Height
					If (LOC_Width == 500
						&& LOC_Height == 200) {
						WinHide
						TRY_ShowTrayTip("MediaMonkey splash screen hidden")
						Break
					}
				}
			}
		}
		Process, Exist, MediaMonkey.exe
		LOC_PID := ErrorLevel
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; MediaMonkey play/pause { Win + Space } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Media_Play_Pause::
APP_MediaMonkeyPlayPause(true)
Return

#Space::
If (APP_MediaMonkeyPath) {
	APP_MediaMonkeyPlayPause()
} Else {
	APP_DisableMediaMonkey()
	SendInput, #{Space}
}
Return

APP_MediaMonkeyPlayPausePostControl:
APP_MediaMonkeyPlayPause(false, true)
Return

APP_MediaMonkeyPlayPause(PRM_Launch = false, PRM_PostControl = false) {

	Static STA_MediaMonkeyID := 0
	If (PRM_PostControl) {
		If (WinExist("MediaMonkey ahk_class #32770", "Access violation at address")) {
			WinClose
			TRY_ShowTrayTip("MediaMonkey access violation notification closed")
			WinGet, LOC_ActiveWindowID, ID, A
			WinActivate, ahk_id %STA_MediaMonkeyID%
			ControlGetFocus, LOC_FocusedConstrol
			ControlFocus, TVirtualStringTree5
			SendInput, {Space}
			ControlFocus, %LOC_FocusedConstrol%
			WinActivate, ahk_id %LOC_ActiveWindowID%
		}
		Return
	}
	
	IfWinActive, MediaMonkey ahk_class TFMainWindow
	{
		SendInput, {Space}
		WinGet, STA_MediaMonkeyID, ID
		AHK_ShowToolTip("MediaMonkey play/pause")
	} Else If (WinExist("MediaMonkey ahk_class TFMainWindow")) {
		WinGet, STA_MediaMonkeyID, ID
		ControlSend, ahk_parent, {Space}
		AHK_ShowToolTip("MediaMonkey play/pause")
		SetTimer, APP_MediaMonkeyPlayPausePostControl, -100
	} Else If (PRM_Launch) {
		GoSub, APP_MediaMonkey
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; MediaMonkey file properties { AltGr + Enter } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#IfWinActive, MediaMonkey ahk_class TFMainWindow
!Enter::
<^>!Enter::
SendInput, {Shift Down}{Enter}{Shift Up}{Ctrl Up}{Alt Up}
Return

; MediaMonkey go to * Inconnu :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
!i::
<^>!i::
SendInput, !l ; go to Playlists
SendInput, *%A_Space%I
Return

<^>!g::SendInput, !g
<^>!l::SendInput, !l

; MediaMonkey playlist cleaner (done straight in the app) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ^Delete::SendInput, ^{Delete}
^Delete::
APP_EmptyListMonkey()
Return

APP_EmptyListMonkey() {
	ControlGetPos, LOC_ControlX, LOC_ControlY, LOC_ControlWidth, LOC_ControlHeight, TVirtualStringTree5
	If (LOC_ControlWidth) {
		CoordMode, Mouse, Screen
		WinGetPos, LOC_WindowX, LOC_WindowY
		MouseGetPos, LOC_MouseX, LOC_MouseY
		MouseClick, Right, LOC_WindowX + LOC_ControlX + LOC_ControlWidth // 2, LOC_WindowY + LOC_ControlY + LOC_ControlHeight // 2
		MouseMove, LOC_MouseX, LOC_MouseY
		Sleep, 50
		SendInput, lv
		AHK_ShowToolTip("MediaMonkey playlist now empty")
	}
}

; MediaMonkey add to playlist starting with 'P' (for Playlist) { Ctrl + P } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
^p::
SendInput, {AppsKey}
Sleep, 10
SendInput, y{Right 3}p{Enter}
Return

; MediaMonkey column filer from clipboard { Ctrl + Alt + Shift + T } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
^!+t::
APP_ColumnFilerMonkey()
Return

APP_ColumnFilerMonkey() {
	
	Global AHK_ScriptInfo
	LOC_WindowID := WinActive("A")
	MsgBox, 4147, MediaMonkey Auto-filling - %AHK_ScriptInfo%, To proceed the auto-filling, you must have :`n   - first copied your text values into the clipboard,`n   - then selected the first row to fill in MediaMonkey.`n`nContinue to proceed ? ; Exclamation, Yes/No/Cancel buttons & modal
	IfMsgBox, Yes
	{
		WinActivate, ahk_id %LOC_WindowID%
		WinWaitActive
		LOC_Values := Clipboard
		LOC_FirstValue := true
		, LOC_Count := 0
		Loop, Parse, LOC_Values, `n`v`f, `r
		{
			
			If (LOC_WindowID != WinActive("A")) {
				Return
			}
			LOC_Value := Trim(A_loopfield)
			If (LOC_Value == "") {
				Continue
			}
			If (LOC_FirstValue) {
				SendInput, {Down}{Up}
				LOC_FirstValue := false
			} Else {
				SendInput, {Down}
				Sleep, 10
				LOC_Count++
			}
			Sleep, 10
			SendInput, {Esc}{F2}
			Sleep, 10
			SendInput, {Raw}%LOC_Value%
			Sleep, 10
			SendInput, {Enter 2}
		}
		If (LOC_Count) {
			SendInput, {Up %LOC_Count%}
		}
	}
}

; MediaMonkey image auto-adding (Folder.jpg is supposed to be placed in the folder of the selected songs) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
^i::
^+i::
APP_MonkeyImage()
Return

APP_MonkeyImage() {
	; Display properties :
	SendInput, +{Enter}
	WinWaitActive, ahk_class TFSongProperties, , 1
	If (ErrorLevel) {
		Return
	}
	
	; Select image tab :
	SendInput, !u
	Sleep, 100
	While (WinExist("Information ahk_class TMessageFormPlus", "Annuler")) {
		Sleep, 100
	}
	
	; Display file selection dialog :
	ControlFocus, TButtonPlus2, A
	Sleep, 50
	SendInput, {Space}
	WinWaitActive, Sélectionner les fichiers image ahk_class #32770, , 5
	If (ErrorLevel) {
		Return
	}
	
	; Select Folder.jpg :
	ControlFocus, Edit1
	Sleep, 50
	SendInput, ^a
	Sleep, 150
	SendInput, {Raw}Folder.jpg
	Sleep, 50
	ControlFocus, Button2
	Sleep, 50
	SendInput, {Space}
	
	; Validate image-adding :
	WinWaitActive, Ajouter une illustration ahk_class TFCover, , 5
	If (ErrorLevel) {
		If (WinExist("Sélectionner les fichiers image ahk_class #32770")) {
			SendInput, {Esc}
		}
		Return
	}
	ControlFocus, TButtonPlus2
	SendInput, {Enter}
	
	; Close properties dialog
	WinWaitActive, ahk_class TFSongProperties, , 5
	If (ErrorLevel) {
		Return
	}
	SendInput, {Tab 3}
	Sleep, 50
	ControlFocus, TButtonPlus4
	Sleep, 50
	SendInput, {Enter}
}

; MediaMonkey volume adjustment auto-confirmation :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
~^+a::
APP_MediaMonkeyVolumeAdjustment()
Return

APP_MediaMonkeyVolumeAdjustment() {
	WinWaitActive, Confirmation ahk_class TMessageFormPlus, &Oui, 1
	If (!ErrorLevel) {
		SendInput, {Alt Down}o{Alt Up}
	}
}
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; MediaMonkey file tagger :
;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, Tags-auto depuis les noms de fichier ahk_class TFChooseMask
!a::
<^>!a::
SendInput, <Artiste>
Return
!b::
<^>!b::
SendInput, <Album>
Return
!t::
<^>!t::
SendInput, <Titre>
Return
!n::
<^>!n::
SendInput, <Piste n°>
Return
!p::
<^>!p::
SendInput, <Passer>
Return
!r::
<^>!r::
SendInput, <Répertoire>
Return
#IfWinActive

#IfWinActive, ahk_class TFRenameWithMask
!a::
<^>!a::
SendInput, <Artiste>
Return
!b::
<^>!b::
SendInput, <Album>
Return
!g::
<^>!g::
SendInput, <Genre>
Return
!t::
<^>!t::
SendInput, <Titre>
Return
!n::
<^>!n::
SendInput, <Piste n°>
Return
!r::
<^>!r::
SendInput, <Répertoire>
Return
!y::
<^>!y::
SendInput, <Année>
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, ahk_class TFSongProperties
!t:: ; title
<^>!t::
SendInput, {Alt Down}p{Alt Up}{Alt Down}b{Alt Up}
ControlFocus, TEditPlus8
Return
!a:: ; artist
<^>!a::
SendInput, {Alt Down}p{Alt Up}{Alt Down}b{Alt Up}
ControlFocus, TComboBoxPlus7
Return
!g:: ; style
<^>!g::
SendInput, {Alt Down}p{Alt Up}{Alt Down}b{Alt Up}
ControlFocus, TComboBoxPlus5
Return
!b:: ; album
<^>!b::
SendInput, {Alt Down}p{Alt Up}{Alt Down}b{Alt Up}
ControlFocus, TComboBoxPlus6
Return
!+a:: ; album artist
<^>!+a::
SendInput, {Alt Down}p{Alt Up}{Alt Down}b{Alt Up}
ControlFocus, TComboBoxPlus4
Return
!n:: ; track number
<^>!n::
SendInput, {Alt Down}p{Alt Up}{Alt Down}b{Alt Up}
ControlFocus, TEditPlus6
Return
!y:: ; year
<^>!y::
SendInput, {Alt Down}p{Alt Up}{Alt Down}b{Alt Up}
ControlFocus, TEditPlus7
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Notes { Win + N } :
;;;;;;;;;;;;;;;;;;;;;

APP_Notes:
#n::
; APP_Run("Notes", A_WinDir . "\system32\StikyNot.exe")
APP_RunAs()
Run, %A_WinDir%\system32\StikyNot.exe
RunAs
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; XAMPP { Win + P } :
;;;;;;;;;;;;;;;;;;;;;
APP_XAMPP:
#p::
If (APP_ApachePath && APP_MySQLPath) {
	APP_XAMPP()
} Else {
	HotKey, #p, Off
	SendInput, #p
}
Return

APP_XAMPP() {
	Global APP_ApachePath, APP_MySQLPath
	SplitPath, APP_ApachePath, LOC_ProcessName
	Process, Exist, %LOC_ProcessName%
	LOC_ApachePID := ErrorLevel
	SplitPath, APP_MySQLPath, LOC_ProcessName
	Process, Exist, %LOC_ProcessName%
	LOC_MySQLPID := ErrorLevel
	If (LOC_ApachePID && LOC_MySQLPID) {
		Process, Close, %LOC_ApachePID%
		Process, Close, %LOC_MySQLPID%
		TRY_ShowTrayTip("Apache stopped")
	} Else {
		If (!LOC_ApachePID) {
			Run, %APP_ApachePath%, , Hide UseErrorLevel
		}
		If (!LOC_MySQLPID) {
			Run, %APP_MySQLPath%, , Hide UseErrorLevel
		}
		TRY_ShowTrayTip("Apache launched")
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; PuTTY Connection Manager { Win + P } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_PuTTY:
; #p::
APP_Run("PuTTY", A_ProgramFiles . "\PuTTY Connection Manager\puttycm.exe")
Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; PuTTY { Ctrl + V }, { Delete } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, ahk_class PuTTY
Delete::
SendInput, {Right}{Backspace} ; Delete key in PuTTY
Return
RButton::
APP_ConsolePaste()
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Performances { Ctrl + Win + P } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_Performances:
^#p::
APP_Run("Performances", A_WinDir . "\system32\mmc.exe", """" . A_WinDir . "\system32\perfmon.msc""", A_WinDir . "\system32", , "Analyseur de performances ahk_class MMCMainFrame", , false)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; SQL Developer or Quintessential { Win + Q } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_SQL:
#q::
If (!APP_Run("Quintessential", APP_QuintessentialPath, APP_AreFilesSelected(), , false)) {
	SetTimer, TRY_HideTrayTipTimer, -1
	APP_Run("SQL Developer", APP_SQLDeveloperPath)
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, SQL Developer ahk_class SunAwtFrame
F5::
SendInput, ^r
Return

#IfWinActive, ahk_group WIN_QuintessentialGroup
Space:: ; play/pause
APP_QintessentialSpace()
Return

Left:: ; 5s forward
Right:: ; 5s backward
ControlSend, ahk_parent, {%A_ThisHotkey%}, ahk_class PlayerCanvas
WinActivate, ahk_class PlayerCanvas
Return

+Left:: ; 30s backward
ControlSend, ahk_parent, {Left 6}, ahk_class PlayerCanvas
WinActivate, ahk_class PlayerCanvas
Return

+Right:: ; 30s forward
ControlSend, ahk_parent, {Right 6}, ahk_class PlayerCanvas
WinActivate, ahk_class PlayerCanvas
Return

<^>!Left:: ; previous track
ControlSend, ahk_parent, w, ahk_class PlayerCanvas
WinActivate, ahk_class PlayerCanvas
Return

<^>!Right:: ; next track
ControlSend, ahk_parent, e, ahk_class PlayerCanvas
WinActivate, ahk_class PlayerCanvas
Return

^Left:: ; slow down
APP_ChronotronControl(true, false)
Return
^Right:: ; speed up
APP_ChronotronControl(true, true)
Return
^Up:: ; tune up
APP_ChronotronControl(false, true)
Return
^Down:: ; tune down
APP_ChronotronControl(false, false)
Return

Insert:: ; A-B repeat
APP_QuintessentialABRepeat()
Return

#IfWinActive

APP_QuintessentialABRepeat() {
	If (WinExist("A-B Repeat ahk_class #32770")) {
		WinGet, LOC_ActiveWindowID, ID, A
		WinActivate
		ControlFocus, Button1
		SendInput, {Space}
		WinActivate, ahk_id %LOC_ActiveWindowID%
	}
}

APP_ChronotronControl(PRM_Speed = true, PRM_Up = true) {
	If (WinExist("ahk_class Chronotron Plugin ahk_class TModuleForm")) {
		WinGet, LOC_ActiveWindowID, ID, A
		WinActivate
		CoordMode, Mouse, Window
		MouseGetPos, LOC_MouseX, LOC_MouseY
		MouseClick, Left, (PRM_Up ? 320 : 55), (PRM_Speed ? 120 : 70), (PRM_Speed ? 50 : 100)
		MouseMove, LOC_MouseX, LOC_MouseY
		WinActivate, ahk_id %LOC_ActiveWindowID%
	}
}

APP_QintessentialSpace() {
	If (WinExist("ahk_class PlayerCanvas")) {
		WinGet, LOC_ActiveWindowID, ID, A
		WinActivate
		LOC_ButtonX := 35,
		LOC_ButtonY := 190
		CoordMode, Mouse, Screen
		WinGetPos, LOC_X, LOC_Y, LOC_Width, LOC_Height, ahk_class PlayerCanvas
		If (LOC_Width == ""
			|| LOC_Width < LOC_ButtonX
			|| LOC_Height < LOC_ButtonY) {
			Return
		}
		MouseGetPos, LOC_MouseX, LOC_MouseY
		MouseClick, Left, LOC_X + LOC_ButtonX, LOC_Y + LOC_ButtonY
		MouseMove, LOC_MouseX, LOC_MouseY
		WinActivate, ahk_id %LOC_ActiveWindowID%
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Command prompt { Win + R } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_Console:
#r::
Suspend, Permit
APP_Console()
Return

; CygWin :
APP_CygWin:
!#r::
Suspend, Permit
APP_Console(true)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_Console(PRM_CygWin = false) {

	Suspend, Permit
	Global ZZZ_ProgramFiles64
	KeyWait, LWin
	KeyWait, RWin
	AHK_SetCursor("AppliStarting")

	; Set working directory :
	LOC_DefaultDirectory := A_WinDir . "\system32"
	If (WinActive("ahk_class ExploreWClass")
		|| WinActive("ahk_class CabinetWClass")) { ; Windows explorer
		Try {
			ControlGetText, LOC_WorkingDirectory, Edit1
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "APP_Console")
			LOC_WorkingDirectory := ""
		}
	} Else If WinActive("ahk_class dopus.lister") {
		Try {
			ControlGetText, LOC_WorkingDirectory, dopus.ctl.treepath1
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "APP_Console")
			LOC_WorkingDirectory := ""
		}
		If (LOC_WorkingDirectory == "Poste de travail") {
			LOC_WorkingDirectory := LOC_DefaultDirectory
		}
	} Else {
		LOC_WorkingDirectory := (WinActive("Program Manager ahk_class Progman") ? A_Desktop : LOC_DefaultDirectory)
	}
	If (SubStr(LOC_WorkingDirectory, 1, 2) == "\\"
		|| InStr(SubStr(LOC_WorkingDirectory, 6), "FTP://")) {
		LOC_WorkingDirectory := LOC_DefaultDirectory
	}
	
	; CygWin :
	If (PRM_CygWin && APP_CygWinPath) {
			Run, "%APP_CygWinPath%" --icon /Cygwin-Terminal.ico --title "%LOC_Title%", %LOC_WorkingDirectory%, UseErrorLevel, LOC_CygWinPID
		If (ErrorLevel == "ERROR") {
			TRY_ShowTrayTip("CygWin not launched", 3)
		} Else {
			WinWait, ahk_pid %LOC_CygWinPID%, , 5
			IfWinExist, ahk_pid %LOC_CygWinPID%
			{
				SendInput, {Raw}cd "%LOC_WorkingDirectory%"; PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'; clear`n
			}
		}
		Return
	}
	
	RegRead, LOC_HKLMAutoRun, HKEY_LOCAL_MACHINE, Software\Microsoft\Command Processor, AutoRun
	RegRead, LOC_HKCUAutoRun, HKEY_CURRENT_USER, Software\Microsoft\Command Processor, AutoRun
	If (FileExist(A_ScriptDir . "\bin\AnsiCon.exe")) {
		LOC_AnsiCon := A_ScriptDir . "\bin\AnsiCon.exe"
	} Else {
		LOC_AnsiCon := ""
	}

	; Extended console :
	If (FileExist(A_ScriptDir . "\bin\Console.exe")) {
		LOC_AlternateConsoleID := WinExist("ahk_class Console_2_Main")
		
		; Extended Console already launched :
		If (LOC_AlternateConsoleID) {
			WinActivate
			If (LOC_WorkingDirectory) {
				LOC_AutoRun := "cd /d """ . LOC_WorkingDirectory . """ && "
				StringGetPos, LOC_BackSlashLastPos, LOC_WorkingDirectory, \, R
				If (LOC_BackSlashLastPos < StrLen(LOC_WorkingDirectory) - 1) {
					 LOC_AutoRun .= "title " . SubStr(LOC_WorkingDirectory, LOC_BackSlashLastPos + 2) . " && cls"
				} Else {
					LOC_AutoRun .= "title " . LOC_WorkingDirectory . " && cls"
				}
				RegWrite, REG_SZ, HKEY_LOCAL_MACHINE, Software\Microsoft\Command Processor, AutoRun, %LOC_AutoRun%
				RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\Microsoft\Command Processor, AutoRun, %LOC_AutoRun%
				TRY_ShowTrayTip("Console launched")
			}
			; PostMessage, 0x111, 2000 ; SendInput, {F3} : New Console tab
			SendInput, {F3}
			Sleep, 50
			SetKeyDelay, 30
			LOC_LastSlahPos := InStr(LOC_WorkingDirectory, "\", , -1)
			LOC_Title := (LOC_LastSlahPos ? SubStr(LOC_WorkingDirectory, LOC_LastSlahPos + 1) : LOC_WorkingDirectory)
			SendPlay, {Raw}cd "%LOC_WorkingDirectory%" && title %LOC_Title% && cls`n
			SetKeyDelay, -1
		} Else {
			
		; Extended Console to launch :
			StringGetPos, LOC_BackSlashLastPos, LOC_WorkingDirectory, \, R
			If (LOC_BackSlashLastPos < StrLen(LOC_WorkingDirectory) - 1) {
				LOC_Title := SubStr(LOC_WorkingDirectory, LOC_BackSlashLastPos + 2)
			} Else {
				LOC_Title := LOC_WorkingDirectory
			}
			If (LOC_WorkingDirectory) {
				RegWrite, REG_SZ, HKEY_LOCAL_MACHINE, Software\Microsoft\Command Processor, AutoRun, title %LOC_Title%
				RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\Microsoft\Command Processor, AutoRun, title %LOC_Title%
			}
			Run, % (LOC_AnsiCon ? """" . LOC_AnsiCon . """ """ : "") . A_ScriptDir . "\bin\Console.exe"" -t " . (LOC_CygWin ? "CygWin" : "Console") . (LOC_WorkingDirectory != "" ? " -d """ . LOC_WorkingDirectory . """ -w """ . LOC_Title . """" : ""), %A_ScriptDir%\bin, Min UseErrorLevel
			If (ErrorLevel == "ERROR") {
				AHK_Debug((LOC_AnsiCon ? """" . LOC_AnsiCon . """ """ : "") . A_ScriptDir . "\bin\Console.exe"" -t " . (LOC_CygWin ? "CygWin" : "Console") . (LOC_WorkingDirectory != "" ? " -d """ . LOC_WorkingDirectory . """ -w """ . LOC_Title . """" : ""), 3)
			} Else {
				WinWaitActive, ahk_class Console_2_Main, , 5
				TRY_ShowTrayTip("Console launched")
			}
		}
	
	} Else {
		; Usual console :
		If (LOC_WorkingDirectory) {
			RegWrite, REG_SZ, HKEY_LOCAL_MACHINE, Software\Microsoft\Command Processor, AutoRun, title %LOC_WorkingDirectory%
			RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\Microsoft\Command Processor, AutoRun, title %LOC_WorkingDirectory%
		}
		If (LOC_CygWin) {
			Run, "%APP_CygwinPath%" --icon /Cygwin-Terminal.ico --title "%LOC_Title%", %LOC_WorkingDirectory%, UseErrorLevel, LOC_CygWinPID
			If (ErrorLevel == "ERROR") {
				TRY_ShowTrayTip("CygWin not launched", 3)
			} Else {
				WinWait, ahk_pid %LOC_CygWinPID%, , 5
				IfWinExist, ahk_pid %LOC_CygWinPID%
				{
					SendInput, {Raw}cd "%LOC_WorkingDirectory%"; PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'; clear`n
				}
			}
		} Else {
			APP_Run("Console", LOC_AnsiCon, """" . A_WinDir . "\system32\cmd.exe""")
			WinWait, ahk_class ConsoleWindowClass, , 5
		}
		TRY_ShowTrayTip("Console launched")
	}
	
	If (LOC_WorkingDirectory) {
		RegWrite, REG_SZ, HKEY_LOCAL_MACHINE, Software\Microsoft\Command Processor, AutoRun, %LOC_HKLMAutoRun%
		RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\Microsoft\Command Processor, AutoRun, %LOC_HKCUAutoRun%
	}
	AHK_ResetCursor()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Command prompt combinaisons { Ctrl + V }, { Ctrl + D }, { Alt + F4 }, { Middle-Click } :
;;;;;;;;;;;;;;;;;;;::::::::;;;;;;;::;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, ahk_class ConsoleWindowClass
^d::
!F4::
WinClose, A
AUD_Beep()
Return

RButton::
APP_ConsoleRButton()
Return

APP_ConsoleRButton() {
	MouseGetPos, , , , LOC_Control
	If (Substr(LOC_Control, 1, 14) == "Console_2_View") {
		APP_ConsolePaste()
	} Else {
		MouseClick, Right
	}
}
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, ahk_class Console_2_Main
^c::SendInput, {Esc}

^d::
SendMessage, 0x111, 32779 ; SendInput, {Ctrl Down}{F4}{Ctrl Up}
AUD_Beep()
Return

RButton::
APP_ConsolePaste()
Return

Up::
Down::
SendInput, {F8}
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_ConsolePaste() {
	CoordMode, Mouse, Screen
	MouseGetPos, , , LOC_WindowID
	If (WinActive("ahk_id " . LOC_WindowID)) {
		TXT_PasteManager()
	} Else {
		WinActivate, ahk_id %LOC_WindowID%
		WinWaitActive, ahk_id %LOC_WindowID%, , 0
		MouseClick, Right
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Registry { Ctrl + Win + R } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_Registry:
^#r::
APP_Registry()
Return

APP_Registry() {
	Global APP_RegistryManagerPath
	LOC_Selection := Trim(TXT_GetSelectedText(), " `t`r`n`v`f")
	, LOC_IsRegistryKey := false
	If (LOC_Selection != "") {
		LOC_Selection := RegExReplace(LOC_Selection, "[ \t\r\n]*[\\/]{1,}[ \t\r\n]*", "\")
		LOC_FirstSlash := InStr(LOC_Selection, "\", false)
		If (LOC_FirstSlash) {
			LOC_Abreviations := { "HKLM" : "HKEY_LOCAL_MACHINE"
				, "HKCU" : "HKEY_CURRENT_USER"
				, "HKCR" : "HKEY_CLASSES_ROOT"
				, "HKU" : "HKEY_USERS"
				, "HKCC" : "HKEY_CURRENT_CONFIG" }
			, LOC_IsRegistryKey := false
			, LOC_Indicator := SubStr(LOC_Selection, 1, LOC_FirstSlash - 1)
			StringUpper, LOC_Indicator, LOC_Indicator
			For LOC_Key, LOC_Name In LOC_Abreviations
			{
				If (LOC_Indicator == LOC_Key) {
					LOC_Selection := LOC_Name . SubStr(LOC_Selection, LOC_FirstSlash)
					, LOC_IsRegistryKey := true
					Break
				}
				If (LOC_Indicator == LOC_Name) {
					LOC_IsRegistryKey := true
					Break
				}
			}
		}
	}
	If (APP_RegistryManagerPath) {
		LOC_AlreadyLaunched := WinExist("Registrar Registry Manager ahk_class TAppForm")
		If (!LOC_AlreadyLaunched) {
			APP_Run("Registry", APP_RegistryManagerPath)
			WinWait, Registrar Home Edition Notice ahk_class TNagForm, , 5
			If (!ErrorLevel) {
				WinActivate
				CoordMode, Mouse, Relative
				MouseClick, , 566, 567
			}
		}
		If (LOC_IsRegistryKey) {
			WinWait, Registrar Registry Manager ahk_class TAppForm, , 5
			If (!ErrorLevel) {
				WinActivate
				WinWaitActive, , , 0
				SendInput, {Esc 2}
				ControlFocus, Edit1
				SendInput, {Raw}%LOC_Selection%
				SendInput, {Enter}
				WinActivate, Registry and Tool Windows ahk_class TEditDockForm
				WinWaitActive, , , 0
				SendInput, {Esc 2}
				ControlFocus, Edit3
				SendInput, {Raw}%LOC_Selection%
				SendInput, {Enter}
			}
		}
	} Else {
		If (LOC_IsRegistryKey) {
			RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Applets\Regedit, LastKey, Ordinateur\%LOC_Selection%
		}
		APP_Run("Registry", A_WinDir . "\regedit.exe", , A_WinDir, , "ahk_class RegEdit_RegEdit")
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Startup Delayer { Win + S } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_StartupDelayer:
#s::
If (APP_StartupDelayerPath) {
	APP_Run("Startup Delayer", APP_StartupDelayerPath, , A_WinDir . "\system32", , "Startup Delayer ahk_class WindowsForms10.Window.8.app.0.11ecf05")
} Else {
	APP_Run("Services", A_WinDir . "\system32\mmc.exe", """" . A_WinDir . "\system32\services.msc""", A_WinDir . "\system32", , "Services ahk_class MMCMainFrame")
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Services { Ctrl + Win + S } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_Services:
^#s::
APP_Run("Services", A_WinDir . "\system32\mmc.exe", """" . A_WinDir . "\system32\services.msc""", A_WinDir . "\system32", , "Services ahk_class MMCMainFrame")
Return

#IfWinActive, Services ahk_class MMCMainFrame
Insert:: ; Start service
SendInput, {AppsKey}{Down}{Enter}
Return
Delete:: ; Stop service
SendInput, {AppsKey}{Down 2}{Enter}
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Thunderbird { Win + T } [ Ctrl : Safe-mode ] [ Shift : Full rights ] :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_TrayMenuMail:
APP_TrayMenuMail()
Return

APP_TrayMenuMail() {
	WIN_FocusLastWindow()
	APP_MailManager(, PRM_Selection := TXT_GetSelectedText())
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#t::
+#t::
; ^#t:: ; already used by Planned tasks
; ^+#t:: ; already used by Tooltips option
APP_Mail()
Return

APP_Mail() {
	AHK_KeyWait("#^+")
	, APP_MailManager(A_ThisHotKey, PRM_Selection := TXT_GetSelectedText())
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_NewMailComposerTimer:
APP_NewMailComposerTimer()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_NewMailComposerTimer(PRM_Body = "") {
	Static STA_Body := "", STA_TimeUp := 30
	If (PRM_Body) {
		STA_Body := PRM_Body
		, STA_TimeUp := 30
	}
	IfWinExist, Rédaction : NewAHKMailComposer ahk_class MozillaWindowClass ; Thunderbird
	{
		WinActivate
		WinWaitActive, , , 3
		WinShow
		Sleep, 150
		SendInput, {Tab}{Delete}{Tab}
		Sleep, 150
		TXT_PasteManager(, STA_Body)
		SendInput, {Ctrl Down}{Home}{Tab 2}{Ctrl Up}
		STA_Body := ""
	} Else IfWinExist, NewAHKMailComposer - Message ahk_class OpusApp ; Outlook
	{
		WinActivate
		WinWaitActive, , , 3
		WinShow
		Sleep, 150
		SendMessage, 0xC, 0, "", RichEdit20WPT8 ; Reset object
		SendInput, {Tab 3}
		TXT_PasteManager(, STA_Body)
		SendInput, ^{Home}
		Sleep, 150
		SendInput, {Shift Down}{Tab 3}{Shift Up}
		ControlFocus, RichEdit20WPT5
		STA_Body := ""
	} Else {
		STA_TimeUp--
		If (STA_TimeUp > 0) {
			SetTimer, APP_NewMailComposerTimer, -100 ; Checks existence of a mail composer window
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_MailManager(PRM_ThisHotKey = false, PRM_Selection = "", PRM_AlreadyLaunchedWarning = true) {

	Global APP_MailApplicationPath, LOG_DomainEncryptedPassword
	; APP_MailApplicationPath == Mozilla Thunderbird\thunderbird.exe
	; APP_MailApplicationPath == Microsoft Office\OFFICE11\OUTLOOK.EXE
	If (APP_MailApplicationPath == "") {
		TRY_ShowTrayTip("No mail application found", 3)
		Return
	}

	SplitPath, APP_MailApplicationPath, , , , LOC_MailApplicationName
	StringLower, LOC_MailApplicationName, LOC_MailApplicationName, T
	If (LOC_MailApplicationName == "Thunderbird") {
		LOC_MailApplicationTitle := "Mozilla Thunderbird ahk_class MozillaWindowClass"
	} Else If (LOC_MailApplicationName == "Outlook") {
		LOC_MailApplicationTitle := "- Microsoft Outlook ahk_class rctrl_renwnd32"
	}

	IfWinExist, %LOC_MailApplicationTitle%
	{
		If (PRM_Selection) {
			Run, "mailto:?subject=NewAHKMailComposer"
			APP_NewMailComposerTimer(PRM_Selection)
		} Else {
			WinActivate
			WinWaitActive, , , 0
			WinShow
			If (PRM_AlreadyLaunchedWarning) {
				TRY_ShowTrayTip(LOC_MailApplicationName . " already launched", 2)
			}
		}
	} Else {
		If (PRM_ThisHotKey) {
			StringReplace, LOC_Modifiers, A_ThisHotKey, % "#t"
			StringReplace, LOC_Modifiers, LOC_Modifiers, % "Launch_Mail"
		} Else {
			LOC_Modifiers := ""
		}
		If (LOC_Modifiers == "") {
			APP_RunAs()
			Run, "%A_WinDir%\system32\StripMyRights.exe" "%APP_MailApplicationPath%", %A_Desktop%, Max UseErrorLevel
		} Else If (LOC_Modifiers == "+") {
			Run, "%APP_MailApplicationPath%", %A_Desktop%, Max UseErrorLevel
		} Else If (LOC_Modifiers == "^") {
			APP_RunAs()
			Run, "%A_WinDir%\system32\StripMyRights.exe" "%APP_MailApplicationPath%" "-safe-mode", %A_Desktop%, Max UseErrorLevel
		} Else If (LOC_Modifiers == "^+") {
			Run, "%APP_MailApplicationPath%" "-safe-mode", %A_Desktop%, Max UseErrorLevel
		}
		If (ErrorLevel == "ERROR") {
			TRY_ShowTrayTip(LOC_MailApplicationName . " not launched", 3)
		} Else {
			TRY_ShowTrayTip(LOC_MailApplicationName . " launched" . (InStr(LOC_Modifiers, "^") ? " in safe mode" : "") . (InStr(LOC_Modifiers, "+") ? " with full rights" : " with restricted rights"))
			If (PRM_Selection) {
				Sleep, 5000
				Run, "mailto:?subject=NewAHKMailComposer"
				APP_NewMailComposerTimer(PRM_Selection)
			}
		}
		RunAs
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Thunderbird { Ctrl + G }, { Ctrl + K }, {ˆ + _ } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, Rédaction ahk_class MozillaWindowClass

^l:: ; hyperlink
SendInput, ^k
Return

^g:: ; bold
SendInput, ^b
Return

NumpadSub:: ; line separator
SendInput, {AltDown}i
Sleep, 50
SendInput, g{AltUp}
Return

^Enter:: ; do not send mail
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, ahk_class MozillaWindowClass
^WheelUp::
SendInput, ^{NumpadAdd}
Return
^WheelDown::
SendInput, ^{NumpadSub}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, Modifier l'événement ahk_class MozillaDialogClass
+Enter::
SendInput, ^l
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, Modifier l'évènement ahk_class MozillaDialogClass
+Enter::
SendInput, ^l
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, Nouvel événement ahk_class MozillaDialogClass
+Enter::
SendInput, ^l
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, Nouvel évènement ahk_class MozillaDialogClass
+Enter::
SendInput, ^l
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Office hyperlink {Ctrl + L } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#IfWinActive, ahk_class OpusApp
^l::
SendInput, ^k
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; OutLook Reminder Repeat { Insert on Event }             :
; OutLook Reminder Repeat All { Shift + Click on Repeat } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, Rappel ahk_class #32770, Cliquez sur Répéter pour recevoir un rappel dans
Insert::
NumpadIns::
Numpad0::
APP_OutlookReminderRepeat()
Return

+LButton::
+Insert::
APP_OutlookReminderRepeatAll(A_ThisHotKey)
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_OutlookReminderRepeat() {
	ControlGetFocus, LOC_ControlClass
	If (LOC_ControlClass == "SysListView321") { ; Task list
		ControlFocus, Button5
		Sleep, 80
		SendInput, {Space}
		Sleep, 80
		ControlFocus, SysListView321
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_OutlookReminderRepeatAll(PRM_ThisHotKey = "+Insert") {

	MouseGetPos, , , , LOC_ControlClass
	If (LOC_ControlClass == "Button5" ; Repeat button
		|| PRM_ThisHotKey == "+Insert") {
		ControlFocus, REComboBox20W1
		LOC_SnoozeTime := TXT_GetSelectedText()
		ControlFocus, SysListView321
		Sleep, 80
		SendInput, {Ctrl Down}{Home}{Ctrl Up}{Down}{Up}{Ctrl Down}{Shift Down}{End}{Shift Up}{Ctrl Up} ; Select all tasks
		Sleep, 80
		ControlFocus, REComboBox20W1
		SendInput, {Raw}%LOC_SnoozeTime%
		Sleep, 80
		ControlFocus, Button5
		Sleep, 80
		SendInput, {Space}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Outlook mark as read :
;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, Microsoft Outlook ahk_class rctrl_renwnd32
+RButton::
^RButton::
APP_OutlookMarkAsRead()
Return

APP_OutlookMarkAsRead() {
	MouseGetPos, , , , LOC_ControlClass
	If (LOC_ControlClass == "NetUIHWND1") { ; Folder tree
		SendInput, {LButton}{Alt Down}e{Alt Up}m{Esc}
		Return
	}
	If (LOC_ControlClass == "SUPERGRID1") { ; Mail list
		SendInput, {Alt Down}e{Alt Up}l{Esc}
		Return
	}
	SendInput, {Shift Down}{RButton}{Shift Up}
}
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_Tasks:
^#t::
APP_Run("Task scheduler", A_WinDir . "\system32\mmc.exe", """" . A_WinDir . "\system32\taskschd.msc""", A_WinDir . "\system32", , "Planificateur de tâches ahk_class MMCMainFrame", , false)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Ultra Edit / Notepad++ { Win + U } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_UltraEdit:
#u::
AHK_KeyWait("#")
APP_UltraEdit()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_UltraEdit() {

	Global APP_TextEditorPath
	
	If (InStr(APP_TextEditorPath, "UltraEdit")) {
		LOC_ProgramName := "UltraEdit"
	} Else If (InStr(APP_TextEditorPath, "notepad++")) {
		LOC_ProgramName := "Notepad++"
	}

	LOC_Selection := TXT_GetSelectedText()
	, LOC_FilesParameters := APP_AreFiles(LOC_Selection)

	Process, Exist, %LOC_ProcessName%
	LOC_PID := ErrorLevel
	If (LOC_PID > 0
		&& (LOC_WindowID := WinExist(LOC_ProgramName))) {
		WinActivate
		WinWaitActive, ahk_id %LOC_WindowID%, , 0
		WinShow
		If (LOC_FilesParameters) {
			Run, "%APP_TextEditorPath%" %LOC_FilesParameters%, , Max UseErrorLevel
		} Else If (LOC_Selection) {
			SendInput, ^n ; PostMessage, 0x111, 57649 ?
			Sleep, 1000
			TXT_PasteManager(, LOC_Selection)
			SendInput, ^{Home}
		} Else {
			TRY_ShowTrayTip(LOC_ProgramName . " already launched", 2)
		}
		Return
	}

	Try {
		Run, "%APP_TextEditorPath%" %LOC_FilesParameters%, , Max UseErrorLevel
	} Catch LOC_Exception {
		AHK_Catch(LOC_Exception, "APP_UltraEdit")
		, TRY_ShowTrayTip(LOC_ProgramName . " not launched", 3)
		Return
	}
	WinWait, %LOC_ProgramName%, , 10
	WinGet, LOC_WindowID, ID
	WinActivate
	WinWaitActive, ahk_id %LOC_WindowID%, , 0
	WinShow
	If (LOC_Selection
		&& !LOC_FilesParameters) {
		ControlSend, ahk_parent, ^n
		Sleep, 150
		TXT_PasteManager(, LOC_Selection)
	}
	TRY_ShowTrayTip(LOC_ProgramName . " launched")
}

#IfWinActive, UltraEdit
WheelDown::
WheelUp::
WheelLeft::
^WheelUp::
WheelRight::
^WheelDown::
APP_UltraEditWheel(A_ThisHotKey)
Return
#IfWinActive

APP_UltraEditWheel(PRM_HotKey) {
	WinGet, LOC_UltraEditID, ID, A
	CoordMode, Mouse, Screen
	MouseGetPos, , , LOC_HoveredWindowID
	If (SubStr(PRM_HotKey, 1, 1) == "^") {
		LOC_Prefix := "^"
		, LOC_Direction := SubStr(PRM_HotKey, 7)
	} Else {
		LOC_Prefix := ""
		, LOC_Direction := SubStr(PRM_HotKey, 6)
	}
	
	If (LOC_HoveredWindowID == LOC_UltraEditID) {
		SendInput, %LOC_Prefix%{Wheel%LOC_Direction%}
	} Else {
		If (LOC_Prefix) {
			If (LOC_Direction == "Up") {
				SYS_WheelLeft()
			} Else {
				SYS_WheelRight()
			}
		} Else {
			SYS_Wheel%LOC_Direction%()
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; µTorrent { Win + µ } :
;;;;;;;;;;;;;;;;;;;;;;;;

APP_muTorrent:
#SC02B::
+#SC02B::
APP_Run("µTorrent", APP_uTorrentPath)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Video converter { Win + V } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
APP_Video:
#v::
APP_Run("Video Converter", APP_VideoConverterPath, APP_AreFilesSelected(), , false, , false)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Event viewer { Ctrl + Win + V } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_Events:
^#v::
APP_Run("Event viewer", A_WinDir . "\system32\mmc.exe", """" . A_WinDir . "\system32\eventvwr.msc""", A_WinDir . "\system32", , "Observateur d'événements ahk_class MMCMainFrame", , false)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; WMP { Win + W } :
;;;;;;;;;;;;;;;;;;;

APP_WMP:
#w::
APP_Run("WMP", APP_WindowsMediaPlayerPath, APP_AreFilesSelected(""), A_MyDocuments, false, "ahk_class WMPlayerApp")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; WMP full screen { AltrGr + Enter | Click } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, ahk_class WMPlayerApp
LButton::
APP_WMPFullScreen()
Return

<^>!Enter::
SendInput, !{Enter}
Return

#IfWinActive, ahk_class WMP Skin Host
LButton::
APP_WMPFullScreen()
Return

<^>!Enter::
SendInput, !{Enter}
Return
#IfWinActive

APP_WMPFullScreen() {

	LOC_ClickZone := WIN_GetTitleBarClickZone()
	If (LOC_ClickZone == "t") { ; Title bar
		 SendInput, !{Enter}
	} Else {
		 MouseClick
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; WMP play/pause { Space }, speed { Ctrl + Right/Up/Left/Down/0 }, forward/backward { Ctrl + Shift + Left/Down/Right/Up }, previous/next { Alt + Left/Down/Right/Up } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, ahk_group APP_WMPWindowsGroup
; Slow speed :
^Left::
^Down::
IfWinActive, ahk_class MediaPlayerClassicW
{
	SendInput, ^{Down}
} Else {
	PostMessage, 0x111, 18836
}
AHK_ShowToolTip("Slow down")
Return

; Play/pause :
Space::
IfWinActive, ahk_class MediaPlayerClassicW
{
	SendInput, {Space}
} Else {
	SendInput, ^p ; PostMessage, 0x111, 18808
}
Return

LButton Up::
APP_WMPPauseClick()
Return
APP_WMPPauseClick() {
	MouseGetPos, , , LOC_HoveredWindowID, LOC_HoveredControl
	If (LOC_HoveredControl == "EVRVideoHandler1") {
		WinGetTitle, LOC_HoveredWindowTitle, ahk_id %LOC_HoveredWindowID%
		WinGetClass, LOC_HoveredWindowClass, ahk_id %LOC_HoveredWindowID%
		If (LOC_HoveredWindowTitle == "WMPTransition"
			&& LOC_HoveredWindowClass == "WMPTransition") {
			SendInput, ^p
		} Else {
			MouseClick
		}
	}
}

; Normal speed :
Numpad0::
^Numpad0::
NumpadIns::
^NumpadIns::
IfWinActive, ahk_class MediaPlayerClassicW
{
	SendInput, ^r
} Else {
	PostMessage, 0x111, 18835
}
AHK_ShowToolTip("Normal speed")
Return

; Quick speed :
^Right::
^Up::
IfWinActive, ahk_class MediaPlayerClassicW
{
	SendInput, ^{Up}
} Else {
	PostMessage, 0x111, 18834
}
AHK_ShowToolTip("Quick speed")
Return

; Very quick speed :
^+Right::
^+Up::
IfWinActive, ahk_class MediaPlayerClassicW
{
	SendInput, ^{Up}
} Else {
	PostMessage, 0x111, 18813
}
AHK_ShowToolTip("Full quick speed")
Return

; Previous :
!Left::
<^>!Left::
PostMessage, 0x111, 18810
AHK_ShowToolTip("Previous")
Return

; Next :
!Right::
<^>!Right::
PostMessage, 0x111, 18811
AHK_ShowToolTip("Next")
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Flash player play/pause { Space } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, ahk_class ShockwaveFlashFullScreen
Space::
APP_FlashPlayPause()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_FlashPlayPause() {
	CoordMode, Pixel, Screen
	WinGetPos, LOC_X, LOC_Y, LOC_Width, LOC_Height, A
	MouseGetPos, LOC_MouseX, LOC_MouseY
	MouseClick, Left, LOC_X + LOC_Width // 2, LOC_Y + LOC_Height // 2, 1, 0
	Sleep, 10
	MouseMove, LOC_MouseX, LOC_MouseY
}

#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; PDF XChange :
;;;;;;;;;;;;;;;

#IfWinActive,  - PDF-XChange Viewer ahk_class DSUI:PDFXCViewer
; Zoom :
^WheelUp::
SendInput, {Esc}^{NumPadAdd}
Return
^WheelDown::
SendInput, {Esc}^{NumPadSub}
Return
^+Left::
^+Right::
^+Up::
^+Down::
APP_PDFRotatePage(A_ThisHotKey)
Return

APP_PDFRotatePage(PRM_HotKey) {
	WinWaitActive, - PDF-XChange Viewer ahk_class DSUI:PDFXCViewer, , 1
	If (!ErrorLevel) {
		SendInput, {Esc}^+r
		WinWaitActive, Rotation de pages ahk_class #32770, , 1
		If (!ErrorLevel) {
			SendInput, !+d
			Sleep, 50
			SendInput, {Up 2}
			Sleep, 50
			If PRM_HotKey contains Left
			{
				SendInput, {Down}
			} Else If PRM_HotKey contains Up,Down
			{
				SendInput, {Down 2}
			}
			ControlFocus, Button4
			Sleep, 50
			ControlClick, Button4
			Sleep, 50
			SendInput, {Enter}
		}
	}
}
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, Araxis Merge
WheelUp::
WheelDown::
SendInput, {%A_ThisHotkey%}
Return
^WheelUp::
^WheelDown::
SendInput, % "^{" . SubStr(A_ThisHotkey, 2) . "}"
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; FUEL game :
;;;;;;;;;;;;;

#IfWinActive, FUEL ahk_class SDK
~Left::
Suspend, Permit
SendInput, {t Down}
Return

~Left Up::
Suspend, Permit
SendInput, {t Up}
Return

~Right::
Suspend, Permit
SendInput, {y Down}
Return

~Right Up::
Suspend, Permit
SendInput, {y Up}
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Android { Win + A } :
;;;;;;;;;;;;;;;;;;;;;;;

#a::
APP_Android()
Return

APP_Android() {
	Global APP_AndroidPath, APP_AndroidActivityEnabled, ZZZ_AndroidMouseTimer
	APP_Run("Android", APP_AndroidPath, , , PRM_Maximized = false)
	SetTimer, APP_AndroidMouseTimer, %ZZZ_AndroidMouseTimer%
	If (APP_AndroidActivityEnabled) {
		SetTimer, APP_AndroidActivityTimer, -10000
	}
}

APP_AndroidMouseTimer:
APP_AndroidMouseTimer()
Return

APP_AndroidMouseTimer() {
	Global ZZZ_AndroidMouseTimer
	Static STA_LastCheck := 0, STA_LastWindowID := 0
	If (A_TickCount - STA_LastCheck < -ZZZ_AndroidMouseTimer) {
		SetTimer, APP_AndroidMouseTimer, %ZZZ_AndroidMouseTimer%
		Return
	}
	STA_LastCheck := A_TickCount
	MouseGetPos, , , LOC_WindowID
	If (LOC_WindowID != Abs(STA_LastWindowID)) {
		If (WinExist("Nox App Player ahk_class Qt5QWindowIcon ahk_id " . LOC_WindowID)) {
			AHK_SetCursor("Hand")
			SetTimer, APP_AndroidMouseTimer, %ZZZ_AndroidMouseTimer%
			STA_LastWindowID := LOC_WindowID
		} Else {
			If (STA_LastWindowID > 0) {
				AHK_ResetCursor()
			}
			STA_LastWindowID := -LOC_WindowID
			If (WinExist("Nox App Player ahk_class Qt5QWindowIcon")) {
				SetTimer, APP_AndroidMouseTimer, %ZZZ_AndroidMouseTimer%
			}
		}
		STA_LastWindowID := LOC_WindowID
	}
}

#IfWinActive, Nox App Player ahk_class Qt5QWindowIcon
RAlt::LAlt

; Back :
XButton1::
XButton2::
SendInput, {Esc}
APP_AndroidActivity(, true)
Return

; Drag :
RButton::
APP_AndroidActivity(, true)
Return

~LButton::
~LButton Up::
~Space::
APP_AndroidActivity(, true)
Return

Left::
SendInput, a
APP_AndroidActivity(, true)
Return
Right::
SendInput, d
APP_AndroidActivity(, true)
Return
Up::
SendInput, w
APP_AndroidActivity(, true)
Return
Down::
SendInput, s
APP_AndroidActivity(, true)
Return

^+s::
APP_AndroidActivity(true, true)
Return

APP_AndroidActivityTimer:
APP_AndroidActivity()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_InitAndroidCursorTimer() {
	Global
	SetTimer, APP_AndroidMouseTimer, %ZZZ_AndroidMouseTimer%
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Activity simulation for Android :
APP_AndroidActivity(PRM_StateChanged = false, PEM_ReinitCountdown = false) {
	Global SCR_VirtualScreenWidth, SCR_VirtualScreenHeight, ZZZ_CloseHandleFunction, APP_AndroidActivityEnabled
	Static STA_SecondsToWait := 0, STA_MaxSecondsToWait := 0, STA_PreviousMouseX, STA_PreviousMouseY, STA_PreviousClickX, STA_PreviousClickY, STA_WindowID := 0, STA_ProcessID := 0, STA_GetProcessMemoryInfoFunction := AHK_GetFunction("psapi", "GetProcessMemoryInfo"), STA_OpenProcessFunction := AHK_GetFunction("kernel32", "OpenProcess"), STA_ToolTipGuiID := 0
	
	If (!STA_MaxSecondsToWait) {
		STA_MaxSecondsToWait := 30
		, STA_PreviousMouseX := SCR_VirtualScreenWidth
		, STA_PreviousMouseY := SCR_VirtualScreenHeight
		, STA_PreviousClickX := SCR_VirtualScreenWidth
		, STA_PreviousClickY := SCR_VirtualScreenHeight
	}
	
	If (PRM_ReinitCountdown) {
		STA_SecondsToWait := STA_MaxSecondsToWait
		Return
	}
	
	If (!WinExist("ahk_id " . (0 + STA_WindowID))) {
		WinGet, STA_WindowID, ID, Nox App Player ahk_class Qt5QWindowIcon
		If (!STA_WindowID) {
			SetTimer, APP_AndroidActivityTimer, Off
			STA_WindowID := 0
			Loop, 5 { ; GUI_AndroidActivity*
				LOC_GuiID := 51 + A_Index
				Gui, %LOC_GuiID%:Destroy
			}
			Return
		}
	}
	
	Process, Exist, Nox.exe
	STA_ProcessID := ErrorLevel
	If (!STA_ProcessID) {
		SetTimer, APP_AndroidActivityTimer, Off
		STA_WindowID := STA_ProcessID := 0
		Loop, 5 { ; GUI_AndroidActivity*
			LOC_GuiID := 51 + A_Index
			Gui, %LOC_GuiID%:Destroy
		}
		Return
	}

	If (PRM_StateChanged) {
		APP_AndroidActivityEnabled := !APP_AndroidActivityEnabled
		, STA_SecondsToWait := 0
		, AHK_SaveIniFile()
	}
	
	If (APP_AndroidActivityEnabled) {
		CoordMode, Mouse, Screen
		If (WinExist("ahk_id " . STA_WindowID)) {
			WinGetPos, LOC_WindowX, LOC_WindowY, LOC_WindowWidth, LOC_WindowHeight
			MouseGetPos, LOC_MouseX, LOC_MouseY
			LOC_Active := WinActive("ahk_id " . STA_WindowID)
			If (LOC_Active) {
				 ; Clash of Clans (110, 80)-(1440, 800) - Star Wars Commander (150, 0)-(1540, 790) - Castle Clash (130, 90)-(1400, 810) - marge of 10% :
				 LOC_MinX := Round(LOC_WindowX + 280 * LOC_WindowWidth / SCR_VirtualScreenWidth)
				, LOC_MinY := Round(LOC_WindowY + 120 * LOC_WindowHeight / SCR_VirtualScreenHeight)
				, LOC_MaxX := Round(LOC_WindowX + 1320 * LOC_WindowWidth / SCR_VirtualScreenWidth) 
				, LOC_MaxY := Round(LOC_WindowY + 790 * LOC_WindowHeight / SCR_VirtualScreenHeight)
				If (!WinExist("ahk_id " . STA_ToolTipGuiID)) {
					Gui, 52:+AlwaysOnTop -Caption +Border -Resize +ToolWindow +Disabled +HWndSTA_ToolTipGuiID +LastFound ; GUI_AndroidActivitySimulation
					Gui, 52:Color, FFFFDF, 000000
					Gui, 52:Margin, 5, 5
					Gui, 52:Font, Bold
					Gui, 52:Add, Text, , %A_Space% Activity`nSimulation
					WinSet, Transparent, 180
					WinSet, ExStyle, +0x00000020
					; SYS_DockWindowToWindow(STA_ToolTipGuiID, STA_WindowID)
					Loop, 4	{ ; GUI_AndroidActivity*
						LOC_GuiIndex := 52 + A_Index
						Gui, %LOC_GuiIndex%:Destroy
						Gui, %LOC_GuiIndex%:-Caption -SysMenu -Border -Resize +AlwaysOnTop +ToolWindow +Owner +Disabled +LastFound
						Gui, %LOC_GuiIndex%:Color, 96AA4A
						WinSet, Transparent, 100
					}
				}
				; Gui, 52:+LastFound
				Gui, 52:Show, % "X" . (LOC_WindowX + 1603 * LOC_WindowWidth / SCR_VirtualScreenWidth - 34) . " Y" . (LOC_WindowY + 407 * LOC_WindowHeight / SCR_VirtualScreenHeight) . " AutoSize NA NoActivate", GUI_AndroidActivitySimulation
				; WinSet, AlwaysOnTop, On
				Gui, 53:Show, % "x" . LOC_MinX . " y" . (LOC_MinY - 1) . " w" . (LOC_MaxX - LOC_MinX + 1) . " h2 NoActivate", GUI_AndroidActivityTop
				Gui, 54:Show, % "x" . (LOC_MinX - 1) . " y" . LOC_MinY . " w2 h" . (LOC_MaxY - LOC_MinY + 1) . " NoActivate", GUI_AndroidActivityLeft
				Gui, 55:Show, % "x" . LOC_MinX . " y" . LOC_MaxY . " w" . (LOC_MaxX - LOC_MinX + 1) . " h2 NoActivate", GUI_AndroidActivityBottom
				Gui, 56:Show, % "x" . LOC_MaxX . " y" . LOC_MinY . " w2 h" . (LOC_MaxY - LOC_MinY + 1) . " NoActivate", GUI_AndroidActivityRight
			} Else {
				If (WinExist("ahk_id " . STA_ToolTipGuiID)) {
					Loop, 5 {
						LOC_GuiID := 51 + A_Index
						Gui, %LOC_GuiID%:Destroy
					}
				}
			}
			LOC_ProcessHandler := DllCall(STA_OpenProcessFunction, "UInt", 0x10|0x400, "Int", 0, "UInt", STA_ProcessID)
			, VarSetCapacity(LOC_MemoryCounters, 40, 0)
			, DllCall(STA_GetProcessMemoryInfoFunction, "UInt", LOC_ProcessHandler, "UInt", &LOC_MemoryCounters, "UInt", 40)
			, LOC_MemoryLoad := NumGet(LOC_MemoryCounters, 12, "UInt")
			, DllCall(ZZZ_CloseHandleFunction, "UInt", LOC_ProcessHandler)
			If (LOC_MemoryLoad > 67108864
				&& (LOC_MouseX == STA_PreviousMouseX 
						&& LOC_MouseY == STA_PreviousMouseY
						&& !GetKeyState("LButton")
					|| !WinActive("ahk_id " . STA_WindowID))) {
				If (STA_SecondsToWait <= 0) {
					; Simulate click if mouse didn't move :
					LOC_ClickX := STA_PreviousClickX
					, LOC_ClickY := STA_PreviousClickY
					While (Abs(STA_PreviousClickX - LOC_ClickX) < 150 * LOC_WindowWidth / SCR_VirtualScreenWidth
						|| Abs(STA_PreviousClickY - LOC_ClickY) < 150 * LOC_WindowHeight / SCR_VirtualScreenHeight) {
						Random, LOC_ClickX, LOC_MinX - LOC_WindowX, LOC_MaxX - LOC_WindowX
						Random, LOC_ClickY, LOC_MinY - LOC_WindowY, LOC_MaxY - LOC_WindowY
					}
					ControlClick, X%LOC_ClickX% Y%LOC_ClickY%, ahk_id %STA_WindowID%, , Left, 1, NA ; always relative to the window
					If (LOC_Active) {
						CoordMode, Mouse, Window
						MouseMove, LOC_ClickX, LOC_ClickY
						AHK_ShowTooltip("Click !", PRM_ToolTipSeconds := 3)
					}
					STA_PreviousClickX := LOC_ClickX
					, STA_PreviousClickY := LOC_ClickY
					Random, STA_SecondsToWait, 1, %STA_MaxSecondsToWait%
				} Else {
					STA_SecondsToWait--
				}
			} Else {
				STA_SecondsToWait := STA_MaxSecondsToWait
				, STA_PreviousMouseX := LOC_MouseX
				, STA_PreviousMouseY := LOC_MouseY
			}
		} Else {
			STA_SecondsToWait := STA_MaxSecondsToWait
			, STA_PreviousMouseX := 0
			, STA_PreviousMouseY := 0
		}
		SetTimer, APP_AndroidActivityTimer, -1000
	} Else {
		SetTimer, APP_AndroidActivityTimer, Off
		Loop, 5 {
			LOC_GuiID := 51 + A_Index
			Gui, %LOC_GuiID%:Destroy
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Office scroll :
;;;;;;;;;;;;;;;;;

#IfWinActive, ahk_class OpusApp
~^WheelDown::
~^WheelUp::
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Navigation (Tabs) { 4th & 5th mouse buttons } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

XButton1::
APP_XButton(false)
Return

XButton2::
APP_XButton(true)
Return

APP_XButton(PRM_Direction = false) {

	If (!(APP_CheckXButton(PRM_Direction, PRM_ActiveWindows := "ahk_class dopus.lister", PRM_4thButtonAction := "{Esc}^{Left}", PRM_5thButtonAction := "{Esc}^{Right}")
		|| APP_CheckXButton(PRM_Direction, PRM_ActiveWindows := "UltraEdit|UEStudio|Notepad++", PRM_4thButtonAction := "{Esc}!{Up}", PRM_5thButtonAction := "{Esc}!{Down}")
		|| APP_CheckXButton(PRM_Direction, PRM_ActiveWindows := "MediaMonkey ahk_class TFMainWindow", PRM_4thButtonAction := "{Esc}!{Left}", PRM_5thButtonAction := "{Esc}!{Right}", PRM_4thButtonToolTip := "Previous track", PRM_5thButtonToolTip := "Next track")
		|| APP_CheckXButton(PRM_Direction, PRM_ActiveWindows := "Lecteur Windows Media ahk_class WMPlayerApp|Lecteur Windows Media ahk_class WMP Skin Host", PRM_4thButtonAction := "^b", PRM_5thButtonAction := "^f")
		|| APP_CheckXButton(PRM_Direction, PRM_ActiveWindows := "Google Chrome ahk_class Chrome_WidgetWin_1", PRM_4thButtonAction := "{Browser_Back}", PRM_5thButtonAction := "{Browser_Forward}")
		|| APP_CheckXButton(PRM_Direction, PRM_ActiveWindows := "Pale Moon ahk_class MozillaWindowClass|Mozilla Firefox ahk_class MozillaWindowClass", PRM_4thButtonAction := "^{PgUp}", PRM_5thButtonAction := "^{PgDn}")
		|| APP_CheckXButton(PRM_Direction, PRM_ActiveWindows := "Windows Internet Explorer ahk_class IEFrame|Google Chrome ahk_class Chrome_WidgetWin_1", PRM_4thButtonAction := "{Esc}{Ctrl Down}{RShift Down}{Tab}{RShift Up}{Ctrl Up}", PRM_5thButtonAction := "{Esc}^{Tab}")
		|| APP_CheckXButton(PRM_Direction, PRM_ActiveWindows := "KGS ahk_class SunAwtFrame|CGoban ahk_class SunAwtFrame", PRM_4thButtonAction := "{Left 10}", PRM_5thButtonAction := "{Right 10}", PRM_4thButtonToolTip := "« 10 moves", PRM_5thButtonToolTip := "» 10 moves")
		|| APP_CheckXButton(PRM_Direction, PRM_ActiveWindows := "ahk_class TGoGameDieAndLiveForm", PRM_4thButtonAction := "{Esc}{Alt Down}v{Alt Up}p", PRM_5thButtonAction := "{Esc}{Alt Down}v{Alt Up}n")
		|| APP_CheckXButton(PRM_Direction, PRM_ActiveWindows := "Visionneuse de photos Picasa ahk_class ytWindow|ahk_class WMPTransition|ahk_class ShockwaveFlashFullScreen", PRM_4thButtonAction := "{Left}", PRM_5thButtonAction := "{Right}")
		|| APP_CheckXButton(PRM_Direction, PRM_ActiveWindows := "- Eclipse ahk_class SWT_Window0", PRM_4thButtonAction := "{Esc}^+{F6}", PRM_5thButtonAction := "{Esc}^{F6}")
		|| APP_CheckXButton(PRM_Direction, PRM_ActiveWindows := "ahk_class DSUI:PDFXCViewer|Microsoft Word ahk_class OpusApp|Microsoft Excel ahk_class XLMAIN|Microsoft PowerPoint ahk_class PP11FrameClass|Mozilla Thunderbird ahk_class MozillaWindowClass", PRM_4thButtonAction := "{Esc}^+{Tab}", PRM_5thButtonAction := "{Esc}^{Tab}")
 		|| APP_CheckXButton(PRM_Direction, PRM_ActiveWindows := "ahk_class SciTEWindow", PRM_4thButtonAction := "{Esc}+{F6}", PRM_5thButtonAction := "{Esc}{F6}"))) {
		If (WinActive("The Many Faces of Go - [")) {
			WinMenuSelectItem, , , Go To, % (PRM_Direction ? "Forward 10 Moves" : "Back 10 Moves")
			AHK_ShowToolTip(PRM_Direction ? "» 10 moves" : "« 10 moves")
			Return
		}
		SendInput, {%A_ThisHotKey%}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_CheckXButton(PRM_Direction, PRM_ActiveWindows, PRM_4thButtonAction = "", PRM_5thButtonAction = "", PRM_4thButtonToolTip = "", PRM_5thButtonToolTip = "") {

	LOC_Active := false
	Loop, Parse, PRM_ActiveWindows, |
	{
		If (WinActive(A_LoopField)) {
			LOC_Active := true
			Break
		}
	}
	If (LOC_Active) {
		If (PRM_Direction && PRM_5thButtonAction
			|| !PRM_Direction && PRM_4thButtonAction) {
			SendInput, % (PRM_Direction ? PRM_5thButtonAction : PRM_4thButtonAction)
			LOC_ToolTip := (PRM_Direction ? PRM_5thButtonToolTip : PRM_4thButtonToolTip)
			If (LOC_ToolTip) {
				AHK_ShowToolTip(LOC_ToolTip)
			}
			; MsgBox, % (PRM_Direction ? PRM_5thButtonAction : PRM_4thButtonAction)
		}
		Return, true
	}
	Return, false
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

APP_RunAs(PRM_DomainLogin = "", PRM_DomainEncryptedPassword = "") {
	Global LOG_DomainEncryptedPassword
	
	;If (A_IsAdmin) {
		LOC_DomainLogin := (PRM_DomainLogin ? PRM_DomainLogin : A_Username)
		LOC_DomainPassword := LOG_GetFieldValue(PRM_DomainEncryptedPassword && PRM_DomainLogin
				? "PRM_DomainEncryptedPassword"
				: "LOG_DomainEncryptedPassword")
		If (LOC_DomainPassword) {
			RunAs, %LOC_DomainLogin%, %LOC_DomainPassword%
		}
	;}
}

APP_ShowQuickHelpTooltip() {
	WinGetClass, LOC_Class, A
	WinGetTitle, LOC_Title, A
	If (LOC_Class == "SciTEWindow") {
		LOC_Tooltip := "Control + Numpad±`t`t: Toggle current fold`nControl + Shift + Numpad±`t: Toggle all folds`n`n[ Shift + ] F3`t`t`t: Search`nControl + Shift + S`t`t: Save All`n`nAlt + I`t`t`t`t: If () {} Else {}"
	} Else If (LOC_Class == "TMainForm" && InStr(LOC_Title, "Mp3 Editor Pro")) {
		LOC_Tooltip := "4th Button`t: Extend selection to left`n5th Button`t: Extend selection to right"
	} Else If (LOC_Class == "#32770" && Instr(LOC_Title, "image")) {
		LOC_Tooltip := "Control + F`t: Select 'Folder.jpg' in the current folder`nAlt + F`t`t: Select 'Folder.jpg' in 'M:\INCONNU'"
	} Else If (LOC_Class == "TFMainWindow" && InStr(LOC_Title, "MediaMonkey")) {
		LOC_Tooltip := "Win + Space`t`t: Play / Pause`nControl + I`t`t:Add 'Folder.jpg' image`nControl + Alt + Shift + T`t: Fill title raws from clipboard lines`n`nControl + P`t`t: Add to playlist named 'Playlist'`nControl + Delete`t`t: Clear playlist"
	} Else If (LOC_Class == "TFChooseMask" && LOC_Title == "Tags-auto depuis les noms de fichier") {
		LOC_Tooltip := "Alt + A`t: <Artiste>`nAlt + B`t: <Album>`nAlt + T`t: <Titre>`nAlt + N`t: <Piste n°>`nAlt + P`t: <Passer>`nAlt + R`t: <Répertoire>"
	} Else If (LOC_Class == "TFRenameWithMask") {
		LOC_Tooltip := "Alt + A`t: <Artiste>`nAlt + B`t: <Album>`nAlt + G`t: <Genre>`nAlt + T`t: <Titre>`nAlt + N`t: <Piste n°>`nAlt + R`t: <Répertoire>`nAlt + Y`t: <Année>"
	} Else If (LOC_Class == "TFSongProperties") {
		LOC_Tooltip := "Alt + T`t`t: Titre de la piste`nAlt + A`t`t: Artiste`nAlt + G`t`t: Genre`nAlt + B`t`t: Album`nAlt + Shift + A`t: Artiste de l'album`nAlt + N`t`t: Piste n°`nAlt + Y`t`t: Date"
	} Else If (LOC_Class == "PlayerCanvas"
				|| LOC_Class == "ExtPlayerCanvas"
				|| LOC_Class == "TModuleForm" && LOC_Title == "Chronotron Plugin"
				|| LOC_Class == "#32770" && LOC_Title == "A-B Repeat") {
		LOC_Tooltip := "Alt + Left`t: Previous track`nAlt + Right`t: Next track`n`nControl + Left`t: Slow down`nControl + Right`t: Speed up`n`nControl + Up`t: ½ tone higher`nControl + Down`t: ½ tone lower`n`nInsert`t`t: Repeat A-B"
	} Else If (LOC_Class == "AutoHotKeyGUI" 
		&& (LOC_Title == "GUI_HorizontalRuler" || LOC_Title == "Gui_VerticalRuler")) {
		LOC_Tooltip := "Arrows`t: Move ruler`n+ Control`t: Small steps`n+ Shift`t:Long steps`n`nEscape`t: Close ruler"
	} Else If (LOC_Class == "MMCMainFrame" && LOC_Title == "Services") {
		LOC_Tooltip := "Insert`t: Start service`nDelete`t: Stop service"
	} Else If (WinActive("ahk_group APP_WMPWindowsGroup")) {
		LOC_Tooltip := "Alt + Left`t: Previous track`nAlt + Right`t: Next track`n`nControl + Left`t`t: Slow down`nControl + Numpad 0`t: Normal speed`nControl + Right`t`t: Speed up"
	}
	
	If (LOC_Tooltip) {
		AHK_ShowTooltip(LOC_Tooltip, max(2, StrLen(LOC_Tooltip) / 33))
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
