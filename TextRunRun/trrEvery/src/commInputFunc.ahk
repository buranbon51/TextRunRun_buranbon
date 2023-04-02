
cinp_deleteSnippetLogic(keyWord, GuiNum){

	optionObj := glob_snippetObj[keyWord]
	if( IsObject( optionObj ) ) {
		func_folderCheckMakeFolder(gloco_userDir)

		fileFlag := optionObj[2]
		if(fileFlag == 1){
			listFile := gloco_userDir . glob_snippetListFileName
			iniFile := gloco_userDir . glob_snippetFileName

			IniDelete, %iniFile%, %keyWord%
			res := guit_checkErrorLevelOutput("簡易入力のiniファイルの削除に失敗している`n" . keyWord)
			if( res ){
				cen_anyFileEntryDisplay("簡易入力の削除", keyWord . "`nの簡易入力を削除した")
			} else {
				; エラーなら中断
				return  False
			}

			; ファイルから 元のアイテム名と一致している行以外 全て読み込む
			listStr := ite_wordTrimfileRead(keyWord, listFile, "", "")
			FileDelete, %listFile%
			FileAppend, %listStr%, %listFile%
		}
		glob_snippetObj.Remove(keyWord)
		res := guit_checkErrorLevelOutput("簡易入力の削除でエラーあり`n" . keyWord)
		if(res){
			guit_setExplain(keyWord . " の簡易入力を削除した", GuiNum)
			return  True
		}
	} else {
		guit_errorAppend("簡易入力の削除でエラー。`nキー名が見つからない`n" . keyWord)
	}
	return  False
}

cinp_submitSnippetDelete(keyWord, GuiNum){
	if( cinp_deleteSnippetLogic(keyWord, GuiNum) ){
		; アイテム一覧が出てたら更新する
		cen_updateEveryInputGui()
	}
}

