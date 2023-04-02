; 必須 guf  outs 

ahkc_argssSplit(argss){
	delimiter := ","
	StringSplit, arg_ , argss , %delimiter% , %A_Space%
	glob_ahkArg0 := arg_1
	glob_ahkArg1 := outs_textOutTrimss(arg_2)
	glob_ahkArg2 := outs_textOutTrimss(arg_3)
	glob_ahkArg3 := outs_textOutTrimss(arg_4)
	glob_ahkArg4 := outs_textOutTrimss(arg_5)
	glob_ahkArg5 := outs_textOutTrimss(arg_6)
	glob_ahkArg6 := outs_textOutTrimss(arg_7)
	glob_ahkArg7 := outs_textOutTrimss(arg_8)
	glob_ahkArg8 := outs_textOutTrimss(arg_9)
	glob_ahkArg9 := outs_textOutTrimss(arg_10)

	; 関数の , で区切る事による問題を解決するまで保留
	;glob_ahkArg1 := ifco_calcParsentTextOut(glob_ahkArg1, argss)
	;glob_ahkArg2 := ifco_calcParsentTextOut(glob_ahkArg2, argss)
	;glob_ahkArg3 := ifco_calcParsentTextOut(glob_ahkArg3, argss)
	;glob_ahkArg4 := ifco_calcParsentTextOut(glob_ahkArg4, argss)
	;glob_ahkArg5 := ifco_calcParsentTextOut(glob_ahkArg5, argss)
	;glob_ahkArg6 := ifco_calcParsentTextOut(glob_ahkArg6, argss)
	;glob_ahkArg7 := ifco_calcParsentTextOut(glob_ahkArg7, argss)
	;glob_ahkArg8 := ifco_calcParsentTextOut(glob_ahkArg8, argss)
	;glob_ahkArg9 := ifco_calcParsentTextOut(glob_ahkArg9, argss)

	;glob_ahkArg1 := Trim(glob_ahkArg1, "`n")
	;glob_ahkArg2 := Trim(glob_ahkArg2, "`n")
	;glob_ahkArg3 := Trim(glob_ahkArg3, "`n")
	;glob_ahkArg4 := Trim(glob_ahkArg4, "`n")
	;glob_ahkArg5 := Trim(glob_ahkArg5, "`n")
	;glob_ahkArg6 := Trim(glob_ahkArg6, "`n")
	;glob_ahkArg7 := Trim(glob_ahkArg7, "`n")
	;glob_ahkArg8 := Trim(glob_ahkArg8, "`n")
	;glob_ahkArg9 := Trim(glob_ahkArg9, "`n")
}

ahkc_ahkArgssNull(){
	glob_ahkArg1 =
	glob_ahkArg2 =
	glob_ahkArg3 =
	glob_ahkArg4 =
	glob_ahkArg5 =
	glob_ahkArg6 =
	glob_ahkArg7 =
	glob_ahkArg8 =
	glob_ahkArg9 =
}

; ウインドウを操作するときに前もって指定する
ahkc_windowComProvision(GuiNum){
;	DetectHiddenWindows, On
;	DetectHiddenText, On
	if(glob_ahkArg1 == "A" || glob_ahkArg2 == "A" || glob_ahkArg3 == "A"  || glob_ahkArg4 == "A" || glob_ahkArg5 == "A" ){
		edc_hideCommGuiNotActiveIfCommOnly(GuiNum)
		windc_anyWaitActive()
		;Sleep, 500
	}
}

; 引数が多い場合のエラー表示
ahkc_ahkCommAverArgsErrMsg(argss){
	guit_errorAppend("引数が多いAhkコマンドのエラー。`nこのAhkコマンドは、パラメーターを減らして実行する`n" . argss)
	return False
}

/*
もう一つのエラー表示。ダイアログで停止して選択させる。

ahkc_ahkCommAverArgsErrMsg(argss){

	guit_errorAppend("Ahkコマンドのエラー。`n引数が多い`n" . argss)
	MsgBox , 4099 , Ahkコマンドのエラー。 , 以下のコマンドは引数が多い`n%argss%`n`nはい    処理を強制中断する`nいいえ   このコマンドをスキップして続行`nキャンセル  このコマンドをそのまま実行する, 60
	IfMsgBox, Yes
	{
		edi_afterCommandExeLogic()
		Exit
	}
	IfMsgBox, No
	{
		return True
	}
	IfMsgBox, Cancel
	{
		return False
	}
}
*/

; O_ahkErrorNotViewFlag が Trueならエラーを表示する。どちらでも ErrorLevel_TextRunRun には代入する。
ahkc_checkErrorLevelAhkComm(append){
	if(ErrorLevel >= 1){
		ErrorLevel_TextRunRun = %ErrorLevel%
		if(O_ahkErrorNotViewFlag == False){
			guit_errorAppend( "ErrorLevel   " . ErrorLevel  . "`n" . append)
		}
		return False
	}
	return True
}

