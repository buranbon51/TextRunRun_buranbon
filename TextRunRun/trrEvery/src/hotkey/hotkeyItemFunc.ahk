



hoit_HotkeyEdit(argss) {
	if(argss == "") {
		intchf_showHotkeyListGui()
	} else {
		longKeyName := hotk_shortKeyNameToLongName(argss)
		hoit_hotkeyEditGui(longKeyName)
	}
}

hoit_setCommShortLongKeyNameList(str, maxCount, pControl, GuiNum) {
	listStr =
	listStr .= auts_pupupCommShortLongKeyName(str, maxCount)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
}

hoit_setSystemHotkeyList(str, maxCount, pControl, GuiNum) {
	listStr =
	listStr .= hoit_pupupSystemHotkey(str, maxCount)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
}

hoit_updateHotkeyListGui(){
	IfWinExist, %gGlob_Gui80Title%
	{
		hoit_setCommShortLongKeyNameList("", 150, "List80_1", 80)
		hoit_setSystemHotkeyList("", 150, "List80_2", 80)
	}
}

hoit_hotkeyControlInput(){
	str := guf_getControl( "Hotkey79_1", 79 )
	guf_setControl( str, "Edit79_1", 79 )
}

hoit_everHotkeyShow(com2){
	GuiControl, 79:Focus, Edit79_1

	GuiControl, 79:Focus, Edit79_1
	GuiControl, 79:+c000000, Text79_1
	GuiControl, 79:, Text79_1, キー名(&K)
	GuiControl, 79:+c000000, Text79_2
	GuiControl, 79:, Text79_2, 実行スクリプト(&L)

	guf_setControl( "", "Edit79_1", 79 )
	; 引数を入れる
	guf_setControl( com2, "Edit79_2", 79 )
	guf_setControl( "", "BoxEdit79_1", 79 )
	guf_setControl( 0, "Checkbox79_1", 79 )
	guf_setControl( "", "Hotkey79_1", 79 )

	guf_setControl( 0, "HiddenCheckbox79_1", 79 )
	guf_setControl( "", "HiddenEdit79_1", 79 )

	Gui, 79:Show
}

hoit_hotkeyEditGui(argss){
	optionObj := glob_commShortLongKeyNameObj[argss]
	if(IsObject(optionObj)) {
		GuiControl, 79:Focus, Edit79_2

		GuiControl, 79:+cFF0000, Text79_1
		GuiControl, 79:, Text79_1, キー名の編集はできない
		fileFlag := optionObj[4]
		if( fileFlag == 2 ){
			GuiControl, 79:+cFF0000, Text79_2
			GuiControl, 79:, Text79_2, コマンドから登録したので編集不可
		} else if( fileFlag == 3 ){
			GuiControl, 79:+cFF0000, Text79_2
			GuiControl, 79:, Text79_2, fromFileName から登録したので編集不可
		} else {
			GuiControl, 79:+c000000, Text79_2
			GuiControl, 79:, Text79_2, 実行スクリプト(&L)
		}

		guf_setControl( 1, "HiddenCheckbox79_1", 79 )	;編集用の目印
		guf_setControl( argss, "HiddenEdit79_1", 79 )	;アイテム名変更に備えて保存

		guf_setControl( argss, "Edit79_1", 79 )
		num := optionObj[1]
		exeScript := glob_commShortCutKeyObj[num]

		guf_setControl( exeScript, "Edit79_2", 79 )
		guf_setControl( optionObj[2], "BoxEdit79_1", 79 )
		guf_setControl( optionObj[3], "Checkbox79_1", 79 )
		guf_setControl( "", "Hotkey79_1", 79 )

		Gui, 79:Show
	} else {
		guit_errorAppend("登録キーが見つからない")
	}
}

