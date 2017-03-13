;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; API Windows : http://msdn.microsoft.com/en-us/library/windows/desktop/ff818516%28v=vs.85%29.aspx
; Styles : http://msdn.microsoft.com/en-us/library/windows/desktop/ff700543%28v=vs.85%29.aspx
; Gradients : http://www.autohotkey.com/board/topic/80588-how-to-simulate-a-linear-gradient/#entry57229

; Bugs :
;;;;;;;;

; StripMyRights (av IE) ne se lance pas !

; KBD_WordControl : gérer les multiples retours-chariots, qui ne st p pris en cpte ds la sélection naturelle
;                    gérer le cut

; Pr les insertions en mode texte des items (mot de passe, CB, Bank, ...), faire une première saisie pr demander le mdp initialement une fois (et le conserver seult en mémoire) - ou faire une option de conservation disque ou pas : tout crypter, sauf le mot de passe, enregistré en static dans une fonction

; Ctrl+Win+Shift+@ pr modifier les adresses LOG_MailEncryptedAddressesManager et les mdp LOG_MainEncryptedPassword, LOG_MainEncryptedPassword, LOG_WindowsLogin, LOG_CBEncryptedNumber, LOG_BankNumber

; Gdip_Startup existe encore... Mutualiser ?

; Jarter les PeriodicTimer AHK_InitTimers
; Faire une variable ini DisplayFusion, pr savoir si cé lancé ou pas, et désactiver tt code DF si pas
; Idem pr les autres applis, pr savoir si elles st activées (et installées !)

; Ss WinSpy, les copier-coller des listes copient le contenu de la liste précédemment sélectionnée - nyap de chgt d'indice
; de mm, entourer correctement ctrl et fenetre sélectionnés (qd p RShift)

; Win+H : un GET provoque le déplacement du contenu ingéré en première position dans la liste (voire sa création, en cas de Ctrl pr append) <- marche mal - utiliser des timestamps pr chq entrée !! Le tru se fait par fic
; Copier qui se fait au lanct d'AHK av un tooltip, et qui correspond au clipboard à monter en RAM : il faudrait contrôler le clipboard et tenter de l'affecter d'abord s'il n'existe pas, pr ne pas le modifier ! TXT_ClipBoardHistoryManager
; Ds la GUI, gérer les Alt+ 48: (TXT_ClipBoardHistoryManager)
; Ctrl+Alt+C prd bcp trop de tps !


; Automatic transparency ne marche plus ! WIN_ToggleAutomaticTransparency

; CygWin ne se lance pas APP_Console

; Screen capture : SCR_CaptureManager - Tout tester ! Le ScreenWidth ne prd pas l'écran de gche : http://www.autohotkey.com/board/topic/10556-livewindows-watch-dialogboxes-in-thumbnail/
; Les captures vers clipboard ne marchent pas !!!

;	TRY_AddMenuItem("Screen", "                                           PrintScreen`tEntire &Desktop to ClipBoard") KO
;	TRY_AddMenuItem("Screen", "                                Shift + PrintScreen`tEntire &Desktop to ClipBoard ( +  Cursor)") KO
;	TRY_AddMenuItem("Screen", "                    Alt     +            PrintScreen`tEntire &Desktop to File") OK
;	TRY_AddMenuItem("Screen", "                    Alt     + Shift + PrintScreen`tEntire &Desktop to File ( +  Cursor)") OK
;
;	TRY_AddMenuItem("Screen", "          Win +                         PrintScreen`tActive &Window to ClipBoard")
;	TRY_AddMenuItem("Screen", "          Win +             Shift + PrintScreen`tActive &Window to ClipBoard ( +  Cursor)")
;	TRY_AddMenuItem("Screen", "          Win + Alt     +            PrintScreen`tActive &Window to File") OK
;	TRY_AddMenuItem("Screen", "          Win + Alt     + Shift + PrintScreen`tActive &Window to File ( +  Cursor)") OK
;
;	TRY_AddMenuItem("Screen", "Ctrl +                                    PrintScreen`t&Zone to ClipBoard")
;	TRY_AddMenuItem("Screen", "Ctrl +                        Shift + PrintScreen`t&Zone to ClipBoard ( +  Cursor)")
;	TRY_AddMenuItem("Screen", "Ctrl +           Alt     +             PrintScreen`t&Zone to File") 
;	TRY_AddMenuItem("Screen", "Ctrl +           Alt     + Shift + PrintScreen`t&Zone to File ( +  Cursor)")

; Minimize to Tray ne permet pas de réafficher la fenêtre ! Win+Start : Restore last window minimized to tray WIN_MinimizeToTray

; SCR_CharArt() : créer systématiquement les fichiers comportant les caractères en question

; si gé des raccourcis en CapsLock + touche direct (ss préfixe, alors à quoi servent les préfixes ???) : pq ne pas tenter les raccourcis ss capitalisation (ms en se basant juste sur la touche CapsLock enfoncée), et ds le cas contraire, av les SendInput, ça devrait conserver la hotstring en cours de construction, non ?

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Évolutions :
;;;;;;;;;;;;;;

; Faire un pense-bête (avec alarme ?)

; Faire un chrono, un cpte à rebours & des alarmes

; Pr les fds de login, taper ds les wallpapers

; Mémo à mettre à jour ! ADM_Memo