cinp_snippetDelete(argss, pControl, GuiNum){
	str := "簡易入力を削除する。`n引数  キーになる文字"
	if( edc_helpViewIfHyphenH(str, argss, GuiNum) ){
		return
	}
	if(argss == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	if( cinp_deleteSnippetLogic(argss, GuiNum) ){
		; アイテム一覧が出てたら更新する
		cen_updateEveryInputGui()
	}
}

cinp_editSnippetEntry(keyWord, sentence, spaceFlag){
	func_folderCheckMakeFolder(gloco_userDir)
	optionObj := glob_snippetObj[keyWord]
	if( IsObject( optionObj ) == False ){
		guit_errorAppend("簡易入力の編集でエラー。`n以下のキー名が見つからない`n" . keyWord)
		return  False
	}
	fileFlag := optionObj[2]
	if( fileFlag == 2 ){
		guit_setExplainOtherThanCommand("この簡易入力はコマンドから登録したものなので変更できない")
		return  False
	} else if( fileFlag == 3 ){
		guit_setExplainOtherThanCommand("この簡易入力はfromFileNameから登録したものなので変更できない")
		return  False
	} else if( fileFlag == 0 ){
		guit_setExplainOtherThanCommand("この簡易入力は規定のものなので変更できない")
		return  False
	}

	;glob_snippetObj.Remove(keyWord)

	cen_snippetObjInsert(keyWord, sentence, spaceFlag, 1, "", "")

	cinp_snippetWriteiniFile(keyWord, sentence, spaceFlag)
	res := guit_checkErrorLevelOutput("簡易入力のiniファイル書き込み時にエラー")
	if(res){
		return  True
	}
	return  False
}

cinp_submitSnippetEdit(keyWord, sentence, spaceFlag){

	keyWord := Trim(keyWord)
	if(keyWord == ""){
		guit_setExplainOtherThanCommand("キーになる文字が入っていない")
		return
	}

	func_msgBoxOkCancelModal(keyWord . "`nの簡易入力を編集してよいか？`n（登録はファイルに保存される）", "簡易入力の編集")
	IfMsgBox, OK
	{
		; そのまま実行
	} else {
		return
	}

	; sentence は Trim をしない
	tmpSentence := Trim(sentence)
	if( tmpSentence == "" ) {
		guit_setExplainOtherThanCommand("展開後の文字が入っていない")
		return
	}

	StringLower, keyWordLower, keyWord
	StringLower, sentenceLower, sentence
	if(keyWordLower == sentenceLower){
		guit_errorAppend("キー名と展開後の文字が同じものは禁止にしている`n" . keyWord)
		return
	}

	;Gui, 89:Hide

	res := cinp_editSnippetEntry(keyWord, sentence, spaceFlag)
	if(res){
		;guit_setExplainOtherThanCommand(keyWord . " の簡易入力を編集した")
		cen_anyFileEntryDisplay("簡易入力の編集", keyWord . " の簡易入力を編集した")
		; リスト一覧を更新する
		cen_updateEveryInputGui()
	}
}

cinp_newSnippetEntry(keyWord, sentence, spaceFlag){
	cen_snippetObjInsert(keyWord, sentence, spaceFlag, 1, "", "")

	cinp_snippetWriteiniFile(keyWord, sentence, spaceFlag)
	res := guit_checkErrorLevelOutput("簡易入力のiniファイルへの書き込み時にエラー")
	if(res == False){
		return  False
	}

	listFile := gloco_userDir . glob_snippetListFileName
	keyWord := keyWord . "`n"
	FileAppend, %keyWord%, %listFile%
	res := guit_checkErrorLevelOutput("簡易入力のキー名のリストのファイルへの書き込み時にエラー")
	if(res){
		return  True
	}
	return  False
}

cinp_snippetWriteiniFile(keyWord, sentence, spaceFlag){
	func_folderCheckMakeFolder(gloco_userDir . glob_userSnippetDirName)
	iniFile := gloco_userDir . glob_snippetFileName

	; ini ファイルの設定上、"" が両端にあったら読み込み時に削除されるので""を２重につける
	StringLeft, lChr, sentence, 1
	if(lChr == """"){
		StringRight, rChr, sentence, 1
		if(lChr == """"){
			sentence := """" . sentence  . """"
		}
	}

	IniWrite, %sentence%, %iniFile%, %keyWord%, sentence
	IniWrite, %spaceFlag%, %iniFile%, %keyWord%, spaceFlag
}

cinp_submitSnippetEntry(keyWord, sentence, spaceFlag){
	keyWord := Trim(keyWord)
	if(keyWord == ""){
		guit_setExplainOtherThanCommand("キーになる文字が入っていない")
		return
	}

	func_msgBoxOkCancelModal(keyWord . "`nの簡易入力を新規登録してよいか？`n（登録はファイルに保存される）", "簡易入力の新規登録")
	IfMsgBox, OK
	{
		; そのまま実行
	} else {
		return
	}

	; sentence は Trim をしない
	tmpSentence := Trim(sentence)
	if( tmpSentence == "" ) {
		guit_setExplainOtherThanCommand("展開後の文字が入っていない")
		return
	}

	StringLower, keyWordLower, keyWord
	StringLower, sentenceLower, sentence
	if(keyWordLower == sentenceLower){
		guit_errorAppend("キー名と展開後の文字が同じものは禁止にしている`n" . keyWord)
		return
	}

	if( IsObject( glob_snippetObj[keyWord] ) ) {
		guit_errorAppend(keyWord . "  の簡易入力はすでに登録されている。")
		return
	}

	;Gui, 89:Hide

	res := cinp_newSnippetEntry(keyWord, sentence, spaceFlag)
	if(res){
		;guit_setExplainOtherThanCommand(keyWord . " の簡易入力を登録した")
		cen_anyFileEntryDisplay("簡易入力の登録", keyWord . " の簡易入力を登録した")
		; リスト一覧を更新する
		cen_updateEveryInputGui()
	}
}