hoit_hotkeyItemWriteiniFile(longKeyName, exeScript, explanation, tmpItem){
	func_folderCheckMakeFolder(gloco_userDir . glob_userHotKeyItemDirName)
	; 一時的に保存のか、普通のに保存かを分ける
	iniFile := gloco_userDir . glob_hotkeyItemIniFileName
	if(tmpItem == 1){
		func_folderCheckMakeFolder(gloco_userDir . glob_userTmpHotkeyItemDirName)
		iniFile := gloco_userDir . glob_tmpHotkeyItemIniFileName
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

	IniWrite, %exeScript%, %iniFile%, %longKeyName%, exeScriptKey
	IniWrite, %explanation%, %iniFile%, %longKeyName%, explanationKey
}

hoit_hotkeyItemEntry(longKeyName, exeScript, explanation, tmpItem){
	res := hotk_entryKeyOnTextCommandLogic(longKeyName, exeScript, explanation, tmpItem, 1, "", 63)
	if(res == False){
		return  False
	}

	hoit_hotkeyItemWriteiniFile(longKeyName, exeScript, explanation, tmpItem)
	res := guit_checkErrorLevelOutput("ホットキーのiniファイルへの書き込み時にエラー", A_LineFile, A_LineNumber)
	if(res == False){
		return  False
	}

	; 一時的に保存のか、普通のに保存かを分ける
	file := gloco_userDir . glob_hotkeyItemListName
	if(tmpItem == 1){
		file := gloco_userDir . glob_tmpHotkeyItemListName
	}
	longKeyName := longKeyName . "`n"
	FileAppend, %longKeyName%, %file%
	res := guit_checkErrorLevelOutput("ホットキーのリストのファイルへの書き込み時にエラー", A_LineFile, A_LineNumber)
	if(res){
		return  True
	}
	return  False
}

hoit_everHotkeySubmit(){
	Edit79_1 := guf_getControl( "Edit79_1", 79 )
	Edit79_2 := guf_getControl( "Edit79_2", 79 )
	BoxEdit79_1 := guf_getControl( "BoxEdit79_1", 79 )
	Checkbox79_1 := guf_getControl( "Checkbox79_1", 79 )
	HiddenCheckbox79_1 := guf_getControl( "HiddenCheckbox79_1", 79 )
	HiddenEdit79_1 := guf_getControl( "HiddenEdit79_1", 79 )

	Edit79_1 := Trim(Edit79_1)
	Edit79_2 := Trim(Edit79_2)
	BoxEdit79_1 := Trim(BoxEdit79_1)
	HiddenEdit79_1 := Trim(HiddenEdit79_1)

	if(Edit79_1 == ""){
		return
	}
	;if(Edit79_2 == ""){
	;	return
	;}

	longKeyName := hotk_shortKeyNameToLongName(Edit79_1)

	Gui, 79:Hide
	if( HiddenCheckbox79_1 == 0 ){
		;キー名が被ってるかどうか
		if( IsObject( glob_commShortLongKeyNameObj[longKeyName] ) ) {
			guit_errorAppend(Edit79_1  . "  はすでに設定されている。")
			return
		}

		res := hoit_hotkeyItemEntry(longKeyName, Edit79_2, BoxEdit79_1, Checkbox79_1)
		if(res){
			cen_anyFileEntryDisplay(longKeyName . " キーの追加", Edit79_2)
			; キーの一覧が出てたら更新する
			hoit_updateHotkeyListGui()
		}
	} else {
		res := hoit_hotkeyEditLogic(longKeyName, Edit79_2, BoxEdit79_1, Checkbox79_1, HiddenEdit79_1)
		if(res){
			cen_anyFileEntryDisplay(longKeyName . " キーの編集", Edit79_2)
			; キーの一覧が出てたら更新する
			hoit_updateHotkeyListGui()
		}
	}
}

hoit_tmpHotkeyDeleteFile(){
	MsgBox, 4097, 再起動の確認, キーの消去には再起動が必要になる。`nよろしいか?, 60
	IfMsgBox, OK
	{
		iniFile := gloco_userDir . glob_tmpHotkeyItemIniFileName
		file := gloco_userDir . glob_tmpHotkeyItemListName
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

hoit_hotkeyDeleteLogic(argss){
	longKeyName := hotk_shortKeyNameToLongName(argss)

	optionObj := glob_commShortLongKeyNameObj[longKeyName]
	if( IsObject(optionObj) ) {
		if(optionObj[4] == 1){
			file := gloco_userDir . glob_hotkeyItemListName
			iniFile := gloco_userDir . glob_hotkeyItemIniFileName
			if(optionObj[3] == 1){
				file := gloco_userDir . glob_tmpHotkeyItemListName
				iniFile := gloco_userDir . glob_tmpHotkeyItemIniFileName
			}

			IniDelete, %iniFile%, %longKeyName%
			res := guit_checkErrorLevelOutput("ホットキーの ini ファイルの削除に失敗している")
			if( res ){
				cen_anyFileEntryDisplay("ショートカットキーの削除", longKeyName . " を削除した")
			} else {
				; エラーなら中断
				return  False
			}

			; ファイルから 元のアイテム名と一致している行以外 全て読み込む
			listStr := ite_wordTrimfileRead(longKeyName, file, A_LineFile, A_LineNumber)
			FileDelete, %file%
			FileAppend, %listStr%, %file%
		}
		;glob_commShortCutKeyObj.Remove(optionObj[1])
		glob_commShortLongKeyNameObj.Remove(longKeyName)

		res := hotk_hotkeyOffFromLongKeyName(longKeyName)
		if(res){
			return  True
		}
	} else {
		guit_errorAppend("登録したキーが見つからない")
	}
	return  False
}

hoit_HotkeyDelete(argss, pControl, GuiNum) {
	str := "登録したショートカットキーを削除。`nキー名いれる。`nキー名は +^!a でも Ctrl+a の形式でもいい。`nなお、キーは完全に削除するわけではなく、Offにするだけ`n-tmp で一時保存のアイテムを全て消す"
	if( edc_helpViewIfHyphenH(str, argss, GuiNum) ){
		return
	}
	if(argss == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}

	if(argss == "-tmp"  ){
		; 成功した場合、再起動する
		hoit_tmpHotkeyDeleteFile()
		return
	}
	res := hoit_hotkeyDeleteLogic(argss)
	if( res ){
		guit_setExplain(argss . "  のショートカットキーを削除した。`nなお、完全に削除するには再起動する必要がある", GuiNum)
		;guf_setControl( "", pControl, GuiNum )
	} else {
		guit_errorAppend("ショートカットキーの削除の時にエラーがある。`n" . argss)
	}
	; キーの一覧が出てたら更新する
	hoit_updateHotkeyListGui()
}

