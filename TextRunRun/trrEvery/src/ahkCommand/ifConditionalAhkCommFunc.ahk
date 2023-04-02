

ifcah_IfEqual(argss, pOut, GuiNum, notMultipleFlag){
	ansNum = 3
	ansFlag := False
	ahkc_argssSplit(argss)
	helpStr := "IfEqual, var, value, 実行させる処理"
	if( edc_helpViewIfHyphenH(helpStr, glob_ahkArg1, GuiNum) ){
		return 3
	}
	if(glob_ahkArg2 != ""){
		IfEqual, %glob_ahkArg1% , %glob_ahkArg2%
		{
			ansFlag := True
			ansNum = 1
		} else {
			;ansFlag := False
			ansNum = 0
		}
		if( notMultipleFlag ){
			rStr := func_rightStrOrNullFromSearchStrTurnAssign(argss, ",", 3)
			ifco_ifSentenceCommandExe(ansFlag, rStr, "", pOut, GuiNum)
		}
		return ansNum
	} else {
		guit_setExplain(helpStr, GuiNum)
	}
	guit_checkErrorLevelOutput("")
	return 3
}

ifcah_IfNotEqual(argss, pOut, GuiNum, notMultipleFlag){
	ansNum = 3
	ansFlag := False
	ahkc_argssSplit(argss)
	helpStr := "IfNotEqual, var, value, 実行させる処理"
	if( edc_helpViewIfHyphenH(helpStr, glob_ahkArg1, GuiNum) ){
		return 3
	}
	if(glob_ahkArg2 != ""){
		IfNotEqual, %glob_ahkArg1% , %glob_ahkArg2%
		{
			ansFlag := True
			ansNum = 1
		} else {
			;ansFlag := False
			ansNum = 0
		}
		if( notMultipleFlag ){
			rStr := func_rightStrOrNullFromSearchStrTurnAssign(argss, ",", 3)
			ifco_ifSentenceCommandExe(ansFlag, rStr, "", pOut, GuiNum)
		}
		return ansNum
	} else {
		guit_setExplain(helpStr, GuiNum)
	}
	guit_checkErrorLevelOutput("")
	return 3
}

ifcah_IfGreater(argss, pOut, GuiNum, notMultipleFlag){
	ansNum = 3
	ansFlag := False
	ahkc_argssSplit(argss)
	helpStr := "IfGreater, var, value, 実行させる処理"
	if( edc_helpViewIfHyphenH(helpStr, glob_ahkArg1, GuiNum) ){
		return 3
	}
	if(glob_ahkArg2 != ""){
		IfGreater, %glob_ahkArg1% , %glob_ahkArg2%
		{
			ansFlag := True
			ansNum = 1
		} else {
			;ansFlag := False
			ansNum = 0
		}
		if( notMultipleFlag ){
			rStr := func_rightStrOrNullFromSearchStrTurnAssign(argss, ",", 3)
			ifco_ifSentenceCommandExe(ansFlag, rStr, "", pOut, GuiNum)
		}
		return ansNum
	} else {
		guit_setExplain(helpStr, GuiNum)
	}
	guit_checkErrorLevelOutput("")
	return 3
}

ifcah_IfGreaterOrEqual(argss, pOut, GuiNum, notMultipleFlag){
	ansNum = 3
	ansFlag := False
	ahkc_argssSplit(argss)
	helpStr := "IfGreaterOrEqual, var, value, 実行させる処理"
	if( edc_helpViewIfHyphenH(helpStr, glob_ahkArg1, GuiNum) ){
		return 3
	}
	if(glob_ahkArg2 != ""){
		IfGreaterOrEqual, %glob_ahkArg1% , %glob_ahkArg2%
		{
			ansFlag := True
			ansNum = 1
		} else {
			;ansFlag := False
			ansNum = 0
		}
		if( notMultipleFlag ){
			rStr := func_rightStrOrNullFromSearchStrTurnAssign(argss, ",", 3)
			ifco_ifSentenceCommandExe(ansFlag, rStr, "", pOut, GuiNum)
		}
		return ansNum
	} else {
		guit_setExplain(helpStr, GuiNum)
	}
	guit_checkErrorLevelOutput("")
	return 3
}

