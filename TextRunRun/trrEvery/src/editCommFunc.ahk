; 必須 glob gGlob guf func outs heard
; chec cof syf aut auts edi


edc_editssCommExeLogic(Edit1, Edit2, Edit3, Edit4, Edit5, Edit6, Edit7, Edit8, Checkbox1, GuiNum, notShortKeyFlag, andFlag){

	Edit1 := Trim(Edit1)
	Edit2 := Trim(Edit2)
	Edit3 := Trim(Edit3)
	Edit4 := Trim(Edit4)
	Edit5 := Trim(Edit5)
	Edit6 := Trim(Edit6)
	Edit7 := Trim(Edit7)
	Edit8 := Trim(Edit8)

	; タブ は スペース に変える
	IfInString, Edit1, `t
	{
		StringReplace, Edit1, Edit1, `t , %A_Space%, All
	}
	IfInString, Edit2, `t
	{
		StringReplace, Edit2, Edit2, `t , %A_Space%, All
	}
	IfInString, Edit3, `t
	{
		StringReplace, Edit3, Edit3, `t , %A_Space%, All
	}
	IfInString, Edit4, `t
	{
		StringReplace, Edit4, Edit4, `t , %A_Space%, All
	}
	IfInString, Edit5, `t
	{
		StringReplace, Edit5, Edit5, `t , %A_Space%, All
	}
	IfInString, Edit6, `t
	{
		StringReplace, Edit6, Edit6, `t , %A_Space%, All
	}
	IfInString, Edit7, `t
	{
		StringReplace, Edit7, Edit7, `t , %A_Space%, All
	}
	IfInString, Edit8, `t
	{
		StringReplace, Edit8, Edit8, `t , %A_Space%, All
	}

	glob_commSuccessFlag := True

	danGerFlag := False
	if(func_checkDangerStr(Edit1)){
		danGerFlag := True
	}
	if(func_checkDangerStr(Edit2)){
		danGerFlag := True
	}
	if(func_checkDangerStr(Edit3)){
		danGerFlag := True
	}
	if(func_checkDangerStr(Edit4)){
		danGerFlag := True
	}
	if(func_checkDangerStr(Edit5)){
		danGerFlag := True
	}
	if(func_checkDangerStr(Edit6)){
		danGerFlag := True
	}
	if(func_checkDangerStr(Edit7)){
		danGerFlag := True
	}
	if(func_checkDangerStr(Edit8)){
		danGerFlag := True
	}

	if(danGerFlag){
		guit_errorAppend("危険な文字あり。")
		return
	}

	focusEdit =
	focusEditValue =
	focusHwnd =
	if( andFlag == False ){
		GuiControlGet, focusEdit , %GuiNum%:FocusV
		; フォーカス位置が　Edit の場合以外なら Edit2 にフォーカスがあるようにする
		focusEdit := guaf_focusCheck(focusEdit, GuiNum)
		if(focusEdit != ""){
			focusEditValue := %focusEdit%
			focusEditValue := Trim(focusEditValue)
		}
		focusHwnd := guf_getHwnd(GuiNum, focusEdit)
	}

	; 入力補完を表示させる系のコマンド
	if( cof_syscommandPopup(Edit1, focusEdit, GuiNum) ) {
		func_sendEndToHwndControle(focusHwnd)
		return
	}

	; ショートカットキーの場合は入力補完の表示は無視する
	if(notShortKeyFlag){
		; タイマー処理か、＆＆で実行された場合、無視するようにする。
		if( andFlag == False ){
			if( autg_pushEnterFromListEditss(GuiNum) ) {		;入力補完の時、Enterの処理
				return
			}
		}
	}

	; フォーカス位置で動作が変わるコマンド
	if( cof_syscommandEarly(Edit1, focusEditValue, focusEdit, focusHwnd, GuiNum) ) {
		;func_sendEndToHwndControle(focusHwnd)
		return
	}

	Edit1Backup := Edit1
	Edit2Backup := Edit2
	Edit3Backup := Edit3
	;Edit4Backup := Edit4
	Edit5Backup := Edit5
	Edit6Backup := Edit6
	Edit7Backup := Edit7
	Edit8Backup := Edit8

	; &&& の処理はこの変数を使う
	Edit8UseAnd := Edit8


	; <<< があれば ファイルの中身か、Guiの文字列を引数として、入れ込む
	;Edit1 := cinp_inputControl(Edit1)
	Edit2 := cinp_inputControl(Edit2)
	Edit3 := cinp_inputControl(Edit3)
	;Edit4 := cinp_inputControl(Edit4)
	Edit5 := cinp_inputControl(Edit5)
	Edit6 := cinp_inputControl(Edit6)
	Edit7 := cinp_inputControl(Edit7)
	Edit8 := cinp_inputControl(Edit8)

	; 早めに実行したいコマンド
	if( cof_syscommandBefore(Edit1, Edit2, focusEdit, GuiNum) ){
		return
	}
