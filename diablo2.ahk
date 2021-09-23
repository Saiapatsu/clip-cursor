;Diablo 2 cursor clipping AHK script
; For AutoHotkey 1.1
; quickly cleaned up for Indrek
; May require manual adjustments

; BUG: this does not react at all when the window's size changes

GroupAdd diablo, ahk_exe Game.exe
GroupAdd diablo, ahk_exe D2SE.exe
GroupAdd diablo, Diablo II
GroupAdd diablo, ahk_exe notepad++.exe
; add something that matches D2R here #######################################
; "ahk_exe Game.exe" will match any program named Game.exe
; "Diablo II" will match any window whose title is Diablo II

; die if this script isn't in admin mode
; (if D2R doesn't require admin, this part can be removed safely ######################)
if !A_IsAdmin
{
	MsgBox, This script should be run in administrator mode
	ExitApp
}

; ---------------------------------------------------

#NoEnv
#SingleInstance force
SetTitleMatchMode 2

; start looking for the window
Loop
{
	WinWaitActive ahk_group diablo
	ToolTip Active
	
	; there's no function or coordmode in 1.1 that will give us the client coordinates of the game,
	; so let's do it ourselves
	; copied from: https://www.autohotkey.com/boards/viewtopic.php?t=60924
	VarSetCapacity(RECT, 16, 0)
	DllCall("user32\GetClientRect" , "Ptr", WinExist(), "Ptr", &RECT)
	DllCall("user32\ClientToScreen", "Ptr", WinExist(), "Ptr", &RECT)
	x := NumGet(&RECT,  0, "Int")
	y := NumGet(&RECT,  4, "Int")
	w := NumGet(&RECT,  8, "Int")
	h := NumGet(&RECT, 12, "Int")
	ClipCursor(1, x, y, x+w, y+h)
	
	WinWaitNotActive ahk_group diablo
	ToolTip Inactive
	ClipCursor(0, 0, 0, 0, 0)
}

;ClipCursor function via https://autohotkey.com/board/topic/61753-confining-mouse-to-a-window/
ClipCursor( Confine=True, x1=0 , y1=0, x2=1, y2=1 ) {
 VarSetCapacity(R,16,0),  NumPut(x1,&R+0),NumPut(y1,&R+4),NumPut(x2,&R+8),NumPut(y2,&R+12)
Return Confine ? DllCall( "ClipCursor", UInt,&R ) : DllCall( "ClipCursor" )
}