ifcah_IfLess(argss, pOut, GuiNum, notMultipleFlag){
	ansNum = 3
	ansFlag := False
	ahkc_argssSplit(argss)
	helpStr := "IfLess, var, value, 実行させる処理"
	if( edc_helpViewIfHyphenH(helpStr, glob_ahkArg1, GuiNum) ){
		return 3
	}
	if(glob_ahkArg2 != ""){
		IfLess, %glob_ahkArg1% , %glob_ahkArg2%
		{
			ansFlag := True
			ansNum = 1
		} else {
			;ansFlag := False
			ansNum = 0
		}
		if( notMultipleFlag ){
			rStr := func_rightStrOrNullFromSearchStrTurnAssign(argss, ",", 3)
			ifco_ifSentenceCommandExe(ansFlag, rStr, "", pOut, GuiNum)
		}
		return ansNum
	} else {
		guit_setExplain(helpStr, GuiNum)
	}
	guit_checkErrorLevelOutput("")
	return 3
}

ifcah_IfLessOrEqual(argss, pOut, GuiNum, notMultipleFlag){
	ansNum = 3
	ansFlag := False
	ahkc_argssSplit(argss)
	helpStr := "IfLessOrEqual, var, value, 実行させる処理"
	if( edc_helpViewIfHyphenH(helpStr, glob_ahkArg1, GuiNum) ){
		return 3
	}
	if(glob_ahkArg2 != ""){
		IfLessOrEqual, %glob_ahkArg1% , %glob_ahkArg2%
		{
			ansFlag := True
			ansNum = 1
		} else {
			;ansFlag := False
			ansNum = 0
		}
		if( notMultipleFlag ){
			rStr := func_rightStrOrNullFromSearchStrTurnAssign(argss, ",", 3)
			ifco_ifSentenceCommandExe(ansFlag, rStr, "", pOut, GuiNum)
		}
		return ansNum
	} else {
		guit_setExplain(helpStr, GuiNum)
	}
	guit_checkErrorLevelOutput("")
	return 3
}

ifcah_IfWinActive(argss, pOut, GuiNum, notMultipleFlag){
	ansNum = 3
	exeFlag := False
	ahkc_argssSplit(argss)
	helpStr := "IfWinActive , WinTitle, WinText, ExcludeTitle, ExcludeText, 実行させる処理"
	if( edc_helpViewIfHyphenH(helpStr, glob_ahkArg1, GuiNum) ){
		return 3
	}
	;edc_hideCommGuiNotActiveIfCommOnly(GuiNum)
	;windc_anyWaitActive()
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg4 != ""){
		IfWinActive, %glob_ahkArg1% , %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
		{
			ansNum = 1
		} else {
			ansNum = 0
		}
		exeFlag := True
	} else if(glob_ahkArg3 != ""){
		IfWinActive, %glob_ahkArg1% , %glob_ahkArg2%, %glob_ahkArg3%
		{
			ansNum = 1
		} else {
			ansNum = 0
		}
		exeFlag := True
	} else if(glob_ahkArg2 != ""){
		IfWinActive, %glob_ahkArg1% , %glob_ahkArg2%
		{
			ansNum = 1
		} else {
			ansNum = 0
		}
		exeFlag := True
	} else if(glob_ahkArg1 != ""){
		IfWinActive, %glob_ahkArg1%
		{
			ansNum = 1
		} else {
			ansNum = 0
		}
		exeFlag := True
	} else {
		guit_setExplain(helpStr, GuiNum)
	}
	guit_checkErrorLevelOutput("")
	if( exeFlag ){
		if( notMultipleFlag ){
			rStr := func_rightStrOrNullFromSearchStrTurnAssign(argss, ",", 5)
			ifco_ifSentenceCommandExe(ansNum, rStr, "", pOut, GuiNum)
		}
		return ansNum
	}
	return 3
}

