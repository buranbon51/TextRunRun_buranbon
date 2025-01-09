





musc_multipleScriptsExe(scripts, pControl, GuiNum, hwnd, outPutSucceedFlag, count){
	smicron := "`;"		; コメントの文字

	if(count >= 11){
		guit_errorAppend("現時点では10回以上続く ブロック文は処理できない。`n以下の構文は処理できない`n" . scripts)
		return True
	}

	loopCount = 0
	; 現時点では最大でも、100行までしか処理しない
	nowCommand =
	beforeCommand =
	ifSentence =
	buffComm =
	leftChar =
	blockFlag := False
	Loop, Parse, scripts , `n, `r
	{
		if(loopCount >= 100){
			guit_errorAppend("現時点では100行以上の処理はできない`n以下のスクリプト以降は実行しない`n" . A_LoopField)
			break
		}

		nowCommand := Trim(A_LoopField)
		if(nowCommand != ""){
			StringLeft, leftChar, nowCommand, 1
			if(leftChar != smicron){		; があったらコメント扱い


				loopCount++
				if(beforeCommand != ""){

					if( blockFlag ){
						; ブロック文なら
						buffComm .= nowCommand . "`n"
						if( ifco_blockConfirmOnly(buffComm, "{", "}") ){
							; { と } の数が等しいとき。または、ブロック文ではないとき
							; nowCommand  が  } else { と記述があった場合はここを通過しないはず

							; } else かどうかを調べる
							tmpNowCommand := LTrim( nowCommand, "}" )
							tmpNowCommand := Trim(tmpNowCommand)
							StringLeft, L4Str, tmpNowCommand, 4
							StringLower, L4StrLower, L4Str
							if(L4StrLower == "else"){
								; } else   と記述されていたとき、ブロック文の処理をあと1回続ける
							} else {
								; if文実行。処理する構文を取得
								ansBuffComm := musc_exeBuffCommFromIfSentence(ifSentence, buffComm, pControl, GuiNum)
								; 再帰的処理
								countPlus := count + 1
;guit_appendExplain("ブロック文のif文を実行`n" . ansBuffComm)
								; 返り値が True なら、再帰的に終了させる
								if( musc_multipleScriptsExe(ansBuffComm, pControl, GuiNum, hwnd, outPutSucceedFlag, countPlus) ){
									return True
								}
								buffComm =
								ifSentence =
								blockFlag := False
								; nowCommand をカラにして、二重に実行されるのを防ぐ
								nowCommand =
							}
						} ; { と } の数が等しいとき。
					} else {
						; ブロック文でないとき

						; if文の行 の末尾に { かどうか調べる。ブロック文の中に無い場合のみ対応する
						StringRight, rightChar, beforeCommand, 1
						if( rightChar == "{" ){
							beforeCommand := RTrim( beforeCommand, "{" )
							nowCommand := "{ " . nowCommand
						}
						; ブロック文のスタートかどうか
						StringLeft, LChar, nowCommand, 1
						if(LChar == "{"){
							blockFlag := True
							ifSentence := beforeCommand
							buffComm .= nowCommand . "`n"
							if( ifco_blockConfirmOnly(buffComm, "{", "}") ){
								guit_errorAppend("一行で閉じるブロック文はエラー`n" . buffComm)
								return True
							}
						} else {	; if(LChar == "{"){
							; if文かどうか確認
							ansNum := ifco_flagFromIfConditional(beforeCommand, pControl, GuiNum)
							if(ansNum == 4){
								; エラーを表示するだけ。 ansNum == 3 だったら、何もしない
								guit_errorAppend("このif文は構文的にエラー`n" . ifSentence)
							}
							if(ansNum == 1 || ansNum == 0){
								; 一行のif文を実行。現時点では、False なら、何もしない。 else があっても、Trueの構文がブロック文でなければ無効
								ansComm := musc_exeBuffCommFromIfSentenceLogic(ansNum, nowCommand, pOut, GuiNum, 1)
								;edi_outPutSucceedFlagInCaseTrueCommandExeLogic(ansComm, "BoxEdit82_1", 82, gGlob_hwndBoxEdit82_1, True, outPutSucceedFlag)
								; 出力先の変更を引き継がないように使用変更したので、こちらを使う
								StringLower, lowerStr, ansComm
								if(lowerStr == "return"){
									return True
								}
								edi_outPutSucceedFlagStopCommandExe(ansComm, "", "BoxEdit82_1", 82, gGlob_hwndBoxEdit82_1, True)
							}
							if(ansNum == 2){
								; if文 ではなかった場合

								; 現時点では、Gui82 から実行してるのと同じ状態にしている
								;edi_outPutSucceedFlagInCaseTrueCommandExeLogic(beforeCommand, "BoxEdit82_1", 82, gGlob_hwndBoxEdit82_1, True, outPutSucceedFlag)
								; 出力先の変更を引き継がないように使用変更したので、こちらを使う
								StringLower, lowerStr, beforeCommand
								if(lowerStr == "return"){
									return True
								}
								edi_outPutSucceedFlagStopCommandExe(beforeCommand, "", "BoxEdit82_1", 82, gGlob_hwndBoxEdit82_1, True)
							} else {
								; nowCommand をカラにして、二重に実行されるのを防ぐ。ansNum が 2 以外ならカラに
								nowCommand =
							}
						}	; if(LChar == "{"){ の else
					}	; if( blockFlag ){ の else
				}	; if(beforeCommand != ""){
				beforeCommand := nowCommand


			}	; セミコロンの有無
		}	; カラかどうか
	}	; ループ

	; 最後の行がカラか、コメントだった場合、beforeCommand が実行されないままなので、そっちを実行させる
	if(nowCommand == ""){
		nowCommand := beforeCommand
	} else if(leftChar == smicron){
		nowCommand := beforeCommand
	}
	; 最後の1回はループを抜けるためここで実行
	;edi_outPutSucceedFlagInCaseTrueCommandExeLogic(nowCommand, "BoxEdit82_1", 82, gGlob_hwndBoxEdit82_1, True, outPutSucceedFlag)
	; 出力先の変更を引き継がないように使用変更したので、こちらを使う
	StringLower, lowerStr, nowCommand
	if(lowerStr == "return"){
		return True
	}
	edi_outPutSucceedFlagStopCommandExe(nowCommand, "", "BoxEdit82_1", 82, gGlob_hwndBoxEdit82_1, True)
	return False
}


musc_easyMultipleScriptsExe(scripts, pControl, GuiNum, hwnd, outPutSucceedFlag, count){
	smicron := "`;"		; コメントの文字

	loopCount = 0
	; 現時点では最大でも、３０行までしか処理しない
	Loop, Parse, scripts , `n, `r
	{
		if(loopCount >= 30){
			guit_errorAppend("現時点では３０行以上の処理はできない")
			break
		}
		loopCount++

		command := Trim(A_LoopField)
		if(command != ""){
			StringLeft, leftChar, command, 1
			if(leftChar != smicron){			; があったらコメント扱い
				; 現時点では、Gui82 から実行してるのと同じ状態にしている
				;edi_outPutSucceedFlagInCaseTrueCommandExeLogic(command, "BoxEdit82_1", 82, gGlob_hwndBoxEdit82_1, True, outPutSucceedFlag)
				; 出力先の変更を引き継がないように使用変更したので、こちらを使う
				edi_outPutSucceedFlagStopCommandExe(command, "", "BoxEdit82_1", 82, gGlob_hwndBoxEdit82_1, True)
			}
		}
	}
}

musc_multipleScriptsExeWrapper(scripts, pControl, GuiNum, hwnd){
	musc_multipleScriptsExe(scripts, pControl, GuiNum, hwnd, False, 1)
	edi_afterCommandExeLogic()
}

musc_multipleScriptsWriteiniFile(itemName, scripts, explanation, imagePath, iconNum, tmpItem){
	iniFile := gloco_userDir . glob_scriptsItemName
	scriptsTextDir := gloco_userDir . glob_scriptsTextDirName
	func_folderCheckMakeFolder(gloco_userDir . glob_scriptsDirName)
	func_folderCheckMakeFolder(scriptsTextDir)
	; 一時的に保存のか、普通のに保存かを分ける
	if(tmpItem == 1){
		iniFile := gloco_userDir . glob_tmpScriptsItemName
		scriptsTextDir := gloco_userDir . glob_tmpScriptsTextDirName
		func_folderCheckMakeFolder(gloco_userDir . glob_tmpScriptsDirName)
		func_folderCheckMakeFolder(scriptsTextDir)
	}

	StringReplace, explanation, explanation, `n, ###n, All
	textFile := scriptsTextDir . "\" . itemName . ".ahk"
	FileAppend , %scripts%, %textFile%
	res := guit_checkErrorLevelOutput("二行以上アイテムの文字列を書き込む時にエラー", "", 0)
	if(res == False){
		; エラーなら中断
		return  res
	}

	IniWrite, %explanation%, %iniFile%, %itemName%, explanation
	IniWrite, %imagePath%, %iniFile%, %itemName%, imagePath
	IniWrite, %iconNum%, %iniFile%, %itemName%, iconNum
	res := guit_checkErrorLevelOutput("二行以上アイテムの設定を書き込む時にエラー", "", 0)
	return  res
}

musc_multipleScriptstToObj(itemName, scripts, explanation, imagePath, iconNum, tmpItem) {
	optionObj := Object()
	optionObj.Insert(1, scripts)
	optionObj.Insert(2, "")
	optionObj.Insert(3, "")
	optionObj.Insert(4, explanation)
	optionObj.Insert(5, 4)			; 種類　必ず　4　にする
	optionObj.Insert(6, imagePath)
	optionObj.Insert(7, iconNum)
	optionObj.Insert(8, 0)			; dbQuout
	optionObj.Insert(9, tmpItem)
	optionObj.Insert(10, 1)		; ファイルに登録
	; カテゴリーフォルダ
	optionObj.Insert(11, "")
	optionObj.Insert(12, "")

	glob_multipleObj.Insert(itemName, optionObj)
}

musc_multipleScriptsEntry(itemName, scripts, explanation, imagePath, iconNum, tmpItem){
	musc_multipleScriptstToObj(itemName, scripts, explanation, imagePath, iconNum, tmpItem)

	; 一時的に保存のか、普通のに保存かを分ける
	listFile := gloco_userDir . glob_scriptsItemListName
	if(tmpItem == 1){
		listFile := gloco_userDir . glob_tmpScriptsItemListName
	}
	res := musc_multipleScriptsWriteiniFile(itemName, scripts, explanation, imagePath, iconNum, tmpItem)
	if(res == False){
		; エラーなら中断
		return  res
	}

	itemName := itemName . "`n"
	FileAppend, %itemName%, %listFile%
	res := guit_checkErrorLevelOutput("二行以上アイテムのリストファイルへの書き込み時にエラー", A_LineFile, A_LineNumber)
	return  res
}

musc_submitMultipleScriptsEntry(itemName, scripts, explanation, imagePath, iconNum, tmpItem){
	itemName := Trim(itemName)
	scripts := Trim(scripts)
	explanation := Trim(explanation)
	imagePath := Trim(imagePath)
	editFlag := guf_getControl( "HiddenCheckbox83_1_1", 83 )
	beforeItemName := guf_getControl( "HiddenEdit83_1_1", 83 )

	if(itemName == ""){
		GuiControl, 83:+cFF0000, Text83_1_1
		GuiControl, 83:, Text83_1_1,  アイテム名は必要(&E)
		return
	}
	if( ite_itemNameNGCharacterConfirm(itemName) == False ) {
		GuiControl, 83:+cFF0000, Text83_1_1
		GuiControl, 83:, Text83_1_1,  無効な文字が入っている(&E)
		return
	}
	if(scripts == ""){
		GuiControl, 83:+cFF0000, Text83_1_2
		GuiControl, 83:, Text83_1_2,  スクリプトが無記入(&L)
		return
	}
	; ループを避けるため、アイテム名とパスが同じものはエラーにする
	StringLower, itemNameLower, itemName
	StringLower, scriptLower, scripts
	if(itemNameLower == scriptLower) {
		guit_errorAppend("アイテム名とスクリプトが同じものは、禁止にしている")
		return
	}

	Gui, 83:Show, Hide

	res := False
	str =
	; 編集か新規か
	if( editFlag ){
		str := "編集"
		errFlag := False
		; 編集前と同じアイテム名なら問題なし
		if(itemName != beforeItemName){
			str := "新規登録し、`n" . beforeItemName . "  の二行以上アイテムを削除"
			; アイテム名がすでに存在してるならエラーに
			if( cen_keyWordIsObject(itemName) ) {
				errFlag := True
			}
		}
		if( errFlag ){
			guit_errorAppend(itemName . "  のアイテムはすでに登録されている。")
			return
		}
		res := musc_multipleScriptsEdit(itemName, scripts, explanation, imagePath, iconNum, tmpItem, beforeItemName)
	} else {
		str := "新規登録"
		if( cen_keyWordIsObject(itemName) ) {			;キーワードがかぶってるかどうか
			guit_errorAppend(itemName . "  のアイテムはすでに登録されている。")
			return
		}
		res := musc_multipleScriptsEntry(itemName, scripts, explanation, imagePath, iconNum, tmpItem)
	}
	if(res){
		;guit_setExplain(itemName . " の二行以上アイテムを" . str . "した", 63)
		cen_anyFileEntryDisplay("アイテムの" . str, itemName  . "`nの二行以上アイテムを" . str . "した")
		; アイテム一覧が出てたら更新する
		ite_updateGui73()
	}
}

musc_multipleScriptsDelete(itemName){
	if( cen_keyWordIsObject(itemName) ) {
		res := True
		optionObj := cen_getFromEnyObject(itemName)
		if(optionObj[10] == 1){
			beforeTmpItem := optionObj[9]

			listFile := gloco_userDir . glob_scriptsItemListName
			iniFile := gloco_userDir . glob_scriptsItemName
			scriptsTextDir := gloco_userDir . glob_scriptsTextDirName
			func_folderCheckMakeFolder(gloco_userDir . glob_scriptsDirName)
			; 一時的に保存のか、普通のに保存かを分ける
			if(beforeTmpItem == 1){
				listFile := gloco_userDir . glob_tmpScriptsItemListName
				iniFile := gloco_userDir . glob_tmpScriptsItemName
				scriptsTextDir := gloco_userDir . glob_tmpScriptsTextDirName
				func_folderCheckMakeFolder(gloco_userDir . glob_tmpScriptsDirName)
			}

			IniDelete, %iniFile%, %itemName%
			res := guit_checkErrorLevelOutput(itemName . "  の二行以上アイテムの設定ファイルの削除にエラー", A_LineFile, A_LineNumber)
			if(res == False){
				; エラーなら中断
				return  False
			}
			; ファイルから 元のアイテム名と一致している行以外 全て読み込む
			listStr := ite_wordTrimfileRead(itemName, listFile, A_LineFile, A_LineNumber)
			FileDelete, %listFile%
			FileAppend, %listStr%, %listFile%
			res := guit_checkErrorLevelOutput(itemName . "  の二行以上アイテムのリストファイルの削除にエラーあり", A_LineFile, A_LineNumber)
			if(res == False){
				; エラーなら中断
				return  False
			}
			textFile := scriptsTextDir . "\" . itemName . ".ahk"
			FileDelete, %textFile%
			res := guit_checkErrorLevelOutput(itemName . "  の二行以上アイテムのスクリプト記述ファイルの削除にエラー", A_LineFile, A_LineNumber)
			if(res){
				cen_anyFileEntryDisplay("アイテムの削除", itemName  . "`nの二行以上アイテムを削除した")
			}
		}

		;再起動するまでのリストの変更
		ite_itemRemoveFromEnyObj(itemName)

		return  res
	} else {
		guit_errorAppend(itemName . "  の二行以上アイテムが見つかりません")
	}
	return  False
}

musc_submitMultipleScriptsDelete(itemName){
	res := musc_multipleScriptsDelete(itemName)
	if(res){
		guit_setExplain(itemName . "  の二行以上アイテムを削除した", 63)
		; アイテム一覧が出てたら更新する
		ite_updateGui73()
	}
}

musc_multipleScriptsEdit(itemName, scripts, explanation, imagePath, iconNum, afterTmpItem, beforeItemName){
	optionObj := cen_getFromEnyObject(beforeItemName)
	if( optionObj[10] == 2 ){
		guit_setExplain("このアイテムはコマンドから登録したものなので変更できない", 63)
		return  False
	} else if( optionObj[10] == 3 ){
		guit_setExplain("このアイテムは fromFileName から登録したものなので変更できない", 63)
		return  False
	}

	beforeTmpItem := optionObj[9]

	listFile := gloco_userDir . glob_scriptsItemListName
	iniFile := gloco_userDir . glob_scriptsItemName
	scriptsTextDir := gloco_userDir . glob_scriptsTextDirName
	func_folderCheckMakeFolder(gloco_userDir . glob_scriptsDirName)
	func_folderCheckMakeFolder(scriptsTextDir)
	; 一時的に保存のか、普通のに保存かを分ける
	if(beforeTmpItem == 1){
		listFile := gloco_userDir . glob_tmpScriptsItemListName
		iniFile := gloco_userDir . glob_tmpScriptsItemName
		scriptsTextDir := gloco_userDir . glob_tmpScriptsTextDirName
		func_folderCheckMakeFolder(gloco_userDir . glob_tmpScriptsDirName)
		func_folderCheckMakeFolder(scriptsTextDir)
	}

	; 一時的に保存の項目を変更したら、少し変わった処理をする
	if(beforeTmpItem != afterTmpItem){
		if( musc_multipleScriptsDelete(beforeItemName) ){
			res := musc_multipleScriptsEntry(itemName, scripts, explanation, imagePath, iconNum, afterTmpItem)
			return  res
		}
		return  False
	}

	ite_itemRemoveFromEnyObj(beforeItemName)		;再起動するまでのリストの変更
												;どちらにしろ１度、元の登録は破棄する
	musc_multipleScriptstToObj(itemName, scripts, explanation, imagePath, iconNum, afterTmpItem)

	if(beforeItemName != itemName) {
		;アイテム名が違う場合の処理
		IniDelete, %iniFile%, %beforeItemName%
		res := guit_checkErrorLevelOutput(beforeItemName . "  の二行以上アイテムの設定の削除時にエラー", A_LineFile, A_LineNumber)
		if(res == False){
			; エラーなら中断
			return  res
		}
		; ファイルから 元のアイテム名と一致している行以外 全て読み込む
		listStr := ite_wordTrimfileRead(beforeItemName, listFile, A_LineFile, A_LineNumber)
		FileDelete, %listFile%
		itemName_n := itemName . "`n"
		listStr .= itemName_n
		FileAppend, %listStr%, %listFile%
		res := guit_checkErrorLevelOutput(beforeItemName . "  の二行以上アイテムのリストファイルの削除時にエラー", A_LineFile, A_LineNumber)
		if(res == False){
			; エラーなら中断
			return  res
		}
	}
	; スクリプト記述ファイルはどの場合でも削除する
	textFile := scriptsTextDir . "\" . beforeItemName . ".ahk"
	FileDelete, %textFile%
	res := guit_checkErrorLevelOutput(beforeItemName . "  の二行以上アイテムのスクリプト記述ファイルの削除にエラー", A_LineFile, A_LineNumber)
	if(res == False){
		; エラーなら中断
		return  res
	}
	res := musc_multipleScriptsWriteiniFile(itemName, scripts, explanation, imagePath, iconNum, afterTmpItem)
	return  res
}

musc_copyMultipleItem(itemName, pList, GuiNum){
	optionObj := glob_multipleObj[itemName]
	if(IsObject(optionObj)) {
		StringRight, rChar, itemName, 1		; 右端が数字かどうか調べる
		copyName =
		rNum = 0
		If rChar is digit
		{
			rChar++						; 数字だったら copy2 を copy3 にする
			StringTrimRight, itemName, itemName, 1
			copyName := itemName  . rChar
			rNum := rChar				; 下のループ処理で使うかもしれない変数
		} else {
			copyName := itemName  . "2"	; 数字でなかったら copy を copy2にする
			rNum = 2
		}
		Loop , 10
		{
			optObj2 := cen_getFromEnyObject(copyName)		; それがすでに登録されているか調べる
			if(IsObject(optObj2)) {
				rNum++
				copyName := itemName . rNum
			} else {
				if(rNum >= 10){
					guit_errorAppend("現時点では左の数字、９以上の数字は適用できない。")
					return
				}
				; ite_itemCopyEdit(argss, pList) との違いはここだけ
				musc_multipleScriptsEntry(copyName, optionObj[1], optionObj[4], optionObj[6], optionObj[7], optionObj[9])
				break
			}
		}
		res := guit_checkErrorLevelOutput("二行以上アイテムのコピーのエラー", "", 0)
		if(res){
			;guit_setExplain(copyName . "  の二行以上アイテムを登録", 63)
			cen_anyFileEntryDisplay("アイテムの新規登録", copyName  . "`nの二行以上アイテムを新規登録した")
			guf_setControl( copyName  . "||", pList, GuiNum )
		}

	} else {
		guit_setExplain(itemName . "  のアイテムが見つからない", 63)
	}
}

musc_historyNotAddSignInsert(){
	smicron_local := "`;"		; コメントの文字
	sign_local := smicron_local . " --norecord"
	scripts_local := guf_getControl( "BoxEdit83_1_1", 83 )
	oneLine_local := func_leftStrOrAllFromSearchStr(scripts_local, "`n")
	oneLine_local := RTrim( oneLine_local, "`r" )
	if( oneLine_local == sign_local ){
		return
	}
	add_local := sign_local . "`n" . scripts_local
	guf_setControl( add_local, "BoxEdit83_1_1", 83 )
}

musc_setMultipleItemPictuer(){
	Edit83_1_2 := guf_getControl( "Edit83_1_2", 83 )
	UpDown83_1_1 := guf_getControl( "UpDown83_1_1", 83 )
	Edit83_1_2 := outs_textOutTrimss(Edit83_1_2)
	Edit83_1_2 := aut_checkDangerStr(Edit83_1_2)
	ite_itemPictuerOfPath( Edit83_1_2, UpDown83_1_1, "*icon71 *w32 *h32 " . glob_SHELL32DLL, "Picture83_1_1", 83)
	ite_itemPictuerOfPath( Edit83_1_2, UpDown83_1_1, "*icon71 *w32 *h32 " . glob_SHELL32DLL, "Picture83_2_1", 83)
}

musc_showMultipleScriptsGui(scripts) {
	GuiControl, 83:Focus, Edit83_1_1
	GuiControl, 83:+c000000, Text83_1_1
	GuiControl, 83:, Text83_1_1, アイテム名(&E)
	GuiControl, 83:+c000000, Text83_1_2
	GuiControl, 83:, Text83_1_2, スクリプト(&L)
	guf_setControl( "", "Edit83_1_1", 83 )
	guf_setControl( scripts, "BoxEdit83_1_1", 83 )
	guf_setControl( 0, "Checkbox83_1_1", 83 )
	guf_setControl( "", "BoxEdit83_1_2", 83 )
	guf_setControl( "", "Edit83_1_2", 83 )
	guf_setControl( 1, "UpDown83_1_1", 83 )
	guf_setControl( 0, "HiddenCheckbox83_1_1", 83 )
	guf_setControl( "", "HiddenEdit83_1_1", 83 )
	GuiControl, 83:Choose, Tab83_1, 1

	Gui, 83:Show
}


musc_editMultipleScriptsGui(itemName){
	optionObj := cen_getFromEnyObject(itemName)
	if(IsObject(optionObj)) {
		guf_setControl( 1, "HiddenCheckbox83_1_1", 83 )
		guf_setControl( itemName, "HiddenEdit83_1_1", 83 )

		guf_setControl( itemName, "Edit83_1_1", 83 )
		guf_setControl( optionObj[1], "BoxEdit83_1_1", 83 )
		guf_setControl( optionObj[9], "Checkbox83_1_1", 83 )
		guf_setControl( optionObj[4], "BoxEdit83_1_2", 83 )
		guf_setControl( optionObj[6], "Edit83_1_2", 83 )
		guf_setControl( optionObj[7], "UpDown83_1_1", 83 )
		GuiControl, 83:Focus, Edit83_1_1
		GuiControl, 83:+c000000, Text83_1_1
		GuiControl, 83:, Text83_1_1, アイテム名(&E)
		fileFlag := optionObj[10]
		if( fileFlag == 1 ){
			GuiControl, 83:+c000000, Text83_1_2
			GuiControl, 83:, Text83_1_2, スクリプト(&L)
		} else if( fileFlag == 2 ){
			GuiControl, 83:+cFF0000, Text83_1_2
			GuiControl, 83:, Text83_1_2, コマンドから登録したので編集不可
		} else if( fileFlag == 3 ){
			GuiControl, 83:+cFF0000, Text83_1_2
			GuiControl, 83:, Text83_1_2, fromFileName から登録したので編集不可
		}
		GuiControl, 83:Choose, Tab83_1, 1

		Gui, 83:Show
	} else {
		guit_setExplain(itemName . "  のアイテムが見つからない", 63)
	}
}

musc_tmpMultipleItemDeleteObjectAndFile(){
	tmpIniFile := gloco_userDir . glob_tmpScriptsItemName
	tmpListFile := gloco_userDir . glob_tmpScriptsItemListName
	tmpScriptsTextDir := gloco_userDir . glob_tmpScriptsTextDirName
	if( func_isFolder(tmpScriptsTextDir) ){
		FileRemoveDir, %tmpScriptsTextDir% ,1
		res := guit_checkErrorLevelOutput("一時的に保存した二行以上アイテムのスクリプト記述ファイルの削除にエラーあり")
		if(res == False){
			; エラーなら中断
			return  False
		}
		Loop, Read, %tmpListFile%
		{
			itemName := Trim(A_LoopReadLine)
			if(itemName != ""){
				ite_itemRemoveFromEnyObj(itemName)
			}
		}
		FileDelete, %tmpIniFile%
		FileDelete, %tmpListFile%

		FileAppend, %null%, %tmpIniFile%
		FileAppend, %null%, %tmpListFile%
		res := guit_checkErrorLevelOutput("一時的に保存した二行以上アイテムの削除の時にエラーあり")
		return  res
	}
	return  False
}

musc_multiplelineExe(rightStr, pOut, GuiNum, outPutSucceedFlag){
	str := "二行以上のスクリプトを実行する。`n処理を``nで区切って、複数の処理を実行できる"
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}
	if(rightStr == ""){
		guit_setExplain(str, GuiNum)
		return
	}

	rightStr := outs_textOutTrimss(rightStr)
	; `n の文字列を改行に置換
	rightStr := func_linefeedReplace(rightStr)

	; outputの設定が変えられていたら、引き継がせるため、Trueを返す
	;outPutSucceedFlag := cen_outPutSucceedFlagTrueIfNotBasic()
	musc_multipleScriptsExe(rightStr, pOut, GuiNum, "", outPutSucceedFlag, 1)
}

musc_multiplelineExeFromFile(rightStr, pOut, GuiNum){
	str := "二行以上のスクリプトを実行する。`n引数にファイルパスを指定する。`nファイルの中に記入されている文字を、二行以上のスクリプトとして実行する。"
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}
	if(rightStr == ""){
		guit_setExplain(str, GuiNum)
		return
	}

	;rightStr := outs_textOutDqAllTrim(rightStr)
	str := outs_getStrFromReadFile(rightStr)

	str := Trim(str)
	if(str == ""){
		guit_errorAppend("&multiplelineExeFromFile のエラー`nファイルの中身に実行する内容が記入されていない`nファイルパス`n" . rightStr)
		return
	}

	; outputの設定が変えられていたら、引き継がせるため、Trueを返す
	;outPutSucceedFlag := cen_outPutSucceedFlagTrueIfNotBasic()
	musc_multipleScriptsExe(str, pOut, GuiNum, "", False, 1)
}

musc_newMultiple(rightStr, pControl, GuiNum){
	str := "二行以上のアイテムを登録するGuiの表示。引数はスクリプトの欄の文字列になる。`n改行の文字は改行に置換される"
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}
	if(rightStr != ""){
		; `n の文字列を改行に置換
		rightStr := func_linefeedReplace(rightStr)
	}
	musc_showMultipleScriptsGui(rightStr)
}

musc_exeBuffCommFromIfSentenceLogic(ansNum, buffComm, pOut, GuiNum, count){
	falseBuffComm =
	blockFlag := False
	; 改行はとっておく
	buffComm := RTrim(buffComm, "`n")

	if(count >= 21){
		guit_errorAppend("現時点では20以上続く else if文は処理できない。`n以下の構文は処理できない`n" . buffComm)
		return  buffComm
	}

	kakko := "{"
	StringLeft, LChar, buffComm, 1
	if(LChar == kakko){
		; ブロック文の場合
		IfNotInString, buffComm, }
		{
			guit_errorAppend("if文の { } が閉じられていないようなのでエラー`n" . buffComm)
			return ""
		}
		blockFlag := True
	}

	if( ansNum ){
		; if文 が True なら
		trueBuffComm := buffComm
		if( blockFlag ){
			trueBuffComm := ifco_blockTrimFirstLeft(buffComm, "{", "}", A_LineFile, A_LineNumber)
		}
		return  trueBuffComm
	}
	; if文 が False なら
	rightBuffComm =
	if( blockFlag ){
		rightBuffComm := ifco_rightStrFromBlockTrimFirstLeft(buffComm, "{", "}", A_LineFile, A_LineNumber)
	}

	if(rightBuffComm != ""){
		StringLeft, L4Str, rightBuffComm, 4
		StringLower, L4StrLower, L4Str
		if(L4StrLower == "else"){
			; else 文なら
			StringTrimLeft, L4TrimRightBuffComm, rightBuffComm, 4
			elseRightBuffComm := LTrim(L4TrimRightBuffComm)
			elseRightBuffComm := LTrim(elseRightBuffComm, "`n")
			if(elseRightBuffComm == ""){
				guit_appendExplain("else の後がカラなのでエラー")
				return ""
			}
			;falseBuffComm := elseRightBuffComm
			StringLeft, LChar, elseRightBuffComm, 1
			if(LChar == "{"){
				; ブロック文の場合
				falseBuffComm := ifco_blockTrimFirstLeft(elseRightBuffComm, "{", "}", A_LineFile, A_LineNumber)
			} else {
				; ブロック文ではないか（一行の文）、 else if文 の場合
				ansNum := ifco_flagFromIfConditionalByBuffComm(elseRightBuffComm, pOut, GuiNum)
				if(ansNum == 2){
					; else if文 ではない
					return  elseRightBuffComm
				}
				if(ansNum == 3){
					return  ""
				}
				if(ansNum == 4){
					guit_errorAppend("else if文で、構文的にエラー`n" . elseRightBuffComm)
					return  ""
				}
				if(ansNum == 1 || ansNum == 0){
					; else if文 のとき。
					rStr := func_rightStrOrNullFromSearchStrTurnAssign(elseRightBuffComm, "{", 1)
					rStr := "{" . rStr
					count++
					; 再帰的処理
					falseBuffComm := musc_exeBuffCommFromIfSentenceLogic(ansNum, rStr, pOut, GuiNum, count)
				} else {
					guit_errorAppend("if文の返り値で、エラー`n" . elseRightBuffComm . "返り値  " . ansNum)
				}
			}
		} else {
			; else でないなら、謎
			guit_errorAppend("} の右に無効な文字があるのでエラー`n" . rightBuffComm)
		}
	}
	return  falseBuffComm
}