hoit_hotkeyDeleteFromGui(){
	List80_1 := guf_getControl( "List80_1", 80 )
	if( hoit_hotkeyDeleteLogic(List80_1) ){
		guit_setExplain(List80_1 . "  のショートカットキーを削除した。`nなお、完全に削除するには再起動する必要がある", 63)
	} else {
		guit_errorAppend("ショートカットキーの削除の時にエラーがある。`n" . List80_1)
	}

	; キーの一覧が出てたら更新する
	hoit_updateHotkeyListGui()
}

hoit_hotkeyEditFromGui(){
	List80_1 := guf_getControl( "List80_1", 80 )
	hoit_hotkeyEditGui(List80_1)
}

hoit_autoExplainFromLongKeyName( pControl1, pControl2, pText1, pText2, GuiNum ){
	List80_1 := guf_getControl( "List80_1", 80 )
	optionObj := glob_commShortLongKeyNameObj[List80_1]
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
			guf_setControl( optionObj[5], pText2, GuiNum )
		} else {
			guf_setControl( "", pText1, GuiNum )
			guf_setControl( "", pText2, GuiNum )
		}
	}
	num := optionObj[1]
	command := glob_commShortCutKeyObj[num]
	guf_setControl( optionObj[2], pControl1, GuiNum )
	guf_setControl( command, pControl2, GuiNum )
}

hoit_autoSetSystemHotkey( pControl, GuiNum ){
	List80_2 := guf_getControl( "List80_2", 80 )
	explanation := glob_systemHotkeyObj[List80_2]
	guf_setControl( explanation, pControl, GuiNum )
}