; 文字列が関数なら  空の文字  を返す
ahkc_isFuncStr(argss){
	advice := "文字列が関数の書き方ではない"
	IfNotInString, argss, (
	{
		return  advice
	}
	funcArg_3 =
	StringSplit, funcArg_ , argss , ( , %A_Space%
	funcArg_1 := outs_textOutTrimss(funcArg_1)
	IsFunc_res := IsFunc(funcArg_1)
	if( IsFunc_res == 0 ){
		str := "その関数は存在しません"
		return  str
	}
	if(funcArg_3 != ""){
		return  advice
	}
	StringRight, funcArg_2Rigth1, funcArg_2, 1
	if(funcArg_2Rigth1 != ")"){
		return  advice
	}
	StringRight, argssRigth1, argss, 1
	if(argssRigth1 != ")"){
		return  advice
	}

	resStr := ahkc_IsFuncCountConfirm(funcArg_2, IsFunc_res)
	if( resStr != null ){
		return  resStr
	}
	return  null
}

; 引数の数と IsFunc の関数の返り値の数とで確認
ahkc_IsFuncCountConfirm(funcArg_2, IsFunc_res){
	; IsFunc_res は 引数の数より１大きいので引く(引数の数にする)
	IsFunc_res_1 := IsFunc_res - 1
	delimitChar := ","

	; まず、引数が０か１つかの関数かを調べる
	IfNotInString, funcArg_2, %delimitChar%
	{
		funcArg_2 := RTrim( funcArg_2, ")" )
		funcArg_2 := Trim(funcArg_2)
		if(funcArg_2 == ""){
			if(IsFunc_res_1 >= 1){
				str := IsFunc_res_1  . "つ以上の引数が必要な関数です。"
				return  str
			}
		} else {
			if(IsFunc_res_1 >= 2){
				str := IsFunc_res_1  . "つ以上の引数が必要な関数です。"
				return  str
			}
		}
		return  null
	}

	StringSplit, arg_, funcArg_2 , %delimitChar%, %A_Space%
	if(arg_11 != ""){
		str := "引数が１１以上ある関数は呼べません。"
	} else if(arg_10 != ""){
		if(IsFunc_res_1 >= 11){
			str := IsFunc_res_1  . "つ以上の引数が必要な関数です。"
			return  str
		}
	} else if(arg_9 != ""){
		if(IsFunc_res_1 >= 10){
			str := IsFunc_res_1  . "つ以上の引数が必要な関数です。"
			return  str
		}
	} else if(arg_8 != ""){
		if(IsFunc_res_1 >= 9){
			str := IsFunc_res_1  . "つ以上の引数が必要な関数です。"
			return  str
		}
	} else if(arg_7 != ""){
		if(IsFunc_res_1 >= 8){
			str := IsFunc_res_1  . "つ以上の引数が必要な関数です。"
			return  str
		}
	} else if(arg_6 != ""){
		if(IsFunc_res_1 >= 7){
			str := IsFunc_res_1  . "つ以上の引数が必要な関数です。"
			return  str
		}
	} else if(arg_5 != ""){
		if(IsFunc_res_1 >= 6){
			str := IsFunc_res_1  . "つ以上の引数が必要な関数です。"
			return  str
		}
	} else if(arg_4 != ""){
		if(IsFunc_res_1 >= 5){
			str := IsFunc_res_1  . "つ以上の引数が必要な関数です。"
			return  str
		}
	} else if(arg_3 != ""){
		if(IsFunc_res_1 >= 4){
			str := IsFunc_res_1  . "つ以上の引数が必要な関数です。"
			return  str
		}
	} else if(arg_2 != ""){
		if(IsFunc_res_1 >= 3){
			str := IsFunc_res_1  . "つ以上の引数が必要な関数です。"
			return  str
		}
	}

	return  null
}

ahkc_Process(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg3 != ""){
		if(glob_ahkArg4 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		Process, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		Process, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "Exist  Close  Priority  Wait  WaitClose`nProcess, Cmd, PID-or-Name [, Param3]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	; ErrorLevel を当たり前に使うので、エラーを表示させない
	cen_setOnlyErrorLevel_TextRunRun( True )
	;ahkc_checkErrorLevelAhkComm("")
	guit_setExplainNotShow(argss  . "`nを実行した", GuiNum)
}

ahkc_Run(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg4 != "") {
		if(glob_ahkArg5 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		ahkArg3 := glob_ahkArg3 . " UseErrorLevel"
		Run, %glob_ahkArg1% , %glob_ahkArg2%, %ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		ahkArg3 := glob_ahkArg3 . " UseErrorLevel"
		Run, %glob_ahkArg1% , %glob_ahkArg2%, %ahkArg3%
	} else if(glob_ahkArg2 != "") {
		Run, %glob_ahkArg1% , %glob_ahkArg2%, UseErrorLevel
	} else if(glob_ahkArg1 != "") {
		Run, %glob_ahkArg1% , , UseErrorLevel
	} else {
		str := "Run, Target [, WorkingDir, Max|Min|Hide|UseErrorLevel, OutputVarPID]`n*RunAs [exeファイル]で管理者で実行`nproperties [exeファイル]でプロパティ表示`nUseErrorLevel はすでに記入しているため、あえて記入する必要はない"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行した", GuiNum)
}

ahkc_RunWait(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	str =
	if(glob_ahkArg4 != "") {
		if(glob_ahkArg5 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		ahkArg3 := glob_ahkArg3 . " UseErrorLevel"
		RunWait, %glob_ahkArg1% , %glob_ahkArg2%, %ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		ahkArg3 := glob_ahkArg3 . " UseErrorLevel"
		RunWait, %glob_ahkArg1% , %glob_ahkArg2%, %ahkArg3%
	} else if(glob_ahkArg2 != "") {
		RunWait, %glob_ahkArg1% , %glob_ahkArg2%, UseErrorLevel
	} else if(glob_ahkArg1 != "") {
		RunWait, %glob_ahkArg1% , , UseErrorLevel
	} else {
		str := "RunWait, Target [, WorkingDir, Max|Min|Hide|UseErrorLevel, OutputVarPID]`nUseErrorLevel はすでに記入しているため、あえて記入する必要はない"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行した", GuiNum)
}

ahkc_RunAs(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	str =
	if(glob_ahkArg3 != "") {
		if(glob_ahkArg4 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		RunAs , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		RunAs , %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		RunAs , %glob_ahkArg1%
	} else {
		RunAs
		str := "RunAs を 解除`nRunAs [, User, Password, Domain] `nRunAs のみで解除"
		glob_runAsStatus := "通常"
		;guit_appendExplain(str)
		guit_setExplainNotShow(str, GuiNum)
		return
	}
	if( ahkc_checkErrorLevelAhkComm("RunAs の動作でエラー`n" . argss) ){
		glob_runAsStatus := glob_ahkArg1
	}
	;guit_appendExplain(argss)
	guit_setExplainNotShow(argss  . "`nを実行した", GuiNum)
}

ahkc_EnvAdd(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg3 != ""){
		if(glob_ahkArg4 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		EnvAdd, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		EnvAdd, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "EnvAdd, Var, Value [, TimeUnits]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	num := %glob_ahkArg1%
	guit_setExplainNotShow(glob_ahkArg1  . " の値は`n" . num, GuiNum)
}

ahkc_EnvSub(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg3 != ""){
		if(glob_ahkArg4 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		EnvSub, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		EnvSub, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "EnvSub, Var, Value [, TimeUnits]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	num := %glob_ahkArg1%
	guit_setExplainNotShow(glob_ahkArg1  . " の値は`n" . num, GuiNum)
}

ahkc_EnvMult(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg2 != ""){
		if(glob_ahkArg3 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		EnvMult, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "EnvMult, Var, Value"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	num := %glob_ahkArg1%
	guit_setExplainNotShow(glob_ahkArg1  . " の値は`n" . num, GuiNum)
}

ahkc_EnvDiv(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg2 != ""){
		if(glob_ahkArg3 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		if(glob_ahkArg2 == 0) {
			guit_appendExplain(argss . "`nのエラー。`n0を割る事はできない")
			return
		} else {
			EnvDiv, %glob_ahkArg1%, %glob_ahkArg2%
		}
	} else {
		str := "EnvDiv, Var, Value"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	num := %glob_ahkArg1%
	guit_setExplainNotShow(glob_ahkArg1  . " の値は`n" . num, GuiNum)
}

ahkc_Transform(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg4 != ""){
		if(glob_ahkArg5 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		Transform, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		Transform, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else {
		str := "Transform, OutputVar, Cmd, Value1 [, Value2]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	num := %glob_ahkArg1%
	guit_setExplainNotShow(num, GuiNum)
}

ahkc_Shutdown(argss, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != "") {
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		if(glob_ahkArg1 == 0 || glob_ahkArg1 == 1 || glob_ahkArg1 == 2 || glob_ahkArg1 == 4 || glob_ahkArg1 == 5){
			Shutdown, %glob_ahkArg1%
			ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
			return
		}
	}
	str := "Shutdown, Code`n0  ログオフ`n1  シャットダウン`n2  再起動`n4  強制的`n5  実行後電源を切る"
	guit_setExplainPurpose(str, GuiNum)
}

ahkc_ToolTip(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg4 != ""){
		if(glob_ahkArg5 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		ToolTip, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
		;timf_toolTipClose(5)
		;ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
		;return
	} else if(glob_ahkArg3 != ""){
		ToolTip, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		ToolTip, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != ""){
		ToolTip, %glob_ahkArg1%
	} else {
		ToolTip
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	;timf_toolTipClose(5)
}

ahkc_MsgBox(argss, pOut, GuiNum){
	str_local := "MsgBox [, Options, Title, Text, Timeout]`nが本来の形だが、Optionsの部分が指定できないので、`nその部分は 0 か 1 か 3 か 4097 以外は何を指定しても意味が無い。`nそれ以外の指定なら 4099 を指定している事になる"
	ahkc_argssSplit(argss)
	if(glob_ahkArg5 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return
		}
	}
	if(glob_ahkArg1 == 0){
		if(glob_ahkArg4 != ""){
			MsgBox, 0, %glob_ahkArg2%, %glob_ahkArg3% , %glob_ahkArg4%
		} else if(glob_ahkArg3 != ""){
			MsgBox, 0, %glob_ahkArg2%, %glob_ahkArg3%
		} else if(glob_ahkArg2 != ""){
			MsgBox, 0, %glob_ahkArg2%, %A_Space%
		} else {
			guit_setExplainPurpose(str_local, GuiNum)
		}
		cen_setOnlyErrorLevel_TextRunRun( True )
		;ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
		return
	}

	if(glob_ahkArg1 == 1){
		if(glob_ahkArg4 != ""){
			MsgBox, 1, %glob_ahkArg2%, %glob_ahkArg3% , %glob_ahkArg4%
		} else if(glob_ahkArg3 != ""){
			MsgBox, 1, %glob_ahkArg2%, %glob_ahkArg3%
		} else if(glob_ahkArg2 != ""){
			MsgBox, 1, %glob_ahkArg2%, %A_Space%
		} else {
			guit_setExplainPurpose(str_local, GuiNum)
		}
		cen_setOnlyErrorLevel_TextRunRun( True )
		;ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
		return
	}

	if(glob_ahkArg1 == 3){
		if(glob_ahkArg4 != ""){
			MsgBox, 3, %glob_ahkArg2%, %glob_ahkArg3% , %glob_ahkArg4%
		} else if(glob_ahkArg3 != ""){
			MsgBox, 3, %glob_ahkArg2%, %glob_ahkArg3%
		} else if(glob_ahkArg2 != ""){
			MsgBox, 3, %glob_ahkArg2%, %A_Space%
		} else {
			guit_setExplainPurpose(str_local, GuiNum)
		}
		cen_setOnlyErrorLevel_TextRunRun( True )
		;ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
		return
	}

	if(glob_ahkArg1 == 4097){
		if(glob_ahkArg4 != ""){
			MsgBox, 4097, %glob_ahkArg2%, %glob_ahkArg3% , %glob_ahkArg4%
		} else if(glob_ahkArg3 != ""){
			MsgBox, 4097, %glob_ahkArg2%, %glob_ahkArg3%
		} else if(glob_ahkArg2 != ""){
			MsgBox, 4097, %glob_ahkArg2%, %A_Space%
		} else {
			guit_setExplainPurpose(str_local, GuiNum)
		}
		cen_setOnlyErrorLevel_TextRunRun( True )
		;ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
		return
	}

	if(glob_ahkArg4 != ""){
		MsgBox, 4099, %glob_ahkArg2%, %glob_ahkArg3% , %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		MsgBox, 4099, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		MsgBox, 4099, %glob_ahkArg2%, %A_Space%
	} else if(glob_ahkArg1 != ""){
		MsgBox, %glob_ahkArg1%
	} else {
		guit_setExplainPurpose(str_local, GuiNum)
	}
	cen_setOnlyErrorLevel_TextRunRun( True )
	;ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
}


ahkc_WinWait(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg5 != ""){
		if(glob_ahkArg6 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		WinWait , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		WinWait , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		WinWait , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		WinWait , %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		WinWait , %glob_ahkArg1%
	} else {
		str := "WinWait, WinTitle, WinText, Seconds [, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_WinWaitActive(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg5 != ""){
		if(glob_ahkArg6 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		WinWaitActive , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		WinWaitActive , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		WinWaitActive , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		WinWaitActive , %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		WinWaitActive , %glob_ahkArg1%
	} else {
		str := "WinWaitActive, WinTitle, WinText, Seconds [, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_WinWaitClose(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg5 != ""){
		if(glob_ahkArg6 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		WinWaitClose , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		WinWaitClose , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		WinWaitClose , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		WinWaitClose , %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		WinWaitClose , %glob_ahkArg1%
	} else {
		str := "WinWaitClose, WinTitle, WinText, Seconds [, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_WinWaitNotActive(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg5 != ""){
		if(glob_ahkArg6 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		WinWaitNotActive , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		WinWaitNotActive , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		WinWaitNotActive , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		WinWaitNotActive , %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		WinWaitNotActive , %glob_ahkArg1%
	} else {
		str := "WinWaitNotActive, WinTitle, WinText, Seconds [, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_WinHide(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg4 != "") {
		if(glob_ahkArg5 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		WinHide , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		WinHide , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		WinHide , %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		WinHide , %glob_ahkArg1%
	} else {
		str := "WinHide [, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_WinClose(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg5 != ""){
		if(glob_ahkArg6 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		WinClose , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		WinClose , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		WinClose , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		WinClose , %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		WinClose , %glob_ahkArg1%
	} else {
		str := "WinClose [, WinTitle, WinText, SecondsToWait, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_WinMove(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg8 != ""){
		if(glob_ahkArg9 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		WinMove , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%, %glob_ahkArg8%
	} else if(glob_ahkArg7 != ""){
		WinMove , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%
	} else if(glob_ahkArg6 != ""){
		WinMove , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != ""){
		WinMove , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		WinMove , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		WinMove , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		WinMove , %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "WinMove, WinTitle, WinText, X, Y [, Width, Height, ExcludeTitle, ExcludeText]`nWinMove, X, Y"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_WinKill(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg5 != ""){
		if(glob_ahkArg6 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		WinKill , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		WinKill , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		WinKill , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		WinKill , %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		WinKill , %glob_ahkArg1%
	} else {
		str := "WinKill [, WinTitle, WinText, SecondsToWait, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_WinSet(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg6 != ""){
		if(glob_ahkArg7 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		if(glob_ahkArg2 == ""){
			WinSet, %glob_ahkArg1%, , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
		} else {
			WinSet, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
		}
	} else if(glob_ahkArg5 != "") {
		if(glob_ahkArg2 == ""){
			WinSet, %glob_ahkArg1%, , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
		} else {
			WinSet, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
		}
	} else if(glob_ahkArg4 != "") {
		if(glob_ahkArg2 == ""){
			WinSet, %glob_ahkArg1%, , %glob_ahkArg3%, %glob_ahkArg4%
		} else {
			WinSet, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
		}
	} else if(glob_ahkArg3 != "") {
		if(glob_ahkArg2 == ""){
			WinSet, %glob_ahkArg1%, , %glob_ahkArg3%
		} else {
			WinSet, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
		}
	} else if(glob_ahkArg2 != "") {
		WinSet, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		WinSet, %glob_ahkArg1%
	} else {
		str := "WinSet, AlwaysOnTop|Trans, On|Off|Toggle|Value(0-255) [, WinTitle, WinText, ExcludeTitle, ExcludeText]`nTop  Bottom  Topmost  Enable  Style  ExStyle  Transparent  Region"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_WinActivate(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg4 != "") {
		if(glob_ahkArg5 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		WinActivate , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		WinActivate , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		WinActivate , %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		WinActivate , %glob_ahkArg1%
	} else {
		str := "WinActivate [, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_WinShow(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg4 != "") {
		if(glob_ahkArg5 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		WinShow, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		WinShow, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		WinShow, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		WinShow, %glob_ahkArg1%
	} else {
		str := "WinShow [, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_WinSetTitle(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg5 != "") {
		if(glob_ahkArg6 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		WinSetTitle, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		WinSetTitle, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		WinSetTitle, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else {
		str := "WinSetTitle, WinTitle, WinText, NewTitle [, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_WinMenuSelectItem(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg9 != "") {
		WinMenuSelectItem, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%, %glob_ahkArg8%, %glob_ahkArg9%
	} else if(glob_ahkArg8 != "") {
		WinMenuSelectItem, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%, %glob_ahkArg8%
	} else if(glob_ahkArg7 != "") {
		WinMenuSelectItem, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%
	} else if(glob_ahkArg6 != "") {
		WinMenuSelectItem, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != "") {
		WinMenuSelectItem, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		WinMenuSelectItem, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		WinMenuSelectItem, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else {
		str := "WinMenuSelectItem, WinTitle, WinText, Menu [, SubMenu1, SubMenu2, SubMenu3, SubMenu4, SubMenu5, SubMenu6, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_DetectHiddenWindows(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != "") {
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		DetectHiddenWindows , %glob_ahkArg1%
	} else {
		str := "DetectHiddenWindows, On|Off"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_DetectHiddenText(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != "") {
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		DetectHiddenText , %glob_ahkArg1%
	} else {
		str := "DetectHiddenText, On|Off"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_SetTitleMatchMode(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != "") {
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		SetTitleMatchMode , %glob_ahkArg1%
	} else {
		str := "SetTitleMatchMode, Fast|Slow|RegEx|1|2|3"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_WinActivateBottom(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg4 != ""){
		if(glob_ahkArg5 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		WinActivateBottom, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		WinActivateBottom, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		WinActivateBottom, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		WinActivateBottom , %glob_ahkArg1%
	} else {
		str := "WinActivateBottom [, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_WinMaximize(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg4 != ""){
		if(glob_ahkArg5 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		WinMaximize, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		WinMaximize, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		WinMaximize, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		WinMaximize , %glob_ahkArg1%
	} else {
		str := "WinMaximize [, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_WinMinimize(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg4 != ""){
		if(glob_ahkArg5 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		WinMinimize, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		WinMinimize, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		WinMinimize, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		WinMinimize , %glob_ahkArg1%
	} else {
		str := "WinMinimize [, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_WinRestore(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg4 != ""){
		if(glob_ahkArg5 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		WinRestore, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		WinRestore, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		WinRestore, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		WinRestore , %glob_ahkArg1%
	} else {
		str := "WinRestore [, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_SetWinDelay(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != "") {
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		SetWinDelay , %glob_ahkArg1%
	} else {
		str := "SetWinDelay, Delay"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_SetControlDelay(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != "") {
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		SetControlDelay , %glob_ahkArg1%
	} else {
		str := "SetControlDelay, Delay"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_GroupAdd(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg6 != ""){
		if(glob_ahkArg7 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		GroupAdd, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != "") {
		GroupAdd, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		GroupAdd, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		GroupAdd, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		GroupAdd, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "GroupAdd, GroupName, WinTitle [, WinText, Label, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_GroupActivate(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg2 != ""){
		if(glob_ahkArg3 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		GroupActivate, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		GroupActivate, %glob_ahkArg1%
	} else {
		str := "GroupActivate, GroupName [, R]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_GroupClose(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg2 != ""){
		if(glob_ahkArg3 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		GroupClose, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		GroupClose, %glob_ahkArg1%
	} else {
		str := "GroupClose, GroupName [, A|R]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_GroupDeactivate(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg2 != ""){
		if(glob_ahkArg3 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		GroupDeactivate, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		GroupDeactivate, %glob_ahkArg1%
	} else {
		str := "GroupDeactivate, GroupName [, R]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_StatusBarWait(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg6 != ""){
		if(glob_ahkArg7 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		StatusBarWait, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != ""){
		StatusBarWait, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != ""){
		StatusBarWait, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		StatusBarWait, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		StatusBarWait, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		StatusBarWait , %glob_ahkArg1%
	} else {
		str := "StatusBarWait [, BarText, Seconds, Part#, WinTitle, WinText, Interval, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_FileSetAttrib(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg2 := outs_textOutToAbsolePath(glob_ahkArg2, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg4 != "") {
		if(glob_ahkArg5 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		FileSetAttrib, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		FileSetAttrib, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		FileSetAttrib, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		FileSetAttrib, %glob_ahkArg1%
	} else {
		str := "FileSetAttrib, Attributes(+-^RASHNOT) [, FilePattern, OperateOnFolders?, Recurse?]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_FileSetTime(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg2 := outs_textOutToAbsolePath(glob_ahkArg2, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg5 != "") {
		if(glob_ahkArg6 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		FileSetTime, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		FileSetTime, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		FileSetTime, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		FileSetTime, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		FileSetTime, %glob_ahkArg1%
	} else {
		str := "FileSetTime [, YYYYMMDDHH24MISS, FilePattern, WhichTime (M|C|A), OperateOnFolders?, Recurse?]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_IniWrite(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg4 != "") {
		if(glob_ahkArg5 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		IniWrite, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else {
		str := "IniWrite, Value, Filename, Section, Key"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_IniDelete(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg2 := outs_textOutToAbsolePath(glob_ahkArg2, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg3 != "") {
		if(glob_ahkArg4 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		IniDelete, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		IniDelete, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "IniDelete, Filename, Section [, Key]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_Send(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != "") {
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		edc_hideCommGuiNotActiveIfCommOnly(GuiNum)
		WinWaitActive , A, , 1
		ErrorLevel = 0
		;Sleep, 1000
		Send, %glob_ahkArg1%
	} else {
		str := "Send, Keys"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行した", GuiNum)
}

ahkc_SendRaw(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != "") {
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		edc_hideCommGuiNotActiveIfCommOnly(GuiNum)
		WinWaitActive , A, , 1
		ErrorLevel = 0
		;Sleep, 1000
		SendRaw, %glob_ahkArg1%
	} else {
		str := "SendRaw, Keys"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行した", GuiNum)
}

ahkc_SendInput(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != "") {
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		edc_hideCommGuiNotActiveIfCommOnly(GuiNum)
		WinWaitActive , A, , 1
		ErrorLevel = 0
		;Sleep, 1000
		SendInput, %glob_ahkArg1%
	} else {
		str := "SendInput, Keys"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行した", GuiNum)
}

ahkc_SendPlay(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != "") {
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		edc_hideCommGuiNotActiveIfCommOnly(GuiNum)
		WinWaitActive , A, , 1
		ErrorLevel = 0
		;Sleep, 1000
		SendPlay, %glob_ahkArg1%
	} else {
		str := "SendPlay, Keys"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行した", GuiNum)
}

ahkc_SendEvent(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != "") {
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		edc_hideCommGuiNotActiveIfCommOnly(GuiNum)
		WinWaitActive , A, , 1
		ErrorLevel = 0
		;Sleep, 1000
		SendEvent, %glob_ahkArg1%
	} else {
		str := "SendEvent, Keys"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行した", GuiNum)
}


ahkc_KeyWait(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg2 != "") {
		if(glob_ahkArg3 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		KeyWait, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		KeyWait, %glob_ahkArg1%
	} else {
		str := "KeyWait, KeyName [, Options]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	;ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	cen_setOnlyErrorLevel_TextRunRun( True )
	guit_setExplainNotShow(argss  . "`nを実行した", GuiNum)
}

ahkc_SendMode(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != "") {
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		SendMode, %glob_ahkArg1%
	} else {
		str := "SendMode, Event|Play|Input|InputThenPlay"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	;guit_appendExplain(argss  . "`nを実行した")
}

ahkc_BlockInput(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != "") {
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		BlockInput, %glob_ahkArg1%
	} else {
		str := "BlockInput, On|Off|Send|Mouse|SendAndMouse|Default|MouseMove|MouseMoveOff`nKeyWaitを使わないと、ボタンが押し下げられたままになるので注意"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	;guit_appendExplain(argss  . "`nを実行した")
}

ahkc_Gui(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg4 != "") {
		if(glob_ahkArg5 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		Gui, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		Gui, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		Gui, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		Gui, %glob_ahkArg1%
	} else {
		str := "Gui, sub-command [, Param2, Param3, Param4]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行した", GuiNum)
}

ahkc_GuiControl(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg3 != "") {
		if(glob_ahkArg4 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		GuiControl, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		GuiControl, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "GuiControl, Sub-command, ControlID [, Param3]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_Progress(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg5 != ""){
		if(glob_ahkArg6 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		Progress, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != ""){
		Progress, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		Progress, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		Progress, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != ""){
		Progress, %glob_ahkArg1%
	} else {
		str := "Progress, Param1 [, SubText, MainText, WinTitle, FontName]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_SplashImage(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg1 := outs_textOutToAbsolePath(glob_ahkArg1, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg6 != ""){
		if(glob_ahkArg7 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		SplashImage, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != ""){
		SplashImage, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != ""){
		SplashImage, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		SplashImage, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		SplashImage, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != ""){
		SplashImage, %glob_ahkArg1%
	} else {
		str := "SplashImage [, ImageFile, Options, SubText, MainText, WinTitle, FontName]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_SplashTextOn(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg4 != ""){
		if(glob_ahkArg5 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		SplashTextOn, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		SplashTextOn, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		SplashTextOn, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != ""){
		SplashTextOn, %glob_ahkArg1%
	} else {
		str := "SplashTextOn [, Width, Height, Title, Text]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_TrayTip(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg4 != ""){
		if(glob_ahkArg5 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		TrayTip, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		TrayTip, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		TrayTip, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != ""){
		TrayTip, %glob_ahkArg1%
	} else {
		str := "TrayTip [, Title, Text, Seconds, Options]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_StringCaseSense(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != "") {
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		StringCaseSense, %glob_ahkArg1%
	} else {
		str := "StringCaseSense, On|Off|Locale"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行`nただし、１つのサブルーチン内でのみ有効", GuiNum)
}

ahkc_Pause(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg2 != "") {
		if(glob_ahkArg3 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		;guit_appendExplain(argss  . "`nを実行")
		cen_trayPauseIconChangeBefore()
		Pause, %glob_ahkArg1%, %glob_ahkArg2%
		cen_trayIconChangeFromSuspendOrPause()
	}
	if(glob_ahkArg1 != "") {
		;guit_appendExplain(argss  . "`nを実行")
		cen_trayPauseIconChangeBefore()
		Pause, %glob_ahkArg1%
		cen_trayIconChangeFromSuspendOrPause()
	} else {
		str := "Pause [, On|Off|Toggle, OperateOnUnderlyingThread?]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
}

ahkc_Gosub(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != "") {
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		if( outs_checkIsLabel(glob_ahkArg1, GuiNum) == False ){
			return
		}
		Gosub, %glob_ahkArg1%
	} else {
		str := "Gosub, Label"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	;guit_appendExplain(argss  . "`nを実行")
}

ahkc_GoFunc(editAll, rightStrAll, hwnd, pOut, GuiNum, outPutSucceedFlag){
	; "" で囲まれてる文字を置き換える
	editAll := heard_dbQuouteReplace(editAll, False)
	; &&& がついてる場合 その左側の文字のみ使うようにする
	editAll := func_leftStrOrAllFromSearchStr(editAll, "&&& ")
	; >>> があれば outputの種類を変更する
	editAll := guit_outPutControl(editAll, outPutSucceedFlag)
	; "" で囲まれてる文字を戻す
	editAll := heard_dbQuouteReplaceReturn(editAll, A_LineFile, A_LineNumber, True, True)
	rightStr := func_separationSpaceRightOrNull(editAll)

	returnValue := ahkc_GoFunc_sub(rightStr)
	ahkc_checkErrorLevelAhkComm("関数のエラー`n" . rightStr)
	; 返り値があれば表示する
	if(returnValue != ""){
		guit_setExplainNotShow(returnValue, GuiNum)
	}

	; &&& がついてる場合の処理
	edi_andAndRStrExeLogic(rightStrAll, pOut, GuiNum, hwnd, outPutSucceedFlag)
}

ahkc_GoFunc_sub(com2){
	str =
	; 文字列が関数かどうかを確認
	advice := ahkc_isFuncStr(com2)
	if( advice != null ) {
		return advice
	}

	; 関数名とそれ以外の文字に分ける
	StringSplit, funcArg_ , com2 , ( , %A_Space%
	funcArg_1 := outs_textOutTrimss(funcArg_1)

	; 呼ぶと危険な関数をチェック
	if(funcArg_1 == A_ThisFunc){
		str := "その関数は呼ぶとループになる"
		return  str
	} else if(funcArg_1 == "ahkc_GoFunc"){
		str := "その関数は呼ぶとループになる"
		return  str
	}

	funcArg_2 := RTrim( funcArg_2, ")" )
	delimitChar := ","
	explain =

	; まず、引数が０か１つかの関数かを調べる
	IfNotInString, funcArg_2, %delimitChar%
	{
		funcArg_2 := Trim(funcArg_2)
		if(funcArg_2 == ""){
			str := %funcArg_1%()
			explain := funcArg_1 . "( )`nを実行した"
		} else {
			funcArg_2_value := ifco_answerFromEnyCalcOrStringUseFunc(funcArg_2, funcArg_1, com2, True)
			str := %funcArg_1%(funcArg_2_value)
			explain := funcArg_1 . "( )`n引数   " . funcArg_2_value . "`nを実行した"
		}
		if(str != ""){
			explain := "返り値   " . str . "`n" . explain
		}
		cen_easyCheckAppendNotShow(explain . "`n" . A_ThisFunc . "`nA_LineNumber  " . A_LineNumber)

		return  str
	}
	; 引数が２つ以上の関数の場合
	StringSplit, arg_ , funcArg_2 , %delimitChar%, %A_Space%
	arg_1_value := ifco_answerFromEnyCalcOrStringUseFunc(arg_1, funcArg_1, com2, True)
	arg_2_value := ifco_answerFromEnyCalcOrStringUseFunc(arg_2, funcArg_1, com2, False)
	arg_3_value := ifco_answerFromEnyCalcOrStringUseFunc(arg_3, funcArg_1, com2, False)
	arg_4_value := ifco_answerFromEnyCalcOrStringUseFunc(arg_4, funcArg_1, com2, False)
	arg_5_value := ifco_answerFromEnyCalcOrStringUseFunc(arg_5, funcArg_1, com2, False)
	arg_6_value := ifco_answerFromEnyCalcOrStringUseFunc(arg_6, funcArg_1, com2, False)
	arg_7_value := ifco_answerFromEnyCalcOrStringUseFunc(arg_7, funcArg_1, com2, False)
	arg_8_value := ifco_answerFromEnyCalcOrStringUseFunc(arg_8, funcArg_1, com2, False)
	arg_9_value := ifco_answerFromEnyCalcOrStringUseFunc(arg_9, funcArg_1, com2, False)
	arg_10_value := ifco_answerFromEnyCalcOrStringUseFunc(arg_10, funcArg_1, com2, False)

	if(arg_11 != ""){
		guit_errorAppend("引数が１１以上ある関数は呼べません。`n" . com2)
		return ""
	} else if(arg_10 != ""){
		str := %funcArg_1%(arg_1_value, arg_2_value, arg_3_value, arg_4_value, arg_5_value, arg_6_value, arg_7_value, arg_8_value, arg_9_value, arg_10_value)
		explain := funcArg_1 . "( )`n引数   " . arg_1_value . ",  " . arg_2_value . ",  " . arg_3_value . ",  " . arg_4_value . ",  " . arg_5_value . ",  " . arg_6_value . ",  " . arg_7_value . ",  " . arg_8_value . ",  " . arg_9_value . ",  " . arg_10_value . "`nを実行した"
	} else if(arg_9 != ""){
		explain := funcArg_1 . "( )`n引数   " . arg_1_value . ",  " . arg_2_value . ",  " . arg_3_value . ",  " . arg_4_value . ",  " . arg_5_value . ",  " . arg_6_value . ",  " . arg_7_value . ",  " . arg_8_value . ",  " . arg_9_value . "`nを実行した"
		str := %funcArg_1%(arg_1_value, arg_2_value, arg_3_value, arg_4_value, arg_5_value, arg_6_value, arg_7_value, arg_8_value, arg_9_value)
	} else if(arg_8 != ""){
		str := %funcArg_1%(arg_1_value, arg_2_value, arg_3_value, arg_4_value, arg_5_value, arg_6_value, arg_7_value, arg_8_value)
		explain := funcArg_1 . "( )`n引数   " . arg_1_value . ",  " . arg_2_value . ",  " . arg_3_value . ",  " . arg_4_value . ",  " . arg_5_value . ",  " . arg_6_value . ",  " . arg_7_value . ",  " . arg_8_value . "`nを実行した"
	} else if(arg_7 != ""){
		str := %funcArg_1%(arg_1_value, arg_2_value, arg_3_value, arg_4_value, arg_5_value, arg_6_value, arg_7_value)
		explain := funcArg_1 . "( )`n引数   " . arg_1_value . ",  " . arg_2_value . ",  " . arg_3_value . ",  " . arg_4_value . ",  " . arg_5_value . ",  " . arg_6_value . ",  " . arg_7_value . "`nを実行した"
	} else if(arg_6 != ""){
		str := %funcArg_1%(arg_1_value, arg_2_value, arg_3_value, arg_4_value, arg_5_value, arg_6_value)
		explain := funcArg_1 . "( )`n引数   " . arg_1_value . ",  " . arg_2_value . ",  " . arg_3_value . ",  " . arg_4_value . ",  " . arg_5_value . ",  " . arg_6_value . "`nを実行した"
	} else if(arg_5 != ""){
		str := %funcArg_1%(arg_1_value, arg_2_value, arg_3_value, arg_4_value, arg_5_value)
		explain := funcArg_1 . "( )`n引数   " . arg_1_value . ",  " . arg_2_value . ",  " . arg_3_value . ",  " . arg_4_value . ",  " . arg_5_value . "`nを実行した"
	} else if(arg_4 != ""){
		str := %funcArg_1%(arg_1_value, arg_2_value, arg_3_value, arg_4_value)
		explain := funcArg_1 . "( )`n引数   " . arg_1_value . ",  " . arg_2_value . ",  " . arg_3_value . ",  " . arg_4_value . "`nを実行した"
	} else if(arg_3 != ""){
		str := %funcArg_1%(arg_1_value, arg_2_value, arg_3_value)
		explain := funcArg_1 . "( )`n引数   " . arg_1_value . ",  " . arg_2_value . ",  " . arg_3_value . "`nを実行した"
	} else if(arg_2 != ""){
		str := %funcArg_1%(arg_1_value, arg_2_value)
		explain := funcArg_1 . "( )`n引数   " . arg_1_value . ",  " . arg_2_value . "`nを実行した"
	} else {
		guit_errorAppend("引数の数が不明", A_LineFile, A_LineNumber)
	}
	if(str != ""){
		explain := "返り値   " . str . "`n" . explain
	}
	cen_easyCheckAppendNotShow(explain . "`n" . A_ThisFunc . "`nA_LineNumber  " . A_LineNumber)
	return  str
}

; ""で囲まれてる文字列か、変数名かを判別
ahkc_dbQuouteOrVariable(arg, errViewFlag){
	if(arg == ""){
		return  ""
	}
	dbQuout = "	;	"
	IfInString, arg, %dbQuout%
	{
		; "がありながら、 ""で囲まれていないときはエラー
		StringLeft, argLeft1, arg, 1
		if(argLeft1 != dbQuout){
			return  ""
		}
		StringRight, argRight1, arg, 1
		if(argRight1 != dbQuout){
			return  ""
		}
		returnValue := Trim(arg, dbQuout)
		; `n の文字列を改行に置換
		returnValue := func_linefeedReplace(returnValue)
		return  returnValue
	}
	; 数値ならそのまま使う
	If arg is number
	{
		return  arg
	}
	; テキストアウトも可能にする
	arg := outs_textOutTrimss(arg)
	;" がなく、数値でもないなら、変数名と判断する
	if( outs_valueValidatorRulesNot(arg) ){
		guit_errorAppendViewFlag(errViewFlag, "変数として使用できないの文字が入っている。`n変数名  " . arg)
		return ""
	}
	returnValue := %arg%
	return returnValue
}

ahkc_SetTimer(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg2 != "") {
		if(glob_ahkArg3 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		if( outs_checkIsLabel(glob_ahkArg1, GuiNum) == False ){
			return
		}
		SetTimer, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		if( outs_checkIsLabel(glob_ahkArg1, GuiNum) == False ){
			return
		}
		SetTimer, %glob_ahkArg1%
	} else {
		str := "SetTimer, Label [, Period|On|Off]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_Menu(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg5 != ""){
		if(glob_ahkArg6 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		Menu, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		Menu, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		Menu, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		Menu, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "Menu, MenuName, Cmd [, P3, P4, P5]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	; メニューを閉じた後に表示してほしくないのであえて表示させない
	;guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_SoundPlay(argss, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg1 := outs_textOutToAbsolePath(glob_ahkArg1, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg2 != ""){
		if(glob_ahkArg3 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		SoundPlay, %glob_ahkArg1% , %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		SoundPlay, %glob_ahkArg1%
	} else {
		str := "SoundPlay, Filename [, wait]`n*-1  Beep音`n*16  一般の警告`n*32  問い合わせ`n*48  警告`n*64  情報"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	; 音を止める時、エラーを表示させたくないのでコメントに
	;ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_SoundBeep(argss, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg2 != ""){
		if(glob_ahkArg3 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		SoundBeep, %glob_ahkArg1% , %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		SoundBeep, %glob_ahkArg1%
	} else {
		SoundBeep
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_SetWorkingDir(argss, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg1 := outs_textOutToAbsolePath(glob_ahkArg1, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg1 != "") {
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		SetWorkingDir, %glob_ahkArg1%
	} else {
		str := "SetWorkingDir, DirName"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_FileCopyDir(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg1 := outs_textOutToAbsolePath(glob_ahkArg1, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg3 != ""){
		if(glob_ahkArg4 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		FileCopyDir, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		FileCopyDir, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "FileCopyDir, Source, Dest [, Flag]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_FileRemoveDir(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg1 := outs_textOutToAbsolePath(glob_ahkArg1, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg2 != ""){
		if(glob_ahkArg3 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		FileRemoveDir, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != ""){
		FileRemoveDir, %glob_ahkArg1%
	} else {
		str := "FileRemoveDir, Path [, Recurse? (1 = yes)]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_FileCreateDir(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg1 := outs_textOutToAbsolePath(glob_ahkArg1, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg1 != ""){
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		FileCreateDir, %glob_ahkArg1%
	} else {
		str := "FileCreateDir, Path"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_FileRecycle(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg1 := outs_textOutToAbsolePath(glob_ahkArg1, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg1 != ""){
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		FileRecycle, %glob_ahkArg1%
	} else {
		str := "FileRecycle, FilePattern"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_FileRecycleEmpty(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg1 := outs_textOutToAbsolePath(glob_ahkArg1, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg1 != ""){
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		FileRecycleEmpty, %glob_ahkArg1%
	} else {
		FileRecycleEmpty
		str := argss  . "`nを実行`nFileRecycleEmpty [, C:\]"
		guit_setExplainNotShow(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_FileDelete(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg1 := outs_textOutToAbsolePath(glob_ahkArg1, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg1 != ""){
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		FileDelete, %glob_ahkArg1%
	} else {
		str := "FileDelete, FilePattern"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_FileRead(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg2 := outs_textOutToAbsolePath(glob_ahkArg2, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg2 != ""){
		if(glob_ahkArg3 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		FileRead, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "FileRead, OutputVar, Filename"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_SplitPath(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg1 := outs_textOutToAbsolePath(glob_ahkArg1, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg6 != ""){
		if(glob_ahkArg7 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		SplitPath, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != "") {
		SplitPath, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		SplitPath, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		SplitPath, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		SplitPath, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "SplitPath, InputVar [, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_FileEncoding(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != ""){
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		FileEncoding, %glob_ahkArg1%
	} else {
		FileEncoding
		str := argss  . "`nを実行`nFileEncoding [, Encoding]"
		guit_setExplainNotShow(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_FileMoveDir(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg1 := outs_textOutToAbsolePath(glob_ahkArg1, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg3 != ""){
		if(glob_ahkArg4 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		FileMoveDir, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		FileMoveDir, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "FileMoveDir, Source, Dest [, Flag (2 = overwrite)]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_FileCopy(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg1 := outs_textOutToAbsolePath(glob_ahkArg1, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg3 != ""){
		if(glob_ahkArg4 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		FileCopy, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		FileCopy, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "FileCopy, Source, Dest [, Flag (1 = overwrite)]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_FileMove(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg1 := outs_textOutToAbsolePath(glob_ahkArg1, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg3 != ""){
		if(glob_ahkArg4 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		FileMove, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		FileMove, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "FileMove, Source, Dest [, Flag (1 = overwrite)]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_FileAppend(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	; `n などを改行に変えるのは、var1 = a`n と var1 := "a`n" の方でのみ実行する
	;Transform, glob_ahkArg1, Deref, %glob_ahkArg1%
	if(glob_ahkArg2 != ""){
		if(glob_ahkArg3 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		; ファイル名が * だった場合、`n を入れないと、すぐに出力されないので `n を加えて出力する
		if(glob_ahkArg2 == "*"){
			FileAppend, %glob_ahkArg1%`n, %glob_ahkArg2%
		} else {
			FileAppend, %glob_ahkArg1%, %glob_ahkArg2%
		}
	} else if(glob_ahkArg1 != ""){
		FileAppend, %glob_ahkArg1%
	} else {
		str := "FileAppend [, Text, Filename]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_FileCreateShortcut(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	glob_ahkArg1 := outs_textOutToAbsolePath(glob_ahkArg1, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(glob_ahkArg6 != ""){
		if(glob_ahkArg7 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		FileCreateShortcut, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != ""){
		FileCreateShortcut, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != ""){
		FileCreateShortcut, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		FileCreateShortcut, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		FileCreateShortcut, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "FileCreateShortcut, Target, C:\My Shortcut.lnk [, WorkingDir, Args, Description, IconFile, ShortcutKey, IconNumber, RunState]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_Drive(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg3 != ""){
		if(glob_ahkArg4 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		Drive, %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		Drive, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != ""){
		Drive, %glob_ahkArg1%
	} else {
		str := "Drive, Label [, Drive , NewLabel]`nDrive, Eject [, Drive , Retract?]`nDrive, Lock, Drive`nDrive, Unlock, Drive"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_SetEnv(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg2 != "") {
		if(glob_ahkArg3 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		SetEnv, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "SetEnv, Var, Value"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow("変数  " . glob_ahkArg1  . " に`n" . glob_ahkArg2  . " を代入", GuiNum)
}

ahkc_CoordMode(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg2 != "") {
		if(glob_ahkArg3 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		CoordMode, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		CoordMode, %glob_ahkArg1%
	} else {
		str := "CoordMode, ToolTip|Pixel|Mouse [, Screen|Relative]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_AutoTrim(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != "") {
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		AutoTrim, %glob_ahkArg1%
	} else {
		str := "AutoTrim, On|Off"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_ClipWait(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg3 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return
		}
	}
	if(glob_ahkArg2 != "") {
		ClipWait, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		ClipWait, %glob_ahkArg1%
	} else {
		ClipWait
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_Control(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg6 != "") {
		if(glob_ahkArg7 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		Control , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != "") {
		Control , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		Control , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		Control , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		Control , %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		Control , %glob_ahkArg1%
	} else {
		str := "Control, Cmd [, Value, Control, WinTitle, WinText, ExcludeTitle, ExcludeText]`nCheck UnCheck  Enable  Disable  Show  Hide  Style,N  ExStyle,N`n  Add,String  Delete,N  Choose,N  ChooseString,String  EditPaste,String"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_ControlSend(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg6 != "") {
		if(glob_ahkArg7 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		ControlSend , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != "") {
		ControlSend , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		ControlSend , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		ControlSend , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		ControlSend , %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "ControlSend [, Control, Keys, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_ControlFocus(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg5 != "") {
		if(glob_ahkArg6 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		ControlFocus , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		ControlFocus , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		ControlFocus , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		ControlFocus , %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "ControlFocus [, Control, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_ControlMove(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg6 != "") {
		if(glob_ahkArg7 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		ControlMove , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != "") {
		ControlMove , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		ControlMove , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else {
		str := "ControlMove, Control, X, Y, Width, Height [, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_ControlSetText(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg6 != "") {
		if(glob_ahkArg7 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		ControlSetText , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != "") {
		ControlSetText , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		ControlSetText , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		ControlSetText , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		ControlSetText , %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "ControlSetText, Control, NewText [, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_ControlClick(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg6 != "") {
		if(glob_ahkArg7 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		ControlClick , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != "") {
		ControlClick , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != "") {
		ControlClick , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != "") {
		ControlClick , %glob_ahkArg1%, %glob_ahkArg2%, %glob_ahkArg3%
	} else if(glob_ahkArg2 != "") {
		ControlClick , %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		ControlClick , %glob_ahkArg1%
	} else {
		str := "ControlClick [, Control-or-Pos, WinTitle, WinText, WhichButton, ClickCount, Options, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_URLDownloadToFile(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg2 != "") {
		if(glob_ahkArg3 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		URLDownloadToFile , %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "URLDownloadToFile, URL, Filename"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	res := ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
	if(res){
		str := glob_ahkArg2  . "  のファイルにダウンロード"
		guit_appendExplain(str)
	}
}

ahkc_SoundSetWaveVolume(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg2 != "") {
		if(glob_ahkArg3 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		SoundSetWaveVolume , %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		SoundSetWaveVolume , %glob_ahkArg1%
	} else {
		str := "SoundSetWaveVolume, Percent [, DeviceNumber]`n-100から100で指定`n-や+で始まる場合現在の値からの相対値"
		guit_setExplainPurpose(str, GuiNum)
	}
	res := ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	if(res){
		guit_setExplainNotShow(argss  . "  を実行", GuiNum)
	}
}

ahkc_MouseMove(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg4 != ""){
		if(glob_ahkArg5 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		MouseMove, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		MouseMove, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		MouseMove, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "MouseMove, X, Y [, Speed, R]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行した", GuiNum)
}

ahkc_MouseClick(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg7 != ""){
		if(glob_ahkArg8 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		MouseClick, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%
	} else if(glob_ahkArg6 != ""){
		MouseClick, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != ""){
		MouseClick, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != ""){
		MouseClick, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		MouseClick, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg1 != ""){
		MouseClick, %glob_ahkArg1%
	} else {
		str := "MouseClick, WhichButton [, X, Y, ClickCount, Speed, D|U, R]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行した", GuiNum)
}

ahkc_MouseClickDrag(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg6 != ""){
		if(glob_ahkArg7 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		MouseClickDrag, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != ""){
		MouseClickDrag, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else {
		str := "MouseClickDrag, WhichButton, X1, Y1, X2, Y2 [, Speed, R]`n現時点では７番目の引数には対応していない"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行した", GuiNum)
}

ahkc_Click(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg6 != ""){
		if(glob_ahkArg7 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		Click, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != ""){
		Click, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != ""){
		Click, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		Click, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		Click, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != ""){
		Click, %glob_ahkArg1%
	} else {
		Click
		str := argss  . "を実行した。`nClick[, Button, up/down, x, y, count, rel]"
		guit_setExplainNotShow(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行した", GuiNum)
}

ahkc_Hotkey(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg4 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return
		}
	}

	if(glob_ahkArg1 == "IfWinActive"){
		if(glob_ahkArg2 != ""){
			Hotkey, IfWinActive , %glob_ahkArg2%
		} else if(glob_ahkArg1 != ""){
			Hotkey, IfWinActive
		}
		errorStr := "ホットキーの登録に失敗している。`n" . argss
		ahkc_checkErrorLevelAhkComm(errorStr)
		return
	}

	if(glob_ahkArg3 != ""){
		ahkArg3 := glob_ahkArg3 . " UseErrorLevel"
		Hotkey, %glob_ahkArg1% , %glob_ahkArg2%, %ahkArg3%
	} else if(glob_ahkArg2 != ""){
		Hotkey, %glob_ahkArg1%, %glob_ahkArg2%, UseErrorLevel
	} else if(glob_ahkArg1 != ""){
		Hotkey, %glob_ahkArg1%, , UseErrorLevel
	} else {
		str := "Hotkey, KeyName [, Label, Options]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	if(ErrorLevel == 1){
		errorStr := "ホットキーの登録に失敗している。`nそのサブルーチンは存在しない。`n" . argss
	} else if(ErrorLevel == 2){
		errorStr := "ホットキーの登録に失敗している。`n指定のキーは登録できない。`n" . argss
	} else {
		errorStr := "ホットキーの登録に失敗している。`n" . argss
	}

	if( ahkc_checkErrorLevelAhkComm(errorStr) ){
		guit_setExplain(argss . "  が実行された。", GuiNum)
	}
}

ahkc_Sleep(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != ""){
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		Sleep, %glob_ahkArg1%
	} else {
		str := "Sleep, Delay（ミリ秒で指定）"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_Suspend(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != ""){
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		Suspend, %glob_ahkArg1%
		cen_trayIconChangeFromSuspendOrPause()
	} else {
		str := "Suspend [, On|Off|Toggle|Permit]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	;guit_appendExplain(argss  . "`nを実行")
}

ahkc_Exit(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != ""){
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		edi_afterCommandExeLogic()
		Exit, %glob_ahkArg1%
	} else {
		edi_afterCommandExeLogic()
		Exit
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplain(argss  . "`nを実行`nあくまで１つのサブルーチンのみ終了", GuiNum)
}

ahkc_ExitApp(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != ""){
		edi_afterCommandExeLogic()
		ExitApp, %glob_ahkArg1%
	} else {
		edi_afterCommandExeLogic()
		ExitApp
	}
}

ahkc_OnExit(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != ""){
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		if( outs_checkIsLabel(glob_ahkArg1, GuiNum) == False ){
			return
		}
		OnExit, %glob_ahkArg1%
	} else {
		str := "OnExit [, Label]`n※注意  指定したサブルーチンの処理の中で、`n必ず ExitApp を入れておくこと。`nでなければこのソフトが何をしても終了しなくなる。"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_ListLines(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != ""){
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		ListLines, %glob_ahkArg1%
	} else {
		ListLines
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
}

ahkc_OutputDebug(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg1 != ""){
		if(glob_ahkArg2 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		OutputDebug, %glob_ahkArg1%
	} else {
		guit_setExplainPurpose("OutputDebug, Text", GuiNum)
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_SetFormat(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg2 != ""){
		if(glob_ahkArg3 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		SetFormat, %glob_ahkArg1%, %glob_ahkArg2%
	} else {
		str := "SetFormat, float|integer, TotalWidth.DecimalPlaces|hex|d"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	;guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_SendMessage(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg8 != ""){
		if(glob_ahkArg9 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		SendMessage, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%, %glob_ahkArg8%
	} else if(glob_ahkArg7 != ""){
		SendMessage, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%
	} else if(glob_ahkArg6 != ""){
		SendMessage, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != ""){
		SendMessage, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != ""){
		SendMessage, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		SendMessage, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		SendMessage, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != ""){
		SendMessage, %glob_ahkArg1%
	} else {
		str := "SendMessage, Msg [, wParam, lParam, Control, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行した", GuiNum)
}

ahkc_PostMessage(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	if(glob_ahkArg8 != ""){
		if(glob_ahkArg9 != ""){
			if( ahkc_ahkCommAverArgsErrMsg(argss) ){
				return
			}
		}
		PostMessage, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%, %glob_ahkArg8%
	} else if(glob_ahkArg7 != ""){
		PostMessage, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%, %glob_ahkArg7%
	} else if(glob_ahkArg6 != ""){
		PostMessage, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%, %glob_ahkArg6%
	} else if(glob_ahkArg5 != ""){
		PostMessage, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%, %glob_ahkArg5%
	} else if(glob_ahkArg4 != ""){
		PostMessage, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%, %glob_ahkArg4%
	} else if(glob_ahkArg3 != ""){
		PostMessage, %glob_ahkArg1%, %glob_ahkArg2% , %glob_ahkArg3%
	} else if(glob_ahkArg2 != ""){
		PostMessage, %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != ""){
		PostMessage, %glob_ahkArg1%
	} else {
		str := "PostMessage, Msg [, wParam, lParam, Control, WinTitle, WinText, ExcludeTitle, ExcludeText]"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行した", GuiNum)
}

ahkc_SetKeyDelay(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg3 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return
		}
	}
	if(glob_ahkArg2 != "") {
		SetKeyDelay , %glob_ahkArg1%, %glob_ahkArg2%
	} else if(glob_ahkArg1 != "") {
		SetKeyDelay , %glob_ahkArg1%
	} else {
		SetKeyDelay
		str := "SetKeyDelay [, Delay, PressDuration]"
		guit_setExplainNotShow(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_SetStoreCapslockMode(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg2 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return
		}
	}
	if(glob_ahkArg1 != "") {
		StringLower, argLower, glob_ahkArg1
		if( argLower == "on" || argLower == "off" ){
			SetStoreCapslockMode , %glob_ahkArg1%
		} else {
			guit_errorAppend("SetStoreCapslockModeのエラー。`nOn か Off 以外が指定されている`n" . argss)
			return
		}
	} else {
		str := "SetStoreCapslockMode, On|Off"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_SetCapsLockState(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg2 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return
		}
	}
	if(glob_ahkArg1 != "") {
		StringLower, argLower, glob_ahkArg1
		if( argLower == "on" || argLower == "off" || argLower == "alwayson" || argLower == "alwaysoff" ){
			SetCapsLockState , %glob_ahkArg1%
		} else {
			guit_errorAppend("SetCapsLockStateのエラー。`nOn か Off か AlwaysOn か AlwaysOff 以外が指定されている`n" . argss)
			return
		}
	} else {
		str := "SetCapsLockState, On|Off|AlwaysOn|AlwaysOff"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_SetScrollLockState(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg2 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return
		}
	}
	if(glob_ahkArg1 != "") {
		StringLower, argLower, glob_ahkArg1
		if( argLower == "on" || argLower == "off" || argLower == "alwayson" || argLower == "alwaysoff" ){
			SetScrollLockState , %glob_ahkArg1%
		} else {
			guit_errorAppend("SetScrollLockStateのエラー。`nOn か Off か AlwaysOn か AlwaysOff 以外が指定されている`n" . argss)
			return
		}
	} else {
		str := "SetScrollLockState, On|Off|AlwaysOn|AlwaysOff"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_SetNumLockState(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg2 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return
		}
	}
	if(glob_ahkArg1 != "") {
		StringLower, argLower, glob_ahkArg1
		if( argLower == "on" || argLower == "off" || argLower == "alwayson" || argLower == "alwaysoff" ){
			SetNumLockState , %glob_ahkArg1%
		} else {
			guit_errorAppend("SetNumLockStateのエラー。`nOn か Off か AlwaysOn か AlwaysOff 以外が指定されている`n" . argss)
			return
		}
	} else {
		str := "SetNumLockState, On|Off|AlwaysOn|AlwaysOff"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_SetMouseDelay(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg2 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return
		}
	}
	if(glob_ahkArg1 != "") {
		SetMouseDelay , %glob_ahkArg1%
	} else {
		str := "SetMouseDelay, Delay"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}

ahkc_SetDefaultMouseSpeed(argss, pOut, GuiNum){
	ahkc_argssSplit(argss)
	ahkc_windowComProvision(GuiNum)
	if(glob_ahkArg2 != ""){
		if( ahkc_ahkCommAverArgsErrMsg(argss) ){
			return
		}
	}
	if(glob_ahkArg1 != "") {
		SetDefaultMouseSpeed , %glob_ahkArg1%
	} else {
		str := "SetDefaultMouseSpeed, Speed"
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	ahkc_checkErrorLevelAhkComm("AHKコマンドのエラー`n" . argss)
	guit_setExplainNotShow(argss  . "`nを実行", GuiNum)
}
