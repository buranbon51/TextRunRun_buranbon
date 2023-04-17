; 必須 glob gGlob guf func outs heard
; chec cof syf aut auts



edi_commandExeLogic(argStr, historyStr, pControl, GuiNum, hwnd, notShortKeyFlag, andFlag=False, outPutSucceedFlag=False){

	glob_commSuccessFlag := True
	
	argStr := Trim( argStr )
	; タブ は スペース に変える
	IfInString, argStr, `t
	{
		StringReplace, argStr, argStr, `t , %A_Space%, All
	}

	if(func_checkDangerStr(argStr)){	; 危険な文字をチェック
		guit_errorAppend("危険な文字あり。")
		return
	}


	mainCom := func_separationSpaceLeftOrAll(argStr)	; 最初の単語とそれ以外に分ける
	rightStr := func_separationSpaceRightOrNull(argStr)
	; バックアップ
	rightStrAll := rightStr


	; 入力補完を表示させる系のコマンド
	if( cof_syscommandPopup(mainCom, pControl, GuiNum) ) {
		func_sendEndToHwndControle(hwnd)
		return
	}

	; ショートカットキーの場合は入力補完の表示は無視する
	if(notShortKeyFlag){
		if( edi_pushEnterFromListEditAnotherGui(GuiNum, andFlag) ){	; 入力補完が表示していたら、ここで止める
			return
		}
	}

	if(argStr == "") {	; 少し遅いが、何も入力してないとき終了。（入力補完の決定の後におきたかった。）
		return
	}

	; フォーカス位置で動作が変わるコマンド
	if( cof_syscommandEarly(mainCom, rightStr, pControl, hwnd, GuiNum) ) {
		;func_sendEndToHwndControle(hwnd)
		return
	}

	argStrDbReplace := heard_dbQuouteReplace(argStr, False)
	; <<< があれば ファイルの中身か、Guiの文字列を引数として、入れ込む。引数のみに使用する
	argStrDbReplace := cinp_inputControlSecondArg(argStrDbReplace)
	argStr := heard_dbQuouteReplaceReturn(argStrDbReplace, A_LineFile, A_LineNumber, True, True)

	mainCom := func_separationSpaceLeftOrAll(argStr)	; 最初の単語とそれ以外に分ける
	rightStr := func_separationSpaceRightOrNull(argStr)

	; 早めに実行したいコマンド。履歴に加えない
	if( cof_syscommandBefore(mainCom, rightStr, pControl, GuiNum) ) {
		return
	}

	; &&& を特殊に使う。そして、 >>> を使った処理は実行させたい。
	if( cof_sysCommSpecial(mainCom, rightStr, argStr, rightStrAll, hwnd, pControl, GuiNum, historyStr, andFlag, outPutSucceedFlag) ){
		; 現時点では、履歴に残さなくてもいいとする
		;edi_historyInsert(historyStr, hwnd, andFlag)
		return
	}


	; &&& が最初にあった場合に対応。実行させるようにした
	if(mainCom == "&&&"){
		edi_andAndRStrExeLogic(mainCom . " " . rightStrAll, pControl, GuiNum, hwnd, outPutSucceedFlag)
		return
	}
	; 左端がいずれかだったら、ここでストップ
	if( edi_trueInCaseEnyWord(mainCom, "<<<", ">>>", "1>>", ">>&", "2>>") ){
		edi_andAndRStrExeLogic(rightStrAll, pControl, GuiNum, hwnd, outPutSucceedFlag)
		return
	}

	; ""の文字列を 置き換える
	argStrDbReplace := heard_dbQuouteReplace(argStr, True)

	; &&& がついてる場合 その左側の文字のみ使うようにする
	argStrDbReplace := func_leftStrOrAllFromSearchStr(argStrDbReplace, "&&& ")

	; >>> があれば outputの種類を変更する
	argStrDbReplace := guit_outPutControl(argStrDbReplace, outPutSucceedFlag)

	; "" で囲んだ文字は %%で展開しない
	argStrDbReplaceTextOut := outs_textOutTrimss(argStrDbReplace)
	; "" を取り除いた状態で元に戻す
	argStrTextOut := heard_dbQuouteReplaceReturn(argStrDbReplaceTextOut, A_LineFile, A_LineNumber, False, True)
	rightStrTextOut := func_separationSpaceRightOrNull(argStrTextOut)


	; 早めに実行したいが、履歴には残したいコマンド。textOutもしている
	if( cof_sysNotSplit(mainCom, rightStrTextOut, pControl, GuiNum) ){
		edi_commEndMiniEdit(historyStr, hwnd, andFlag, rightStrAll, pControl, GuiNum, outPutSucceedFlag)
		return
	}

	argStr := heard_dbQuouteReplaceReturn(argStrDbReplace, A_LineFile, A_LineNumber, True, True)
	; rightStr は &open系 までは使わないが、ここで作っておく
	rightStr := func_separationSpaceRightOrNull(argStr)

	if( cof_autohotCommSet(argStr, mainCom, pControl, GuiNum) ){
		edc_hideAfterCommExe(glob_iniAhkCommExeGuiHide, GuiNum, andFlag)
		edi_commEndMiniEdit(historyStr, hwnd, andFlag, rightStrAll, pControl, GuiNum, outPutSucceedFlag)
		return
	}


	; ファイル名を見つけて $1$ などに置換する
	;if(glob_iniSpaceFileNotFlag == False){
	if(O_spaceFileNotFlag == False){
		argStrDbReplace := heard_searchReplaceFilePath(argStrDbReplace)
	} else {
		; 空白のあるファイル名の有無を確認しない場合、２つ以上ある空白を１つの空白にする

		; このやり方は、改行まで削除してしまうので止める
		;argStrDbReplace := RegExReplace(argStrDbReplace, "\s+" , " ")

		argStrDbReplace := func_spaceChangeOnlyOne(argStrDbReplace)
	}
	
	argStrDbReplace := Trim(argStrDbReplace)

;func_checkErrorLevel( argStrDbReplace, A_LineFile, A_LineNumber )

	
	arg_1 =
	arg_2 =
	arg_3 =
	arg_4 =
	arg_5 =
	arg_6 =
	arg_7 =
	arg_8 =
	arg_9 =

	StringSplit, arg_, argStrDbReplace, %A_Space%

	; なくても arg_9 まで作る
/*
	Loop, 9
	{
		if(arg_%A_Index% == ""){
			arg_%A_Index% := ""
		}
	}
*/

	Loop, %arg_0%		; none を入力してた場合 空白扱いにする
	{
		tmpArg := Trim(arg_%A_Index%)
		if(tmpArg == "none"){
			arg_%A_Index% := ""
		}
	}

	; $111$ などの文字をファイル名に戻す
	;if(glob_iniSpaceFileNotFlag == False){
	if(O_spaceFileNotFlag == False){
		Loop , %arg_0%
		{
			IfInString, arg_%A_Index%, $
			{
				tmpIndexStr := arg_%A_Index%
				tmpIndexStr := Trim(tmpIndexStr)
				if( heard_replaceSignWordConfirm(tmpIndexStr, "$") ){
					; 単純に２番目の文字を取る
					StringTrimLeft, tmpIndexStr, tmpIndexStr, 1
					StringLeft, LChar, tmpIndexStr, 1
					tmpIndexStr := glob_spaceFileObj[LChar]
					arg_%A_Index% := Trim(tmpIndexStr)
				}
			}
		}
		glob_spaceFileObj := Object()	; 初期化する
	}

	; textOutをして、" " を取り除く
	; " " で囲まれている場合、textOutを展開しないようにするため、この位置で展開する
	;argDbTrim_1 := outs_textOutTrimss(arg_1)
	argDbTrim_2 := outs_textOutTrimss(arg_2)
	argDbTrim_3 := outs_textOutTrimss(arg_3)
	argDbTrim_4 := outs_textOutTrimss(arg_4)
	argDbTrim_5 := outs_textOutTrimss(arg_5)
	argDbTrim_6 := outs_textOutTrimss(arg_6)
	argDbTrim_7 := outs_textOutTrimss(arg_7)
	argDbTrim_8 := outs_textOutTrimss(arg_8)
	argDbTrim_9 := outs_textOutTrimss(arg_9)


	;argDbTrim_1 := Trim( argDbTrim_1, """" )
	;argDbTrim_2 := Trim( argDbTrim_2, """" )
	;argDbTrim_3 := Trim( argDbTrim_3, """" )
	;argDbTrim_4 := Trim( argDbTrim_4, """" )
	;argDbTrim_5 := Trim( argDbTrim_5, """" )
	;argDbTrim_6 := Trim( argDbTrim_6, """" )
	;argDbTrim_7 := Trim( argDbTrim_7, """" )
	;argDbTrim_8 := Trim( argDbTrim_8, """" )
	;argDbTrim_9 := Trim( argDbTrim_9, """" )


	;""の文字列を早速戻す
	Loop , %arg_0%
	{
		IfInString, arg_%A_Index%, @
		{
			tmpIndexStr := arg_%A_Index%
			tmpIndexStr := Trim(tmpIndexStr)
			arg_%A_Index% := heard_dbQuouteReplaceReturn(tmpIndexStr, A_LineFile, A_LineNumber, True, True)
			argDbTrim_%A_Index% := Trim( arg_%A_Index%, """" )
			;if( heard_replaceSignWordConfirm(tmpIndexStr, "@") ){
			;	; 単純に２番目の文字を取る
			;	StringTrimLeft, tmpIndexStr, tmpIndexStr, 1
			;	StringLeft, LChar, tmpIndexStr, 1
			;	arg_%A_Index% := glob_backUp_dq_%LChar%
			;	argDbTrim_%A_Index% := Trim( glob_backUp_dq_%LChar%, """" )
			;}
		}
	}


	; 引数１が , だったら、 , で区切る仕様に変える
	if( arg_2 == "," ){
		delimiter := ","
		argDbTrim_2 =
		argDbTrim_3 =
		argDbTrim_4 =
		argDbTrim_5 =
		argDbTrim_6 =
		argDbTrim_7 =
		argDbTrim_8 =
		argDbTrim_9 =

		StringSplit, argDbTrim_ , argStr , %delimiter% , %A_Space%
		arg_1 := argDbTrim_1
		argDbTrim_2 := outs_textOutTrimss(argDbTrim_2)
		argDbTrim_3 := outs_textOutTrimss(argDbTrim_3)
		argDbTrim_4 := outs_textOutTrimss(argDbTrim_4)
		argDbTrim_5 := outs_textOutTrimss(argDbTrim_5)
		argDbTrim_6 := outs_textOutTrimss(argDbTrim_6)
		argDbTrim_7 := outs_textOutTrimss(argDbTrim_7)
		argDbTrim_8 := outs_textOutTrimss(argDbTrim_8)
		argDbTrim_9 := outs_textOutTrimss(argDbTrim_9)
	}

/*
	if(glob_iniEasyCheck == 1){
		Loop, 5
		{
			guit_appendExplainNotShow(arg_%A_Index%)
		}
	}
*/
	argOther := argDbTrim_7 . " " . argDbTrim_8 . " " . argDbTrim_9
	argOther := Trim(argOther)
	; 「コマンドの実行過程を表示」にチェックしてた場合
	;cen_easyCheckAppendNotShow(arg_1 . " の引数分割チェック`n" . argDbTrim_1  . "`n" . argDbTrim_2  . "`n" . argDbTrim_3  . "`n" . argDbTrim_4  . "`n" . argDbTrim_5  . "`n" . argDbTrim_6  . "`n" . argOther)

	if( cof_syscommandExecute(arg_1, argDbTrim_2, argDbTrim_3, argDbTrim_4, argDbTrim_5, argDbTrim_6, argOther, pControl, GuiNum) ) {
		edi_commEndMiniEdit(historyStr, hwnd, andFlag, rightStrAll, pControl, GuiNum, outPutSucceedFlag)
		return
	}

	if( cof_ifConditional(arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7, argStr, hwnd, pControl, GuiNum) ){
		edi_commEndMiniEdit(historyStr, hwnd, andFlag, rightStrAll, pControl, GuiNum, outPutSucceedFlag)
		return
	}

	if( cof_equalSubstitutionCommand(arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, argStr, pControl, GuiNum) ){
		edi_commEndMiniEdit(historyStr, hwnd, andFlag, rightStrAll, pControl, GuiNum, outPutSucceedFlag)
		return
	}

	; アイテムの実行
	if(mainCom == "&open"){		; &open だったら rightStr をさらに分ける
		mainCom2 := func_separationSpaceLeftOrAll(rightStr)
		rightStr3 := func_separationSpaceRightOrNull(rightStr)
		rightStrAll2 := func_separationSpaceRightOrNull(rightStrAll)
		openFlag := edi_openCommand16(mainCom2, rightStr3, rightStr, pControl, GuiNum, hwnd, historyStr, andFlag, rightStrAll2, outPutSucceedFlag, 1)
		if( openFlag == False ){
			guit_setExplain("&open  のエラー`n" . mainCom2 . "`nはアイテム名やファイルパスではない", GuiNum)
		}
		; コマンドの終わりの処理を  excof_itemExecute  で行っている
		;edi_commEndMiniEdit(historyStr, hwnd, andFlag, rightStrAll, pControl, GuiNum, outPutSucceedFlag)
		return
	}
	if(mainCom == "&openConfirm"){
		mainCom2 := func_separationSpaceLeftOrAll(rightStr)
		rightStr3 := func_separationSpaceRightOrNull(rightStr)
		rightStrAll2 := func_separationSpaceRightOrNull(rightStrAll)
		openFlag := edi_openCommand16(mainCom2, rightStr3, rightStr, pControl, GuiNum, hwnd, historyStr, andFlag, rightStrAll2, outPutSucceedFlag, 2)
		if( openFlag == False ){
			guit_setExplain(mainCom2 . "`nはアイテム名やファイルパスではない", GuiNum)
		}
		return
	}
	if(mainCom == "&openConfirmOneLine"){
		mainCom2 := func_separationSpaceLeftOrAll(rightStr)
		rightStr3 := func_separationSpaceRightOrNull(rightStr)
		rightStrAll2 := func_separationSpaceRightOrNull(rightStrAll)
		openFlag := edi_openCommand16(mainCom2, rightStr3, rightStr, pControl, GuiNum, hwnd, historyStr, andFlag, rightStrAll2, outPutSucceedFlag, 3)
		if( openFlag == False ){
			guit_setExplain(mainCom2 . "`nはアイテム名やファイルパスではない", GuiNum)
		}
		return
	}
	if(mainCom == "&openTextOut"){
		mainCom2 := func_separationSpaceLeftOrAll(rightStr)
		rightStr3 := func_separationSpaceRightOrNull(rightStr)
		rightStrAll2 := func_separationSpaceRightOrNull(rightStrAll)
		mainCom2TextOut := outs_textOutTrimss(mainCom2)
		rightStr3 := outs_textOutTrimss(rightStr3)
		openFlag := edi_openCommand16(mainCom2TextOut, rightStr3, rightStr, pControl, GuiNum, hwnd, historyStr, andFlag, rightStrAll2, outPutSucceedFlag, 1)
		if( openFlag == False ){
			guit_setExplain("&openTextOut  のエラー`n" . mainCom2TextOut . "`nはアイテム名やファイルパスではない`n元の文字   " . mainCom2, GuiNum)
		}
		return
	}

	openFlag := edi_openCommand16(mainCom, rightStr, argStr, pControl, GuiNum, hwnd, historyStr, andFlag, rightStrAll, outPutSucceedFlag, 1)
	if( openFlag ){
		; コマンドの終わりの処理を  excof_itemExecute  で行っている
		;edi_commEndMiniEdit(historyStr, hwnd, andFlag, rightStrAll, pControl, GuiNum, outPutSucceedFlag)
		return
	}

	edi_varCheck(mainCom, argStr, historyStr, pControl, GuiNum)	; 値のチェック
	edi_andAndRStrExeLogic(rightStrAll, pControl, GuiNum, hwnd, outPutSucceedFlag)
	;func_sendEndToHwndControle(hwnd)
}

; コマンドの実行後に必ず実行させる後処理
edi_afterCommandExeLogic(){
	glob_shortKeyComm =
	glob_shortKeyFlag := False
	glob_outputChangeNum = 1
	glob_errorOutputChangeNum = 1
	glob_outputChangeFile =
	B_itemNameOwn =
	B_itemArgAll =
	B_itemArg0 = 0
	B_itemArg1 =
	B_itemArg2 =
	B_itemArg3 =
	B_itemArg4 =
	B_itemArg5 =
	B_itemArg6 =
	B_itemArg7 =
	B_itemArg8 =
	B_itemArg9 =
/*
	B_itemArgVarName0 = 0
	B_itemArgVarName1 =
	B_itemArgVarName2 =
	B_itemArgVarName3 =
	B_itemArgVarName4 =
	B_itemArgVarName5 =
	B_itemArgVarName6 =
	B_itemArgVarName7 =
	B_itemArgVarName8 =
	B_itemArgVarName9 =
*/
}

; 必ず実行させたい後処理と前処理を追加している。
edi_commandExeLogicWrapper(argStr, historyStr, pControl, GuiNum, hwnd, notShortKeyFlag, andFlag=False){
	glob_outputChangeNum = 1
	glob_errorOutputChangeNum = 1
	glob_outputChangeFile =
	edi_commandExeLogic(argStr, historyStr, pControl, GuiNum, hwnd, notShortKeyFlag, andFlag, False)
	edi_afterCommandExeLogic()
}

edi_commandExeLogicWrapperOfWrapper(command, enterExeBefore, enterExeAfter, allExeAfter, pControl, GuiNum, hwnd){

	; ErrorLevel_TextRunRun はユーザーが初期化しないと変わらないようにしておく
	;ErrorLevel_TextRunRun = 0
	historyStr = %command%
	notShortKeyFlag := True
	;ショートカットキーで動作した場合
	if( glob_shortKeyFlag ){
		glob_shortKeyFlag := False
		notShortKeyFlag := False
		; %--  の文字があるなら、引数の処理をしない。引数の追加もしない。
		parsentMinus := "%--"
		glob_shortKeyComm := RTrim( glob_shortKeyComm )
		StringRight, right3Str, glob_shortKeyComm, 3
		if(right3Str == parsentMinus){
			; %--  の文字を消す
			StringTrimRight, command, glob_shortKeyComm, 3
			; 履歴にも保存しないようにする
			historyStr =
		} else {
			command := glob_shortKeyComm  . " " . command
		}
		command := Trim( command )
	} else {
		; O_enterExeText1Beforeなどを使用していた場合
		command := enterExeBefore . " " . command . " " . enterExeAfter
	}
	command := command . " " . allExeAfter
	;command := Trim(command)
	edi_commandExeLogicWrapper(command, historyStr, pControl, GuiNum, hwnd, notShortKeyFlag, False)
}

edi_trueInCaseEnyWord(str, word1, word2, word3, word4, word5){
	if(str == word1){
		return True
	}
	if(str == word2){
		return True
	}
	if(str == word3){
		return True
	}
	if(str == word4){
		return True
	}
	if(str == word5){
		return True
	}
	return False
}

; アイテムの実行
edi_openCommand16(mainCom, rightStr, argStr, pOut, GuiNum, hwnd, historyStr, andFlag, rightStrAll, outPutSucceedFlag, openNum=1){
	; ソフトの実行  rightStrAll はスクリプトの引数と、&&& の処理に使うのであえて２箇所渡す
	if(excof_itemExecute(mainCom, rightStr, "", pOut, GuiNum, hwnd, historyStr, andFlag, rightStrAll, rightStrAll, outPutSucceedFlag, openNum)) {
		return  True
	}

	argStr := outs_textOutTrimss(argStr)
	;argStr := Trim( argStr, """" )
	; 空白のあるファイル名  と 引数  があった場合実行できるようにした処理
	;if(glob_iniSpaceFileNotFlag == False){
	if(O_spaceFileNotFlag == False){
		if( heard_miniEditFileNameOpen(argStr, GuiNum, A_LineFile, A_LineNumber, openNum) ){
			; コマンドの終わりの処理をここで実行させる
			edi_commEndMiniEdit(historyStr, hwnd, andFlag, rightStrAll, pOut, GuiNum, outPutSucceedFlag)
			return  True
		}
	}


	; 左端のファイル名が " " で囲まれていたときも対応する
	dbQuouteChar := """"
	StringLeft, LChar, argStr, 1
	if(LChar == dbQuouteChar){
		StringTrimLeft, argStrTmp, argStr, 1
		StringGetPos, index, argStrTmp, %dbQuouteChar%
		StringLeft, leftStr, argStrTmp, %index%
		if( func_myFileExist(leftStr) ){
			index += 1
			StringTrimLeft, rightStr, argStrTmp, %index%
			rightStr := Trim(rightStr)
			mainCom := leftStr
		}
	}

	; < > で囲まれてるのを取り除いてからファイルかどうかを確認
	leftArgStr := outs_miniEditExceptingWorkDir(argStr)
	if( func_myFileExist(leftArgStr) )
	{
		if( outs_checkErrorFile(argStr) ){
			; コマンドの終わりの処理をここで実行させる
			edi_commEndMiniEdit(historyStr, hwnd, andFlag, rightStrAll, pOut, GuiNum, outPutSucceedFlag)
			return  True
		}

		; < > で囲まれてるのは workDir にする処理
		workDir := outs_miniEditWorkDir(argStr)
		workDir := outs_textOutDqAllTrim(workDir)
		workDir := outs_relativeToAbsoluteFromWorkDir(workDir,  A_LineFile, A_LineNumber, False)
		outs_workDirCheck(workDir, "作業フォルダが不明`n" . workDir)
		if(workDir == ""){
			workDir = %A_WorkingDir%
		}

		runPath := outs_relativeToAbsoluteFromWorkDir(leftArgStr, A_LineFile, A_LineNumber, True)
		cen_easyCheckAppendNotShow("path  " . runPath . "`n" . A_ThisFunc . "`nA_LineNumber  " . A_LineNumber)
		pathStr = %runPath%
		tmpRunPath = %runPath%
		argss =


		; 設定で、拡張子によって開くソフトを変える場合
		changeFlag := False
		; まずはフォルダーかどうか
		if( cen_openFolderMethodChangeFromFolderVar(tmpRunPath) ){
			pathStr := cen_getScriptBeforeExeSoftItem(O_folderOpenSoftItem, "O_folderOpenSoftItem", tmpRunPath)
			argss := cen_getArgssBeforeExeSoftItem(O_folderOpenSoftItem, tmpRunPath)
			workDir := cen_getWorkDirBeforeExeSoftItem(O_folderOpenSoftItem)
			changeFlag := True
		}
		if( cen_openMethodChangeFromVar(O_txtOpenSoftItem, "O_txtOpenSoftItem", tmpRunPath, ".txt") ){
			pathStr := cen_getScriptBeforeExeSoftItem(O_txtOpenSoftItem, "O_txtOpenSoftItem", tmpRunPath)
			argss := cen_getArgssBeforeExeSoftItem(O_txtOpenSoftItem, tmpRunPath)
			workDir := cen_getWorkDirBeforeExeSoftItem(O_txtOpenSoftItem)
			changeFlag := True
		}
		if( cen_openMethodChangeFromVar(O_ahkOpenSoftItem, "O_ahkOpenSoftItem", tmpRunPath, ".ahk") ){
			pathStr := cen_getScriptBeforeExeSoftItem(O_ahkOpenSoftItem, "O_ahkOpenSoftItem", tmpRunPath)
			argss := cen_getArgssBeforeExeSoftItem(O_ahkOpenSoftItem, tmpRunPath)
			workDir := cen_getWorkDirBeforeExeSoftItem(O_ahkOpenSoftItem)
			changeFlag := True
		}
		if( changeFlag ){
			; ソフトのパスの返り値(pathStr)が、元のファイル名(tmpRunPath)だった場合、引数は無しにする
			if(tmpRunPath == pathStr){
				argss =
			}
			runPath := dbQuouteChar . pathStr . dbQuouteChar . " " . argss
			runPath := Trim(runPath)
		}


		if(openNum == 1){
			Run, %runPath% , %workDir%, UseErrorLevel
			edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
			cen_checkCommSuccess()
			guit_checkErrorLevelOutput("ファイルの実行に失敗。", "パス`t" . runPath)
		} else if(openNum == 2){
			edi_openSetEditBoxss(pathStr, argss, workDir, GuiNum)
			edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
		} else if(openNum == 3){
			guaf_openSetMiniEdit(pathStr, argss, workDir, GuiNum)
			edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
		}
		; コマンドの終わりの処理をここで実行させる
		edi_commEndMiniEdit(historyStr, hwnd, andFlag, rightStrAll, pOut, GuiNum, outPutSucceedFlag)
		return  True
	} else {
		pathStr := outs_textOutDqAllTrim(mainCom)
		if( func_myFileExist(pathStr) )
		{
			if( outs_checkErrorFile(pathStr) ){
				; コマンドの終わりの処理をここで実行させる
				edi_commEndMiniEdit(historyStr, hwnd, andFlag, rightStrAll, pOut, GuiNum, outPutSucceedFlag)
				return  True
			}

			pathStr := outs_relativeToAbsoluteFromWorkDir(pathStr, A_LineFile, A_LineNumber, True)

			; < > で囲まれてるのは workDir にする処理
			workDir := outs_miniEditWorkDir(rightStr)
			rightStr := outs_miniEditExceptingWorkDir(rightStr)
			workDir := outs_textOutDqAllTrim(workDir)
			workDir := outs_relativeToAbsoluteFromWorkDir(workDir,  A_LineFile, A_LineNumber, False)
			outs_workDirCheck(workDir, "作業フォルダが不明`n" . workDir)
			if(workDir == ""){
				workDir = %A_WorkingDir%
			}

			argss := outs_textOutTrimss(rightStr)
			; 絶対パスにするかどうか
			if(glob_iniAbsolePathNotFlag == False){
				;if(glob_iniSpaceFileNotFlag == False){
				if(O_spaceFileNotFlag == False){
					argss := heard_fileAllAbsoluteOrDbQuoute(argss, A_LineFile, A_LineNumber, False, False)
				} else {
					; 絶対パスにはするが、空白のあるファイルがあったら対処できない簡易版
					argss := heard_absoluteAllEasy(argss, A_LineFile, A_LineNumber)
				}
			}

			runPath := dbQuouteChar . pathStr . dbQuouteChar . " " . argss
			runPath := Trim(runPath)
			tmpRunPath := pathStr  . " " . argss
			tmpRunPath := Trim(tmpRunPath)
			cen_easyCheckAppendNotShow("path  " . runPath . "`n" . A_ThisFunc . "`nA_LineNumber  " . A_LineNumber)


			; 設定で、拡張子によって開くソフトを変える場合
			changeFlag := False
			; まずはフォルダーかどうか
			if( cen_openFolderMethodChangeFromFolderVar(tmpRunPath) ){
				pathStr := cen_getScriptBeforeExeSoftItem(O_folderOpenSoftItem, "O_folderOpenSoftItem", tmpRunPath)
				argss := cen_getArgssBeforeExeSoftItem(O_folderOpenSoftItem, tmpRunPath)
				workDir := cen_getWorkDirBeforeExeSoftItem(O_folderOpenSoftItem)
				changeFlag := True
			}
			if( cen_openMethodChangeFromVar(O_txtOpenSoftItem, "O_txtOpenSoftItem", tmpRunPath, ".txt") ){
				pathStr := cen_getScriptBeforeExeSoftItem(O_txtOpenSoftItem, "O_txtOpenSoftItem", tmpRunPath)
				argss := cen_getArgssBeforeExeSoftItem(O_txtOpenSoftItem, tmpRunPath)
				workDir := cen_getWorkDirBeforeExeSoftItem(O_txtOpenSoftItem)
				changeFlag := True
			}
			if( cen_openMethodChangeFromVar(O_ahkOpenSoftItem, "O_ahkOpenSoftItem", tmpRunPath, ".ahk") ){
				pathStr := cen_getScriptBeforeExeSoftItem(O_ahkOpenSoftItem, "O_ahkOpenSoftItem", tmpRunPath)
				argss := cen_getArgssBeforeExeSoftItem(O_ahkOpenSoftItem, tmpRunPath)
				workDir := cen_getWorkDirBeforeExeSoftItem(O_ahkOpenSoftItem)
				changeFlag := True
			}
			if( changeFlag ){
				; ソフトのパスの返り値(pathStr)が、元のファイル名(tmpRunPath)だった場合、引数は無しにする
				if(tmpRunPath == pathStr){
					argss =
				}
				runPath := dbQuouteChar . pathStr . dbQuouteChar . " " . argss
				runPath := Trim(runPath)
			}


			if(openNum == 1){
				Run, %runPath%,  %workDir% , UseErrorLevel
				edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
				cen_checkCommSuccess()
				guit_checkErrorLevelOutput("ファイルの実行に失敗。", "パス`t" . runPath)
			} else if(openNum == 2){
				edi_openSetEditBoxss(pathStr, argss, workDir, GuiNum)
				edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
			} else if(openNum == 3){
				guaf_openSetMiniEdit(pathStr, argss, workDir, GuiNum)
				edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
			}
			; コマンドの終わりの処理をここで実行させる
			edi_commEndMiniEdit(historyStr, hwnd, andFlag, rightStrAll, pOut, GuiNum, outPutSucceedFlag)
			return  True
		}
	}
	return  False
}

edi_varCheck(mainCom, argStr, historyStr, pControl, GuiNum){
	res := RegExMatch(argStr, "^[0-9a-zA-Z_@#\$]+$")
	if(res == 1) {
		if (%argStr% == "") {			; 変数を表示させる

		} else {
			anser =
			str_value := %argStr%
			if( IsObject(str_value) ){
				anser := argStr  . " はオブジェクト"
			} else {
				anser := str_value
			}
			guit_setExplain(anser, GuiNum)
			return
		}
	}
	guit_errorAppendOrSetExplain(mainCom  . " のコマンドは存在しない`n元の一行`n" . argStr, GuiNum)
}

/*
edi_popUpEnyEditMini( str, pControl, GuiNum) {
	if(glob_pupupNum == 1) {
		edi_autoPopUpAllList( str, pControl, GuiNum )
		;auts_autoPopUpFileItemList( str, pControl, GuiNum )
	} else if (glob_pupupNum == 2) {
		auts_autoPopUpSoftObjList( str, pControl, GuiNum )
	} else if (glob_pupupNum == 3) {
		auts_autoPupupFileList( str, pControl, GuiNum )
	} else if (glob_pupupNum == 4) {
		auts_autoPopUpFolderObjList( str, pControl, GuiNum )
	} else if (glob_pupupNum == 5) {
		auts_autoPopUpitemCommandObjList( str, pControl, GuiNum )
	} else if (glob_pupupNum == 6) {
		auts_autoPopHistoryList( str, pControl, GuiNum )
	} else if (glob_pupupNum == 7) {
		auts_autoPopHistoryFilterList( str, pControl, GuiNum )
	} else if (glob_pupupNum == 8) {
		auts_autoPouUpListUserMakeWordFilter( str, pControl, GuiNum )
	} else if (glob_pupupNum == 9) {
		auts_autoPouUpListSpecialWord( str, pControl, GuiNum )
	}
}
*/

edi_popUpEnyEditAnotherGui( str ) {
	if(glob_pupupNum == 1) {
		edi_autoPopUpAllList( str, "List70_1", 70 )
		;auts_autoPopUpFileItemList( str, "List70_1", 70 )
	} else if (glob_pupupNum == 2) {
		auts_autoPopUpSoftObjList( str, "List70_1", 70 )
	} else if (glob_pupupNum == 3) {
		auts_autoPupupFileList( str, "List70_1", 70 )
	} else if (glob_pupupNum == 4) {
		auts_autoPopUpFolderObjList( str, "List70_1", 70 )
	} else if (glob_pupupNum == 5) {
		auts_autoPopUpitemCommandObjList( str, "List70_1", 70 )
	} else if (glob_pupupNum == 6) {
		auts_autoPopHistoryList( str, "List70_1", 70 )
	} else if (glob_pupupNum == 7) {
		auts_autoPopHistoryFilterList( str, "List70_1", 70 )
	} else if (glob_pupupNum == 8) {
		auts_autoPouUpListUserMakeWordFilter( str, "List70_1", 70 )
	} else if (glob_pupupNum == 9) {
		auts_autoPouUpListSpecialWord( str, "List70_1", 70 )
	}
}

edi_autoPopUpAllList( str, pControl, GuiNum=1 ) {
	;static listStr =
	listStr = 
	str := auts_takeLastStr(str)
	listStr .= auts_pupupSnippetInteriorNullIfStrNull(str)
	listStr .= auts_pupupSnippetObjNullIfStrNull(str, 30)
	listStr .= auts_pupupOnlyFolders(str, 30)
	listStr .= auts_pupupOnlyFiles(str, 30)
	listStr .= auts_pupupSoftObjNullIfStrNull(str, 30)
	listStr .= auts_pupupFolderObjNullIfStrNull(str, 30)
	listStr .= auts_pupupItemCommandObjNullIfStrNull(str, 30)
	listStr .= auts_pupupMultipleObjNullIfStrNull(str, 30)
	listStr .= auts_pupupSysCommNullIfStrNull(str, 30)
	listStr .= auts_pupupSpecialWordNullIfStrNull(str, 30)
	listStr .= auts_pupupVariableWordNullIfStrNull(str, 30)
	listStr .= auts_pupupUserVariableWordNullIfStrNull(str, 10)
	listStr .= auts_pupupAhkCommNullIfStrNull(str, 30)
	listStr .= auts_pupupHistoryObj(str, 100)
	listStr .= auts_pupupUserMakeWordNullIfStrNull(str, 30)
	listStr .= auts_pupupOptionVariableWordNullIfStrNull(str, 30)
	listStr .= auts_pupupOptionSetterFuncWordNullIfStrNull(str, 30)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
	;listStr = 
}

/*
; エディットにカーソルがあるときPopupを表示
edi_pupUpShowEditMini(GuiNum, pupNum, viewType, notAutoFlag) {
	popY = 16
	if(glob_needReloadIniCommTitleNotFlag == False){
		popY -= 22
	}
	if(glob_needReloadIniCommMenuNotFlag == False){
		popY -= 20
	}

	; 自動で入力補完を表示する設定で動作をかえる
	if( notAutoFlag ){
		glob_pupupNum = %pupNum%
	}

	pEdit1 := "Edit" . GuiNum  . "_1"
	pList1 :=  "List" . GuiNum  . "_1"
	GuiControlGet, OutputVar, %GuiNum%:FocusV			; 入力補完を表示させる
	if(OutputVar == pEdit1) {
		if( notAutoFlag ){
			editVar := guf_getControl( pEdit1, GuiNum )
			editVar := outs_textOutDqAllTrim(editVar)
			editVar := aut_checkDangerStr(editVar)
			edi_popUpEnyEditMini( editVar, pList1, GuiNum)
		}
		aut_visiblePopUpListMini(pList1, pEdit1, GuiNum, -5, popY, viewType)
	} else if(OutputVar == pList1) {
		GuiControl, %GuiNum%:Focus, %pEdit1%
	} else {
		edi_commListHide(pList1, pEdit1, GuiNum)
	}
}
*/

edi_pupUpShowEditAnotherGui(GuiNum, pupNum, viewType, notAutoFlag) {
	;popY := guaf_anyOfNumFromDpi(27, 30, 33)
/*
	if(glob_needReloadIniCommTitleNotFlag == False){
		popY -= 22
	}
	if(glob_needReloadIniCommMenuNotFlag == False){
		popY -= 20
	}
*/
	; 自動で入力補完を表示する設定で動作をかえる
	if( notAutoFlag ){
		glob_pupupNum = %pupNum%
	}

	pEdit1 := "Edit" . GuiNum  . "_1"
	commWinTitle := gGlob_Gui%GuiNum%Title
	GuiControlGet, OutputVar, %GuiNum%:FocusV			; 入力補完を表示させる
	if(OutputVar == pEdit1) {
		; 今動作中のコマンドのＧｕｉを設定
		glob_nowAutoPopGui = %GuiNum%
		if( notAutoFlag ){
			editVar := guf_getControl( pEdit1, GuiNum )
			editVar := outs_textOutDqAllTrim(editVar)
			editVar := aut_checkDangerStr(editVar)
			edi_popUpEnyEditAnotherGui( editVar )
		}
		;aut_visiblePopUpListAnotherGui(0, popY, viewType, commWinTitle)
		aut_visiblePopUpListAnotherGui(O_inputListX, O_inputListY, viewType, commWinTitle)
		return
	}
	OutputVar := func_focusVGet(70)
	if (OutputVar == "List70_1") {			;Listに選択肢が行ってる時
		GuiControl, %GuiNum%:Focus, %pEdit1%
	} else {
		edi_commListHideAnotherGui()
	}
}

/*
edi_UpDownKeyEditMini(GuiNum, key, hwnd){
	pEdit1 := "Edit" . GuiNum  . "_1"
	pList1 :=  "List" . GuiNum  . "_1"
	GuiControlGet, OutputVar, %GuiNum%:FocusV
	if(OutputVar == pEdit1) {
		aut_controlKeyUpDownTestList1(False, key, pList1, GuiNum)
	} else {
		if(key == 1) {
			Send, {Blind}{Up}
		} else if(key == 2) {
			Send, {Blind}{Down}
		} else if(key == 3) {
			Send, {Blind}{PgUp}
		} else if(key == 4) {
			Send, {Blind}{PgDn}
		} else if(key == 5) {
			Send, {Blind}{Home}
		} else {
			guit_errorAppend("key_notFound")
		}
	}

}
*/

; AnotherGui版
edi_UpDownKeyEditAnotherGui(GuiNum, key){
	pEdit1 := "Edit" . GuiNum  . "_1"
	GuiControlGet, OutputVar, %GuiNum%:FocusV
	if(OutputVar == pEdit1) {
		aut_controlKeyUpDownTestAnotherGui(False, key)
	} else {
		if(key == 1) {
			Send, {Blind}{Up}
		} else if(key == 2) {
			Send, {Blind}{Down}
		} else if(key == 3) {
			Send, {Blind}{PgUp}
		} else if(key == 4) {
			Send, {Blind}{PgDn}
		} else if(key == 5) {
			Send, {Blind}{Home}
		} else {
			guit_errorAppend("key_notFound")
		}
	}
}

edi_UpDownKeyTextAny(key){
	IfWinActive , %gGlob_Gui61Title%
	{
		autg_editssUpDownKey(61, key)
		return
	}
	IfWinActive , %gGlob_Gui62Title%
	{
		autg_editssUpDownKey(62, key)
		return
	}

	IfWinActive , %gGlob_Gui63Title%
	{
		edi_UpDownKeyEditAnotherGui(63, key)
		return
	}
	IfWinActive , %gGlob_Gui64Title%
	{
		edi_UpDownKeyEditAnotherGui(64, key)
		return
	}
	IfWinActive , %gGlob_Gui65Title%
	{
		edi_UpDownKeyEditAnotherGui(65, key)
		return
	}
	IfWinActive , %gGlob_Gui72Title%
	{
		ita_gui72UpDownKey(key)
		return
	}
}

;入力補完の時
/*
edi_pushEnterFromListEditMini(GuiNum, andFlag) {
	if(andFlag){		; タイマー処理か、＆＆で実行された場合、無視するようにする。
		return  False
	}

	pEdit1 := "Edit" . GuiNum  . "_1"
	pList1 := "List" . GuiNum  . "_1"

	; GuiNumのGuiのフォーカスを取得
	OutputVar := func_focusVGet(GuiNum)
	if(OutputVar == pEdit1) {			;Editにフォーカスが行ってる時
		if( aut_varSetFileItem(pEdit1, GuiNum, pList1, GuiNum) ) {
			return True
		}
		return False

	} else if (OutputVar == pList1) {			;Listに選択肢が行ってる時
		aut_varSetFileItem(pEdit1, GuiNum, pList1, GuiNum)		; Editと違い絶対にTrueが返されるのでif文を減らしている
		return True
	}
	return False
}
*/

; AnotherGui版
edi_pushEnterFromListEditAnotherGui(GuiNum, andFlag) {
	if(andFlag){		; タイマー処理か、＆＆で実行された場合、無視するようにする。
		return  False
	}

	pEdit1 := "Edit" . GuiNum  . "_1"

	; GuiNumのGuiのフォーカスを取得
	OutputVar := func_focusVGet(GuiNum)
	if(OutputVar == pEdit1) {			;Editにフォーカスが行ってる時
		if( aut_varSetFileItem(pEdit1, GuiNum, "List70_1", 70) ) {
			return True
		}
		return False

	}
	OutputVar := func_focusVGet(70)
	if (OutputVar == "List70_1") {			;Listに選択肢が行ってる時
		aut_varSetFileItem(pEdit1, GuiNum, "List70_1", 70)		; Editと違い絶対にTrueが返されるのでif文を減らしている
		return True
	}
	return False
}

edi_ansVarPersent(str) {
	res := RegExMatch(str, "^[0-9a-zA-Z_@#$]+$")
	if(res == 1) {
		if (%str% == "") {			; 変数を表示させる
			guit_errorAppend("%の中の値が見つかりません")
		} else {
			str_value := %str%
			return str_value
		}
	} else {
		guit_errorAppend("無効な文字が入ってます")
	}
	guit_checkErrorLevelOutput(A_LineFile, A_LineNumber, ErrorLevel)
	return ""
}

edi_textSizeChangeWinTitle(val, pVal, twice, large, minusWidth, startNum, winTitle, GuiNum){
	returnValue = 0
	StringLen, outCount, val
	if (outCount >= startNum) {
		; DetectHiddenWindows, On  をしないと、非表示のウインドウには使用できない
		WinGetPos, X, Y, Width, Height, %winTitle%
		maxWidth := gloco_maxWinWidth - X - minusWidth
		eStr := outCount * twice
		if(eStr >= maxWidth) {
			eStr := maxWidth
		}
		if(eStr <= large){
			eStr := large
		}
		GuiControl, %GuiNum%:Move, %pVal%, W%eStr%
		returnValue := eStr - large
	} else {
		GuiControl, %GuiNum%:Move, %pVal%, W%large%
		returnValue = 0
	}
	return  returnValue
}

edi_textSizeChangeEditMini(val, pVal, twice, large, minusWidth, startNum, winTitle, widthBasis, changeFlag, GuiNum){
	if( changeFlag ){
		return
	}
	; 非表示のウインドウは現在の位置とサイズを取得しにくにため。後、アクティブの状態になってしまうため
	IfWinNotActive, %winTitle%
	{
		return
	}
	diffLength := edi_textSizeChangeWinTitle(val, pVal, twice, large, minusWidth, startNum, winTitle, GuiNum)
	length := widthBasis + diffLength
	Gui, %GuiNum%:Show, w%length%
}

edi_textSizeChangeCommbox(val, pVal, twice, large, minusWidth, startNum, winTitle, widthBasis, changeFlag, GuiNum) {
	if( changeFlag ){
		return
	}
	; 非表示のウインドウは現在の位置とサイズを取得しにくにため。後、アクティブの状態になってしまうため
	IfWinNotActive, %winTitle%
	{
		return
	}
	diffLength := edi_textSizeChangeWinTitle(val, pVal, twice, large, minusWidth, startNum, winTitle, GuiNum)
	length := widthBasis + diffLength
	Gui, %GuiNum%:Show, w%length%
}

edi_commListHide(pList, pEdit, GuiNum){
	res := guf_controlHideDisable(pList, GuiNum)
	if( res ){
		GuiControlGet, value, %GuiNum%:Pos, %pEdit%
		if(valueY >= 280){
			WinGetPos , winX, winY, , , A
			basisY := winY + 300
			WinMove, A, , %winX%, %basisY%
			editY := valueY - 295
			editYStr := "Y" . editY
			pictureY := editY - 5
			pictureYStr := "Y" . pictureY
			pPicture := "Picture" . GuiNum  . "_1"
			guf_GuiControl(pEdit, GuiNum, "Move", editYStr)
			guf_GuiControl(pPicture, GuiNum, "Move", pictureYStr)
		}
		guf_showGuiParams(GuiNum, "AutoSize")
	}
	return  res
}

edi_commListHideAnotherGui(){
	IfWinExist, %gGlob_Gui70Title%
	{
		Gui, 70:Hide
		return True
	}
	return False
}

; コマンドが無事に終わった時の処理   履歴に追加も
edi_commEndMiniEdit(comStr, hwnd, andFlag, argStrAll, pControl, GuiNum, outPutSucceedFlag){
	edi_andAndRStrExeLogic(argStrAll, pControl, GuiNum, hwnd, outPutSucceedFlag)
	edi_historyInsert(comStr, hwnd, andFlag)
}

edi_historyInsert(comStr, hwnd, andFlag){
	; 履歴の文字が無い場合、右端に移動するのも無しにする
	if( comStr == "" ){
		return
	}
	if( andFlag == False ){
		edi_historyInsertMiniEdit(comStr)
		func_sendEndToHwndControle(hwnd)
	}
}

edi_historyInsertMiniEdit(comStr){
	if(comStr == ""){
		return
	}

	; 履歴を止める変数が ON なら止める
	if( O_textHistoryNotFlag ){
		return
	}

	; 履歴の設定が０なら何もしない
	;if(glob_iniHistoryCount <= 0){
	if(O_textHistory <= 0){
		return
	}
	if( func_StringShortMoreNum(comStr, 130) ){
		glob_tmpHistoryObj.Insert(comStr)
		edi_historyObjSwap()
		syf_historyObjSave()
	}
}

edi_historyObjSwap(){
	glob_historyObj := Object()
	max := glob_tmpHistoryObj.MaxIndex()
	loopCount := max
	;if(max > glob_iniHistoryCount){
	if(max > O_textHistory){
		glob_tmpHistoryObj.Remove(1)
		max--
		;loopCount := glob_iniHistoryCount
		loopCount := O_textHistory
	}
	if(loopCount == 0){
		return
	}
	Loop , %loopCount%
	{
		tmpStr := glob_tmpHistoryObj[max]
		glob_historyObj.Insert(tmpStr)
		max--
		if(max <= 0){
			break
		}
	}
}

edi_shortCutPath(com2, pOut, GuiNum){
	com2 := outs_textOutToAbsolePath(com2, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if( func_myFileExist(com2) ){
		FileGetShortcut, %com2% , OutTarget, OutDir, OutArgs, OutDescription, OutIcon, OutIconNum, OutRunState
		if(OutTarget != ""  ){
			num := guit_editTypeNumGet(GuiNum)
			if(num == 1){
				guit_setEditBoxssAct("__", OutTarget, OutArgs, OutDir, GuiNum)
			} else if(num == 2){
				pathArgs := OutTarget  . " " . OutArgs
				pathArgs := RTrim(pathArgs)
				guf_setControl( pathArgs, pOut, GuiNum )
			} else {
				pathArgs := OutTarget  . " " . OutArgs
				pathArgs := RTrim(pathArgs)
				guit_appendExplain(com2 . "  のリンク先は`n" . pathArgs)
			}
			return
		}
	}
	guit_errorAppendOrSetExplain("&shortCutPathのエラー`n以下のファイルパスはショートカットではない`n" . com2, GuiNum)
}

/*
edi_setEditssAct(Edit1="__", Edit2="__", Edit3="__", Edit4="__", GuiNum=1){
	num := guit_editTypeNumGet(GuiNum)
	if(num == 1){
		guit_setEditBoxssAct(Edit1, Edit2, Edit3, Edit4, GuiNum)
	} else {
		edi_setMiniEditAct(Edit1, Edit2, Edit3, Edit4, GuiNum)
	}
}

edi_setMiniEditAct(Edit1="__", Edit2="__", Edit3="__", Edit4="__", GuiNum=1){
	buff =
	if(Edit1 != "__"){
		buff := Edit1
	}
	if(Edit2 != "__"){
		buff .= " " . Edit2
	}
	if(Edit3 != "__"){
		buff .= " " . Edit3
	}
	if(Edit4 != "__"){
		buff .= " " . Edit4
	}
	buff := Trim(buff)
	pOut := "Edit" . GuiNum  . "_1"
	guf_setControl( buff, pOut, GuiNum )
}
*/

edi_FileDialog(com2, pOut, hwnd, GuiNum){
	if(com2 == ""){
		com2 := A_WorkingDir
	}
	com2 := outs_textOutToAbsolePath(com2, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	FileSelectFile, OutputVar , 3, %com2%, ファイルの選択
	if(ErrorLevel == 0){
		guf_setControl( OutputVar, pOut, GuiNum )
		func_sendEndToHwndControle(hwnd)
	}
}

edi_FolderDialog(com2, pOut, hwnd, GuiNum){
	com2 := outs_textOutToAbsolePath(com2, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if(com2 == ""){
		com2 := A_WorkingDir
	}
	res := func_isNotFolder(com2)
	if(res){
		guit_setExplain("フォルダ名を指定していないのでエラー", GuiNum)
		return
	}
	FileSelectFolder, OutputVar , %com2%, 3, フォルダの選択
	if(ErrorLevel == 0){
		guf_setControl( OutputVar, pOut, GuiNum )
		func_sendEndToHwndControle(hwnd)
	}
}

; &&& がついてる場合の処理
edi_andAndRStrExeLogic(argStrAll, pControl, GuiNum, hwnd, outPutSucceedFlag){
	; コマンドが成功してる場合と失敗した場合で分ける
/*
	rStr =
	cen_checkCommSuccess()
	if( glob_commSuccessFlag ){
		rStr  := func_rightStrOrNullFromSearchStr(argStrAll, "&&& ")
	} else {
		rStr  := func_rightStrOrNullFromSearchStr(argStrAll, "||| ")
	}
	if(rStr  == null){
		return
	}
*/

	; "" で囲まれていたら、無視できるようにする
	argStrAll := heard_dbQuouteReplace(argStrAll, False)
	rStr  := func_rightStrOrNullFromSearchStr(argStrAll, "&&& ")
	if(rStr == ""){
		return
	}
	rStr := heard_dbQuouteReplaceReturn(rStr, A_LineFile, A_LineNumber, True, True)

	;edi_outPutSucceedFlagInCaseTrueCommandExeLogic(rStr , pControl, GuiNum, hwnd, True, outPutSucceedFlag)
	; 出力先の変更を引き継がないように使用変更したので、こちらを使う
	edi_outPutSucceedFlagStopCommandExe(rStr, "", pControl, GuiNum, hwnd, True)

}

; 出力先の変更を引き継がないように使用変更したので、こちらを使う
; edi_commandExeLogicWrapper ではなくこちらを使う理由はこの先、出力のしかたを変更する可能性のある箇所という理由
edi_outPutSucceedFlagStopCommandExe(rStr, historyStr, pControl, GuiNum, hwnd, andFlag){
	glob_outputChangeNum = 1
	glob_errorOutputChangeNum = 1
	glob_outputChangeFile =

	; notShortKeyFlag は、入力補完の影響を無くすのに都合がいいため、あえて False にしている
	edi_commandExeLogic(rStr, historyStr, pControl, GuiNum, hwnd, False, andFlag, False)

	glob_outputChangeNum = 1
	glob_errorOutputChangeNum = 1
	glob_outputChangeFile =
}

; outputの設定を引き継がないなら、初期化させておく。
; glob_outputChangeNum がグローバル変数のため、タイマー処理などで、別のスレッド（サブルーチン）が割り込んだ場合、
; 標準のoutputに戻ることになるので、苦し紛れの対処をする。あくまでないよりましな対処。

; outputの引継ぎが False の場合、スクリプトの処理中に
; outputの種類が切り替わったままになってしまう可能性があるので、バックアップをとって切り替わったままになる可能性を対処する
/*
edi_outPutSucceedFlagInCaseTrueCommandExeLogic(rStr , pControl, GuiNum, hwnd, andFlag, outPutSucceedFlag){
	outputChangeNumBackup =
	errorOutputChangeNumBackup =
	outputChangeFileBackup =
	; outputの設定を引き継がないなら、初期化させておく。
	if( outPutSucceedFlag == False ){
		glob_outputChangeNum = 1
		glob_errorOutputChangeNum = 1
		glob_outputChangeFile =
	} else {
		; glob_outputChangeNum がグローバル変数のため、タイマー処理などで、別のスレッド（サブルーチン）が割り込んだ場合、
		; 標準のoutputに戻ることになるので、苦し紛れの対処をする。あくまでないよりましな対処。
		outputChangeNumBackup := glob_outputChangeNum
		errorOutputChangeNumBackup := glob_errorOutputChangeNum
		outputChangeFileBackup := glob_outputChangeFile
	}

	edi_commandExeLogic(rStr, "", pControl, GuiNum, hwnd, True, andFlag, outPutSucceedFlag)

	if( outPutSucceedFlag ){
		glob_outputChangeNum := outputChangeNumBackup
		glob_errorOutputChangeNum := errorOutputChangeNumBackup
		glob_outputChangeFile := outputChangeFileBackup
	}
}
*/

; ファイル名のみなら "" をはずす
edi_trimDbQuouteIfFile(arg){
	trimArg := Trim( arg, """" )
	if( func_myFileExist(trimArg) ){
		return  trimArg
	}
	return  arg
}

edi_stockCommExeShortCut(usePOut){
	edi_otherEditUseExeLogic("", usePOut, 78, "Edit63_1", 63, gGlob_hwndEdit63_1, True)
}

edi_otherEditUse(argStr, usePOut, useGuiNum, exePOut, exeGuiNum){
	hwnd =
	editType := guit_editTypeNumGet(exeGuiNum)
	if(editType == 1){
		; フォーカス位置の　コントロール変数とHwndの変数を取得
		exePOut := guaf_focusCheck(exePOut, exeGuiNum)
		hwnd := guf_getHwnd(exeGuiNum, exePOut)
	} else if(editType == 2){
		pHwnd := "gGlob_hwndEdit" . exeGuiNum  . "_1"
		hwnd := %pHwnd%
	}

	edi_otherEditUseExeLogic(argStr, usePOut, useGuiNum, exePOut, exeGuiNum, hwnd, True)
}

edi_otherEditUseExeLogic(argStr, usePOut, useGuiNum, exePOut, exeGuiNum, hwnd, andFlag){
	argStrAll =
	useEdit =
	if(useGuiNum == exeGuiNum){
		guit_setExplain("使用するテキストのＧｕｉと`n引数に使うテキストのＧｕｉが同じなので実行できない", exeGuiNum)
		return
	}
	typeNum := guit_editTypeNumGet(useGuiNum)
	if(typeNum == 1){
		useEdit := edi_appendAllEditssBox(useGuiNum)
	} else {
		useEdit := guf_getControl( usePOut, useGuiNum )
	}

	useEdit := Trim(useEdit)
	; ストックの方がカラだった場合は、実行しないようにする
	if(useEdit == ""){
		guit_setExplain("利用するテキストの方がカラなので、何も実行しない", exeGuiNum)
		return
	}

	; おまけ要素	&green1 などの文字を置き換える
	useEdit := edi_replaceOtherEditAll(useEdit, 1)
	argStr := edi_replaceOtherEditAll(argStr, 1)
	
	; 利用するEdit に %1 などが入ってるなら特殊な処理をする
	argStrAll := heard_itemArgssLogic_Cust(useEdit, argStr, "")

	if(argStrAll == ""){
		guit_appendExplain("テキストが空なので何も実行しません")
		return
	}
	if(typeNum == 3){
		; 説明は表示せず、影で書き込む
		guit_setExplainNotShow(argStrAll, useGuiNum)
		; 二行以上のスクリプトを使う場合。outputの引継ぎは False
		musc_multipleScriptsExe(argStrAll, exePOut, exeGuiNum, hwnd, False, 1)
	} else {
		guit_setExplainToolTip(argStrAll)

		;edi_outPutSucceedFlagInCaseTrueCommandExeLogic(argStrAll , exePOut, exeGuiNum, hwnd, andFlag, False)
		; 出力先の変更を引き継がないように使用変更したので、こちらを使う
		; 現在 andFlag は True になるので意味はない
		edi_outPutSucceedFlagStopCommandExe(argStrAll, argStr, exePOut, exeGuiNum, hwnd, andFlag)
	}
}

edi_collabEdit(com2, pOut, GuiNum, outPutSucceedFlag){
	helpStr := "他のテキストを先頭にして実行する。`n引数１ 1 から 5 なら、他のテキスト。6 か 7 ならストックを使う。 8 なら二行以上のテキスト。`n引数２  引数１が 6 か 7 なら、1 から 10 を指定する`n残りの引数を引数として使う"
	if( edc_helpViewIfHyphenH(helpStr, com2, GuiNum) ){
		return
	}

	LChar := func_separationSpaceLeftOrAll(com2)
	rStr := func_separationSpaceRightOrNull(com2)

	; >>> があれば outputの種類を変更する
	guit_outPutControl(rStr, outPutSucceedFlag)
	;  >>> xxx の文字を取り除かない。 引数としてそのまま扱う。
	; というか、今のままでは、&&& を使ったときとの違いが出てややこしいのでこうしている。

	if(LChar == 1){
		edi_otherEditUse(rStr, "Edit63_1", 63, pOut, GuiNum)
	} else if(LChar == 2){
		edi_otherEditUse(rStr, "Edit64_1", 64, pOut, GuiNum)
	} else if(LChar == 3){
		edi_otherEditUse(rStr, "Edit65_1", 65, pOut, GuiNum)
	} else if(LChar == 4){
		edi_otherEditUse(rStr, "", 61, pOut, GuiNum)
	} else if(LChar == 5){
		edi_otherEditUse(rStr, "", 62, pOut, GuiNum)
	} else if(LChar == 6){
		edi_commStockCollabEdit(rStr, pOut, GuiNum, 1)
	} else if(LChar == 7){
		edi_commStockCollabEdit(rStr, pOut, GuiNum, 2)
	} else if(LChar == 8){
		edi_otherEditUse(rStr, "BoxEdit82_1", 82, pOut, GuiNum)
	} else {
		guit_setExplainPurpose(helpStr, GuiNum)
	}
}

edi_commStockCollabEdit(rStr, pOut, GuiNum, typeNum){
	LChar2 := func_separationSpaceLeftOrAll(rStr)
	rStr2 := func_separationSpaceRightOrNull(rStr)
	useGuiNum = 77
	if(typeNum == 2){
		useGuiNum = 78
	}
	pControlName := "Edit" . useGuiNum

	if(LChar2 == 1){
		edi_otherEditUse(rStr2, pControlName  . "_1", useGuiNum, pOut, GuiNum)
	} else if(LChar2 == 2){
		edi_otherEditUse(rStr2, pControlName  . "_2", useGuiNum, pOut, GuiNum)
	} else if(LChar2 == 3){
		edi_otherEditUse(rStr2, pControlName  . "_3", useGuiNum, pOut, GuiNum)
	} else if(LChar2 == 4){
		edi_otherEditUse(rStr2, pControlName  . "_4", useGuiNum, pOut, GuiNum)
	} else if(LChar2 == 5){
		edi_otherEditUse(rStr2, pControlName  . "_5", useGuiNum, pOut, GuiNum)
	} else if(LChar2 == 6){
		edi_otherEditUse(rStr2, pControlName  . "_6", useGuiNum, pOut, GuiNum)
	} else if(LChar2 == 7){
		edi_otherEditUse(rStr2, pControlName  . "_7", useGuiNum, pOut, GuiNum)
	} else if(LChar2 == 8){
		edi_otherEditUse(rStr2, pControlName  . "_8", useGuiNum, pOut, GuiNum)
	} else if(LChar2 == 9){
		edi_otherEditUse(rStr2, pControlName  . "_9", useGuiNum, pOut, GuiNum)
	} else if(LChar2 == 10){
		edi_otherEditUse(rStr2, pControlName  . "_10", useGuiNum, pOut, GuiNum)
	}
}

edi_replaceOtherEditAll(argStr, count){
	IfNotInString, argStr, $$
	{
		return  argStr
	}
	gui63 := "D_text1$$"
	gui64 := "D_text2$$"
	gui65 := "D_text3$$"
	gui61_1 := "D_textSplit1_1$$"
	gui61_2 := "D_textSplit1_2$$"
	gui61_3 := "D_textSplit1_3$$"
	gui61_4 := "D_textSplit1_4$$"
	gui62_1 := "D_textSplit2_1$$"
	gui62_2 := "D_textSplit2_2$$"
	gui62_3 := "D_textSplit2_3$$"
	gui62_4 := "D_textSplit2_4$$"
	gui77_1 := "D_stockBlue_1$$"
	gui77_2 := "D_stockBlue_2$$"
	gui77_3 := "D_stockBlue_3$$"
	gui77_4 := "D_stockBlue_4$$"
	gui77_5 := "D_stockBlue_5$$"
	gui77_6 := "D_stockBlue_6$$"
	gui77_7 := "D_stockBlue_7$$"
	gui77_8 := "D_stockBlue_8$$"
	gui77_9 := "D_stockBlue_9$$"
	gui77_10 := "D_stockBlue_10$$"
	gui78_1 := "D_stockGreen_1$$"
	gui78_2 := "D_stockGreen_2$$"
	gui78_3 := "D_stockGreen_3$$"
	gui78_4 := "D_stockGreen_4$$"
	gui78_5 := "D_stockGreen_5$$"
	gui78_6 := "D_stockGreen_6$$"
	gui78_7 := "D_stockGreen_7$$"
	gui78_8 := "D_stockGreen_8$$"
	gui78_9 := "D_stockGreen_9$$"
	gui78_10 := "D_stockGreen_10$$"
	
	argStr := edi_replaceOtherEditOnly(argStr, gui63, "Edit63_1", 63, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui64, "Edit64_1", 64, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui65, "Edit65_1", 65, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui62_1, "Edit62_1", 62, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui62_2, "Edit62_2", 62, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui62_3, "Edit62_3", 62, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui62_4, "Edit62_4", 62, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui61_1, "Edit61_1", 61, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui61_2, "Edit61_2", 61, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui61_3, "Edit61_3", 61, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui61_4, "Edit61_4", 61, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_1, "Edit77_1", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_2, "Edit77_2", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_3, "Edit77_3", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_4, "Edit77_4", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_5, "Edit77_5", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_6, "Edit77_6", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_7, "Edit77_7", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_8, "Edit77_8", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_9, "Edit77_9", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_10, "Edit77_10", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui78_1, "Edit78_1", 78, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui78_2, "Edit78_2", 78, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui78_3, "Edit78_3", 78, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui78_4, "Edit78_4", 78, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui78_5, "Edit78_5", 78, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui78_6, "Edit78_6", 78, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui78_7, "Edit78_7", 78, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui78_8, "Edit78_8", 78, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui78_9, "Edit78_9", 78, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui78_10, "Edit78_10", 78, count)

	; 再帰的な処理をしない変わりに、逆の順番から再アタックをかける
	IfNotInString, argStr, $$
	{
		return  argStr
	}
	argStr := edi_replaceOtherEditOnly(argStr, gui78_10, "Edit78_10", 78, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui78_9, "Edit78_9", 78, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui78_8, "Edit78_8", 78, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui78_7, "Edit78_7", 78, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui78_6, "Edit78_6", 78, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui78_5, "Edit78_5", 78, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui78_4, "Edit78_4", 78, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui78_3, "Edit78_3", 78, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui78_2, "Edit78_2", 78, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui78_1, "Edit78_1", 78, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_10, "Edit77_10", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_9, "Edit77_9", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_8, "Edit77_8", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_7, "Edit77_7", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_6, "Edit77_6", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_5, "Edit77_5", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_4, "Edit77_4", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_3, "Edit77_3", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_2, "Edit77_2", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui77_1, "Edit77_1", 77, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui61_4, "Edit61_4", 61, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui61_3, "Edit61_3", 61, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui61_2, "Edit61_2", 61, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui61_1, "Edit61_1", 61, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui62_4, "Edit62_4", 62, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui62_3, "Edit62_3", 62, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui62_2, "Edit62_2", 62, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui62_1, "Edit62_1", 62, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui65, "Edit65_1", 65, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui64, "Edit64_1", 64, count)
	argStr := edi_replaceOtherEditOnly(argStr, gui63, "Edit63_1", 63, count)

	return  argStr
}

edi_replaceOtherEditOnly(argStr, searchWord, pOut, GuiNum, count){
	IfInString, argStr, %searchWord%
	{
		Edit1 := guf_getControl( pOut, GuiNum )
		StringReplace, argStr, argStr, %searchWord% , %Edit1%
		argStr := Trim(argStr)
		; 再帰的処理をしてもよかったが、止めておく
		;count++
		;if(count >= 11){
		;	guit_errorAppend("現時点では10回以上続く D_xxx$$ の文字の処理のループはできない。`n以下の構文は処理できない`n" . argStr)
		;	return  argStr
		;}
		;edi_replaceOtherEditAll(argStr, count)
	}
	return  argStr
}

edi_addStockSetControl(rightStr, stockGui, GuiNum){
	pEdit := "Edit" . stockGui . "_"
	Loop, 10
	{
		pControl := pEdit . A_Index
		useEdit := guf_getControl( pControl, stockGui )
		if(useEdit == ""){
			guf_setControl( rightStr, pControl, stockGui )
			Break
		}
		if(A_Index == 10){
			guit_setExplain("空きがないで保存ができない", GuiNum)
		}
	}
}

edi_addStockLogic(rightStr, stockGui, pOut, GuiNum){
	if(rightStr == ""){
		return
	}

	sec := glob_iniStock_sec
	timerSub := "gGlob_timerGui" . stockGui
	closeSub := "SubGui" . stockGui . "Close"

	edi_addStockSetControl(rightStr, stockGui, GuiNum)

	if(sec == 0){
		guf_showGuiAssign(stockGui, " NA")
		return
	}
	guit_showGuiEnyAutoClose(sec, timerSub, closeSub, stockGui, " NA")
}

; 実行した EditBoxss とは違う EditBoxss に表示させる
edi_openSetEditBoxss(pathStr, argss, workStr, GuiNum){
	if(GuiNum == 61){
		Gui, 62:Show
		guit_setEditBoxssAct("", pathStr, argss, workStr, 62)
	} else {
		Gui, 61:Show
		guit_setEditBoxssAct("", pathStr, argss, workStr, 61)
	}
}

edi_appendAllEditssBox(useGuiNum){
	edit2 := "Edit" . useGuiNum  . "_2"
	edit3 := "Edit" . useGuiNum  . "_3"
	edit5 := "Edit" . useGuiNum  . "_5"
	edit6 := "Edit" . useGuiNum  . "_6"
	edit7 := "Edit" . useGuiNum  . "_7"
	edit8 := "Edit" . useGuiNum  . "_8"

	editValue2 := guf_getControl( edit2, useGuiNum )
	editValue3 := guf_getControl( edit3, useGuiNum )
	editValue5 := guf_getControl( edit5, useGuiNum )
	editValue6 := guf_getControl( edit6, useGuiNum )
	editValue7 := guf_getControl( edit7, useGuiNum )
	editValue8 := guf_getControl( edit8, useGuiNum )
	argStrAll := editValue2  . " " . editValue3  . " " . editValue5  . " " . editValue6  . " " . editValue7  . " " . editValue8
	argStrAll := Trim(argStrAll)
	return  argStrAll
}

edi_argsReplaceBeforeCommandExe(stockStr, rStr){
	smicron := "`;"		; コメントの文字

	; ストックの中身がカラなら、引数があっても実行しない
	stockStr := Trim(stockStr)
	if(stockStr == ""){
		return
	}

	StringLeft, leftChar, stockStr, 1
	if(leftChar == smicron){		; があったらコメント扱い
		return
	}

	; おまけ要素	&green1 などの文字を置き換える
	stockStr := edi_replaceOtherEditAll(stockStr, 1)
	rStr := edi_replaceOtherEditAll(rStr, 1)
	; 利用するEdit に %1 などが入ってるなら特殊な処理をする
	argStrAll := heard_itemArgssLogic_Cust(stockStr, rStr, "")


	; outputの設定が変えられていたら、引き継がせるため、Trueを返す
	;outPutSucceedFlag := cen_outPutSucceedFlagTrueIfNotBasic()
	;  &stockExeAll は outputの設定を引き継ぐ
	;edi_outPutSucceedFlagInCaseTrueCommandExeLogic(argStrAll, "", 63, null, True, outPutSucceedFlag)

	; 出力先の変更を引き継がないように使用変更したので、こちらを使う
	edi_outPutSucceedFlagStopCommandExe(argStrAll, "", "", 71, null, True)
}

edi_stockExeAll(num, rStr, pOut, GuiNum, iniFile){

	listName := "type" . num
	IniRead, Out1, %iniFile%, %listName%, Edit_1 , %A_Space%
	IniRead, Out2, %iniFile%, %listName%, Edit_2 , %A_Space%
	IniRead, Out3, %iniFile%, %listName%, Edit_3 , %A_Space%
	IniRead, Out4, %iniFile%, %listName%, Edit_4 , %A_Space%
	IniRead, Out5, %iniFile%, %listName%, Edit_5 , %A_Space%
	IniRead, Out6, %iniFile%, %listName%, Edit_6 , %A_Space%
	IniRead, Out7, %iniFile%, %listName%, Edit_7 , %A_Space%
	IniRead, Out8, %iniFile%, %listName%, Edit_8 , %A_Space%
	IniRead, Out9, %iniFile%, %listName%, Edit_9 , %A_Space%
	IniRead, Out10, %iniFile%, %listName%, Edit_10 , %A_Space%

/*
	hwnd =
	editType := guit_editTypeNumGet(GuiNum)
	if(editType == 1){
		; Gui5 のフォーカス位置が　Edit の場合以外なら Edit2 にフォーカスがあるようにする
		pOut := guaf_focusCheck(pOut, GuiNum)
		GuiControlGet,hwnd, %GuiNum%:Hwnd, %pOut%
	} else if(editType == 2 || editType == 3){
		pHwnd := "gGlob_hwndEdit" . GuiNum  . "_1"
		hwnd := %pHwnd%
	}
*/
	edi_argsReplaceBeforeCommandExe(Out1, rStr)
	edi_argsReplaceBeforeCommandExe(Out2, rStr)
	edi_argsReplaceBeforeCommandExe(Out3, rStr)
	edi_argsReplaceBeforeCommandExe(Out4, rStr)
	edi_argsReplaceBeforeCommandExe(Out5, rStr)
	edi_argsReplaceBeforeCommandExe(Out6, rStr)
	edi_argsReplaceBeforeCommandExe(Out7, rStr)
	edi_argsReplaceBeforeCommandExe(Out8, rStr)
	edi_argsReplaceBeforeCommandExe(Out9, rStr)
	edi_argsReplaceBeforeCommandExe(Out10, rStr)
}

edi_stockExeAllBlue(rightStr, pOut, GuiNum){
	LChar := func_separationSpaceLeftOrAll(rightStr)
	rStr := func_separationSpaceRightOrNull(rightStr)

	str := "ストックしてあるテキストを全て実行する。`n引数１に  ストックのリストのナンバーを入れる"
	if( edc_helpViewIfHyphenH(str, LChar, GuiNum) ){
		return
	}

	if(LChar == ""){
		guit_errorAppend("&stockExeAllBlueのエラー`n引数１に  ストックのリストのナンバーを入れる")
		return
	}

	If LChar is not number
	{
		guit_errorAppend("&stockExeAllBlueのエラー`n引数が数字ではない")
		return
	}

	edi_stockExeAll(LChar, rStr, pOut, GuiNum, gloco_userDir . glob_commStockFile77Name)
}

edi_stockExeAllGreen(rightStr, pOut, GuiNum){
	LChar := func_separationSpaceLeftOrAll(rightStr)
	rStr := func_separationSpaceRightOrNull(rightStr)

	str := "ストックしてあるテキストを全て実行する。`n引数１に  ストックのリストのナンバーを入れる"
	if( edc_helpViewIfHyphenH(str, LChar, GuiNum) ){
		return
	}

	if(LChar == ""){
		guit_errorAppend("&stockExeAllGreenのエラー`n引数１に  ストックのリストのナンバーを入れる")
		return
	}

	If LChar is not number
	{
		guit_errorAppend("&stockExeAllGreenのエラー`n引数が数字ではない")
		return
	}

	edi_stockExeAll(LChar, rStr, pOut, GuiNum, gloco_userDir . glob_commStockFile78Name)
}

edi_exitAppIfCommGuiOnlyFlag(){
	if( glob_reloadIniCommGuiOnlyFlag ){
		ExitApp
	}
}

edi_autoImageSetFromText(pEditControl, pPictureControl, GuiNum){
	edit1 := guf_getControl( pEditControl, GuiNum )
	edit1 := Trim(edit1)
	if( edit1 == "" ){
		if(glob_stockNoneFile == ""){
			; アイコンのサイズは、次利用するアイコンに依存する
			guf_setControl( "", pPictureControl, GuiNum )
		} else {
			guf_setControl( glob_stockNoneFile, pPictureControl, GuiNum )
		}
		return
	}
	edit1 := outs_textOutDqAllTrim(edit1)
	edit1 := aut_checkDangerStr(edit1)
	; アイコンのサイズはあえて指定しない
	;aut_pictuerSetByFileOrObj( edit1, "", "*icon24 *w32 *h32 " . glob_SHELL32DLL, "", 71, pPictureControl, GuiNum, False, "")
	aut_pictuerSetByFileOrObj( edit1, "", glob_stockHaveFile, "", 71, pPictureControl, GuiNum, False, "")
}

; 右クリックで入力補完を表示する。すでに表示されていたら
; リストを選択をして、同じ内容だったら、テキストへ
edi_GuiContextMenu(pControl ,GuiNum){
	pList1 :=  "List" . GuiNum  . "_1"
	pList2 :=  "List" . GuiNum  . "_2"
	pList3 :=  "List" . GuiNum  . "_3"
	pList4 :=  "List" . GuiNum  . "_4"
	pList5 :=  "List" . GuiNum  . "_5"
	listFlag := False
	if(pControl == pList1){
		listFlag := True
	} else if(pControl == pList2){
		listFlag := True
	} else if(pControl == pList3){
		listFlag := True
	} else if(pControl == pList4){
		listFlag := True
	} else if(pControl == pList5){
		listFlag := True
	}
	if( listFlag ){
		; 何も選択されてないなら、左クリックのみをする
		listValue := guf_getControl( pControl, GuiNum )
		Send, {LButton}
		if( listValue != "" ){
			; すでに選択されているなら、前の文字と同じかどうか
			;Sleep, 200
			listValue2 := guf_getControl( pControl, GuiNum )
			if( listValue == listValue2 ){
				; 前の文字なら、テキストへ
				Send, !n
			}
		}
	} else {
		Send, !b
	}
}

edi_leftClickOnText(GuiNum){
	pList1 :=  "List" . GuiNum  . "_1"
	pList2 :=  "List" . GuiNum  . "_2"
	pList3 :=  "List" . GuiNum  . "_3"
	pList4 :=  "List" . GuiNum  . "_4"
	pList5 :=  "List" . GuiNum  . "_5"
	listFlag := False
	GuiControlGet, focusEdit , %GuiNum%:FocusV
	if(focusEdit == pList1){
		listFlag := True
	} else if(focusEdit == pList2){
		listFlag := True
	} else if(focusEdit == pList3){
		listFlag := True
	} else if(focusEdit == pList4){
		listFlag := True
	} else if(focusEdit == pList5){
		listFlag := True
	}
	if( listFlag ){
		Send, {RButton}
	} else {
		Send, {LButton}
	}
}

edi_leftClickOnTextAny(){
	IfWinActive , %gGlob_Gui61Title%
	{
		edi_leftClickOnText(61)
		return
	}
	IfWinActive , %gGlob_Gui62Title%
	{
		edi_leftClickOnText(62)
		return
	}
	IfWinActive , %gGlob_Gui72Title%
	{
		edi_leftClickOnText(72)
		return
	}

	Send, {LButton}

	;IfWinActive , %gGlob_Gui70Title%
	;{
	;	edi_leftClickOnText(70)
	;	return
	;}
}

edi_sendScriptToText(rightStr, GuiNum){
	str := "テキストに実行スクリプトを送って、テキスト上で動作させる。`n引数１  テキストのGuiの番号`nany  を指定すると、前面にあるテキストが対象になる。`n引数２以降  実行スクリプト"
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}
	if(rightStr == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	;allSec = 0
	;dateTime = 0
	textGuiNum =

	rightStr_left := func_separationSpaceLeftOrAll(rightStr)
	rightStr_left := outs_textOutTrimss(rightStr_left)
	if(rightStr_left == "any"){
		WinActivate , %gGlob_GuiCommandTitle%
		WinWaitActive , %gGlob_GuiCommandTitle%, , 1
		WinGetActiveTitle, winTitle
		if( winTitle == gGlob_Gui61Title ){
			textGuiNum = 61
		} else if( winTitle == gGlob_Gui62Title ){
			textGuiNum = 62
		} else if( winTitle == gGlob_Gui63Title ){
			textGuiNum = 63
		} else if( winTitle == gGlob_Gui64Title ){
			textGuiNum = 64
		} else if( winTitle == gGlob_Gui65Title ){
			textGuiNum = 65
		} else {
			guit_errorAppend("&sendScriptToTextのエラー`nテキストが非表示になっている。`n引数  " . rightStr)
			return
		}
	} else {
		If rightStr_left is not integer
		{
			guit_errorAppend("&sendScriptToTextのエラー`n引数１にテキストのGuiの番号を指定していない。`n引数  " . rightStr)
			return
		}
		typeNum := guit_editTypeNumGet(rightStr_left)
		if( typeNum == 1 ){
			textGuiNum = %rightStr_left%
		} else if( typeNum == 2 ){
			textGuiNum = %rightStr_left%
		} else {
			guit_errorAppend("&sendScriptToTextのエラー`n引数１はテキストのGuiの番号しか指定できない。`n引数  " . rightStr)
			return
		}
	}
	; rightStr  の右の文字
	rightStr_right := func_separationSpaceRightOrNull(rightStr)
	if( rightStr_right == "" ){
		guit_errorAppend("&sendScriptToTextのエラー`n引数２以降に実行スクリプトを指定していない。`n引数  " . rightStr)
		return
	}

	glob_sendToTextArg = %rightStr_right%
	glob_sendToTextGuiNum = %textGuiNum%
	;glob_sendToTextTimer = %dateTime%

	SetTimer, SubSendScriptToText, 200
}

edi_sendScriptToTextTimer(){
	guf_showGuiAssign(glob_sendToTextGuiNum)
	WinWaitActive , A, , 1
	glob_shortKeyComm = %glob_sendToTextArg%
	glob_shortKeyFlag := True
	Send, !n
	;glob_sendToTextArg =
	;glob_sendToTextGuiNum =
	glob_sendToTextTimer = 0
}

; テキストの場合、入力補完を閉じるなどの動作をして閉じる。
; minimizeFlag が True なら 最小化させる設定によって、最小化する
; outGuiHideFlag が True なら 出力のウインドウを閉じる
; closeExitFlag が True なら 「テキスト１が閉じたら終了する」設定に対応する
edi_hideOrMinimizeGuiTextPattern(GuiNum, minimizeFlag, outGuiHideFlag, closeExitFlag){
	if(GuiNum == ""){
		; 何もしない(A_Guiに何もない時)
		return
	}
	typeNum := guit_editTypeNumGet(GuiNum)
	if(typeNum == 2){
		edi_commListHideAnotherGui()
		if( outGuiHideFlag ){
			Gui, 66:Show, Hide
			Gui, 67:Show, Hide
			Gui, 68:Show, Hide
		}
		if( minimizeFlag ){
			; テキストを最小化させる設定
			;if( glob_iniTextGuiMinimize ){
			if( O_minimizeTextFlag ){
				Gui, %GuiNum%:Minimize
				return
			}
		}
		if( closeExitFlag ){
			; テキスト１が閉じたら終了の設定かどうか
			if(GuiNum == 63){
				edi_exitAppIfCommGuiOnlyFlag()
			}
		}
	} else if(typeNum == 1){
		if( minimizeFlag ){
			; テキストを最小化させる設定
			;if( glob_iniTextGuiMinimize ){
			if( O_minimizeTextFlag ){
				Gui, %GuiNum%:Minimize
				return
			}
		}
	} else if(typeNum == 4){
		; 何もしない
		return
	}
	Gui, %GuiNum%:Hide
}

; 表示してないか、最小化なら、前面に表示。
; それ以外なら、設定によって閉じたり、最小化する。
; 「テキスト１が閉じたら終了」の設定は対応しない
edi_showHideGuiTextPattern(GuiNum, minimizeFlag, outGuiHideFlag, pOrder="_"){
	examplControl := "Edit" . GuiNum . "_1"
	GuiControlGet, OutputVar, %GuiNum%:Visible, %examplControl%
	; 閉じてるかどうか
	if(OutputVar == 1){
		winTitle := gGlob_Gui%GuiNum%Title
		WinGet,OutputVar, MinMax, %winTitle%
		; 最小化してるかどうか
		if(OutputVar == -1){
			guf_showGuiAssign(GuiNum, pOrder)
		} else {
			edi_hideOrMinimizeGuiTextPattern(GuiNum, minimizeFlag, outGuiHideFlag, False)
		}
		return
	}
	guf_showGuiAssign(GuiNum, pOrder)
}

; ウインドウの操作をする前の前準備。
; 実行元のテキストを隠して、どれかのウインドウが最前面になるのを待つ
edi_hideGuiTextPatternAnyWinActiveWait(){
	if(A_Gui != ""){
		edi_hideOrMinimizeGuiTextPattern(A_Gui, True, False, False)
		windc_anyWaitActive()
	}
}

; A が指定されてたら、実行元テキストを隠す
edi_hideOrMinimizeGuiTextPatternWinIfA(winTitle){
	if(winTitle == "A"){
		if(A_Gui != ""){
			edi_hideOrMinimizeGuiTextPattern(A_Gui, True, False, False)
			windc_anyWaitActive()
		}
	}
}

edi_guiHideTextExecutor(rightStr){
	str := "実行元のＧｕｉを閉じる。`nその後、WinWaitActive, A も使用している。`n引数に -n を入れると、WinWaitActive を使用しなくなる。"
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}
	flag := True
	if(rightStr == "-n"){
		flag := False
	}
	edi_hideOrMinimizeGuiTextPattern(A_Gui, True, False, True)
	if( flag ){
		windc_anyWaitActive()
	}
}

edi_lastAsHeadExecute(com2, pOutControl, hwnd, GuiNum){
	str := "最後の引数を最初の文字として扱ってコマンドを実行する。`n入力欄に再記入される文字は、`n&lastAsHead  と違い、最後の引数を最初に移動することはせず、削除だけして入力欄に記入する。`n`n分割テキストでは、フォーカスされてる入力欄のみで動作する"
	if( edc_helpViewIfHyphenH(str, com2, GuiNum) ){
		return
	}
	if(com2 == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}

	com2 := Trim(com2)
	IfNotInString, com2, %A_Space%
	{
		guit_setExplainPurpose(str, GuiNum)
		return
	}

	StringGetPos, index, com2, %A_Space%, R1
	index++
	StringLeft, leftStr, com2, index
	StringTrimLeft, rightStr, com2, index
	rightStr := Trim(rightStr)
	newStr := rightStr  . " " . leftStr
	; 右の文字を取り除いた文字を入力欄に入れる
	guf_setControl( leftStr, pOutControl, GuiNum )
	edi_outPutSucceedFlagStopCommandExe(newStr, "", pOutControl, GuiNum, null, True)
	func_sendEndToHwndControle(hwnd)
}

edi_getTextGuiAssign(com2, com3){
	if(com2 == ""){
		guit_setExplainOtherThanCommand("テキスト欄の文字を取得する。`nnumber には何番目のテキストかを指定。`nテキスト欄のウインドウにのみ有効")
		return ""
	}

	if(com3 == ""){
		com3 = 1
	}

	;com2 := outs_textOutTrimss(com2)
	;com3 := outs_textOutTrimss(com3)

	If com2 is not number
	{
		guit_errorAppend("F_getTextGuiAssign() のエラー`n引数の指定が数字ではない`nGuiNum  " . com2)
		return ""
	}
	If com3 is not number
	{
		guit_errorAppend("F_getTextGuiAssign() のエラー`n引数の指定が数字ではない`nnumber  " . com3)
		return ""
	}

	targetGui = %com2%
	num := guit_editTypeNumGet(targetGui)

	if(num == 1){
		EditAny := "Edit" . targetGui  . "_" . com3
		str := guf_getControl( EditAny, targetGui )
	} else if(num == 3){
		; 二行以上のテキストのＧｕｉなら、引数２ の数字がいくつでも無関係
		BoxEdit1 := "BoxEdit" . targetGui  . "_1"
		str := guf_getControl( BoxEdit1, targetGui )
	} else if(num == 4){
		; 何もしない
	} else if(num == 2){
		EditAny := "Edit" . targetGui  . "_" . com3
		str := guf_getControl( EditAny, targetGui )
	} else {
		EditAny := "Edit" . targetGui  . "_" . com3
		str := guf_getControl( EditAny, targetGui )
	}
	res := guit_checkErrorLevelOutput("F_getTextGuiAssign() でエラー`n引数`n" . com2 . " " . com3)
	if( res ){
		return str
	}
	return ""
}

edi_outTextToTextGuiAssign(rightStr, GuiNum, textOutFlag, addFlag){
	str =
(LTrim
テキスト欄に文字を記入する。
引数に数字を指定して、どのウインドウのテキスト欄かを指定する。
引数１に、Guiの番号。
引数２に、上から何番目のテキスト欄かを指定。
引数３以降、記入する文字。
例
&outArgsToTextGuiAssign  ％A_Gui％  1  文字列
テキスト欄のウインドウにのみ有効
&outArgsToTextGuiAssignAdd  なら、上書きではなく、追加になる
)
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}
	if(rightStr == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}

	IfNotInString, rightStr, %A_Space%
	{
		guit_setExplainPurpose(str, GuiNum)
		return
	}

	arg_1 := func_separationSpaceLeftOrAll(rightStr)
	rightStr2 := func_separationSpaceRightOrNull(rightStr)

	if(rightStr2 == ""){
		guit_setExplain(str, GuiNum)
		guit_errorAppend("&outArgsToTextGuiAssign のエラー`n引数の指定が正しくない`n" . rightStr)
		return
	}
	arg_2 := func_separationSpaceLeftOrAll(rightStr2)
	rightStr3 := func_separationSpaceRightOrNull(rightStr2)

	;rightStr3 は カラでもよい

	arg_1 := outs_textOutTrimss(arg_1)
	arg_2 := outs_textOutTrimss(arg_2)

	If arg_1 is not number
	{
		guit_setExplain(str, GuiNum)
		guit_errorAppend("&outArgsToTextGuiAssign のエラー`n引数の指定が正しくない`n" . rightStr)
		return
	}
	If arg_2 is not number
	{
		guit_setExplain(str, GuiNum)
		guit_errorAppend("&outArgsToTextGuiAssign のエラー`n引数の指定が正しくない`n" . rightStr)
		return
	}

	targetGui = %arg_1%
	num := guit_editTypeNumGet(targetGui)

	if( textOutFlag ){
		rightStr3 := outs_textOutTrimssSharp(rightStr3)
		Transform, rightStr3, Deref, %rightStr3%
	}
	if(num == 1){
		EditAny := "Edit" . targetGui  . "_" . arg_2
		if( addFlag ){
			beforeStr := guf_getControl( EditAny, targetGui )
			rightStr3 := beforeStr . " " . rightStr3
		}
		guf_setControl( rightStr3, EditAny, targetGui )
	} else if(num == 3){
		; 二行以上のテキストのＧｕｉなら、引数２ の数字がいくつでも無関係
		BoxEdit1 := "BoxEdit" . targetGui  . "_1"
		if( addFlag ){
			beforeStr := guf_getControl( BoxEdit1, targetGui )
			rightStr3 := beforeStr . " " . rightStr3
		}
		guf_setControl( rightStr3, BoxEdit1, targetGui )
	} else if(num == 4){
		; 何もしない
	} else if(num == 2){
		EditAny := "Edit" . targetGui  . "_" . arg_2
		if( addFlag ){
			beforeStr := guf_getControl( EditAny, targetGui )
			rightStr3 := beforeStr . " " . rightStr3
		}
		guf_setControl( rightStr3, EditAny, targetGui )
	} else {
		EditAny := "Edit" . targetGui  . "_" . arg_2
		if( addFlag ){
			beforeStr := guf_getControl( EditAny, targetGui )
			rightStr3 := beforeStr . " " . rightStr3
		}
		guf_setControl( rightStr3, EditAny, targetGui )
	}
	guit_checkErrorLevelOutput("&outArgsToTextGuiAssign でエラー`n引数`n" . rightStr)
}