ifcah_IfWinNotActive(argss, pOut, GuiNum, notMultipleFlag){
	ansNum = 3
	exeFlag := False
	ahkc_argssSplit(argss)
	helpStr := "IfWinNotActive , WinTitle, WinText, ExcludeTitle, ExcludeText, 実行させる処理"
	if( edc_helpViewIfHyphenH(helpStr, glob_ahkArg1, GuiNum) ){
		return 3
	}
	;edc_hideCommGuiNotActiveIfCommOnly(GuiNum)
	;windc_anyWaitActive()
	ahkc_windowComProvision(GuiNum)
	;Sleep, 100
	if(glob_ahkArg4 != ""){
		IfWinNotActive, %glob_ahkArg1% , %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
		{
			ansNum = 1
		} else {
			ansNum = 0
		}
		exeFlag := True
	} else if(glob_ahkArg3 != ""){
		IfWinNotActive, %glob_ahkArg1% , %glob_ahkArg2%, %glob_ahkArg3%
		{
			ansNum = 1
		} else {
			ansNum = 0
		}
		exeFlag := True
	} else if(glob_ahkArg2 != ""){
		IfWinNotActive, %glob_ahkArg1% , %glob_ahkArg2%
		{
			ansNum = 1
		} else {
			ansNum = 0
		}
		exeFlag := True
	} else if(glob_ahkArg1 != ""){
		IfWinNotActive, %glob_ahkArg1%
		{
			ansNum = 1
		} else {
			ansNum = 0
		}
		exeFlag := True
	} else {
		guit_setExplain(helpStr, GuiNum)
	}
	guit_checkErrorLevelOutput("")
	if( exeFlag ){
		if( notMultipleFlag ){
			rStr := func_rightStrOrNullFromSearchStrTurnAssign(argss, ",", 5)
			ifco_ifSentenceCommandExe(ansNum, rStr, "", pOut, GuiNum)
		}
		return ansNum
	}
	return 3
}

ifcah_IfWinExist(argss, pOut, GuiNum, notMultipleFlag){
	ansNum = 3
	exeFlag := False
	ahkc_argssSplit(argss)
	helpStr := "IfWinExist , WinTitle, WinText, ExcludeTitle, ExcludeText, 実行させる処理"
	if( edc_helpViewIfHyphenH(helpStr, glob_ahkArg1, GuiNum) ){
		return 3
	}
	if(glob_ahkArg4 != ""){
		IfWinExist, %glob_ahkArg1% , %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
		{
			ansNum = 1
		} else {
			ansNum = 0
		}
		exeFlag := True
	} else if(glob_ahkArg3 != ""){
		IfWinExist, %glob_ahkArg1% , %glob_ahkArg2%, %glob_ahkArg3%
		{
			ansNum = 1
		} else {
			ansNum = 0
		}
		exeFlag := True
	} else if(glob_ahkArg2 != ""){
		IfWinExist, %glob_ahkArg1% , %glob_ahkArg2%
		{
			ansNum = 1
		} else {
			ansNum = 0
		}
		exeFlag := True
	} else if(glob_ahkArg1 != ""){
		IfWinExist, %glob_ahkArg1%
		{
			ansNum = 1
		} else {
			ansNum = 0
		}
		exeFlag := True
	} else {
		guit_setExplain(helpStr, GuiNum)
	}
	guit_checkErrorLevelOutput("")
	if( exeFlag ){
		if( notMultipleFlag ){
			rStr := func_rightStrOrNullFromSearchStrTurnAssign(argss, ",", 5)
			ifco_ifSentenceCommandExe(ansNum, rStr, "", pOut, GuiNum)
		}
		return ansNum
	}
	return 3
}

ifcah_IfWinNotExist(argss, pOut, GuiNum, notMultipleFlag){
	ansNum = 3
	exeFlag := False
	ahkc_argssSplit(argss)
	helpStr := "IfWinNotExist , WinTitle, WinText, ExcludeTitle, ExcludeText, 実行させる処理"
	if( edc_helpViewIfHyphenH(helpStr, glob_ahkArg1, GuiNum) ){
		return 3
	}
	if(glob_ahkArg4 != ""){
		IfWinNotExist, %glob_ahkArg1% , %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
		{
			ansNum = 1
		} else {
			ansNum = 0
		}
		exeFlag := True
	} else if(glob_ahkArg3 != ""){
		IfWinNotExist, %glob_ahkArg1% , %glob_ahkArg2%, %glob_ahkArg3%
		{
			ansNum = 1
		} else {
			ansNum = 0
		}
		exeFlag := True
	} else if(glob_ahkArg2 != ""){
		IfWinNotExist, %glob_ahkArg1% , %glob_ahkArg2%
		{
			ansNum = 1
		} else {
			ansNum = 0
		}
		exeFlag := True
	} else if(glob_ahkArg1 != ""){
		IfWinNotExist, %glob_ahkArg1%
		{
			ansNum = 1
		} else {
			ansNum = 0
		}
		exeFlag := True
	} else {
		guit_setExplain(helpStr, GuiNum)
	}
	guit_checkErrorLevelOutput("")
	if( exeFlag ){
		if( notMultipleFlag ){
			rStr := func_rightStrOrNullFromSearchStrTurnAssign(argss, ",", 5)
			ifco_ifSentenceCommandExe(ansNum, rStr, "", pOut, GuiNum)
		}
		return ansNum
	}
	return 3
}

