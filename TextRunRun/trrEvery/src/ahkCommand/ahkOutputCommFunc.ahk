; 必須 glob  guf  func


ahkc_FormatTime(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg4 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg3 != ""){
		FormatTime, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		FormatTime, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != ""){
		FormatTime, %glob_ahkArg1%
	} else {
		str := "FormatTime, OutputVar [, YYYYMMDDHH24MISS, Format]"
		return  str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	str := %glob_ahkArg1%
	return  str
}

ahkc_SysGet(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg4 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg3 != ""){
		SysGet, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		SysGet, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "SysGet, OutputVar, Sub-command [, Param3]"
		return  str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	str =
	if(glob_ahkArg2 == "Monitor"){
		str .= "Left   " . %glob_ahkArg1%Left  . "`n"
		str .= "Right  " . %glob_ahkArg1%Right  . "`n"
		str .= "Top    " . %glob_ahkArg1%Top  . "`n"
		str .= "Bottom " . %glob_ahkArg1%Bottom
	} else {
		str := %glob_ahkArg1%
	}
	return  str
}

ahkc_ControlGet(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg7 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg6 != "") {
		ControlGet , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != "") {
		ControlGet , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		ControlGet , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		ControlGet , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		ControlGet , %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "ControlGet, OutputVar, Cmd [, Value, Control, WinTitle, WinText, ExcludeTitle, ExcludeText]`nChecked  Enabled  Visible  Tab  FindString,String  Choice`nList  List,(option)`n  Count  ColN  Selected  Focused  Count Col`nLineCount  CurrentLine  CurrentCol  Line,N  Selected  Style  ExStyle  Hwnd"
		return  str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	str := %glob_ahkArg1%
	return  str
}

ahkc_ControlGetText(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg7 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg6 != "") {
		ControlGetText , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != "") {
		ControlGetText , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		ControlGetText , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		ControlGetText , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		ControlGetText , %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		ControlGetText , %glob_ahkArg1%
	} else {
		str := "ControlGetText, OutputVar [, Control, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		return  str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	str := %glob_ahkArg1%
	return  str
}

ahkc_ControlGetPos(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg7 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg6 != "") {
		ControlGetPos , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
		str := %glob_ahkArg1%  . "`n" . %glob_ahkArg2%  . "`n" . %glob_ahkArg3%  . "`n" . %glob_ahkArg4%
	} else if(glob_ahkArg5 != "") {
		ControlGetPos , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
		str := %glob_ahkArg1%  . "`n" . %glob_ahkArg2%  . "`n" . %glob_ahkArg3%  . "`n" . %glob_ahkArg4%
	} else if(glob_ahkArg4 != "") {
		ControlGetPos , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
		str := %glob_ahkArg1%  . "`n" . %glob_ahkArg2%  . "`n" . %glob_ahkArg3%  . "`n" . %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		ControlGetPos , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
		str := %glob_ahkArg1%  . "`n" . %glob_ahkArg2%  . "`n" . %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		ControlGetPos , %glob_ahkArg1%, %glob_ahkArg2%
		str := %glob_ahkArg1%  . "`n" . %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		ControlGetPos , %glob_ahkArg1%
		str := %glob_ahkArg1%
	} else {
		str := "ControlGetPos [, X, Y, Width, Height, Control, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		return  str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_ControlGetFocus(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg6 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg5 != "") {
		ControlGetFocus , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		ControlGetFocus , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		ControlGetFocus , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		ControlGetFocus , %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		ControlGetFocus , %glob_ahkArg1%
	} else {
		str := "ControlGetFocus, OutputVar [WinTitle, WinText, ExcludeTitle, ExcludeText]"
		return  str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	str := %glob_ahkArg1%
	return  str
}


ahkc_DriveGet(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg4 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg3 != ""){
		DriveGet, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		DriveGet, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "DriveGet, OutputVar, Cmd [, Value]"
		return  str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	str := %glob_ahkArg1%
	return  str
}