cinp_autoSetSnippet( str, pEdit1, pCheckbox1, pText1, pText2, GuiNum ){
	optionObj := glob_snippetObj[str]
	if(IsObject(optionObj)){
		guf_setControl( optionObj[1], pEdit1, GuiNum )
		guf_setControl( optionObj[3], pCheckbox1, GuiNum )

		fileFlag := optionObj[2]
		if( fileFlag == 1 ){
			guf_setControl( "", pText1, GuiNum )
			guf_setControl( "", pText2, GuiNum )
		} else if( fileFlag == 0 ){
			GuiControl, %GuiNum%:+c2ED8C9, %pText1%
			guf_setControl( "規定のスニペット", pText1, GuiNum )
			guf_setControl( "", pText2, GuiNum )
		} else if( fileFlag == 2 ){
			GuiControl, %GuiNum%:+c46D82E, %pText1%
			guf_setControl( "コマンドから登録", pText1, GuiNum )
			guf_setControl( "", pText2, GuiNum )
		} else if( fileFlag == 3 ){
			GuiControl, %GuiNum%:+cFFB255, %pText1%
			GuiControl, %GuiNum%:+cFFB255, %pText2%
			guf_setControl( "fromFileNameから登録", pText1, GuiNum )
			guf_setControl( optionObj[4], pText2, GuiNum )
		} else if( fileFlag == 4 ){
			GuiControl, %GuiNum%:+c46D82E, %pText1%
			GuiControl, %GuiNum%:+c46D82E, %pText2%
			guf_setControl( "コマンドから登録", pText1, GuiNum )
			guf_setControl( optionObj[4], pText2, GuiNum )
		}
	}
}

cinp_snippetOpen(com2, pControl, hwnd, GuiNum){
	if(com2 == "") {
		return
	}
	IfInString, com2, %A_Space%
	{
		StringGetPos, index, com2, %A_Space%, R1
		StringTrimLeft, com2Last, com2, index
		StringLeft, com2Before, com2, index
		com2Before := RTrim(com2Before)
		com2Last := Trim(com2Last)
		optionObj := glob_snippetObj[com2Last]
		if( IsObject( optionObj ) ){
			if( optionObj[3] ){
				com2Last := optionObj[1] . " "
			} else {
				com2Last := optionObj[1]
			}
		} else {
			guit_setExplain(com2Last . "`nの簡易入力が見つからない", GuiNum)
			return
		}
		com2 := com2Before  . " " . com2Last
	} else {
		optionObj := glob_snippetObj[com2]
		if( IsObject( optionObj ) ){
			if( optionObj[3] ){
				com2 := optionObj[1] . " "
			} else {
				com2 := optionObj[1]
			}
		} else {
			guit_setExplain(com2 . "`nの簡易入力が見つからない", GuiNum)
			return
		}
	}

	guf_setControl( com2 , pControl, GuiNum )
	guf_setFocus(pControl, GuiNum)
	func_sendEndToHwndControle(hwnd)
}