ifcah_IfExist(argss, pOut, GuiNum, notMultipleFlag){
	ansNum = 3
	ansFlag := False
	ahkc_argssSplit(argss)
	helpStr := "IfExist, File|Dir|Pattern, 実行させる処理"
	if( edc_helpViewIfHyphenH(helpStr, glob_ahkArg1, GuiNum) ){
		return 3
	}

	if(glob_ahkArg1 != ""){
		IfExist, %glob_ahkArg1%
		{
			ansFlag := True
			ansNum = 1
		} else {
			;ansFlag := False
			ansNum = 0
		}
		if( notMultipleFlag ){
			rStr := func_rightStrOrNullFromSearchStrTurnAssign(argss, ",", 2)
			ifco_ifSentenceCommandExe(ansFlag, rStr, "", pOut, GuiNum)
		}
		return ansNum
	} else {
		guit_setExplain(helpStr, GuiNum)
	}
	guit_checkErrorLevelOutput("")
	return 3
}

ifcah_IfNotExist(argss, pOut, GuiNum, notMultipleFlag){
	ansNum = 3
	ansFlag := False
	ahkc_argssSplit(argss)
	helpStr := "IfNotExist, File|Dir|Pattern, 実行させる処理"
	if( edc_helpViewIfHyphenH(helpStr, glob_ahkArg1, GuiNum) ){
		return 3
	}

	if(glob_ahkArg1 != ""){
		IfNotExist, %glob_ahkArg1%
		{
			ansFlag := True
			ansNum = 1
		} else {
			;ansFlag := False
			ansNum = 0
		}
		if( notMultipleFlag ){
			rStr := func_rightStrOrNullFromSearchStrTurnAssign(argss, ",", 2)
			ifco_ifSentenceCommandExe(ansFlag, rStr, "", pOut, GuiNum)
		}
		return ansNum
	} else {
		guit_setExplain(helpStr, GuiNum)
	}
	guit_checkErrorLevelOutput("")
	return 3
}

ifcah_IfMsgBox(argss, pOut, GuiNum, notMultipleFlag){
	ansNum = 3
	ansFlag := False
	ahkc_argssSplit(argss)
	helpStr := "IfMsgBox, Yes|No|OK|Cancel|Abort|Ignore|Retry|Timeout, 実行させる処理`nYes  No  Cancel しか、ここで使う分には意味がないと思われる。"
	if( edc_helpViewIfHyphenH(helpStr, glob_ahkArg1, GuiNum) ){
		return 3
	}
	if(glob_ahkArg1 != ""){
		IfMsgBox, %glob_ahkArg1%
		{
			ansFlag := True
			ansNum = 1
		} else {
			;ansFlag := False
			ansNum = 0
		}
		if( notMultipleFlag ){
			rStr := func_rightStrOrNullFromSearchStrTurnAssign(argss, ",", 2)
			ifco_ifSentenceCommandExe(ansFlag, rStr, "", pOut, GuiNum)
		}
		return ansNum
	} else {
		guit_setExplain(helpStr, GuiNum)
	}
	guit_checkErrorLevelOutput("")
	return 3
}

ifcah_IfInString(argss, pOut, GuiNum, notMultipleFlag){
	ansNum = 3
	ansFlag := False
	ahkc_argssSplit(argss)
	helpStr := "IfInString, Var, SearchString, 実行させる処理"
	if( edc_helpViewIfHyphenH(helpStr, glob_ahkArg1, GuiNum) ){
		return 3
	}
	if(glob_ahkArg2 != ""){
		IfInString, %glob_ahkArg1% , %glob_ahkArg2%
		{
			ansFlag := True
			ansNum = 1
		} else {
			;ansFlag := False
			ansNum = 0
		}
		if( notMultipleFlag ){
			rStr := func_rightStrOrNullFromSearchStrTurnAssign(argss, ",", 3)
			ifco_ifSentenceCommandExe(ansFlag, rStr, "", pOut, GuiNum)
		}
		return ansNum
	} else {
		guit_setExplain(helpStr, GuiNum)
	}
	guit_checkErrorLevelOutput("")
	return 3
}