musc_exeBuffCommFromIfSentence(ifSentence, buffComm, pOut, GuiNum){
	ansNum := ifco_flagFromIfConditional(ifSentence, pOut, GuiNum)
	if(ansNum == 2){
		guit_errorAppend("if文ではないのでエラー`n" . ifSentence)
		return  ""
	}
	if(ansNum == 3){
		return  ""
	}
	if(ansNum == 4){
		guit_errorAppend("このif文は構文的にエラー`n" . ifSentence)
		return  ""
	}

	if(ansNum == 1 || ansNum == 0){
		ansBuffComm := musc_exeBuffCommFromIfSentenceLogic(ansNum, buffComm, pOut, GuiNum, 1)
		return  ansBuffComm
	}
	guit_errorAppend("if文の返り値で、エラー`n" . buffComm . "返り値  " . ansNum)
	return  ""
}

; コマンドから登録する場合。二行以上のもここで登録する
; fromFileNameから登録する場合は、使っていない
musc_itemToObjFromCommand(arg1, arg2, arg3, arg4, arg6, dbQuout, iconFile, iconNumber, explanation, entryMethod){
	optionObj := Object()
	optionObj.Insert(1, arg2)
	optionObj.Insert(2, arg3)
	optionObj.Insert(3, arg4)
	optionObj.Insert(4, explanation)
	optionObj.Insert(5, arg6)	; 種類
	optionObj.Insert(6, iconFile)
	optionObj.Insert(7, iconNumber)
	optionObj.Insert(8, dbQuout)
	optionObj.Insert(9, 0)		; 一時的
	optionObj.Insert(10, entryMethod)		; 何から登録したか
	; カテゴリーフォルダ
	optionObj.Insert(11, "")
	optionObj.Insert(12, "")

	if(arg6 == 1) {
		glob_softObj.Insert(arg1, optionObj)
	} else if (arg6 ==  2) {
		glob_folderObj.Insert(arg1, optionObj)
	} else if (arg6 ==  3) {
		glob_itemCommandObj.Insert(arg1, optionObj)
	} else if (arg6 ==  4) {
		glob_multipleObj.Insert(arg1, optionObj)
	}
}