; com5 は今後のために残しているだけ。
cinp_snippetAdd(com2, com3, com4, com5, GuiNum){
	str := "簡易入力追加する。引数1  キーになる文字`n引数2  展開する文字`n引数3  最後にスペースをつける（TrueかFalse）"
	if( edc_helpViewIfHyphenH(str, com2, GuiNum) ){
		return
	}
	com2 := Trim(com2)
	if(com2 == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	tmpCom3 := Trim(com3)
	if(tmpCom3 == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}

	StringLower, keyWordLower, com2
	StringLower, sentenceLower, com3
	if(keyWordLower == sentenceLower){
		guit_errorAppend("&snippetAdd のエラー`nキー名と展開後の文字が同じものは禁止にしている`n" . com2)
		return
	}

	if( com4 == "" ){
		com4 := False
	}
	com4 := outs_getFlagByOnOffStrOrBasicAndErrMsg(com4, False, com2 . "`nの &snippetAdd の spaceFlag")

	;IfInString, com5, ###n
	;{
	;	StringReplace, com5, com5, ###n , `n, All
	;}

	cen_snippetObjInsert(com2, com3, com4, 2, "", "")
	guit_setExplain(com2 . "`nの簡易入力を追加した", GuiNum)
}

cinp_sendTextItself(rightStr, GuiNum){
	str := "Send,Key ではテキスト自体にはキーを送れないため、`nテキストにキーを送る場合に使う。`nSend,Key と同じ書式で指定。`n例`n&sendTextItself  {End}`nちなみに`n&sendTextItself  return  なら何もしない"
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}
	rightStr := Trim(rightStr)
	if(rightStr == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	; 引数１が , だったら、 , で区切る仕様に変える
	StringLeft, lChr, rightStr, 1
	if( lChr == "," ){
		; 左の , を取り除くだけ
		StringTrimLeft, rightStr, rightStr, 1
	}

	if(rightStr == "return"){
		; 引数が return だったら、何もしないようにする
		return
	}

	;rightStr := outs_textOutTrimss(rightStr)

	IfWinActive , %gGlob_GuiCommandTitle%
	{
		Send, %rightStr%
	}
	;Send, %rightStr%
}

cinp_sendPasteFromFile(rightStr, GuiNum, textOutFlag){
	str := "ファイルを指定する。`n指定したファイルの中身を貼り付ける"
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}
	if(rightStr == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}

	rightStr := outs_textOutDqAllTrim(rightStr)
	str := outs_getStrFromReadFile(rightStr)
	if( str == "" ){
		guit_errorAppend("&sendPasteFromFile のエラー。`nファイルの文字が読み込めない")
		return
	}

	tmpStr := Clipboard

	if( textOutFlag ){
		str := outs_textOutTrimss(str)
	}

	Clipboard := str

	;edi_hideGuiTextPatternAnyWinActiveWait()
	edc_hideCommGuiNotActiveIfCommOnly(GuiNum)
	windc_anyWaitActive()

	ClipWait, 1
	if(ErrorLevel == 1){
		guit_errorAppend("&sendPasteFromFile のエラー。`nClipWaitのエラー")
		return
	}
	Sleep, 200
	; まだ、クリップボードが変更されてないなら、少し待つ
	if(Clipboard != str){
		Sleep, 300
	}
	if(Clipboard != str){
		Sleep, 300
	}
	if(Clipboard != str){
		Sleep, 300
	}

	Send, ^v
	Sleep, 300
	Clipboard := tmpStr
}

cinp_sendPaste(rightStr, GuiNum, textOutFlag){
	str := "文字を貼り付ける。`n&sendPasteTextOut  の場合は、Transform, , Deref, で１度文字を変化させてから貼り付ける"
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}
	if(rightStr == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}

	tmpStr := Clipboard

	; `n の文字を改行に変える
	;rightStr := func_linefeedReplace(rightStr)

	; `n の文字を変えたり、%%の文字を展開したり
	;Transform, rightStr, Deref, %rightStr%

	if( textOutFlag ){
		rightStr := outs_textOutTrimss(rightStr)
		; `n の文字を変えたり、%%の文字を展開したり
		Transform, rightStr, Deref, %rightStr%
	}

	Clipboard := rightStr

	;edi_hideGuiTextPatternAnyWinActiveWait()
	edc_hideCommGuiNotActiveIfCommOnly(GuiNum)
	windc_anyWaitActive()

	ClipWait, 1
	if(ErrorLevel == 1){
		guit_errorAppend("&sendPaste のエラー。`nClipWaitのエラー")
		return
	}
	Sleep, 200
	; まだ、クリップボードが変更されてないなら、少し待つ
	if(Clipboard != rightStr){
		Sleep, 300
	}
	if(Clipboard != rightStr){
		Sleep, 300
	}
	if(Clipboard != rightStr){
		Sleep, 300
	}

	Send, ^v
	Sleep, 300
	Clipboard := tmpStr
}

