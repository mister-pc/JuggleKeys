;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; API Windows : http://msdn.microsoft.com/en-us/library/windows/desktop/ff818516%28v=vs.85%29.aspx
; Styles : http://msdn.microsoft.com/en-us/library/windows/desktop/ff700543%28v=vs.85%29.aspx
; Gradients : http://www.autohotkey.com/board/topic/80588-how-to-simulate-a-linear-gradient/#entry57229

; Bugs :
;;;;;;;;

; Supprimer LOG_DomainEncryptedPassword là où il ne sert pas (déclaré en Global inutilement)

; logon background

; Modif .ini non prise en cpte

; Propriété d'une tâche planifiée se ferme immédiatement

; Déplacer la règle graduée avec un clic gche glissé/déposé

; Revoir les agrandissements sur l'autre écran, surtt lrsq la fenêtre est dj agrandie ou pas

; StripMyRights (av IE) ne se lance pas !

; Revoir ds le presse-papiers les fics enregs av des trous ds les noms (parex, 01 qui saute)

; KBD_WordControl : gérer les multiples retours-chariots, qui ne st p pris en cpte ds la sélection naturelle
;                    gérer le cut

; Pr les insertions en mode texte des items (mot de passe, CB, Bank, ...), faire une première saisie pr demander le mdp initialement une fois (et le conserver seult en mémoire) - ou faire une option de conservation disque ou pas : tout crypter, sauf le mot de passe, enregistré en static dans une fonction

; Ctrl+Win+Shift+@ pr modifier les adresses LOG_MailEncryptedAddressesManager et les mdp LOG_MainEncryptedPassword, LOG_MainEncryptedPassword, LOG_WindowsLogin, LOG_CBEncryptedNumber, LOG_BankNumber

; Gdip_Startup existe encore... Mutualiser ?

; Jarter les PeriodicTimer AHK_InitTimers
; Faire une variable ini DisplayFusion, pr savoir si cé lancé ou pas, et désactiver tt code DF si pas

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

