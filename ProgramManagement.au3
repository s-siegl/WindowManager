#include <WinAPIShellEx.au3>

Global Const $sNOTEPAD_PLUSPLUS_PROGRAM = "C:\Program Files (x86)\Notepad++\notepad++.exe"

Func OpenDocuments()
	_WinAPI_ShellExecute(@UserProfileDir & "\Documents", Default, Default, "explore")
EndFunc

Func OpenDownloads()
	_WinAPI_ShellExecute(@UserProfileDir & "\Downloads", Default, Default, "explore")
EndFunc

Func StartNotepadPlusPlus()
	Run($sNOTEPAD_PLUSPLUS_PROGRAM)
EndFunc

Func StartPowershell()
	Run("powershell.exe")
EndFunc