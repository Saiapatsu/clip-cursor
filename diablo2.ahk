;Diablo 2 AHK script

if !A_IsAdmin
{
	MsgBox, This script should be run in administrator mode
	ExitApp
}

#NoEnv
#SingleInstance force
;#ClipboardTimeout -1
SendMode Input
SetWorkingDir %A_ScriptDir%
for __, Category in ["Pixel", "Mouse"]
	CoordMode, %Category%, Client

SetKeyDelay 0
SetMouseDelay 0
SetDefaultMouseSpeed, 0
SetTitleMatchMode 2



;---------------------------------Auto-suspend----------------------------------

Suspend on
GroupAdd diablo, ahk_exe Game.exe
GroupAdd diablo, ahk_exe D2SE.exe
GroupAdd diablo, Diablo II
WinNotActive()

WinActive()
{
	Suspend Off
	;Clip mouse to the game window
	WinGetPos, VarX, VarY, Width, Height, A
	VarX2 := VarX + Width
	VarY2 := VarY + Height
	ClipCursor( True, VarX+8, VarY+31, VarX2-8, VarY2-8)
	WinWaitNotActive ahk_group diablo
	{
		WinNotActive()
	}
}
WinNotActive()
{
	ClipCursor( False,0,0,0,0)
	Suspend on
	WinWaitActive ahk_group diablo
	{
		WinActive()
	}
}

;---------------------------------The cool shit---------------------------------

;unclip mouse
f2::ClipCursor( False,0,0,0,0)

;reload script
^!r::Reload

;remap middle click to right click
; MButton::RButton

;use a town portal
!q::
LButtonDown := GetKeyState("LButton")
MouseGetPos, mousx, mousy
Send, {Space}
Click, right, 432, 330
Send, {Space}
MouseMove, mousx, mousy
if LButtonDown
	Click, left, down
return

;ClipCursor function via https://autohotkey.com/board/topic/61753-confining-mouse-to-a-window/
ClipCursor( Confine=True, x1=0 , y1=0, x2=1, y2=1 ) {
 VarSetCapacity(R,16,0),  NumPut(x1,&R+0),NumPut(y1,&R+4),NumPut(x2,&R+8),NumPut(y2,&R+12)
Return Confine ? DllCall( "ClipCursor", UInt,&R ) : DllCall( "ClipCursor" )
}