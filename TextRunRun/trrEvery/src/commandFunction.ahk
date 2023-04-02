



cof_autohotCommSet(argss, com1, pOut, GuiNum){

	delimiter := ","
	IfInString, argss, %delimiter%
	{
		StringSplit, arg_ , argss , %delimiter% , %A_Space%

		if( cof_autohotComm(arg_1, argss, pOut, GuiNum) ){
			return  True
		}
		if( cof_autohotGuiComm(arg_1, argss, pOut, GuiNum) ){
			return  True
		}
		if( cof_autohotOutPutComm(arg_1, argss, pOut, GuiNum) ){
			return  True
		}
		ansNum := cof_autohotIfConditional(arg_1, argss, pOut, GuiNum, True)
		if( ansNum != 2 ){
			return  True
		}
	}
	if(com1 == "WinMinimizeAll" ) {
		WinMinimizeAll
		return True
	} else if(com1 == "WinMinimizeAllUndo") {
		WinMinimizeAllUndo
		return True
	} else if (com1 == "ListVars") {
		ListVars
		return True
	} else if (com1 == "KeyHistory") {
		KeyHistory
		return True
	} else if (com1 == "ListHotkeys") {
		ListHotkeys
		return True
	} else if (com1 == "Reload") {
		edi_afterCommandExeLogic()
		Reload
		return True
	} else if (com1 == "SplashTextOff") {
		SplashTextOff
		return True
	} else if(com1 == "Exit" ) {
		ahkc_Exit(argss, pOut, GuiNum)
		return True
	} else if(com1 == "ExitApp" ) {
		ahkc_ExitApp(argss, pOut, GuiNum)
		return True
	} else if(com1 == "ListLines" ) {
		ahkc_ListLines(argss, pOut, GuiNum)
		return True
	} else if(com1 == "FileRecycleEmpty" ) {
		ahkc_FileRecycleEmpty(argss, pOut, GuiNum)
		return True
	} else if(com1 == "ToolTip" ) {
		ahkc_ToolTip(argss, pOut, GuiNum)
		return True
	} else if(com1 == "RunAs" ) {
		ahkc_RunAs(argss, pOut, GuiNum)
		return True
	}
	return  False
}