/*
	appendEdit := Edit1  . " " . Edit2  . " " . Edit3  . " " . Edit4  . " " . Edit5  . " " . Edit6  . " " . Edit7  . " " . Edit8
	StringSplit, split_ , appendEdit , %A_Space%, %A_Space%
	; 空白がなかった場合 split_1 は 空になる
	if( split_1 == "" ){
		split_1 := Edit1
	} else {
		; コマンドの先頭を取り除く
		StringReplace, rightStr, appendEdit, %split_1%, %null%
		rightStr := Trim(rightStr)
	}
*/

	editAll := Edit1  . " " . Edit2  . " " . Edit3  . " " . Edit5  . " " . Edit6  . " " . Edit7  . " " . Edit8
	rightStr := Edit2  . " " . Edit3  . " " . Edit5  . " " . Edit6  . " " . Edit7  . " " . Edit8
	editAll := Trim(editAll)
	rightStr := Trim(rightStr)

	; &&& を特殊に使う
	if( cof_sysCommSpecial(Edit1, rightStr, editAll, Edit8UseAnd, "", focusEdit, GuiNum, Edit2Backup, andFlag, False) ){
		; 現時点では、履歴に残さなくてもいいとする
		;edc_commEndHistoryInsert(Edit2Backup, Edit3Backup, Edit5Backup, focusEdit, andFlag)
		return
	}

	; &&& がついてた場合、左側の文字だけにする

	;現時点では、「＆＆＆や>>>の引数」で記入している文字のみを処理するようにしている。
	;Edit1 := func_leftStrOrAllFromSearchStr(Edit1, "&&& ")
	;Edit2 := func_leftStrOrAllFromSearchStr(Edit2, "&&& ")
	;Edit3 := func_leftStrOrAllFromSearchStr(Edit3, "&&& ")
	;Edit4 := func_leftStrOrAllFromSearchStr(Edit4, "&&& ")
	;Edit5 := func_leftStrOrAllFromSearchStr(Edit5, "&&& ")
	;Edit6 := func_leftStrOrAllFromSearchStr(Edit6, "&&& ")
	;Edit7 := func_leftStrOrAllFromSearchStr(Edit7, "&&& ")
	Edit8 := func_leftStrOrAllFromSearchStr(Edit8, "&&& ")

	; あとで別に作るのでコメントにする
	;rightStr := func_leftStrOrAllFromSearchStr(rightStr, "&&& ")

	;Edit1 := guit_outPutControl(Edit1, False)
	;Edit2 := guit_outPutControl(Edit2, False)
	;Edit3 := guit_outPutControl(Edit3, False)
	;Edit4 := guit_outPutControl(Edit4, False)
	;Edit5 := guit_outPutControl(Edit5, False)
	;Edit6 := guit_outPutControl(Edit6, False)
	;Edit7 := guit_outPutControl(Edit7, False)
	Edit8 := guit_outPutControl(Edit8, False)

	; あとで別に作るのでコメントにする
	;rightStr := guit_outPutControl(rightStr, False)

	; もう１度、rightStr を作る。このほうが、なにかと誤差がなくて確実
	rightStr := Edit2  . " " . Edit3  . " " . Edit5  . " " . Edit6  . " " . Edit7  . " " . Edit8
	rightStr := Trim(rightStr)
	rightStrTextOut := outs_textOutTrimss(rightStr)

	; 早めに実行したいが、履歴には残したいコマンド。textOutもしている
	if( cof_sysNotSplit(Edit1, rightStrTextOut, focusEdit, GuiNum) ){
		edc_commEndLogic(Edit2Backup, Edit3Backup, Edit5Backup, Edit8UseAnd, focusEdit, GuiNum, andFlag)
		return
	}


	; 現時点では editAll との違いは Edit8 の部分でしかない
	argStrAll := Edit1  . " " . Edit2  . " " . Edit3  . " " . Edit5  . " " . Edit6  . " " . Edit7  . " " . Edit8
	argStrAll := Trim(argStrAll)
	edit1Edit2 := Edit1 . Edit2
	edit1Edit2 := Trim(edit1Edit2)

	if( cof_autohotCommSet(argStrAll, edit1Edit2, focusEdit, GuiNum) ){
		edc_hideAfterCommExe(glob_iniAhkCommExeGuiHide, GuiNum, andFlag)
		edc_commEndLogic(Edit2Backup, Edit3Backup, Edit5Backup, Edit8UseAnd, focusEdit, GuiNum, andFlag)
		return
	}