ifcah_IfNotInString(argss, pOut, GuiNum, notMultipleFlag){
	ansNum = 3
	ansFlag := False
	ahkc_argssSplit(argss)
	helpStr := "IfNotInString, Var, SearchString, 実行させる処理"
	if( edc_helpViewIfHyphenH(helpStr, glob_ahkArg1, GuiNum) ){
		return 3
	}
	if(glob_ahkArg2 != ""){
		IfNotInString, %glob_ahkArg1% , %glob_ahkArg2%
		{
			ansFlag := True
			ansNum = 1
		} else {
			;ansFlag := False
			ansNum = 0
		}
		if( notMultipleFlag ){
			rStr := func_rightStrOrNullFromSearchStrTurnAssign(argss, ",", 3)
			ifco_ifSentenceCommandExe(ansFlag, rStr, "", pOut, GuiNum)
		}
		return ansNum
	} else {
		guit_setExplain(helpStr, GuiNum)
	}
	guit_checkErrorLevelOutput("")
	return 3
}

ifcah_IfVarInVersion(com2, com3, com4, com5, editAll, notFlag, hwnd, pOut, GuiNum, notMultipleFlag){
	ansNum = 3
	ansFlag := False
	helpStr := "If Var [not] in value1,value2,...{ 実行させる処理 }`n実行させる処理は { } で括らなければ認識できない。"
	if( edc_helpViewIfHyphenH(helpStr, com2, GuiNum) ){
		return 3
	}

	com2 := outs_textOutTrimss(com2)
	com4 := outs_textOutTrimss(com4)

	if( notFlag ){
		If %com2% not in %com4%
		{
			ansFlag := True
			ansNum = 1
		} else {
			;ansFlag := False
			ansNum = 0
		}
	} else {
		If %com2% in %com4%
		{
			ansFlag := True
			ansNum = 1
		} else {
			;ansFlag := False
			ansNum = 0
		}
	}
	if( notMultipleFlag ){
		rStr := func_rightStrOrNullFromSearchStrTurnAssign(editAll, "{", 1)
		rStr := "{" . rStr
		ifco_ifSentenceCommandExe(ansFlag, rStr, hwnd, pOut, GuiNum)
	}
	return ansNum
}

ifcah_IfVarContainsVersion(com2, com3, com4, com5, editAll, notFlag, hwnd, pOut, GuiNum, notMultipleFlag){
	ansNum = 3
	ansFlag := False
	helpStr := "If Var [not] contains value1,value2,...{ 実行させる処理 }`n実行させる処理は { } で括らなければ認識できない。"
	if( edc_helpViewIfHyphenH(helpStr, com2, GuiNum) ){
		return 3
	}

	com2 := outs_textOutTrimss(com2)
	com4 := outs_textOutTrimss(com4)

	if( notFlag ){
		If %com2% not contains %com4%
		{
			ansFlag := True
			ansNum = 1
		} else {
			;ansFlag := False
			ansNum = 0
		}
	} else {
		If %com2% contains %com4%
		{
			ansFlag := True
			ansNum = 1
		} else {
			;ansFlag := False
			ansNum = 0
		}
	}
	if( notMultipleFlag ){
		rStr := func_rightStrOrNullFromSearchStrTurnAssign(editAll, "{", 1)
		rStr := "{" . rStr
		ifco_ifSentenceCommandExe(ansFlag, rStr, hwnd, pOut, GuiNum)
	}
	return ansNum
}

ifcah_IfVarBetweenVersion(com2, com3, com4, com5, com6, editAll, notFlag, hwnd, pOut, GuiNum, notMultipleFlag){
	ansNum = 3
	ansFlag := False
	helpStr := "If Var [not] between Low and High { 実行させる処理 }`n実行させる処理は { } で括らなければ認識できない。"
	if( edc_helpViewIfHyphenH(helpStr, com2, GuiNum) ){
		return 3
	}

	com2 := outs_textOutTrimss(com2)
	com4 := outs_textOutTrimss(com4)
	com6 := outs_textOutTrimss(com6)

	advice := "If Var between のエラー`nIf  Var  between  value1  and  value2  の形式で記入すること。`nand の文字がない。"
	if(com5 != "and"){
		guit_errorAppend(advice)
		return 3
	}
	if(com6 == ""){
		guit_errorAppend(advice)
		return 3
	}

	if( notFlag ){
		If %com2% not between %com4% and %com6%
		{
			ansFlag := True
			ansNum = 1
		} else {
			;ansFlag := False
			ansNum = 0
		}
	} else {
		If %com2% between %com4% and %com6%
		{
			ansFlag := True
			ansNum = 1
		} else {
			;ansFlag := False
			ansNum = 0
		}
	}
	if( notMultipleFlag ){
		rStr := func_rightStrOrNullFromSearchStrTurnAssign(editAll, "{", 1)
		rStr := "{" . rStr
		ifco_ifSentenceCommandExe(ansFlag, rStr, hwnd, pOut, GuiNum)
	}
	return ansNum
}