; アイテムをコマンドで登録する
; エラーがある場合は 0 。新規登録した場合は 1 を返す。
musc_newItemFromCommandLogic(radioNum, itemName, script, args, workDir, dbQuoutFlag, funcName){
	if( script == "" ) {
		guit_errorAppend(funcName . " のエラー。`nリンク先がカラなので登録できない`nアイテム名   " . itemName)
		return "0"
	}

	if( cen_keyWordIsObject(itemName) ) {			;アイテム名がかぶってるかどうか
		guit_errorAppend(funcName . " のエラー。`n同じアイテム名のものがすでに存在している`nアイテム名    " . itemName)
		return "0"
	}

	if(dbQuoutFlag == ""){
		dbQuoutFlag = 0
	}
	if( func_checkFlagStr(dbQuoutFlag) ){
		dbQuoutFlag := func_getFlagByOnOffStr(dbQuoutFlag)
	} else {
		guit_errorAppend(funcName . " のエラー。`ndoubleQuoutの値でTrueかFalse以外が指定されている`n値  " . dbQuoutFlag . "`nアイテム名   " . itemName)
		return "0"
	}

	If radioNum is not integer
	{
		guit_errorAppend(funcName . " のエラー。`nアイテムの種類の番号が整数でない`n番号   " . radioNum . "`nアイテム名   " . itemName)
		return "0"
	}
	If radioNum not between 0 and 5
	{
		guit_errorAppend(funcName . " のエラー。`nアイテムの種類の番号が１から４ではない`n番号   " . radioNum . "`nアイテム名   " . itemName)
		return "0"
	}

	if(radioNum == 4){
		; `n の文字列を改行に置換
		script := func_linefeedReplace(script)
	} else {
		; 前後の改行を取り除く
		script := Trim(script, "`r`n")
	}

	script := Trim( script, """" )
	workDir := Trim( workDir, """" )

	; タイプ 1 か 2 なら、右端の\は取る
	if(radioNum == 1){
		script := RTrim(script, "\\")
	} else if(radioNum == 2){
		script := RTrim(script, "\\")
	}

	; もう一度
	script := Trim(script)
	if( script == "" ) {
		guit_errorAppend(funcName . " のエラー。`nリンク先がカラなので登録できない`nアイテム名   " . itemName)
		return "0"
	}

	if( ite_itemNameExistNGCharacter(itemName) ) {
		guit_errorAppend(funcName . " のエラー。`nアイテム名として使えない文字がある`nアイテム名   " . itemName)
		return "0"
	}

	; ループを避けるため、アイテム名とパスが同じものはエラーにする
	StringLower, itemNameLower, itemName
	StringLower, scriptLower, script
	if(itemNameLower == scriptLower) {
		guit_errorAppend(funcName . " のエラー。`nアイテム名とリンク先が同じものは、禁止にしている`nアイテム名   " . itemName)
		return "0"
	}

	;if(imagePath == ""){
	;	iconNum = 1
	;}

	if(radioNum == 1){
		; 作業フォルダがカラなら、#itemName#\ にする
		if(workDir == ""){
			workDir := "#" . itemName . "#\"
		}
		workDir := RTrim(workDir, "\\")
		StringRight, rChar, workDir, 1	;	ここでいらん一工夫
		if(rChar == "#"){			;	 ##で囲まれているなら(item名なら)
			workDir .= "\"			;	その親フォルダをかえすようにする(\をやっぱり付け足す)
		}

		; %%と##を展開する(でも登録はしない)
		tempStr := outs_textOutDqAllTrim(script)
		type := FileExist(tempStr)
		IfInString, type, D
		{
			if(radioNum != 2){		;フォルダにチェックを入れていない
				radioNum = 2
				guit_appendExplain("アイテムをフォルダとして登録する`nアイテム名    " . itemName)
			}
		} else {
			; フォルダが存在していなくても登録できるようにする
			;if(radioNum == 2){
			;	; リンク先がフォルダではない時、フォルダにチェックを入れてればエラー
			;	GuiControl, 72:+cFF0000, Text72_3
			;	GuiControl, 72:, Text72_3, 種類を確認してください(&L)
			;	return "0"
			;}
		}
	}

	;typeStr := "ソフト・ファイル"
	if(radioNum == 1){

	} else if(radioNum == 2){			; フォルダかスクリプトなら、引数と作業フォルダをカラに
		args := ""
		workDir := ""
		;typeStr := "フォルダ"
	} else if(radioNum == 3){
		args := ""
		workDir := ""
		;typeStr := "スクリプト"
	} else if(radioNum == 4){
		args := ""
		workDir := ""
		;typeStr := "二行以上"
	}

	musc_itemToObjFromCommand(itemName, script, args, workDir, radioNum, dbQuoutFlag, "", 1, "", 2)
	return "1"
}

