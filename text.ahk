;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_Init() {
	Global TXT_TemporaryClipBoard
	TXT_ClipBoardHistoryManager(PRM_SetOperation := -2)
	, TXT_TemporaryClipBoard := false
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_GetSelectedText() {

	LOC_ClipBoard := ClipBoardAll
	AutoTrim, Off ; Retain any leading and trailing whitespace on the ClipBoard.
	LOC_Selection := TXT_SelectToClipBoard(PRM_Copy := 1)
	TXT_SetClipBoard(LOC_ClipBoard)
	AutoTrim, On
	If (LOC_Selection != "") {
		StringReplace, LOC_Selection, LOC_Selection, `r`n, `r, All  ; Using `r works better than `n in MS Word, etc.
		StringReplace, LOC_Selection, LOC_Selection, `n, `r, All
	}
	Return, LOC_Selection
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_PasteToSelection(PRM_Text) {
	StringLen, LOC_Length, PRM_Text
	SetKeyDelay, -1, -1
	TXT_SendRaw(PRM_Text)
	If (LOC_Length > 0) {
		SendInput, {Left %LOC_Length%}{Shift Down}{Right %LOC_Length%}{Shift Up}
	}
	AutoTrim, On
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Send straight raw text :
;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_SendRaw(PRM_Text = "") {

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

; lowercase { Win + F8 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_TrayMenulowercase:
If (WIN_FocusLastWindow()) {
	TXT_lowercase()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#F8::
AHK_KeyWait("#")
TXT_lowercase()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_lowercase() {
	LOC_Selection := TXT_GetSelectedText()
	If (LOC_Selection == "") {
		Return
	}
	AutoTrim, Off
	StringLower, LOC_Selection, LOC_Selection
	TXT_PasteToSelection(LOC_Selection)
	, AHK_ShowToolTip("lowercase")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; UPPERCASE { Win + Shift + F8 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_TrayMenuUPPERCASE:
If (WIN_FocusLastWindow()) {
	TXT_UPPERCASE()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

+#F8::
AHK_KeyWait("+#")
TXT_UPPERCASE()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_UPPERCASE() {
	If ((LOC_Selection := TXT_GetSelectedText()) != "") {
		AutoTrim, Off
		StringUpper, LOC_Selection, LOC_Selection
		TXT_PasteToSelection(TXT_LowerSpecialChars(LOC_Selection))
		, AHK_ShowToolTip("UPPERCASE")
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Title Case { Ctrl + Win + Shift + F8 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_TrayMenuTitleCase:
If (WIN_FocusLastWindow()) {
	TXT_TitleCase()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^+#F8::
AHK_KeyWait("^+#")
TXT_TitleCase()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_TitleCase() {
	If ((LOC_Selection := TXT_GetSelectedText()) != "") {
		AutoTrim, Off
		StringLower, LOC_Selection, LOC_Selection, T
		TXT_PasteToSelection(TXT_LowerSpecialChars(RegExReplace(RegExReplace(LOC_Selection, "'([a-zàáâãäåæçèéêëìíîïðñòóôõöùúûüýÿ])", "'$u1"), "'([MDS])([^a-zA-Z])", "'$l1$2")))
		, AHK_ShowToolTip("Title Case")
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Invert Title Case { Ctrl + Win + Alt + Shift + F8 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_TrayMenuiNVERTtITLEcASE:
If (WIN_FocusLastWindow()) {
	TXT_iNVERTtITLEcASE()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^#<!+F8::
AHK_KeyWait("#^!+")
TXT_iNVERTtITLEcASE()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_iNVERTtITLEcASE() {
	If ((LOC_Selection := TXT_GetSelectedText()) != "") {
		AutoTrim, Off
		StringLower, LOC_Selection, LOC_Selection, T
		LOC_Selection := RegExReplace(RegExReplace(LOC_Selection, "'([a-zàáâãäåæçèéêëìíîïðñòóôõöùúûüýÿ])", "'$u1"), "'([MDS])([^a-zA-Z])", "'$l1$2")
		StringLen, LOC_Length, LOC_Selection
		Loop, %LOC_Length% {
			StringLeft, LOC_Char, LOC_Selection, 1
			If (LOC_Char Is Lower) {
				StringUpper, LOC_Char, LOC_Char
			} Else If (LOC_Char Is Upper) {
				StringLower, LOC_Char, LOC_Char
			}
			StringTrimLeft, LOC_Selection, LOC_Selection, 1
			LOC_Selection .= LOC_Char
		}
		TXT_PasteToSelection(LOC_Selection)
		, AHK_ShowToolTip("iNVERTED tITLE cASE")
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Sentence case { Ctrl + Win + F8 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_TrayMenuSentencecase:
If (WIN_FocusLastWindow()) {
	TXT_Sentencecase()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^#F8::
AHK_KeyWait("#^")
TXT_Sentencecase()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_Sentencecase() {
	If ((LOC_Selection := TXT_GetSelectedText()) != "") {
		AutoTrim, Off
		StringLower, LOC_Selection, LOC_Selection
		Try {
			TXT_PasteToSelection(TXT_LowerSpecialChars(RegExReplace(LOC_Selection, "(((^|([\.!?¿]\s+))[a-z])| i | i')", "$u1")))
			, AHK_ShowToolTip("Sentence case")
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "TXT_Sentencecase")
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; iNVERT SENTENCE CASE { Ctrl + Win + Alt + F8 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_TrayMenuiNVERTSENTENCECASE:
If (WIN_FocusLastWindow()) {
	TXT_iNVERTSENTENCECASE()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^#<!F8::
AHK_KeyWait("#^!")
TXT_iNVERTSENTENCECASE()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_iNVERTSENTENCECASE() {
	If ((LOC_Selection := TXT_GetSelectedText()) != "") {
		AutoTrim, Off
		StringLower, LOC_Selection, LOC_Selection
		Try {
			LOC_Selection := RegExReplace(LOC_Selection, "(((^|([\.!?¿]\s+))[a-z])| i | i')", "$u1")
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "TXT_iNVERTSENTENCECASE")
		}
		StringLen, LOC_Length, LOC_Selection
		Loop, %LOC_Length% {
			StringLeft, LOC_Char, LOC_Selection, 1
			If (LOC_Char Is Lower) {
				StringUpper, LOC_Char, LOC_Char
			} Else If (LOC_Char Is Upper) {
				StringLower, LOC_Char, LOC_Char
			}
			StringTrimLeft, LOC_Selection, LOC_Selection, 1
			LOC_Selection .= LOC_Char
		}
		TXT_PasteToSelection(TXT_LowerSpecialChars(LOC_Selection))
		, AHK_ShowToolTip("iNVERTED SENTENCE CASE")
}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; iNVerT cASe { Win + Alt + F8 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_TrayMenuInverTCasE:
If (WIN_FocusLastWindow()) {
	TXT_InverTCasE()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#<!F8::
AHK_KeyWait("#!")
TXT_InverTCasE()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_InverTCasE() {
	If ((LOC_Selection := TXT_GetSelectedText()) != "") {
		AutoTrim, Off
		StringLen, LOC_Length, LOC_Selection
		Loop, %LOC_Length% {
			StringLeft, LOC_Char, LOC_Selection, 1
			If (LOC_Char Is Lower) {
				StringUpper, LOC_Char, LOC_Char
			} Else If (LOC_Char Is Upper) {
				StringLower, LOC_Char, LOC_Char
			}
			StringTrimLeft, LOC_Selection, LOC_Selection, 1
			LOC_Selection .= LOC_Char
		}
		TXT_PasteToSelection(TXT_LowerSpecialChars(LOC_Selection))
		, AHK_ShowToolTip("iNvErT cAsE")
}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Random Case { Win + Alt + Shift + F8 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_TrayMenurANdOmcAsE:
If (WIN_FocusLastWindow()) {
	TXT_rANdOmcAsE()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#<!+F8::
AHK_KeyWait("#!+")
TXT_rANdOmcAsE()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_rANdOmcAsE() {
	If ((LOC_Selection := TXT_GetSelectedText()) != "") {
		AutoTrim, Off
		StringLen, LOC_Length, LOC_Selection
		Loop, %LOC_Length% {
			StringLeft, LOC_Char, LOC_Selection, 1
			Random, LOC_Random, 1, 2
			If (LOC_Random == 1) {
				StringLower, LOC_Char, LOC_Char
			} Else {
				StringUpper, LOC_Char, LOC_Char
			}
			StringTrimLeft, LOC_Selection, LOC_Selection, 1
			LOC_Selection .= LOC_Char
		}
		TXT_PasteToSelection(TXT_LowerSpecialChars(LOC_Selection))
		, AHK_ShowToolTip("rANdOmcAsE")
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_LowerSpecialChars(PRM_Text) {
	StringReplace, LOC_Text, PRM_Text, ``R, ``r, All
	StringReplace, LOC_Text, LOC_Text, ``T, ``t, All
	StringReplace, LOC_Text, LOC_Text, ``V, ``v, All
	StringReplace, LOC_Text, LOC_Text, ``F, ``f, All
	Return, LOC_Text
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Disable style { Win + AltGr + F8 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_TrayMenuNoStyle:
If (WIN_FocusLastWindow()) {
	TXT_DisableStyle()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

<^>!#F8::
AHK_KeyWait("^!#")
TXT_DisableStyle()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_DisableStyle() {
	If ((LOC_Selection := TXT_GetSelectedText()) != "") {
		TXT_PasteToSelection(LOC_Selection)
		, AHK_ShowToolTip("Style disabled")
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Format punctuation { Win + AltGr + Shift + F8 } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_TrayMenuFormatPunctuation:
If (WIN_FocusLastWindow()) {
	TXT_FormatPunctuation()
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

<^>!+#F8::
AHK_KeyWait("^!+#")
TXT_FormatPunctuation()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_FormatPunctuation() {
	If ((LOC_Selection := TXT_GetSelectedText()) != "") {
		Try {
			LOC_Selection := RegExReplace(LOC_Selection, "[  \t_]+", " ") ; Reduce multiple spaces and tabulations in one space
			LOC_Selection := RegExReplace(LOC_Selection, "[\r\n]+", "`r`n") ; Reduce multiple carriage-returns in just one
			LOC_Selection := RegExReplace(LOC_Selection, "^\r\n") ; Delete starting carriage-return
			LOC_Selection := RegExReplace(LOC_Selection, "[ ]([.,])", "$1") ; Delete spaces before comma & dot
			LOC_Selection := RegExReplace(LOC_Selection, "([BbCcDdFfGgJjKkLlMmNnPpRrSsTtVvWwXxZz]) ?' ?([AaÀàÄäÂâÆæEeÉéÈèÊêËëIiÎîÏïOoÔôÖöŒœUuÙùÛûÜüYyŸÿ])", "$1'$2") ; Delete spaces around apostrophe
			LOC_Selection := RegExReplace(LOC_Selection, "[ ]$") ; Delete last space
			LOC_Selection := RegExReplace(LOC_Selection, "([^ !?¿¡:;»])([:;!?¿¡»])", "$1 $2") ; Append space before question mark, ...
			LOC_Selection := RegExReplace(LOC_Selection, "([,:;.!?¿¡«])([^ :.!?¿¡«])", "$1 $2") ; Append space after comma, dot, semi-colon, ...
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "TXT_FormatPunctuation")
		}
		StringReplace, LOC_Selection, LOC_Selection, ` `r`n, `r`n, All ; Trim line-ends
		If (LOC_Selection) {
			TXT_PasteToSelection(LOC_Selection)
		} Else {
			SendInput, {Delete}
		}
		AHK_ShowToolTip("Punctuation formatted")
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Standard copy/cut operations :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

~^c::
TXT_StandardCopy()
Return

TXT_StandardCopy() {
	If (!WinActive("ahk_class PuTTY")
		&& !WinActive("ahk_class Console_2_Main")
		&& !WinActive("ahk_class ConsoleWindowClass")) {
		TXT_StandardCopyCutManager(PRM_CopyOperation := 1, PRM_HotKeyTickCount := A_TickCount)
		SetTimer, TXT_CopyTimer, -500
	}
}

TXT_CopyTimer:
SetTimer, TXT_CopyTimer, Off
TXT_StandardCopyCutManager(1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

~^x::
TXT_StandardCut()
Return

TXT_StandardCut() {
	TXT_StandardCopyCutManager(PRM_CutOperation := -1, PRM_HotKeyTickCount := A_TickCount)
	SetTimer, TXT_CutTimer, -500
}

TXT_CutTimer:
SetTimer, TXT_CutTimer, Off
TXT_StandardCopyCutManager(-1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_StandardCopyCutManager(PRM_Operation, PRM_HotKeyTickCount = -1, PRM_ClipboardTickCount = -1) {

	; PRM_Operation == 1 : copy
	;                 -1 : cut
	;                  0 : undefined
	Global TXT_ClipBoard, ZZZ_ClipBoardInitialized, ZZZ_CopyCutTimer
	Static STA_HotKeyTickCount := -1, STA_ClipBoardTickCount := -1, STA_Operation := 1

	AHK_Log("> TXT_StandardCopyCutManager(" . PRM_Operation . ", " . PRM_HotKeyTickCount . ", " . PRM_ClipboardTickCount . ")")

	; Parsing parameters :
	;;;;;;;;;;;;;;;;;;;;;;
	If (PRM_Operation != 0) {
		STA_Operation := PRM_Operation
	}
	If (PRM_HotKeyTickCount != -1) {
		STA_HotKeyTickCount := PRM_HotKeyTickCount
		, AHK_Log("< TXT_StandardCopyCutManager(" . PRM_Operation . ", " . PRM_HotKeyTickCount . ", " . PRM_ClipboardTickCount . ") : HotKeyTickCount")
		Return
	}
	If (PRM_ClipboardTickCount != -1) {
		STA_ClipBoardTickCount := PRM_ClipboardTickCount
		, AHK_Log("< TXT_StandardCopyCutManager(" . PRM_Operation . ", " . PRM_HotKeyTickCount . ", " . PRM_ClipboardTickCount . ") : ClipboardTickCount")
		Return
	}

	; No clipboard content found :
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	If (Abs(STA_ClipBoardTickCount - STA_HotKeyTickCount) > Abs(ZZZ_CopyCutTimer)) {
		LOC_Clipboard := TXT_CaptureTextManager(PRM_AppendMode := false, PRM_ForceGUI := false)
		, AHK_Log("< TXT_StandardCopyCutManager(" . PRM_Operation . ", " . PRM_HotKeyTickCount . ", " . PRM_ClipboardTickCount . ") : NoClipboardFound")
		, STA_HotKeyTickCount := -1
		, STA_ClipBoardTickCount := -1
		Return
	}
	
	LOC_TextCaptured := false
	, STA_HotKeyTickCount := STA_ClipBoardTickCount := 0
	LOC_ClipBoardAll := ClipboardAll ; mandatory to detect ClipBoardAll content
	If (Clipboard
		|| StrLen(LOC_ClipBoardAll) > 0) {
		If (!ZZZ_ClipBoardInitialized) {
			TXT_ClipBoard := ClipBoardAll
			TXT_ClipBoardHistoryManager(PRM_SetOperation := 1)
			SetTimer, TXT_SaveAlternateClipBoard, -1
		}
		LOC_Length := StrLen(ClipBoard)
		If (LOC_Length > 0) {
			LOC_LineCount := TXT_GetFormattedNumber(TXT_GetLineCount(ClipBoard))
			, AHK_ShowToolTip("Clipboard < " . TXT_GetFormattedNumber(LOC_Length) . " char" . (LOC_Length > 1 ? "s" : "") . (LOC_LineCount > 1 ? " [" . LOC_LineCount . " lines]" : "") . (LOC_TextCaptured ? " captured" : (STA_Operation == 1 ? " copied" : (STA_Operation == -1 ? " cut" : ""))), PRM_Seconds := (LOC_Length > 999 ? 1.5 : 0.75))
		}
	}
	AHK_Log("< TXT_StandardCopyCutManager(" . PRM_Operation . ", " . PRM_HotKeyTickCount . ", " . PRM_ClipboardTickCount . ") : ClipboardCopied")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Extended copy/cut operations { Ctrl [ + Shift ] [ + Alt ] + { c | x | Insert | Delete } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_TrayMenuCopyAlternate:
If (WIN_FocusLastWindow()) {
	TXT_ExtendedCopyCutManager("^<!c")
}
Return

TXT_TrayMenuCopyPlainText:
If (WIN_FocusLastWindow()) {
	TXT_ExtendedCopyCutManager("^+c")
}
Return

TXT_TrayMenuAppendPlainText:
If (WIN_FocusLastWindow()) {
	TXT_ExtendedCopyCutManager("^+Insert")
}
Return

TXT_TrayMenuCopyPlainAlternateText:
If (WIN_FocusLastWindow()) {
	TXT_ExtendedCopyCutManager("^<!+c")
}
Return

TXT_TrayMenuAppendPlainAlternateText:
If (WIN_FocusLastWindow()) {
	TXT_ExtendedCopyCutManager("^<!+Insert")
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_TrayMenuCutAlternate:
If (WIN_FocusLastWindow()) {
	TXT_ExtendedCopyCutManager("^<!x")
}
Return

TXT_TrayMenuCutPlainText:
If (WIN_FocusLastWindow()) {
	TXT_ExtendedCopyCutManager("^+x")
}
Return

TXT_TrayMenuAppendCutPlainText:
If (WIN_FocusLastWindow()) {
	TXT_ExtendedCopyCutManager("^+Delete")
}
Return

TXT_TrayMenuCutPlainAlternateText:
If (WIN_FocusLastWindow()) {
	TXT_ExtendedCopyCutManager("^<!+x")
}
Return

TXT_TrayMenuAppendCutPlainAlternateText:
If (WIN_FocusLastWindow()) {
	TXT_ExtendedCopyCutManager("^<!+Delete")
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, MediaMonkey ahk_class TFMainWindow
~^+c::
Return
#IfWinActive, Pale Moon ahk_class MozillaWindowClass
~^+c::
Return
#IfWinActive
^+c::
^Insert::
^Delete::
^+Insert::
^+x::
^+Delete::
^<!c::
^<!Insert::
^<!x::
; ^<!Delete:: Task Manager !
^<!+c::
^<!+Insert::
^<!+x::
^<!+Delete::
TXT_ExtendedCopyCutManager(A_ThisHotKey)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_ExtendedCopyCutManager(PRM_ThisHotKey) {

	Critical, On
	Global TXT_ClipBoard, ZZZ_ClipBoardInitialized

	LOC_ClipBoardAll := ClipBoardAll
	LOC_ClipBoard := ClipBoard
	IfInString, PRM_ThisHotKey, % "Insert"
	{
		LOC_Char := "c"
		, LOC_AppendMode := true
		, LOC_PlainTextMode := true
	} Else IfInString, PRM_ThisHotKey, % "Delete"
	{
		LOC_Char := "x"
		, LOC_AppendMode := true
		, LOC_PlainTextMode := true
	} Else {
		StringRight, LOC_Char, PRM_ThisHotKey, 1
		LOC_AppendMode := false
		, LOC_PlainTextMode := InStr(PRM_ThisHotKey, "+")
	}
	LOC_Alternate := InStr(PRM_ThisHotKey, "!")

	If (StrLen(TXT_SelectToClipBoard(PRM_CopyCutOperation := (LOC_Char == "c" ? 1 : -1))) == 0) {
		If (LOC_Char == "c") {
			TXT_SetClipBoard(TXT_CaptureTextManager(PRM_AppendMode := LOC_AppendMode, PRM_ForceGUI := false))
			Return
		}
		If (!ClipBoard) {
			TXT_ClipBoard := LOC_ClipBoardAll
			TXT_ClipBoardHistoryManager(PRM_SetOperation := 1, PRM_AlternateClipBoard := LOC_Alternate, PRM_AppendMode := LOC_AppendMode)
			Critical, Off
			Return
		}
		LOC_TextCaptured := true
	} Else {
		LOC_TextCaptured := false
	}
	LOC_Length := StrLen(ClipBoard)
	, LOC_LineCount := TXT_GetFormattedNumber(TXT_GetLineCount(ClipBoard))
	, LOC_LengthIndication := TXT_GetFormattedNumber(LOC_Length) . " char" . (LOC_Length > 1 ? "s" : "") . (LOC_LineCount > 1 ? " [" . LOC_LineCount . " lines]" : "") . (LOC_Char == "c" ? (LOC_TextCaptured ? " captured" : " copied") : " cut")

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Plain text :
	If (LOC_PlainTextMode)	{
		; Trim clipboard blanks and empty strings :
		If PRM_ThisHotKey Not In ^Insert,^Delete,^<!Insert,^<!Delete
		{
			Try {
				TXT_SetClipBoard(RegExReplace(RegExReplace(RegExReplace(ClipBoard, "^[  \t\r\n]+"), "[  \t\r\n]+$"), "[  \t]*([\r\n]+)[  \t]*", "$1"))
			} Catch LOC_Exception {
				AHK_Catch(LOC_Exception, "TXT_ExtendedCopyCutManager", PRM_ThisHotKey)
				TXT_SetClipBoard(ClipBoard)
			}
			If (!ClipBoard) {
				Critical, Off
				Return
			}
		}

		; Set append separator :
		If (LOC_AppendMode) {
			LOC_ContentAlreadyMemorized := (LOC_Alternate ? TXT_ClipBoard : LOC_ClipBoard) . ""
			StringRight, LOC_Separator, LOC_ContentAlreadyMemorized, 1
			If (LOC_Separator != ""
				&& LOC_Separator != A_Space
				&& LOC_Separator != "`n"
				&& LOC_Separator != "`v"
				&& LOC_Separator != "`f"
				&& LOC_Separator != "`r"
				&& LOC_Separator != "`t") {
				TXT_SetClipBoard(" " . ClipBoard)
			}
		}

		If (LOC_Alternate) {
			If (LOC_AppendMode) {
				; Append alternate plain text (^<!Insert, ^<!Delete, ^<!+Insert and ^<!+Delete) :
				TXT_ClipBoard .= ClipBoard
			} Else {
				; Copy/cut alternate plain text (^<!+c and ^<!+x) :
				TXT_ClipBoard := ClipBoard
			}
			TXT_ClipBoardHistoryManager(PRM_SetOperation := 1, PRM_AlternateClipBoard := LOC_Alternate, PRM_AppendMode := LOC_AppendMode)
			SetTimer, TXT_SaveAlternateClipBoard, -1
			TXT_SetClipBoard(LOC_ClipBoardAll)
		} Else {
			If (LOC_AppendMode) {
				; Append plain text (^Insert, ^+Insert and ^+Delete) (^Delete reserved for erasing next word):
				TXT_SetClipBoard(LOC_ClipBoard . ClipBoard)
				If (!ZZZ_ClipBoardInitialized) {
					TXT_ClipBoard := ClipBoard
					SetTimer, TXT_SaveAlternateClipBoard, -1
				}
			} Else {
				; Copy/cut plain text (^+c and ^+x) :
				; Nothing to do : ClipBoard already initialized
			}
		}
		AHK_ShowToolTip((LOC_Alternate ? "Alternate clipboard <" : "Clipboard <") . (LOC_AppendMode ? "< " : " ") . LOC_LengthIndication, PRM_Seconds := (LOC_Length > 999 ? 1.5 : 0.75))
		Critical, Off
		Return
	}

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Binary data :
	If (LOC_Alternate) {
		; Copy/cut alternate data (^<!c, ^<!Insert ^<!x) :
		TXT_ClipBoard := ClipBoardAll
		TXT_ClipBoardHistoryManager(PRM_SetOperation := 1, PRM_AlternateClipBoard := LOC_Alternate)
		TXT_SetClipBoard(LOC_ClipBoardAll)
		SetTimer, TXT_SaveAlternateClipBoard, -1
	}
	If (LOC_Length > 0) {
		AHK_ShowToolTip((LOC_Alternate ? "Alternate clipboard" : "Clipboard") . " < " . LOC_LengthIndication, PRM_Seconds := (LOC_Length > 999 ? 1.5 : 0.75))
	}
	Critical, Off
}

TXT_SaveAlternateClipBoard:
TXT_SaveAlternateClipBoard()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Capture text { AltGr + PrintScreen } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_CaptureText:
<^>!PrintScreen::
TXT_CaptureText()
Return

TXT_CaptureText() {
	SCR_MouseAxisLockPeriodicTimer(PRM_Destroy := true)
	TXT_CaptureTextManager(PRM_AppendMode := false, PRM_ForceGUI := true)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_CaptureAppendText:
<^>!+PrintScreen::
TXT_CaptureAppendText()
Return

TXT_CaptureAppendText() {
	SCR_MouseAxisLockPeriodicTimer(PRM_Destroy := true)
	TXT_CaptureTextManager(PRM_AppendMode := true, PRM_ForceGUI := true)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_CaptureTextManager(PRM_AppendMode = -1, PRM_ForceGui = false, PRM_GuiButton = false) {

	; PRM_AppendMode : true or false (-1 by default)
	; PRM_ForceGui   : display popup if nothing captured
	; PRM_GuiButton  : event from Gui
	Global SCR_VirtualScreenWidth, SCR_VirtualScreenHeight
	Static STA_Edit1, STA_Button1, STA_Edit2, STA_Button2, STA_Edit3, STA_Button3, STA_Edit4, STA_Button4, STA_Edit5, STA_Button5, STA_Edit6, STA_Button6, STA_Edit7, STA_Button7, STA_Edit8, STA_Button8, STA_Edit9, STA_Button9, STA_Append = false

	If (PRM_AppendMode != -1) {
		STA_Append := PRM_AppendMode
	}
	If (PRM_GuiButton) {
		LOC_Key := SubStr(PRM_GuiButton, 0, 1)
		GuiControlGet, LOC_Text, , STA_Edit%LOC_Key%
		If (LOC_Text) {
			If (STA_Append) {
				StringRight, LOC_Separator, LOC_Text, 1
				If (LOC_Separator == ""
					|| LOC_Separator == A_Space
					|| LOC_Separator == "`n"
					|| LOC_Separator == "`v"
					|| LOC_Separator == "`f"
					|| LOC_Separator == "`t") {
					LOC_Separator := ""
				} Else {
					LOC_Separator := " "
				}
				TXT_SetClipBoard(Clipboard . LOC_Separator . LOC_Text)
			} Else {
				TXT_SetClipboard(LOC_Text)
			}
		}
		Gui, 29:Destroy ; Text Capture
		Return
	}

	CoordMode, Mouse, Screen
	MouseGetPos, LOC_MouseX, LOC_MouseY
	LOC_Item := TXT_GetCapturedElementItem(LOC_MouseX, LOC_MouseY)
	If (!LOC_Item.1) {
		If (PRM_ForceGui) {
			MsgBox, , Text Capture - %AHK_ScriptInfo%, No text has been captured.
		} Else {
			AHK_ShowTooltip(PRM_ToolTipText := "Clipboard <" . (PRM_AppendMode == true ? "<" : "") . " 0 char captured")
		}
		Return, ""
	}
	Gui, 29:Destroy ; Text Capture
	Gui, 29:Margin, 10, 10
	Gui, 29:+LastFound

	If (LOC_Item.2
		|| PRM_ForceGui) {
		For LOC_Key, LOC_Value In LOC_Item {
			Try {
				Gui, 29:Add, Edit, x10 w480 -Tabstop vSTA_Edit%LOC_Key%, % RegExReplace(RegExReplace(RegExReplace(LOC_Value, "^[  \t\r\n]+"), "[  \t\r\n]+$"), "[  \t]*([\r\n]+)[  \t]*", "$1")
			} Catch LOC_Exception {
				AHK_Catch(LOC_Exception, "TXT_CaptureTextManager", PRM_AppendMode, PRM_ForceGui, PRM_GuiButton)
				Gui, 29:Add, Edit, x10 w480 -Tabstop vSTA_Edit%LOC_Key%, % LOC_Value
			}
			Gui, 29:Add, Button, x+10 yp+0 vSTA_Button%LOC_Key% gTXT_CaptureToClipBoard, % (STA_Append ? "  Append  " : "  Copy  ")
		}
		
		Gui, 29:Add, StatusBar, , ` Press Esc to exit
		Gui, 29:Show, AutoSize x%SCR_VirtualScreenWidth% y%SCR_VirtualScreenHeight% NoActivate, Text Capture
 		For LOC_Key, LOC_Value In LOC_Item {
			ControlGetPos, , , , LOC_EditHeight, Edit%LOC_Key%
			ControlGetPos, , , , LOC_ButtonHeight, Button%LOC_Key%
			LOC_MaxHeight := Max(LOC_EditHeight, LOC_ButtonHeight)
			If (LOC_EditHeight < LOC_MaxHeight) {
				ControlMove, Edit%LOC_Key%, , , , LOC_MaxHeight
			}
			If (LOC_ButtonHeight < LOC_MaxHeight) {
				ControlMove, Button%LOC_Key%, , , , LOC_MaxHeight
			}
		}
		Gui, 29:Show, Center, Text Capture
		CoordMode, Mouse, Window
		ControlGetPos, LOC_CopyButtonX, LOC_CopyButtonY, LOC_CopyButtonWidth, LOC_CopyButtonHeight, Button1
		MouseMove, LOC_CopyButtonX + LOC_CopyButtonWidth // 2, LOC_CopyButtonY + LOC_CopyButtonHeight // 2
		Return, ""
	} Else {
		Try {
			Return, RegExReplace(RegExReplace(RegExReplace(LOC_Item.1, "^[  \t\r\n]+"), "[  \t\r\n]+$"), "[  \t]*([\r\n]+)[  \t]*", "$1")
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "TXT_CaptureTextManager", PRM_AppendMode, PRM_ForceGui, PRM_GuiButton)
			Return, LOC_Item.1
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_CaptureToClipBoard:
TXT_CaptureToClipBoard()
Return

TXT_CaptureToClipBoard() {
	TXT_CaptureTextManager(PRM_AppendModeUndefined := -1, PRM_ForceGUI := false, PRM_GuiButton := A_GuiControl)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

29GuiEscape: ; Text Capture
29GuiClose:
Gui, 29:Destroy
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_GetCapturedElementItem(LOC_X, LOC_Y) {

	Global ZZZ_UIAutomation
	If (!ZZZ_UIAutomation) {
		Return, false
	}
	LOC_Item := {}
	DllCall(AHK_PointerDelta(ZZZ_UIAutomation, 7), "Ptr", ZZZ_UIAutomation, "Int64", LOC_X | LOC_Y << 32, "Ptr*", LOC_Element) ;IUIAutomation::ElementFromPoint
	If (!LOC_Element) {
        Return, false
	}
	DllCall(AHK_PointerDelta(LOC_Element, 23), "Ptr", LOC_Element, "Ptr*", LOC_Name) ;IUIAutomationElement::CurrentName
	, DllCall(AHK_PointerDelta(LOC_Element, 10), "Ptr", LOC_Element, "UInt", 30045, "Ptr", TXT_GetVariableVariant(LOC_Value)) ;IUIAutomationElement::GetCurrentPropertyValue::value
	, DllCall(AHK_PointerDelta(LOC_Element, 10), "Ptr", LOC_Element, "UInt", 30092, "Ptr", TXT_GetVariableVariant(LOC_LongName)) ;IUIAutomationElement::GetCurrentPropertyValue::lname
	, DllCall(AHK_PointerDelta(LOC_Element, 10), "Ptr", LOC_Element, "UInt", 30093, "Ptr", TXT_GetVariableVariant(LOC_LongValue)) ;IUIAutomationElement::GetCurrentPropertyValue::lvalue
	, DllCall(AHK_PointerDelta(LOC_Element, 21), "Ptr", LOC_Element, "UInt*", LOC_Type) ;IUIAutomationElement::CurrentControlType

	LOC_Name := StrGet(LOC_Name, "UTF-16")
	, LOC_Value := StrGet(NumGet(LOC_Value, 8, "Ptr"), "UTF-16")
	, LOC_LongName := StrGet(NumGet(LOC_LongName, 8, "Ptr"), "UTF-16")
	, LOC_LongValue := StrGet(NumGet(LOC_LongValue, 8, "Ptr"), "UTF-16")

	If (LOC_Name) {
		LOC_Item.Insert(LOC_Name)
	}
	If (LOC_Value && AHK_NotInArray(LOC_Value, LOC_Item)) {
		LOC_Item.Insert(LOC_Value)
	}
	If (LOC_LongName && AHK_NotInArray(LOC_LongName, LOC_Item)) {
		LOC_Item.Insert(LOC_LongName)
	}
	If (LOC_LongValue && AHK_NotInArray(LOC_LongValue, LOC_Item)) {
		LOC_Item.Insert(LOC_LongValue)
	}
	If (LOC_Type == 50004) {
		LOC_ElementWhole := TXT_GetWholeCapturedElement(LOC_Element)
		If (LOC_ElementWhole && AHK_NotInArray(LOC_ElementWhole, LOC_Item)) {
			LOC_Item.Insert(LOC_ElementWhole)
		}
	}
	ObjRelease(LOC_Element)
	Return, LOC_Item
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_GetWholeCapturedElement(PRM_Element) {

	Global ZZZ_UIAutomation
	Static STA_Init := 1, STA_TrueCondition, STA_Walker
	If (STA_Init) {
		STA_Init := DllCall(AHK_PointerDelta(ZZZ_UIAutomation, 21), "Ptr", ZZZ_UIAutomation, "Ptr*", STA_TrueCondition) ;IUIAutomation::CreateTrueCondition
		, STA_Init += DllCall(AHK_PointerDelta(ZZZ_UIAutomation, 14), "Ptr", ZZZ_UIAutomation, "Ptr*", STA_Walker) ;IUIAutomation::ControlViewWalker
	}
	DllCall(AHK_PointerDelta(ZZZ_UIAutomation, 5), "Ptr", ZZZ_UIAutomation, "Ptr*", LOC_Root) ;IUIAutomation::GetRootElement
	DllCall(AHK_PointerDelta(ZZZ_UIAutomation, 3), "Ptr", ZZZ_UIAutomation, "Ptr", PRM_Element, "Ptr", LOC_Root, "Int*", LOC_Same) ;IUIAutomation::CompareElements
	ObjRelease(LOC_Root)
	If (LOC_Same) {
		Return, false
	}

	DllCall(AHK_PointerDelta(STA_Walker, 3), "Ptr", STA_Walker, "Ptr", PRM_Element, "Ptr*", LOC_Parent) ;IUIAutomationTreeWalker::GetParentElement
	If (LOC_Parent) {
		LOC_ElementWhole := ""
		DllCall(AHK_PointerDelta(LOC_Parent, 6), "Ptr", LOC_Parent, "UInt", 2, "Ptr", STA_TrueCondition, "Ptr*", LOC_Array) ;IUIAutomationElement::FindAll
		, DllCall(AHK_PointerDelta(LOC_Array, 3), "Ptr", LOC_Array, "Int*", LOC_Length) ;IUIAutomationElementArray::Length
		Loop, %LOC_Length% {
			DllCall(AHK_PointerDelta(LOC_Array, 4), "Ptr", LOC_Array, "Int", A_Index - 1, "Ptr*", LOC_NewElement) ;IUIAutomationElementArray::GetElement
			DllCall(AHK_PointerDelta(LOC_NewElement, 23), "Ptr", LOC_NewElement, "Ptr*", LOC_Name) ;IUIAutomationElement::CurrentName
			LOC_ElementWhole .= StrGet(LOC_Name, "UTF-16")
			, ObjRelease(LOC_NewElement)
		}
        ObjRelease(LOC_Array)
		, ObjRelease(LOC_Parent)
		Return, LOC_ElementWhole
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_GetVariableVariant(ByRef PRM_Variable) {
	Return, (VarSetCapacity(PRM_Variable, 8 + 2 * A_PtrSize) + NumPut(0, PRM_Variable, 0, "Short") + NumPut(0, PRM_Variable, 8, "Ptr")) * 0 + &PRM_Variable
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Paste :
;;;;;;;;;

TXT_TrayMenuPasteAlternate:
If (WIN_FocusLastWindow()) {
	TXT_PasteManager("^<!v")
}
Return

TXT_TrayMenuPastePlainText:
If (WIN_FocusLastWindow()) {
	TXT_PasteManager("^+v")
}
Return

TXT_TrayMenuPastePlainAlternateText:
If (WIN_FocusLastWindow()) {
	TXT_PasteManager("^<!+v")
}
Return

^v::
^+v::
^<!v::
^<!+v::
!Insert::
#IfWinNotActive, ahk_class mintty
+Insert::
#IfWinNotActive
!+Insert::
TXT_PasteManager(A_ThisHotKey)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_PasteManager(PRM_ThisHotKey = "", PRM_Text = "") {

	Critical, On
	Global TXT_ClipBoard
	LOC_Alternate := LOC_Reload := false
	LOC_ClipBoard := ClipBoardAll
	If (PRM_Text != "") {
		TXT_SetClipBoard(PRM_Text)
	} Else IfInString, PRM_ThisHotKey, % "!"
	{
		TXT_SetClipBoard(TXT_ClipBoard)
		LOC_Alternate := true
		, LOC_Reload := true
	}
	IfInString, PRM_ThisHotKey, % "+"
	{
		Transform, LOC_Unicode, Unicode
		Transform, ClipBoard, Unicode, %LOC_Unicode%
		LOC_Reload := true
	}

	SoundGet, LOC_MuteVolume, , Mute
	LOC_MuteVolume := (LOC_MuteVolume == "Off")
		&& (WinActive("ahk_class OpusApp")
			|| !WinExist("MediaMonkey ahk_class TFMainWindow"))
	If (LOC_MuteVolume) {
		AUD_SoundSet(1, , "Mute")
	}
	LOC_Length := StrLen(ClipBoard)
	If (LOC_Length > 0) {
		LOC_LineCount := TXT_GetFormattedNumber(TXT_GetLineCount(ClipBoard))
		, AHK_ShowToolTip((LOC_Alternate ? "Alternate clipboard" : "Clipboard") . " > " . TXT_GetFormattedNumber(LOC_Length) . " char" . (LOC_Length > 1 ? "s" : "") . (LOC_LineCount > 1 ? " [" . LOC_LineCount . " lines]": "") . " pasted", PRM_Seconds := (LOC_Length > 999 ? 1.5 : 0.75))
	}
	If (WinActive("ahk_class ConsoleWindowClass")
		|| WinActive("ahk_class Console_2_Main")
		|| WinActive("ahk_class PuTTY")) {
		WinGet, LOC_ActiveWindowID, ID
		ControlGetFocus, LOC_Control
		ControlClick, %LOC_Control%, , , Right, 1, NA
		WinActivate, ahk_id %LOC_ActiveWindowID%
	} Else {
		SendInput, ^v
	}
	If (LOC_MuteVolume) {
		AUD_SoundSet(0, , "Mute")
	}
	If (LOC_Reload) {
		Sleep, 300
		TXT_SetClipBoard(LOC_ClipBoard)
	}
	Critical, Off
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Clipboard change control :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OnClipboardChange:
TXT_OnClipboardChange()
Return

TXT_OnClipboardChange(PRM_Operation := 0) {
	; PRM_Operation : -1 : disables onClipBoardChange
	;                  0 : executes onClipBoardChange
	;                  1 : enables  onClipBoardChange
	;                  2 : get state
	Global TXT_TemporaryClipBoard
	Static STA_OnClipBoardChangeEnabled := false
	
	If (PRM_Operation == 2) {
		Return, STA_OnClipBoardChangeEnabled
	}
	
	; Enables / disables :
	;;;;;;;;;;;;;;;;;;;;;;
	If (PRM_Operation == -1) {
		STA_OnClipBoardChangeEnabled := false
		Return
	}
	If (PRM_Operation == 1) {
		STA_OnClipBoardChangeEnabled := true
		Return
	}
		
	If (STA_OnClipBoardChangeEnabled) {
		LOC_TemporaryClipBoard := TXT_TemporaryClipBoard
		If (A_EventInfo != 0) { ; Clipboard not empty
			LOC_ThisHotKey := A_ThisHotKey
			, LOC_TickCount := A_TickCount
			, TXT_TemporaryClipBoard := false
			
			; Tooltip :
			If (LOC_ThisHotKey == "~^c"
				|| LOC_ThisHotKey == "~^Insert") {
				TXT_StandardCopyCutManager(PRM_CopyOperation := 1, , PRM_ClipboardTickCount := LOC_TickCount)
			} Else If (LOC_ThisHotKey == "~^x"
				|| LOC_ThisHotKey == "~^Delete") {
				TXT_StandardCopyCutManager(PRM_CutOperation := -1, , PRM_ClipboardTickCount := LOC_TickCount)
			} Else {
				TXT_StandardCopyCutManager(PRM_UndefinedOperation := 0, , PRM_ClipboardTickCount := LOC_TickCount)
				If (!LOC_TemporaryClipBoard) {
					If LOC_ThisHotKey Not In ^Insert,^Delete,^+c,^+Insert,^+x,^+Delete,^<!c,^<!Insert,^<!x,^<!Delete,^<!+c,^<!+Insert,^<!+x,^<!+Delete
					{
						LOC_Length := StrLen(ClipBoard)
						If (LOC_Length > 0) {
							LOC_LineCount := TXT_GetFormattedNumber(TXT_GetLineCount(ClipBoard))
							, AHK_ShowToolTip("Clipboard < " . TXT_GetFormattedNumber(LOC_Length) . " char" . (LOC_Length > 1 ? "s" : "") . (LOC_LineCount > 1 ? " [" . LOC_LineCount . " lines]" : ""), PRM_Seconds := (LOC_Length > 999 ? 1.5 : 0.75))
						}
					}
				}
			}

			; History :
			If (!LOC_TemporaryClipBoard) {
				TXT_ClipBoardHistoryManager(PRM_SetOperation := 1)
			}
		}
	}
	TXT_TemporaryClipBoard := false
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_GetClipBoard(PRM_FromClipBoard = true, PRM_ClipBoard = "") {
	
	; Returns object : Data
	;                  DataLength
	;                  IsTextable
	;                  Text
	;                  TextLength
	;                  Length
	
	LOC_ClipBoardA := {}
	LOC_OnClipBoardChangeEnabled := TXT_OnClipBoardChange(PRM_GetState := 2)
	, TXT_OnClipBoardChange(PRM_Enabled := 1)
	If (!PRM_FromClipBoard) {
		LOC_ClipBoardAll := ClipboardAll
		If (LOC_OnClipBoardChangeEnabled) {
			TXT_SetClipBoard(PRM_ClipBoard)
		} Else {
			ClipBoard := PRM_ClipBoard
		}
	}
	LOC_ClipBoardA.Data := ClipboardAll
	LOC_ClipBoardA.Text := ClipBoard
	
	LOC_ClipBoardA.DataLength := StrLen(LOC_ClipBoardA.Data)
	, LOC_ClipBoardA.TextLength := StrLen(LOC_ClipBoardA.Text)
	, LOC_ClipBoardA.IsTextable := (LOC_ClipBoardA.TextLength > 0 || LOC_ClipBoardA.DataLength == 0)
	, LOC_ClipBoardA.Length := (LOC_ClipBoardA.IsTextable ? LOC_ClipBoardA.TextLength : LOC_ClipBoardA.DataLength)
	
	If (!PRM_FromClipBoard) {
		If (LOC_OnClipBoardChangeEnabled) {
			TXT_SetClipBoard(PRM_ClipBoard)
		} Else {
			ClipBoard := LOC_ClipBoardAll
		}
	}
	Return, LOC_ClipBoardA
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_GetClipBoardLength(PRM_FromClipBoard = true, PRM_ClipBoard = "") {
	
	If (!PRM_FromClipBoard) {
		LOC_SavedClipBoardAll := ClipboardAll
		, TXT_SetClipBoard(PRM_ClipBoard)
	}
	LOC_ClipBoardAll := ClipboardAll
	LOC_Length := StrLen(LOC_ClipBoardAll)
	
	If (!PRM_FromClipBoard) {
		TXT_SetClipBoard(LOC_SavedClipBoardAll)
	}
	Return, LOC_Length
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_SelectToClipBoard(PRM_CopyCut = 1, PRM_Binary = false) {

	; PRM_CopyCut ==  1 : copy
	;             == -1 : cut
	Global TXT_TemporaryClipBoard
	LOC_OnClipBoardChangeEnabled := TXT_OnClipboardChange(PRM_GetState := 2)
	If (TXT_GetClipBoardLength() > 0) {
		TXT_TemporaryClipBoard := true
		ClipBoard := ""
		LOC_Count := 100
		While (LOC_OnClipBoardChangeEnabled
			&& TXT_TemporaryClipBoard
			&& LOC_Count > 0) {
			Sleep, 10
			LOC_Count--
		}
	}
	TXT_TemporaryClipBoard := true
	SendInput, % (PRM_CopyCut == 1 ? "^c" : "^x")
	ClipWait, 1, PRM_Binary ? 1 : 0
	If (ErrorLevel) {
		TXT_TemporaryClipBoard := false
		Return, ""
	}
	TXT_TemporaryClipBoard := false
	
	If (PRM_Binary) {
		LOC_ClipBoardAll := ClipBoardAll
		Return, LOC_ClipBoardAll
	} Else {
		Return, ClipBoard
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_SetClipBoard(PRM_Value = "") {
	Global TXT_TemporaryClipBoard
	LOC_OnClipBoardChangeEnabled := TXT_OnClipboardChange(PRM_GetState := 2)
	If (ClipBoard) {
		TXT_TemporaryClipBoard := true
		ClipBoard := ""
		LOC_Count := 50
		While (LOC_OnClipBoardChangeEnabled
			&& TXT_TemporaryClipBoard
			&& LOC_Count > 0) {
			Sleep, 10
			LOC_Count--
		}
	}
	
	If (PRM_Value != "") {
		TXT_TemporaryClipBoard := true
		ClipBoard := PRM_Value
	}
	Return, StrLen(PRM_Value) > 0 ? true : false
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TXT_SaveAlternateClipBoard() {

	Global TXT_ClipBoard, ZZZ_ClipBoardInitialized
	Static STA_Writing := false
	If (!TXT_ClipBoard) {
		Return
	}
	While (STA_Writing)
	{
		Sleep, 100
	}
	STA_Writing := true
	Try {
		If (FileExist(A_ScriptDir . "\clip\alternate.clip")) {
			FileDelete, %A_ScriptDir%\clip\alternate.clip
		}
	} Catch LOC_Exception {
		AHK_Catch(LOC_Exception, "TXT_SaveAlternateClipBoard")
	}
	Try {
		FileAppend, %ClipboardAll%, %A_ScriptDir%\clip\alternate.clip
	} Catch LOC_Exception {
		AHK_Catch(LOC_Exception, "TXT_SaveAlternateClipBoard")
	}
	ZZZ_ClipBoardInitialized := true
	, STA_Writing := false
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Clipboard History { Win + H } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#h::
TXT_ShowClipBoardHistoryManager:
TXT_ShowClipBoardHistoryManager()
Return

TXT_ShowClipBoardHistoryManager() {
	TXT_ClipBoardHistoryManager(PRM_ShowOperation := 0)
}

TXT_ClipBoardHistoryManager(PRM_Operation = 1, PRM_AlternateClipBoard = false, PRM_AppendMode = false, PRM_RawTextMode = false, PRM_SelectedIndex = false) {

	; PRM_Operation : -2 : init (or refresh) clipboard history from disk
	;                 -1 : get from history
	;                  0 : show history
	;                  1 : set history
	; PRM_AlternateClipBoard == true : copy to alternate clipboard
	; PRM_AppendMode         == true : append to clipboard
	; PRM_SelectedIndex       > 0    : set history index value into clipboard

	Static STA_DataHistory := false, STA_TextHistory := false, STA_IsTextableHistory := false, STA_DateHistory := false, STA_LengthHistory := false, STA_Count := 50, STA_GuiID := 0, STA_InitDone := false
	Global TXT_ClipBoard, AHK_ScriptInfo, AHK_LogsEnabled, AHK_DebugEnabled, ZZZ_HistorySelectedIndex := false

	AHK_Log("> TXT_ClipBoardHistoryManager(" . PRM_Operation . ", " . PRM_AlternateClipBoard . ", " . PRM_AppendMode . ", " . PRM_RawTextMode . ", " . PRM_SelectedIndex . ")")
	
	; Initialization :
	;;;;;;;;;;;;;;;;;;
	If (PRM_Operation == -2) {
		STA_DataHistory := Array()
		, STA_DataHistory.SetCapacity(STA_Count)
		, STA_TextHistory := Array()
		, STA_TextHistory.SetCapacity(STA_Count)
		, STA_IsTextableHistory := Array()
		, STA_IsTextableHistory.SetCapacity(STA_Count)
		, STA_LengthHistory := Array()
		, STA_LengthHistory.SetCapacity(STA_Count)
		, STA_DateHistory := Array()
		, STA_DateHistory.SetCapacity(STA_Count)

		; Load saved clipboards from disk :
		LOC_ClipBoardIndex := 1
		Loop, %STA_Count% {
			LOC_File := A_ScriptDir . "\clip\" . (A_Index < 10 ? "0" : "") . A_Index . ".clip"
			If (FileExist(LOC_File)) {
				Try {
					FileRead, LOC_Content, *c %LOC_File%
					LOC_ClipBoardA := TXT_GetClipBoard(PRM_FromClipBoard := false, LOC_Content)
					STA_DataHistory[A_Index] := LOC_ClipBoardA.Data
					, STA_TextHistory[A_Index] := LOC_ClipBoardA.Text
					, STA_LengthHistory[A_Index] := LOC_ClipBoardA.Length
					, STA_IsTextableHistory[A_Index] := LOC_ClipBoardA.IsTextable
					FileGetTime, LOC_Time, %LOC_File%, M
					FormatTime, LOC_Time, %LOC_Time%, dd/MM/yyyy HH:mm:ss
					STA_DateHistory[A_Index] := LOC_Time
				} Catch LOC_Exception {
					AHK_Catch(LOC_Exception, "TXT_ClipBoardHistoryManager", PRM_Operation, PRM_AlternateClipBoard, PRM_AppendMode, PRM_RawTextMode, PRM_SelectedIndex)
				}
			}
		}
		
		TXT_OnClipBoardChange(PRM_Operation := 1)
		, STA_InitDone := true
		, AHK_Log("< TXT_ClipBoardHistoryManager(" . PRM_Operation . ", " . PRM_AlternateClipBoard . ", " . PRM_AppendMode . ", " . PRM_RawTextMode . ", " . PRM_SelectedIndex . ") : ShownOrRefreshed")
		Return, 0
	}
	
	If (!STA_InitDone) {
		AHK_Log("< TXT_ClipBoardHistoryManager(" . PRM_Operation . ", " . PRM_AlternateClipBoard . ", " . PRM_AppendMode . ", " . PRM_RawTextMode . ", " . PRM_SelectedIndex . ") : ShownOrRefreshed")
		Return , -1
	}

	; Show (or refresh) GUI :
	;;;;;;;;;;;;;;;;;;;;;;;;;
	If (PRM_Operation == 0) {
		Gui, 48:Destroy ; Clipboard History
		Gui, 48:+LastFound
		Gui, 48:Default

		LOC_MinIndex := STA_DataHistory.MinIndex()
		If (LOC_MinIndex == "") {
			AHK_Debug("Empty clipboard history : TXT_ClipBoardHistoryManager(" . PRM_Operation . "," PRM_AlternateClipBoard . ", " . PRM_AppendMode . ", " . PRM_RawTextMode . ", " . PRM_SelectedIndex . ")")
			If (AHK_LogsEnabled
				|| AHK_DebugEnabled) {
				MsgBox, 4144, No clipboard history - %AHK_ScriptInfo%, There's no clipboard history., 1 ; Exclamation, OK button and modal
			}
			AHK_Log("< TXT_ClipBoardHistoryManager(" . PRM_Operation . ", " . PRM_AlternateClipBoard . ", " . PRM_AppendMode . ", " . PRM_RawTextMode . ", " . PRM_SelectedIndex . ") : ShownOrRefreshed")
			Return, 0
		}
		
		LOC_ItemCount := STA_DataHistory.MaxIndex()
		Gui, 48:Add, ListView, w650 Count%LOC_ItemCount% R%LOC_ItemCount% Grid -Multi +ReadOnly -WantF2 gTXT_SetHistoryToClipBoard, Date|Text|Length|Content
		Gui, 48:Add, Button, Hidden Default gTXT_ClipboardHistoryEnterPressed
		Loop, %LOC_ItemCount% {
			LV_Add(A_Index == 1 ? "Select Vis" : "Vis"
					, STA_DateHistory[A_Index]
					, (STA_IsTextableHistory[A_Index] ? "×" : "")
					, STA_LengthHistory[A_Index]
					, STA_IsTextableHistory[A_Index]
						? (STA_LengthHistory[A_Index] > 64 ? SubStr(STA_TextHistory[A_Index], 1, 63) . "…" : STA_TextHistory[A_Index])
						: "<binary data>")
		}
		LV_ModifyCol(1, "AutoHdr Center CaseLocale")
		LV_ModifyCol(2, "AutoHdr Center CaseLocale")
		LV_ModifyCol(3, "AutoHdr Right CaseLocale")
		LV_ModifyCol(4, "AutoHdr CaseLocale")
		Gui, 48:Add, StatusBar, , Double-click | Enter : Clipboard copy
		SB_SetParts(190, 110, 140, 105)
		SB_SetText(" [+ Control] : Append", 2)
		SB_SetText(" [+ Alt] : Alternate clipboard", 3)
		SB_SetText(" [+ Shift] : Plain text", 4)
		SB_SetText("           Esc : Exit", 5)
		Gui, 48:Show, Center AutoSize, Clipboard History
		If (STA_SelectedIndex) {
			LV_Modify(ZZZ_HistorySelectedIndex, "Select")
		}
		AHK_Log("< TXT_ClipBoardHistoryManager(" . PRM_Operation . ", " . PRM_AlternateClipBoard . ", " . PRM_AppendMode . ", " . PRM_RawTextMode . ", " . PRM_SelectedIndex . ") : ShownOrRefreshed")
		Return, 0
	}

	; Get from history :
	;;;;;;;;;;;;;;;;;;;;
	If (PRM_Operation == -1) {
		If (PRM_SelectedIndex) {
			If (PRM_RawTextMode) {
				LOC_ClipBoard := STA_TextHistory[PRM_SelectedIndex]
			} Else {
				LOC_ClipBoard := STA_DataHistory[PRM_SelectedIndex]
			}
			LOC_ClipBoardA := TXT_GetClipBoard(PRM_FromClipBoard := false, PRM_Content := LOC_ClipBoard)

			LOC_PreviousClipBoard := (PRM_AlternateClipBoard ? TXT_ClipBoard : ClipBoard)
			LOC_ClipBoard := (PRM_AppendMode
								? LOC_PreviousClipBoard . (LOC_PreviousClipBoard ? " " : "") . STA_TextHistory[PRM_SelectedIndex]
								: (PRM_RawTextMode
										? STA_TextHistory[PRM_SelectedIndex]
										: STA_DataHistory[PRM_SelectedIndex]))
			LOC_CharaCopied := StrLen(STA_LengthHistory[PRM_SelectedIndex])
			If (!PRM_AppendMode
				&& !PRM_RawTextMode
				&& STA_IsTextableHistory[PRM_SelectedIndex]
				&& LOC_ClipBoard == "") {
				LOC_ClipBoard := STA_TextHistory[PRM_SelectedIndex]
			}
			If (PRM_AlternateClipBoard) {
				TXT_ClipBoard := LOC_ClipBoard
			} Else {
				TXT_SetClipboard(LOC_ClipBoard)
			}
			
			If (PRM_AppendMode) {
				;~ STA_DataHistory[PRM_SelectedIndex] := ""
				;~ STA_TextHistory[PRM_SelectedIndex] := LOC_ClipBoard
				;~ STA_IsTextableHistory[PRM_SelectedIndex] := true
				;~ STA_LengthHistory[PRM_SelectedIndex] := StrLen(LOC_ClipBoard)
				;~ FormatTime, LOC_Time, , dd/MM/yyyy HH:mm:ss
				;~ STA_DateHistory[PRM_SelectedIndex] := LOC_Time
				
				;~ LV_Modify(PRM_SelectedIndex, "Select Focus Vis",
						;~ , STA_DateHistory[PRM_SelectedIndex]
						;~ , "×"
						;~ , STA_LengthHistory[PRM_SelectedIndex]
						;~ , STA_LengthHistory[A_Index] > 64 ? SubStr(STA_TextHistory[A_Index], 1, 63) . "…" : STA_TextHistory[A_Index])
				AHK_Debug("New clipboard history entry created")
				LOC_CharsCopied := TXT_ClipBoardHistoryManager(PRM_SetOperation := 1, PRM_AlternateClipBoard, PRM_AppendMode, PRM_RawTextMode)
				LV_Add()
				Loop, % STA_DataHistory.MaxIndex()
				{
					LV_Modify(A_Index, (A_Index == 1 ? "Select Focus Vis" : "-Select")
								, STA_DateHistory[A_Index]
								, (STA_IsTextableHistory[A_Index] ? "×" : "")
								, STA_LengthHistory[A_Index]
								, STA_IsTextableHistory[A_Index]
									? (STA_LengthHistory[A_Index] > 64 ? SubStr(STA_TextHistory[A_Index], 1, 63) . "…" : STA_TextHistory[A_Index])
									: "<binary data>")
				}
				
				If (PRM_SelectedIndex < STA_Count) {
					LV_Modify(min(PRM_SelectedIndex + 1, STA_Count), "Select Focus Vis")
				}
			} Else {
				; Change date and other properties
				STA_IsTextableHistory[PRM_SelectedIndex] := LOC_ClipBoardA.isTextable
				FormatTime, LOC_Time, , dd/MM/yyyy HH:mm:ss
				STA_DateHistory[PRM_SelectedIndex] := LOC_Time
				, LOC_CharsCopied := STA_LengthHistory[PRM_SelectedIndex]
				LV_Modify(PRM_SelectedIndex, PRM_SelectedIndex == 1 ? "Select Vis" : "Vis"
					, STA_DateHistory[PRM_SelectedIndex]
					, (STA_IsTextableHistory[PRM_SelectedIndex] ? "×" : "")
					, STA_LengthHistory[PRM_SelectedIndex]
					, STA_IsTextableHistory[PRM_SelectedIndex]
						? (STA_LengthHistory[PRM_SelectedIndex] > 64 ? SubStr(STA_TextHistory[PRM_SelectedIndex], 1, 63) . "…" : STA_TextHistory[PRM_SelectedIndex])
						: "<binary data>")
			}
			AHK_ShowToolTip((PRM_AlternateClipBoard ? "Alternate clipboard" : "Clipboard") . " <" . (PRM_AppendMode ? "< " : " ") . LOC_CharsCopied . " char" . (LOC_CharsCopied > 1 ? "s" : "") . " copied", PRM_ToolTipSeconds := 1.25)
			AHK_Log("< TXT_ClipBoardHistoryManager(" . PRM_Operation . ", " . PRM_AlternateClipBoard . ", " . PRM_AppendMode . ", " . PRM_RawTextMode . ", " . PRM_SelectedIndex . ") : ClipboardPasted")
			Return, LOC_CharaCopied
		}
	}

	; Set to history :
	;;;;;;;;;;;;;;;;;;
	If (PRM_Operation == 1) {
		
		; Init values :
		LOC_ClipBoardA := TXT_GetClipBoard(PRM_FromClipBoard := !PRM_AlternateClipBoard, TXT_ClipBoard)

		; Compare with previous content :
		LOC_FirstIndex := STA_DataHistory.MinIndex()
		If (LOC_FirstIndex) {
			If (STA_IsTextableHistory[LOC_FirstIndex] == LOC_ClipBoardA.IsTextable
				&& STA_LengthHistory[LOC_FirstIndex] == LOC_ClipBoardA.Length) {
				LOC_PreviousContent := STA_DataHistory[LOC_FirstIndex]
				, LOC_CurrentContent := LOC_ClipBoardA.Data
				If LOC_PreviousContent = %LOC_CurrentContent%
				{
					FormatTime, LOC_Time, , dd/MM/yyyy HH:mm:ss
					STA_DateHistory[LOC_FirstIndex] := LOC_Time
					LOC_File := A_ScriptDir . "\clip\" . (LOC_FirstIndex < 10 ? "0" : "") . LOC_FirstIndex . ".clip"
					AHK_Debug(LOC_File)
					If (FileExist(LOC_File)) {
						Try {
							FileSetTime, , %LOC_File%
						} Catch LOC_Exception {
							AHK_Catch(LOC_Exception, "TXT_ClipBoardHistoryManager", PRM_Operation, PRM_AlternateClipBoard, PRM_AppendMode, PRM_RawTextMode, PRM_SelectedIndex)
						}
					}
					AHK_Log("< TXT_ClipBoardHistoryManager(" . PRM_Operation . ", " . PRM_AlternateClipBoard . ", " . PRM_AppendMode . ", " . PRM_RawTextMode . ", " . PRM_SelectedIndex . ") : ClipboardHistoryEntryRefreshed")
					Return, 0
				}
			}
		}

		; Save clipboard values :
		; AHK_Debug("Save clipboard values")
		LOC_MaxIndex := STA_DataHistory.MaxIndex()
		If (LOC_MaxIndex) {
			Loop, %LOC_MaxIndex% {
				LOC_Index := LOC_MaxIndex - A_Index
				If (LOC_Index > 0) {
					STA_DataHistory[LOC_Index + 1] := STA_DataHistory[LOC_Index]
					, STA_TextHistory[LOC_Index + 1] := STA_TextHistory[LOC_Index]
					, STA_IsTextableHistory[LOC_Index + 1] := STA_IsTextableHistory[LOC_Index]
					, STA_LengthHistory[LOC_Index + 1] := STA_LengthHistory[LOC_Index]
					, STA_DateHistory[LOC_Index + 1] := STA_DateHistory[LOC_Index]
				}
			}
		}

		FormatTime, LOC_Time, , dd/MM/yyyy HH:mm:ss
		STA_DataHistory[1] := LOC_ClipBoardA.Data
		, STA_TextHistory[1] := LOC_ClipBoardA.Text
		, STA_IsTextableHistory[1] := LOC_ClipBoardA.IsTextable
		, STA_LengthHistory[1] := LOC_ClipBoardA.Length
		, STA_DateHistory[1] := LOC_Time

		; Manage files for setting new data :
		LOC_File := A_ScriptDir . "\clip\" . (STA_Count < 10 ? "0" : "") . STA_Count . ".clip"
		If (FileExist(LOC_File)) {
			Try {
				FileSetAttrib, -RSH, %LOC_File%
				FileDelete, %LOC_File%
			} Catch LOC_Exception {
				AHK_Catch(LOC_Exception, "TXT_ClipBoardHistoryManager", PRM_Operation, PRM_AlternateClipBoard, PRM_AppendMode, PRM_RawTextMode, PRM_SelectedIndex)
			}
		}

		Loop, %STA_Count% {
			LOC_Count := STA_Count - A_Index
			LOC_File := A_ScriptDir . "\clip\" . (LOC_Count < 10 ? "0" : "") . LOC_Count . ".clip"
			LOC_NewFile := A_ScriptDir . "\clip\" . (LOC_Count + 1 < 10 ? "0" : "") . (LOC_Count + 1) . ".clip"
			If (FileExist(LOC_File)) {
				Try {
					FileSetAttrib, -RSH, %LOC_File%
					FileMove, %LOC_File%, %LOC_NewFile%, 1
				} Catch LOC_Exception {
					AHK_Catch(LOC_Exception, "TXT_ClipBoardHistoryManager", PRM_Operation, PRM_AlternateClipBoard, PRM_AppendMode, PRM_RawTextMode, PRM_SelectedIndex)
				}
			}
		}

		LOC_File := A_ScriptDir . "\clip\01.clip"
		If (FileExist(LOC_File)) {
			Try {
				FileDelete, %LOC_File%
			} Catch LOC_Exception {
				AHK_Catch(LOC_Exception, "TXT_ClipBoardHistoryManager", PRM_Operation, PRM_AlternateClipBoard, PRM_AppendMode, PRM_RawTextMode, PRM_SelectedIndex)
			}
		}
		Try {
			FileAppend, %ClipboardAll%, %LOC_File%
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "TXT_ClipBoardHistoryManager", PRM_Operation, PRM_AlternateClipBoard, PRM_AppendMode, PRM_RawTextMode, PRM_SelectedIndex)
		}
		LOC_CharsCopied := STA_LengthHistory[1]
		, AHK_Log("< TXT_ClipBoardHistoryManager(" . PRM_Operation . ", " . PRM_AlternateClipBoard . ", " . PRM_AppendMode . ", " . PRM_RawTextMode . ", " . PRM_SelectedIndex . ") : ShownOrRefreshed")
		Return, LOC_CharsCopied
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

48GuiClose:
48GuiEscape:
Gui, 48:Destroy
Return

TXT_ClipboardHistoryEnterPressed:
TXT_SetHistoryToClipBoard()
Return

TXT_SetHistoryToClipBoard:
TXT_SetHistoryToClipBoard(A_GuiEvent)
Return

TXT_SetHistoryToClipBoard(PRM_GuiEvent = "DoubleClick") {
	Global AHK_TooltipsEnabled, ZZZ_HistorySelectedIndex
	If (PRM_GuiEvent == "DoubleClick") {
		Gui, 48:Default ; Clipboard History
		LOC_SelectedIndex := LV_GetNext(0, "Focused")
		If (LOC_SelectedIndex > 0) {
			ZZZ_HistorySelectedIndex := LOC_SelectedIndex
			IF (! AHK_TooltipsEnabled) {
				AHK_Debug("TXT_SetHistoryToClipBoard", PRM_GuiEvent, "-" . LOC_SelectedIndex . "-")
			}
			TXT_ClipBoardHistoryManager(PRM_GetOperation := -1, PRM_AlternateClipBoard := GetKeyState("Alt"), PRM_AppendMode := GetKeyState("Control"), PRM_RawTextMode := GetKeyState("Shift"), PRM_SelectedIndex := LOC_SelectedIndex)
			Gui, 48:Destroy
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Current / previous / next word { { Control | Alt | Control + Alt } [ + Shift ] + { Arrows | BackSpace } } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;^Left:: ; Move to previous word OK
;KBD_WordControl(false, 0)
;Return

;~ ^+Left:: ; Select previous word
;~ KBD_ControlShiftArrow(false)
;~ Return

;^Right:: ; Move to next word KO
;KBD_WordControl(true)
;Return

;~ ^+Right:: ; Select next word
;~ KBD_ControlShiftArrow(true)
;~ Return

;^!Left:: ; Select current word from right to left KO
;KBD_SelectCurrentWord(false)
;Return

;^!Right:: ; Select current word from left to right KO
;KBD_SelectCurrentWord(true)
;Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^BackSpace:: ; Erase previous word OK
KBD_WordControl(false, 2)
Return
KBD_TrayMenuDeletePreviousWord:
If (WIN_FocusLastWindow()) {
	KBD_WordControl(false, 2)
}
Return

^+BackSpace:: ; Cut previous word OK
KBD_WordControl(false, 3)
Return
KBD_TrayMenuCutPreviousWord:
If (WIN_FocusLastWindow()) {
	KBD_WordControl(false, 3)
}
Return

!BackSpace:: ; Erase next word OK
KBD_WordControl(true, 2)
Return
KBD_TrayMenuDeleteNextWord:
If (WIN_FocusLastWindow()) {
	KBD_WordControl(true, 2)
}
Return

!+BackSpace:: ; Cut next word KO
KBD_WordControl(true, 3)
Return
KBD_TrayMenuCutNextWord:
If (WIN_FocusLastWindow()) {
	KBD_WordControl(true, 3)
}
Return

^!BackSpace:: ; Erase current word
KBD_WordControl(true, 2)
, KBD_WordControl(false, 2)
Return
KBD_TrayMenuDeleteCurrentWord:
If (WIN_FocusLastWindow()) {
	KBD_WordControl(true, 2)
	, KBD_WordControl(false, 2)
}
Return

^!+BackSpace:: ; Cut current word
KBD_WordControl(false, 3, KBD_WordControl(true, 2))
Return
KBD_TrayMenuCutCurrentWord:
If (WIN_FocusLastWindow()) {
	KBD_WordControl(false, 3, KBD_WordControl(true, 2))
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;~ KBD_ControlShiftArrow(PRM_Direction = true) {
	;~ TXT_OnClipboardChange(PRM_Activate := -1)
	;~ , LOC_Selection := TXT_GetSelectedText()
	;~ , TXT_OnClipboardChange(PRM_Activate := 1)
	;~ If (LOC_Selection) {
		;~ SendInput, % "^+" . (PRM_Direction ? "Right" : "Left")
	;~ } Else {
		;~ KBD_WordControl(PRM_Direction, 1)
	;~ }
;~ }

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_SelectCurrentWord(PRM_Direction) {
	LOC_FinalLength := KBD_WordControl(PRM_Direction, -1) + KBD_WordControl(!PRM_Direction, 0)
	If (LOC_FinalLength > 0) {
		SendInput, % "+{" . (PRM_Direction ? "Right" : "Left") . (LOC_FinalLength > 1 ? " " . LOC_FinalLength : "") . "}"
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_WordControl(PRM_Direction, PRM_Operation = 0, PRM_AppendedText = "") {
	
	; PRM_Direction == false => Left
	; PRM_Direction == true  => Right
	; PRM_Operation == -1 => no move (return length)
	; PRM_Operation == 0  => move to text (return length)
	; PRM_Operation == 1  => select text (return text)
	; PRM_Operation == 2  => erase text (return text)
	; PRM_Operation == 3  => cut text (return text)
	; PRM_AppendedText    => Text to append to the result
	Static STA_NoType := 0, STA_LowerType := 1, STA_UpperType := 2, STA_NumericType := 3, STA_SpaceType := 4, STA_PunctuationType := 5, STA_ApostropheType := 6 ; must be the same as in KBD_GetCharType()
	
; MsgBox, % "^{Alt Up}" . (GetKeyState("Shift") ? "" : "+") . "{" . (PRM_Direction ? "Right" : "Left") . "}"
;	SendInput, % "^{Alt Up}" . (GetKeyState("Shift") ? "" : "+") . "{" . (PRM_Direction ? "Right" : "Left") . "}"
	SendInput, % "^+{" . (PRM_Direction ? "Right" : "Left") . "}"
	TXT_OnClipboardChange(PRM_Activate := -1)
	, LOC_Selection := TXT_GetSelectedText()
	, TXT_OnClipboardChange(PRM_Activate := 1)
;Return
	If (LOC_Selection == "") {
;MsgBox, Out !
		Return, % (PRM_Operation == -1 || PRM_Operation == 0 ? 0 : "")
	}
;MsgBox, Ici.
	LOC_SelectionLength := StrLen(LOC_Selection)
	, LOC_FinalLength := LOC_CharType := 0
	Loop, %LOC_SelectionLength% {
		LOC_Char := SubStr(LOC_Selection, PRM_Direction ? A_Index : LOC_SelectionLength - A_Index + 1, 1)
		, LOC_CharType := KBD_GetCharType(LOC_Char)
		If (A_Index == 1) { ; first char
			LOC_MainType := LOC_CharType
		} Else If (A_Index == 2 && LOC_MainType == STA_SpaceType) { ; single space to erase, then word
			LOC_MainType := LOC_CharType
		} Else If (PRM_Direction && LOC_MainType == STA_UpperType && LOC_CharType == STA_LowerType) { ; lowercase word starting with an uppercase
			LOC_MainType := STA_LowerType
		} Else If (!PRM_Direction && LOC_MainType == STA_LowerType && LOC_CharType == STA_UpperType) { ; lowercase word starting with an uppercase
			LOC_FinalLength++
			Break
		} Else If (PRM_Direction && (LOC_MainType == STA_UpperType || LOC_MainType == STA_LowerType) && LOC_CharType == STA_ApostropheType) { ; apostrophe foolowing alpha
			LOC_FinalLength++
			Break
		} Else If (A_Index == 2 && !PRM_Direction && LOC_MainType == STA_ApostropheType && (LOC_CharType == STA_UpperType || LOC_MainType == STA_LowerType)) { ; apostrophe preceeding alpha
			LOC_MainType := LOC_CharType
		} Else If (A_Index == LOC_SelectionLength
			&& LOC_CharType == STA_SpaceType
			&& LOC_MainType != STA_SpaceType
			&& (!PRM_Direction || PRM_AppendedText == "")) { ; unique beginning/ending space to delete
			LOC_FinalLength == LOC_SelectionLength
			Break
		} Else If (LOC_CharType != LOC_MainType) {
			Break
		}
		LOC_FinalLength++
	}
	
;MsgBox, Là : %LOC_FinalLength% < %LOC_SelectionLength% ?
	; No move operation => set cursor pos to original :
	If (PRM_Operation == -1) {
		SendInput, % (PRM_Direction ? "{Left}" : "{Right}")
		Return, LOC_FinalLength
	}

	; Reduce selection to its length :
	If (LOC_FinalLength < LOC_SelectionLength) {
		SendInput, % (PRM_Operation > 0 ? "+" : "") . "{" . (PRM_Direction ? "Left" : "Right") . " " . LOC_SelectionLength - LOC_FinalLength . "}"
	} Else If (PRM_Operation == 0) {
		SendInput, % (PRM_Direction ? "{Left}{Right}" : "{Right}{Left}") ; just to deselect text
	}
	
	If (PRM_Operation == 0) {
		Return, LOC_FinalLength
	}

	LOC_Selection := SubStr(LOC_Selection, PRM_Direction ? 1 : LOC_SelectionLength - LOC_FinalLength + 1, LOC_FinalLength) . PRM_AppendedText
	If (PRM_Operation == 2
		|| PRM_Operation == 3) { ; erase or cut
;MsgBox, Coupez !
		SendInput, {Delete}
	}
	If (PRM_Operation == 3) {
		Clipboard := LOC_Selection
	}
	Return, LOC_Selection
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KBD_GetCharType(PRM_Char) {
	Static STA_NoType := 0, STA_LowerType := 1, STA_UpperType := 2, STA_NumericType := 3, STA_SpaceType := 4, STA_PunctuationType := 5, STA_ApostropheType := 6 ; must be the same as in KBD_WordControl()
	If (PRM_Char) {
		If PRM_Char Is Lower
		{
			LOC_CharType := STA_LowerType
		} Else If PRM_Char In á,à,â,ä,ã,å,æ,ç,é,è,ê,ë,í,ì,î,ï,ñ,ó,ò,ô,õ,ö,œ,š,ú,ù,û,ü,ý,ÿ,ž
		{
			LOC_CharType := STA_LowerType
		} Else If PRM_Char Is Upper
		{
			LOC_CharType := STA_UpperType
		} Else If PRM_Char In Á,À,Â,Ä,Ã,Å,Æ,Ç,É,È,Ê,Ë,Í,Ì,Î,Ï,Ñ,Ó,Ò,Ô,Õ,Ö,Œ,Š,Ú,Ù,Û,Ü,Ý,Ÿ,Ž
		{
			LOC_CharType := STA_UpperType
		} Else If PRM_Char Is Digit
		{
			LOC_CharType := STA_NumericType
		} Else If PRM_Char In %A_Space%,`t,`r,`n,`v,`f,-,–,—,_
		{
			LOC_CharType := STA_SpaceType
		} Else If PRM_Char In !,",(,),`,,.,/,:,;,<,=,>,?,[,\,],^,{,|,},‚,„,…,ˆ,‹,“,”,›,¡,¦,«,¶,¸,»,¿
		{
			LOC_CharType := STA_PunctuationType
		} Else If PRM_Char In ',``,‘,’,´
		{
			LOC_CharType := STA_ApostropheType
		} Else {
			LOC_CharType := STA_NoType
		}
		Return, LOC_CharType
	}
	Return, STA_NoType
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