hoit_pupupSystemHotkey(str, maxCount) {
	listStr =
	count = 1
	for key, value in glob_systemHotkeyObj {
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

hoit_editHotkeyObjSetting(keyCount, keyName, exeScript, explanation, tmpItem, fileFlag){

	; キーのショートネームをロングネームに変える
	; さらにこの関数は Win+Ctrl+Alt+Shift+ の順番に並び替える役割も担っている。
	longKeyName := hotk_shortKeyNameToLongName(keyName)

	; キーのロングネームをショートネームに変える
	keyName := hotk_wordReplaceAndLower(longKeyName, "ctrl+", "^")
	keyName := hotk_wordReplaceAndLower(keyName, "alt+", "!")
	keyName := hotk_wordReplaceAndLower(keyName, "win+", "#")
	keyName := hotk_wordReplaceAndLower(keyName, "shift+", "+")

	; Remove(keyCount) をしないと、１つずつずれる現象が発生する
	glob_commShortCutKeyObj.Remove(keyCount)
	glob_commShortCutKeyObj.Insert(keyCount, exeScript)

	optionObj := Object()
	optionObj.Insert(1, keyCount)
	optionObj.Insert(2, explanation)
	optionObj.Insert(3, tmpItem)
	optionObj.Insert(4, fileFlag)
	glob_commShortLongKeyNameObj.Insert(longKeyName, optionObj)
}



hoit_hotkeyEditLogic(longKeyName, exeScript, explanation, afterTmpItem, beforeKeyName){

	optionObj := glob_commShortLongKeyNameObj[beforeKeyName]
	fileFlag := optionObj[4]
	if( fileFlag == 2 ){
		guit_setExplain("このキーはコマンドから登録したものなので変更できない", 63)
		return  False
	} else if( fileFlag == 3 ){
		guit_setExplain("このキーは fromFileName から登録したものなので変更できない", 63)
		return  False
	}

	if(beforeKeyName != longKeyName){
		guit_setExplain("キー名が元のキーと違う場合は編集ができない", 63)
		return  False
	}

	hoit_editHotkeyObjSetting(optionObj[1], beforeKeyName, exeScript, explanation, afterTmpItem, optionObj[4])

	beforeTmpItem := optionObj[3]
	; 一時的に保存の項目を変更したら、少し変わった処理をする
	if(beforeTmpItem != afterTmpItem){
		beforeFile := gloco_userDir . glob_hotkeyItemListName
		beforeIniFile := gloco_userDir . glob_hotkeyItemIniFileName
		if(beforeTmpItem == 1){
			beforeFile := gloco_userDir . glob_tmpHotkeyItemListName
			beforeIniFile := gloco_userDir . glob_tmpHotkeyItemIniFileName
		}

		IniDelete, %beforeIniFile%, %longKeyName%
		res := guit_checkErrorLevelOutput("ホットキーの ini ファイルの削除に失敗している")
		if( res ){

		}
		; ファイルから 元のアイテム名と一致している行以外 全て読み込む
		listStr := ite_wordTrimfileRead(longKeyName, beforeFile, A_LineFile, A_LineNumber)
		FileDelete, %beforeFile%
		FileAppend, %listStr%, %beforeFile%

		afterFile := gloco_userDir . glob_hotkeyItemListName
		if(afterTmpItem == 1){
			afterFile := gloco_userDir . glob_tmpHotkeyItemListName
		}

		tmpLongKeyName := longKeyName . "`n"
		FileAppend, %tmpLongKeyName%, %afterFile%
		res := guit_checkErrorLevelOutput("ホットキーのリストのファイルへの書き込み時にエラー", A_LineFile, A_LineNumber)
		if(res){
			
		}
	}

	hoit_hotkeyItemWriteiniFile(longKeyName, exeScript, explanation, afterTmpItem)
	res := guit_checkErrorLevelOutput("キーのiniファイル書き込み時にエラー")
	if(res){
		return  True
	}
	return  False
}
