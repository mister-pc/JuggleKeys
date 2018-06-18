;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Information input window :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_InitGroups() {
	Global ZZZ_FieldsManagerWindowsGroup
	LOG_FieldsManager(PRM_Title := "", PRM_Text := "", PRM_TextWidth := 0, PRM_VariableNames := "DontSet", PRM_VariableWidth := 0, PRM_SetDestroyToValue := false)
	GroupAdd, ZZZ_FieldsManagerWindowsGroup, Enregistement du compte en banque ahk_class AutoHotkeyGUI
	GroupAdd, ZZZ_FieldsManagerWindowsGroup, Enregistrement de la Carte Bleue ahk_class AutoHotkeyGUI
	GroupAdd, ZZZ_FieldsManagerWindowsGroup, Informations d'identification à Windows ahk_class AutoHotkeyGUI
	GroupAdd, ZZZ_FieldsManagerWindowsGroup, Informations d'identification au domaine ahk_class AutoHotkeyGUI
	GroupAdd, ZZZ_FieldsManagerWindowsGroup, Identification locale ahk_class AutoHotkeyGUI
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

5GuiClose:  ; { Enregistement du compte en banque | Enregistrement de la Carte Bleue | Informations d'identification à Windows | Informations d'identification au domaine | Identification locale }
5GuiEscape:
5GuiEscape()
Return

5GuiEscape() {
	LOG_FieldsManager(PRM_Title := "", PRM_Text := "", PRM_TextWidth := 0, PRM_VariableNames := "DontSet", PRM_VariableWidth := 0, PRM_SetDestroyToValue := true)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


LOG_GetFieldValue(PRM_VariableName) {
	LOG_FieldValueManager(PRM_GetAction := 0, PRM_VariableName)
}

LOG_SetFieldValue(PRM_VariableName, PRM_DecryptedValue = false, PRM_Display = true) {
	LOG_FieldValueManager(PRM_SetAction := 1, PRM_VariableName, PRM_DecryptedValue, PRM_Display)
}

LOG_FieldValueManager(PRM_Action, PRM_VariableName, PRM_DecryptedValue = false, PRM_Display = false) {
	
	; PRM_Action ==  1 : set
	; PRM_Action ==  0 : get
	; PRM_Action == -1 : password check
	
	

	Global LOG_MailEncryptedAddresses, LOG_BankEncryptedAccount, LOG_BankEncryptedProAccount, LOG_CBEncryptedNumber, LOG_DomainEncryptedPassword, LOG_MainEncryptedPassword, LOG_DomainName
	Static STA_Password := ""
	, STA_EncryptedFields := "LOG_MailEncryptedAddresses,LOG_BankEncryptedAccount,LOG_BankEncryptedProAccount,LOG_CBEncryptedNumber,LOG_DomainEncryptedPassword,LOG_MainEncryptedPassword"
	
	;~ ; Password check :
	If (!STA_Password
		|| STA_Password != LOG_Decrypt(LOG_MainEncryptedPassword, STA_Password)) {
		; MsgBox, no STA_Password %PRM_VariableNames%
		STA_Password := ""
		If (PRM_VariableNames != "LOG_MainEncryptedPassword") {
			LOG_FieldsManager("Identification locale", "Mot de &passe principal", 0, "LOG_MainEncryptedPassword", 150)
			If (STA_Password != LOG_Decrypt(LOG_Password, STA_Password)) {
				STA_Password := ""
				Return, false
			} 
		}
	}

	LOC_Encrypted := false
	If PRM_VariableName In %STA_EncryptedFields%
	{
		LOC_Encrypted := true
	}
	
	; set value :
	If (PRM_Set == 1) {
		LOC_Encrypted := false
		If PRM_VariableName In %STA_EncryptedFields%
		{
			%PRM_VariableName% := LOG_Encrypt(PRM_DecryptedValue, STA_Password)
		} Else {
			%PRM_VariableName% := PRM_DecryptedValue
		}
		Return
	}
	
	; get value :
	If (PRM_Set == 0) {
	}
}

LOG_FieldsManager(PRM_Title, PRM_Text, PRM_TextWidth, PRM_VariableNames, PRM_VariableWidth, PRM_SetDestroyToValue = -1) {

	Global AHK_ScriptInfo
	Static STA_InputField1 := ""
	, STA_InputField2 := ""
	, STA_InputField3 := ""
	, STA_Password := ""
	, STA_Destroy := 0

	If (PRM_SetDestroyToValue != -1) {
		STA_Destroy := PRM_SetDestroyToValue
		Return
	}
	If (PRM_VariableNames == "DontSet"
		|| WinActive("ahk_group ZZZ_FieldsManagerWindowsGroup")) {
		Return
	}
	
	; encrypted field ?
	LOC_EncryptedField := false
	Loop, Parse, PRM_VariableNames, `,
	{
		If A_LoopField In LOG_MailEncryptedAddresses,LOG_BankEncryptedAccount,LOG_BankEncryptedProAccount,LOG_CBEncryptedNumber,LOG_DomainEncryptedPassword,LOG_MainEncryptedPassword
		{
			LOC_EncryptedField := true
			Break
		}
	}
	
	; record variable names :
	LOC_FieldsNumber := 0
	Loop, Parse, PRM_VariableNames, `,
	{
		LOC_FieldsNumber++
		, LOC_VariableName%LOC_FieldsNumber% := A_LoopField
	}

	; record GUI text :
	LOC_TotalFieldsNumber := Max(1, LOC_FieldsNumber)
	, LOC_FieldsNumber := 0
	Loop, Parse, PRM_Text, `,
	{
		LOC_FieldsNumber++
		, LOC_Text%LOC_FieldsNumber% := A_LoopField
	}

	; display GUI ?
	LOC_DisplayGUI := false
	, LOC_TotalFieldsNumber := Max(LOC_TotalFieldsNumber, LOC_FieldsNumber)
	Loop, %LOC_TotalFieldsNumber% {
		LOC_VariableName := LOC_VariableName%A_Index%
		, LOC_VariableValue := %LOC_VariableName%
		
		If (!LOC_VariableValue
			|| LOC_EncryptedField
				&& LOG_Decrypt(LOC_VariableValue, STA_Password) == "") {
			LOC_DisplayGUI := true
			Break
		}
	}

	; Display GUI (if necessary) :
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	If (LOC_DisplayGUI) {
		Gui, 5:Destroy ; { Enregistement du compte en banque | Enregistrement de la Carte Bleue | Informations d'identification à Windows | Informations d'identification au domaine | Identification locale }
		Gui, 5:-MaximizeBox -MinimizeBox -Resize +Owner +ToolWindow +AlwaysOnTop +OwnDialogs
		Gui, 5:Margin, 20, 20

		Loop, %LOC_TotalFieldsNumber% {
			LOC_VariableName := LOC_VariableName%A_Index%
			, LOC_VariableNameValueIsSet := %LOC_VariableName%
			, LOC_Text := LOC_Text%A_Index%

			Gui, 5:Font, Norm
			If (PRM_TextWidth > 0) {
				Gui, 5:Add, Text, xm yp+30 +Right w%PRM_TextWidth%, %LOC_Text%  :  `
			} Else {
				Gui, 5:Add, Text, xm yp+30 +Right, %LOC_Text%  :  `
			}

			Gui, 5:Font, Bold
			If (PRM_VariableWidth > 0) {
				Gui, 5:Add, Edit, x+1 yp-3 w%PRM_VariableWidth% vSTA_InputField%A_Index%, % %LOC_VariableName%
			} Else {
				Gui, 5:Add, Edit, x+1 yp-3 vSTA_InputField%A_Index%, % %LOC_VariableName%
			}
		}
		Gui, 5:Font, Norm
		Gui, 5:Add, StatusBar, , Press Esc to exit
		Gui, 5:Show, , %PRM_Title% - %AHK_ScriptInfo%

		Loop
		{
			If (STA_Destroy) {
				Gui, 5:Destroy
				STA_Destroy := false
				Break
			}
			GuiControlGet, LOC_GUIVisible, 5:Visible, STA_InputField1
			If (LOC_GUIVisible) {
				Loop, %LOC_TotalFieldsNumber% {
					LOC_VariableValue := LOC_VariableName%A_Index%
					GuiControlGet, %LOC_VariableValue%, 5:, STA_InputField%A_Index%
					AHK_Debug("Variable ", %LOC_VariableValue%)
					If (LOC_EncryptedField) {
						%LOC_VariableValue% := LOG_Encrypt(%LOC_VariableValue%, STA_Password)
					}
				}
				Sleep, 100
			} Else {
				Break
			}
		}
		WIN_FocusLastWindow()
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_TrayMenuMailAddresses:
WIN_FocusLastWindow()
LOG_MailEncryptedAddressesManager()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^#à::
; AHK_KeyWait("#^")
LOG_MailEncryptedAddressesManager()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_MailEncryptedAddressesManager(PRM_HotKey = false, PRM_SelectedIndex = 0) {

	Global LOG_MailEncryptedAddresses, AHK_IniFile, AHK_ScriptInfo, SCR_VirtualScreenX, SCR_VirtualScreenY, SCR_VirtualScreenWidth, SCR_VirtualScreenHeight
	Static STA_MailAddress, STA_MailAddressIndex, STA_Rows, STA_ActiveWindowID, STA_Delta := 3

	If (PRM_SelectedIndex > 0
		&& !PRM_HotKey) {
		STA_MailAddressIndex := PRM_SelectedIndex
		Return
	}
	If (PRM_HotKey == "Up") {
		If (STA_MailAddressIndex == 1) {
			STA_MailAddressIndex := STA_Rows + 1
		}
		STA_MailAddressIndex--
		GuiControl, 6:Choose, STA_MailAddress, % STA_MailAddressIndex ; GUI_MailAddresses
		Return
	}
	If (PRM_HotKey == "Down") {
		If (STA_MailAddressIndex == STA_Rows) {
			STA_MailAddressIndex := 0
		}
		STA_MailAddressIndex++
		GuiControl, 6:Choose, STA_MailAddress, % STA_MailAddressIndex
		Return
	}
	If (PRM_HotKey == "PgUp") {
		STA_MailAddressIndex := 1
		GuiControl, 6:Choose, STA_MailAddress, % STA_MailAddressIndex
		Return
	}
	If (PRM_HotKey == "PgDn") {
		STA_MailAddressIndex := STA_Rows
		GuiControl, 6:Choose, STA_MailAddress, % STA_MailAddressIndex
		Return
	}
	If (PRM_HotKey == "Select") {
		GuiControlGet, STA_MailAddressIndex, 6:, STA_MailAddress
		Return
	}
	If (PRM_HotKey == "Enter") {
		If (PRM_SelectedIndex > 0) {
			STA_MailAddressIndex := PRM_SelectedIndex
		}
		Gui, 6:Submit ; GUI_MailAddresses
		Gui, 6:Destroy
		If (STA_ActiveWindowID) {
			WinActivate, ahk_id %STA_ActiveWindowID%
			WinWaitActive, ahk_id %STA_ActiveWindowID%, , 0

			Loop, Parse, LOG_MailEncryptedAddresses, |
			{
				If (A_Index == STA_MailAddress) {
					TXT_SendRaw(LOG_Decrypt(A_LoopField))
					Return
				}
			}
		}
		Return
	}
	If (PRM_HotKey == "Esc") {
		Gui, 6:Destroy
		If (STA_ActiveWindowID) {
			WinActivate, ahk_id %STA_ActiveWindowID%
			WinWaitActive, ahk_id %STA_ActiveWindowID%, , 0
		}
		Return
	}

	WinGet, STA_ActiveWindowID, ID, A
	AHK_SaveIniFile()
	If (LOG_MailEncryptedAddresses != "") {
		STA_Rows := 0
		, LOC_Length := 0
		, STA_MailAddressIndex := 1
		Loop, Parse, LOG_MailEncryptedAddresses, |
		{
			LOC_Length := Max(LOC_Length, StrLen(A_LoopField) * 8.5)
			, STA_Rows++
		}
		Gui, 6:Destroy ; GUI_MailAddresses
		Gui, 6:+AlwaysOnTop -Caption -Border -Resize -ToolWindow + LastFound
		Gui, 6:Font, s10, Courier New
		Gui, 6:Add, ListBox, AltSubmit Choose%STA_MailAddressIndex% R%STA_Rows% W%LOC_Length% vSTA_MailAddress gLOG_MailAddress, % LOG_MailEncryptedAddresses
		Gui, 6:Show, % "AutoSize x" . SCR_VirtualScreenX + SCR_VirtualScreenWidth . " y" . SCR_VirtualScreenY + SCR_VirtualScreenHeight . " NoActivate", GUI_MailAddresses
		WinGetPos, , , LOC_GuiWidth, LOC_GuiHeight

		CoordMode, Caret, Screen
		If (A_CaretX != 4
			&& A_CaretY != 0) {
			LOC_GuiX := A_CaretX + STA_Delta
			LOC_GuiY := A_CaretY + 20
			If (LOC_GuiX + LOC_GuiWidth > SCR_VirtualScreenX + SCR_VirtualScreenWidth) {
				LOC_GuiX := SCR_VirtualScreenX + SCR_VirtualScreenWidth - LOC_GuiWidth
			}
			If (LOC_GuiY + LOC_GuiHeight > SCR_VirtualScreenY + SCR_VirtualScreenHeight) {
				LOC_GuiY := A_CaretY - LOC_GuiHeight - STA_Delta
			}
		} Else {
			ControlGetFocus, LOC_FocusedControl, ahk_id %STA_ActiveWindowID%
			If (LOC_FocusedControl) {
				WinGetPos, LOC_WindowX, LOC_WindowY, , , ahk_id %STA_ActiveWindowID%
				ControlGetPos, LOC_ControlX, LOC_ControlY, LOC_ControlWidth, LOC_ControlHeight, %LOC_FocusedControl%, ahk_id %STA_ActiveWindowID%
				If (LOC_ControlWidth
					&& LOC_ControlHeight) {
					LOC_ControlX += 0
					, LOC_ControlY += 0
					If (LOC_WindowX + LOC_ControlX + LOC_GuiWidth > SCR_VirtualScreenX + SCR_VirtualScreenWidth) {
						LOC_GuiX := SCR_VirtualScreenX + SCR_VirtualScreenWidth - LOC_GuiWidth
					} Else {
						LOC_GuiX := LOC_WindowX + LOC_ControlX
					}
					If (LOC_WindowY + LOC_ControlY + LOC_ControlHeight + LOC_GuiHeight + STA_Delta > SCR_VirtualScreenY + SCR_VirtualScreenHeight) {
						LOC_GuiY := LOC_WindowY + LOC_ControlY - LOC_GuiHeight - STA_Delta
						If (LOC_GuiY < SCR_VirtualScreenY) {
							LOC_GuiX := LOC_GuiY := "Center"
						}
					} Else {
						LOC_GuiY := LOC_WindowY + LOC_ControlY + LOC_ControlHeight + STA_Delta
					}
				} Else {
					LOC_GuiX := LOC_GuiY := "Center"
				}
			} Else {
				LOC_GuiX := LOC_GuiY := "Center"
			}
		}
		If (LOC_GuiX == ""
			|| LOC_GuiY == "") {
			LOC_GuiX := LOC_GuiY := "Center"
		}
		Gui, 6:Show, x%LOC_GuiX% y%LOC_GuiY%, GUI_MailAddresses
	} Else {
		Gui, 6:Destroy
		MsgBox, , No Mail Address Found - %AHK_ScriptInfo%, No mail address was found in the configuration file :`n%AHK_IniFile%`n`nFill your mail addresses`, separated by pipe ( | ) character.
		If (STA_ActiveWindowID) {
			WinActivate, ahk_id %STA_ActiveWindowID%
			WinWaitActive, ahk_id %STA_ActiveWindowID%, , 0
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

6GuiClose:
6GuiEscape:
6GuiEscape()
Return

6GuiEscape() {
	LOG_MailEncryptedAddressesManager(PRM_HotKey := "Esc")
}

#IfWinActive GUI_MailAddresses ahk_class AutoHotkeyGUI
Up::
Down::
Enter::
PgUp::
PgDn::
LOG_MailEncryptedAddressesKeyboardMove()
Return

LOG_MailEncryptedAddressesKeyboardMove() {
	LOG_MailEncryptedAddressesManager(PRM_HotKey := A_ThisHotkey)
}

#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_MailEncryptedAddressesPeriodicTimer() {
	IfWinExist, GUI_MailAddresses ahk_class AutoHotkeyGUI
	{
		IfWinNotActive
		{
			Gui, 6:Destroy ; GUI_MailAddresses
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_MailAddress:
LOG_MailAddress()
Return

LOG_MailAddress() {
	LOG_MailEncryptedAddressesManager(PRM_HotKey := (A_GuiEvent == "DoubleClick" ? "Enter" : "Select"), PRM_SelectedIndex := A_EventInfo)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Bank Account { Ctrl + Win + B } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_TrayMenuBankAccount:
If (WIN_FocusLastWindow()) {
	LOG_BankEncryptedAccount()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^#b::
AHK_KeyWait("#")
LOG_BankEncryptedAccount()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_BankEncryptedAccount() {
	Global LOG_BankEncryptedAccount, AHK_IniFile
	IniRead, LOG_BankEncryptedAccount, %AHK_IniFile%, Text, BankEncryptedAccount, %A_Space%
	LOG_FieldsManager(PRM_Title := "Enregistement du compte en banque", PRM_Text := "Numéro de compte en &banque", PRM_TextWidth := 0, PRM_VariableNames := "LOG_BankEncryptedAccount", PRM_VariableWidth := 180)
	If (LOG_BankEncryptedAccount) {
		TXT_SendRaw(LOG_Decrypt(LOG_BankEncryptedAccount))
		SendInput, {Tab}
	}
	IniWrite, %LOG_BankEncryptedAccount%, %AHK_IniFile%, Text, BankEncryptedAccount
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Bank Pro Account { Alt + Win + B } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_TrayMenuBankProAccount:
If (WIN_FocusLastWindow()) {
	LOG_BankEncryptedProAccount()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!#b::
AHK_KeyWait("#")
LOG_BankEncryptedProAccount()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_BankEncryptedProAccount() {
	Global LOG_BankEncryptedProAccount, AHK_IniFile
	IniRead, LOG_BankEncryptedProAccount, %AHK_IniFile%, Text, BankEncryptedProAccount, %A_Space%
	LOG_FieldsManager(PRM_Title := "Enregistement du compte en banque pro", PRM_Text := "Numéro de compte en &banque", PRM_TextWidth := 0, PRM_VariableNames := "LOG_BankEncryptedProAccount", PRM_VariableWidth := 180)
	If (LOG_BankEncryptedProAccount) {
		TXT_SendRaw(LOG_Decrypt(LOG_BankEncryptedProAccount))
		SendInput, {Tab}
	}
	IniWrite, %LOG_BankEncryptedProAccount%, %AHK_IniFile%, Text, BankEncryptedProAccount
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; CB number { Win + Shift + B } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_TrayMenuCB:
If (WIN_FocusLastWindow()) {
	LOG_CB()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

+#b::
AHK_KeyWait("#+")
LOG_CB()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_CB() {
	Global LOG_CBEncryptedNumber, AHK_IniFile
	IniRead, LOG_CBEncryptedNumber, %AHK_IniFile%, Text, CBEncryptedNumber, %A_Space%
	LOG_FieldsManager(PRM_Title := "Enregistrement de la Carte Bleue", PRM_Text := "Numéro de Carte &Bleue", PRM_TextWidth := 0, PRM_VariableNames := "LOG_CBEncryptedNumber", PRM_VariableWidth := 150)
	If (LOG_CBEncryptedNumber) {
		
		TXT_SendRaw(LOG_Decrypt(LOG_CBEncryptedNumber))
		SendInput, {Tab}
	}
	IniWrite, %LOG_CBEncryptedNumber%, %AHK_IniFile%, Text, CBEncryptedNumber
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Windows login { Win + Enter } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_TrayMenuWindowsLogin:
If (WIN_FocusLastWindow()) {
	LOG_WindowsLogin()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

+#Enter::
+#NumPadEnter::
AHK_KeyWait("#")
LOG_WindowsLogin()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_WindowsLogin() {

	Global LOG_DomainEncryptedPassword, AHK_IniFile
	IniRead, LOG_DomainEncryptedPassword, %AHK_IniFile%, Text, DomainEncryptedPassword, %A_Space%
	LOG_FieldsManager(PRM_Title := "Informations d'identification à Windows", PRM_Text := "&Mot de passe Windows", PRM_TextWidth := 90, PRM_VariableNames := "LOG_DomainEncryptedPassword", PRM_VariableWidth := 120)
	SendInput, ^a
	TXT_SendRaw(A_Username)
	SendInput, {Tab}
	If (LOG_DomainEncryptedPassword) {
		Sleep, 200
		SendInput, ^a
		TXT_SendRaw(LOG_Decrypt(LOG_DomainEncryptedPassword))
		SendInput, {Enter}
	}
	IniWrite, %LOG_DomainEncryptedPassword%, %AHK_IniFile%, Text, DomainEncryptedPassword
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Window domain login { Ctrl | Shift } { Win + Enter } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_TrayMenuDNSLogin:
If (WIN_FocusLastWindow()) {
	LOG_DNSLogin()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

<^+#Enter::
>^+#Enter::
<^+#NumpadEnter::
>^+#NumpadEnter::
AHK_KeyWait("#+")
LOG_DNSLogin()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_DNSLogin() {
	Global LOG_DomainName, LOG_DomainEncryptedPassword, AHK_IniFile
    If (GetKeyState("RWin", "P")) {
		KeyWait, RWin
	}
	IniRead, LOG_DomainName, %AHK_IniFile%, Text, DomainName, %A_Space%
	IniRead, LOG_DomainEncryptedPassword, %AHK_IniFile%, Text, DomainEncryptedPassword, %A_Space%
	LOG_FieldsManager(PRM_Title := "Informations d'identification au domaine", PRM_Text := "&Domaine,&Mot de passe de session", PRM_TextWidth := 90, PRM_VariableNames := "LOG_DomainName,LOG_DomainEncryptedPassword", PRM_VariableWidth := 120)
	If (LOG_DomainName) {
		SendInput, ^a
		TXT_SendRaw(LOG_DomainName . "\" . A_Username)
		SendInput, {Tab}
		If (LOG_DomainEncryptedPassword) {
			Sleep, 200
			SendInput, ^a
			TXT_SendRaw(LOG_Decrypt(LOG_DomainEncryptedPassword))
			SendInput, {Enter}
		}
	}
	IniWrite, %LOG_DomainName%, %AHK_IniFile%, Text, DomainName
	IniWrite, %LOG_DomainEncryptedPassword%, %AHK_IniFile%, Text, DomainEncryptedPassword
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Local password { [ Ctrl + ] Win + Enter } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_TrayMenuPassword:
LOG_TrayMenuPassword()
Return

LOG_TrayMenuPassword() {
	If (WIN_FocusLastWindow()) {
		LOG_MainEncryptedPassword(PRM_PressEnterKey := true)
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

<^#Enter::
>^#Enter::
<^#NumpadEnter::
>^#NumpadEnter::
LOG_MainEncryptedPasswordThenNoEnter()
Return

LOG_MainEncryptedPasswordThenNoEnter() {
	AHK_KeyWait("#^")
	LOG_MainEncryptedPassword(PRM_PressEnterKey := false)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#Enter::
#NumpadEnter::
LOG_MainEncryptedPasswordThenEnter()
Return

LOG_MainEncryptedPasswordThenEnter() {
	AHK_KeyWait("#^+")
	LOG_MainEncryptedPassword(PRM_PressEnterKey := true)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_MainEncryptedPassword(PRM_PressEnterKey = true) {
	Global LOG_MainEncryptedPassword, AHK_IniFile
    If (GetKeyState("RWin", "P")) {
		KeyWait, RWin
	}
	IniRead, LOG_MainEncryptedPassword, %AHK_IniFile%, Text, MainEncryptedPassword, %A_Space%
	LOG_FieldsManager(PRM_Title := "Identification locale", PRM_Text := "Mot de &passe local", PRM_TextWidth := 0, PRM_VariableNames := "LOG_MainEncryptedPassword", PRM_VariableWidth := 150)
	If (LOG_MainEncryptedPassword) {
		SendInput, ^a
		TXT_SendRaw(LOG_Decrypt(LOG_MainEncryptedPassword))
		If (PRM_PressEnterKey) {
			SendInput, {Enter}
		}
	}
	IniWrite, %LOG_MainEncryptedPassword%, %AHK_IniFile%, Text, MainEncryptedPassword
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Encryption :
;;;;;;;;;;;;;;

/*
###############################################
Encrypt() - Password protected Text Encryption
by Avi Aryan
v 0.6
#############################
FEATURES
* SAME KEY (PASSWORD) FOR ENCRYPTION AND DECRYPTION
* ENCRYPTED STRING IS POWERFUL BUT OF SAME SIZE AS STRING
* PASSWORDS CAN BE CASE-SENSITIVE AND ALPHA NUMERIC THUS SECURE AND EASY TO REMEMBER
* STRING'S CASE IS CONSERVED THROUGH THE PROCESS
NOTES
* Max Pass Length = 30 characters
PLEASE SEE
* Requires Scientific Maths lib
* The Crypt algorithm changes with version. So, the function stores version number in the encrypted text (from v0.3) and notifies you when you are using a
older/newer version for decryption.
Version History - https://github.com/avi-aryan/Avis-Autohotkey-Repo/commits/master/Functions/Encrypt.ahk

msgbox,% var1 := Encrypt("AutoHotkey_l", "lexikos")
msgbox,% Decrypt(var1, "lexIkos") ;<--- Password problem. I is capital in lexikos
msgbox,% Decrypt(var1, "lexiko") ;<--- s missing and you r dead
msgbox,% Decrypt(var1, "lexikos") ;<--- Perfect password , perfect result
*/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_Encrypt(PRM_Text, PRM_Key = "") {
	AHK_Log("> LOG_Encrypt(PRM_Text = " . PRM_Text . ", PRM_Key = " . PRM_Key . ")")
	Return, PRM_Text
	Return, LOG_CryptManager(PRM_Text, PRM_Key)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_Decrypt(PRM_Text, PRM_Key = "") {
	AHK_Log("> LOG_Decrypt(PRM_Text = " . PRM_Text . ", PRM_Key = " . PRM_Key . ")")
	Return, PRM_Text
	If (Substr(PRM_Text, -1) != "06") {
		Return, false
	}
	Return, LOG_CryptManager(Substr(PRM_Text, 1, -2), PRM_Key, PRM_Mode = false)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_CryptManager(PRM_Text, PRM_Key = "", PRM_Mode = true) {
	
	Global LOG_MainEncryptedPassword
	Static STA_LocalDecryptedPassword := "polisse99", STA_FinalTimestamp := 0
	
	RegRead, STA_FinalTimestamp, HKEY_LOCAL_MACHINE, SOFTWARE\AutoHotkey, PasswordValidationLimit
	If (A_TickCount < STA_FinalTimestamp) { ; TODO : jarter ce true
		LOC_Key := (PRM_Key != "" ? PRM_Key : STA_LocalDecryptedPassword)
		, LOC_CaseSense := A_StringCaseSense
		StringCaseSense, On
		LOC_Letters := "abcdefghijklmnopqrstuvwxyz0123456789-,. @!?/:;()"	;48 . no limit here but still
		LOC_ParsedList := LOG_PassCrypt(LOC_Key, LOC_Letters, LOC_ConvIndex, LOC_CarryIndex) . "ABCDEFGHIJKLMOPQRSTUVWXYZ"
		LOC_Letters .= "ABCDEFGHIJKLMOPQRSTUVWXYZ"
		, LOC_Text := PRM_Text
		, LOC_ReturnValue := ""
		Loop
		{
			LOC_ReturnValue .= (PRM_Mode
						? LOG_CryptReplace(LOC_Letters, LOC_ParsedList, Substr(LOC_Text, 1, LOC_ConvIndex))
						: LOG_CryptReplace(LOC_ParsedList, LOC_Letters, Substr(LOC_Text, 1, LOC_ConvIndex)))
			LOC_ParsedList := Substr(LOC_ParsedList, 1 - LOC_CarryIndex) . SubStr(LOC_ParsedList, 1, -1 * LOC_CarryIndex)
			, LOC_Text := Substr(LOC_Text, LOC_ConvIndex + 1)
			If (LOC_Text == "") {
				StringCaseSense, %LOC_CaseSense%
				Return, LOC_ReturnValue . (PRM_Mode ? "06" : "")
			}
		}
	} Else {
		; TODO : saisie du mot de passe local et contrôle
		LOC_OriginalEncryptedPassword := LOG_MainEncryptedPassword
		LOG_MainEncryptedPassword := ""
		LOG_FieldsManager(PRM_Title := "Identification primaire locale", PRM_Text := "Mot de &passe local", PRM_TextWidth := 0, PRM_VariableNames := "LOG_MainEncryptedPassword", PRM_VariableWidth := 150)
		If (LOG_MainEncryptedPassword) {
			STA_LocalDecryptedPassword := LOG_MainEncryptedPassword
			LOG_MainEncryptedPassword := LOG_Encrypt(LOG_MainEncryptedPassword, LOG_MainEncryptedPassword)
			If (LOC_CurrentEncryptedPassword == LOC_OriginalEncryptedPassword) {
				STA_FinalTimestamp := A_TickCount + 30 * 60 * 1000 ; min * sec * ms
				RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, SOFTWARE\AutoHotkey, PasswordValidationLimit, %STA_FinalTimestamp%
				, LOG_CryptManager(PRM_Text, STA_LocalDecryptedPassword)
			} Else {
				STA_LocalDecryptedPassword := LOG_MainEncryptedPassword := ""
			}
		} Else {
			STA_LocalDecryptedPassword := LOG_MainEncryptedPassword := ""
			MsgBox, 4144, Identification locale - %AHK_ScriptInfo%, Mot de passe local incorrect.
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_PassCrypt(PRM_Key, PRM_Letters, ByRef PRM_ConvIndex, ByRef PRM_CarryIndex){
; Generates Random sequence from a password
	LOC_AlphaList := Substr(PRM_Letters, 1, 26)
	Loop, Parse, LOC_AlphaList
	{
		StringReplace, PRM_Key, PRM_Key, %A_Loopfield%, %A_Index%, All ; Convert to numeric format
	}
	StringUpper, LOC_AlphaList, LOC_AlphaList
	Loop, Parse, LOC_AlphaList
	{
		StringReplace, PRM_Key, PRM_Key, %A_Loopfield%, % A_Index + 26, All
	}
	PRM_ConvIndex := Substr(PRM_Key, 1, 1)
	, PRM_CarryIndex := (Substr(PRM_Key, 0) == "0"
						? 1 
						: Substr(PRM_Key, 0))
	Return, SM_uniquePMT(PRM_Letters, PRM_Key, "|")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOG_CryptReplace(PRM_BaseList, PRM_ParsedList, PRM_Text){
	LOC_Chars := "¢¤¥¦§©ª«®µ¶"
	, LOC_Text := PRM_Text
	
	Loop, Parse, LOC_Chars
	{
		If (!Instr(PRM_Text, A_LoopField)) {
			LOC_ConversionChar := A_LoopField
			Break
		}
	}
	
	Loop, Parse, PRM_BaseList
	{
		StringReplace, LOC_Text, LOC_Text, %A_LoopField%, %A_LoopField%%LOC_ConversionChar%, All
	}
	
	Loop, Parse, PRM_ParsedList
	{
		LOC_FromBaseList := Substr(PRM_BaseList, A_Index, 1)
		StringReplace, LOC_Text, LOC_Text, %LOC_FromBaseList%%LOC_ConversionChar%, %A_LoopField%, All
	}
	Return, LOC_Text
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/*
Scientific MATHS LIBRARY
by Avi Aryan
v3.43
Thanks to hd0202, smorgasbord, Uberi and sinkfaze
Special thanks to smorgasbord for the factorial function
------------------------------------------------------------------------------
DOCUMENTATION - http://avi-aryan.github.io/ahk/functions/smaths.html
Math-Functions.ahk - https://github.com/avi-aryan/Avis-Autohotkey-Repo/blob/master/Functions/Math-Functions.ahk
##############################################################################
FUNCTIONS
##############################################################################
* NOTES ARE PROVIDED WITH EACH FUNCTION IN THE FORM OF COMMENTS. EXPLORE
* SM_Solve(Expression, AHK=false) --- Solves a Mathematical expression. (with extreme capabilites)
* SM_Add(number1, number2) --- +/- massive numbers . Supports Real Nos (Everything)
* SM_Multiply(number1, number2) --- multiply two massive numbers . Supports everything
* SM_Divide(Dividend, Divisor, length) --- Divide two massive numbers . Supports everything . length is number of decimals smartly rounded.
* SM_Greater(number1, number2, trueforequal=false) --- compare two massive numbers
* SM_Prefect(number) --- convert a number to most suitable form. like ( 002 to 2 ) and ( 000.5600 to 0.56 )
* SM_fact(number) --- factorial of a number . supports large numbers
* SM_toExp(number, decimals) --- Converts a number to Scientific notation format
* SM_FromExp(sci_num) --- Converts a scientific type formatted number to a real number
* SM_Pow(number, power) --- power of a number . supports large numbers and powers
* SM_Mod(Dividend, Divisor) --- Mod() . Supports large numbers
* SM_Round(number, decimals) --- Round() . Large numbers
* SM_Floor(number) --- Floor() . large numbers
* SM_Ceil(number) --- Ceil() . large number
* SM_e(N, auto=1) --- returns e to the power N . Recommend auto=1 for speed
* SM_Number2base(N, base) --- Converts N to base 'base'
* SM_Base2Number(H, base) --- Converts H in base 'base' to a real number
* SM_UniquePmt(pattern, ID, Delimiter=",") ;gives the unique permutation possible .
################################################################################
READ
################################################################################
* Pass the numbers as strings in each of these functions. This is done to avoid number trimming due to Internal AHK Limit
* For a collection of general Math functions, see < Math-functions.ahk >
*/
;~ PRM_Key := "polisse99"
;~ PRM_Text := "Salut à toi !"
;~ LOC_ET := LOG_Encrypt(PRM_Text, PRM_Key)
;~ MsgBox, Encrypté : %LOC_ET%
;~ MsgBox, % "Décrypté : " . LOG_Decrypt(LOC_ET, PRM_Key) ; OK
;~ MsgBox, % "Décrypté : " . LOG_Decrypt(LOC_ET, PRM_Key . "zozo") ; Erreur à catcher

;msgbox % SM_Solve("%sin(1.59)% e %log(1000)%") ;is equal to sin(1.59) e log(1000) = 999.816
;msgbox % SM_Solve("4 + ( 2*( 3+(4-2)*round(2.5) ) ) + (5c2)**(4c3)")
;msgbox % "The gravity on earth is: " SM_Solve("(6.67e-11 * 5.978e24) / 6.378e6^2")
;msgbox % Sm_fact(40) ;<--try puttin one more zero here
;msgbox,% SM_Mod( SM_Pow(3,77), 79)
;msgbox,% SM_Round("124389438943894389430909430438098232323.427239238023823923984",4)
;msgbox,% SM_ToExp("328923823982398239283923.238239238923", 3)
;msgbox,% SM_Divide("43.034934034904334", "89.3467436743", 10)
;msgbox,% SM_UniquePmt("abcdefghijklmnopqrstuvwxyz0123456789",12367679898956098)
;msgbox,% SM_Mod("-22","-7")
;msgbox % SM_fromexp("6.45423e10")
;msgbox,% SM_Divide("48.45","19.45",2)
;msgbox,% SM_UniquePmt("avi,annat,koiaur,aurkoi")
;msgbox,% SM_Solve("(28*45) - (45*28)")
;msgbox,% SM_Add("1280232382372012010120325634", "-12803491201290121201212.98")
;MsgBox,% SM_Solve("23898239238923.2382398923 + 2378237238.238239 - (989939.9939 * 892398293823)")
;msgbox,% SM_ToExp("0.1004354545")
;var = sqrt(10!) - ( 2**5 + 5*8 )
;msgbox,% SM_Solve(var)
;Msgbox,% SM_Greater(18.789, 187)
;msgbox,% SM_Divide("434343455677690909087534208967834434444.5656", "8989998989898909090909009909090909090908656454520", 100)
;MsgBox,% SM_Multiply("111111111111111111111111111111111111111111.111","55555555555555555555555555555555555555555555.555")
;MsgBox,% SM_Prefect("00.002000")
;msgbox % t:=SM_Number2Base("10485761048", 2) ;base 2
;msgbox % f:=SM_Number2base("10485761048", 32) ;base 32
;msgbox % SM_Base2Number(t, 2) "`n" SM_Base2Number(f, 32)
;return
;###################################################################################################################################################################
;#Include, Maths.ahk
/*
SM_Solve(expression, ahk=false)
Solves the expression in string. SM_Solve() uses the powerful functions present in the library for processing
ahk = true will make SM_Solve() use Ahk's +-/* for processing. Will be faster
* You can use global variables in expressions . To make SM_Solve see them as global vars, surround them by %..%
* To nest expressions with brackets , you can use the obvious ( ) brackets
* You can use numbers in sci notation directly in this function . ("6.67e-11 * 4.23223e24")
* You can use ! to calulate factorial ( 48! ) ( log(1000)! )
* You can use ^ or ** to calculate power ( 2.2321^12 ) ( 4**14 )
* You can use p or c for permutation or combination
* Use %...% to use functions with e, c, p . ("4**sin(3.14) + 5c%log(100)% + %sin(1.59)%e%log(1000)% + log(1000)!")
Example
global someglobalvar := 26
msgbox,% SM_Solve("Sqrt(%someglobalvar%) * 4! * log(100) * ( 3.43e3 - 2^5 )")
*/
SM_Solve(expression, ahk=false){
	Static fchars := "e- e+ **- ** **+ ^- ^+ + - * / \" , rchars := "#< #> ^< ^> ^> ^< ^> ¢ ¤ ¥ ¦ ¦"
	; Reject invalid
	If (expression == "") {
		Return
	}
	;Check Expression for invalid
	If expression is alpha
	{
		temp2 := %expression%
		Return, %temp2% ;return value of expression if it is a global variable or nothing
	}
	Else If expression is number
	{
		if (!Instr(expression, "e")) {
			Return, expression
		}
	}
	
	;Fix Expression
	StringReplace, expression, expression, %A_space%, , All
	StringReplace, expression, expression, %A_tab%, , All
	expression := SM_Fixexpression(expression)
	; Solving Brackets first
	while (b_pos := RegexMatch(expression, "i)[\+\-\*\\\/\^]\(")) {
		b_count := {"(": 1, ")": 0}
		b_temp := Substr(expression, b_pos+2)
		loop, parse, b_temp
		{
			b_count[A_LoopField] += 1
			if b_count["("] = b_count[")"]
			{
				end_pos := A_index
				break
			}
		}
		expression := Substr(expression, 1, b_pos) . SM_Solve(Substr(expression, b_pos+2, end_pos-1)) . Substr(expression, end_pos + b_pos + 2)
	}
	;Changing +,-,e-,e+ and all signs to different things
	expression := SM_FixExpression(expression) ;FIX again after solving brackets
	loop
	{
		If (!Instr(expression, "(")) {
			expression := SM_PowerReplace(expression, fchars, rchars, "All") ;power replaces replaces those characters
			reserve .= expression
			break
		}
		temp := Substr(expression, 1, Instr(expression, "(")) ;till 4+2 + sin(
		temp := SM_PowerReplace(temp, fchars, rchars, "All") ;we dont want to replace +- inside functions
		temp2 := SubStr(expression, Instr(expression, "(") + 1, Instr(expression, ")") - Instr(expression, "("))
		reserve .= temp . temp2
		expression := Substr(expression, Instr(expression, ")") + 1)
	}
	;
	expression := reserve
	; The final solving will be done now
	loop, parse, expression, ¢¤¥¦
	{
		;Check for functions --
		If (RegExMatch(A_LoopField, "iU)^[a-z0-9_]+\(.*\)$")) { ; Ungreedy ensures throwing cases like sin(45)^sin(95)
			fname := Substr(A_LoopField, 1, Instr(A_loopfield,"(") - 1) ;extract func
			ffeed := Substr(A_loopfield, Instr(A_loopfield, "(") + 1, Instr(A_loopfield, ")") - Instr(A_loopfield, "(") - 1) ;extract func feed
			loop, parse, ffeed, `,
			{
				StringReplace, feed, A_loopfield,",,All"
				feed%A_index% := SM_Solve(feed)
				, totalfeeds := A_index
			}
			if fname = SM_toExp
			{
				outExp := 1 ; now output will be in Exp , set feed1 as the number
				, number := feed1
			} else if (totalfeeds == 1) {
				number := %fname%(feed1)
			} else if (totalfeeds == 2) {
				number := %fname%(feed1, feed2)
			} else if (totalfeeds == 3) {
				number := %fname%(feed1, feed2, feed3)
			} else if (totalfeeds == 4) {
				number := %fname%(feed1, feed2, feed3, feed4) ;Add more like this if needed
			}
			function := 1
		} Else {
			number := A_LoopField
			, function := 0
		}
		;Perform the previous assignment routine
		if (char != "") {
			;The order is important here
			if (!function) {
				while match_pos := RegExMatch(number, "iU)%.*%", output_var)
					output_var := Substr(output_var, 2 , -1)
					, number := Substr(number, 1, match_pos-1) SM_Solve(Instr(output_var, "(") ? output_var : %output_var%) Substr(number, match_pos+Strlen(output_var)+2)
				if Instr(number, "#") or Instr(number, "^")
					number := SM_PowerReplace(number, "#< #> ^> ^<", "e- e ^ ^-", "All") ;replace #,^ back to e and ^
				;Symbols
				;As all use SM_Solve() , else-if is OK
				if (p := Instr(number, "c") ) or ( p := p + Instr(number, "p") ) ;permutation or combination
					term_n := Substr(number, 1, p-1) , term_r := Substr(number,p+1)
					, number := SM_Solve( term_n "!/" term_r "!" ( Instr(number, "c") ? "/(" term_n "-" term_r ")!" : "" ) )
				else if Instr(number, "^")
					number := SM_Pow( SM_Solve( SubStr(number, 1, posofpow := Instr(number, "^")-1 ) ) , SM_Solve( Substr(number, posofpow+2) ) )
				else if Instr(number, "!")
					number := SM_fact( SM_Solve( Substr(number, 1, -1) ) )
				else if Instr(number, "e") ; solve e
					number := SM_fromExp( number )
			}
			if (Ahk) {
				if char = ¢
					solved := solved + (number)
				else if char = ¤
					solved := solved - (number)
				else if char = ¦
				{
					if !number
						return
					solved := solved / (number)
				}
				else if char = ¥
					solved := solved * (number)
			} else {
				if char = ¢
					solved := SM_Add(solved, number)
				else if char = ¤
					solved := SM_Add(solved,"-" . number)
				else if char = ¦
				{
					if !number
					return
					solved := SM_Divide(solved, number)
				}
				else if char = ¥
					solved := SM_Multiply(solved, number)
			}
		}
		if solved =
			solved := number
		char := Substr(expression, Strlen(A_loopfield) + 1, 1)
		expression := Substr(expression, Strlen(A_LoopField) + 2) ;Everything except number and char
	}
	return, outExp ? SM_ToExp( solved ) : SM_Prefect( solved )
}
;###############################################################################################################################
/*
SM_Add(number1, number2, prefect=true)
Adds or subtracts 2 numbers
To subtract A and B , do like SM_Add(A, "-" B) i.e. append a minus
*/
SM_Add(number1, number2, prefect=true){ ;Dont set Prefect false, Just forget about it.
;Processing
	IfInString,number2,--
		count := 2
	else IfInString,number2,-
		count := 1
	else
		count := 0
	IfInString,number1,-
		count+=1

	n1 := number1
	n2 := number2
	StringReplace, number1, number1, -, , All
	StringReplace, number2, number2, -, , All
	;Decimals
	dec1 := Instr(number1,".") ? StrLen(number1) - InStr(number1, ".") : 0
	dec2 := Instr(number2,".") ? StrLen(number2) - InStr(number2, ".") : 0
	if (dec1 > dec2){
		dec := dec1
		loop,% (dec1 - dec2)
			number2 .= "0"
	} else if (dec2 > dec1){
		dec := dec2
		loop,% (dec2 - dec1)
			number1 .= "0"
	} else
		dec := dec1
	StringReplace, number1, number1, .
	StringReplace, number2, number2, .
	;Processing
	;Add zeros
	if (Strlen(number1) >= StrLen(number2)) {
		loop,% (Strlen(number1) - strlen(number2))
			number2 := "0" . number2
	}
	else
		loop,% (Strlen(number2) - strlen(number1))
			number1 := "0" . number1
	n := strlen(number1)
	;
	if count not in 1,3	;Add
	{
		loop,
		{
			digit := SubStr(number1,1 - A_Index, 1) + SubStr(number2, 1 - A_index, 1) + (carry ? 1 : 0)
			if (A_index == n) {
				sum := digit . sum
				break
			}
			if (digit > 9){
				carry := true
				digit := SubStr(digit, 0, 1)
			}
			else
				carry := false
			sum := digit . sum
		}
		;Giving sign
		if (Instr(n2,"-") and Instr(n1, "-"))
			sum := "-" . sum
	}else { ;SUBTRACT ******************
	;Compare numbers for suitable order
	numbercompare := SM_Greater(number1, number2, true)
	if !(numbercompare) {
		mid := number2
		number2 := number1
		number1 := mid
	}
	loop
	{
		digit := SubStr(number1, 1 - A_Index, 1) - SubStr(number2, 1 - A_index, 1) + (borrow ? -1 : 0)
		if (A_index == n){
			StringReplace, digit, digit, -
			sum := digit . sum
			break
		}
		if Instr(digit, "-")
			borrow:= true , digit := 10 + digit	;4 - 6 , then 14 - 6 = 10 + (-2) = 8
		else
			borrow := false
		sum := digit sum
	}
	;End of loop ;Giving Sign
	;
	If InStr(n2,"--"){
		if (numbercompare)
			sum := "-" . sum
	}else If InStr(n2,"-"){
		if !(numbercompare)
			sum := "-" . sum
	}else IfInString,n1,-
		if (numbercompare)
			sum := "-" . sum
	}
	;End of Subtract - Sum
	;End
	if ((sum == "-")) ;Ltrim(sum, "0") == ""
		sum := 0
	;Including Decimal
	If (dec && sum)
			sum := SubStr(sum,1,StrLen(sum) - dec) . "." . SubStr(sum,1 - dec)
	;Prefect
	Return, Prefect ? SM_Prefect(sum) : sum
}
;###################################################################################################################
/*
SM_Multiply(number1, number2)
Multiplies any two numbers
*/
SM_Multiply(number1, number2){
	;Getting Sign
	positive := true
	if Instr(number2, "-")
		positive := false
	if Instr(number1, "-")
		positive := !positive
	number1 := Substr(number1, Instr(number1, "-") ? 2 : 1)
	, number2 := Substr(number2, Instr(number2, "-") ? 2 : 1)
	; Removing Dot
	dec := InStr(number1,".") ? StrLen(number1) - InStr(number1, ".") : 0
	If n2dotpos := Instr(number2, ".")
		dec := dec + StrLen(number2) - n2dotpos
	StringReplace,number1,number1,.
	StringReplace,number2,number2,.
	; Multiplying
	loop,% Strlen(number2)
		number2temp .= Substr(number2, 1-A_Index, 1)
	number2 := number2temp
	;Reversing for suitable order
	product := "0"
	Loop,parse,number2
	{
		;Getting Individual letters
		row := "0"
		zeros := ""
		if (A_loopfield)
			loop,% (A_loopfield)
				row := SM_Add(row, number1, 0)
		else
			loop,% (Strlen(number1) - 1) ;one zero is already 5 lines above
				row .= "0"
		loop,% (A_index - 1) ;add suitable zeroes to end
			zeros .= "0"
		row .= zeros
		product := SM_Add(product, row, false)
	}
	;Give Dots
	if (dec){
		product := SubStr(product,1,StrLen(product) - dec) . "." . SubStr(product,1 - dec)
		product := SM_Prefect(product)
	}
	;Give sign
	if !(positive)
		product := "-" . product
	return, product
}
;######################################################################################################################################
/*
SM_Divide(number1, number2, length=10)
Divide any two numbers
length = defines the number of decimal places in the result
*/
SM_Divide(number1, number2, length=10){
	;Getting Sign
	positive := true
	if (Instr(number2, "-"))
	positive := false
	if (Instr(number1, "-"))
	positive := !positive
	StringReplace,number1,number1,-
	StringReplace,number2,number2,-
	;Perfect them
	number1 := SM_Prefect(number1) , number2 := SM_Prefect(number2)
	;Cases
	;if !number1 && !number2
	; return 1
	if !number2 ; return blank if denom is 0
	return
	;Remove Decimals
	dec := 0
	if Instr(number1, ".")
	dec := - (Strlen(number1) - Instr(number1, ".")) ;-ve as when the num is multiplied by 10, 10 is divided
	if Instr(number2, ".")
	dec := Strlen(number2) - Instr(number2, ".") + dec + 0
	StringReplace,number1,number1,.
	StringReplace,number2,number2,.
	number1 := Ltrim(number1, "0") , number2 := Ltrim(number2, "0")
	decimal := dec , num1 := number1 , num2 := number2 ;These wiil be used to handle point insertion
	n1 := Strlen(number1) , n2 := StrLen(number2) ;Stroring n1 & n2 as they will be used heavily below
	;Widen number1
	loop,% n2 + length
	number1 .= "0"
	coveredlength := 0 , dec := dec - n2 - length , takeone := false , n1f := n1 + n2 + length
	;Start
	while(number1 != "")
	{
	times := 0 , below := "" , lendivide := 0 , n1fromleft := (takeone) ? Substr(number1, 1, n2+1) : Substr(number1, 1, n2)
	if SM_Greater(n1fromleft, number2, true)
	{
	todivide := n1fromleft
	loop, 10
	{
	num2temp%A_index% := SM_Multiply(number2, A_index)
	if !(SM_Greater(todivide, num2temp%A_index%, true)){
	lendivide := (takeone) ? n2 + 1 : n2
	times := A_index - 1 , below := num2temp%times%
	break
	}
	}
	res .= zeroes_r
	}
	else
	{
	todivide := SubStr(number1, 1, n2+1) ; :-P (takeone) will not be needed here
	loop, 10
	{
		num2temp%A_index% := SM_Multiply(number2, A_index)
		if !(SM_Greater(todivide, num2temp%A_index%, true)){
			lendivide := n2 + 1
			times := A_index - 1 , below := num2temp%times%
			break
		}
	}
	if (coveredlength != 0)
		res .= zeroes_r "0"
	}
	res .= times , coveredlength+=(lendivide - Strlen(remainder)) ;length of previous remainder will add to number1 and so is not counted
	remainder := SM_Add(todivide, "-" below)
	if remainder = 0
		remainder := ""
	number1 := remainder . Substr(number1, lendivide + 1)
	if SM_Greater("0", remainder, true)
	{
		zeroes_k := ""
		loop,% Strlen(number1)
			zeroes_k .= "0"
		if (number1 == zeroes_k){
			StringTrimRight,number1,number1,1
			number1 := "1" . number1
			res := SM_Multiply(res, number1)
			break
		}
	}
	if times = 0
	break
	zeroes_r := "" , takeone := false
	if (remainder == "") {
		loop,
		if (Instr(number1, "0") == 1)
		zeroes_r .= "0" , number1 := Substr(number1, 2) , coveredlength+=1
		else
		break
	}
	if (Strlen(remainder) == n2)
		takeone := true
	else
		loop,% n2 - StrLen(remainder) - 1
		zeroes_r .= "0"
	}
	;Putting Decimal points"
	if (dec < 0)
	{
		oldformat := A_formatfloat
		SetFormat,float,0.16e
		Divi := Substr(num1,1,15) / Substr(num2,1,15) ; answer in decimals
		, decimal := decimal + Strlen(Substr(num1,16)) - Strlen(Substr(num2,16))
		if (Instr(divi,"-"))
			decimal := decimal - Substr(divi,-1) + 1
		else
			decimal := decimal + Substr(divi,-1) + 1
		if (decimal > 0)
			res := Substr(res, 1, decimal) . "." . Substr(res, decimal + 1)
		else if (decimal < 0){
			loop,% Abs(decimal)
				zeroes_e .= "0"
			res := "0." zeroes_e res
		}
		else
			res := "0." res
		SetFormat,float,%oldformat%
	}
	else
	{
		num := "1"
		loop,% dec
			num .= "0"
		res := SM_Multiply(SM_Prefect(res), num)
	}
	return, ( (positive) ? "" : "-" ) . SM_Round(SM_Prefect(res), decimal < 0 ? Abs(decimal)+length : length)
}
;##########################################################################################################################################
/*
SM_UniquePmt(series, ID="", Delimiter=",")
Powerful Permutation explorer function that uses an unique algorithm made by the author to give a unique sequence linked to a number.
For example, the word "abc" has 6 permutations . So, SM_UniquePmt("abc", 1) gives a different sequence, ("abc", 2) a different till ("abc", 6)
As the function is powered by the the specialist Mod, Division and Multiply functions, it can handle series larger series too.
Examples --
msgbox,% SM_UniquePmt("abcd") ;leaving ID = "" gives all permutations
msgbox,% SM_UniquePmt("abcdefghijklmnopqrstuvwxyz123456789", 23322323323) ;<----- That's called huge numbers
*/
SM_UniquePmt(series, ID="", Delimiter=","){
if Instr(series, Delimiter)
loop, parse, series,%Delimiter%
item%A_index% := A_LoopField , last := lastbk := A_Index
else{
loop, parse, series
item%A_index% := A_loopfield
last := lastbk := Strlen(series) , Delimiter := ""
}
if (ID == "") ;Return all possible permutations
{
fact := SM_fact(last)
loop,% fact
toreturn .= SM_UniquePmt(series, A_index) . "`n"
return, Rtrim(toreturn, "`n")
}
posfactor := (SM_Mod(ID, last) == "0") ? last : SM_Mod(ID, last)
incfactor := (SM_Mod(ID, last) == "0") ? SM_Floor(SM_Divide(ID,last)) : SM_Floor(SM_Divide(ID,last)) + 1
loop,% last
{
tempmod := SM_Mod(posfactor + incfactor - 1, last) ;should be faster
posfactor := (tempmod == "0") ? last : tempmod ;Extraction point
res .= item%posfactor% . Delimiter , item%posfactor% := ""
loop,% lastbk
if (item%A_index% == "")
plus1 := A_index + 1 , item%A_index% := item%plus1% , item%plus1% := ""
last-=1
if (posfactor > last)
posfactor := 1
}
return, Rtrim(res, Delimiter)
}
;####################################################################################################################################
/*
SM_Greater(number1, number2, trueforqual=false)
Evaluates to true if number1 > number2
If the "trueforequal" param is true , the function will also evaluate to true if number1 = number2
*/
SM_Greater(number1, number2, trueforequal=false){
IfInString,number2,-
IfNotInString,number1,-
return, true
IfInString,number1,-
IfNotInString,number2,-
return, false
if (Instr(number1, "-") and Instr(number2, "-"))
bothminus := true
number1 := SM_Prefect(number1) , number2 := SM_Prefect(number2)
; Manage Decimals
dec1 := (Instr(number1,".")) ? ( StrLen(number1) - InStr(number1, ".") ) : (0)
dec2 := (Instr(number2,".")) ? ( StrLen(number2) - InStr(number2, ".") ) : (0)
if (dec1 > dec2)
loop,% (dec1 - dec2)
number2 .= "0"
else if (dec2 > dec1)
loop,% (dec2 - dec1)
number1 .= "0"
StringReplace,number1,number1,.
StringReplace,number2,number2,.
; Compare Lengths
if (Strlen(number1) > Strlen(number2))
return,% (bothminus) ? (false) : (true)
else if (Strlen(number2) > Strlen(number1))
return,% (bothminus) ? (true) : (false)
else	;The final way out
{
stop := StrLen(number1)
loop,
{
if (SubStr(number1,A_Index, 1) > Substr(number2,A_index, 1))
return bothminus ? 0 : 1
else if (Substr(number2,A_index, 1) > SubStr(number1,A_Index, 1))
return bothminus ? 1 : 0
if (a_index == stop)
return, (trueforequal) ? 1 : 0
}
}
}
;#########################################################################################################################################
/*
SM_Prefect(number)
Converts any number to Perfect form i.e removes extra zeroes and adds reqd. ones. eg > SM_Prefect(000343453.4354500000)
*/
SM_Prefect(number){
number .= ""	;convert to string if needed
number := RTrim(number, "+-")
if number=
return 0
if Instr(number, "-")
number := Substr(number, 2) , negative := true
if Instr(number, "."){
number := Trim(number, "0")
if (Substr(number,1,1) == ".") ;if num like .6767
number := "0" number
if (Substr(number, 0) == ".") ;like 456.
number := Substr(number, 1, -1)
return,% (negative) ? ("-" . number) : (number)
} ; Non-decimal below
else
{
if Trim(number, "0")
return negative ? ("-" . Ltrim(number, "0")) : (Ltrim(number, "0"))
else
return 0
}
}
;###########################################################################################################################################
/*
SM_Mod(dividend, divisor)
Gives remanider when dividend is divided by divisor
*/
SM_Mod(dividend, divisor){
;Signs
positive := true
if Instr(divisor, "-")
positive := false
if (Instr(dividend, "-"))
positive := !positive
dividend := Substr(dividend, Instr(dividend, "-") ? 2 : 1) , divisor := Substr(divisor, Instr(divisor, "-") ? 2 : 1) , Remainder := dividend
;Calculate no of occurances
if SM_Greater(dividend, divisor, true){
div := SM_Divide(dividend, divisor)
div := Instr(div, ".") ? SubStr(div, 1, Instr(div, ".") - 1) : 0
if ( div == "0" )
Remainder := 0
else
Remainder := SM_Add(dividend, "-" SM_Multiply(Divisor, div))
}
return, ( (Positive or Remainder=0) ? "" : "-" ) . Remainder
}
;############################################################################################################################################
/*
SM_ToExp(number, decimals="") // SM_Exp
Gives exponential form of representing a number.
If decimals param is omitted , it is automatically detected.
? SM_Exp was the function's name in old versions and so a dummy function has been created
*/
SM_Exp(number, decimals=""){
return SM_ToExp(number, decimals)
}
SM_ToExp(number, decimals=""){
if (dec_pos := Instr(number, "."))
{
number := SM_Prefect(number) , number := Substr(number, Instr(number, "0")=1 ? 2 : 1)
Loop, parse, number
{
if A_loopfield > 0
break
tempnum .= A_LoopField
}
number := Substr(number, Strlen(tempnum)+1) , power := dec_pos-Strlen(tempnum)-2
number2 := Substr(number, 2)
StringReplace,number2,number2,.
number := Substr(number, 1, 1) "." number2
decimals := ( decimals="" or decimals>Strlen(number2) ) ? Strlen(number2) : decimals
return SM_Round(number, decimals) "e" power
}
else
{
number := SM_Prefect(number) , decimals := ( decimals="" or decimals>Strlen(Substr(number,2)) ) ? Strlen(Substr(number,2)) : decimals
return SM_Round( Substr(number, 1, 1) "." Substr(number, 2), decimals ) "e" Strlen(number)-1
}
}
/*
SM_FromExp(expnum)
Converts exponential form to number
*/
SM_FromExp(expnum){
if !Instr(expnum, "e")
return expnum
n1 := Substr(expnum, 1, t := Instr(expnum, "e")-1) , n2 := Substr(expnum, t+2)
return SM_ShiftDecimal(n1, n2)
}
;#######################################################################################################################################
/*
SM_Round(number, decimals)
Rounds a infinitely sized number to given number of decimals
*/
SM_Round(number, decimals){
if Instr(number,".")
{
nofdecimals := StrLen(number) - ( Instr(number, ".") = 0 ? Strlen(number) : Instr(number, ".") )
if (nofdecimals > decimals)
{
secdigit := Substr(number, Instr(number,".")+decimals+1, 1)
if secdigit >= 5
loop,% decimals-1
zeroes .= "0"
number := SM_Add(Substr(number, 1, Instr(number, ".")+decimals), (secdigit >= 5) ? "0." zeroes "1" : "0")
}
else
{
loop,% decimals - nofdecimals
zeroes .= "0"
number .= zeroes
}
return, Rtrim(number, ".")
}
else
return, number
}
;###################################################################################################################################################
/*
SM_Floor(number)
Floor function with extended support. Refer to Ahk documentation for Floor()
*/
SM_Floor(number){
number := SM_Prefect(number)
if Instr(number, "-")
if Instr(number,".")
return, SM_Add(Substr(number, 1, Instr(number, ".") - 1), -1)
else
return, number
else
return, Instr(number, ".") ? Substr(number, 1, Instr(number, ".") - 1) : number
}
;##################################################################################################################################################
/*
SM_Ceil(number)
Ceil function with extended support. Refer to Ahk documentation for Ceil()
*/
SM_Ceil(number){
number := SM_Prefect(number)
if Instr(number, "-")
{
if Instr(number,".")
return, Substr(number, 1, Instr(number, ".") - 1)
else
return, number
}
else
return, Instr(number, ".") ? SM_Add( Substr(number, 1, Instr(number, ".") - 1), 1) : number
}
;#################################################################################################################################################
/*
SM_fact(number)
Gives factorial of number of any size. Try SM_fact(200) :-;
;--- Edit
Now SM_Fact() uses smorgasboard method for faster results
http://ahkscript.org/boards/viewtopic.php?f=22&t=176&p=4786#p4781
*/
SM_fact(N){
res := 1 , k := 1 , carry := 0
N -= 1
loop % N
{
StringSplit, l_times, res
index := l_times0
k := A_index + 1
Loop %index%
{
digit := k * l_times%index% + carry
if ( digit > 9 )
{
carry := RegExReplace(digit, "(.*)(\d)", "$1")
digit := RegExReplace(digit, "(.*)(\d)", "$2")
}
else
carry := 0
r := digit r
index --
}
if ( carry != 0 )
final := carry r
else
final := r
res := final
digit := index := final := r =
r := ""
carry := 0
}
return final ? final : 1
}
/*
SM_Pow(number, power)
Gives the power of a number . Uses SM_Multiply() for the purpose
*/
SM_Pow(number, power){
if (power < 1)
{
if !power ;0
return 1
if power Between -1 and 1
return number ** power
power := -power , I := Floor(power) , D := Mod(power, 1)
if Instr(number, "-") && D ;if number is - and power is - in decimals , it doesnt exist ... -4 ** -2.5
return
D_part := number ** D ;The power of decimal part
I_part := SM_Pow(number, I) ;Now I will always be >=1 . So it will fall in the below else part
return SM_Prefect( SM_Divide(1, SM_Multiply(I_part, D_part)) )
}
else
{
if power > 6
{
sqrt_c := Floor(Sqrt(power))
x_c := SM_Iterate(number, sqrt_c) , loopc := Floor(power/sqrt_c)
x_c_loop := SM_iterate(x_c, loopc) , remPow := power - (sqrt_c*loopc)
x_remPow := SM_iterate(number, remPow)
return SM_Multiply(x_c_loop, x_remPow)
}
else x_7_pow7 := 1
a := 1
loop % Mod(power, 7)
a := SM_Multiply(number, a)
return SM_Multiply(x_7_pow7, a)
}
}
/*
SM_e(N, auto=1)
Gives the power of e to N
auto = 1 enables smart rounding for faster results
Call auto as false (0) for totally accurate results. (may be slow)
*/
SM_e(N, auto=1){
static e := 2.71828182845905 , d := 14 ;rendering precise results with speed .
if (N > 5) and auto
e := SM_Round("2.71828182845905", (F := d-N+5)>2 ? F : 2)
return SM_Pow(e, N)
}
/*
SM_ base Conversion functions
via Base to Number and Number to Base conversion
Base = 16 for HexaDecimal , 2 for Binary, 8 for Octal and 10 for our own number system
*/
SM_Number2Base(N, base=16){
baseLen:=base<10 ? SM_Ceil((10/base)*Strlen(N)) : Strlen(N)
if SM_checkformat(N) && SM_Checkformat(base**(baseLen-1)) ;check if N and base**base (used below) is compatitible
loop % baseLen
D:=Floor(N/(T:=base**(baseLen-A_index))),H.=!D?0:(D>9?Chr(D+87):D),N:=N-D*T
else
loop % baseLen
D:=SM_Floor( SM_Divide(N , T:= SM_Pow(base, baselen-A_index)) ) , H.=!D?0:(D>9?Chr(D+87):D) , N:=SM_Add( N, "-" SM_Multiply(D,T) )
return Ltrim(H,"0")
}
SM_Base2Number(H, base=16){
StringLower, H, H ;convert to lowercase for Asc to work
S:=Strlen(H),N:=0
loop,parse,H
N := SM_Add( N, SM_Multiply( (A_LoopField*1="")?Asc(A_LoopField)-87:A_LoopField , SM_Pow(base, S-A_index) ) )
return N
}
;################# NON - MATH FUNCTIONS #######################################
;################# RESERVED ###################################################
; Checks if n is within AHK range
SM_Checkformat(n){
static ahk_ct := 9223372036854775807
if n < 0
return 0
if ( ahk_ct > n+0 )
return 1
}
;Shifts the decimal point
;specify -<dec_shift> to shift in left direction
SM_ShiftDecimal(number, dec_shift=0){
if Instr(number, "-")
number := Substr(number,2) , minus := 1
dec_pos := Instr(number, ".") , numlen := StrLen(number)
loop % Abs(dec_shift) ;create zeroes
zeroes .= "0"
if !dec_pos ;add decimal to integers
number .= ".0"
number := dec_shift>0 ? number zeroes : zeroes number ;append zeroes
dec_pos := Instr(number, ".") ;get dec_pos in the new number
StringReplace, number, number, % "."
number := Substr(number, 1, dec_pos+dec_shift-1) "." Substr(number, dec_pos+dec_shift)
return ( minus ? "-" : "" ) SM_Prefect(number)
}
; powers a number n times
SM_Iterate(number, times){
x := 1
loop % times
x := SM_Multiply(x, number)
return x
}
; fast string replace
SM_PowerReplace(input, find, replace, options="All"){
StringSplit, rep, replace, % A_space
loop, parse, find, % A_Space
StringReplace, input, input, % A_LoopField, % rep%A_index%, % options
return Input
}
SM_FixExpression(expression){
expression := Rtrim(expression, "+-=*/\^")
StringReplace,expression,expression,--,+,All
StringReplace,expression,expression,-+,-,All
StringReplace,expression,expression,+-,-,All
StringReplace,expression,expression,++,+,All
;Reject invalid
if expression=
return
;if (Substr(expression, 1, 1) != "+") or (Substr(expression, 1, 1) != "-")
if Substr(expression, 1, 1) == "-"
expression := "0" expression ;make it 0 - 10
else expression := "+" expression
loop,
{
if Instr(expression, "*-"){
fromleft := Substr(expression, 1, Instr(expression, "*-"))
StringGetPos,posplus,fromleft,+,R
StringGetPos,posminus,fromleft,-,R
if (posplus > posminus)
fromleft := Substr(fromleft, 1, posplus) "-" Substr(fromleft, posplus + 2)
else
fromleft := Substr(fromleft, 1, posminus) "+" Substr(fromleft, posminus + 2)
expression := fromleft . Substr(expression, Instr(expression, "*-") + 2)
}else if Instr(expression, "/-"){
fromleft := Substr(expression, 1, Instr(expression, "/-"))
StringGetPos,posplus,fromleft,+,R
StringGetPos,posminus,fromleft,-,R
if (posplus > posminus)
fromleft := Substr(fromleft, 1, posplus) "-" Substr(fromleft, posplus + 2)
else
fromleft := Substr(fromleft, 1, posminus) "+" Substr(fromleft, posminus + 2)
expression := fromleft . Substr(expression, Instr(expression, "/-") + 2)
}else if Instr(expression, "\-"){
fromleft := Substr(expression, 1, Instr(expression, "\-"))
StringGetPos,posplus,fromleft,+,R
StringGetPos,posminus,fromleft,-,R
if (posplus > posminus)
fromleft := Substr(fromleft, 1, posplus) "-" Substr(fromleft, posplus + 2)
else
fromleft := Substr(fromleft, 1, posminus) "+" Substr(fromleft, posminus + 2)
expression := fromleft . Substr(expression, Instr(expression, "\-") + 2)
}else if Instr(expression, "x-"){
fromleft := Substr(expression, 1, Instr(expression, "x-"))
StringGetPos,posplus,fromleft,+,R
StringGetPos,posminus,fromleft,-,R
if (posplus > posminus)
fromleft := Substr(fromleft, 1, posplus) "-" Substr(fromleft, posplus + 2)
else
fromleft := Substr(fromleft, 1, posminus) "+" Substr(fromleft, posminus + 2)
expression := fromleft . Substr(expression, Instr(expression, "x-") + 2)
}else
break
}
StringReplace,expression,expression,--,+,All
StringReplace,expression,expression,-+,-,All
StringReplace,expression,expression,+-,-,All
StringReplace,expression,expression,++,+,All
return, expression
}