cinp_inputDifferentiate(str){
	returnValue =
	StringLower, strLower, str
	if(strLower == "null" || strLower == "no" ||  strLower == "d_none"){
		
	} else if(strLower == "d_outputgui"){
		returnValue := guf_getControl( "BoxEdit66_1", 66 )
	} else if(strLower == "d_tmpoutputgui"){
		returnValue := guf_getControl( "BoxEdit68_1", 68 )
	} else if(strLower == "d_errorgui"){
		returnValue := guf_getControl( "BoxEdit67_1", 67 )
	} else if(strLower == "d_readfilegui"){
		returnValue := guf_getControl( "BoxEdit69_1", 69 )
	} else if(strLower == "d_tmpoutputfile"){
		str := gloco_userDir . glob_outputTmpFileName
		str := outs_textOutDqAllTrim(str)
		if( func_isFolder(str) ){
			guit_errorAppend(str . "`nはフォルダなので読み込めない")
		} else {
			if( func_myFileExist(str) ){
				if( outs_similarTxtFile(str) == False ){
					guit_errorAppend(str . "`nこのファイルは拡張子の問題で読み込まないようにしている。")
					return null
				}
				FileRead, outValue, %str%
				res := guit_checkErrorLevelOutput("ファイルの読み込みにエラーがある")
				if(res){
					returnValue := outValue
				}
			} else {
				guit_errorAppend(str . "`nこのファイルは存在しない。")
			}
		}
	} else {
		str := outs_textOutDqAllTrim(str)
		if( func_isFolder(str) ){
			guit_errorAppend(str . "`nはフォルダなので読み込めない")
		} else {
			if( func_myFileExist(str) ){
				if( outs_similarTxtFile(str) == False ){
					guit_errorAppend(str . "`nこのファイルは拡張子の問題で読み込まないようにしている。")
					return null
				}
				FileRead, outValue, %str%
				res := guit_checkErrorLevelOutput("ファイルの読み込みにエラーがある")
				if(res){
					returnValue := outValue
				}
			} else {
				guit_errorAppend(str . "`nこのファイルは存在しない。")
			}
		}
	}
	returnValue := Trim(returnValue)

	;前後の改行を取り除く
	returnValue := Trim(returnValue, "`n")

	return returnValue
}

cinp_inputControlLogic(argStr, searchStr, plus){
	LAndArgStr := func_leftStrOrAllFromSearchStr(argStr, "&&& ")
	LWordargStr := func_leftStrOrAllFromSearchStr(LAndArgStr, searchStr)

	rAndArgStr := func_rightStrOrNullFromSearchStr(argStr, "&&& ")
	if( rAndArgStr != "" ){
		rAndArgStr := " &&& " . rAndArgStr
	}


	StringGetPos, index, LAndArgStr, %searchStr%
	index += plus
	StringTrimLeft, rightStr, LAndArgStr, %index%
	rightStr := Trim(rightStr)
	word =
	rightFromWord =
	IfInString, rightStr, %A_Space%
	{
		StringGetPos, index, rightStr, %A_Space%
		StringLeft, word, rightStr, %index%
		word := Trim(word)
		StringTrimLeft, rightFromWord, rightStr, %index%
		rightFromWord := Trim(rightFromWord)
	} else {
		word := rightStr
	}

	fromInput := cinp_inPutDifferentiate(word)

	LAndArgStr := LWordargStr . " " . fromInput . " " . rightFromWord
	LAndArgStr := Trim(LAndArgStr)

	argStr := LAndArgStr . rAndArgStr
	return argStr
}

; 引数のみに使用する
cinp_inputControlSecondArg(argStr){
	searchStr := "<<< "
	IfInString, argStr, %searchStr%
	{
		; 引数のみ変更があるようにする
		mainCom := func_separationSpaceLeftOrAll(argStr)
		rightStr := func_separationSpaceRightOrNull(argStr)
		IfInString, rightStr, %searchStr%
		{
			rightStr := cinp_inputControlLogic(rightStr, searchStr, 3)
			argStr := mainCom . " " . rightStr
		}
	}
	return argStr
}

; <<< があれば ファイルの中身か、Guiの文字列を引数として、入れ込む
cinp_inputControl(argStr){
	searchStr := "<<< "
	IfInString, argStr, %searchStr%
	{
		argStr := cinp_inputControlLogic(argStr, searchStr, 3)
	}
	return argStr
}