ifcah_IfVarIsEnyVersion(com2, com3, com4, com5, editAll, notFlag, hwnd, pOut, GuiNum, notMultipleFlag){
	ansNum = 3
	ansFlag := False
	helpStr := "If Var is [not] integer|float|number|digit|xdigit|alpha|upper|lower|alnum|space|time { 実行させる処理 }`n実行させる処理は { } で括らなければ認識できない。"
	if( edc_helpViewIfHyphenH(helpStr, com2, GuiNum) ){
		return 3
	}

	com2 := outs_textOutTrimss(com2)
	com4 := outs_textOutTrimss(com4)

	advice := "If Var is のエラー`ninteger|float|number|digit|xdigit|alpha|upper|lower|alnum|space|time 以外の書式が記入されている。"
	If com4 not in integer,float,number,digit,xdigit,alpha,upper,lower,alnum,space,time
	{
		guit_errorAppend(advice)
		return 3
	}

	if( notFlag ){
		If %com2% is not %com4%
		{
			ansFlag := True
			ansNum = 1
		} else {
			;ansFlag := False
			ansNum = 0
		}
	} else {
		If %com2% is %com4%
		{
			ansFlag := True
			ansNum = 1
		} else {
			;ansFlag := False
			ansNum = 0
		}
	}
	if( notMultipleFlag ){
		rStr := func_rightStrOrNullFromSearchStrTurnAssign(editAll, "{", 1)
		rStr := "{" . rStr
		ifco_ifSentenceCommandExe(ansFlag, rStr, hwnd, pOut, GuiNum)
	}
	return ansNum
}

ifcah_ifSentenceEnyType(com2, com3, com4, com5, com6, editAll, notFlag, hwnd, pOut, GuiNum, notMultipleFlag){
	ansNum = 2
	StringLower, com3Lower, com3
	if(com3Lower == "in"){
		ansNum := ifcah_IfVarInVersion(com2, com3, com4, com5, editAll, notFlag, hwnd, pOut, GuiNum, notMultipleFlag)
		return ansNum
	} else if(com3Lower == "contains"){
		ansNum := ifcah_IfVarContainsVersion(com2, com3, com4, com5, editAll, notFlag, hwnd, pOut, GuiNum, notMultipleFlag)
		return ansNum
	} else if(com3Lower == "between"){
		ansNum := ifcah_IfVarBetweenVersion(com2, com3, com4, com5, com6, editAll, notFlag, hwnd, pOut, GuiNum, notMultipleFlag)
		return ansNum
	}
	return ansNum
}

ifcah_ifSentenceAhkVersion(com2, com3, com4, com5, com6, com7, editAll, hwnd, pOut, GuiNum, notMultipleFlag){
	ansNum = 2
	StringLower, com3Lower, com3
	if(com3Lower == "not"){
		ansNum := ifcah_ifSentenceEnyType(com2, com4, com5, com6, com7, editAll, True, hwnd, pOut, GuiNum, notMultipleFlag)
		return ansNum
	} else if(com3Lower == "is"){
		StringLower, com4Lower, com4
		if(com4Lower == "not"){
			ansNum := ifcah_IfVarIsEnyVersion(com2, com3, com5, com6, editAll, True, hwnd, pOut, GuiNum, notMultipleFlag)
		} else {
			ansNum := ifcah_IfVarIsEnyVersion(com2, com3, com4, com5, editAll, False, hwnd, pOut, GuiNum, notMultipleFlag)
		}
		return ansNum
	}

	ansNum := ifcah_ifSentenceEnyType(com2, com3, com4, com5, com6, editAll, False, hwnd, pOut, GuiNum, notMultipleFlag)
	
	return ansNum
}
