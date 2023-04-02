
#Include %A_ScriptDir%\trrEvery\src\defaultVariable.ahk

#Include %A_ScriptDir%\trrEvery\src\commonTrr\startup\globalCommon.ahk

#Include %A_ScriptDir%\trrEvery\src\commonTrr\startup\startOptionVar.ahk

#Include %A_ScriptDir%\trrEvery\src\global.ahk

#Include %A_ScriptDir%\trrEvery\src\guiGlobal.ahk

#Include %A_ScriptDir%\trrEvery\src\optionVariable\optionVariable.ahk

#Include %A_ScriptDir%\trrEvery\src\beforehandInitSetting.ahk

#Include %A_ScriptDir%\trrEvery\src\easyToUse\easyToUseVariable.ahk

#Include %A_ScriptDir%\trrEvery\src\argsStartCheck.ahk

#Include %A_ScriptDir%\trrEvery\src\newAhk_Gui\guiFactory.ahk

#Include %A_ScriptDir%\trrEvery\src\newAhk_Gui\guiDivideFactory.ahk

#Include %A_ScriptDir%\trrEvery\src\menuFactory.ahk

#Include %A_ScriptDir%\trrEvery\src\newAhk_Gui\textGuiFactory.ahk

#Include %A_ScriptDir%\trrEvery\src\initSetting.ahk

guit_checkErrorLevelOutput_StartUp("起動終了時点でのエラー")
;func_checkErrorLevel_custom( A_LineFile, A_LineNumber )

; 非表示のウインドウを操作
#Include %A_ScriptDir%\trrEvery\src\hiddenWindowControl.ahk

;あえてここで設定する
DetectHiddenWindows, Off

#Include *i %A_ScriptDir%\trrEvery\Plugins\pluginsStartUpExecute.ahk
guit_checkErrorLevelOutput_StartUp("pluginsStartUpExecute.ahk  でのエラー")

#Include *i %A_ScriptDir%\trrEvery\userMakeScript\userMakeStartUpExecute.ahk
guit_checkErrorLevelOutput_StartUp("userMakeStartUpExecute.ahk  でのエラー")

#Include %A_ScriptDir%\trrEvery\src\initUserScriptsExe.ahk
guit_checkErrorLevelOutput_StartUp("起動時に実行する処理でエラーあり")
