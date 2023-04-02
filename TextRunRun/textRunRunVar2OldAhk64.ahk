#SingleInstance FORCE	;終了してから再起動
;#WinActivateForce
;#MenuMaskKey vk07
#KeyHistory 0

Process, Priority, , Normal	;優先度を普通にする
;mySc_ahkPid = %ErrorLevel%

;あとで設定するのでコメントにする
;DetectHiddenWindows, Off
DetectHiddenText, Off

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
CoordMode, ToolTip, Screen
SetDefaultMouseSpeed, 1
StringCaseSense, On		;大文字と小文字を区別する
ListLines, Off			;スクリプトの実行履歴


SetWorkingDir, %A_ScriptDir%

IfNotExist,  %A_ScriptDir%\trrEvery\icon.ico
{
	if(A_IsCompiled == 1){
		Menu, Tray, Icon, %A_ScriptFullPath%
	} else {
		Menu, Tray, Icon, %A_AhkPath%
	}
} else {
	Menu, Tray, Icon, %A_ScriptDir%\trrEvery\icon.ico
}

global trrma_bitVar := "64ビット"
global trrma_sign := ""
; 昔の ahkを使う場合
;#Include %A_ScriptDir%\trrEvery\src\var2\newAhk_Gui\startTrrVar2\startUpExecute.ahk
#Include %A_ScriptDir%\trrEvery\src\var2\oldAhk_Gui\startTrrVar2\startUpExecute.ahk

; DetectHiddenWindows を On にしている箇所があるので Off にする。
; startUpExecute.ahk 内で Off にするようにした。
;DetectHiddenWindows, Off


Menu, Tray, Add, テキスト１(&T), enys_SubTrayMenuDefault
Menu, Tray, Add, メインのメニュー(&M), :D_menuMain
Menu, Tray, Add, バージョン情報(&A), enys_SubThisSoftStatus
Menu, Tray, Add
;Menu, Tray, Add, キャンセル(&C), enys_SubCancel
Menu, Tray, Add, TextRunRunの終了(&X), enys_SubExitAppFromMenu
Menu, Tray, NoStandard
Menu, Tray, Default, テキスト１(&T)
Menu, Tray, Click, 1

; init_commWinTitleSet() の後で使用する
Menu, Tray, Tip, %gGlob_GuiAllTitle%

; 引数を入れて起動すると、余計な変数が作られるので、対処する
0 = 0
1 = 1
2 = 2
3 = 3
4 = 4
5 = 5
6 = 6
7 = 7
8 = 8
9 = 9

return				;	ここで念のため１ったん止める。余計なサブルーチンなどが実行されないように

; 昔の ahkを使う場合
;#Include %A_ScriptDir%\trrEvery\src\var2\newAhk_Gui\startTrrVar2\subroutineAndFunction.ahk
#Include %A_ScriptDir%\trrEvery\src\var2\oldAhk_Gui\startTrrVar2\subroutineAndFunction.ahk
