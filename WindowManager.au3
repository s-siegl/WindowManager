#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=WindowManager.ico
#AutoIt3Wrapper_Outfile_x64=WindowManager.exe
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Fileversion=1.0.0.10
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_Icon_Add=WindowManager.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <MsgBoxConstants.au3>
#include "ProgramManagement.au3"
#include "WindowManagement.au3"

; OWN MANAGEMENT
HotKeySet("!^+q", "KillMe")

; WINDOW MANAGEMENT
HotKeySet("!b", "MaximizeWindow")
HotKeySet("!c", "MinimizeWindow")
HotKeySet("!v", "RestoreWindow")
HotKeySet("!^a", "MoveAround")
HotKeySet("!^r", "Resize")

; PROGRAM STARTUP
HotKeySet("!n", "StartNotepadPlusPlus")
HotKeySet("!p", "StartPowershell")
HotKeySet("^!d", "OpenDocuments")
HotKeySet("^!j", "OpenDownloads")

Func KillMe()
	Local $iChoice = MsgBox($MB_OKCANCEL + $MB_ICONQUESTION, _
		"Window Manager", _
		"You are about to KILL this program, CONTINUE?"& _
		@CRLF&@CRLF&@CRLF & _
		"PROGRAMS Usage:" & @CRLF & _
		"ALT + N                -> Notepad++" & @CRLF & _
		"ALT + P                -> Powershell" & @CRLF & _
		"CTRL + ALT + D  -> Documents" & @CRLF & _
		"CTRL + ALT + J   -> Downloads" & @CRLF & _
		@CRLF & _
		"WINDOWS Usage:" & @CRLF & _
		"ALT + B                -> Maximise" & @CRLF & _
		"ALB + V                -> Restore" & @CRLF & _
		"ALT + C                -> Minimize" & @CRLF & _
		"CTRL + ALT + A  -> Move Around" & @CRLF & _
		"CTRL + ALT + R  -> Resize")
	If $iChoice = $IDOK Then Exit 0
EndFunc

While True
	Sleep(10*1000)
WEnd