; Alt+NumpadParenthesis pr trouver la précédente correspondante ou la suivante ! ( à combiner av Ctrl et Shift pr [ et { ) KBD_NumPadLookOpeningParenthesis

; Brightness automatique (en fonction du jour et de l'heure) : WIN_SetBrightness2

; http://mizage.com/divvy/

; Icônes : explorer.exe, compstui.dll & icmui.dll (couleurs), mmsys.cpl (sound on/off), mspaint.exe (pinceaux), rasdlg.dll 1 & 2 (pr les checkboxes)

; SysMenu personnalisé (Kill, AOT, Trans, ...)
; Touches mortes avec accents : écrire les séquences directement ? genre ’+e => é
; Drag to scroll

; Setter les icônes des GUI :
; Disons q ça reprd l'icone du tray lorsque celle-ci a été positionnée av Menu, Tray, Icon, <file>, ce qui né p le cas auj.
; Sinon, la méthode ci-dess ne marche p...
/*
Chargement par numéro ds un paquet :
hModule := DllCall( "kernel32.dll\GetModuleHandle", Str,"Shell32.dll" ) ; dj chargée
hIcon := DllCall( "user32.dll\LoadIcon", UInt,hModule, Int,51 )

Gui, +LastFound
SendMessage, 0x80, 0, hIcon   ; Titlebar Icon
; SendMessage, 0x80, 1, hIcon ; Alt+Tab Icon
Gui, Show, w640 h480
Return

I wrote this a while back to change the icon in a message box to any icon.
It uses the icon resource from a .ico file in the script directory.

SetWorkingDir % A_ScriptDir
IconFile = Icon.ico
hIcon := DllCall("user32.dll\LoadImage", uInt, 0, Str, IconFile, uInt, 2, Int, 0, Int, 0, uInt, 0x10)
SetTimer, ChangeIcon, -100 ; commentaire pr chger l'icone de l'appli AHK
MsgBox,0x1000,, Icon updated using IconFile!
return

ChangeIcon:
PostMessage, 0x80, 0, hIcon,, ahk_class #32770 ; applies icon to messagebox
Return
*/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; GUI (* displayed title) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 01 : About *
; 02 : GUI_Memo
; 03 : GUI_FadeOutBackground
; 04 : { Hibernate computer | Suspend computer | Force log off | Log off | Forcing computer shutdown | Shutdown computer | Forcing computer restart | Restart computer } *
; 05 : { Enregistement du compte en banque | Enregistrement de la Carte Bleue | Informations d'identification à Windows | Informations d'identification au domaine | Identification locale } *
; 06 : GUI_MailAddresses
; 07 : GUI_Calendar
; 08 : GUI_HorizontalRuler
; 09 : GUI_VerticalRuler
; 10 : GUI_SplashScreen
; 11 : GUI_MouseLockStartXAxis
; 12 : GUI_MouseLockStartYAxis
; 13 : GUI_MouseLockStartPoint
; 14 : GUI_MouseLockEndXAxis
; 15 : GUI_MouseLockEndYAxis
; 16 : GUI_MouseLockEndPoint
; 17 : GUI_ColorPicker
; 18 : GUI_ColoredTaskbar
; 19 : GUI_DisplayFusionColoredTaskbar
; 20 : GUI_ScreenshotStartXAxis
; 21 : GUI_ScreenshotStartYAxis
; 22 : GUI_ScreenshotRectangle
; 23 : GUI_ScreenshotCountdown
; 24 : GUI_ScreenshotFlash
; 25 : Screenshot *
; 26 : GUI_Magnifier
; 27 : { Unl | L } ock Keyboard *
; 28 : GUI_LockKeyboardBackground
; 29 : Text Capture *
; 30 : WindowSpy *
; 31 : GUI_WindowSpyHoveredColor
; 32 : GUI_WindowSpyHoveredWindowTop
; 33 : GUI_WindowSpyHoveredWindowLeft
; 34 : GUI_WindowSpyHoveredWindowBottom
; 35 : GUI_WindowSpyHoveredWindowRight
; 36 : GUI_WindowSpyHoveredControlTop
; 37 : GUI_WindowSpyHoveredControlLeft
; 38 : GUI_WindowSpyHoveredControlBottom
; 39 : GUI_WindowSpyHoveredControlRight
; 40 : { Unicode | ASCII } Art Capture *
; 41 : GUI_LeftTopToolTip
; 42 : GUI_WidthHeightToolTip
; 43 : GUI_RightBottomToolTip
; 44 : GUI_ToolTip
; 45 : GUI_BufferedToolTip
; 46 : GUI_Clock
; 47 : GUI_VolumeBar
; 48 : Clipboard history *
; 49 : Delayed Shutdown
; 50 : GUI_MouseRings
; 51 : GUI_ErgonomicKeyboard
; 52 : GUI_ClashOfClansActivitySimulation
; 53 : GUI_ClashOfClansActivityTop
; 54 : GUI_ClashOfClansActivityLeft
; 55 : GUI_ClashOfClansActivityBottom
; 56 : GUI_ClashOfClansActivityRight
; 69... : GUI_BSOD (2 per monitor)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Main program :
;;;;;;;;;;;;;;;;

#SingleInstance, Force
#Persistent
#NoEnv
#WinActivateForce
#HotkeyInterval, 1000
#MaxHotkeysPerInterval, 100
#MaxThreads, 255
#MaxThreadsPerHotkey, 20
#MaxThreadsBuffer, On
; #KeyHistory, 0 ; TODO : réactiver
#InstallKeybdHook
#InstallMouseHook
#UseHook, On
; #Warn, All, StdOut
#NoTrayIcon

SplitPath, A_ScriptFullPath, , , , AHK_ScriptName
AHK_ScriptInfo := "JuggleKeys"

Gui, 10:Destroy ; GUI_SplashScreen
If (A_IsUnicode) {
	Gui, 10:Font, s16
	Gui, 10:Add, Text, , % "`n " . AHK_ScriptInfo . " doesn't work with a Unicode executable version `n"
	AHK_FadeSplashScreen(true)
	Sleep, 3000
	AHK_FadeSplashScreen(false)
	AHK_Exit()
}

Gui, 10:Font, s16
Gui, 10:Add, Text, , % "`n Loading " . AHK_ScriptInfo . " `n"
SetTimer, AHK_FadeInSplashScreen, -1

SetWorkingDir %A_ScriptDir%
Process, Priority, , High
; Thread, NoTimers, false
ListLines, Off
SetWinDelay, 0
SetControlDelay, 0
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetNumLockState, AlwaysOn
SetBatchLines, 10ms
SetTitleMatchMode, 2
SetFormat, Integer, D
CoordMode, Mouse, Screen
DetectHiddenWindows, On
OnExit, AHK_Exit
SetTimer, AHK_Init, -1
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_FadeInSplashScreen:
AHK_FadeSplashScreen(true)
Return

AHK_FadeOutSplashScreen:
AHK_FadeSplashScreen(false)
Return

AHK_FadeSplashScreen(PRM_Visible = true) {
	
	Static STA_Fading := false
	Critical, On
	While (STA_Fading) {
		Sleep, 100
	}
	STA_Fading := true
	LOC_Transparency := (PRM_Visible ? 20 : 200)
	Gui, 10:-MaximizeBox -MinimizeBox -Resize +Owner +Disabled -Caption +AlwaysOnTop +Border +LastFound ; GUI_SplashScreen
	WinSet, ExStyle, +0x00000020
	WinSet, Transparent, %LOC_Transparency%
	Gui, 10:Show, Autosize Center NoActivate, GUI_SplashScreen
	While (LOC_Transparency > 0
		&& LOC_Transparency <= 200) {
		Sleep, 100
		LOC_Transparency += (PRM_Visible ? 25 : -25)
		WinSet, Transparent, %LOC_Transparency%
	}
	If (!PRM_Visible) {
		Gui, 10:Destroy
	}
	STA_Fading := false
	Critical, Off
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_Init:
AHK_RunLockManager()
SetTimer, ZZZ_CheckModificationsTimer, -1

AHK_LoadIniFile(true)
, AHK_Log()
, AHK_InitLibraries()
, AHK_InitTimers()
, AHK_ResetControlKeys()
, AHK_ParseCommandLineParameters()
, WIN_Init()
, APP_Init()
, SCR_Init()
, KBD_Init()
, AUD_Init()
, TXT_Init()
, TRY_InitMenus()
, TRY_InitTrayIcon()
, TRY_InitTrayTip()
, SYS_InitWheel()
, WIN_SetFocusFollowsMouse()
, WIN_InitTransparency()
, WIN_AdjustBrightness(0)

Menu, Tray, Icon
AHK_ToggleSuspend(AHK_Suspended)
, TRY_SetHotstringsTrayIcon(false)
, AHK_FadeSplashScreen(false)

ADM_ApplyMouseHooks()
, SCR_MouseRingManager(0)
, WIN_InitGroups()
, LOG_InitGroups()
, HOT_InitGroups()
, SYS_WriteRegistryOptions()
, KBD_InitMicrosoftErgonomicKeyboard()
, AHK_InitShutdownConfirmation()
, ADM_InitAboutLinks()
, SCR_InitMagnifier()
, AHK_DisplayDisabledOptions()
, AHK_WindowsTimeSynchronization()
, AHK_FreeMemory()
, AHK_SetPeriodicCkeckTimers()
, APP_DeactivateBlueStacksAutostart()
, APP_InitBlueStacksCursorTimer()
, SYS_SetClassicStartMenu()
, SCR_InitWallpapers()
, AHK_BackupScripts()
SetTimer, TRY_CheckTrayIconStateTimer, %ZZZ_CheckTrayIconStateTimer%
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#Include %A_ScriptDir%\administration.ahk
#Include %A_ScriptDir%\applications.ahk
#Include %A_ScriptDir%\audio.ahk
#Include %A_ScriptDir%\hotstrings.ahk
#Include %A_ScriptDir%\keyboard.ahk
#Include %A_ScriptDir%\login.ahk
#Include %A_ScriptDir%\power.ahk
#Include %A_ScriptDir%\screen.ahk
#Include %A_ScriptDir%\system.ahk
#Include %A_ScriptDir%\text.ahk
#Include %A_ScriptDir%\tray.ahk
#Include %A_ScriptDir%\windows.ahk

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_RunLockManager(PRM_Active = true) {
	Global AHK_ScriptName
	LOC_File := A_ScriptDir . "\conf\" . AHK_ScriptName . ".lock"
	
	If (PRM_Active) {
		If (FileExist(LOC_File)) {
			FileRead, LOC_ScriptID, %LOC_File%
			Process, Exist, %LOC_ScriptID%
			If (ErrorLevel) {
				Process, Close, %LOC_ScriptID%
			}
			FileDelete, %LOC_File%
		}
		LOC_File := FileOpen(LOC_File, "w")
		If (LOC_File) {
			LOC_File.Write(A_ScriptHwnd)
			LOC_File.Close()
		}
	} Else {
		Try {
			FileDelete, %LOC_File%
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Init timers :
;;;;;;;;;;;;;;;

AHK_InitTimers() {
	Global
	
	; les périodiques st +, les non- st -
	ZZZ_SuspendingWindowsPeriodicTimer := 994
	, ZZZ_BoringPopUpsPeriodicTimer := 247
	, ZZZ_ShowDialogsPeriodicTimer := 259
	, ZZZ_OpenSaveDialogsPeriodicTimer := 252
	, ZZZ_XWindowFocusPeriodicTimer := 487


	, ZZZ_StartButtonTooltipPeriodicTimer := 248
	, ZZZ_StartMenuDisplayTimer := 202
	, ZZZ_TaskbarClockPeriodicTimer := 752
	, ZZZ_TaskbarColorPeriodicTimer := 106
	, ZZZ_TransparencyPeriodicTimer := 99
	, ZZZ_TaskbarCalendarPeriodicTimer := 505
	, ZZZ_CheckTrayIconStateTimer := 501
	
	, ZZZ_MouseAxisLockPeriodicTimer := -253
	, ZZZ_MouseAxisUnlockPeriodicTimer := -47

	ZZZ_CheckModificationsTimer := -509
	, ZZZ_CopyCutTimer := -481
	, ZZZ_ClosePreviousAHKInstanceTimer := -491
	, ZZZ_HideWindowToolTipTimer := -1004
	, ZZZ_HideDebugTimer := -3987
	, ZZZ_HideMemoTimer := -507
	, ZZZ_WindowSpyRefreshTimer := -101
	, ZZZ_KillRegServerTimer := -1012
	, ZZZ_BlueStacksMouseTimer, -1024
	, ZZZ_IgnoreKeyTimer := -100
	, ZZZ_DragWindowResizingTimer := -100
	, ZZZ_RepaintMagnifierTimer := -100
	, ZZZ_DestroyMagnifierTimer := -100
	, ZZZ_CopyCutTimer := -500
	, ZZZ_SetMonitorOffTimer := -100
	, ZZZ_DisplayConfirmationTimer := -250
	, ZZZ_DestroyVolumeBarTimer := -500
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Displays disabled options :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_DisplayDisabledOptions() {

	Global
	Local LOC_Tooltip := "", LOC_Variables := "", LOC_WarningCount := 0
		, LOC_MessageA := { AHK_LeftMouseButtonHookEnabled: "     - Left button hook disabled`n"
			, AHK_MiddleMouseButtonHookEnabled: "     - Middle button hook disabled`n"
			, AHK_RightMouseButtonHookEnabled: "     - Right button hook disabled`n"
			, AHK_FourthMouseButtonHookEnabled: "     - 4th button hook disabled`n"
			, AHK_FifthMouseButtonHookEnabled: "     - 5th button hook disabled`n"
			, TRY_TrayTipEnabled: "     - Traytips disabled`n"
			, AHK_TooltipsEnabled: "     - Tooltips disabled`n"
			, AHK_DebugEnabled: "     - Debug mode enabled`n"
			, AHK_AudioEnabled: "     - Audio effects disabled`n"
			, SCR_MouseTracesEnabled: "     - Mouse trace disabled`n"
			, WIN_FocusFollowsMouseEnabled: "     - X-Mouse focus enabled`n"
			, WIN_TransparencyEnabled: "     - Automatic window transparency enabled`n"
			, SCR_WallpaperRotationEnabled: "     - Automatic wallpaper rotation disabled`n"
			, SCR_WallpaperFolder: "     - Wallpaper folder not defined`n"
			, LOG_BankEncryptedAccount: "     - Bank encrypted account not defined`n"
			, LOG_CBEncryptedNumber: "     - CB number not defined`n"
			, LOG_MailEncryptedAddresses: "     - Mail addresses not defined`n"
			, LOG_MainEncryptedPassword: "     - Local password not defined`n"
			, LOG_DomainEncryptedPassword: "     - Domain password not defined`n" }
		, LOC_VariableWarningStateA := { TRY_TrayTipEnabled: false
			, AHK_TooltipsEnabled: false
			, AHK_DebugEnabled: true
			, AHK_AudioEnabled: false
			, SCR_MouseTracesEnabled: false
			, WIN_FocusFollowsMouseEnabled: true
			, WIN_TransparencyEnabled: true
			, SCR_WallpaperRotationEnabled: false }

	; Mouse button hooks :
	;;;;;;;;;;;;;;;;;;;;;;
	LOC_Variables := "AHK_LeftMouseButtonHookEnabled|AHK_MiddleMouseButtonHookEnabled|AHK_RightMouseButtonHookEnabled|AHK_FourthMouseButtonHookEnabled|AHK_FifthMouseButtonHookEnabled"
	Loop, Parse, LOC_Variables, |
	{
		If (A_Index > AHK_MouseButtonNumber) {
			Break
		}
		If (!%A_LoopField%) {
			LOC_ToolTip .= LOC_MessageA[A_LoopField]
			, LOC_WarningCount++
		}
	}
	
	LOC_Variables := "TRY_TrayTipEnabled|AHK_TooltipsEnabled|AHK_DebugEnabled|SCR_MouseTracesEnabled|WIN_FocusFollowsMouseEnabled|WIN_TransparencyEnabled|SCR_WallpaperRotationEnabled"
	Loop, Parse, LOC_Variables, |
	{
		If (%A_LoopField% == LOC_VariableWarningStateA[A_LoopField]) {
			LOC_ToolTip .= LOC_MessageA[A_LoopField]
			, LOC_WarningCount++
		}
	}
	If (!SCR_WallpaperFolder
		&& SCR_WallpaperRotationEnabled) {
		LOC_ToolTip .= LOC_MessageA["SCR_WallpaperFolder"]
		, LOC_WarningCount++
	}
	
	; User personal information :
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LOC_Variables := "LOG_BankEncryptedAccount|LOG_CBEncryptedNumber|LOG_MailEncryptedAddresses|LOG_MainEncryptedPassword"
	Loop, Parse, LOC_Variables, |
	{
		If (!%A_LoopField%) {
			LOC_ToolTip .= LOC_MessageA[A_LoopField]
			, LOC_WarningCount++
		}
	}
	If (LOG_DomainName
		&& !LOG_DomainEncryptedPassword) {
		LOC_ToolTip .= LOC_MessageA["LOG_DomainEncryptedPassword"]
		, LOC_WarningCount++
	}

	; Audio :
	;;;;;;;;;
	If (!AHK_AudioEnabled) {
		LOC_ToolTip .= LOC_MessageA["AHK_AudioEnabled"]
		, LOC_WarningCount++
	}
	
	If (LOC_ToolTip) {
		TRY_ShowTrayTip("`nConfiguration not optimized :`n`n" . LOC_ToolTip . "`nCheck the file " . AHK_IniFile, - Round(1.5 * max(2, LOC_WarningCount)))
	}
	; AHK_Debug(LOC_ToolTip)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Shutdown confirmation :
;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_InitShutdownConfirmation() {
	AHK_Log("> AHK_InitShutdownConfirmation()")
	DllCall("kernel32.dll\SetProcessShutdownParameters", "UInt", 0x4FF, "UInt", 0)
	, OnMessage(0x11, "AHK_ShutdownShellHook")
	, AHK_Log("< AHK_InitShutdownConfirmation()")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_ShutdownShellHook(wParam, lParam) {

	If (lParam & 0x80000000) {
		SetTimer, AHK_LogOffTimer, -1
	} Else {
		SetTimer, AHK_ShutdownTimer, -1
	}
	Return, false
}

AHK_ShutdownTimer:
AHK_ShutdownTimer()
Return

AHK_ShutdownTimer() {
	PRM_PowerManager(PRM_Submit := false, PRM_State := 3, , PRM_Yes := false)
}

AHK_LogOffTimer:
AHK_LogOffTimer()
Return

AHK_LogOffTimer() {
	PRM_PowerManager(PRM_Submit := false, PRM_State := 2)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Command line parameters :
;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_ParseCommandLineParameters() {

	Local LOC_Index
	AHK_Log("> AHK_ParseCommandLineParameters()")
	Loop, %0% {
		StringLower, LOC_Index, A_Index
		If (LOC_Index == "/x"
			|| LOC_Index == "/exit") {
			ExitApp
		}
	}
	AHK_Log("< AHK_ParseCommandLineParameters()")
	Return
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Low memory usage :
;;;;;;;;;;;;;;;;;;;;

AHK_FreeMemory() {
	Global AHK_AutoHotKeyPID, ZZZ_CloseHandleFunction
	LOC_CurrentProcess := DllCall("kernel32.dll\OpenProcess", "UInt", 0x001F0FFF, "Int", 0, "Int", AHK_AutoHotKeyPID)
	, DllCall("kernel32.dll\SetProcessWorkingSetSize", "UInt", LOC_CurrentProcess, "Int", -1, "Int", -1)
	, DllCall(ZZZ_CloseHandleFunction, "Int", LOC_CurrentProcess)
	Return
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Persistent configuration :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_LoadIniFile(PRM_FirstLoad = false) {

	Global
	Static STA_DefaultValuesA := { "WIN_Brightness": 128, "WIN_Transparency": 220, "WIN_MenusTransparency": 230, "WIN_TransparencyEnabled": 0, "AHK_Suspended": 0, "AHK_LogsEnabled": 0, "AHK_DebugEnabled": 0, "AHK_ToolTipsEnabled": 1, "AHK_AudioEnabled": 1, "AHK_BackupDays": 60, "AUD_Step": 5, "AUD_BigStep": 10, "SYS_CPURefreshTime": 1000, "SCR_WallpaperRotationEnabled": 1, "SCR_WallpaperFolder": 0, "WIN_FocusFollowsMouseEnabled": 0, "SCR_MouseTracesEnabled": 1, "AHK_LeftMouseButtonHookEnabled": 1, "AHK_MiddleMouseButtonHookEnabled": 1, "AHK_RightMouseButtonHookEnabled": 1, "AHK_FourthMouseButtonHookEnabled": 1, "AHK_FifthMouseButtonHookEnabled": 1, "SYS_ScrollTimeOut": 400, "SYS_ScroolBoost": 20, "SYS_ScrollLimit": 60, "SCR_ChangeWallPaperTimer": 3600, "SCR_PixelsPerMillimeter": 3.5, "APP_BlueStacksActivityEnabled": 0, "SCR_MouseRings": 20 }
	Static STA_ApplicationPathA := [ "Apache"
		, "AutoScriptWriter"
		, "BlueStacks"
		, "CDBurner"
		, "ClassicStartMenu"
		, "CygWin"
		, "DieOrLive"
		, "DirectoryOpus"
		, "DirectoryOpusRT"
		, "Eclipse"
		, "Firefox"
		, "InternetExplorer"
		, "JavaWebStart"
		, "MP3Editor"
		, "MailApplication"
		, "MediaMonkey"
		, "MySQL"
		, "Photoshop"
		, "Quintessential"
		, "RegistryManager"
		, "SQLDeveloper"
		, "SciTE"
		, "SnagIt"
		, "StartupDelayer"
		, "TextEditor"
		, "VideoConverter"
		, "VisionGo"
		, "WinSpector"
		, "WindowsMediaPlayer"
		, "uTorrent" ]
	Local LOC_Exception, LOC_VariableName, LOC_Value, LOC_Directories, LOC_Attributes, LOC_Exception

	LOC_Directories := "\conf|\clip|\media"
	Loop, Parse, LOC_Directories, |
	{
		LOC_Attributes := FileExist(A_ScriptDir . A_LoopField)
		If (LOC_Attributes) {
			If (InStr(LOC_Attributes, "D")) {
				LOC_Attributes := "D"
			} Else {
				Try {
					FileDelete, % A_ScriptDir . A_LoopField
				} Catch LOC_Exception {
					AHK_Catch(LOC_Exception, "AHK_LoadIniFile", PRM_FirstLoad)
				}
				LOC_Attributes := ""
			}
		}
		If (!LOC_Attributes) {
			Try {
				FileCreateDir, % A_ScriptDir . A_LoopField
			} Catch LOC_Exception {
				AHK_Catch(LOC_Exception, "AHK_LoadIniFile", PRM_FirstLoad)
			}
		}
	}
	
	If (PRM_FirstLoad) {
		AHK_IniFile := A_ScriptDir . "\conf\" . AHK_ScriptName . ".ini"
		IniRead, AHK_Suspended, %AHK_IniFile%, Main, Suspended, % STA_DefaultValuesA["AHK_Suspended"]
		If (A_Is64bitOS) {
			EnvGet, ZZZ_ProgramFiles32, ProgramFiles(x86)
			EnvGet, ZZZ_ProgramFiles64, ProgramW6432
		} Else {
			ZZZ_ProgramFiles32 := ZZZ_ProgramFiles64 := A_ProgramFiles
		}
	}

	IniRead, WIN_Brightness, %AHK_IniFile%, Main, Brightness, % STA_DefaultValuesA["WIN_Brightness"]
	IniRead, WIN_Transparency, %AHK_IniFile%, Main, Transparency, % STA_DefaultValuesA["WIN_Transparency"]
	IniRead, WIN_MenusTransparency, %AHK_IniFile%, Main, MenusTransparency, % STA_DefaultValuesA["WIN_MenusTransparency"]
	IniRead, WIN_TransparencyEnabled, %AHK_IniFile%, Main, TransparencyEnabled, % STA_DefaultValuesA["WIN_TransparencyEnabled"]
	IniRead, AHK_LogsEnabled, %AHK_IniFile%, Main, LogsEnabled, % STA_DefaultValuesA["AHK_LogsEnabled"]
	IniRead, AHK_DebugEnabled, %AHK_IniFile%, Main, DebugEnabled, % STA_DefaultValuesA["AHK_DebugEnabled"]
	IniRead, AHK_ToolTipsEnabled, %AHK_IniFile%, Main, ToolTipsEnabled, % STA_DefaultValuesA["AHK_ToolTipsEnabled"]
	IniRead, AHK_AudioEnabled, %AHK_IniFile%, Main, AudioEnabled, % STA_DefaultValuesA["AHK_AudioEnabled"]
	IniRead, AHK_BackupDays, %AHK_IniFile%, Main, BackupDays, % STA_DefaultValuesA["AHK_BackupDays"]
	IniRead, AUD_Step, %AHK_IniFile%, Main, AudioStep, % STA_DefaultValuesA["AUD_Step"]
	IniRead, AUD_BigStep, %AHK_IniFile%, Main, AudioBigStep, % STA_DefaultValuesA["AUD_BigStep"]
	IniRead, SYS_CPURefreshTime, %AHK_IniFile%, Main, CPURefreshTime, % STA_DefaultValuesA["SYS_CPURefreshTime"]
	IniRead, SCR_WallpaperRotationEnabled, %AHK_IniFile%, Main, WallpaperRotationEnabled, % STA_DefaultValuesA["SCR_WallpaperRotationEnabled"]
	IniRead, SCR_ChangeWallPaperTimer, %AHK_IniFile%, Main, WallpaperTimer, % STA_DefaultValuesA["SCR_ChangeWallPaperTimer"]
	IniRead, SCR_WallpaperFolder, %AHK_IniFile%, Main, WallpaperFolder, % STA_DefaultValuesA["SCR_WallpaperFolder"]
	IniRead, SCR_PixelsPerMillimeter, %AHK_IniFile%, Main, PixelsPerMillimeter, % STA_DefaultValuesA["SCR_PixelsPerMillimeter"]
	IniRead, WIN_FocusFollowsMouseEnabled, %AHK_IniFile%, Mouse, FocusFollowsMouseEnabled, % STA_DefaultValuesA["WIN_FocusFollowsMouseEnabled"]
	IniRead, SCR_MouseTracesEnabled, %AHK_IniFile%, Mouse, TracesEnabled, % STA_DefaultValuesA["SCR_MouseTracesEnabled"]
	IniRead, SCR_MouseRings, %AHK_IniFile%, Mouse, Rings, % STA_DefaultValuesA["SCR_MouseRings"]
	IniRead, AHK_LeftMouseButtonHookEnabled, %AHK_IniFile%, Mouse, LeftMouseButtonEnabled, % STA_DefaultValuesA["AHK_LeftMouseButtonHookEnabled"]
	IniRead, AHK_MiddleMouseButtonHookEnabled, %AHK_IniFile%, Mouse, MiddleMouseButtonEnabled, % STA_DefaultValuesA["AHK_MiddleMouseButtonHookEnabled"]
	IniRead, AHK_RightMouseButtonHookEnabled, %AHK_IniFile%, Mouse, RightMouseButtonEnabled, % STA_DefaultValuesA["AHK_RightMouseButtonHookEnabled"]
	IniRead, AHK_FourthMouseButtonHookEnabled, %AHK_IniFile%, Mouse, FourthMouseButtonEnabled, % STA_DefaultValuesA["AHK_FourthMouseButtonHookEnabled"]
	IniRead, AHK_FifthMouseButtonHookEnabled, %AHK_IniFile%, Mouse, FifthMouseButtonEnabled, % STA_DefaultValuesA["AHK_FifthMouseButtonHookEnabled"]
	IniRead, SYS_ScrollTimeOut, %AHK_IniFile%, Mouse, ScrollTimeOut, % STA_DefaultValuesA["SYS_ScrollTimeOut"] ; The length of a scrolling session. Keep scrolling within this time to accumulate boost. Default: 500. Recommended between 400 and 1000.
	IniRead, SYS_ScroolBoost, %AHK_IniFile%, Mouse, ScroolBoost, % STA_DefaultValuesA["SYS_ScroolBoost"] ; If you scroll a long distance in one session, apply additional boost factor. The higher the value, the longer it takes to activate, and the slower it accumulates. Set to zero to disable completely. Default: 30.
	IniRead, SYS_ScrollLimit, %AHK_IniFile%, Mouse, ScrollLimit, % STA_DefaultValuesA["SYS_ScrollLimit"] ; Spamming applications with hundreds of individual scroll events can slow them down. This sets the maximum number of scrolls sent per click, i.e. max velocity. Default: 60.
	IniRead, APP_BlueStacksActivityEnabled, %AHK_IniFile%, Applications, BlueStacksActivityEnabled, % STA_DefaultValuesA["APP_BlueStacksActivityEnabled"]

	For LOC_VariableName, LOC_Value In STA_DefaultValuesA
	{
		If (StrLen(%LOC_VariableName%) == 0) {
			%LOC_VariableName% := LOC_Value
		}
	}

	; Applications :
	For LOC_Value, LOC_VariableName In STA_ApplicationPathA
	{
		IniRead, APP_%LOC_VariableName%Path, %AHK_IniFile%, Applications, %LOC_VariableName%Path, % ""
		If (APP_%LOC_VariableName%Path) {
			If (FileExist(ZZZ_ProgramFiles32 . "\" . APP_%LOC_VariableName%Path)) {
				APP_%LOC_VariableName%Path := ZZZ_ProgramFiles32 . "\" . APP_%LOC_VariableName%Path
			} Else If (FileExist(ZZZ_ProgramFiles64 . "\" . APP_%LOC_VariableName%Path)) {
				APP_%LOC_VariableName%Path := ZZZ_ProgramFiles64 . "\" . APP_%LOC_VariableName%Path
			} Else If (!FileExist(APP_%LOC_VariableName%Path)) {
				APP_%LOC_VariableName%Path := ""
			}
		}
		If (!APP_%LOC_VariableName%Path) {
			IniWrite, % "", %AHK_IniFile%, Applications, %LOC_VariableName%Path
		}
	}

	; BlueStacks :
	If (PRM_FirstLoad) {
		If (WinExist("BlueStacks App Player")) {
			SetTimer, APP_BlueStacksMouseTimer, -1
			If (APP_BlueStacksActivityEnabled) {
				APP_ClashOfClansActivity(true)
			}
		} Else {
			If (APP_BlueStacksActivityEnabled) {
				APP_BlueStacksActivityEnabled := 0
				, AHK_SaveIniFile()
			}
		}
	}
	
	Try {
		If (FileExist(A_ScriptDir . "\clip\" . AHK_ScriptName . ".clip")) {
			FileRead, TXT_ClipBoard, *c %A_ScriptDir%\clip\%AHK_ScriptName%.clip
		}
	} Catch LOC_Exception {
		AHK_Catch(LOC_Exception, "AHK_LoadIniFile", PRM_FirstLoad)
		TXT_ClipBoard := ""
	}
	ZZZ_ClipBoardInitialized := (StrLen(TXT_ClipBoard) > 0)
	TRY_GetTrayTipState()
	If (!PRM_FirstLoad) {
		AHK_SaveIniFile()
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_SaveIniFile:
AHK_SaveIniFile()
Return

AHK_SaveIniFile() {
	Global
	Local LOC_LogFile := A_ScriptDir . "\conf\" . AHK_ScriptName . ".log", LOC_Exception := false
	SetTimer, ZZZ_CheckModificationsTimer, Off
	
	IniWrite, %AHK_LogsEnabled%, %AHK_IniFile%, Main, LogsEnabled
	IniWrite, %AHK_DebugEnabled%, %AHK_IniFile%, Main, DebugEnabled
	IniWrite, %AHK_ToolTipsEnabled%, %AHK_IniFile%, Main, ToolTipsEnabled
	IniWrite, %AHK_Suspended%, %AHK_IniFile%, Main, Suspended
	IniWrite, %AHK_AudioEnabled%, %AHK_IniFile%, Main, AudioEnabled
	IniWrite, %SYS_CPURefreshTime%, %AHK_IniFile%, Main, CPURefreshTime
	IniWrite, %AUD_Step%, %AHK_IniFile%, Main, AudioStep
	IniWrite, %AUD_BigStep%, %AHK_IniFile%, Main, AudioBigStep
	IniWrite, %WIN_Brightness%, %AHK_IniFile%, Main, Brightness
	IniWrite, %WIN_TransparencyEnabled%, %AHK_IniFile%, Main, TransparencyEnabled
	IniWrite, %WIN_Transparency%, %AHK_IniFile%, Main, Transparency
	IniWrite, %WIN_MenusTransparency%, %AHK_IniFile%, Main, MenuTransparency
	IniWrite, %SCR_WallpaperRotationEnabled%, %AHK_IniFile%, Main, WallpaperRotationEnabled
	IniWrite, %SCR_ChangeWallPaperTimer%, %AHK_IniFile%, Main, WallpaperTimer
	IniWrite, %SCR_WallpaperFolder%, %AHK_IniFile%, Main, WallpaperFolder
	IniWrite, %SCR_PixelsPerMillimeter%, %AHK_IniFile%, Main, PixelsPerMillimeter
	IniWrite, %AHK_BackupDays%, %AHK_IniFile%, Main, BackupDays
	IniWrite, %APP_BlueStacksActivityEnabled%, %AHK_IniFile%, Applications, BlueStacksActivityEnabled

	IniWrite, %SCR_MouseTracesEnabled%, %AHK_IniFile%, Mouse, TracesEnabled
	IniWrite, %SCR_MouseRings%, %AHK_IniFile%, Mouse, Rings
	IniWrite, %WIN_FocusFollowsMouseEnabled%, %AHK_IniFile%, Mouse, FocusFollowsMouseEnabled
	IniWrite, %AHK_LeftMouseButtonHookEnabled%, %AHK_IniFile%, Mouse, LeftMouseButtonEnabled
	IniWrite, %AHK_MiddleMouseButtonHookEnabled%, %AHK_IniFile%, Mouse, MiddleMouseButtonEnabled
	IniWrite, %AHK_RightMouseButtonHookEnabled%, %AHK_IniFile%, Mouse, RightMouseButtonEnabled
	IniWrite, %AHK_FourthMouseButtonHookEnabled%, %AHK_IniFile%, Mouse, FourthMouseButtonEnabled
	IniWrite, %AHK_FifthMouseButtonHookEnabled%, %AHK_IniFile%, Mouse, FifthMouseButtonEnabled
	IniWrite, %SYS_ScrollTimeOut%, %AHK_IniFile%, Mouse, ScrollTimeOut
	IniWrite, %SYS_ScroolBoost%, %AHK_IniFile%, Mouse, ScroolBoost
	IniWrite, %SYS_ScrollLimit%, %AHK_IniFile%, Mouse, ScrollLimit
	
	IniRead, LOG_MailEncryptedAddresses, %AHK_IniFile%, Text, MailEncryptedAddresses, %A_Space%
	IniWrite, %LOG_MailEncryptedAddresses%, %AHK_IniFile%, Text, MailEncryptedAddresses
	IniRead, LOG_BankEncryptedAccount, %AHK_IniFile%, Text, BankEncryptedAccount, %A_Space%
	IniWrite, %LOG_BankEncryptedAccount%, %AHK_IniFile%, Text, BankEncryptedAccount
	IniRead, LOG_CBEncryptedNumber, %AHK_IniFile%, Text, CBEncryptedNumber, %A_Space%
	IniWrite, %LOG_CBEncryptedNumber%, %AHK_IniFile%, Text, CBEncryptedNumber
	IniRead, LOG_DomainName, %AHK_IniFile%, Text, DomainName, %A_Space%
	If (LOG_DomainName == "") {
		EnvGet, LOG_DomainName, USERDOMAIN
	}
	IniWrite, %LOG_DomainName%, %AHK_IniFile%, Text, DomainName
	IniRead, LOG_DomainLogin, %AHK_IniFile%, Text, DomainLogin, %A_UserName%
	IniWrite, %LOG_DomainLogin%, %AHK_IniFile%, Text, DomainLogin
	IniRead, LOG_DomainEncryptedPassword, %AHK_IniFile%, Text, DomainEncryptedPassword, %A_Space%
	IniWrite, %LOG_DomainEncryptedPassword%, %AHK_IniFile%, Text, DomainEncryptedPassword
	IniRead, LOG_MainEncryptedPassword, %AHK_IniFile%, Text, MainEncryptedPassword, %A_Space%
	IniWrite, %LOG_MainEncryptedPassword%, %AHK_IniFile%, Text, MainEncryptedPassword
	Try {
		FileSetAttrib, -A, %AHK_IniFile%
	} Catch LOC_Exception {
		AHK_Catch(LOC_Exception, "AHK_SaveIniFile")
	}
	If (AHK_LogsEnabled) {
		If (!FileExist(LOC_LogFile)) {
			Try {
				FileAppend, , %LOC_LogFile%
			} Catch LOC_Exception {
				AHK_Catch(LOC_Exception, "AHK_SaveIniFile")
			}
		}
	} Else {
		FileRecycle, %LOC_LogFile%
	}

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
	
	Local LOC_ProgramData
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
	SetTimer, ZZZ_CheckModificationsTimer, %ZZZ_CheckModificationsTimer%
	Return
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Check script modifications :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ZZZ_CheckModificationsTimer:
SetTimer, ZZZ_CheckModificationsTimer, Off
If (AHK_CheckModifications()) {
	ADM_Reload()
} Else
If (!A_IsSuspended) {
	SetTimer, ZZZ_CheckModificationsTimer, %ZZZ_CheckModificationsTimer%
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_CheckModifications() {

	Global AHK_ScriptName
	
	; Close current script if bad PID :
	LOC_LockFile := A_ScriptDir . "\conf\" . AHK_ScriptName . ".lock"
	If (FileExist(LOC_LockFile)) {
		FileRead, LOC_ScriptID, %LOC_LockFile%
		If (LOC_ScriptID != A_ScriptHwnd) {
			Process, Exist, %LOC_ScriptID%
			If (ErrorLevel == LOC_ScriptID) {
				AHK_Exit()
			}
		}
	} Else {
		ADM_Reload()
	}

	; Reload ini file if modified :
	Try {
		FileGetAttrib, LOC_Attributes, %A_ScriptDir%\conf\%AHK_ScriptName%.ini
		If (InStr(LOC_Attributes, "A")) {
			AHK_LoadIniFile()
			FileSetAttrib, -A, %A_ScriptDir%\conf\%AHK_ScriptName%.ini
		}
	} Catch LOC_Exception {
		AHK_Catch(LOC_Exception, "AHK_CheckModifications")
	}

	; Check *.ahk files :
	LOC_Reload := false
	If (!A_IsCompiled) {
		Loop, %A_ScriptDir%\*.ahk
		{
			Try {
				FileGetAttrib, LOC_Attributes, %A_LoopFileLongPath%
			} Catch LOC_Exception {
				AHK_Catch(LOC_Exception, "AHK_CheckModifications")
			}
			If (InStr(LOC_Attributes, "A")) {
				LOC_Reload := true
				Break
			}
		}
		If (LOC_Reload) {
			Sleep, 500
			Try {
				FileSetAttrib, -A, %A_ScriptDir%\*.ahk
			} Catch LOC_Exception {
				AHK_Catch(LOC_Exception, "AHK_CheckModifications")
			}
		}
	}
	Return, LOC_Reload
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Periodic system Timer :
;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_SetPeriodicCkeckTimers(PRM_Active = true) {
	
	Global
	SetTimer, AHK_SuspendingWindowsPeriodicTimer, % ZZZ_SuspendingWindowsPeriodicTimer
	SetTimer, WIN_BoringPopUpsPeriodicTimer, % (A_IsSuspended ? "Off" : ZZZ_BoringPopUpsPeriodicTimer)
	SetTimer, SYS_TaskbarColorPeriodicTimer, % (A_IsSuspended ? "Off" : ZZZ_TaskbarColorPeriodicTimer)
	SetTimer, SYS_TaskbarCalendarPeriodicTimer, % (A_IsSuspended ? "Off" : ZZZ_TaskbarCalendarPeriodicTimer)
	SetTimer, SYS_GetCPUAndMemoryInfosPeriodicTimer, % (A_IsSuspended ? "Off" : SYS_CPURefreshTime)
	SetTimer, SYS_StartButtonTooltipPeriodicTimer, % (A_IsSuspended ? "Off" : ZZZ_StartButtonTooltipPeriodicTimer)
	SetTimer, SYS_TaskbarClockPeriodicTimer, % ZZZ_TaskbarClockPeriodicTimer
	SetTimer, WIN_TransparencyPeriodicTimer, % (A_IsSuspended ? "Off" : ZZZ_TransparencyPeriodicTimer)
	SetTimer, SYS_StartMenuDisplayTimer, % (A_IsSuspended ? "Off" : ZZZ_StartMenuDisplayTimer)
	SetTimer, WIN_OpenSaveDialogsPeriodicTimer, % (A_IsSuspended ? "Off" : ZZZ_OpenSaveDialogsPeriodicTimer)
	SetTimer, WIN_ShowDialogsPeriodicTimer, % (A_IsSuspended ? "Off" : ZZZ_ShowDialogsPeriodicTimer)
	SetTimer, SCR_MouseAxisLockPeriodicTimer, % (A_IsSuspended ? "Off" : ZZZ_MouseAxisLockPeriodicTimer)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Exit operations :
;;;;;;;;;;;;;;;;;;;

AHK_Exit:
AHK_Exit()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_Exit() {

	Global AHK_ScriptName, AHK_ScriptInfo, ZZZ_ClosePreviousAHKInstanceTimer
	AHK_Log("> AHK_Exit()")
	Gui, 10:Destroy
	Gui, 10:Font, s16
	Gui, 10:Add, Text, , % "`n Exiting " . AHK_ScriptInfo . " `n"
	SetTimer, AHK_FadeOutSplashScreen, -1
	BlockInput, Off
	SetTimer, AHK_ClosePreviousAHKInstanceTimer, %ZZZ_ClosePreviousAHKInstanceTimer%
	AHK_SetPeriodicCkeckTimers(false)
	SetTimer, ZZZ_CheckModificationsTimer, Off
	SetTimer, TRY_CheckTrayIconStateTimer, Off
	AHK_ResetControlKeys()
	, WIN_RollDownAll()
	, WIN_MinimizeToTray(, PRM_Flags := -1)
	, AHK_SaveIniFile()
	, AHK_KillTimeProcess()
	, WIN_AlwaysOnTopAllOff()
	, AHK_ResetCursor()
	, WIN_SetBrightness(128)
	, WIN_TransparencyAllOff()
	, SYS_RestoreClock()
	, OnMessage(0x11, "")
	, OnMessage(0x200, "")
	, OnMessage(0x202, "")
	, OnMessage(0x404, "")
	, OnMessage(1028, "")
	, AHK_KillGUIs()
	, SCR_MouseRingManager(-1)
	, AHK_RunLockManager(false)
	, AHK_Log("< AHK_Exit()")
	ExitApp
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_KillGUIs() {
	Loop, 99 {
		Gui, %A_Index%:Destroy
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_ClosePreviousAHKInstanceTimer:
SetTimer, AHK_ClosePreviousAHKInstanceTimer, Off
IfWinExist, AutoHotKey.ahk ahk_class #32770, Could not close the previous instance of this script
{
	WinActivate
	SendInput, !o
} Else {
	SetTimer, AHK_ClosePreviousAHKInstanceTimer, %ZZZ_ClosePreviousAHKInstanceTimer%
}
Return

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
			WinSet, Transparent, %PRM_Transparency%
			WinSet, ExStyle, +0x00000020
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

; Shell hook to minimize to tray :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_InitLibraries() {
	Global
	AHK_Log("> AHK_InitLibraries()")
	, AHK_Suspended := false
	, AHK_AutoHotKeyPID := DllCall("kernel32.dll\GetCurrentProcessId")
	, AHK_AutoHotKeyID := WinExist("ahk_class AutoHotkey ahk_pid " . AHK_AutoHotKeyPID)
	, ZZZ_ShellHook := DllCall("user32.dll\RegisterWindowMessage", "Str","SHELLHOOK")
	, ZZZ_CloseHandleFunction := AHK_GetFunction("kernel32", "CloseHandle")
	, DllCall("user32.dll\RegisterShellHookWindow", "Uint", AHK_AutoHotKeyID)
	, AHK_Log("< AHK_InitLibraries()")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Windows clock :
;;;;;;;;;;;;;;;;;

AHK_WindowsTimeSynchronization(PRM_Action = false) {

	Global LOG_DomainLogin, LOG_DomainEncryptedPassword
	If (PRM_Action) {
		If (FileExist(A_ScriptDir . "\bin\Time.exe")) {
			APP_RunAs()
			Try {
				Run, "%A_ScriptDir%\bin\Time.exe" /P SYNC /M:3600 /W:1000, , Hide UseErrorLevel
			} Catch LOC_Exception {
				AHK_Catch(LOC_Exception, "AHK_WindowsTimeSynchronization")
			}
			RunAs
		}
	} Else {
		SetTimer, AHK_WindowsTimeSynchronization, -1
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_WindowsTimeSynchronization:
AHK_WindowsTimeSynchronization(true)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_KillTimeProcess() {
	Process, Exist, Time.exe
	If (ErrorLevel) {
		Process, Close, %ErrorLevel%
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

; Mouse cursors :
;;;;;;;;;;;;;;;;;

AHK_SetCursor(PRM_CursorString = "") {

	Static STA_CursorA := { "No" : 0, "Arrow" : 32512, "Help" : 32651, "AppStarting" : 32650, "Wait" : 32514, "Cross" : 32515, "IBeam" : 32513, "UpArrow" : 32516, "Disabled" : 32648, "CursorSizeNS" : 32645, "SizeWE" : 32644, "SizeNWSE" : 32642, "SizeNESW" : 32643, "Size" : 32640, "SizeAll" : 32646, "Icon" : 32641, "Hand" : 32649 }
	Static STA_CopyImageFunction := AHK_GetFunction("user32", "CopyImage"), STA_SetSystemCursorFunction := AHK_GetFunction("user32", "SetSystemCursor"), STA_CreateCursorFunction := AHK_GetFunction("user32", "CreateCursor")

	LOC_CursorID := STA_CursorA[PRM_CursorString]
	If (LOC_CursorID) {
		For LOC_Cursor, LOC_Value In STA_CursorA
		{
			LOC_CursorHandle := DllCall("user32.dll\LoadCursor", "UInt", 0, "Int", LOC_CursorID) ; DLL call to name and not function pointer, because not working
			, LOC_CursorHandle := DllCall(STA_CopyImageFunction, "Uint", LOC_CursorHandle, "Uint", 0x2, "Int", 0, "Int", 0, "Int", 0)
			, DllCall(STA_SetSystemCursorFunction, "Uint", LOC_CursorHandle, "Int", LOC_Value)
		}
	} Else {
		LOC_CursorHandle := DllCall("user32.dll\LoadCursor", "UInt", 0, "UInt", STA_CursorA["Arrow"]) ; DLL call to name and not function pointer, because not working
		, LOC_CursorHandle := DllCall(STA_CopyImageFunction, "UInt", LOC_CursorHandle, "UInt", 2, "Int", 0, "Int", 0, "UInt", 0)
		, VarSetCapacity(LOC_AndMask, 32*4, 0xFF)
		, VarSetCapacity(LOC_XOrMask, 32*4, 0)
		, LOC_CursorHandle := DllCall(STA_CreateCursorFunction, "UInt", 0, "Int", 0, "Int", 0, "Int", 32, "Int", 32, "UInt", &LOC_AndMask, "UInt", &LOC_XOrMask)
		, DllCall(STA_SetSystemCursorFunction, "UInt", LOC_CursorHandle, "UInt", STA_CursorA["Arrow"])
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_ResetCursor() {
	DllCall("user32.dll\SystemParametersInfo", "UInt", 0x57, "UInt", 0, "UInt", 0, "UInt", 0) ; DLL call to name and not function pointer, because not working
	Return
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Audio activation :
;;;;;;;;;;;;;;;;;;;;
AHK_ToggleAudio:
AHK_ToggleAudio()
, TRY_ShowTrayTip("Audio: " . (AHK_AudioEnabled ? "On" : "Off"))
Menu, Options, Show
Return

^+#a::
AHK_ToggleAudio()
Return

AHK_ToggleAudio() {
	Global
	AHK_AudioEnabled := !AHK_AudioEnabled
	, TRY_UpdateMenus()
	, AHK_SaveIniFile()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suspend AutoHotKey :
;;;;;;;;;;;;;;;;;;;;;;

AHK_ToggleSuspend:
^+#Pause::
Pause::
Suspend, Permit
AHK_ToggleSuspend()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_ToggleSuspend(PRM_NewValue = -1) {
	Global
	AHK_Suspended := (PRM_NewValue == -1 ? !AHK_Suspended : (PRM_NewValue ? true : false))
	If (!AHK_Suspended) {
		SetTimer, ZZZ_CheckModificationsTimer, %ZZZ_CheckModificationsTimer%
		AHK_SetPeriodicCkeckTimers()
	} Else {
		AUD_Beep()
	}
	AHK_ApplySuspendedState()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_ApplySuspendedState() {
	Global
	Suspend, Permit
	If (AHK_Suspended) {
		Suspend, On
		Menu, Tray, Rename, &Suspend, &Resume
		TRY_AddMenuItem("Tray", "&Resume", "AHK_ToggleSuspend", "shell32.dll", 177)
		Menu, Administration, Rename, Ctrl + Win + Shift + Escape`t&Suspend, Ctrl + Win + Shift + Escape`t&Resume
		; TODO : icone resume
		TRY_AddMenuItem("Administration", "Ctrl + Win + Shift + Escape`t&Resume", "AHK_ToggleSuspend", "shell32.dll", 177)
		, TRY_ShowTrayTip(AHK_ScriptInfo . " suspended`nCtrl + Win + Shift + Esc to resume it again", 2)
	} Else {
		Suspend, Off
		Menu, Tray, Rename, &Resume, &Suspend
		TRY_AddMenuItem("Tray", "&Suspend", "AHK_ToggleSuspend", "shell32.dll", 110)
		Menu, Administration, Rename, Ctrl + Win + Shift + Escape`t&Resume, Ctrl + Win + Shift + Escape`t&Suspend
		TRY_AddMenuItem("Administration", "Ctrl + Win + Shift + Escape`t&Suspend", "AHK_ToggleSuspend", "shell32.dll", 110)
		, TRY_ShowTrayTip(AHK_ScriptInfo . " resumed`nCtrl + Win + Shift + Esc to suspend it again", 1)
	}

	TRY_UpdateMenus()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_SuspendingWindowsPeriodicTimer:
IfWinActive, ahk_group WIN_SuspendingWindowsGroup
{
	If (!A_IsSuspended) {
		Suspend, On
		AUD_Beep()
	}
} Else {
	If (A_IsSuspended
		&& !AHK_Suspended) {
		Suspend, Off
		AUD_Beep()
	}
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Send straight raw text :
;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_SendRaw(PRM_Text = "") {

	If (PRM_Text) {
		LOC_ClipBoard := ClipBoardAll
		TXT_SetClipBoard(PRM_Text)
		SendInput, ^v
		Sleep, 200
		TXT_SetClipBoard(LOC_ClipBoard)
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Script Backup :
;;;;;;;;;;;;;;;;;

AHK_BackupScripts() {

	Global AHK_BackupDays
	LOC_Folder := A_ScriptDir . "\backup\" . A_YYYY "-" . A_MM . "-" . A_DD . "_" . A_Hour . "-" . A_Min
	, LOC_CurrentTimeStamp := 365 * A_YYYY + 30 * A_MM + A_DD
	If (FileExist(LOC_Folder)) {
		FileGetAttrib, LOC_Attributes, %LOC_Folder%
		If (!InStr(LOC_Attributes, "D"))	{
			FileDelete, %LOC_Folder%
			FileCreateDir, %LOC_Folder%
		}
	} Else {
		FileCreateDir, %LOC_Folder%
	}
	FileCopy, %A_ScriptDir%\*.ahk, %LOC_Folder%\*.bak, 1
	
	If (AHK_BackupDays) {
		Loop, Files, %A_ScriptDir%\backup\????-??-??_??-??, D
		{
			If (LOC_CurrentTimeStamp - 365 * SubStr(A_LoopFileName, 1, 4) - 30 * SubStr(A_LoopFileName, 6, 2) - SubStr(A_LoopFileName, 9, 2) > AHK_BackupDays) {
				FileRemoveDir, %A_LoopFileFullPath%, 1
			}
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Generic AHK Trace :
;;;;;;;;;;;;;;;;;;;;;

AHK_Trace(PRM_SecondLevelLog = false, PRM_String1 = "", PRM_String2 = "", PRM_String3 = "", PRM_String4 = "", PRM_String5 = "", PRM_String6 = "", PRM_String7 = "", PRM_String8 = "", PRM_String9 = "") {
	
	Global AHK_ScriptName, AHK_LogsEnabled, AHK_DebugEnabled, ZZZ_HideDebugTimer
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
			FileAppend, % LOC_FormatedLog, % A_ScriptDir . "\conf\" . AHK_ScriptName . ".log"
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

; AHK log :
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

; Do Nothing :
;;;;;;;;;;;;;;

AHK_DoNothing:
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; File Windows information :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_GetFileInfo(PRM_File) {
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


AHK_ResetControlKeys:
^#F5::
AHK_ResetControlKeys()
Return

AHK_ResetControlKeys() {
	LOC_Keys := "LButton,RButton,MButton,XButton1,XButton2,LControl,RControl,LWin,RWin,LAlt,RAlt,LShift,RShift,CapsLock,NumLock"
	Loop, Parse, LOC_Keys
	{
		If (GetKeyState(A_LoopField)) {
			SendInput, {%A_LoopField% Up}
		}
	}
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

AHK_SetProcessAffinity(PRM_PID = 0x0, PRM_CPU = 2) {
	; PRM_CPU == 1 : CPU #0
	; PRM_CPU == 2 : CPU #1
	; PRM_CPU == 3 : CPU #0 & #1
	Global ZZZ_CloseHandleFunction
	Static STA_GetCurrentProcessIdFunction := AHK_GetFunction("kernel32", "GetCurrentProcessId"), STA_OpenProcess := AHK_GetFunction("kernel32", "OpenProcess"), STA_GetProcessAffinityMaskFunction := AHK_GetFunction("kernel32", "GetProcessAffinityMask"), STA_SetProcessAffinityMaskFunction := AHK_GetFunction("kernel32", "SetProcessAffinityMask")
	Process, Exist, %PRM_PID%
	LOC_PID := (ErrorLevel ? PRM_PID : DllCall(STA_GetCurrentProcessIdFunction))
	LOC_Handler := DllCall(STA_OpenProcess, "Int", 1536, "Int", 0, "Int", LOC_PID)
	DllCall(STA_GetProcessAffinityMaskFunction, "Int", LOC_Handler, "IntP", LOC_PAM, "IntP", LOC_SAM)
	If (PRM_CPU > 0
		&& PRM_CPU <= LOC_SAM) {
		LOC_Return := DllCall(STA_SetProcessAffinityMaskFunction, "Int", LOC_Handler, "Int", PRM_CPU)
	}
	DllCall(ZZZ_CloseHandleFunction, "Int", LOC_Handler)
	Return, (LOC_Return == "" ? 0 : LOC_Return)
	
	
	;~ Process,Exist,%A_LoopField%
   ;~ if errorlevel <> 0
      ;~ {
      ;~ Affinity_pid:=ErrorLevel
      ;~ Affinity_Process:=DllCall("OpenProcess","UInt",0x1F0FFF,"Int",false,"UInt",Affinity_pid)
      ;~ DllCall("SetProcessAffinityMask","UInt",Affinity_Process,"UInt",Task_Affinity)
      ;~ DllCall("CloseHandle","UInt",Affinity_Process)
      ;~ }
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