cof_autohotOutPutComm(arg_1, argss, pOut, GuiNum){
	flag := False
	str =
	if(arg_1 == "ControlGet" ) {
		str := ahkc_ControlGet(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "ControlGetText" ) {
		str := ahkc_ControlGetText(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "ControlGetFocus" ) {
		str := ahkc_ControlGetFocus(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "ControlGetPos" ) {
		str := ahkc_ControlGetPos(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "DriveGet" ) {
		str := ahkc_DriveGet(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "FileGetShortcut" ) {
		str := ahkc_FileGetShortcut(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "FileGetAttrib" ) {
		str := ahkc_FileGetAttrib(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "FileGetTime" ) {
		str := ahkc_FileGetTime(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "FileGetVersion" ) {
		str := ahkc_FileGetVersion(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "FileSelectFile" ) {
		str := ahkc_FileSelectFile(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "FileSelectFolder" ) {
		str := ahkc_FileSelectFolder(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "IniRead" ) {
		str := ahkc_IniRead(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "FormatTime" ) {
		str := ahkc_FormatTime(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "SysGet" ) {
		str := ahkc_SysGet(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "WinGet" ) {
		str := ahkc_WinGet(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "WinGetTitle" ) {
		str := ahkc_WinGetTitle(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "WinGetClass" ) {
		str := ahkc_WinGetClass(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "WinGetPos" ) {
		str := ahkc_WinGetPos(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "WinGetActiveStats" ) {
		str := ahkc_WinGetActiveStats(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "WinGetActiveTitle" ) {
		str := ahkc_WinGetActiveTitle(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "StringLen" ) {
		str := ahkc_StringLen(argss, GuiNum)
		flag := True
	} else if(arg_1 == "StringMid" ) {
		str := ahkc_StringMid(argss, GuiNum)
		flag := True
	} else if(arg_1 == "StringSplit" ) {
		str := ahkc_StringSplit(argss, GuiNum)
		flag := True
	} else if(arg_1 == "StringReplace" ) {
		str := ahkc_StringReplace(argss, GuiNum)
		flag := True
	} else if(arg_1 == "StringLower" ) {
		str := ahkc_StringLower(argss, GuiNum)
		flag := True
	} else if(arg_1 == "StringUpper" ) {
		str := ahkc_StringUpper(argss, GuiNum)
		flag := True
	} else if(arg_1 == "StringLeft" ) {
		str := ahkc_StringLeft(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "StringRight" ) {
		str := ahkc_StringRight(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "StringTrimLeft" ) {
		str := ahkc_StringTrimLeft(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "StringTrimRight" ) {
		str := ahkc_StringTrimRight(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "StringGetPos" ) {
		str := ahkc_StringGetPos(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "Sort" ) {
		str := ahkc_Sort(argss, GuiNum)
		flag := True
	} else if(arg_1 == "MouseGetPos" ) {
		str := ahkc_MouseGetPos(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "SoundGet" ) {
		str := ahkc_SoundGet(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "SoundGetWaveVolume" ) {
		str := ahkc_SoundGetWaveVolume(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "InputBox" ) {
		str := ahkc_InputBox(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "EnvGet" ) {
		str := ahkc_EnvGet(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "Random" ) {
		str := ahkc_Random(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "Input" ) {
		str := ahkc_Input(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "DriveSpaceFree" ) {
		str := ahkc_DriveSpaceFree(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "FileGetSize" ) {
		str := ahkc_FileGetSize(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "FileReadLine" ) {
		str := ahkc_FileReadLine(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "RegRead" ) {
		str := ahkc_RegRead(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "PixelGetColor" ) {
		str := ahkc_PixelGetColor(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "ImageSearch" ) {
		str := ahkc_ImageSearch(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "PixelSearch" ) {
		str := ahkc_PixelSearch(argss, pOut, GuiNum)
		flag := True
	} else if(arg_1 == "GetKeyState" ) {
		str := ahkc_GetKeyState(argss, pOut, GuiNum)
		flag := True
	}

	if(flag){
		if(str != ""){
			guit_setExplain(str, GuiNum)
		} else {
			guit_setExplain("値は空", GuiNum)
		}
		return  True
	}
	return  False
}

cof_autohotIfConditional(arg_1, argss, pOut, GuiNum, notMultipleFlag){
	ansNum = 2
	if(arg_1 == "IfEqual"){
		ansNum := ifcah_IfEqual(argss, pOut, GuiNum, notMultipleFlag)
		return ansNum
	} else if(arg_1 == "IfNotEqual" ) {
		ansNum := ifcah_IfNotEqual(argss, pOut, GuiNum, notMultipleFlag)
		return ansNum
	} else if(arg_1 == "IfGreater" ) {
		ansNum := ifcah_IfGreater(argss, pOut, GuiNum, notMultipleFlag)
		return ansNum
	} else if(arg_1 == "IfGreaterOrEqual" ) {
		ansNum := ifcah_IfGreaterOrEqual(argss, pOut, GuiNum, notMultipleFlag)
		return ansNum
	} else if(arg_1 == "IfLess" ) {
		ansNum := ifcah_IfLess(argss, pOut, GuiNum, notMultipleFlag)
		return ansNum
	} else if(arg_1 == "IfLessOrEqual" ) {
		ansNum := ifcah_IfLessOrEqual(argss, pOut, GuiNum, notMultipleFlag)
		return ansNum
	} else if(arg_1 == "IfWinActive" ) {
		ansNum := ifcah_IfWinActive(argss, pOut, GuiNum, notMultipleFlag)
		return ansNum
	} else if(arg_1 == "IfWinNotActive" ) {
		ansNum := ifcah_IfWinNotActive(argss, pOut, GuiNum, notMultipleFlag)
		return ansNum
	} else if(arg_1 == "IfWinExist" ) {
		ansNum := ifcah_IfWinExist(argss, pOut, GuiNum, notMultipleFlag)
		return ansNum
	} else if(arg_1 == "IfWinNotExist" ) {
		ansNum := ifcah_IfWinNotExist(argss, pOut, GuiNum, notMultipleFlag)
		return ansNum
	} else if(arg_1 == "IfExist" ) {
		ansNum := ifcah_IfExist(argss, pOut, GuiNum, notMultipleFlag)
		return ansNum
	} else if(arg_1 == "IfNotExist" ) {
		ansNum := ifcah_IfNotExist(argss, pOut, GuiNum, notMultipleFlag)
		return ansNum
	} else if(arg_1 == "IfMsgBox" ) {
		ansNum := ifcah_IfMsgBox(argss, pOut, GuiNum, notMultipleFlag)
		return ansNum
	} else if(arg_1 == "IfInString" ) {
		ansNum := ifcah_IfInString(argss, pOut, GuiNum, notMultipleFlag)
		return ansNum
	} else if(arg_1 == "IfNotInString" ) {
		ansNum := ifcah_IfNotInString(argss, pOut, GuiNum, notMultipleFlag)
		return ansNum
	}
	return  ansNum
}

cof_autohotGuiComm(arg_1, argss, pOut, GuiNum){
	if(arg_1 == "Gui"){
		ahkc_Gui(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "GuiControlGet" ) {
		ahkc_GuiControlGet(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "GuiControl" ) {
		ahkc_GuiControl(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "Progress" ) {
		ahkc_Progress(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SplashImage" ) {
		ahkc_SplashImage(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SplashTextOn" ) {
		ahkc_SplashTextOn(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SplashTextOff" ) {
		SplashTextOff
		return True
	} else if(arg_1 == "TrayTip" ) {
		ahkc_TrayTip(argss, pOut, GuiNum)
		return True
	}
	return  False
}

cof_autohotComm(arg_1, argss, pOut, GuiNum){
	if(arg_1 == "WinClose"){
		ahkc_WinClose(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "WinActivate" ) {
		ahkc_WinActivate(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "WinWait" ) {
		ahkc_WinWait(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "WinWaitActive" ) {
		ahkc_WinWaitActive(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "WinWaitClose" ) {
		ahkc_WinWaitClose(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "WinWaitNotActive" ) {
		ahkc_WinWaitNotActive(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "WinMove" ) {
		ahkc_WinMove(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "ControlSend" ) {
		ahkc_ControlSend(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "Control" ) {
		ahkc_Control(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "ControlFocus" ) {
		ahkc_ControlFocus(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "ControlMove" ) {
		ahkc_ControlMove(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "ControlSetText" ) {
		ahkc_ControlSetText(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "Drive" ) {
		ahkc_Drive(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "WinShow" ) {
		ahkc_WinShow(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "EnvSet" ) {
		guit_appendExplain("このソフトでは`nEnvSet は現時点では用意していない。")
		return True
	} else if(arg_1 == "SetEnv" ) {
		ahkc_SetEnv(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "Send" ) {
		ahkc_Send(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SendRaw" ) {
		ahkc_SendRaw(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SendInput" ) {
		ahkc_SendInput(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SendPlay" ) {
		ahkc_SendPlay(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SendEvent" ) {
		ahkc_SendEvent(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SendMode" ) {
		ahkc_SendMode(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "BlockInput" ) {
		ahkc_BlockInput(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "ControlClick" ) {
		ahkc_ControlClick(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "Run" ) {
		ahkc_Run(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "RunWait" ) {
		ahkc_RunWait(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "RunAs" ) {
		ahkc_RunAs(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "Process" ) {
		ahkc_Process(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "WinMinimizeAll" ) {
		WinMinimizeAll
		return True
	} else if(arg_1 == "WinMinimizeAllUndo" ) {
		WinMinimizeAllUndo
		return True
	} else if (arg_1 == "ListVars") {
		ListVars
		return True
	} else if (arg_1 == "KeyHistory") {
		KeyHistory
		return True
	} else if (arg_1 == "ListHotkeys") {
		ListHotkeys
		return True
	} else if (arg_1 == "Reload") {
		Reload
		return True
	} else if(arg_1 == "ListLines" ) {
		ahkc_ListLines(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "OutputDebug" ) {
		ahkc_OutputDebug(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "ClipWait" ) {
		ahkc_ClipWait(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "WinHide" ) {
		ahkc_WinHide(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "WinKill" ) {
		ahkc_WinKill(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "WinSet" ) {
		ahkc_WinSet(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "WinSetTitle" ) {
		ahkc_WinSetTitle(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "GroupAdd" ) {
		ahkc_GroupAdd(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "GroupActivate" ) {
		ahkc_GroupActivate(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "GroupClose" ) {
		ahkc_GroupClose(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "GroupDeactivate" ) {
		ahkc_GroupDeactivate(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "StatusBarGetText" ) {
		ahkc_StatusBarGetText(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "FileSetAttrib" ) {
		ahkc_FileSetAttrib(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "FileRemoveDir" ) {
		ahkc_FileRemoveDir(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "FileCreateDir" ) {
		ahkc_FileCreateDir(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "FileRecycle" ) {
		ahkc_FileRecycle(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "FileRecycleEmpty" ) {
		ahkc_FileRecycleEmpty(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "FileDelete" ) {
		ahkc_FileDelete(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "FileRead" ) {
		ahkc_FileRead(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SplitPath" ) {
		ahkc_SplitPath(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "FileEncoding" ) {
		ahkc_FileEncoding(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "BlockInput" ) {
		ahkc_BlockInput(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "WinGetText" ) {
		ahkc_WinGetText(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "WinMenuSelectItem" ) {
		ahkc_WinMenuSelectItem(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "DetectHiddenWindows" ) {
		ahkc_DetectHiddenWindows(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "DetectHiddenText" ) {
		ahkc_DetectHiddenText(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SetTitleMatchMode" ) {
		ahkc_SetTitleMatchMode(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SetWinDelay" ) {
		ahkc_SetWinDelay(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "CoordMode" ) {
		ahkc_CoordMode(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "AutoTrim" ) {
		ahkc_AutoTrim(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "WinActivateBottom" ) {
		ahkc_WinActivateBottom(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "WinMaximize" ) {
		ahkc_WinMaximize(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "WinMinimize" ) {
		ahkc_WinMinimize(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "WinRestore" ) {
		ahkc_WinRestore(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "StatusBarWait" ) {
		ahkc_StatusBarWait(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SetControlDelay" ) {
		ahkc_SetControlDelay(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "Pause" ) {
		ahkc_Pause(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "Gosub" ) {
		ahkc_Gosub(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SetTimer" ) {
		ahkc_SetTimer(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "Menu" ) {
		ahkc_Menu(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SoundPlay" ) {
		ahkc_SoundPlay(argss, GuiNum)
		return True
	} else if(arg_1 == "SoundBeep" ) {
		ahkc_SoundBeep(argss, GuiNum)
		return True
	} else if(arg_1 == "SetWorkingDir" ) {
		ahkc_SetWorkingDir(argss, GuiNum)
		return True
	} else if(arg_1 == "FileCopyDir" ) {
		ahkc_FileCopyDir(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "FileMoveDir" ) {
		ahkc_FileMoveDir(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "FileCopy" ) {
		ahkc_FileCopy(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "FileMove" ) {
		ahkc_FileMove(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "FileAppend" ) {
		ahkc_FileAppend(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "FileCreateShortcut" ) {
		ahkc_FileCreateShortcut(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "FileSetTime" ) {
		ahkc_FileSetTime(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "IniWrite" ) {
		ahkc_IniWrite(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "IniDelete" ) {
		ahkc_IniDelete(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "EnvAdd" ) {
		ahkc_EnvAdd(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "EnvSub" ) {
		ahkc_EnvSub(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "EnvMult" ) {
		ahkc_EnvMult(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "EnvDiv" ) {
		ahkc_EnvDiv(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SetFormat" ) {
		ahkc_SetFormat(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "Transform" ) {
		ahkc_Transform(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "Shutdown" ) {
		ahkc_Shutdown(argss, GuiNum)
		return True
	} else if(arg_1 == "URLDownloadToFile" ) {
		ahkc_URLDownloadToFile(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "ToolTip" ) {
		ahkc_ToolTip(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "MsgBox" ) {
		ahkc_MsgBox(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SoundSetWaveVolume" ) {
		ahkc_SoundSetWaveVolume(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "Hotkey" ) {
		ahkc_Hotkey(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "Sleep" ) {
		ahkc_Sleep(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "Suspend" ) {
		ahkc_Suspend(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "Exit" ) {
		ahkc_Exit(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "ExitApp" ) {
		ahkc_ExitApp(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "OnExit" ) {
		ahkc_OnExit(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "StringCaseSense" ) {
		ahkc_StringCaseSense(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "KeyWait" ) {
		ahkc_KeyWait(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "PostMessage" ) {
		ahkc_PostMessage(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SendMessage" ) {
		ahkc_SendMessage(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "MouseMove" ) {
		ahkc_MouseMove(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "MouseClick" ) {
		ahkc_MouseClick(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "MouseClickDrag" ) {
		ahkc_MouseClickDrag(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "Click" ) {
		ahkc_Click(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SetKeyDelay" ) {
		ahkc_SetKeyDelay(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SetStoreCapslockMode" ) {
		ahkc_SetStoreCapslockMode(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SetCapsLockState" ) {
		ahkc_SetCapsLockState(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SetScrollLockState" ) {
		ahkc_SetScrollLockState(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SetNumLockState" ) {
		ahkc_SetNumLockState(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SetMouseDelay" ) {
		ahkc_SetMouseDelay(argss, pOut, GuiNum)
		return True
	} else if(arg_1 == "SetDefaultMouseSpeed" ) {
		ahkc_SetDefaultMouseSpeed(argss, pOut, GuiNum)
		return True
	}
	return False
}

; 条件文かどうかを確認して、実行
cof_ifConditional(com1, com2, com3, com4, com5, com6, com7, editAll, hwnd, pOut, GuiNum){
	if( ifco_hatenaSentence(com1, com2, com3, com4, com5, editAll, hwnd, pOut, GuiNum) ){
		return True
	}

	StringLower, com1Lower, com1
	if(com1Lower == "if"){
		ansNum := ifcah_ifSentenceAhkVersion(com2, com3, com4, com5, com6, com7, editAll, hwnd, pOut, GuiNum, True)
		if( ansNum != 2 ){
			return True
		}
	}

	ansNum := ifco_ifSentence(com1, com2, com3, com4, com5, editAll, hwnd, pOut, GuiNum, True)
	if( ansNum != 2 ){
		return True
	}

	return False
}

; 引数２が = や := なら代入する。 もしくは、計算式があったら計算する
cof_equalSubstitutionCommand(com1, com2, com3, com4, com5, com6, editAll, pOut, GuiNum){
	if(com2 == "=" ) {
		ifco_equalSubstitution(com1, editAll, GuiNum, False, "", False)
		return True
	} else if(com2 == ":=" ) {
		ifco_colonEqualSubstitution(com1, editAll, GuiNum, False, "")
		return True
	} else if(com2 == "+=" ) {
		ifco_anyEqualSubstitution(com1, com2, editAll, GuiNum, 1)
		return True
	} else if(com2 == "-=" ) {
		ifco_anyEqualSubstitution(com1, com2, editAll, GuiNum, 2)
		return True
	} else if(com2 == "*=" ) {
		ifco_anyEqualSubstitution(com1, com2, editAll, GuiNum, 3)
		return True
	} else if(com2 == "/=" ) {
		ifco_anyEqualSubstitution(com1, com2, editAll, GuiNum, 4)
		return True
	} else if(com2 == "//=" ) {
		ifco_anyEqualSubstitution(com1, com2, editAll, GuiNum, 5)
		return True
	} else if(com2 == ".=" ) {
		ifco_stringEqualSubstitution(com1, com2, editAll, GuiNum)
		return True
	}

	if(com1 == "global" ) {
		; %変数名% も textOut して使えるようにする
		com2TextOut := outs_textOutTrimss(com2)
		if(com2TextOut == ""){
			guit_errorAppend("global宣言のエラー。`n変数がカラになっている`n" . editAll)
			return True
		}

		; global 宣言をしてる場合は２度目以降はスルーする、裏技的な使い方で使える
		; ただ、今は使わない
		;if( ifco_globalVarExist(com2TextOut) ){
		;	guit_errorAppend("global宣言のエラー。`n変数がすでに存在している。代入は中止している`n" . editAll)
		;	return True
		;}
		com2Value := %com2TextOut%
		if(com2Value != ""){
			;guit_errorAppend("global宣言のエラー。`n変数がすでに存在している。代入は中止している`n" . editAll)
			guit_setExplain("global宣言のエラー。`n変数がすでに存在している。代入は中止している`n" . editAll, GuiNum)
			return True
		}

		if(com3 == "=" ) {
			rStr := func_separationSpaceRightOrNull(editAll)
			ifco_globalVarMake(com2TextOut)
			ifco_equalSubstitution(com2, rStr, GuiNum, True, com2Value, False)
		} else if(com3 == ":=" ) {
			rStr := func_separationSpaceRightOrNull(editAll)
			ifco_globalVarMake(com2TextOut)
			ifco_colonEqualSubstitution(com2, rStr, GuiNum, True, com2Value)
		} else if(com3 == "" ) {
			; com3 が カラなら、初期値を指定しない global宣言 になる
			; 右に = をプラスするだけ
			rStr := func_separationSpaceRightOrNull(editAll)
			ifco_globalVarMake(com2TextOut)
			ifco_equalSubstitution(com2, rStr, GuiNum, True, com2Value, True)
		} else {
			; com3 に文字列がある場合は、global宣言と解釈できない
			guit_errorAppend("global宣言のエラー。`n以下の文はglobal宣言と解釈できない。`n" . editAll)
		}
		return True
	}

	if( ifco_isEnyOperationAll(com2) ){
		if(com3 != ""){
			answer := ifco_answerFromOperationAll(com1, com2, com3, com4, editAll, True)
			if(answer != ""){
				guit_setExplain(answer, GuiNum)
				return True
			}
		}
	}
	; V_var++  -V_var  !V_var  ~V_var  not V_var  の処理
	res := ifco_anySimplexOperationExe(com1, com2, False, GuiNum, 1, editAll)
	if( res == 1 ){
		return True
	}

	return False
}

; 入力補完を表示させる系のコマンド
cof_syscommandPopup(com1, pOut, GuiNum) {
	if(com1 == "&popList" ) {
		edc_popupShowEditType(GuiNum, 1, 2)
		return True
	} else if(com1 == "&popItemSoftList" ) {
		edc_popupShowEditType(GuiNum, 2, 2)
		return True
	} else if(com1 == "&popFileList" ) {
		edc_popupShowEditType(GuiNum, 3, 2)
		return True
	} else if(com1 == "&popItemFolderList" ) {
		edc_popupShowEditType(GuiNum, 4, 2)
		return True
	} else if(com1 == "&popItemScriptList" ) {
		edc_popupShowEditType(GuiNum, 5, 2)
		return True
	} else if(com1 == "&popHistoryList" ) {
		edc_popupShowEditType(GuiNum, 6, 2)
		return True
	} else if(com1 == "&popHistoryFilterList" ) {
		edc_popupShowEditType(GuiNum, 7, 2)
		return True
	} else if(com1 == "&popAddWordFilterList" ) {
		edc_popupShowEditType(GuiNum, 8, 2)
		return True
	} else if(com1 == "&popSpecialWordList" ) {
		edc_popupShowEditType(GuiNum, 9, 2)
		return True
	} else if(com1 == "&hideInputList" ) {
		edc_commListHideEnyType(GuiNum)
		return True
	} else if(com1 == "&hideInputListExecutor" ) {
		edc_commListHideEnyType(A_Gui)
		return True
	} else if(com1 == "&inputListSelectOnly" ) {
		lasw_inputListSelectOnly(GuiNum)
		return True
	} else if(com1 == "&outArgsTestType1" ) {
		syf_outArgsTestType1(pOut, GuiNum)
		return True
	}

	if( uptype1_plusPopupCommand(com1, pOut, GuiNum) ){
		return True
	}

	return  False
}

; フォーカス位置で動作が変わるコマンド
cof_syscommandEarly(com1, com2, pOut, hwnd, GuiNum) {
	if(com1 == "&doubleQuoute" ) {
		craf_commanddoubleQuoute(com2, pOut, hwnd, GuiNum)
		return True
	} else if(com1 == "&doubleQuouteCustom" ) {
		craf_doubleQuouteCustomComm(com2, True, True, pOut, hwnd, GuiNum)
		return True
	} else if(com1 == "&fullPathAll" ) {
		craf_fullPathAll(com2, False, False, pOut, hwnd, GuiNum)
		return True
	} else if(com1 == "&relativePath" ) {
		craf_RelativePathComm(com2, pOut, hwnd, GuiNum)
		return True
	} else if(com1 == "&parsentss" ) {
		craf_commandparsentss(com2, pOut, hwnd, GuiNum)
		return True
	} else if(com1 == "&sharpss" ) {
		craf_commandsharpss(com2, pOut, hwnd, GuiNum)
		return True
	} else if(com1 == "&sharpssCustom" ) {
		craf_commandsharpssCustom(com2, pOut, hwnd, GuiNum)
		return True
	} else if(com1 == "&backOneDir" ) {
		craf_commandListOuttoDir(com2, pOut, hwnd, GuiNum)
		return True
	} else if(com1 == "&reBackOneDir" ) {
		craf_OuttoDirBackComm(pOut, hwnd, GuiNum)
		return True
	} else if(com1 == "&fullPath" ) {
		craf_FullPathComm(com2, pOut, hwnd, GuiNum)
		return True
	} else if(com1 == "&lastAsHead" ) {
		craf_useAsHead(com2, pOut, hwnd, GuiNum)
		return True
	} else if(com1 == "&lastAsHeadExecute" ) {
		edi_lastAsHeadExecute(com2, pOut, hwnd, GuiNum)
		return True
	} else if(com1 == "&textOut" ) {
		craf_commandtextOut(com2, pOut, hwnd, GuiNum)
		return True
	} else if (com1 == "&menuShow") {
		syf_menuShow(com2)
		return True
	} else if(com1 == "&pathLink" ) {
		craf_sysCommandpath( com2, pOut, hwnd, GuiNum )
		return True
	} else if(com1 == "&getValue" ) {
		craf_commandvarGet(com2, pOut, hwnd, GuiNum)
		return True
	} else if(com1 == "&fileDialog" ) {
		edi_FileDialog(com2, pOut, hwnd, GuiNum)
		return True
	} else if(com1 == "&folderDialog" ) {
		edi_FolderDialog(com2, pOut, hwnd, GuiNum)
		return True
	} else if(com1 == "&snippetOpen" ) {
		cinp_snippetOpen(com2, pOut, hwnd, GuiNum)
		return True
	} else if(com1 == "&outArgsTestType2" ) {
		syf_outArgsTestType2_3_5(com2, pOut, GuiNum)
		return True
	}

	if( uptype2_plusDifferentByFocusCommand(com1, com2, pOut, hwnd, GuiNum) ){
		return True
	}
	
	return  False
}

; 早めに実行したいコマンド。履歴に加えない
cof_syscommandBefore(com1, rightStr, pOut, GuiNum) {
	if (com1 == "&newItem") {
		excof_sysCommandnew(rightStr, pOut, GuiNum)
		return True
	} else if (com1 == "&editItem") {
		cen_sysCommandeditCommand(rightStr, pOut, GuiNum)
		return True
	} else if (com1 == "&hotkeyOnTextNew") {
		hotk_HotkeyNew(rightStr, pOut, GuiNum)
		return True
	} else if (com1 == "&hotkeyOnTextEdit") {
		hoit_HotkeyEdit(rightStr)
		return True
	} else if(com1 == "&enterForLastWord" ) {
		lasw_enterForLastWord(com1, GuiNum)
		return True
	} else if (com1 == "&cleanTextEasy") {
		edc_cleanEditEasy(pOut, GuiNum)
		return True
	} else if (com1 == "&cleanText") {
		edc_cleanEditAssign(A_Gui, "", GuiNum)
		return True
	} else if(com1 == "&stockAddBlue" ) {
		edi_addStockLogic(rightStr, 77, pOut, GuiNum)
		return True
	} else if(com1 == "&stockAddGreen" ) {
		edi_addStockLogic(rightStr, 78, pOut, GuiNum)
		return True
	} else if(com1 == "&more" ) {
		linu_more(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&moreTextOut" ) {
		rightStr := outs_textOutTrimss(rightStr)
		; `n などを改行に変える。でも止める
		;Transform, rightStr, Deref, %rightStr%
		linu_more(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&outArgsToOutGuiAddLinefeed" ) {
		time := func_getHourMinSec()
		guit_appendBoxEdit66_1(time  . "`n" . rightStr)
		return True
	} else if(com1 == "&outArgsToTmpOutGui" ) {
		guit_setBoxEdit68_1CustSingle(rightStr)
		return True
	} else if(com1 == "&outArgsToTextEditExecutor" ) {
		edc_outTextToTextExecutor(rightStr, GuiNum, False)
		return True
	} else if(com1 == "&outArgsToTextEditExecutorTextOut" ) {
		edc_outTextToTextExecutor(rightStr, GuiNum, True)
		return True
	} else if(com1 == "&outArgsToTextGuiAssign" ) {
		edi_outTextToTextGuiAssign(rightStr, GuiNum, False, False)
		return True
	} else if(com1 == "&outArgsToTextGuiAssignTextOut" ) {
		edi_outTextToTextGuiAssign(rightStr, GuiNum, True, False)
		return True
	} else if(com1 == "&outArgsToTextGuiAssignAdd" ) {
		edi_outTextToTextGuiAssign(rightStr, GuiNum, False, True)
		return True
	} else if(com1 == "&outArgsToTextGuiAssignAddTextOut" ) {
		edi_outTextToTextGuiAssign(rightStr, GuiNum, True, True)
		return True
	} else if(com1 == "&outArgsToMultipleText1AddLinefeed" ) {
		guf_appendBoxEditBasisPlan(rightStr, "BoxEdit82_1", 82)
		guf_showGuiAssign(82, "NA")
		return True
	} else if(com1 == "&outArgsToMultipleText1AddLinefeedTextOut" ) {
		rightStr := outs_textOutTrimss(rightStr)
		Transform, rightStr, Deref, %rightStr%
		guf_appendBoxEditBasisPlan(rightStr, "BoxEdit82_1", 82)
		guf_showGuiAssign(82, "NA")
		return True
	} else if(com1 == "&outOutGuiToOutFileAddLinefeed" ) {
		syf_OutOutGuiToFile(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&outArgsToOutFileAddLinefeed" ) {
		; `n の文字列を改行に置換。でも止める
		;rightStr := func_linefeedReplace(rightStr)
		syf_OutCommToOutFile(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&outTmpOutGuiToText" ) {
		syf_OutTmpOutGuiToComm(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&outTmpOutGuiToTmpFile" ) {
		syf_OutTmpOutGuiToTmpFile(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&outTmpOutGuiToOutFileAddLinefeed" ) {
		syf_outTmpOutGuiToOutFile(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&outTmpOutGuiToOutGuiAddLinefeed" ) {
		syf_OutTmpOutGuiToOutGui(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&outArgsToOutGuiAddLinefeedTextOut" ) {
		rightStr := outs_textOutTrimss(rightStr)
		; `n などを改行に変える。でも止める
		;Transform, rightStr, Deref, %rightStr%
		time := func_getHourMinSec()
		guit_appendBoxEdit66_1(time  . "`n" . rightStr)
		return True
	} else if(com1 == "&outArgsToTmpOutGuiTextOut" ) {
		rightStr := outs_textOutTrimss(rightStr)
		; `n などを改行に変える。でもやめる
		;Transform, rightStr, Deref, %rightStr%
		guit_setBoxEdit68_1CustSingle(rightStr)
		return True
	} else if(com1 == "&outArgsToOutFileAddLinefeedTextOut" ) {
		rightStr := outs_textOutTrimss(rightStr)
		; `n などを改行に変える。でも止める
		;Transform, rightStr, Deref, %rightStr%
		syf_OutCommToOutFile(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&outArgsToFileAssignAddLinefeed" ) {
		syf_OutTextToFileAssign(rightStr, GuiNum, False)
		return True
	} else if(com1 == "&outArgsToFileAssignAddLinefeedTextOut" ) {
		syf_OutTextToFileAssign(rightStr, GuiNum, True)
		return True
	} else if(com1 == "&outOutFileToFileGui" ) {
		syf_OutFileToFileGui(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&outErrGuiToErrFileAddLinefeed" ) {
		syf_OutErrGuiToErrFile(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&outErrFileToFileGui" ) {
		syf_OutErrFileToFileGui(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&newMultipleItem" ) {
		musc_newMultiple(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&sendPaste" ) {
		cinp_sendPaste(rightStr, GuiNum, False)
		return True
	} else if(com1 == "&sendPasteTextOut" ) {
		cinp_sendPaste(rightStr, GuiNum, True)
		return True
	} else if(com1 == "&sendPasteFromFile" ) {
		cinp_sendPasteFromFile(rightStr, GuiNum, False)
		return True
	} else if(com1 == "&sendPasteFromFileTextOut" ) {
		cinp_sendPasteFromFile(rightStr, GuiNum, True)
		return True
	} else if(com1 == "&sendTextItself" ) {
		cinp_sendTextItself(rightStr, GuiNum)
		return True
	} else if(com1 == "&sendScriptToText" ) {
		edi_sendScriptToText(rightStr, GuiNum)
		return True
	} else if(com1 == "&sendEndToTextEditExecutor" ) {
		edc_sendEndToTextEditExecutor(rightStr, GuiNum)
		return True
	} else if(com1 == "&outArgsTestType3" ) {
		syf_outArgsTestType2_3_5(rightStr, pOut, GuiNum)
		return True
	}

	if( uptype3_notSaveHistoryCommand(com1, rightStr, pOut, GuiNum) ){
		return True
	}

	return  False
}

; &&& を特殊に使う。そして、 >>> を使った処理は実行させたい。
cof_sysCommSpecial(com1, rightStr, editAll, rightStrAll, hwnd, pOut, GuiNum, historyStr, andFlag, outPutSucceedFlag){
	; 関数の文字列が書かれていたら実行するようにする
	advice := ahkc_isFuncStr(editAll)
	if( advice == null ) {
		returnValue := ahkc_GoFunc_sub(editAll)
		guit_checkErrorLevelOutput("関数のエラー`n" . editAll)
		; 返り値があれば表示する
		if(returnValue != ""){
			guit_setExplainNotShow(returnValue, GuiNum)
		}
		return  True
	}

	if(com1 == "&goFunc"  ){
		ahkc_GoFunc(editAll, rightStrAll, hwnd, pOut, GuiNum, outPutSucceedFlag)
		edi_historyInsert(historyStr, hwnd, andFlag)
		return True
	} else if(com1 == "&wait"  ){
		linu_sleep(rightStr, pOut, GuiNum, outPutSucceedFlag)
		edi_historyInsert(historyStr, hwnd, andFlag)
		return True
	} else if(com1 == "&timer"){
		linu_at(rightStr, pOut, GuiNum, outPutSucceedFlag)
		edi_historyInsert(historyStr, hwnd, andFlag)
		return True
	} else if(com1 == "&collabText" ) {
		edi_collabEdit(rightStr, pOut, GuiNum, outPutSucceedFlag)
		return True
	} else if(com1 == "&multiplelineExe") {
		musc_multiplelineExe(rightStr, pOut, GuiNum, outPutSucceedFlag)
		edi_historyInsert(historyStr, hwnd, andFlag)
		return True
	} else if(com1 == "&outArgsTestType4") {
		syf_outArgsTestType4(rightStr, editAll, rightStrAll, hwnd, pOut, GuiNum)
		return True
	}

	if( uptype4_specialCommand(com1, rightStr, editAll, pOut, GuiNum, historyStr, andFlag) ){
		return True
	}

	return  False
}

; 早めに実行したいが、履歴には残したいコマンド。textOutもしている
cof_sysNotSplit(com1, rightStr, pOut, GuiNum){
	if(com1 == "&readFile" ) {
		linu_readFile(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&stockExeAllBlue" ) {
		edi_stockExeAllBlue(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&stockExeAllGreen" ) {
		edi_stockExeAllGreen(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&shutdown" ) {
		linu_shutdownTimeSet(rightStr, 1, GuiNum)
		return True
	} else if(com1 == "&shutdown_r" ) {
		linu_shutdownTimeSet(rightStr, 2, GuiNum)
		return True
	} else if(com1 == "&logoff" ) {
		linu_shutdownTimeSet(rightStr, 3, GuiNum)
		return True
	} else if(com1 == "&mkdir" ) {
		syf_sysCommandmkdir(rightStr, GuiNum)
		return True
	} else if (com1 == "&deleteItem") {
		ite_sysCommanddeleteCommand(rightStr, pOut, GuiNum)
		return True
	} else if (com1 == "&hotkeyOnTextDelete") {
		hoit_HotkeyDelete(rightStr, pOut, GuiNum)
		return True
	} else if (com1 == "&snippetDelete") {
		cinp_snippetDelete(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&cd" ) {
		syf_currentDirChange( rightStr, pOut, GuiNum )
		return True
	} else if(com1 == "&cdmydocu" ) {
		syf_cdmydocuComm(pOut, GuiNum)
		return True
	} else if(com1 == "&cdmain" ) {
		syf_cdmainComm(pOut, GuiNum)
		return True
	} else if (com1 == "&ls") {
		syf_sysCommandls(rightStr, GuiNum)
		return True
	} else if(com1 == "&cmd" ) {
		syf_cmdCommand(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&shortCutPath" ) {
		edi_shortCutPath(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&multiplelineExeFromFile" ) {
		musc_multiplelineExeFromFile(rightStr, pOut, GuiNum)
		return True
	} else if(com1 == "&addWordListAddFromFile" ) {
		cen_userMakeWordAddFromFile(rightStr, GuiNum)
		return True
	} else if(com1 == "&snippetAddFromFile" ) {
		cen_snippetAddFromFile(rightStr, GuiNum)
		return True
	} else if(com1 == "&guiShow" ) {
		edc_guiShow(rightStr, GuiNum)
		return True
	} else if(com1 == "&guiHideTextExecutor" ) {
		edi_guiHideTextExecutor(rightStr)
		return True
	} else if(com1 == "&guiShowWaitExecutor" ) {
		guit_guiShowWaitExecutor(rightStr, GuiNum)
		return True
	} else if(com1 == "&guiHideAndShowWaitExecutor" ) {
		guit_guiHideAndShowWaitExecutor(rightStr, GuiNum)
		return True
	} else if(com1 == "&itemReloadAll" ) {
		cen_itemReloadAll(rightStr, GuiNum)
		return True
	} else if(com1 == "&cleanTextExecutor" ) {
		edc_cleanEditAssign(A_Gui, "", GuiNum)
		return True
	} else if(com1 == "&outArgsTestType5" ) {
		syf_outArgsTestType2_3_5(rightStr, pOut, GuiNum)
		return True
	}

	if( uptype5_argNotSplitSpaceCommand(com1, rightStr, pOut, GuiNum) ){
		return True
	}

	return  False
}

cof_syscommandExecute(com1, com2, com3, com4, com5, com6, com7, pOut, GuiNum) {
	if(com1 == "&pctime" ) {
		pctimeVar := func_timeFromPcStart()
		guit_setExplainPurpose(pctimeVar, GuiNum)
		return True
	} else if(com1 == "&setValue" ) {
		craf_setValue(com2, com3, pOut, GuiNum)
		return True
	} else if(com1 == "&setValueTmpOutGui" ) {
		craf_setValueTmpOutGui(com2, com3, pOut, GuiNum)
		return True
	} else if(com1 == "&setValueMultipleText1" ) {
		guaf_setValueMultipleText(com2, GuiNum)
		return True
	} else if(com1 == "&getObj" ) {
		craf_ObjGet(com2, com3, com4, com5, com6, pOut, GuiNum)
		return True
	} else if(com1 == "&returnOutputGui" ) {
		guaf_returnBoxEdit66_1()
		return True
	} else if(com1 == "&pwd" ) {
		guit_setExplainPurpose(A_WorkingDir, GuiNum)
		return True
	} else if(com1 == "&relativeAssign" ) {
		craf_RelativeAssignComm(com2, com3, pOut, GuiNum)
		return True
	} else if(com1 == "&fullPathAssign" ) {
		craf_FullPathAssignComm(com2, com3, pOut, GuiNum)
		return True
	} else if(com1 == "&winCapture" ) {
		excof_windowCaptureItemFromComm(com2, pOut, GuiNum)
		return True
	} else if(com1 == "&timerView" ) {
		timf_showGui87_autoClose("NA")
		return True
	} else if(com1 == "&timerStop" ) {
		timf_stopTimer(com2, com3, pOut, GuiNum)
		return True
	} else if(com1 == "&stockChangeBlue" ) {
		syf_changeStockBlue(com2, com3, pOut, GuiNum)
		return True
	} else if(com1 == "&stockChangeGreen" ) {
		syf_changeStockGreen(com2, com3, pOut, GuiNum)
		return True
	} else if(com1 == "&stockSaveBlue" ) {
		chec_stockSaveOnCommand("ListBox77_1", "Edit77_11", 77, gloco_userDir . glob_commStockFile77Name)
		return True
	} else if(com1 == "&stockSaveGreen" ) {
		chec_stockSaveOnCommand("ListBox78_1", "Edit78_11", 78, gloco_userDir . glob_commStockFile78Name)
		return True
	} else if(com1 == "&tmpDelete" ) {
		intchf_tmpDelete(com2, pOut, GuiNum)
		return True
	} else if(com1 == "&config" ) {
		syf_configCommand(com2, com3, pOut, GuiNum)
		return True
	} else if(com1 == "&startupFlag" ) {
		syf_startupFlagCommand(com2, GuiNum)
		return True
	} else if(com1 == "&outArgsTestType6" ) {
		syf_outArgsTestType6(com2, com3, com4, com5, com6, com7, GuiNum)
		return True
	} else if(com1 == "&hotkeyOnTextNewFromCommand" ) {
		hotk_hotkeyOnTextFromCommand(com2, com3, pOut, GuiNum)
		return True
	} else if(com1 == "&newItemFromCommand" ) {
		musc_newItemFromCommand(com2, com3, com4, com5, com6, com7, GuiNum)
		return True
	} else if(com1 == "&itemReloadOneFromFileName" ) {
		cen_itemReloadOneFromFileName(com2, com3, com4, GuiNum)
		return True
	} else if(com1 == "&cleanTextAssign" ) {
		edc_cleanEditAssign(com2, com3, GuiNum)
		return True
	} else if(com1 == "&addWordListAdd" ) {
		cen_userMakeWordAdd(com2, com3, GuiNum)
		return True
	} else if(com1 == "&snippetAdd" ) {
		cinp_snippetAdd(com2, com3, com4, com5, GuiNum)
		return True
	}


	if( uptype6_argSplitSpaceCommand(com1, com2, com3, com4, com5, com6, com7, pOut, GuiNum) ){
		return True
	}

	return False
}

