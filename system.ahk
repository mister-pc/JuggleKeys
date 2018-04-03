;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Process priority { Ctrl + Win + Wheel } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SYS_ProcessPriority:
^#WheelUp::
^#WheelDown::
^+#WheelUp::
^+#WheelDown::
SYS_SetProcessPriority()
Return

SYS_SetProcessPriority() {
	SYS_ProcessPriority(PRM_Direction := (InStr(A_ThisHotkey, "Up") ? 1 : -1), PRM_ActiveWindow := !InStr(A_ThisHotKey, "+"))
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SYS_ProcessPriority(PRM_Direction = 0, PRM_ActiveWindow = true) {

	Global ZZZ_CloseHandleFunction
	If (PRM_ActiveWindow) {
		WinGet, LOC_WindowID, ID, A
	} Else {
		MouseGetPos, , , LOC_WindowID
	}
	If (!LOC_WindowID) {
		Return, false
	}
	WinGet, LOC_PID, PID, ahk_id %LOC_WindowID%
	LOC_ProcessHandler := DllCall("kernel32.dll\OpenProcess", "UInt", 0x0400, "UInt", 1, "UInt", LOC_PID)
	If (LOC_ProcessHandler) {
		LOC_Priority := DllCall("kernel32.dll\GetPriorityClass", "UInt", LOC_ProcessHandler)
		, LOC_Label := ""
		DllCall(ZZZ_CloseHandleFunction, "UInt", LOC_ProcessHandler)
		If (LOC_Priority == 0x00000100) { ; Realtime
			LOC_Priority := (PRM_Direction >= 0 ? "Realtime" : "High")
		} Else
		If (LOC_Priority == 0x00000080) { ; High
			LOC_Priority := (PRM_Direction > 0 ? "Realtime" : (PRM_Direction == 0 ? "High" : "AboveNormal"))
			, LOC_Label := (PRM_Direction < 0 ? "Above Normal" : "")
		} Else
		If (LOC_Priority == 0x00008000) { ; Above normal
			LOC_Priority := (PRM_Direction > 0 ? "High" : (PRM_Direction == 0 ? "AboveNormal" : "Normal"))
			, LOC_Label := (PRM_Direction == 0 ? "Above Normal" : "")
		} Else
		If (LOC_Priority == 0x00000020) { ; Normal
			LOC_Priority := (PRM_Direction > 0 ? "AboveNormal" : (PRM_Direction == 0 ? "Normal" : "BelowNormal"))
			, LOC_Label := (PRM_Direction > 0 ? "Above Normal" : (PRM_Direction < 0 ? "Below Normal" : ""))
		} Else
		If (LOC_Priority == 0x00004000) { ; Below normal
			LOC_Priority := (PRM_Direction > 0 ? "Normal" : (PRM_Direction == 0 ? "BelowNormal" : "Low"))
			LOC_Label := (PRM_Direction > 0 ? "" : (PRM_Direction == 0 ? "Below Normal" : "Idle"))
		} Else
		If (LOC_Priority == 0x00000040) { ; Low
			LOC_Priority := (PRM_Direction > 0 ? "BelowNormal" : "Low")
			LOC_Label := (PRM_Direction > 0 ? "Below Normal" : "Idle")
		} Else {
			Return, false
		}
		If (PRM_Direction != 0) {
			Process, Priority, %LOC_PID%, %LOC_Priority%
			AHK_ShowToolTip("Priority: " . (LOC_Label ? LOC_Label : LOC_Priority))
		}
		Return, (LOC_Label ? LOC_Label : LOC_Priority)
	}
	Return, false
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suspend / resume process { Ctrl + [ Shift + ] Pause } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SYS_TrayMenuSuspendProcess:
If (WIN_FocusLastWindow()) {
	SYS_SuspendProcess(-1, true)
}
Return

SYS_TrayMenuResumeProcess:
If (WIN_FocusLastWindow()) {
	SYS_SuspendProcess(-1, false)
}
Return

#Pause::
SYS_SuspendProcess(-1, true)
Return

+#Pause::
SYS_SuspendProcess(-1, false)
Return

^#Pause::
^#CtrlBreak::
AHK_KeyWait("Pause", "^#")
SendInput, {LWin Down}{Pause}{LWin Up}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SYS_SuspendProcess(PRM_PID, PRM_Suspend = true, PRM_Tooltip = true) {
	Global ZZZ_CloseHandleFunction
	Static STA_OpenProcessFunction := AHK_GetFunction("kernel32", "OpenProcess"), STA_NtSuspendProcessFunction := AHK_GetFunction("ntdll", "NtSuspendProcess"), STA_NtResumeProcessFunction := AHK_GetFunction("ntdll", "NtResumeProcess")
    If (PRM_PID > 0) {
		LOC_PID := PRM_PID
	} Else {
		WinGet, LOC_PID, PID, A
	}
	LOC_ProcessHandler := DllCall(STA_OpenProcessFunction, "UInt", 0x1F0FFF, "Int", 0, "Int", LOC_PID)
    If (LOC_ProcessHandler) {
		DllCall(PRM_Suspend ? STA_NtSuspendProcessFunction : STA_NtResumeProcessFunction, "Int", LOC_ProcessHandler)
		DllCall(ZZZ_CloseHandleFunction, "Int", LOC_ProcessHandler)
		If (PRM_Tooltip) {
			AHK_ShowTooltip("Process " . (PRM_Suspend ? "suspended" : "resumed"), 1)
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Default registry options :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SYS_KillRegServer:
SYS_WriteRegistryOptions(true)
Return

SYS_WriteRegistryOptions(PRM_KillRegServer = false) {

	Global AHK_SSD, LOG_DomainLogin, LOG_DomainEncryptedPassword, TRY_TrayTipEnabled, ZZZ_KillRegServerTimer
	Static STA_RegServer1 := 0, STA_RegServer2 := 0
	
	; Kill unclosed regserver commands :
	If (PRM_KillRegServer) {
		Loop, 2 {
			Process, Exist, % STA_RegServer%A_Index%
			If (ErrorLevel) {
				Process, Close, % STA_RegServer%A_Index%
			}
		}
		Return
	}
	
	RegWrite, REG_SZ,     HKEY_CLASSES_ROOT,  icofile\DefaultIcon,               Default, % "%1"
	RegWrite, REG_BINARY, HKEY_CLASSES_ROOT,  icofile\DefaultIcon,               EditFlags, % "00000100"
	RegWrite, REG_SZ,     HKEY_CLASSES_ROOT,  .ico,                              Default, icofile
	RegWrite, REG_SZ,     HKEY_CLASSES_ROOT,  .ico,                              Content Type, image/x-icon
	RegWrite, REG_SZ,     HKEY_CLASSES_ROOT,  exefile,                           Default, Application    ; don't ask about exe provenance
	RegWrite, REG_BINARY, HKEY_CLASSES_ROOT,  exefile,                           EditFlags, % "38070100"
	RegWrite, REG_SZ,     HKEY_CLASSES_ROOT,  Drive\shell\PrintHere,             Default, Print Contents ; add print drive and folder contents context menu
	RegWrite, REG_SZ,     HKEY_CLASSES_ROOT,  Drive\shell\PrintHere\Command,     Default, C:\WINDOWS\system32\cmd.exe /c ls -FA1 "`%1" >contents.txt
	RegWrite, REG_SZ,     HKEY_CLASSES_ROOT,  Directory\shell\PrintHere,         Default, Print Contents
	RegWrite, REG_SZ,     HKEY_CLASSES_ROOT,  Directory\shell\PrintHere\Command, Default, C:\WINDOWS\system32\cmd.exe /c ls -FA1 "`%1" >contents.txt
	RegWrite, REG_SZ,     HKEY_CLASSES_ROOT,  MIME\Database\Content Type\image/jpeg, AutoplayContentTypeHandler, PicturesContentHandler
	RegWrite, REG_SZ,     HKEY_CLASSES_ROOT,  MIME\Database\Content Type\image/jpeg, CLSID, {25336920-03F9-11cf-8FD0-00AA00686F13}
	RegWrite, REG_SZ,     HKEY_CLASSES_ROOT,  MIME\Database\Content Type\image/jpeg, Extension, .jpg
	RegWrite, REG_SZ,     HKEY_CLASSES_ROOT,  MIME\Database\Content Type\image/jpeg, Image Filter CLSID, {607fd4e8-0a03-11d1-ab1d-00c04fc9b304}
	RegWrite, REG_BINARY, HKEY_CLASSES_ROOT,  MIME\Database\Content Type\image/jpeg\Bits, 0, % "02000000ffffffd8"
	
	; RegWrite, REG_SZ,     HKEY_CLASSES_ROOT,  *\shellex\ContextMenuHandlers\{645FF040-5081-101B-9F08-00AA002F954E}, Default, Empty Recycle Bin
	; RegWrite, REG_SZ,     HKEY_CLASSES_ROOT,  *\shellex\ContextMenuHandlers\Empty Recycle Bin, Default, {645FF040-5081-101B-9F08-00AA002F954E}
	; RegWrite, REG_SZ,     HKEY_CLASSES_ROOT,  Directory\Background\shellex\ContextMenuHandlers\Empty Recycle Bin, Default, {645FF040-5081-101B-9F08-00AA002F954E}
	; RegWrite, REG_SZ,     HKEY_CLASSES_ROOT,  Directory\shellex\ContextMenuHandlers\Empty Recycle Bin, Default, {645FF040-5081-101B-9F08-00AA002F954E}
	; RegWrite, REG_SZ,     HKEY_CLASSES_ROOT,  Folder\shellex\ContextMenuHandlers\Empty Recycle Bin, Default, {645FF040-5081-101B-9F08-00AA002F954E}

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	RegWrite, REG_SZ,     HKEY_USERS,         .DEFAULT\Control Panel\Keyboard,   InitialKeyboardIndicators, 2 ; NumLock on
	RegWrite, REG_SZ,     HKEY_USERS,         .DEFAULT\Control Panel\Desktop,    AutoEndTasks, 1 ; auto-end tasks
	RegWrite, REG_SZ,     HKEY_USERS,         .DEFAULT\Control Panel\Desktop,    PowerOffActive, 1 ; power-off enabled
	RegWrite, REG_SZ,     HKEY_USERS,         .DEFAULT\Control Panel\Desktop,    ScreenSaveActive, 1 ; screen-saver enabled
	RegWrite, REG_DWORD,  HKEY_USERS,         .DEFAULT\Console,                  QuickEdit, 1 ; console quick edition
	RegWrite, REG_DWORD,  HKEY_USERS,         .DEFAULT\Software\Microsoft\Windows\CurrentVersion\Internet Settings, MaxConnectionsPerServer, 10 ; increase max connection limit for HTTP 1.1
	RegWrite, REG_DWORD,  HKEY_USERS,         .DEFAULT\Software\Microsoft\Windows\CurrentVersion\Internet Settings, MaxConnectionsPer1_0Server, 10 ; increase max connection limit for HTTP 1.0

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	RegWrite, REG_SZ,     HKEY_CURRENT_USER,  Control Panel\Sound,                                                   Beep, No ; no beep on errors
	RegWrite, REG_SZ,     HKEY_CURRENT_USER,  Control Panel\Sound,                                                   ExtendedSounds, No ; no beep on errors
	RegWrite, REG_SZ,     HKEY_CURRENT_USER,  Control Panel\Desktop,                                                 DragFullWindows, 1 ; display content while dragging
	RegWrite, REG_SZ,     HKEY_CURRENT_USER,  Control Panel\Desktop,                                                 MenuShowDelay, 0 ; set menu delay to 0
	RegWrite, REG_SZ,     HKEY_CURRENT_USER,  Control Panel\Desktop,                                                 HungAppTimeout, 4000
	RegWrite, REG_SZ,     HKEY_CURRENT_USER,  Control Panel\Desktop,                                                 WaitToKillAppTimeout, 5000
	RegWrite, REG_SZ,     HKEY_CURRENT_USER,  Control Panel\Desktop,                                                 FontSmoothing, 2 ; smooth edges of screen fonts
	RegWrite, REG_SZ,     HKEY_CURRENT_USER,  Control Panel\Desktop,                                                 FontSmoothingType, 2 ; smooth edges of screen fonts
	RegWrite, REG_SZ,     HKEY_CURRENT_USER,  Control Panel\Desktop,                                                 DragFullWindows, 1 ; display full window while dragging
	RegWrite, REG_BINARY, HKEY_CURRENT_USER,  Control Panel\Desktop,                                                 UserPreferencesMask, % "1e2c0780" ; adjust visual effects for appearance
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Control Panel\Desktop,                                                 PaintDesktopVersion, 1
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Control Panel\Desktop,                                                 SmoothScroll, 1
	RegWrite, REG_SZ,     HKEY_CURRENT_USER,  Control Panel\Desktop\WindowMetrics,                                   MinAnimate, 1 ; animate windows when minimizing and maximizing
	RegWrite, REG_SZ,     HKEY_CURRENT_USER,  Control Panel\Desktop\Keyboard,                                        KeyboardDataQueueSize, 1 ; animate windows when minimizing and maximizing
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Command Processor,                                  CompletionChar, 0x00000009 ; command line auto-completion
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Internet Explorer,                                  Show_FullURL, 1 ; command line auto-completion
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\MediaPlayer\Preferences,                            AddToMRU, 0 ; no history in WMP

	; no system icons on desktop :
	RegWrite, REG_SZ,     HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}, Default, My Documents
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\ShellFolder, Attributes, 0x41f05001
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\NonEnum, {20D04FE0-3AEA-1069-A2D8-08002B30309D, 1
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer, NoInternetIcon, 1
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer, NoThumbnailCache, 1
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Advanced, DisableThumbnailCache, 1

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Command Processor,                                  EnableExtensions, 1 ; enables shell-extensions
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Command Processor,                                  DelayedExpension, 1 ; enables shell variable delayed interpretation
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Command Processor,                                  CompletionChar, 64 ; enables shell tab-completion
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Command Processor,                                  PathCompletionChar, 64 ; enables shell tab-completion
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{208D2C60-3AEA-1069-A2D7-08002B30309D}\ShellFolder, Attributes, 0x41f05001
	; RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\ShellFolder, Attributes, 0x41f05001 ; no recycle bin
	; RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu, {645FF040-5081-101B-9F08-00AA002F954E}, 1 ; hide recycle bin from desktop
	; RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel, {645FF040-5081-101B-9F08-00AA002F954E}, 1 ; hide recycle bin from desktop

	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer,                    DesktopProcess, 1 ; Open separate explorer processes
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced,           TaskbarGroupSize, 0x00000010 ; group taskbar when > 9
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced,           StartMenuFavorites, 0 ; no favorites menu
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced,           ListviewShadow, 1 ; rop shadows for icon labels on the desktop
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced,           ListviewAlphaSelect, 1 ; show translucent selection rectangle
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced,           ListviewWatermark, 1 ; background image for each folder type
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced,           FriendlyTree, 0 ; no explorer simple view
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced,           TaskbarAnimations, 1 ; slide taskbar buttons
	RegWrite, REG_SZ,     HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced,           CascadeControlPanel, YES ; expand Control Panel
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced,           NoStartMenuHelp, 1 ; no start menu help
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced,           Start_ShowRecentDocs, 0 ; no start menu recent documents
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced,           StartButtonBalloonTip, 0 ; no start button tip
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced,           IntelliMenus, 0 ; no personalized menus
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced,           TaskbarGlomming, 1 ; group similar taskbar buttons
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced,           DisableThumbnailCache, 1 ; don't cache thumbnails
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced,           SeparateProcess, 1 ; folder windows in separate process
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced,           Start_ShowControlPanel, 2 ; control panel in start menu
	RegWrite, REG_SZ,     HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState,       Use Search Asst, no ; make the "find files" interface cleaner and turn that damn dog off
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Internet Settings,           MaxConnectionsPerServer, 10 ; increase max connection limit for HTTP 1.1
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Internet Settings,           MaxConnectionsPer1_0Server, 10  ; increase max connection limit for HTTP 1.0

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoCDBurning, 1
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoDriveTypeAutoRun, 0x000000bd ; no autorun
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           RecycleBinSize, 0x0000000a ; no recycle bin maximum size
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoWelcomeScreen, 1 ; no welcome screen
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoStartMenuMyMusic, 1 ; no music menu
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoFavoritesMenu, 1 ; no favorites menu
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoSMMyDocs, 1 ; no start menu documents
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoSMMyPictures, 1 ; no image menu
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoSMConfigurePrograms, 1 ; no program configuration menu
	; RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoStartMenuMorePrograms, 1 ; no programs in start menu
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoLogoff, 1 ; no log-off menu
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoInstrumentation, 1 ; disable user tracking
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoRecentDocsMenu, 1 ; no start menu recent documents
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoStartBanner, 1 ; no message 'click here to start' on start button
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           GreyMSIAds, 0 ; no start menu grey shortcuts
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoResolveSearch, 1 ; no missing shortcut search
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoResolveTrack, 1 ; no missing shortcut search
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoRun, % (A_Is64BitOS ? 0 : 1) ; no run menu
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoSMHelp, 1 ; no help in start menu
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           MemCheckBoxInRunDlg, 1 ; checkbox in exexute dialog for separated memory execution
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           ForceStartMenuLogOff, 0 ; no log-off in start menu
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           StartMenuLogOff, 1 ; no log-off in start menu
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoAutoTrayNotify, 1 ; no systray auto-hiding
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoTaskGrouping, 0 ; taskbar grouping
	; RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,         NoToolbarsOnTaskbar, 1 ; no toolbars on taskbar
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoResolveSearch, 1 ; no search when corrupted link
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoFind, 1 ; no search in start menu
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           ConfirmFileDelete, 0 ; no delete confirmation
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoActiveDesktop, 1 ; no active desktop
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoSaveSettings, 0 ; save settings
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoSimpleStartMenu, 1 ; classic XP menu
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           ForceClassicControlPanel, 1 ; classic control panel
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoSetActiveDesktop, 1 ; no active desktop
	RegWrite, REG_BINARY, HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer,                    DesktopProcess, 1 ; desktop's distinct explorer.exe
	RegWrite, REG_BINARY, HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer,                    link, % "00000000" ; no 'shortcut to' text
	RegWrite, REG_BINARY, HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer,                    EnableAutoTray, 1 ; show inactive icons in tray
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Group Policy Objects\LocalUser\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           NoSaveSettings, 0 ; save settings
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Group Policy Objects\LocalUser\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,           **del.NoSaveSettings, %A_Space% ; save settings
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Policies\Microsoft\Office\11.0\Word\Security\FileValidation\EnableOnLoad, 0
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Policies\Microsoft\Office\12.0\Word\Security\FileValidation\EnableOnLoad, 0
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Policies\Microsoft\Office\11.0\Excel\Security\FileValidation\EnableOnLoad, 0
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Policies\Microsoft\Office\12.0\Excel\Security\FileValidation\EnableOnLoad, 0
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Policies\Microsoft\Office\11.0\PowerPoint\Security\FileValidation\EnableOnLoad, 0
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Policies\Microsoft\Office\12.0\PowerPoint\Security\FileValidation\EnableOnLoad, 0

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Group Policy Objects\{5509DEE0-537C-4D9C-9411-1BBC3137220E}Machine\Software\Policies\Microsoft\Windows\WindowsUpdate\AU, RebootRelaunchTimeoutEnabled, 0 ; no reboot asking after windows update
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Group Policy Objects\{5509DEE0-537C-4D9C-9411-1BBC3137220E}Machine\Software\Policies\Microsoft\Windows\WindowsUpdate\AU, NoAutoRebootWithLoggedOnUsers, 1 ; no reboot asking after windows update
	RegDelete, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Group Policy Objects\{5509DEE0-537C-4D9C-9411-1BBC3137220E}Machine\Software\Policies\Microsoft\Windows\WindowsUpdate\AU, RebootRelaunchTimeout ; no reboot asking after windows update
	RegDelete, HKEY_CURRENT_USER, NoName ; renable sound
	RegDelete, HKEY_CURRENT_USER, , NoName ; renable sound
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Group Policy Objects\{5509DEE0-537C-4D9C-9411-1BBC3137220E}Machine\Software\Policies\Microsoft\Windows\WindowsUpdate\AU, **del.RebootRelaunchTimeout, %A_Space% ; no reboot asking after windows update
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\CleanupWiz, NoRun, 1 ; no desktop cleanup wizard
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects,      VisualFXSetting, 3 ; keep the registry in-line with the above changes
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Internet Settings,  MaxConnectionsPer1_0Server, 10 ; IE 10 simultaneous connections
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Internet Settings,  MaxConnectionsPerServer, 10 ; IE 10 simultaneous connections
	RegWrite, REG_DWORD,  HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion\Applets\Tour,                RunCount, 0 ; no welcome tour

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	RegWrite, REG_SZ,     HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Control,                             WaitToKillServiceTimeout, 1000
	RegWrite, REG_SZ,     HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Control\WOW,                         DefaultSeparateVDM, Yes ; 16-bit applications in their own process
	RegWrite, REG_SZ,     HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Control\FileSystem,                  NtfsDisableLastAccessUpdate, 1 ; disable last access time stamp
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Control\PriorityControl,             Win32PrioritySeparation, 26 ; set CPU priority
	RegWrite, REG_BINARY, HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Control\Update,                      UpdateMode, % "00" ; Explorer fast update
	RegWrite, REG_SZ,     HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Control\Session Manager\Environment, DEVMGR_SHOW_NONPRESENT_DEVICES, 1 ; show hidden devices in device manager
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters, EnablePrefetcher, % (AHK_SSD ? 0 : 1) ; disable prefetch for ssd system drive
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters, EnableSuperfetch, % (AHK_SSD ? 0 : 1) ; disable prefetch for ssd system drive
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Control\SessionManager\Memory Management, ClearPageFileAtShutdown, 0
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Control\SessionManager\Memory Management, LargeSystemCache, 0
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot,    Start, % (AHK_SSD ? 0 : 1) ; for SSD system drive
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Services\Cdrom,                      Autorun, 0 ; no CD autoplay
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Services\upnphost,                   Start, 4 ; disable UPNP service
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Services\cisvc,                      Start, 4 ; disable indexing service
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Services\SSDPSRV,                    Start, 4 ; disable SSDP service
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Services\helpsvc,                    Start, 4 ; disable support service
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Services\ersvc,                      Start, 4 ; disable error reporting service
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Command Processor,                         EnableExtensions, 1 ; enables shell-extensions
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Command Processor,                         DelayedExpension, 1 ; enables shell variable delayed interpretation
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Command Processor,                         CompletionChar, 64 ; enables shell tab-completion
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Command Processor,                         PathCompletionChar, 64 ; enables shell tab-completion
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Command Processor,                         DelayedExpension, 1 ; enables shell variable delayed interpretation
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\SchedulingAgent,                           NotifyOnTaskMiss, 0 ; don't notify missed tasks
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\PCHealth\ErrorReporting,                   DoReport, 0 ; disable error reporting
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Policies\Microsoft\Windows\WindowsUpdate\AU,         NoAutoRebootWithLoggedOnUsers, 1 ; disable reboot after a system update
	; RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon,        DisableCAD, 1 ; disable Ctrl-Alt-Delete !
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon,        AllowMultipleTSSessions, 0 ; disable Fast User Switching
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon,        AutoRestartShell, 1 ; auto restart Explorer after crash
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Explorer,           ShowDriveLettersFirst, 1 ; show drive letters first
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Explorer,           AlwaysUnloadDll, 1 ; unload no more used DLLs
	RegWrite, REG_SZ,     HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Explorer,           Max Cached Icons, 8192 ; icon cache file size (C:\Users\User-Name\AppData\Local\IconCache.db)
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{645FF040-5081-101B-9F08-00AA002F954E},           Default, Corbeille ; rename recycle bin

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,  NoCDBurning, 1
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,  NoDriveTypeAutoRun, 0x000000bd ; no autorun
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,  NoRun, 1 ; no run menu
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,  NoStartMenuMyMusic, 1 ; no music menu
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,  NoSMMyPictures, 1 ; no image menu
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,  NoFavoritesMenu, 1 ; no favorites menu
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,  NoSMConfigurePrograms, 1 ; no program configuration menu
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,  NoSimpleStartMenu, 1 ; classic XP menu
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,  ForceClassicControlPanel, 1 ; classic control panel
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,  NoSetActiveDesktop, 1 ; no active desktop
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,  NoShellSearchButton, 1 ; no start menu search
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,  StartMenuLogOff, 1 ; no log-off in start menu
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,  ForceStartMenuLogOff, 0 ; no log-off in start menu
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SOFTWARE\Policies\Microsoft\Messenger\Client,                 PreventAutoRun, 1 ; prevent messenger from being run
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SOFTWARE\Policies\Microsoft\Messenger\Client,                 PreventRun, 1 ; prevent messenger from being run

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Set logon background from media\logon*.jpg :
	RegWrite, REG_DWORD,  HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\Background, OEMBackground, 1 ; change logon background
	LOC_BackgroundA := Array()
	, LOC_LogonCount := 0
	Loop, Files, %A_ScriptDir%\media\logon*.jpg
	{
		LOC_BackgroundA[A_Index] := A_LoopFileLongPath
		, LOC_LogonCount++
	}
	If (LOC_LogonCount) {
		Random, LOC_LogonIndex, 1, LOC_LogonCount
		LOC_File := LOC_BackgroundA[LOC_LogonIndex]
		FileCreateDir, %A_WinDir%\System32\oobe\info\backgrounds
		APP_RunAs()
		Try {
			Run, xcopy /r /h /y "%LOC_File%" "%A_WinDir%\System32\oobe\info\backgrounds\backgroundDefault.jpg", , Hide
			; AHK_Debug("FileCopy, ", LOC_BackgroundA[LOC_LogonIndex] . ", " . A_WinDir . "\System32\oobe\info\backgrounds\backgroundDefault.jpg, 1")
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "SYS_WriteRegistryOptions", PRM_KillRegServer)
		}
		RunAs
	}

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Hide usual files & folders :
	Try {
		FileSetAttrib, -RSH, %A_AppData%, 2
	} Catch LOC_Exception {
		AHK_Catch(LOC_Exception, "AHK_SaveIniFile")
	}
	Try {
		FileSetAttrib, +SH, %A_Startup%, 2
	} Catch LOC_Exception {
		AHK_Catch(LOC_Exception, "AHK_SaveIniFile")
	}
	Try {
		FileSetAttrib, +SH, %A_StartupCommon%, 2
	} Catch LOC_Exception {
		AHK_Catch(LOC_Exception, "AHK_SaveIniFile")
	}
	Try {
		FileSetAttrib, +SH, C:\service.log
	} Catch LOC_Exception {
		AHK_Catch(LOC_Exception, "AHK_SaveIniFile")
	}
	
	EnvGet, LOC_ProgramData, ProgramData
	If (LOC_ProgramData
		&& FileExist(LOC_ProgramData)) {
		Try {
			FileSetAttrib, +H, %LOC_ProgramData%, 2
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "AHK_SaveIniFile")
		}
	}
	If (!A_Is64bitOS) {
		Try {
			FileSetAttrib, -RSH, %A_AppDataCommon%, 2
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "AHK_SaveIniFile")
		}
		Try {
			FileSetAttrib, -RSH, %A_AppData%\..\Local Settings, 2
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "AHK_SaveIniFile")
		}
		Try {
			FileSetAttrib, -RSH, %A_AppData%\..\Local Settings\Application Data, 2
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "AHK_SaveIniFile")
		}
	}
	RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, EnableBalloonTips, % (TRY_TrayTipEnabled ? 1 : 0)
	RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, EnableBalloonTips, % (TRY_TrayTipEnabled ? 1 : 0)
	SendMessage, 0x001A, , , , ahk_id 0xFFFF ; 0x001A is WM_SETTINGCHANGE ; 0xFFFF is HWND_BROADCAST
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	; RegServer & Windows update commands :
	RegRead, LOC_LastExecutionDay, HKEY_LOCAL_MACHINE, SOFTWARE\AutoHotkey, LastExecutionDay
	If (ErrorLevel) {
		LOC_LastExecutionDay := 0
	}
	If (LOC_LastExecutionDay == 0
		|| LOC_LastExecutionDay > A_YDay
		|| A_YDay - LOC_LastExecutionDay > 7) {
		APP_RunAs()
		If (!A_Is64bitOS) {
			Try {
				Run, %A_WinDir%\system32\regsvr32.exe /u zipfldr.dll, , Hide UseErrorLevel, STA_RegServer1 ; disable Windows support for ZIP files
			} Catch LOC_Exception {
				AHK_Catch(LOC_Exception, "SYS_WriteRegistryOptions")
			}
			Try {
				Run, %A_WinDir%\system32\regsvr32.exe /u %A_WinDir%\system32\regwizc.dll, , Hide UseErrorLevel, STA_RegServer2 ; prevent Microsoft from reading HWID and MSID
			} Catch LOC_Exception {
				AHK_Catch(LOC_Exception, "SYS_WriteRegistryOptions")
			}
			SetTimer, SYS_KillRegServer, %ZZZ_KillRegServerTimer%
		}
		Try {
			Run, "%A_WinDir%\system32\rundll32.exe" iedkcs32.dll`,Clear ; disable IE branding
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "SYS_WriteRegistryOptions")
		}
		SetTimer, SYS_WindowsUpdate, -1
		RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, SOFTWARE\AutoHotkey, LastExecutionDay, %A_YDay%
	} Else {
		;~ Run, %A_WinDir%\system32\sc.exe stop trustedinstaller, , Hide UseErrorLevel
		;~ Run, %A_WinDir%\system32\sc.exe config trustedinstaller start= disabled, , Hide UseErrorLevel
		;~ Run, %A_WinDir%\system32\sc.exe stop wuauserv, , Hide UseErrorLevel
		;~ Run, %A_WinDir%\system32\sc.exe config wuauserv start= disabled, , Hide UseErrorLevel
	}
	RegDelete, HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion, HWID ; prevent Microsoft from reading HardWare ID
	RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RemoteComputer\NameSpace, {D6277990-4C6A-11CF-8D87-00AA0060F5BF} ; speed up access to network shares
	RegDelete, HKEY_CURRENT_USER,  Software\Microsoft\Windows\CurrentVersion, MSID ; prevent Microsoft from reading MSID
	RegDelete, HKEY_CURRENT_USER,  Software\Microsoft\MediaPlayer\Player\CurrentVersion\RecentFileList ; prevent WMP from keeping history
	RunAs
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Windows update { Ctrl + Win + W } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^#w::
SYS_WindowsUpdate:
SYS_WindowsUpdate()
Return

SYS_WindowsUpdate() {
	Global LOG_DomainLogin, LOG_DomainEncryptedPassword
	TRY_ShowTrayTip("Launching Windows Update...")
	APP_RunAs()
	/*
		sc.exe config trustedinstaller start= demand
		sc.exe start trustedinstaller
		sc.exe config wuauserv start= demand
		sc.exe start wuauserv
		wuapp.exe startmenu
	*/
	RunWait, %A_WinDir%\system32\sc.exe config trustedinstaller start= demand, , Hide UseErrorLevel
	RunWait, %A_WinDir%\system32\sc.exe start trustedinstaller, , Hide UseErrorLevel
	RunWait, %A_WinDir%\system32\sc.exe config wuauserv start= demand, , Hide UseErrorLevel
	RunWait, %A_WinDir%\system32\sc.exe start wuauserv, , Hide UseErrorLevel
	Run, %A_WinDir%\system32\wuapp.exe startmenu, , Maximize UseErrorLevel
	TRY_ShowTrayTip("Windows Update launched")
	RunAs
}

#IfWinActive, Windows Update ahk_class #32770, &Redémarrer maintenant
Esc::
ControlFocus, ComboBox1
SendInput, {End}
ControlFocus, Button2
SendInput, {Space}
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Classic Start Menu :
;;;;;;;;;;;;;;;;;;;;;;

SYS_SetClassicStartMenu() {
	Global APP_ClassicStartMenuPath
	If (APP_ClassicStartMenuPath) {
		SplitPath, APP_ClassicStartMenuPath, LOC_ProcessName
		Process, Exist, %LOC_ProcessName%
		If (!ErrorLevel) {
			Run, "%APP_ClassicStartMenuPath%", , Hide UseErrorLevel
		}
		SetTimer, SYS_KillClassicStartMenu, 15000
	}
}

SYS_KillClassicStartMenu:
SYS_KillClassicStartMenu()
Return

SYS_KillClassicStartMenu() {
	Global APP_ClassicStartMenuPath
	SplitPath, APP_ClassicStartMenuPath, LOC_ProcessName
	Process, Exist, %LOC_ProcessName%
	If(ErrorLevel) {
		Process, Close, %ErrorLevel%
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Start menu manager :
;;;;;;;;;;;;;;;;;;;;;;

SYS_StartMenuDisplayTimer:
SYS_StartMenuDisplayTimer()
Return

SYS_StartMenuDisplayTimer(PRM_WinKeyDown = false) {
	
	Global SCR_VirtualScreenX, SCR_VirtualScreenY
	Static STA_InitialMouseX := SCR_VirtualScreenX - 1, STA_InitialMouseY := SCR_VirtualScreenY - 1, STA_InitialCountdown := 10, STA_StartMenuCountdown := STA_InitialCountdown

	CoordMode, Mouse, Screen
	MouseGetPos, LOC_MouseX, LOC_MouseY, LOC_HoveredWindowID
	WinGetClass, LOC_HoveredClass, ahk_id %LOC_HoveredWindowID%
	WinGetTitle, LOC_HoveredTitle, ahk_id %LOC_HoveredWindowID%

	; Hovering start menu :
	If (LOC_HoveredClass == "ClassicShell.CMenuContainer"
		|| LOC_HoveredClass == "ClassicShell.CStartButton"
		|| LOC_HoveredClass == "Button" && LOC_HoveredTitle == "Démarrer") {
		STA_InitialMouseX := LOC_MouseX
		, STA_InitialMouseY := LOC_MouseY
		, STA_StartMenuCountDown := STA_InitialCountdown
		Return
	}

	; Not hovering start menu, but mouse still hasn't moved :
	If (STA_InitialMouseX == SCR_VirtualScreenX - 1
		&& STA_InitialMouseY == SCR_VirtualScreenY - 1) {
		STA_InitialMouseX := LOC_MouseX
		, STA_InitialMouseY := LOC_MouseY
		, STA_StartMenuCountDown := STA_InitialCountdown
		Return
	}
	
	; Not hovering start menu, and mouse has moved :
	If (LOC_MouseX != STA_InitialMouseX
		|| LOC_MouseY != STA_InitialMouseY
		|| STA_StartMenuCountDown != STA_InitialCountdown) {
		If (STA_StartMenuCountDown) {
			If (WinExist("ahk_group WIN_StartMenuGroup")) {
				If (WinExist("ahk_class #32768")) {
					STA_StartMenuCountDown := STA_InitialCountdown
					Return
				}
				
				STA_StartMenuCountDown--
				If (STA_StartMenuCountDown) {
					WinSet, Transparent, Transparent, %STA_StartMenuTransparency%, ahk_group WIN_StartMenuGroup
					Return
				}
				SendInput, {LWin} ; make start menu disappear
			}
		}
		
		STA_StartMenuCountDown := 0
		, STA_InitialMouseX := SCR_VirtualScreenX - 1
		, STA_InitialMouseY := SCR_VirtualScreenY - 1
	}
}		

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Start menu system tooltip :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SYS_GetCPUAndMemoryInfosPeriodicTimer:
SYS_GetCPUAndMemoryInfos()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SYS_GetCPUAndMemoryInfos() {

	Global ZZZ_CloseHandleFunction
	Static STA_ProcessorCount := 0, STA_IdleTime, STA_CPUTick, STA_KernelTimeA := {}, STA_UserTimeA := {}
	Static STA_GetSystemTimesFunction := AHK_GetFunction("kernel32", "GetSystemTimes"), STA_GlobalMemoryStatusExFunction := AHK_GetFunction("kernel32", "GlobalMemoryStatusEx"), STA_OpenProcessFunction := AHK_GetFunction("kernel32", "OpenProcess"), STA_GetProcessTimesFunction := AHK_GetFunction("kernel32", "GetProcessTimes"), STA_GetProcessMemoryInfoFunction := AHK_GetFunction("psapi", "GetProcessMemoryInfo")

/* 		LOC_ProcessHandler := DllCall("kernel32.dll\OpenProcess", "UInt", 0x10|0x400, "Int", 0, "UInt", LOC_Process.ProcessID)
		, DllCall("kernel32.dll\GetProcessTimes", "UInt", LOC_ProcessHandler, "Int64P", LOC_CreationTime, "Int64P", LOC_ExitTime, "Int64P", LOC_KernelTime, "Int64P", LOC_UserTime)
		, DllCall(ZZZ_CloseHandleFunction, "UInt", LOC_ProcessHandler)
 */

	; Init :
	Critical, On
	If (!STA_ProcessorCount) {
		EnvGet, STA_ProcessorCount, NUMBER_OF_PROCESSORS
		VarSetCapacity(LOC_IdleTicks, 8, 0)
		, DllCall(STA_GetSystemTimesFunction, "UInt", &LOC_IdleTicks, "UInt", 0, "UInt", 0)
		, STA_IdleTime := *(&LOC_IdleTicks)
		Loop, 7 {
			STA_IdleTime += *(&LOC_IdleTicks + A_Index) << (8 * A_Index)
		}
		STA_CPUTick := A_TickCount
	}
	Critical, Off

	; CPU & Memory tooltip :
	Loop, 5 {
		LOC_MaxCPUProcess%A_Index% := LOC_MaxMemoryProcess%A_Index% := ""
		, LOC_MaxCPULoad%A_Index% := LOC_MaxMemoryLoad%A_Index% := 0
	}
	VarSetCapacity(LOC_Memory, 64, 0)
	, NumPut(64, LOC_Memory)
	, DllCall(STA_GlobalMemoryStatusExFunction, "UInt", &LOC_Memory)
	, LOC_MemoryRatio := *(&LOC_Memory + 4)
	, LOC_TotalMemory := NumGet(LOC_Memory, 8, "Int64")
	, LOC_OldIdleTime := STA_IdleTime
	, LOC_OldCPUTick := STA_CPUTick
	, VarSetCapacity(LOC_IdleTicks, 8, 0)
	, DllCall(STA_GetSystemTimesFunction, "UInt", &LOC_IdleTicks, "UInt", 0, "UInt", 0)
	, STA_IdleTime := *(&LOC_IdleTicks)
	Loop, 7 {
		STA_IdleTime += *(&LOC_IdleTicks + A_Index) << (8 * A_Index)
	}
	STA_CPUTick := A_TickCount
	, LOC_TotalCPU := 100 - Max(1, Round((STA_IdleTime - LOC_OldIdleTime) / (STA_CPUTick - LOC_OldCPUTick) / (100 * STA_ProcessorCount)))
	, LOC_CPULoadSum := 0
	Try {
		For LOC_Process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process") {
			If (LOC_Process.Name == "System"
				|| LOC_Process.Name == "System Idle Process") {
				Continue
			}
			LOC_ProcessHandler := DllCall(STA_OpenProcessFunction, "UInt", 0x10|0x400, "Int", 0, "UInt", LOC_Process.ProcessID)
			, DllCall(STA_GetProcessTimesFunction, "UInt", LOC_ProcessHandler, "Int64P", LOC_CreationTime, "Int64P", LOC_ExitTime, "Int64P", LOC_KernelTime, "Int64P", LOC_UserTime)
			, VarSetCapacity(LOC_MemoryCounters, 40, 0)
			, DllCall(STA_GetProcessMemoryInfoFunction, "UInt", LOC_ProcessHandler, "UInt", &LOC_MemoryCounters, "UInt", 40)
			, LOC_MemoryLoad := NumGet(LOC_MemoryCounters, 12, "UInt")
			, DllCall(ZZZ_CloseHandleFunction, "UInt", LOC_ProcessHandler)
			If (STA_KernelTimeA[LOC_Process.ProcessID]
				|| STA_UserTimeA[LOC_Process.ProcessID]) {
				LOC_CPULoad := Min(99, Round((LOC_KernelTime - STA_KernelTimeA[LOC_Process.ProcessID] + LOC_UserTime - STA_UserTimeA[LOC_Process.ProcessID]) / (100000 * STA_ProcessorCount)))
				If (LOC_CPULoad > LOC_MaxCPULoad1) {
					LOC_MaxCPULoad5 := LOC_MaxCPULoad4
					, LOC_MaxCPULoad4 := LOC_MaxCPULoad3
					, LOC_MaxCPULoad3 := LOC_MaxCPULoad2
					, LOC_MaxCPULoad2 := LOC_MaxCPULoad1
					, LOC_MaxCPULoad1 := LOC_CPULoad
					, LOC_MaxCPUProcess5 := LOC_MaxCPUProcess4
					, LOC_MaxCPUProcess4 := LOC_MaxCPUProcess3
					, LOC_MaxCPUProcess3 := LOC_MaxCPUProcess2
					, LOC_MaxCPUProcess2 := LOC_MaxCPUProcess1
					, LOC_MaxCPUProcess1 := LOC_Process.Name
				} Else
				If (LOC_CPULoad > LOC_MaxCPULoad2) {
					LOC_MaxCPULoad5 := LOC_MaxCPULoad4
					, LOC_MaxCPULoad4 := LOC_MaxCPULoad3
					, LOC_MaxCPULoad3 := LOC_MaxCPULoad2
					, LOC_MaxCPULoad2 := LOC_CPULoad
					, LOC_MaxCPUProcess5 := LOC_MaxCPUProcess4
					, LOC_MaxCPUProcess4 := LOC_MaxCPUProcess3
					, LOC_MaxCPUProcess3 := LOC_MaxCPUProcess2
					, LOC_MaxCPUProcess2 := LOC_Process.Name
				} Else
				If (LOC_CPULoad > LOC_MaxCPULoad3) {
					LOC_MaxCPULoad5 := LOC_MaxCPULoad4
					, LOC_MaxCPULoad4 := LOC_MaxCPULoad3
					, LOC_MaxCPULoad3 := LOC_CPULoad
					, LOC_MaxCPUProcess5 := LOC_MaxCPUProcess4
					, LOC_MaxCPUProcess4 := LOC_MaxCPUProcess3
					, LOC_MaxCPUProcess3 := LOC_Process.Name
				} Else
				If (LOC_CPULoad > LOC_MaxCPULoad4) {
					LOC_MaxCPULoad5 := LOC_MaxCPULoad4
					, LOC_MaxCPULoad4 := LOC_CPULoad
					, LOC_MaxCPUProcess5 := LOC_MaxCPUProcess4
					, LOC_MaxCPUProcess4 := LOC_Process.Name
				} Else
				If (LOC_CPULoad > LOC_MaxCPULoad5) {
					LOC_MaxCPULoad5 := LOC_CPULoad
					, LOC_MaxCPUProcess5 := LOC_Process.Name
				}
				LOC_CPULoadSum += LOC_CPULoad
			}
			STA_KernelTimeA[LOC_Process.ProcessID] := LOC_KernelTime
			, STA_UserTimeA[LOC_Process.ProcessID] := LOC_UserTime
			If (LOC_MemoryLoad > LOC_MaxMemoryLoad1) {
				LOC_MaxMemoryLoad5 := LOC_MaxMemoryLoad4
				, LOC_MaxMemoryLoad4 := LOC_MaxMemoryLoad3
				, LOC_MaxMemoryLoad3 := LOC_MaxMemoryLoad2
				, LOC_MaxMemoryLoad2 := LOC_MaxMemoryLoad1
				, LOC_MaxMemoryLoad1 := LOC_MemoryLoad
				, LOC_MaxMemoryProcess5 := LOC_MaxMemoryProcess4
				, LOC_MaxMemoryProcess4 := LOC_MaxMemoryProcess3
				, LOC_MaxMemoryProcess3 := LOC_MaxMemoryProcess2
				, LOC_MaxMemoryProcess2 := LOC_MaxMemoryProcess1
				, LOC_MaxMemoryProcess1 := LOC_Process.Name
			} Else
			If (LOC_MemoryLoad > LOC_MaxMemoryLoad2) {
				LOC_MaxMemoryLoad5 := LOC_MaxMemoryLoad4
				, LOC_MaxMemoryLoad4 := LOC_MaxMemoryLoad3
				, LOC_MaxMemoryLoad3 := LOC_MaxMemoryLoad2
				, LOC_MaxMemoryLoad2 := LOC_MemoryLoad
				, LOC_MaxMemoryProcess5 := LOC_MaxMemoryProcess4
				, LOC_MaxMemoryProcess4 := LOC_MaxMemoryProcess3
				, LOC_MaxMemoryProcess3 := LOC_MaxMemoryProcess2
				, LOC_MaxMemoryProcess2 := LOC_Process.Name
			} Else
			If (LOC_MemoryLoad > LOC_MaxMemoryLoad3) {
				LOC_MaxMemoryLoad5 := LOC_MaxMemoryLoad4
				, LOC_MaxMemoryLoad4 := LOC_MaxMemoryLoad3
				, LOC_MaxMemoryLoad3 := LOC_MemoryLoad
				, LOC_MaxMemoryProcess5 := LOC_MaxMemoryProcess4
				, LOC_MaxMemoryProcess4 := LOC_MaxMemoryProcess3
				, LOC_MaxMemoryProcess3 := LOC_Process.Name
			} Else
			If (LOC_MemoryLoad > LOC_MaxMemoryLoad4) {
				LOC_MaxMemoryLoad5 := LOC_MaxMemoryLoad4
				LOC_MaxMemoryLoad4 := LOC_MemoryLoad
				, LOC_MaxMemoryProcess5 := LOC_MaxMemoryProcess4
				, LOC_MaxMemoryProcess4 := LOC_Process.Name
			} Else
			If (LOC_MemoryLoad > LOC_MaxMemoryLoad5) {
				LOC_MaxMemoryLoad5 := LOC_MemoryLoad
				, LOC_MaxMemoryProcess5 := LOC_Process.Name
			}
		}
		SYS_StartButtonTooltipPeriodicTimer(LOC_TotalMemory, LOC_MemoryRatio, LOC_MaxMemoryLoad1, LOC_MaxMemoryProcess1, LOC_MaxMemoryLoad2, LOC_MaxMemoryProcess2, LOC_MaxMemoryLoad3, LOC_MaxMemoryProcess3, LOC_MaxMemoryLoad4, LOC_MaxMemoryProcess4, LOC_MaxMemoryLoad5, LOC_MaxMemoryProcess5, LOC_TotalCPU, PRM_MaxCPULoad1 := Min(99, Round(LOC_MaxCPULoad1 * LOC_TotalCPU / LOC_CPULoadSum)), LOC_MaxCPUProcess1, PRM_MaxCPULoad2 := Min(99, Round(LOC_MaxCPULoad2 * LOC_TotalCPU / LOC_CPULoadSum)), LOC_MaxCPUProcess2, PRM_MaxCPULoad3 := Min(99, Round(LOC_MaxCPULoad3 * LOC_TotalCPU / LOC_CPULoadSum)), LOC_MaxCPUProcess3, PRM_MaxCPULoad4 := Min(99, Round(LOC_MaxCPULoad4 * LOC_TotalCPU / LOC_CPULoadSum)), LOC_MaxCPUProcess4, PRM_MaxCPULoad5 := Min(99, Round(LOC_MaxCPULoad5 * LOC_TotalCPU / LOC_CPULoadSum)), LOC_MaxCPUProcess5)
	} Catch LOC_Exception {
		AHK_Catch(LOC_Exception, "SYS_UpdateCPUAndMemoryBars")
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SYS_StartButtonTooltipPeriodicTimer:
SYS_StartButtonTooltipPeriodicTimer()
Return

SYS_StartButtonTooltipPeriodicTimer(PRM_TotalMemory = -1, PRM_MemoryRatio = -1, PRM_MaxMemoryLoad1 = -1, PRM_MaxMemoryProcess1 = -1, PRM_MaxMemoryLoad2 = -1, PRM_MaxMemoryProcess2 = -1, PRM_MaxMemoryLoad3 = -1, PRM_MaxMemoryProcess3 = -1, PRM_MaxMemoryLoad4 = -1, PRM_MaxMemoryProcess4 = -1, PRM_MaxMemoryLoad5 = -1, PRM_MaxMemoryProcess5 = -1, PRM_TotalCPU = -1, PRM_MaxCPULoad1 = -1,PRM_MaxCPUProcess1 = -1, PRM_MaxCPULoad2 = -1,PRM_MaxCPUProcess2 = -1, PRM_MaxCPULoad3 = -1,PRM_MaxCPUProcess3 = -1, PRM_MaxCPULoad4 = -1,PRM_MaxCPUProcess4 = -1, PRM_MaxCPULoad5 = -1,PRM_MaxCPUProcess5 = -1) {

	Static STA_TotalMemory := false, STA_TotalMemoryString := "", STA_MemoryRatio := false, STA_MemoryRatioString := "", STA_MaxMemoryLoad1 := false, STA_MaxMemoryLoadString1 := "", STA_MaxMemoryProcess1 := "", STA_MaxMemoryLoad2 := false, STA_MaxMemoryLoadString2 := "", STA_MaxMemoryProcess2 := "", STA_MaxMemoryLoad3 := false, STA_MaxMemoryLoadString3 := "", STA_MaxMemoryProcess3 := "", STA_MaxMemoryLoad4 := false, STA_MaxMemoryLoadString4 := "", STA_MaxMemoryProcess4 := "", STA_MaxMemoryLoad5 := false, STA_MaxMemoryLoadString5 := "", STA_MaxMemoryProcess5 := "", STA_TotalCPU := false, STA_MaxCPULoad1 := false, STA_MaxCPUProcess1 := false, STA_MaxCPULoad2 := false, STA_MaxCPUProcess2 := false, STA_MaxCPULoad3 := false, STA_MaxCPUProcess3 := false, STA_MaxCPULoad4 := false, STA_MaxCPUProcess4 := false, STA_MaxCPULoad5 := false, STA_MaxCPUProcess5 := false
	, STA_MouseOnStartButton := false, STA_LastToolTipTimestamp := 0, STA_DisplayToolTip := false, STA_ShellTrayID := 0, STA_ToolTipHeight := 0, STA_StrFormatByteSize64AFunction := false

	If (PRM_TotalMemory != -1
		|| PRM_MemoryRatio != -1
		|| PRM_MaxMemoryLoad1 != -1
		|| PRM_MaxMemoryProcess1 != -1
		|| PRM_MaxMemoryLoad2 != -1
		|| PRM_MaxMemoryProcess2 != -1
		|| PRM_MaxMemoryLoad3 != -1
		|| PRM_MaxMemoryProcess3 != -1
		|| PRM_MaxMemoryLoad4 != -1
		|| PRM_MaxMemoryProcess4 != -1
		|| PRM_MaxMemoryLoad5 != -1
		|| PRM_MaxMemoryProcess5 != -1
		|| PRM_TotalCPU != -1
		|| PRM_MaxCPULoad1 != -1
		|| PRM_MaxCPUProcess1 != -1
		|| PRM_MaxCPULoad2 != -1
		|| PRM_MaxCPUProcess2 != -1
		|| PRM_MaxCPULoad3 != -1
		|| PRM_MaxCPUProcess3 != -1
		|| PRM_MaxCPULoad4 != -1
		|| PRM_MaxCPUProcess4 != -1
		|| PRM_MaxCPULoad5 != -1
		|| PRM_MaxCPUProcess5 != -1) {

		If (!STA_StrFormatByteSize64AFunction) {
			STA_StrFormatByteSize64AFunction := AHK_GetFunction("shlwapi", "StrFormatByteSize64A")
		}
		If (PRM_TotalMemory != -1
			&& STA_TotalMemory != PRM_TotalMemory) {
			STA_TotalMemory := PRM_TotalMemory
			, STA_DisplayToolTip := true
			, VarSetCapacity(STA_TotalMemoryString, 16, 0)
			, DllCall(STA_StrFormatByteSize64AFunction, "Int64", PRM_TotalMemory, "Str", STA_TotalMemoryString, "UInt", 16)
		}
		If (PRM_MemoryRatio != -1
			&& PRM_MemoryRatio != STA_MemoryRatio) {
			STA_MemoryRatio := PRM_MemoryRatio
			, STA_DisplayToolTip := true
			, VarSetCapacity(STA_MemoryRatioString, 16, 0)
			, DllCall(STA_StrFormatByteSize64AFunction, "Int64", PRM_MemoryRatio * STA_TotalMemory // 100, "Str", STA_MemoryRatioString, "UInt", 16)
		}
		If (PRM_TotalCPU != -1
			&& STA_TotalCPU != PRM_TotalCPU) {
			STA_TotalCPU := Min(99, Max(PRM_TotalCPU, PRM_MaxCPULoad1 + PRM_MaxCPULoad2 + PRM_MaxCPULoad3 + PRM_MaxCPULoad4 + PRM_MaxCPULoad5))
			, STA_DisplayToolTip := true
		}
		Loop, 5 {
			If (PRM_MaxMemoryLoad%A_Index% != -1
				&& STA_MaxMemoryLoad%A_Index% != PRM_MaxMemoryLoad%A_Index%) {
				STA_MaxMemoryLoad%A_Index% := PRM_MaxMemoryLoad%A_Index%
				, VarSetCapacity(STA_MaxMemoryLoadString%A_Index%, 16, 0)
				, DllCall(STA_StrFormatByteSize64AFunction, "Int64", PRM_MaxMemoryLoad%A_Index%, "Str", STA_MaxMemoryLoadString%A_Index%, "UInt", 16)
				, STA_DisplayToolTip := true
			}
		}
		LOC_Variables := "MaxMemoryProcess|MaxCPULoad|MaxCPUProcess"
		Loop, Parse, LOC_Variables, |
		{
			LOC_Variable := A_LoopField
			Loop, 5 {
				If (PRM_%LOC_Variable%%A_Index% != -1
					&& STA_%LOC_Variable%%A_Index% != PRM_%LOC_Variable%%A_Index%) {
					STA_%LOC_Variable%%A_Index% := PRM_%LOC_Variable%%A_Index%
					, STA_DisplayToolTip := true
				}
			}
		}
		Return
	}

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Tooltip :
	If (!A_IsSuspended) {
		DetectHiddenWindows, Off
		CoordMode, Mouse, Screen
		MouseGetPos, , , LOC_WindowID, LOC_ControlClass
		WinGetClass, LOC_WindowClass, ahk_id %LOC_WindowID%
		WinGetTitle, LOC_WindowTitle, ahk_id %LOC_WindowID%
		If (LOC_WindowClass == "Shell_TrayWnd"
				&& (A_Is64bitOS && LOC_ControlClass == ""
					|| !A_Is64bitOS && LOC_ControlClass == "Button1")
			|| LOC_WindowClass == "ClassicShell.CStartButton"
			|| LOC_WindowClass == "ClassicShell.CMenuContainer"
			|| A_Is64bitOS
				&& LOC_WindowClass == "DV2ControlHost"
				&& LOC_WindowTitle != "Liste de raccourcis"
			; || LOC_WindowClass == "BaseBar"
			|| LOC_WindowTitle == "Démarrer" 
				&& LOC_WindowClass == "Button") {
			If (!STA_MouseOnStartButton
				|| STA_DisplayToolTip
				|| A_TickCount - STA_LastToolTipTimestamp > 500) {
				If (!STA_ShellTrayID
					|| !WinExist("ahk_id " . STA_ShellTrayID)) {
					WinGet, STA_ShellTrayID, ID, ahk_class Shell_TrayWnd
				}
				LOC_ToolTip := "RAM`t: " . STA_MemoryRatio . "% (" . STA_MemoryRatioString . " / " . STA_TotalMemoryString . ")`n"
				Loop, 5 {
					LOC_ToolTip .= "`t  " . STA_MaxMemoryProcess%A_Index% . (StrLen(STA_MaxMemoryProcess%A_Index%) < 13 ? "`t" : "") . "`t: " . STA_MaxMemoryLoadString%A_Index% . "`n"
				}
				LOC_ToolTip .= "`t`t`t`t`t`t`nCPU`t: " . STA_TotalCPU . "%"
				Loop, 5 {
					LOC_ToolTip .= (STA_MaxCPULoad%A_Index% > 0 ? "`n`t  " . STA_MaxCPUProcess%A_Index% . (StrLen(STA_MaxCPUProcess%A_Index%) < 13 ? "`t" : "") . "`t: " . STA_MaxCPULoad%A_Index% . "%" : "`n")
				}
				If (!STA_ShellTrayID) {
					TRY_ShowTrayTip(LOC_ToolTip)
				} Else {
					WinGetPos, LOC_TrayX, LOC_TrayY, LOC_TrayWidth, , ahk_id %STA_ShellTrayID%
					AHK_ShowToolTip(LOC_ToolTip, PRM_Seconds := 1, PRM_Transparency := 220, LOC_TrayX + LOC_TrayWidth, LOC_TrayY - STA_ToolTipHeight - 3)
					If (!STA_ToolTipHeight) {
						WinGetPos, , , , STA_ToolTipHeight, ToolTip ahk_class AutoHotkeyGUI
						AHK_ShowToolTip(LOC_ToolTip, PRM_Seconds := 1, PRM_Transparency := 220, LOC_TrayX + LOC_TrayWidth, LOC_TrayY - STA_ToolTipHeight - 3)
					}
				}
				STA_LastToolTipTimestamp := A_TickCount
				, STA_DisplayToolTip := false
			}

			If (!STA_MouseOnStartButton) {
				If (!WinExist("ahk_class BaseBar")) {
					; SendInput, {LWin}
				}
				STA_MouseOnStartButton := true
			}
		} Else {
			If (STA_MouseOnStartButton) {
				If (LOC_WindowClass != "BaseBar"
					&& LOC_WindowClass != "Shell_TrayWnd"
					&& WinExist("ahk_class BaseBar")) {
					; SendInput, {LWin}
				}
				If (LOC_WindowClass != "Shell_TrayWnd") {
					STA_MouseOnStartButton := false
				}
				AHK_HideToolTip()
			}
		}
		DetectHiddenWindows, On
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Taskbar color :
;;;;;;;;;;;;;;;;;

