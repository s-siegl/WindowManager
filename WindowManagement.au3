#include <Misc.au3>
#include <WinAPI.au3>

Func MaximizeWindow()
	Local $hWin = _WindowFromMousePos()
	If $hWin = 0 Then Return
	WinSetState($hWin, "", @SW_MAXIMIZE)
EndFunc

Func MinimizeWindow()
	Local $hWin = _WindowFromMousePos()
	If $hWin = 0 Then Return
	WinSetState($hWin, "", @SW_MINIMIZE)
EndFunc

Func RestoreWindow()
	Local $hWin = _WindowFromMousePos()
	If $hWin = 0 Then Return
	WinSetState($hWin, "", @SW_RESTORE)
EndFunc

Func MoveAround()
	Local Const $iCTRLKey = 11, $iALTKey = 12

	; Open USER32.DLL to get Key status (pressed/not) since intensive calls
	Local $hUser32DLL = DllOpen("user32.dll")
	If $hUser32DLL = -1 Then Return

	Local $hWin = _WindowFromMousePos()
	If $hWin = 0 Then Return

	; Get initial mouse position
	Local $aMouseInitPosition = MouseGetPos()
	If @error = 1 Then Return

	; Get initial window position
	Local $aWindowInitPosition = WinGetPos($hWin)
	If @error <> 0 Then Return

	Local $aMouseNewPosition = Null
	Local $iNewXWindowPosition = 0, $iNewYWindowPosition = 0
	While(_IsPressed($iCTRLKey, $hUser32DLL) And _IsPressed($iALTKey, $hUser32DLL))
		$aMouseNewPosition = MouseGetPos()
		$iNewXWindowPosition = $aWindowInitPosition[0] + $aMouseNewPosition[0] - $aMouseInitPosition[0]
		$iNewYWindowPosition = $aWindowInitPosition[1] + $aMouseNewPosition[1] - $aMouseInitPosition[1]

		WinMove($hWin, Default, $iNewXWindowPosition, $iNewYWindowPosition)
		Sleep("25")
	WEnd

	DllClose($hUser32DLL)
EndFunc

Func Resize()
	Local Const $iCTRLKey = 11, $iALTKey = 12

	; Open USER32.DLL to get Key status (pressed/not) since intensive calls
	Local $hUser32DLL = DllOpen("user32.dll")
	If $hUser32DLL = -1 Then Return

	Local $hWin = _WindowFromMousePos()
	If $hWin = 0 Then Return

	; Get initial mouse position
	Local $aMouseInitPosition = MouseGetPos()
	If @error = 1 Then Return

	; Get initial window position
	Local $aWindowInitPosition = WinGetPos($hWin)
	If @error <> 0 Then Return

	; Determine window region (UpLeft, UpRight, DownLeft, DownRight)
	Local $iIsLeft = -1, $iIsUp = -1
	If $aMouseInitPosition[0] < $aWindowInitPosition[0] + $aWindowInitPosition[2]/2 Then  _
		$iIsLeft = 1
	If $aMouseInitPosition[1] < $aWindowInitPosition[1] + $aWindowInitPosition[3]/2 Then _
		$iIsUp = 1
	ConsoleWrite(@CRLF&"LEFT:"&$iIsLeft&@CRLF&"UP:"&$iIsUp&@CRLF&@CRLF)

	Local $aMouseNewPosition = Null
	Local $iXOffset, $iYOffset
	While(_IsPressed($iCTRLKey, $hUser32DLL) And _IsPressed($iALTKey, $hUser32DLL))
		$aMouseNewPosition = MouseGetPos()
		$aWindowInitPosition = WinGetPos($hWin)

		$iXOffset = $aMouseNewPosition[0] - $aMouseInitPosition[0]
		$iYOffset = $aMouseNewPosition[1] - $aMouseInitPosition[1]

		WinMove($hWin, Default, _
			$aWindowInitPosition[0] + ($iIsLeft+1)/2*$iXOffset, _
			$aWindowInitPosition[1] + ($iIsUp+1)/2*$iYOffset, _
			$aWindowInitPosition[2] - $iIsLeft*$iXOffset, _
			$aWindowInitPosition[3] - $iIsUp*$iYOffset)
		$aMouseInitPosition[0] = $iXOffset + $aMouseInitPosition[0]
		$aMouseInitPosition[1] = $iYOffset + $aMouseInitPosition[1]

		Sleep("25")
	WEnd

	DllClose($hUser32DLL)
EndFunc


; Thanks to ascend4ant for the initial code:
; https://stackoverflow.com/questions/11234628/autoit-find-window-under-mouse-pointer
Func _WindowFromMousePos()
    Local $stInt64,$aRet,$stPoint=DllStructCreate("long;long")

	DllStructSetData($stPoint,1,MouseGetPos(0))
    DllStructSetData($stPoint,2,MouseGetPos(1))

	$stInt64=DllStructCreate("int64",DllStructGetPtr($stPoint))
    $aRet=DllCall("user32.dll","hwnd","WindowFromPoint","int64",DllStructGetData($stInt64,1))

	If @error Then Return SetError(2,@error,0)
    If $aRet[0]=0 Then Return SetError(3,0,0)

	Return _WinAPI_GetAncestor($aRet[0], 2)
EndFunc