/*
	; ファイル名のみなら "" をはずす
	Edit2 := edi_trimDbQuouteIfFile(Edit2)
	Edit3 := edi_trimDbQuouteIfFile(Edit3)
	Edit4 := edi_trimDbQuouteIfFile(Edit4)

	; Edit1 が空の時、Edit2 に メインコマンドがあると考える
	Edit2_rigth =
	if(Edit1 == ""){
		IfInString, Edit2, %A_Space%
		{
			StringGetPos, count, Edit2, %A_Space%
			StringTrimLeft, Edit2_rigth, Edit2, %count%
			Edit2_rigth := Trim(Edit2_rigth)
		} else {
			; この値はおそらく空
			Edit2_rigth := Edit2
		}
	} else {
		Edit2_rigth := Edit2
	}
*/

	EditTextOut2 := outs_textOutTrimss(Edit2)
	EditTextOut3 := outs_textOutTrimss(Edit3)
	;EditTextOut4 := outs_textOutTrimss(Edit4)
	EditTextOut5 := outs_textOutTrimss(Edit5)
	EditTextOut6 := outs_textOutTrimss(Edit6)
	EditTextOut7 := outs_textOutTrimss(Edit7)
	EditTextOut8 := outs_textOutTrimss(Edit8)

	; コマンド類の実行
	if(cof_syscommandExecute(Edit1, EditTextOut2, EditTextOut3, EditTextOut5, EditTextOut6, EditTextOut7, EditTextOut8, focusEdit, GuiNum)) {
		edc_commEndLogic(Edit2Backup, Edit3Backup, Edit5Backup, Edit8UseAnd, focusEdit, GuiNum, andFlag)
		return
	}

	if( cof_ifConditional(Edit1, Edit2, Edit3, Edit5, Edit6, Edit7, Edit8, argStrAll, "", focusEdit, GuiNum) ){
		edc_commEndLogic(Edit2Backup, Edit3Backup, Edit5Backup, Edit8UseAnd, focusEdit, GuiNum, andFlag)
		return
	}

	if( cof_equalSubstitutionCommand(Edit1, Edit2, Edit3, Edit5, Edit6, Edit7, argStrAll, focusEdit, GuiNum) ){
		edc_commEndLogic(Edit2Backup, Edit3Backup, Edit5Backup, Edit8UseAnd, focusEdit, GuiNum, andFlag)
		return
	}


	guit_checkErrorLevelOutput("通過点１  " . Edit1)


	if(Checkbox1 == 1){
		Edit3 := outs_orFileToDbQuoute(Edit3)
		Edit5 := outs_orFileToDbQuoute(Edit5)
		Edit6 := outs_orFileToDbQuoute(Edit6)
		Edit7 := outs_orFileToDbQuoute(Edit7)
		Edit8 := outs_orFileToDbQuoute(Edit8)
	}

	rightStr := Edit3 . " " . Edit5 . " " . Edit6 . " " . Edit7
	rightStr := Trim(rightStr)
	rightStrAll := Edit3Backup . " " . Edit5Backup . " " . Edit6Backup . " " . Edit7Backup . " " . Edit8UseAnd
	rightStrAll := Trim(rightStrAll)

	; openConfirmFlag が False になるなら、edi_commandExeLogic() の関数に委譲するので、return をさせないようにする
	openConfirmFlag := True
	if(Edit1 == "&open"){
		; Edit4 は作業フォルダ扱いにする
		openConfirmFlag := edc_sysCommandopen(Edit2, rightStr, Edit4, Edit8, focusEdit, GuiNum, Edit2Backup, Edit3Backup, Edit5Backup, Edit8UseAnd, rightStrAll, andFlag, 1)
		; コマンドの終わりの処理を  excof_itemExecute  で行っている
		;edc_commEndLogic(Edit2Backup, Edit3Backup, Edit5Backup, Edit8UseAnd, focusEdit, GuiNum, andFlag)
		if( openConfirmFlag ){
			return
		}
	}

	if(Edit1 == "&openConfirm"){
		openConfirmFlag := edc_sysCommandopen(Edit2, rightStr, Edit4, Edit8, focusEdit, GuiNum, Edit2Backup, Edit3Backup, Edit5Backup, Edit8UseAnd, rightStrAll, andFlag, 2)
		if( openConfirmFlag ){
			return
		}
	}
	if(Edit1 == "&openConfirmOneLine"){
		openConfirmFlag := edc_sysCommandopen(Edit2, rightStr, Edit4, Edit8, focusEdit, GuiNum, Edit2Backup, Edit3Backup, Edit5Backup, Edit8UseAnd, rightStrAll, andFlag, 3)
		if( openConfirmFlag ){
			return
		}
	}
	if(Edit1 == "&openTextOut"){
		Edit2 := outs_textOutTrimss(Edit2)
		rightStr := outs_textOutTrimss(rightStr)
		Edit8 := outs_textOutTrimss(Edit8)
		openConfirmFlag := edc_sysCommandopen(Edit2, rightStr, Edit4, Edit8, focusEdit, GuiNum, Edit2Backup, Edit3Backup, Edit5Backup, Edit8UseAnd, rightStrAll, andFlag, 1)
		if( openConfirmFlag ){
			return
		}
	}

	; openConfirmFlag が False なら、ここは飛ばすようにする
	if(openConfirmFlag){
		; Edit1 がカラのときのみ実行
		if(Edit1 == ""){
			openFlag := edc_sysCommandopen(Edit2, rightStr, Edit4, Edit8, focusEdit, GuiNum, Edit2Backup, Edit3Backup, Edit5Backup, Edit8UseAnd, rightStrAll, andFlag, 1)
			if( openFlag ){
				; コマンドの終わりの処理を  excof_itemExecute()  で行っている
				;edc_commEndLogic(Edit2Backup, Edit3Backup, Edit5Backup, Edit8UseAnd, focusEdit, GuiNum, andFlag)
				return
			}
		}
	}

	guit_checkErrorLevelOutput("通過点２  " . Edit1)

	; Edit4Backup は省く
	;editFull := Edit1Backup . " " . Edit2Backup . " " . Edit3Backup . " " . Edit5Backup . " " . Edit6Backup . " " . Edit7Backup . " " . Edit8Backup
	;editFull := Trim(editFull)

	; Edit4 は省く。Edit8 は Edit8Backupを使う
	editFull := Edit1 . " " . Edit2 . " " . Edit3 . " " . Edit5 . " " . Edit6 . " " . Edit7 . " " . Edit8Backup
	editFull := Trim(editFull)

	; 「コマンドの実行過程を表示」にチェックしてた場合
	cen_easyCheckAppendNotShow("分割テキストでは処理できないため、一行テキストのやり方で実行する`n" . editFull . "`n" . A_ThisFunc . "`nA_LineNumber  " . A_LineNumber)

	; 認識できなければ、こちらに委譲して実行する
	; notShortKeyFlag は、入力補完の影響を無くすのに都合がいいため、あえて False にしている
	edi_commandExeLogic(editFull, Edit2Backup, focusEdit, GuiNum, focusHwnd, False, andFlag, False)
	;edi_varCheck(Edit1, argStrAll, argStrAll, "", GuiNum)
}