SYS_TaskbarColorPeriodicTimer:
SYS_TaskbarColorPeriodicTimer()
Return

SYS_TaskbarColorPeriodicTimer(PRM_DisplayFusionID = 0) {

    Global AHK_ScriptInfo
	Static STA_InitialCount := 20, STA_Colors := "Red|Green|Blue"
    Static STA_OldRed := 255, STA_Red := 255, STA_RedStep := 0
    Static STA_OldGreen := 255, STA_Green := 255, STA_GreenStep := 0,
    Static STA_OldBlue := 255, STA_Blue := 255, STA_BlueStep := 0
    Static STA_Count := STA_InitialCount, STA_DisplayFusionID := 0, STA_ShellTrayID := 0

    ; Colors :
	If (STA_Count == STA_InitialCount) {
        Loop, Parse, STA_Colors, | ; Red|Green|Blue
        {
            Random, LOC_New%A_LoopField%, 0, 255
            STA_%A_LoopField%Step := (LOC_New%A_LoopField% - STA_Old%A_LoopField%) / STA_InitialCount
            STA_%A_LoopField% := STA_Old%A_LoopField%
            STA_Old%A_LoopField% := LOC_New%A_LoopField%
        }
    }
    STA_Count--
    If (STA_Count < 0) {
        STA_Count := STA_InitialCount
    }
    Loop, Parse, STA_Colors, |
    {
        Transform, LOC_Hexa%A_LoopField%, Floor, STA_%A_LoopField%
        SetFormat, Integer, Hex
        LOC_Hexa%A_LoopField% += 0
        SetFormat, Integer, D
        StringTrimLeft, LOC_Hexa%A_LoopField%, LOC_Hexa%A_LoopField%, 2
        If (STA_%A_LoopField% < 17) {
            LOC_Hexa%A_LoopField% := "0" . LOC_Hexa%A_LoopField%
        }
        STA_%A_LoopField% += STA_%A_LoopField%Step
    }
	
	; Shell tray :
	If (STA_ShellTrayID) {
		If (!WinExist("ahk_id " . STA_ShellTrayID)) {
			STA_ShellTrayID := 0
		}
	} Else {
		STA_ShellTrayID := WinExist("ahk_class Shell_TrayWnd")
	}
    If (STA_ShellTrayID) {
        Gui, 18:+LastFound ; GUI_ColoredTaskbar
		Gui, 18:Color, %LOC_HexaRed%%LOC_HexaGreen%%LOC_HexaBlue%
        Gui, 18:Show, NoActivate, GUI_ColoredTaskbar
        WinSetTitle, GUI_ColoredTaskbar
    } Else {
        Gui, 18:Cancel
    }
	
    ; DisplayFusion tray :
	If (PRM_DisplayFusionID) {
        STA_DisplayFusionID := PRM_DisplayFusionID
    }
    If (STA_DisplayFusionID) {
        If (WinExist("ahk_id " . STA_DisplayFusionID)) {
			Gui, 19:+LastFound ; GUI_DisplayFusionColoredTaskbar
            Gui, 19:Color, %LOC_HexaRed%%LOC_HexaGreen%%LOC_HexaBlue%
            Gui, 19:Show, NoActivate, GUI_DisplayFusionColoredTaskbar
			WinSetTitle, GUI_DisplayFusionColoredTaskbar
        } Else {
            Gui, 19:Cancel
			STA_DisplayFusionID := 0
        }
    }
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Tray clock :
;;;;;;;;;;;;;;

SYS_TaskbarClockPeriodicTimer:
SYS_TaskbarClockPeriodicTimer()
Return

SYS_TaskbarClockPeriodicTimer(PRM_ForceDisplay = false) {

	Global AHK_AudioEnabled
	Static STA_Day := "", STA_DDMMYYYY := "", STA_Time := ""

	If (!STA_Time) {
		ControlGetPos, LOC_SysClockX, LOC_SysClockY, LOC_SysClockWidth, LOC_SysClockHeight, TrayClockWClass1, ahk_class Shell_TrayWnd ; systray clock
		If (!LOC_SysClockWidth
			|| !LOC_SysClockHeight) {
			Return
		}
		If (A_Is64bitOS) {
			LOC_FontSize := 10
			, LOC_Padding := 21
			, LOC_Color := "White"
		} Else {
			LOC_FontSize := 9
			, LOC_Padding := 14
			, LOC_Color := "Black"
		}
		WinGet, LOC_ActiveWindowID, ID, A
		Gui, 46:Destroy ; GUI_Clock
		Gui, 46:-Caption +ToolWindow -Border +LastFound
		Gui, 46:Margin, 0, 0
		Gui, 46:Font, s%LOC_FontSize% Bold c%LOC_Color%, Arial Narrow
		If (A_Is64bitOS) {
			Gui, 46:Color, 000000
		}
		Gui, 46:Add, Text, w%LOC_SysClockWidth% Center vSTA_Day, Mercredi
		Gui, 46:Add, Text, xm+0 yp+%LOC_Padding% w%LOC_SysClockWidth% Center vSTA_DDMMYYYY, DDMMYYYY
		Gui, 46:Add, Text, xm+0 yp+%LOC_Padding% w%LOC_SysClockWidth% Center vSTA_Time, HH:MM:ss
		Gui, 46:Show, x%LOC_SysClockX% y%LOC_SysClockY% w%LOC_SysClockWidth% h%LOC_SysClockHeight% NoActivate, GUI_Clock
		WinGet, LOC_ClockID, ID
		SYS_DockWindowToWindow(PRM_WindowID := LOC_ClockID)
		WinActivate, ahk_id %LOC_ActiveWindowID%
	}

	FormatTime, LOC_Time, , HH:mm:ss
	If (LOC_Time != STA_Time
		|| PRM_ForceDisplay) {
		GuiControl, 46:, STA_Time, %LOC_Time%
		STA_Time := LOC_Time
		FormatTime, LOC_DDMMYYYY, , dd MMM yyyy
		If (LOC_DDMMYYYY != STA_DDMMYYYY
			|| PRM_ForceDisplay) {
			FormatTime, LOC_Day, , dddd
			GuiControl, 46:, STA_Day, %LOC_Day%
			GuiControl, 46:, STA_DDMMYYYY, %LOC_DDMMYYYY%
			STA_Day := LOC_Day
			, STA_DDMMYYYY := LOC_DDMMYYYY
		}
	}
	
	; Gong :
	If (A_Min == 0
		&& A_Sec == 0
		&& !A_IsSuspended
		&& 	AHK_AudioEnabled) {
		Try {
			SoundPlay, %A_ScriptDir%\media\clock.wav, Wait
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "SYS_TaskbarClockPeriodicTimer")
		}
	}

}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SYS_RestoreClock() {
	Gui, 46:Destroy
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SYS_DockWindowToWindow(PRM_WindowID, PRM_ParentWindowID = 0) {
	WinGet, LOC_ActiveWindowID, ID, A
	If (PRM_ParentWindowID) {
		WinGetClass, LOC_ParentClass, ahk_id %PRM_ParentWindowID%
	} Else {
		LOC_ParentClass := "Shell_TrayWnd"
	}
	LOC_TrayHandler := DllCall("user32.dll\FindWindowEx", "UInt", 0, "UInt", 0, "Str", LOC_ParentClass, "UInt", 0)
	DllCall("user32.dll\SetParent", "UInt", PRM_WindowID, "UInt", LOC_TrayHandler)
	If (LOC_ActiveWindowID) {
		WinActivate, ahk_id %LOC_ActiveWindowID%
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Quick Month Calendar { Hovering clock zone } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SYS_TaskbarCalendarPeriodicTimer:
SYS_TaskbarCalendarPeriodicTimer()
Return

SYS_TaskbarCalendarPeriodicTimer(PRM_Hide = false) {

	Global SCR_VirtualScreenWidth, SCR_VirtualScreenHeight, AHK_ScriptInfo
	Static STA_CalendarWindowID := 0, STA_CountDown := -1, STA_CountUp := 0

	If (PRM_Hide) {
		WinSet, Transparent, 0, ahk_id %STA_CalendarWindowID%
		STA_CountDown := -1
		Return
	}
	MouseGetPos, , , LOC_WindowID, LOC_ControlClass
	If (LOC_WindowID == STA_CalendarWindowID
		&& STA_CalendarWindowID != 0) {
		If (STA_CountDown != 7) {
			WinSet, Transparent, 255, ahk_id %STA_CalendarWindowID%
			WinSet, Transparent, Off, ahk_id %STA_CalendarWindowID%
			STA_CountDown := 7
		}
		Gui, 7:Show, NoActivate, GUI_Calendar
		Return
	}

	WinGetTitle, LOC_Title, ahk_id %LOC_WindowID%
	WinGetClass, LOC_WindowClass, ahk_id %LOC_WindowID%
	If (LOC_WindowClass == "Shell_TrayWnd"
			&& LOC_ControlClass == "TrayClockWClass1"
		|| LOC_WindowClass == "AutoHotkeyGUI"
			&& LOC_Title == "GUI_Clock") {
		STA_CountUp := Min(3, STA_CountUp + 1)
		If (STA_CountUp == 3) {
			If (STA_CalendarWindowID == 0) {
				Gui, 7:Destroy ; GUI_Calendar
				Gui, 7:+AlwaysOnTop -Caption +Border -Resize +ToolWindow +Owner +LastFound +HwndSTA_CalendarWindowID
				Gui, 7:Margin, 0, 0
				Gui, 7:Add, MonthCal, 4 R2
				SysGet, LOC_MonitorBound, MonitorWorkArea
				Gui, 7:Show, Hide X%SCR_VirtualScreenWidth% Y%SCR_VirtualScreenHeight% NoActivate, GUI_Calendar
				WinGetPos, , , LOC_Width, LOC_Height
				WinMove, ahk_id %STA_CalendarWindowID%, , LOC_MonitorBoundRight - LOC_Width, LOC_MonitorBoundBottom - LOC_Height
				Gui, 7:Show, NoActivate
			}
			If (STA_CountDown != 7) {
				WinSet, Transparent, 255, ahk_id %STA_CalendarWindowID%
				STA_CountDown := 7
			}
			WinSetTitle, GUI_Calendar, ahk_id %STA_CalendarWindowID%
		}
	} Else If (STA_CalendarWindowID != 0) {
		If (STA_CountDown >= 0) {
			STA_CountDown--
			WinSet, Transparent, % 255 * STA_CountDown / 7, ahk_id %STA_CalendarWindowID%
		} Else {
			STA_CountUp := 0
		}
		WinSetTitle, %AHK_ScriptInfo%, ahk_id %STA_CalendarWindowID%
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

7GuiClose: ; GUI_Calendar
7GuiEscape:
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Rename file with no extension selection [F2] (no use with windows 7) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;~ SYS_RenameFile:
;~ F2::
;~ SYS_RenameFile()
;~ Return

;~ ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;~ SYS_RenameFile() {
	;~ RegRead, LOC_HideFileExtension, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, HideFileExt
	;~ If (LOC_HideFileExtension) {
		;~ SendInput, {F2}
		;~ Return
	;~ }

	;~ WinGetClass, LOC_RenameFileActiveWindowClass, A
	;~ WinGetTitle, LOC_RenameFileActiveWindowTitle, A
	;~ If (LOC_RenameFileActiveWindowClass != "Progman"
		;~ && LOC_RenameFileActiveWindowClass != "WorkerW"
		;~ && LOC_RenameFileActiveWindowClass != "ExploreWClass"
		;~ && LOC_RenameFileActiveWindowClass != "CabinetWClass"
		;~ && (LOC_RenameFileActiveWindowClass != "#32770"
			;~ || LOC_RenameFileActiveWindowTitle != "Sélectionner les fichiers image")) {
		;~ SendInput, {F2}
		;~ Return
	;~ }
	;~ Try {
		;~ ControlGet, LOC_Selection, List, Selected Col1, SysListView321, A
	;~ } Catch LOC_Exception {
		;~ AHK_Catch(LOC_Exception, "SYS_RenameFile")
		;~ Return
	;~ }
	;~ If (!LOC_Selection) {
		;~ Return
	;~ }
	;~ LOC_RightMostDotIndex := InStr(LOC_Selection, ".", 1, 0)

	;~ If (LOC_RenameFileActiveWindowClass == "Progman"
		;~ || LOC_RenameFileActiveWindowClass == "WorkerW") {
		;~ LOC_FolderName := A_Desktop
	;~ } Else {
		;~ Try {
			;~ ControlGetText, LOC_FolderName, Edit1, A
		;~ } Catch LOC_Exception {
			;~ AHK_Catch(LOC_Exception, "SYS_RenameFile")
			;~ , LOC_FolderName := ""
		;~ }
		;~ If (LOC_FolderName == "") {
			;~ Try {
				;~ ControlGetText, LOC_FolderName, ComboBox1, A
			;~ } Catch LOC_Exception {
				;~ AHK_Catch(LOC_Exception, "SYS_RenameFile")
				;~ SendInput, {F2}
				;~ Return
			;~ }
		;~ }
	;~ }
	;~ FileGetShortcut, %LOC_FolderName%\%LOC_Selection%.lnk, LOC_IsShortcut
	;~ FileGetAttrib, LOC_Attributes, %LOC_FolderName%\%LOC_Selection%
	;~ LOC_ExtensionLength := 0
	;~ If (!(Instr(LOC_Attributes, "D")
		;~ || LOC_IsShortcut) && LOC_RightMostDotIndex) {
		;~ LOC_ExtensionLength := StrLen(LOC_Selection) - LOC_RightMostDotIndex + 1
	;~ }
	;~ SendInput, {F2}+{Left %LOC_ExtensionLength%}
;~ }

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Show/Hide hidden files { Ctrl + Win + F6 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SYS_HiddenFiles:
^#F6::
SYS_HiddenFiles()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SYS_HiddenFiles() {
	RegRead, LOC_HiddenFilesStatus, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden
	If (LOC_HiddenFilesStatus == 2) {
		RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1
	} Else {
		RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2
	}
	SendMessage, 0x001A, , , , ahk_id 0xFFFF ; 0x001A is WM_SETTINGCHANGE ; 0xFFFF is HWND_BROADCAST
	WinGetClass, LOC_WindowClass, A
	If (LOC_WindowClass == "#32770"
		|| A_OSVersion == "WIN_VISTA") {
		SendInput, {F5}
	} Else {
		PostMessage, 0x111, 28931, , , A
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Show/Hide system files { Ctrl + Win + Shift + F6 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SYS_SystemFiles:
^+#F6::
SYS_SystemFiles()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SYS_SystemFiles() {
	RegRead, LOC_SystemFilesStatus, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, ShowSuperHidden
	If (LOC_SystemFilesStatus == 0) {
		RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1
		RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, ShowSuperHidden, 1
	} Else {
		RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, ShowSuperHidden, 0
	}
	SendMessage, 0x001A, , , , ahk_id 0xFFFF ; 0x001A is WM_SETTINGCHANGE ; 0xFFFF is HWND_BROADCAST
	WinGetClass, LOC_WindowClass, A
	If (LOC_WindowClass == "#32770"
	|| A_OSVersion == "WIN_VISTA") {
		SendInput, {F5}
	} Else {
		PostMessage, 0x111, 28931, , , A
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
