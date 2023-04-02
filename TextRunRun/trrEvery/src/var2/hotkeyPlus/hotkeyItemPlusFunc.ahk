






; 正しく登録できた場合は True を 失敗したら False を返す
hotitpf_entryAllGroundKeyLogic(com2, com3, explanation, tmpItem, fileFlag, categoryDir, GuiNum, winTitle){

	if(glotaip_allGroundKeyUsedCount >= 50){
		guit_errorAppend("常駐キーは、数の制限により、これ以上登録できない`n" . com2 . "`nのキーの登録は中止している")
		return False
	}

	; キーのショートネームをロングネームに変える
	; さらにこの関数は Win+Ctrl+Alt+Shift+ の順番に並び替える役割も担っている。
	longKeyNameOnly := hotk_shortKeyNameToLongName(com2)
	; 被らないように、ウインドウタイトルと合わせた名前をつくる
	longKeyNameWinTitle := longKeyNameOnly . "_" . winTitle
	if( winTitle == "" ){
		longKeyNameWinTitle := longKeyNameOnly
	}

	;キー名が被ってるかどうか
	if( IsObject( glotaip_allGroundLongKeyNameObj[longKeyNameWinTitle] ) ) {
		guit_errorAppend("常駐キー登録のエラー`n" . com2 . "  はすでに設定されている。`n補足  " . longKeyNameWinTitle)
		return False
	}

	;if( hotk_checkErrorKeyName(longKeyNameOnly) ){
	;	guit_errorAppend("常駐キー登録のエラー`nこのキーは登録できない`n" . com2)
	;	return False
	;}

	; キーのロングネームをショートネームに変える
	keyNameOnly := hotk_wordReplaceAndLower(longKeyNameOnly, "ctrl+", "^")
	keyNameOnly := hotk_wordReplaceAndLower(keyNameOnly, "alt+", "!")
	keyNameOnly := hotk_wordReplaceAndLower(keyNameOnly, "win+", "#")
	keyNameOnly := hotk_wordReplaceAndLower(keyNameOnly, "shift+", "+")


	returnValue := False

	; fromFileName から登録の場合、まとめて指定するのでいらない
	if( fileFlag != 3 ){
		if( winTitle != "" ){
			Hotkey, IfWinActive , %winTitle%
		}
	}
	StringLower, com3Tmp, com3
	if(com3Tmp == "on"){
		Hotkey, %keyNameOnly% , On, UseErrorLevel
		res := guit_checkErrorLevelOutput("常駐キーのエラー`nキーの操作に失敗している。", "引数１  " . com2, "引数２  " . com3)
		if( res ){
			guit_setExplain("常駐キーをOnにした。`n引数１  " . com2, GuiNum)
			returnValue := True
		}
	} else if(com3Tmp == "off"){
		Hotkey, %keyNameOnly% , Off, UseErrorLevel
		res := guit_checkErrorLevelOutput("常駐キーのエラー`nキーの操作に失敗している。", "引数１  " . com2, "引数２  " . com3)
		if( res ){
			guit_setExplain("常駐キーをOffにした。`n引数１  " . com2, GuiNum)
			returnValue := True
		}
	} else {
		res := True
		; すでに登録されているホットキーがあった場合、ErrorLevel は 0 を返すので そうなら、res を False にする
		Hotkey, %keyNameOnly% , , UseErrorLevel
		if(ErrorLevel == 0){
			guit_errorAppend("常駐キー登録のエラー`nすでに設定されている、または何らかの理由でこのキーは登録できない。`nショートキー名  " . keyNameOnly . "`nロングキー名  " . longKeyNameOnly)
			res := False
		}

		; res が False なら、新規登録をしない
		if( res ){
			count := glotaip_allGroundKeyUsedCount
			count++

			sublutinName := "magksub_SubAllGroundKey" . count
			Hotkey, %keyNameOnly% , %sublutinName%, UseErrorLevel
			errorStr := hotk_errorMsgForHotkey(ErrorLevel, com2, com3)
			res := guit_checkErrorLevelOutput(errorStr)
			if( res ){
				; %--  の文字があるなら、取り除く
				parsentMinus := "%--"
				com3 := RTrim( com3, "`r`n" )
				com3 := RTrim( com3 )
				StringRight, right3Str, com3, 3
				if(right3Str == parsentMinus){
					; %--  の文字を消す
					StringTrimRight, com3, com3, 3
					com3 := RTrim(com3)
				}

				; 成功したときのみグローバル変数の数を足す
				glotaip_allGroundKeyUsedCount += 1
				glotaip_allGroundKeyObj.Insert(count, com3)

				optionObj := Object()
				optionObj.Insert(1, count)
				optionObj.Insert(2, explanation)
				optionObj.Insert(3, tmpItem)
				optionObj.Insert(4, fileFlag)
				optionObj.Insert(5, winTitle)
				; テキスト上のキーと違い、キー名を中に登録し、キーとウインドウをオブジェのキーにする
				optionObj.Insert(6, longKeyNameOnly)
				optionObj.Insert(7, categoryDir)
				glotaip_allGroundLongKeyNameObj.Insert(longKeyNameWinTitle, optionObj)
				if(fileFlag == 2){
					guit_setExplain("常駐キーを登録した。`n引数１  " . com2 . "`n引数２  " . com3 . "`n" . count . " つ目の常駐キー", GuiNum)
				}
				returnValue := True
			}
		}
	}

	; fromFileName から登録の場合、まとめて指定するのでいらない
	if( fileFlag != 3 ){
		if( winTitle != "" ){
			Hotkey, IfWinActive
		}
	}

	return returnValue
}