ahkc_StringMid(argss, GuiNum){
	ahkc_argssSplit(argss)
	str =
	if(glob_ahkArg6 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg5 != "") {
		StringMid, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
		str := %glob_ahkArg1%
	} else if(glob_ahkArg4 != "") {
		StringMid, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
		str := %glob_ahkArg1%
	} else if(glob_ahkArg3 != "") {
		StringMid, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
		str := %glob_ahkArg1%
	} else {
		str := "StringMid, OutputVar, InputVar, StartChar [, Count, L]"
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_StringUpper(argss, GuiNum){
	ahkc_argssSplit(argss)
	str =
	if(glob_ahkArg4 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg3 != "") {
		StringUpper, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
		str := %glob_ahkArg1%
	} else if(glob_ahkArg2 != "") {
		StringUpper, %glob_ahkArg1%, %glob_ahkArg2%
		str := %glob_ahkArg1%
	} else {
		str := "StringUpper, OutputVar, InputVar [, T]"
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_StringLower(argss, GuiNum){
	ahkc_argssSplit(argss)
	str =
	if(glob_ahkArg4 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg3 != "") {
		StringLower, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
		str := %glob_ahkArg1%
	} else if(glob_ahkArg2 != "") {
		StringLower, %glob_ahkArg1%, %glob_ahkArg2%
		str := %glob_ahkArg1%
	} else {
		str := "StringLower, OutputVar, InputVar [, T]"
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_StringReplace(argss, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg6 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg5 != "") {
		StringReplace, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		StringReplace, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		StringReplace, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else {
		str := "StringReplace, OutputVar, InputVar, SearchText [, ReplaceText, All]"
		return str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	str := %glob_ahkArg1%
	return  str
}

ahkc_StringSplit(argss, GuiNum){
	ahkc_argssSplit(argss)
	str =
	if(glob_ahkArg5 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg4 != "") {
		StringSplit, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
		;str := %glob_ahkArg1%
	} else if(glob_ahkArg3 != "") {
		StringSplit, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
		;str := %glob_ahkArg1%
	} else {
		str := "StringSplit, OutputArray, InputVar [, Delimiters, OmitChars]"
		return str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	count := %glob_ahkArg1%0
	Loop, %count%
	{
		str .= %glob_ahkArg1%%A_Index% . "`n"
	}
	return  str
}

ahkc_Sort(argss, GuiNum){
	ahkc_argssSplit(argss)
	str =
	if(glob_ahkArg3 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg2 != "") {
		Sort, %glob_ahkArg1%, %glob_ahkArg2%
		str := %glob_ahkArg1%
	} else if(glob_ahkArg1 != "") {
		Sort, %glob_ahkArg1%
		str := %glob_ahkArg1%
	} else {
		str := "Sort, VarName [, Options]"
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_StringLen(argss, GuiNum){
	ahkc_argssSplit(argss)
	str =
	if(glob_ahkArg3 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg2 != "") {
		StringLen, %glob_ahkArg1%, %glob_ahkArg2%
		str := %glob_ahkArg1%
	} else {
		str := "StringLen, OutputVar, InputVar"
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_GuiControlGet(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg5 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg4 != "") {
		GuiControlGet, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		GuiControlGet, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		GuiControlGet, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		GuiControlGet, %glob_ahkArg1%
	} else {
		str := "GuiControlGet, OutputVar [, Sub-command, ControlID, Param4]"
		return str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	str := %glob_ahkArg1%
	return str
}

ahkc_StatusBarGetText(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg7 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg6 != "") {
		StatusBarGetText, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != "") {
		StatusBarGetText, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		StatusBarGetText, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		StatusBarGetText, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		StatusBarGetText, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		StatusBarGetText, %glob_ahkArg1%
	} else {
		str := "StatusBarGetText, OutputVar [, Part#, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		return str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	str := %glob_ahkArg1%
	return str
}

ahkc_WinGetClass(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	str =
	if(glob_ahkArg6 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg5 != "") {
		WinGetClass, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		WinGetClass, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		WinGetClass, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		WinGetClass, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		WinGetClass, %glob_ahkArg1%
	} else {
		str := "WinGetClass, OutputVar [, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		return  str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	str := %glob_ahkArg1%
	return  str
}

ahkc_WinGetPos(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	str =
	if(glob_ahkArg7 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg6 != "") {
		WinGetPos, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
		str := %glob_ahkArg1%  . "`n" . %glob_ahkArg2%  . "`n" . %glob_ahkArg3%  . "`n" . %glob_ahkArg4%
	} else if(glob_ahkArg5 != "") {
		WinGetPos, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
		str := %glob_ahkArg1%  . "`n" . %glob_ahkArg2%  . "`n" . %glob_ahkArg3%  . "`n" . %glob_ahkArg4%
	} else if(glob_ahkArg4 != "") {
		WinGetPos, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
		str := %glob_ahkArg1%  . "`n" . %glob_ahkArg2%  . "`n" . %glob_ahkArg3%  . "`n" . %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		WinGetPos, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
		str := %glob_ahkArg1%  . "`n" . %glob_ahkArg2%  . "`n" . %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		WinGetPos, %glob_ahkArg1%, %glob_ahkArg2%
		str := %glob_ahkArg1%  . "`n" . %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		WinGetPos, %glob_ahkArg1%
		str := %glob_ahkArg1%
	} else {
		str := "WinGetPos [, X, Y, Width, Height, WinTitle, WinText, ExcludeTitle, ExcludeText]"
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_WinGetActiveStats(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	edc_hideCommGuiNotActiveIfCommOnly(GuiNum)
	windc_anyWaitActive()
	str =
	if(glob_ahkArg6 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg5 != "") {
		WinGetActiveStats, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
		str := %glob_ahkArg1%  . "`n" . %glob_ahkArg2%  . "`n" . %glob_ahkArg3%  . "`n" . %glob_ahkArg4%  . "`n" . %glob_ahkArg5%
	} else {
		str := "WinGetActiveStats, Title, Width, Height, X, Y"
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_WinGetTitle(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	str =
	if(glob_ahkArg6 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg5 != "") {
		WinGetTitle, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		WinGetTitle, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		WinGetTitle, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		WinGetTitle, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		WinGetTitle, %glob_ahkArg1%
	} else {
		str := "WinGetTitle, OutputVar [, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		return  str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	str := %glob_ahkArg1%
	return  str
}

ahkc_WinGetText(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg6 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg5 != "") {
		WinGetText, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		WinGetText, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		WinGetText, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		WinGetText, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		WinGetText, %glob_ahkArg1%
	} else {
		str := "WinGetText, OutputVar [, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		return str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	str := %glob_ahkArg1%
	return str
}

ahkc_WinGet(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg7 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg6 != "") {
		WinGet, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != "") {
		WinGet, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		WinGet, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		WinGet, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		WinGet,  %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		WinGet,  %glob_ahkArg1%
	} else {
		str := "ID  ProcessName  Count  Style  ExStyle  ControlList  ControlListHWND  List  MinMax  Transparent  TransColor`n WinGet, OutputVar [, Cmd, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		return  str
	}
	str := %glob_ahkArg1%
	if(glob_ahkArg2 == "List"){
		buff =
		Loop, %str%
		{
			buff .= %glob_ahkArg1%%A_Index%  . "`n"
		}
		str = %buff%
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_FileSelectFolder(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg2 := outs_textOutToAbsolePath(glob_ahkArg2, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg5 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg4 != ""){
		FileSelectFolder, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		FileSelectFolder, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		FileSelectFolder, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != ""){
		FileSelectFolder, %glob_ahkArg1%
	} else {
		str := "FileSelectFolder, OutputVar [, *StartingFolder, Options, Prompt]"
		return  str
	}
	str := %glob_ahkArg1%
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_FileSelectFile(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg3 := outs_textOutToAbsolePath(glob_ahkArg3, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg6 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg5 != ""){
		FileSelectFile, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != ""){
		FileSelectFile, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		FileSelectFile, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		FileSelectFile, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != ""){
		FileSelectFile, %glob_ahkArg1%
	} else {
		str := "FileSelectFile, OutputVar [, Options, RootDir[\DefaultFilename], Prompt, Filter]"
		return  str
	}
	str := %glob_ahkArg1%
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_FileGetShortcut(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	glob_ahkArg1 := outs_textOutToAbsolePath(glob_ahkArg1, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	str =
	if(glob_ahkArg9 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg8 != ""){
		FileGetShortcut, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%, %glob_ahkArg8%
	} else if(glob_ahkArg7 != ""){
		FileGetShortcut, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%
	} else if(glob_ahkArg6 != ""){
		FileGetShortcut, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != ""){
		FileGetShortcut, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != ""){
		FileGetShortcut, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		FileGetShortcut, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		FileGetShortcut, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "FileGetShortcut, LinkFile [, OutTarget, OutDir, OutArgs, OutDescription, OutIcon, OutIconNum, OutRunState]"
		return  str
	}
	str :=  "path`t" . %glob_ahkArg2%  . "`nworkDir`t"  . %glob_ahkArg3%  . "`nargs`t"  . %glob_ahkArg4%  . "`n説明`t"  . %glob_ahkArg5%  . "`nアイコン`t"  . %glob_ahkArg6%  . "`nアイコンNo`t"  . %glob_ahkArg7%  . "`n特殊`t"  . %glob_ahkArg7%
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_FileGetAttrib(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	glob_ahkArg2 := outs_textOutToAbsolePath(glob_ahkArg2, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg3 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg2 != "") {
		FileGetAttrib, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		FileGetAttrib, %glob_ahkArg1%
	} else {
		str := "FileGetAttrib, OutputVar [, Filename]"
		return  str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	str :=  %glob_ahkArg1%
	return  str
}

ahkc_FileGetTime(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	glob_ahkArg2 := outs_textOutToAbsolePath(glob_ahkArg2, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg4 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg3 != "") {
		FileGetTime, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		FileGetTime, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		FileGetTime, %glob_ahkArg1%
	} else {
		str := "FileGetTime, OutputVar [, Filename, WhichTime`nM 最終更新日時(デフォルト)`nC 作成日時`nA 最終アクセス日時"
		return  str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	str :=  %glob_ahkArg1%
	return  str
}

ahkc_IniRead(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	glob_ahkArg2 := outs_textOutToAbsolePath(glob_ahkArg2, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg6 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg5 != "") {
		IniRead, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		IniRead, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else {
		str := "IniRead, OutputVar, Filename, Section, Key [, Default]"
		return  str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	str :=  %glob_ahkArg1%
	return  str
}

ahkc_FileGetVersion(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	glob_ahkArg2 := outs_textOutToAbsolePath(glob_ahkArg2, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg3 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg2 != "") {
		FileGetVersion, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		FileGetVersion, %glob_ahkArg1%
	} else {
		str := "FileGetVersion, OutputVar [, Filename]"
		return  str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	str :=  %glob_ahkArg1%
	return  str
}


ahkc_InputBox(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg9 != ""){
		; 昔の ahk に対応させるため、使えないように
		;InputBox, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%, %glob_ahkArg8%, %glob_ahkArg9%
		InputBox, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%, %glob_ahkArg8%
	} else if(glob_ahkArg8 != ""){
		InputBox, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%, %glob_ahkArg8%
	} else if(glob_ahkArg7 != ""){
		InputBox, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%
	} else if(glob_ahkArg6 != ""){
		InputBox, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != ""){
		InputBox, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != ""){
		InputBox, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		InputBox, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		InputBox, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != ""){
		InputBox, %glob_ahkArg1%
	} else {
		str := "InputBox, OutputVar [, Title, Prompt, HIDE, Width, Height, X, Y, Font, Timeout, Default]`n本来は１１の引数があるが、引数８までしか指定できない。`nFont と Timeout と Default は指定できない。"
		return  str
	}
	str := %glob_ahkArg1%
	; ErrorLevel を当たり前に使うので、エラーを表示させない
	ErrorLevel_TextRunRun = %ErrorLevel%
	;ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_EnvGet(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg3 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg2 != ""){
		EnvGet, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "EnvGet, OutputVar, EnvVarName"
		return  str
	}
	str := %glob_ahkArg1%
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_Random(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	str =
	if(glob_ahkArg4 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg3 != ""){
		Random, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
		str := %glob_ahkArg1%
	} else if(glob_ahkArg2 != ""){
		if(glob_ahkArg1 == ""){
			Random, , %glob_ahkArg2%
			str := argss  . "`nを実行"
		} else {
			Random, %glob_ahkArg1%, %glob_ahkArg2%
			str := %glob_ahkArg1%
		}
	} else if(glob_ahkArg1 != ""){
		Random, %glob_ahkArg1%
		str := %glob_ahkArg1%
	} else {
		str := "Random, OutputVar [, Min, Max]`nRandom, , NewSeed"
		return  str
	}
	;str := %glob_ahkArg1%
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_StringLeft(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg4 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg3 != ""){
		StringLeft, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else {
		str := "StringLeft, OutputVar, InputVar, Count"
		return  str
	}
	str := %glob_ahkArg1%
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_StringRight(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg4 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg3 != ""){
		StringRight, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else {
		str := "StringRight, OutputVar, InputVar, Count"
		return  str
	}
	str := %glob_ahkArg1%
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_StringTrimLeft(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg4 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg3 != ""){
		StringTrimLeft, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else {
		str := "StringTrimLeft, OutputVar, InputVar, Count"
		return  str
	}
	str := %glob_ahkArg1%
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_StringTrimRight(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg4 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg3 != ""){
		StringTrimRight, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else {
		str := "StringTrimRight, OutputVar, InputVar, Count"
		return  str
	}
	str := %glob_ahkArg1%
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_StringGetPos(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg6 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg5 != ""){
		StringGetPos, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != ""){
		StringGetPos, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		StringGetPos, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else {
		str := "StringGetPos, OutputVar, InputVar, SearchText [, L#|R#, Offset]"
		return  str
	}
	str := %glob_ahkArg1%
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_Input(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg5 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg4 != ""){
		Input, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		Input, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		Input, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != ""){
		Input, %glob_ahkArg1%
	} else {
		Input
		str := "Inputの状態を解除した。`nInput [, OutputVar, Options, EndKeys, MatchList]`nInput のみで、Inputの状態を解除できる"
		return  str
	}
	str := %glob_ahkArg1%
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_WinGetActiveTitle(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	edc_hideCommGuiNotActiveIfCommOnly(GuiNum)
	windc_anyWaitActive()
	if(glob_ahkArg2 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg1 != ""){
		WinGetActiveTitle, %glob_ahkArg1%
	} else {
		str := "WinGetActiveTitle, OutputVar"
		return  str
	}
	str := %glob_ahkArg1%
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_DriveSpaceFree(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg3 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg2 != ""){
		DriveSpaceFree, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "DriveSpaceFree, OutputVar, E:\`n空き容量をメガバイト単位で取得"
		return  str
	}
	str := %glob_ahkArg1%
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_FileGetSize(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg2 := outs_textOutToAbsolePath(glob_ahkArg2, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg4 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg3 != ""){
		FileGetSize, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		FileGetSize, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != ""){
		FileGetSize, %glob_ahkArg1%
	} else {
		str := "FileGetSize, OutputVar [, Filename, Units]"
		return  str
	}
	str := %glob_ahkArg1%
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_FileReadLine(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg2 := outs_textOutToAbsolePath(glob_ahkArg2, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg4 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg3 != ""){
		FileReadLine, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else {
		str := "FileReadLine, OutputVar, Filename, LineNum"
		return  str
	}
	str := %glob_ahkArg1%
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_RegRead(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg5 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg4 != ""){
		RegRead, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3% , %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		RegRead, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else {
		str := "RegRead, OutputVar, HKLM|HKU|HKCU|HKCR|HKCC, SubKey [, ValueName]"
		return  str
	}
	str := %glob_ahkArg1%
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_SoundGet(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg5 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg4 != "") {
		SoundGet , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		SoundGet , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		SoundGet , %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		SoundGet , %glob_ahkArg1%
	} else {
		str := "SoundGet, OutputVar [, ComponentType, ControlType, DeviceNumber]"
		return  str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	str :=  %glob_ahkArg1%
	return  str
}

ahkc_SoundGetWaveVolume(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg3 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg2 != "") {
		SoundGetWaveVolume, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		SoundGetWaveVolume , %glob_ahkArg1%
	} else {
		str := "SoundGetWaveVolume, OutputVar [, DeviceNumber]`n音量を0から100で取得"
		return  str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	str :=  %glob_ahkArg1%
	return  str
}

ahkc_MouseGetPos(argss, pOut, GuiNum){
	str =
	ahkc_argssSplit(argss)
	if(glob_ahkArg6 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg5 != "") {
		MouseGetPos , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
		str := %glob_ahkArg1%  . "`n" . %glob_ahkArg2%  . "`n" . %glob_ahkArg3%  . "`n" . %glob_ahkArg4%
	} else if(glob_ahkArg4 != "") {
		MouseGetPos , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
		str := %glob_ahkArg1%  . "`n" . %glob_ahkArg2%  . "`n" . %glob_ahkArg3%  . "`n" . %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		MouseGetPos , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
		str := %glob_ahkArg1%  . "`n" . %glob_ahkArg2%  . "`n" . %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		MouseGetPos , %glob_ahkArg1%, %glob_ahkArg2%
		str := %glob_ahkArg1%  . "`n" . %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		MouseGetPos , %glob_ahkArg1%
		str := %glob_ahkArg1%
	} else {
		str := "MouseGetPos [, OutputVarX, OutputVarY, OutputVarWin, OutputVarControl, 1|2]"
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_PixelGetColor(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg5 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg4 != "") {
		PixelGetColor, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		PixelGetColor, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else {
		str := "PixelGetColor, OutputVar, X, Y [, Alt|Slow|RGB]"
		return  str
	}
	str := %glob_ahkArg1%
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_PixelSearch(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg9 != "") {
		PixelSearch, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%, %glob_ahkArg8%, %glob_ahkArg9%
	} else  if(glob_ahkArg8 != "") {
		PixelSearch, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%, %glob_ahkArg8%
	} else if(glob_ahkArg7 != "") {
		PixelSearch, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%
	} else {
		str := "PixelSearch, OutputVarX, OutputVarY, X1, Y1, X2, Y2, ColorID [, Variation, Fast|RGB]"
		return  str
	}
	str := "X`n" . %glob_ahkArg1% . "`nY`n" . %glob_ahkArg2%
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_ImageSearch(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg8 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg7 != "") {
		ImageSearch, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%
	} else {
		str := "ImageSearch, OutputVarX, OutputVarY, X1, Y1, X2, Y2, ImageFile"
		return  str
	}
	str := "X`n" . %glob_ahkArg1% . "`nY`n" . %glob_ahkArg2%
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	return  str
}

ahkc_GetKeyState(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg4 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return ""
		}
	}
	if(glob_ahkArg3 != "") {
		GetKeyState , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		GetKeyState , %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "GetKeyState, OutputVar, WhichKey [, Mode (P|T)]"
		return  str
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	str := %glob_ahkArg1%
	return  str
}