; アイテムをコマンドのみで登録する
musc_newItemFromCommand(radioNum, itemName, script, args, workDir, dbQuoutFlag, GuiNum){
	str =
(LTrim
アイテムをコマンドで登録する。
&newItem を使用して登録するのと違い、ファイルに保存しないので、再起動した後は無効になる。
引数１  種類
（１  ソフト・ファイル  ２  フォルダ  ３  スクリプト  4  二行以上のアイテム）
引数２  アイテム名
引数３  リンク先
引数４  引数
引数５  作業フォルダ
引数６  ダブルクオーテをつけるかどうか
（１ なら チェックと同じ）

カラなら、初期値が変わりに設定される
普通のアイテムの登録と違い、作業フォルダがカラなら、リンク先の親フォルダになる。

引数６は true false や on off の指定でも可

半角スペースがあるファイルパスなどはダブルクオーテで囲むと１つの引数扱いになるのでそれを利用するとよい。
)
	if( edc_helpViewIfHyphenH(str, itemName, GuiNum) ){
		return
	}
	if(itemName == ""){
		guit_setExplain(str, GuiNum)
		return
	}
	returnNum := musc_newItemFromCommandLogic(radioNum, itemName, script, args, workDir, dbQuoutFlag, "&newItemFromCommand")
	if( returnNum == 1 ){
		guit_setExplain(itemName . " のアイテムを新規登録した", GuiNum)
		; アイテム一覧が出てたら更新する
		ite_updateGui73()
	} else if( returnNum == 0 ){
		;guit_setExplain(itemName . " のアイテムの登録に失敗している。", GuiNum)
	}
}