; 必ず実行させたい後処理を追加している。
edc_editssCommExeLogicWrapper(Edit1, Edit2, Edit3, Edit4, Edit5, Edit6, Edit7, Edit8, Checkbox1, GuiNum, notShortKeyFlag, andFlag){
	glob_outputChangeNum = 1
	glob_errorOutputChangeNum = 1
	glob_outputChangeFile =
	edc_editssCommExeLogic(Edit1, Edit2, Edit3, Edit4, Edit5, Edit6, Edit7, Edit8, Checkbox1, GuiNum, notShortKeyFlag, andFlag)
	edi_afterCommandExeLogic()
}

edc_editssCommExeLogicWrapperOfWrapper(enterExeBefore, enterExeAfter, allExeAfter, Edit1, Edit2, Edit3, Edit4, Edit5, Edit6, Edit7, Edit8, Checkbox1, GuiNum){

	; ErrorLevel_TextRunRun はユーザーが初期化しないと変わらないようにしておく
	;ErrorLevel_TextRunRun = 0
	notShortKeyFlag := True
	;ショートカットキーで動作した場合
	if( glob_shortKeyFlag ){
		Edit1 := glob_shortKeyComm
		Edit1 := Trim(Edit1)
		glob_shortKeyFlag := False
		notShortKeyFlag := False
		; %--  の文字があるなら、引数の処理をしない。
		parsentMinus := "%--"
		StringRight, right3Str, Edit1, 3
		if(right3Str == parsentMinus){
			; %--  の文字を消す
			StringTrimRight, Edit1, Edit1, 3
			Edit1 := RTrim( Edit1 )
			Edit2 =
			Edit3 =
			Edit4 =
			Edit5 =
			Edit6 =
			Edit7 =
			Edit8 =
		}
	} else {
		; O_enterExeTextSplit1Before などを使用していた場合
		Edit2 := enterExeBefore . " " . Edit2
		Edit8 := Edit8 . " " . enterExeAfter
	}
	Edit8 := Edit8 . " " . allExeAfter
	;Edit2 := LTrim( Edit2 )
	;Edit8 := RTrim( Edit8 )
	edc_editssCommExeLogicWrapper(Edit1, Edit2, Edit3, Edit4, Edit5, Edit6, Edit7, Edit8, Checkbox1, GuiNum, notShortKeyFlag, False)
}

edc_sysCommandopen(edit2, rightStr, workDir, edit8, pOut, GuiNum, historyEdit2, historyEdit3, historyEdit5, Edit8UseAnd, rightStrAll, andFlag, openNum=1 ) {

	historyStr := historyEdit2 . " " . historyEdit3 . " " . historyEdit5
	if(excof_itemExecute(edit2, rightStr, edit8, pOut, GuiNum, "", historyStr, andFlag, rightStrAll, Edit8UseAnd, False, openNum)) {			; ソフトの実行  本体
		return  True
	}

	edit2 := outs_textOutDqAllTrim(edit2)
	if( func_myFileExist(edit2) )
	{
		pathStr := outs_relativeToAbsoluteFromWorkDir(edit2, A_LineFile, A_LineNumber, False)
		if( outs_checkErrorFile(pathStr) ){
			; コマンドの終わりの処理をここで実行させる
			edc_commEndLogic(historyEdit2, historyEdit3, historyEdit5, Edit8UseAnd, pOut, GuiNum, andFlag)
			return  True
		}

		argss := rightStr . " " . edit8
		argss := Trim(argss)
		argss := outs_textOutTrimss(argss)
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

		dbQuouteChar := """"

		runPath := dbQuouteChar . pathStr . dbQuouteChar . " " . argss
		runPath := Trim(runPath)
		tmpRunPath := pathStr  . " " . argss
		tmpRunPath := Trim(tmpRunPath)
		workDir := Trim( workDir, """" )
		workDir := outs_textOutDqAllTrim(workDir)
		workDir := outs_relativeToAbsoluteFromWorkDir(workDir,  A_LineFile, A_LineNumber, False)
		outs_workDirCheck(workDir, "作業フォルダが不明`n" . workDir)
		if(workDir == ""){
			workDir = %A_WorkingDir%
		}

		cen_easyCheckAppendNotShow("path  "  . runPath, "work  " . workDir . "`n" . A_ThisFunc . "`nA_LineNumber  " . A_LineNumber)


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
			Run, %runPath%,%workDir% , UseErrorLevel
			edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
			cen_checkCommSuccess()
			guit_checkErrorLevelOutput("ファイルの実行に失敗。", "パス`t" . runPath)
		} else if(openNum == 2) {
			edi_openSetEditBoxss(pathStr, argss, workDir, GuiNum)
			edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
		} else if(openNum == 3) {
			guaf_openSetMiniEdit(pathStr, argss, workDir, GuiNum)
			edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
		}
		; コマンドの終わりの処理をここで実行させる
		edc_commEndLogic(historyEdit2, historyEdit3, historyEdit5, Edit8UseAnd, pOut, GuiNum, andFlag)
		return True
	}
	return  False
}