; Les titres des fenêtres matchent aves des regex (chercher RegEx ds l'aide) 

; APP_ShowQuickHelpTooltip ne marche pas pr les rulers

; Faire un pense-bête (avec alarme ?)

; Mesure d'angle

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
; 52 : GUI_AndroidActivitySimulation
; 53 : GUI_AndroidActivityTop
; 54 : GUI_AndroidActivityLeft
; 55 : GUI_AndroidActivityBottom
; 56 : GUI_AndroidActivityRight
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
TXT_OnClipboardChange(PRM_Enable := -1)
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
SetTimer, AHK_CheckModificationsTimer, -1

AHK_InitTimers()
, AHK_LoadIniFile(true)
, AHK_SetExecutionMode()
, AHK_Log()
, AHK_InitLibraries()
, AHK_ResetControlKeys()
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
, APP_InitAndroidCursorTimer()
, SYS_SetClassicStartMenu()
, SCR_InitWallpapers()
, AHK_BackupScripts()
, TXT_OnClipboardChange(1)
SetTimer, TRY_CheckTrayIconStatePeriodicTimer, %ZZZ_CheckTrayIconStatePeriodicTimer%
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
#Include %A_ScriptDir%\mouse.ahk
#Include %A_ScriptDir%\power.ahk
#Include %A_ScriptDir%\screen.ahk
#Include %A_ScriptDir%\system.ahk
#Include %A_ScriptDir%\text.ahk
#Include %A_ScriptDir%\tools.ahk
#Include %A_ScriptDir%\tray.ahk
#Include %A_ScriptDir%\windows.ahk

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_RunLockManager(PRM_Active = true) {
	LOC_File := A_Temp . "\" . A_Username . ".lock"
	
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
	
	; Periodic timers are positive, non-periodic ones are negative :
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
	, ZZZ_CheckTrayIconStatePeriodicTimer := 501
	
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
	, ZZZ_AndroidMouseTimer, -1024
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
			, SCR_WallpaperRotationEnabled: "     - Automatic wallpaper rotation disabled`n"
			, SCR_WallpaperFolder: "     - Wallpaper folder not defined`n"
			, LOG_BankEncryptedAccount: "     - Bank encrypted account not defined`n"
			, LOG_BankEncryptedProAccount: "     - Bank encrypted pro account not defined`n"
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
	
	LOC_Variables := (AHK_Experimental
		? "TRY_TrayTipEnabled|AHK_TooltipsEnabled|AHK_DebugEnabled|SCR_MouseTracesEnabled|WIN_FocusFollowsMouseEnabled|SCR_WallpaperRotationEnabled"
		: "TRY_TrayTipEnabled|AHK_TooltipsEnabled|SCR_MouseTracesEnabled|WIN_FocusFollowsMouseEnabled|SCR_WallpaperRotationEnabled")
		
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
	LOC_Variables := "LOG_BankEncryptedAccount|LOG_BankEncryptedProAccount|LOG_CBEncryptedNumber|LOG_MailEncryptedAddresses|LOG_MainEncryptedPassword"
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
	Static STA_DefaultValuesA := { "WIN_Brightness": 128, "WIN_MenusTransparency": 230, "AHK_Suspended": 0, "AHK_LogsEnabled": 0, "AHK_DebugEnabled": 0, "AHK_Admin": 1, "AHK_Experimental": 0, "AHK_SSD": 1, "AHK_ToolTipsEnabled": 1, "AHK_AudioEnabled": 1, "AHK_BackupDays": 60, "AUD_Step": 5, "AUD_BigStep": 10, "SYS_CPURefreshTime": 1000, "SCR_WallpaperRotationEnabled": 1, "SCR_WallpaperFolder": 0, "WIN_FocusFollowsMouseEnabled": 0, "SCR_MouseTracesEnabled": 1, "AHK_LeftMouseButtonHookEnabled": 1, "AHK_MiddleMouseButtonHookEnabled": 1, "AHK_RightMouseButtonHookEnabled": 1, "AHK_FourthMouseButtonHookEnabled": 1, "AHK_FifthMouseButtonHookEnabled": 1, "SYS_ScrollTimeOut": 400, "SYS_ScroolBoost": 20, "SYS_ScrollLimit": 60, "SCR_ChangeWallPaperTimer": 3600, "SCR_PixelsPerMillimeter": 3.5, "APP_AndroidActivityEnabled": 0, "SCR_MouseRings": 20 }
	Static STA_ApplicationDefaultPathA := { "Apache": "G:\xamp\apache\bin\httpd.exe" ; APP_ApachePath
		, "AutoScriptWriter": "AutoHotkey\AutoScriptWriter\AutoScriptWriter.exe" ; APP_AutoScriptWriterPath
		, "Android": "Nox\bin\Nox.exe" ; APP_AndroidPath
		, "Bash": "G:\git\git-bash.exe" ; APP_BashPath
		, "CDBurner": "CDBurnerXP\cdbxpp.exe" ; APP_CDBurnerPath
		, "ClassicStartMenu": "Classic Shell\ClassicStartMenu.exe" ; APP_ClassicStartMenuPath
		, "CygWin": "CygWin\Cygwin.bat" ; APP_CygWinPath
		, "DirectoryOpus": "GPSoftware\Directory Opus\dopus.exe" ; APP_DirectoryOpusPath
		, "DirectoryOpusRT": "GPSoftware\Directory Opus\dopusrt.exe" ; APP_DirectoryOpusRTPath
		, "DisplayFusion": "DisplayFusion\DisplayFusion.exe" ; APP_DisplayFusionPath
		, "Eclipse": "Eclipse\eclipse.exe" ; APP_EclipsePath
		, "Firefox": "Pale Moon\palemoon.exe" ; APP_FirefoxPath
		, "InternetExplorer": "Internet Explorer\iexplore.exe" ; APP_InternetExplorerPath
		, "JavaWebStart": "Java\jre\bin\javaws.exe" ; APP_JavaWebStartPath
		, "MP3Editor": "Mp3 Editor Pro\Mp3EditorPro.exe"
		, "MailApplication": "Mozilla Thunderbird\thunderbird.exe" ; APP_MailApplicationPath
		, "MediaMonkey": "MediaMonkey\MediaMonkey.exe" ; APP_MediaMonkeyPath
		, "MySQL": "G:\xamp\mysql\bin\mysqld.exe" ; APP_MySQLPath ; APP_MySQLPath
		, "Photoshop": "Adobe\Adobe Photoshop CS2\Photoshop.exe" ; APP_PhotoshopPath
		, "Quintessential": "Quintessential Media Player\QMPlayer.exe" ; APP_QuintessentialPath
		, "RegistryManager": "Registrar Registry Manager\rr.exe" ; APP_RegistryManagerPath
		, "SQLDeveloper": "" ; APP_SQLDeveloperPath
		, "SciTE": "AutoHotkey\SciTE\SciTE.exe" ; APP_SciTEPath
		, "SnagIt": "TechSmith\Snagit 13\Snagit32.exe" ; APP_SnagItPath
		, "StartupDelayer": "r2 Studios\Startup Delayer\Startup Delayer.exe" ; APP_StartupDelayerPath
		, "TextEditor": "IDM Computer Solutions\UltraEdit\uedit64.exe" ; APP_TextEditorPath
		, "VideoConverter": "Freemake\Freemake Video Converter\FreemakeVC.exe" ; APP_VideoConverterPath
		, "VisionGo": "Vision Go 0.5\VisionGo.exe" ; APP_VisionGoPath
		, "WinSpector": "Winspector\WinspectorU.exe" ; APP_WinSpectorPath
		, "WindowsMediaPlayer": "Windows Media Player\wmplayer.exe" ; APP_WindowsMediaPlayerPath
		, "uTorrent": "uTorrent\uTorrent.exe" } ; APP_uTorrentPath
	Static STA_FirstLoad := true
	Local LOC_Exception, LOC_VariableName, LOC_DefaultValue, LOC_ApplicationName, LOC_DefaultPath, LOC_Directories, LOC_Attributes, LOC_Exception

	; Create specific working directories :
	LOC_Directories := "\conf|\clip|\media"
	Loop, Parse, LOC_Directories, |
	{
		LOC_Attributes := FileExist(A_ScriptDir . A_LoopField)
		If (LOC_Attributes) {
			If (!InStr(LOC_Attributes, "D")) {
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
	
	; Get suspend state & set program files variable :
	If (PRM_FirstLoad) {
		AHK_IniFile := A_ScriptDir . "\conf\" . A_Username . ".ini"
		IniRead, AHK_Suspended, %AHK_IniFile%, Main, Suspended, % STA_DefaultValuesA["AHK_Suspended"]
		If (A_Is64bitOS) {
			EnvGet, ZZZ_ProgramFiles32, ProgramFiles(x86)
			EnvGet, ZZZ_ProgramFiles64, ProgramW6432
		} Else {
			ZZZ_ProgramFiles32 := ZZZ_ProgramFiles64 := A_ProgramFiles
		}
	}

	; Load general variables :
	IniRead, AHK_Experimental, %AHK_IniFile%, Main, Experimental, % STA_DefaultValuesA["AHK_Experimental"]
	IniRead, AHK_Admin, %AHK_IniFile%, Main, Admin, % STA_DefaultValuesA["AHK_Admin"]
	IniRead, AHK_SSD, %AHK_IniFile%, Main, SSD, % STA_DefaultValuesA["AHK_SSD"]
	IniRead, WIN_Brightness, %AHK_IniFile%, Main, Brightness, % STA_DefaultValuesA["WIN_Brightness"]
	IniRead, WIN_MenusTransparency, %AHK_IniFile%, Main, MenusTransparency, % STA_DefaultValuesA["WIN_MenusTransparency"]
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
	IniRead, APP_AndroidActivityEnabled, %AHK_IniFile%, Applications, AndroidActivityEnabled, % STA_DefaultValuesA["APP_AndroidActivityEnabled"]
	For LOC_VariableName, LOC_DefaultValue In STA_DefaultValuesA
	{
		If (StrLen(%LOC_VariableName%) == 0) { ; set unset (but existing) global variables to their default value
			%LOC_VariableName% := LOC_DefaultValue
		}
	}

	If (AHK_Admin && !A_IsAdmin) {
		AHK_Admin := false
	}

	; Load application path variables :
	For LOC_ApplicationName, LOC_DefaultPath In STA_ApplicationDefaultPathA
	{
		IniRead, APP_%LOC_ApplicationName%Path, %AHK_IniFile%, Applications, %LOC_ApplicationName%Path, %LOC_DefaultPath%
		If (!APP_%LOC_ApplicationName%Path) {
			APP_%LOC_ApplicationName%Path := LOC_DefaultPath
		}
		If (APP_%LOC_ApplicationName%Path) {
			If (!FileExist(APP_%LOC_ApplicationName%Path)) {
				If (FileExist(ZZZ_ProgramFiles32 . "\" . APP_%LOC_ApplicationName%Path)) {
					APP_%LOC_ApplicationName%Path := ZZZ_ProgramFiles32 . "\" . APP_%LOC_ApplicationName%Path
				} Else If (FileExist(ZZZ_ProgramFiles64 . "\" . APP_%LOC_ApplicationName%Path)) {
					APP_%LOC_ApplicationName%Path := ZZZ_ProgramFiles64 . "\" . APP_%LOC_ApplicationName%Path
				} Else {
					APP_%LOC_ApplicationName%Path := ""
				}
			}
		} Else {
			APP_%LOC_ApplicationName%Path := ""
		}
	}
	SetTimer, AHK_CheckModificationsTimer, Off
	For LOC_ApplicationName, LOC_DefaultPath In STA_ApplicationDefaultPathA
	{
		IniWrite, % APP_%LOC_ApplicationName%Path, %AHK_IniFile%, Applications, %LOC_ApplicationName%Path
	}
	SetTimer, AHK_CheckModificationsTimer, %ZZZ_CheckModificationsTimer%

	; Android :
	If (PRM_FirstLoad) {
		If (WinExist("Nox App Player ahk_class Qt5QWindowIcon")) {
			SetTimer, APP_AndroidMouseTimer, -1
			If (APP_AndroidActivityEnabled) {
				APP_AndroidActivity(true)
			}
		} Else {
			If (APP_AndroidActivityEnabled) {
				APP_AndroidActivityEnabled := 0
				, AHK_SaveIniFile()
			}
		}
	}

	; Load alternate clipboard from file :
	Try {
		If (FileExist(A_ScriptDir . "\clip\alternate.clip")) {
			FileRead, TXT_ClipBoard, *c %A_ScriptDir%\clip\alternate.clip
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
	Local LOC_LogFile := A_ScriptDir . "\conf\" . A_Username . ".log", LOC_Exception := false
	SetTimer, AHK_CheckModificationsTimer, Off
	
	IniWrite, %AHK_Admin%, %AHK_IniFile%, Main, Admin
	IniWrite, %AHK_Experimental%, %AHK_IniFile%, Main, Experimental
	IniWrite, %AHK_SSD%, %AHK_IniFile%, Main, SSD
	IniWrite, %AHK_LogsEnabled%, %AHK_IniFile%, Main, LogsEnabled
	IniWrite, %AHK_DebugEnabled%, %AHK_IniFile%, Main, DebugEnabled
	IniWrite, %AHK_ToolTipsEnabled%, %AHK_IniFile%, Main, ToolTipsEnabled
	IniWrite, %AHK_Suspended%, %AHK_IniFile%, Main, Suspended
	IniWrite, %AHK_AudioEnabled%, %AHK_IniFile%, Main, AudioEnabled
	IniWrite, %SYS_CPURefreshTime%, %AHK_IniFile%, Main, CPURefreshTime
	IniWrite, %AUD_Step%, %AHK_IniFile%, Main, AudioStep
	IniWrite, %AUD_BigStep%, %AHK_IniFile%, Main, AudioBigStep
	IniWrite, %WIN_Brightness%, %AHK_IniFile%, Main, Brightness
	IniWrite, %WIN_MenusTransparency%, %AHK_IniFile%, Main, MenuTransparency
	IniWrite, %SCR_WallpaperRotationEnabled%, %AHK_IniFile%, Main, WallpaperRotationEnabled
	IniWrite, %SCR_ChangeWallPaperTimer%, %AHK_IniFile%, Main, WallpaperTimer
	IniWrite, %SCR_WallpaperFolder%, %AHK_IniFile%, Main, WallpaperFolder
	IniWrite, %SCR_PixelsPerMillimeter%, %AHK_IniFile%, Main, PixelsPerMillimeter
	IniWrite, %AHK_BackupDays%, %AHK_IniFile%, Main, BackupDays
	IniWrite, %APP_AndroidActivityEnabled%, %AHK_IniFile%, Applications, AndroidActivityEnabled

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
	IniRead, LOG_BankEncryptedProAccount, %AHK_IniFile%, Text, BankEncryptedProAccount, %A_Space%
	IniWrite, %LOG_BankEncryptedProAccount%, %AHK_IniFile%, Text, BankEncryptedProAccount
	IniRead, LOG_CBEncryptedNumber, %AHK_IniFile%, Text, CBEncryptedNumber, %A_Space%
	IniWrite, %LOG_CBEncryptedNumber%, %AHK_IniFile%, Text, CBEncryptedNumber
	IniRead, LOG_DomainName, %AHK_IniFile%, Text, DomainName, %A_Space%
	If (LOG_DomainName == "") {
		EnvGet, LOG_DomainName, USERDOMAIN
	}
	IniWrite, %LOG_DomainName%, %AHK_IniFile%, Text, DomainName
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

	SetTimer, AHK_CheckModificationsTimer, %ZZZ_CheckModificationsTimer%
	Return
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Check script modifications :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_CheckModificationsTimer:
SetTimer, AHK_CheckModificationsTimer, Off
If (AHK_CheckModifications()) {
	AHK_BackupScripts()
	, ADM_Reload()
} Else
If (!A_IsSuspended) {
	SetTimer, AHK_CheckModificationsTimer, %ZZZ_CheckModificationsTimer%
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_CheckModifications() {

	; Close current script if bad PID :
	LOC_LockFile := A_Temp . "\" . A_Username . ".lock"
	If (FileExist(LOC_LockFile)) {
		FileRead, LOC_ScriptID, %LOC_LockFile%
		If (LOC_ScriptID != A_ScriptHwnd) {
			Process, Exist, %LOC_ScriptID%
			If (ErrorLevel == LOC_ScriptID) {
				AHK_Exit()
			}
		}
	} Else {
		AHK_RunLockManager()
		; ADM_Reload()
	}

	; Reload ini file if modified :
	Try {
		FileGetAttrib, LOC_Attributes, %A_ScriptDir%\conf\%A_Username%.ini
		If (InStr(LOC_Attributes, "A")) {
			AHK_LoadIniFile()
			FileSetAttrib, -A, %A_ScriptDir%\conf\%A_Username%.ini
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

	Global AHK_ScriptInfo, ZZZ_ClosePreviousAHKInstanceTimer
	AHK_Log("> AHK_Exit()")
	Gui, 10:Destroy
	Gui, 10:Font, s16
	Gui, 10:Add, Text, , % "`n Exiting " . AHK_ScriptInfo . " `n"
	SetTimer, AHK_FadeOutSplashScreen, -1
	BlockInput, Off
	SetTimer, AHK_ClosePreviousAHKInstanceTimer, %ZZZ_ClosePreviousAHKInstanceTimer%
	AHK_SetPeriodicCkeckTimers(false)
	SetTimer, AHK_CheckModificationsTimer, Off
	SetTimer, TRY_CheckTrayIconStatePeriodicTimer, Off
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

; Shell hook to minimize to tray :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AHK_InitLibraries() {
	; TODO : Shell hook to minimize to tray
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

AHK_WindowsTimeSynchronization:
AHK_WindowsTimeSynchronization(true)
Return

AHK_WindowsTimeSynchronization(PRM_Action = false) {

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
		SetTimer, AHK_WindowsTimeSynchronization, -120000 ; 2 minutes after launching JuggleKeys, especially because the network connection isn't set up when the system just started
	}
}

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
		SetTimer, AHK_CheckModificationsTimer, %ZZZ_CheckModificationsTimer%
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

; Script Backup :
;;;;;;;;;;;;;;;;;

AHK_BackupScripts() {

	Global AHK_BackupDays
	LOC_Folder := A_ScriptDir . "\backup\" . A_YYYY "-" . A_MM . "-" . A_DD . "_" . A_Hour . "-" . A_Min
	, LOC_CurrentTimeStamp := 365 * A_YYYY + 30 * A_MM + A_DD
	If (FileExist(LOC_Folder)) {
		FileGetAttrib, LOC_Attributes, %LOC_Folder%
		If (!InStr(LOC_Attributes, "D")) {
			FileDelete, %LOC_Folder%
			FileCreateDir, %LOC_Folder%
		}
	} Else {
		FileCreateDir, %LOC_Folder%
	}
	FileCopy, %A_ScriptDir%\*.ahk, %LOC_Folder%\*.bak, 1
	FileCopy, %A_ScriptDir%\conf\*.ini, %LOC_Folder%, 1
	
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

AHK_SetExecutionMode() {
	Global AHK_Admin, AHK_Experimental
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