hotitpf_hotkeyAllGroundNewFromCommand(com2, com3, com4, GuiNum){
	str := "&hotkeyAllGroundNewFromCommand  [キー名] [実行させる処理]  [ウインドウタイトル]`n引数1に AHK のキー名。`n引数2に サブルーチンではなく、処理させたいスクリプトを記述。`n引数3は  ウインドウタイトルの指定になる。`nなお、引数１は Ctrl+Alt+Shift+t という書式でも可能ではある。`n登録できる数は 50 に限定している。`n&hotkeyAllGroundNew  で登録する場合と違い、再起動した後は無効になる"
	if( edc_helpViewIfHyphenH(str, com2, GuiNum) ){
		return
	}
	if(com2 == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	;if(com3 == ""){
	;	guit_setExplainPurpose(str, GuiNum)
	;	return
	;}

	; `n の文字列を改行に置換
	com3 := func_linefeedReplace(com3)
	hotitpf_entryAllGroundKeyLogic(com2, com3, "", False, 2, "", GuiNum, com4)
}

hotitpf_entryAllGroundKeyGuiShow(rightStr){
	GuiControl, 90:Focus, Edit90_1

	GuiControl, 90:Focus, Edit90_1
	GuiControl, 90:+c000000, Text90_1
	GuiControl, 90:, Text90_1, キー名(&K)
	GuiControl, 90:+c000000, Text90_2
	GuiControl, 90:, Text90_2, 実行スクリプト(&L)
	GuiControl, 90:+c000000, Text90_3
	GuiControl, 90:, Text90_3, ウインドウタイトルを指定する(&W)

	guf_setControl( "", "Edit90_1", 90 )
	; 引数を入れる
	guf_setControl( rightStr, "BoxEdit90_2", 90 )
	guf_setControl( "", "Edit90_3", 90 )
	guf_setControl( "", "BoxEdit90_1", 90 )
	guf_setControl( 0, "Checkbox90_1", 90 )
	guf_setControl( "", "Hotkey90_1", 90 )

	guf_setControl( 0, "HiddenCheckbox90_1", 90 )
	guf_setControl( "", "HiddenEdit90_1", 90 )

	Gui, 90:Show
}

hotitpf_allGroundKeyWriteIniFile(longKeyNameOnly, exeScript, explanation, tmpItem, winTitle, keyWinTitleReplace){
	func_folderCheckMakeFolder(gloco_userDir . glotaip_allGroundKeyDirName)
	; 一時的に保存のか、普通のに保存かを分ける
	iniFile := gloco_userDir . glotaip_allGroundKeyIniFileName
	if(tmpItem == 1){
		func_folderCheckMakeFolder(gloco_userDir . glotaip_tmpAllGroundKeyDirName)
		iniFile := gloco_userDir . glotaip_tmpAllGroundKeyIniFileName
	}

	IfInString, exeScript, `n
	{
		StringReplace, exeScript, exeScript, `n, ###n, All
	}
	IfInString, explanation, `n
	{
		StringReplace, explanation, explanation, `n, ###n, All
	}

	; ini ファイルの設定上、"" が両端にあったら読み込み時に削除されるので""を２重につける
	dbQuout := """"
	StringLeft, lChr, exeScript, 1
	if(lChr == dbQuout){
		StringRight, rChr, exeScript, 1
		if(lChr == dbQuout){
			exeScript := dbQuout . exeScript  . dbQuout
		}
	}

	IniWrite, %exeScript%, %iniFile%, %keyWinTitleReplace%, scriptAllGround
	IniWrite, %explanation%, %iniFile%, %keyWinTitleReplace%, explanationAllGround
	IniWrite, %winTitle%, %iniFile%, %keyWinTitleReplace%, winTitleAllGround
	IniWrite, %longKeyNameOnly%, %iniFile%, %keyWinTitleReplace%, longKeyOnlyAllGround
}

hotitpf_allGroundKeyItemEntry(longKeyNameOnly, exeScript, explanation, tmpItem, winTitle, longKeyNameWinTitle){
	res := hotitpf_entryAllGroundKeyLogic(longKeyNameOnly, exeScript, explanation, tmpItem, 1, "", 63, winTitle)
	if(res == False){
		return  False
	}

	keyWinTitleReplace = %longKeyNameWinTitle%

	hotitpf_allGroundKeyWriteIniFile(longKeyNameOnly, exeScript, explanation, tmpItem, winTitle, keyWinTitleReplace)
	res := guit_checkErrorLevelOutput("常駐キーのiniファイルへの書き込み時にエラー", "", "")
	if(res == False){
		return  False
	}

	; 一時的に保存のか、普通のに保存かを分ける
	file := gloco_userDir . glotaip_allGroundKeyListName
	if(tmpItem == 1){
		file := gloco_userDir . glotaip_tmpAllGroundKeyListName
	}
	keyWinTitleReplace := keyWinTitleReplace . "`n"
	FileAppend, %keyWinTitleReplace%, %file%
	res := guit_checkErrorLevelOutput("常駐キーのリストのファイルへの書き込み時にエラー", "", "")
	if(res){
		return  True
	}
	return  False
}

hotitpf_editAllGroundKeyObjSet(keyCount, keyNameOnly, exeScript, explanation, tmpItem, fileFlag, winTitle, longKeyNameWinTitle){

	; キーのショートネームをロングネームに変える
	; さらにこの関数は Win+Ctrl+Alt+Shift+ の順番に並び替える役割も担っている。
	longKeyNameOnly := hotk_shortKeyNameToLongName(keyNameOnly)

	; キーのロングネームをショートネームに変える
	keyNameOnly := hotk_wordReplaceAndLower(longKeyNameOnly, "ctrl+", "^")
	keyNameOnly := hotk_wordReplaceAndLower(keyNameOnly, "alt+", "!")
	keyNameOnly := hotk_wordReplaceAndLower(keyNameOnly, "win+", "#")
	keyNameOnly := hotk_wordReplaceAndLower(keyNameOnly, "shift+", "+")

	; Remove(keyCount) をしないと、１つずつずれる現象が発生する
	glotaip_allGroundKeyObj.Remove(keyCount)
	glotaip_allGroundKeyObj.Insert(keyCount, exeScript)

	optionObj := Object()
	optionObj.Insert(1, keyCount)
	optionObj.Insert(2, explanation)
	optionObj.Insert(3, tmpItem)
	optionObj.Insert(4, fileFlag)
	optionObj.Insert(5, winTitle)
	optionObj.Insert(6, longKeyNameOnly)
	glotaip_allGroundLongKeyNameObj.Insert(longKeyNameWinTitle, optionObj)
}

hotitpf_hotkeyAllGroundEditLogic(longKeyNameOnly, exeScript, explanation, afterTmpItem, beforeKeyName, longKeyNameWinTitle){

	optionObj := glotaip_allGroundLongKeyNameObj[beforeKeyName]
	fileFlag := optionObj[4]
	if( fileFlag == 2 ){
		guit_setExplainOtherThanCommand("このキーはコマンドから登録したものなので変更できない")
		return  False
	} else if( fileFlag == 3 ){
		guit_setExplainOtherThanCommand("このキーは fromFileName から登録したものなので変更できない")
		return  False
	}

	if(beforeKeyName != longKeyNameWinTitle){
		guit_setExplainOtherThanCommand("キー名が元のキーと違う場合は編集ができない`n元のキー`n" . beforeKeyName . "`n新しいキー`n" . longKeyNameWinTitle)
		return  False
	}

	; 現時点では winTitle は編集できない
	winTitle := optionObj[5]

	hotitpf_editAllGroundKeyObjSet(optionObj[1], longKeyNameOnly, exeScript, explanation, afterTmpItem, fileFlag, winTitle, longKeyNameWinTitle)

	keyWinTitleReplace = %longKeyNameWinTitle%

	beforeTmpItem := optionObj[3]
	; 一時的に保存の項目を変更したら、少し変わった処理をする
	if(beforeTmpItem != afterTmpItem){
		beforeFile := gloco_userDir . glotaip_allGroundKeyListName
		beforeIniFile := gloco_userDir . glotaip_allGroundKeyIniFileName
		if(beforeTmpItem == 1){
			beforeFile := gloco_userDir . glotaip_tmpAllGroundKeyListName
			beforeIniFile := gloco_userDir . glotaip_tmpAllGroundKeyIniFileName
		}

		IniDelete, %beforeIniFile%, %keyWinTitleReplace%
		res := guit_checkErrorLevelOutput("常駐キーの ini ファイルの削除に失敗している")
		if( res ){

		}
		; ファイルから 元のアイテム名と一致している行以外 全て読み込む
		listStr := ite_wordTrimfileRead(keyWinTitleReplace, beforeFile, A_LineFile, A_LineNumber)
		FileDelete, %beforeFile%
		FileAppend, %listStr%, %beforeFile%

		afterFile := gloco_userDir . glotaip_allGroundKeyListName
		if(afterTmpItem == 1){
			afterFile := gloco_userDir . glotaip_tmpAllGroundKeyListName
		}

		tmpLongKeyName := keyWinTitleReplace . "`n"
		FileAppend, %tmpLongKeyName%, %afterFile%
		res := guit_checkErrorLevelOutput("常駐キーのリストのファイルへの書き込み時にエラー", "", "")
		if(res){
			
		}
	}

	hotitpf_allGroundKeyWriteIniFile(longKeyNameOnly, exeScript, explanation, afterTmpItem, winTitle, keyWinTitleReplace)
	res := guit_checkErrorLevelOutput("常駐キーのiniファイル書き込み時にエラー")
	if(res){
		return  True
	}
	return  False
}

hotitpf_pupupAllGroundLongKeyName(str, maxCount) {
	listStr =
	count = 1
	for key, value in glotaip_allGroundLongKeyNameObj {
		if(key != "") {
			if( RegExMatch(key, "i)^"str) )
			{
				listStr .= "|" . key
				if(count >= maxCount){
					listStr := RTrim(listStr, "|")
					return  listStr
				}
				count++
			}
		}
	}
	listStr := RTrim(listStr, "|")
	return  listStr
}

hotitpf_setAllGroundLongKeyNameList(str, maxCount, pControl, GuiNum) {
	listStr := hotitpf_pupupAllGroundLongKeyName(str, maxCount)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
}

hotitpf_updateOnlyAllGroundKeyListGui(){
	IfWinExist, %gGlob_Gui80Title%
	{
		hotitpf_setAllGroundLongKeyNameList("", 150, "List80_3_1", 80)
	}
}

hotitpf_entryAllGroundKeyGuiSubmit(){
	Edit90_1 := guf_getControl( "Edit90_1", 90 )
	BoxEdit90_2 := guf_getControl( "BoxEdit90_2", 90 )
	Edit90_3 := guf_getControl( "Edit90_3", 90 )
	BoxEdit90_1 := guf_getControl( "BoxEdit90_1", 90 )
	Checkbox90_1 := guf_getControl( "Checkbox90_1", 90 )
	HiddenCheckbox90_1 := guf_getControl( "HiddenCheckbox90_1", 90 )
	HiddenEdit90_1 := guf_getControl( "HiddenEdit90_1", 90 )

	Edit90_1 := Trim(Edit90_1)
	BoxEdit90_2 := Trim(BoxEdit90_2)
	Edit90_3 := Trim(Edit90_3)
	BoxEdit90_1 := Trim(BoxEdit90_1)
	HiddenEdit90_1 := Trim(HiddenEdit90_1)

	if(Edit90_1 == ""){
		return
	}
	;if(BoxEdit90_2 == ""){
	;	return
	;}

	longKeyNameOnly := hotk_shortKeyNameToLongName(Edit90_1)
	longKeyNameWinTitle := longKeyNameOnly . "_" . Edit90_3
	if( Edit90_3 == "" ){
		longKeyNameWinTitle := longKeyNameOnly
	}

	Gui, 90:Hide
	if( HiddenCheckbox90_1 == 0 ){
		;キー名が被ってるかどうか
		if( IsObject( glotaip_allGroundLongKeyNameObj[longKeyNameWinTitle] ) ) {
			guit_errorAppend(Edit90_1  . "  はすでに設定されている。`n補足  " . longKeyNameWinTitle)
			return
		}

		res := hotitpf_allGroundKeyItemEntry(longKeyNameOnly, BoxEdit90_2, BoxEdit90_1, Checkbox90_1, Edit90_3, longKeyNameWinTitle)
		if(res){
			cen_anyFileEntryDisplay("常時使用キーの追加", longKeyNameWinTitle)
			; キーの一覧が出てたら更新する
			hotitpf_updateOnlyAllGroundKeyListGui()
		}
	} else {
		res := hotitpf_hotkeyAllGroundEditLogic(longKeyNameOnly, BoxEdit90_2, BoxEdit90_1, Checkbox90_1, HiddenEdit90_1, longKeyNameWinTitle)
		if(res){
			cen_anyFileEntryDisplay("常時使用キーの編集", longKeyNameWinTitle)
			; キーの一覧が出てたら更新する
			hotitpf_updateOnlyAllGroundKeyListGui()
		}
	}
}

hotitpf_editAllGroundKeyGuiShow(argss){
	optionObj := glotaip_allGroundLongKeyNameObj[argss]
	if(IsObject(optionObj)) {
		GuiControl, 90:Focus, Edit90_2

		GuiControl, 90:+cFF0000, Text90_1
		GuiControl, 90:, Text90_1, キー名の編集はできない
		GuiControl, 90:+cFF0000, Text90_3
		GuiControl, 90:, Text90_3, ウインドウの編集はできない
		fileFlag := optionObj[4]
		if( fileFlag == 2 ){
			GuiControl, 90:+cFF0000, Text90_2
			GuiControl, 90:, Text90_2, コマンドから登録したので編集不可
		} else if( fileFlag == 3 ){
			GuiControl, 90:+cFF0000, Text90_2
			GuiControl, 90:, Text90_2, fromFileName から登録したので編集不可
		} else {
			GuiControl, 90:+c000000, Text90_2
			GuiControl, 90:, Text90_2, 実行スクリプト(&L)
		}

		guf_setControl( 1, "HiddenCheckbox90_1", 90 )	;編集用の目印
		guf_setControl( argss, "HiddenEdit90_1", 90 )	;アイテム名変更に備えて保存

		guf_setControl( optionObj[6], "Edit90_1", 90 )
		num := optionObj[1]
		exeScript := glotaip_allGroundKeyObj[num]

		guf_setControl( exeScript, "BoxEdit90_2", 90 )
		guf_setControl( optionObj[2], "BoxEdit90_1", 90 )
		guf_setControl( optionObj[3], "Checkbox90_1", 90 )
		guf_setControl( optionObj[5], "Edit90_3", 90 )
		guf_setControl( "", "Hotkey90_1", 90 )

		Gui, 90:Show
	} else {
		guit_errorAppend("登録キーが見つからない`n" . argss)
	}
}

hotitpf_hotkeyAllGroundEdit(argss) {
	if(argss == "") {
		intchf_showHotkeyListGui()
	} else {
		;longKeyName := hotk_shortKeyNameToLongName(argss)
		hotitpf_editAllGroundKeyGuiShow(argss)
	}
}

hotitpf_autoExplainFromAllGroundKeyList( pControl1, pControl2, pText1, pText2, GuiNum, pList, pControl3){
	str := guf_getControl( pList, GuiNum )
	optionObj := glotaip_allGroundLongKeyNameObj[str]
	tmpItemFlag := optionObj[3]
	if( tmpItemFlag ){
		GuiControl, %GuiNum%:+c36A2FF, %pText1%
		guf_setControl( "一時的な保存", pText1, GuiNum )
		guf_setControl( "", pText2, GuiNum )
	} else {
		fileFlag := optionObj[4]
		if( fileFlag == 2 ){
			GuiControl, %GuiNum%:+c46D82E, %pText1%
			guf_setControl( "コマンドから登録", pText1, GuiNum )
			guf_setControl( "", pText2, GuiNum )
		} else if( fileFlag == 3 ){
			GuiControl, %GuiNum%:+cFFB255, %pText1%
			guf_setControl( "fromFileName から登録", pText1, GuiNum )
			guf_setControl( optionObj[7], pText2, GuiNum )
		} else {
			guf_setControl( "", pText1, GuiNum )
			guf_setControl( "", pText2, GuiNum )
		}
	}
	num := optionObj[1]
	command := glotaip_allGroundKeyObj[num]
	guf_setControl( optionObj[2], pControl1, GuiNum )
	guf_setControl( command, pControl2, GuiNum )
	guf_setControl( optionObj[5], pControl3, GuiNum )
}

hotitpf_allGroundKeyOffFromLongName(longKeyName, winTitle){

	; キーのロングネームをショートネームに変える
	keyName := hotk_wordReplaceAndLower(longKeyName, "ctrl+", "^")
	keyName := hotk_wordReplaceAndLower(keyName, "alt+", "!")
	keyName := hotk_wordReplaceAndLower(keyName, "win+", "#")
	keyName := hotk_wordReplaceAndLower(keyName, "shift+", "+")

	returnValue := False

	if( winTitle != "" ){
		Hotkey, IfWinActive , %winTitle%
	}

	Hotkey, %keyName% , Off, UseErrorLevel
	res := guit_checkErrorLevelOutput("常駐キーの Off に失敗している。`n  " . longKeyName . "  のOff")
	if( res ){
		returnValue := True
	}

	if( winTitle != "" ){
		Hotkey, IfWinActive
	}

	return returnValue
}

hotitpf_hotkeyAllGroundDeleteLogic(argss){
	;longKeyName := hotk_shortKeyNameToLongName(argss)
	longKeyNameWinTitle := argss
	optionObj := glotaip_allGroundLongKeyNameObj[longKeyNameWinTitle]
	if( IsObject(optionObj) ) {
		winTitle := optionObj[5]
		if(optionObj[4] == 1){
			file := gloco_userDir . glotaip_allGroundKeyListName
			iniFile := gloco_userDir . glotaip_allGroundKeyIniFileName
			if(optionObj[3] == 1){
				file := gloco_userDir . glotaip_tmpAllGroundKeyListName
				iniFile := gloco_userDir . glotaip_tmpAllGroundKeyIniFileName
			}

			IniDelete, %iniFile%, %longKeyNameWinTitle%
			res := guit_checkErrorLevelOutput("常駐キーの ini ファイルの削除に失敗している")
			if( res ){
				cen_anyFileEntryDisplay("常駐キーの削除", longKeyNameWinTitle . " を削除した")
			} else {
				; エラーなら中断
				return  False
			}

			; ファイルから 元のアイテム名と一致している行以外 全て読み込む
			listStr := ite_wordTrimfileRead(longKeyNameWinTitle, file, A_LineFile, A_LineNumber)
			FileDelete, %file%
			FileAppend, %listStr%, %file%
		}
		;glotaip_allGroundKeyObj.Remove(optionObj[1])
		glotaip_allGroundLongKeyNameObj.Remove(longKeyNameWinTitle)

		res := hotitpf_allGroundKeyOffFromLongName(optionObj[6], winTitle)
		if(res){
			return  True
		}
	} else {
		guit_errorAppend("常駐キーの削除のエラー`n登録したキーが見つからない`n" . argss)
	}
	return  False
}

hotitpf_hotkeyAllGroundDelete(argss, pControl, GuiNum) {
	str := "登録した常駐キーを削除。`nキー名いれる。`nキー名は +^!a は不可能。 Ctrl+a の形式で。`nウインドウタイトルがあるなら、[キー名]_[ウインドウタイトル]で。`nなお、キーは完全に削除するわけではなく、Offにするだけで、`n完全に消すには再起動すること。`n-tmp で一時保存のアイテムを全て消す"
	if( edc_helpViewIfHyphenH(str, argss, GuiNum) ){
		return
	}
	if(argss == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}

	if(argss == "-tmp"  ){
		; 成功した場合、再起動する
		hotitpf_tmpAllGroundDeleteFile()
		return
	}
	res := hotitpf_hotkeyAllGroundDeleteLogic(argss)
	if( res ){
		guit_setExplain(argss . "  の常駐キーを削除した。`nなお、完全に削除するには再起動する必要がある", GuiNum)
	} else {
		guit_errorAppend("常駐キーの削除の時にエラーがある。`n" . argss)
	}
	; キーの一覧が出てたら更新する
	hotitpf_updateOnlyAllGroundKeyListGui()
}

hotitpf_hotkeyAllGroundDeleteFromGui(){
	str := guf_getControl( "List80_3_1", 80 )
	if( hotitpf_hotkeyAllGroundDeleteLogic(str) ){
		guit_setExplainOtherThanCommand(str . "  の常駐キーを削除した。`nなお、完全に削除するには再起動する必要がある")
	} else {
		guit_errorAppend("常駐キーの削除の時にエラーがある。`n" . str)
	}

	; キーの一覧が出てたら更新する
	hotitpf_updateOnlyAllGroundKeyListGui()
}

hotitpf_tmpAllGroundDeleteFile(){
	MsgBox, 4097, 再起動の確認, キーの消去には再起動が必要になる。`nよろしいか?, 60
	IfMsgBox, OK
	{
		iniFile := gloco_userDir . glotaip_tmpAllGroundKeyIniFileName
		file := gloco_userDir . glotaip_tmpAllGroundKeyListName
		FileDelete, %iniFile%
		FileDelete, %file%

		FileAppend, %null%, %iniFile%
		FileAppend, %null%, %file%
		if( guit_checkErrorLevelOutput("一時的に保存したキーの削除の時にエラーあり") ){
			Sleep, 800
			Reload
		}
	}
}