edc_historyInsertEditBoxss(com2, com3, com4) {
	insertFlag := False

	; 履歴を止める変数が ON なら止める
	if( O_textHistoryNotFlag ){
		return
	}

	; 履歴の設定が０なら何もしない
	;if(glob_iniHistoryCount <= 0){
	if(O_textHistory <= 0){
		return
	}
	if(com2 != ""){
		if( func_StringShortMoreNum(com2, 130) ){
			glob_tmpHistoryObj.Insert(com2)
			insertFlag := True
		}
	}
	if(com3 != ""){
		if( func_StringShortMoreNum(com3, 130) ){
			glob_tmpHistoryObj.Insert(com3)
			;追加するなら削除するようにする
			max := glob_tmpHistoryObj.MaxIndex()
			;if(max > glob_iniHistoryCount){
			if(max > O_textHistory){
				glob_tmpHistoryObj.Remove(1)
			}
			insertFlag := True
		}
	}
	if(com4 != ""){
		if( func_StringShortMoreNum(com4, 130) ){
			glob_tmpHistoryObj.Insert(com4)
			;追加するなら削除するようにする
			max := glob_tmpHistoryObj.MaxIndex()
			;if(max > glob_iniHistoryCount){
			if(max > O_textHistory){
				glob_tmpHistoryObj.Remove(1)
			}
			insertFlag := True
		}
	}
	if(insertFlag){
		edi_historyObjSwap()
		syf_historyObjSave()
	}
}

edc_commEndHistoryInsert(com2, com3, com4, pOut, andFlag){
	if( andFlag == False ){
		edc_historyInsertEditBoxss(com2, com3, com4)
		hwndVar := guf_getHwnd(GuiNum, pOut)
		func_sendEndToHwndControle(hwndVar)
	}
}

; ちなみに com4 は入れない
edc_commEndLogic(com2, com3, com5, com8UseAnd, pOut, GuiNum, andFlag){
	; 現時点では com8 のみを &&& 処理の対象にする
	;argStrAll := com1  . " " . com2  . " " . com3  . " " . com5  . " " . com6  . " " . com7  . " " . com8

	; output のフラグは必ずFalse（commboxが他のスクリプトから呼び出されることはないため）
	edi_andAndRStrExeLogic(com8UseAnd, pOut, GuiNum, null, False)
	edc_commEndHistoryInsert(com2, com3, com5, pOut, andFlag)
}

; 入力補完を表示。editssとeditMini で分ける
edc_popupShowEditType(GuiNum, popNum, viewType){
	editType := guit_editTypeNumGet(GuiNum)
	if(editType == 1) {
		autg_pupUpShowEditss(GuiNum, popNum, viewType, True)
	} else if( editType == 2 ) {
		;edi_pupUpShowEditMini(GuiNum, popNum, viewType, True)
		edi_pupUpShowEditAnotherGui(GuiNum, popNum, viewType, True)
	} else if( editType == 0 ) {
		edi_pupUpShowEditAnotherGui(GuiNum, popNum, viewType, True)
	}
}

; 入力補完を表示するだけ。リストの中身は更新しない
edc_popupShowOnlyEditType(GuiNum, popNum, viewType){
	editType := guit_editTypeNumGet(GuiNum)
	if(editType == 1) {
		autg_pupUpShowEditss(GuiNum, popNum, viewType, False)
	} else if( editType == 2) {
		;edi_pupUpShowEditMini(GuiNum, popNum, viewType, False)
		edi_pupUpShowEditAnotherGui(GuiNum, popNum, viewType, False)
	} else if( editType == 0) {
		edi_pupUpShowEditAnotherGui(GuiNum, popNum, viewType, False)
	}
}

edc_viewPopupFromAutoFlag(command, pEdit, GuiNum, pList, listGuiNum){

	; 一度だけ自動で表示させない
	if( glob_lastWordInputListStop ){
		glob_lastWordInputListStop := False
		return
	}

	;if( glob_iniAutoPopupNotViewFlag == False ){
	if( O_inputListAutoNotFlag == False ){
		command := Trim(command)
		if(command == ""){
			edc_commListHideEnyType(GuiNum)
			; 自動で入力補完を表示してるとき、テキストがカラになったら、通常の入力補完に戻す
			glob_pupupNum = 1
			return
		}
		; 入力補完に候補がないなら閉じる
		GuiControl, %listGuiNum%:Choose, %pList%, 1
		if(ErrorLevel == 1){
			ErrorLevel = 0
			edc_commListHideEnyType(GuiNum)
			return
		}
		; 入力補完を未選択にする
		GuiControl, %listGuiNum%:Choose, %pList%, 0

		GuiControlGet, OutputVar, %listGuiNum%:Visible, %pList%
		if(OutputVar != 1){
			edc_popupShowOnlyEditType(GuiNum, 1, 0)
		}
	}
}

edc_commListHideEnyType(GuiNum){
	typeNum := guit_editTypeNumGet(GuiNum)
	res := False
	if(typeNum == 1){
		res := guaf_listVisibleEditss(GuiNum)
	} else if(typeNum == 2){
		;res := edi_commListHide(pList, pEdit, GuiNum)
		res := edi_commListHideAnotherGui()
	} else if(typeNum == 0){
		res := edi_commListHideAnotherGui()
	}
	return  res
}

edc_guiShow(rightStr, GuiNum){
	str := "Ｇｕｉを表示する。引数に番号を入れる。`n例  &guiShow %B_GuiNumText1%`n引数1  Ｇｕｉの番号`n引数2以降  表示の仕方を指定（Gui, Show, Param2  のParam2と同じ指定方法）"
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}
	if(rightStr == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}

	rightStr_left = %rightStr%
	rightStr_right := "_"
	IfInString, rightStr, %A_Space%
	{
		rightStr_left := func_separationSpaceLeftOrAll(rightStr)
		rightStr_left := outs_textOutTrimss(rightStr_left)
		rightStr_right := func_separationSpaceRightOrNull(rightStr)
		rightStr_right := outs_textOutTrimss(rightStr_right)
	}

	If rightStr_left is number
	{
		if(rightStr_left >= 100){
			guit_errorAppend("&guiShowのエラー`nGui の番号が100以上になっている`n引数  " . rightStr)
			return
		}
		guf_showGuiAssign(rightStr_left, rightStr_right)
		return
	}
	guit_errorAppend("&guiShowのエラー`nGui の番号が数字ではない`n引数  " . rightStr)
}

edc_outTextToTextExecutor(rightStr, GuiNum, textOutFlag){
	str := "実行元のテキストの入力欄に引数の文字列をそのまま記入する。`n分割テキストでは、フォーカスされた位置で動作する"
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}
	if(rightStr == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	targetGui = %A_Gui%
	typeNum := guit_editTypeNumGet(targetGui)
	if( textOutFlag ){
		rightStr := outs_textOutTrimss(rightStr)
	}

	if(typeNum == 1){
		GuiControlGet, focusEdit , %targetGui%:FocusV
		focusEdit := guaf_focusCheck(focusEdit, targetGui)
		if( focusEdit != "" ){
			guf_setControl( rightStr, focusEdit, targetGui )
		}
	} else if(typeNum == 3){
		; 何もしない
	} else if(typeNum == 4){
		; 何もしない
	} else if(typeNum == 2){
		Edit1 := "Edit" . targetGui  . "_1"
		guf_setControl( rightStr, Edit1, targetGui )
	} else if(typeNum == 0){
		Edit1 := "Edit" . targetGui  . "_1"
		guf_setControl( rightStr, Edit1, targetGui )
	}
}

edc_sendEndToTextEditExecutor(rightStr, GuiNum){
	str := "実行元のテキストの入力欄のカーソルを右端に移動する"
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}

	focusEdit =
	targetGui = %A_Gui%
	typeNum := guit_editTypeNumGet(targetGui)
	if(typeNum == 1){
		GuiControlGet, focusEdit , %targetGui%:FocusV
		focusEdit := guaf_focusCheck(focusEdit, targetGui)
	} else if(typeNum == 3){
		; 何もしない
	} else if(typeNum == 4){
		; 何もしない
	} else if(typeNum == 2){
		focusEdit := "Edit" . targetGui  . "_1"
	} else if(typeNum == 0){
		focusEdit := "Edit" . targetGui  . "_1"
	}
	if( focusEdit == "" ){
		return
	}
	focusHwnd := guf_getHwnd(targetGui, focusEdit)
	func_sendEndToHwndControle(focusHwnd)
}

; 引数が-hなら説明文を表示し、Trueを返す。
edc_helpViewIfHyphenH(helpStr, com2, GuiNum){
	if(com2 == "-h" || com2 == "-help" || com2 == "--help"){
		guit_setExplainPurpose(helpStr, GuiNum)
		return True
	}
	return False
}

edc_cleanEditEasy(pOut, GuiNum){
	num := guit_editTypeNumGet(GuiNum)
	if(num == 1){
		guit_setEditBoxssAct("", "", "", "", GuiNum)
		Edit5 := "Edit" . GuiNum  . "_5"
		Edit6 := "Edit" . GuiNum  . "_6"
		Edit7 := "Edit" . GuiNum  . "_7"
		Edit8 := "Edit" . GuiNum  . "_8"

		BoxEdit1 := "BoxEdit" . GuiNum  . "_1"
		BoxEdit2 := "BoxEdit" . GuiNum  . "_2"

		guf_setControl( "", Edit5, GuiNum )
		guf_setControl( "", Edit6, GuiNum )
		guf_setControl( "", Edit7, GuiNum )
		guf_setControl( "", Edit8, GuiNum )
		guf_setControl( "", BoxEdit1, GuiNum )
		guf_setControl( "", BoxEdit2, GuiNum )
	} else if(num == 4){
		; 何もしない
	} else {
		guf_setControl( "", pOut, GuiNum )
	}
}

edc_cleanEditSome(pOut, GuiNum){
	num := guit_editTypeNumGet(GuiNum)
	if(num == 1){
		pOut2 := "Edit" . GuiNum  . "_2"
		guf_setControl( "", pOut2, GuiNum )
		edc_textSizeBasisRestore(GuiNum)
	} else if(num == 2){
		guf_setControl( "", pOut, GuiNum )
		edc_textSizeBasisRestore(GuiNum)
	} else if(num == 3){
		; 二行以上のＧｕｉなら何もしない
		;guf_setControl( "", pOut, GuiNum )
	}
	; num が 4 でも何もしない
}

; 閉じるか、最小化
edc_hideCommGuiNotActiveIfCommOnly(GuiNum){
	typeNum := guit_editTypeNumGet(GuiNum)
	if(typeNum == 4){
		;何もしない
		return
	}
	if(typeNum == 2){
		; 入力補完も閉じる
		edc_commListHideEnyType(GuiNum)
		; テキストを最小化させる設定
		;if( glob_iniTextGuiMinimize ){
		if( O_minimizeTextFlag ){
			Gui, %GuiNum%:Minimize
			return
		}
		if( glob_reloadIniCommGuiOnlyFlag ){
			if(GuiNum == 63){
				;Send, !{Esc}
				Gui, %GuiNum%:Minimize
				return
			}
		}
		guf_hideGuiAssign(GuiNum)
	} else if(typeNum == 1){
		; テキストを最小化させる設定
		;if( glob_iniTextGuiMinimize ){
		if( O_minimizeTextFlag ){
			Gui, %GuiNum%:Minimize
			return
		}
		guf_hideGuiAssign(GuiNum)
	}
}

; 閉じるか、テキスト１なら、終了かどうか
edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum){
	typeNum := guit_editTypeNumGet(GuiNum)
	if(typeNum == 4){
		;何もしない
		return
	}
	if(typeNum == 2){
		; 入力補完も閉じる
		edc_commListHideEnyType(GuiNum)
		; テキストを最小化させる設定
		;if( glob_iniTextGuiMinimize ){
		if( O_minimizeTextFlag ){
			Gui, %GuiNum%:Minimize
			return
		}
		if(GuiNum == 63){
			; テキスト１が閉じたら終了の設定かどうか
			edi_exitAppIfCommGuiOnlyFlag()
		}
		guf_hideGuiAssign(GuiNum)
	} else if(typeNum == 1){
		; テキストを最小化させる設定
		;if( glob_iniTextGuiMinimize ){
		if( O_minimizeTextFlag ){
			Gui, %GuiNum%:Minimize
			return
		}
		guf_hideGuiAssign(GuiNum)
	}
}

edc_cleanHideAfterCommExe(cleanTextFlag, hideFlag, pOut, GuiNum, andFlag){
	if( andFlag ){
		return
	}
	if( cleanTextFlag ){
		edc_cleanEditSome(pOut, GuiNum)
		if( hideFlag ){
			; Guiが再び表示されてしまうので、遅らせる
			;Sleep, 300
			edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
		}
		return
	}

	if( hideFlag ){
		edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
	}
}

; edc_hideAfterCommExe() と hideFlag の効果が逆になっている
edc_cleanHideAfterCommExeFileType(cleanTextFlag, notHideFlag, pOut, GuiNum, andFlag){
	; andFlag で 連続実行の時、処理を止めるようにしていたが、
	; ファイル・フォルダの場合は連続実行でも、処理をさせるようにした
	;if( andFlag ){
	;	return
	;}
	if( cleanTextFlag ){
		edc_cleanEditSome(pOut, GuiNum)
		if( notHideFlag ){
			return
		}
		; Guiが再び表示されてしまうので、遅らせる
		;Sleep, 300
		edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
		return
	}

	if( notHideFlag ){
		return
	}
	edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
}

edc_hideAfterCommExe(hideFlag, GuiNum, andFlag){
	if( andFlag ){
		return
	}
	if( hideFlag ){
		edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
	}
}

edc_stockCommExeLogic(GuiNum){
	; %--  の文字があるなら、引数の処理をしない。引数の追加もしない。
	parsentHyphen := "%--"
	stockEditValue := glob_stockEditValue
	stockEditValue := RTrim( stockEditValue )
	stockEditValue := edi_replaceOtherEditAll(stockEditValue, 1)
	StringLen, editLength, stockEditValue
	if(editLength >= 3){
		StringRight, right3Str, stockEditValue, 3
		if(right3Str == parsentHyphen){
			; %--  の文字を消す
			StringTrimRight, stockEditValue, stockEditValue, 3
		}
	}
	; 現時点では GuiNum を使わずに、GuiNumは 71 にする
	edi_commandExeLogicWrapper(stockEditValue, "", "", 71, null, True, True)
	glob_stockEditValue := ""
}

edc_buttonPictureAddEnyExtFile(noExtFile, pictureOption, buttonOption, GuiNum){
	if( outs_bgPictureAddEnyExtFile(noExtFile, pictureOption, GuiNum) == False ){
		Gui, %GuiNum%:Add, Button, %buttonOption%, 決定
	}
}

; テキストの幅を元に戻す。
; 現時点では、アクティブか、非表示のときのみ動作する。
edc_textSizeBasisRestore(GuiNum){
	flag := False
	widthWindowBasis =
	winTitle =
	if(GuiNum == 61){
		GuiControl, 61:Move, Edit61_1, W%O_widthBasisTextSplit1%
		GuiControl, 61:Move, Edit61_2, W%O_widthBasisTextSplit1%
		GuiControl, 61:Move, Edit61_3, W%O_widthBasisTextSplit1%
		GuiControl, 61:Move, Edit61_4, W%O_widthBasisWorkDirTextSplit1%
		widthWindowBasis = %O_widthWindowBasisTextSplit1%
		winTitle := gGlob_Gui61Title
		flag := True
	} else if(GuiNum == 62){
		GuiControl, 62:Move, Edit62_1, W%O_widthBasisTextSplit2%
		GuiControl, 62:Move, Edit62_2, W%O_widthBasisTextSplit2%
		GuiControl, 62:Move, Edit62_3, W%O_widthBasisTextSplit2%
		GuiControl, 62:Move, Edit62_4, W%O_widthBasisWorkDirTextSplit2%
		widthWindowBasis = %O_widthWindowBasisTextSplit2%
		winTitle := gGlob_Gui62Title
		flag := True
	} else if(GuiNum == 63){
		GuiControl, %GuiNum%:Move, Edit63_1, W%O_widthBasisText1%
		widthWindowBasis = %O_widthWindowBasisText1%
		winTitle := gGlob_Gui63Title
		flag := True
	} else if(GuiNum == 64){
		GuiControl, %GuiNum%:Move, Edit64_1, W%O_widthBasisText2%
		widthWindowBasis = %O_widthWindowBasisText2%
		winTitle := gGlob_Gui64Title
		flag := True
	} else if(GuiNum == 65){
		GuiControl, %GuiNum%:Move, Edit65_1, W%O_widthBasisText3%
		widthWindowBasis = %O_widthWindowBasisText3%
		winTitle := gGlob_Gui65Title
		flag := True
	}
	if( flag ){
		IfWinActive , %winTitle%
		{
			Gui, %GuiNum%:Show, w%widthWindowBasis%
		}
		IfWinNotExist , %winTitle%
		{
			Gui, %GuiNum%:Show, Hide w%widthWindowBasis%
		}
	}
}

; &cleanText の 数字を指定してどのＧｕｉのテキストを消すかを指定するコマンド
edc_cleanEditAssign(com2, com3, GuiNum){
	str =
(LTrim
&cleanText と同じく、テキスト欄の文字を消す。
引数に数字を指定して、どのウインドウかを指定する。
&cleanTextAssign  ％A_Gui％

引数２に数字を指定すると、指定した番号のテキスト欄の文字のみを消す。
&cleanTextAssign  ％B_GuiNumTextSplit1％  2
)
	if( edc_helpViewIfHyphenH(str, com2, GuiNum) ){
		return
	}
	if(com2 == ""){
		; 何もしない(A_Guiに何もない時)
		;guit_setExplainPurpose(str, GuiNum)
		return
	}
	If com2 is not number
	{
		guit_setExplainPurpose(str, GuiNum)
		return
	}

	targetGui = %com2%
	num := guit_editTypeNumGet(targetGui)

	; 引数２があった場合
	if(com3 != ""){
		If com3 is not number
		{
			guit_setExplainPurpose(str, GuiNum)
			return
		}
		if(num == 1){
			EditAny =
			; 引数２が、9 か 10 なら、説明欄を消す
			if(com3 == 9){
				EditAny := "BoxEdit" . targetGui  . "_1"
			} else if(com3 == 10){
				EditAny := "BoxEdit" . targetGui  . "_2"
			} else {
				EditAny := "Edit" . targetGui  . "_" . com3
			}
			guf_setControl( "", EditAny, targetGui )
		} else if(num == 3){
			; 二行以上のテキストのＧｕｉなら、処理を変えない
			BoxEdit1 := "BoxEdit" . targetGui  . "_1"
			guf_setControl( "", BoxEdit1, targetGui )
		} else if(num == 4){
			; 何もしない
		} else {
			EditAny := "Edit" . targetGui  . "_" . com3
			guf_setControl( "", EditAny, targetGui )
		}
		guit_checkErrorLevelOutput("&cleanTextAssign でエラー`n引数`n" . com2 . " " . com3)
		return
	}

	if(num == 1){
		guit_setEditBoxssAct("", "", "", "", targetGui)
		Edit5 := "Edit" . targetGui  . "_5"
		Edit6 := "Edit" . targetGui  . "_6"
		Edit7 := "Edit" . targetGui  . "_7"
		Edit8 := "Edit" . targetGui  . "_8"

		BoxEdit1 := "BoxEdit" . targetGui  . "_1"
		BoxEdit2 := "BoxEdit" . targetGui  . "_2"

		guf_setControl( "", Edit5, targetGui )
		guf_setControl( "", Edit6, targetGui )
		guf_setControl( "", Edit7, targetGui )
		guf_setControl( "", Edit8, targetGui )
		guf_setControl( "", BoxEdit1, targetGui )
		guf_setControl( "", BoxEdit2, targetGui )
		; テキストのサイズを戻す
		edc_textSizeBasisRestore(targetGui)
	} else if(num == 3){
		BoxEdit1 := "BoxEdit" . targetGui  . "_1"
		guf_setControl( "", BoxEdit1, targetGui )
	} else if(num == 4){
		; 何もしない
	} else if(num == 2){
		Edit1 := "Edit" . targetGui  . "_1"
		guf_setControl( "", Edit1, targetGui )
		; テキストのサイズを戻す
		edc_textSizeBasisRestore(targetGui)
	} else {
		Edit1 := "Edit" . targetGui  . "_1"
		guf_setControl( "", Edit1, targetGui )
	}
	guit_checkErrorLevelOutput("&cleanTextAssign でエラー`n引数`n" . com2)
}
