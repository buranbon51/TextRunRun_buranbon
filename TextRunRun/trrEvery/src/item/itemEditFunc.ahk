;  syf

ite_relativButton(LineFile, LineNumber){
	Edit72_3 := guf_getControl( "Edit72_3", 72 )
	if(Edit72_3 == ""){
		return
	}
	Edit72_3 := outs_textOutTrimss(Edit72_3)
	; C:\ などが違った場合は何もしない。
	SplitPath, A_ScriptDir , , , , , curDrive
	SplitPath, Edit72_3 , , , , , targetDrive
	if(curDrive == targetDrive){
		relativ := outs_absolePathToRelativPath(A_ScriptDir , Edit72_3, LineFile, LineNumber)
		str := "%A_ScriptDir%\"  . relativ
	} else {
		str := Edit72_3
	}
	guf_setControl( str, "Edit72_3", 72 )
}

ite_absoleButton(LineFile, LineNumber){
	Edit72_3 := guf_getControl( "Edit72_3", 72 )
	if(Edit72_3 == ""){
		return
	}
	Edit72_3 := outs_textOutTrimss(Edit72_3)
	str := outs_relativePathToAbsolutePath(Edit72_3, A_ScriptDir, LineFile, LineNumber, False)
	guf_setControl( str, "Edit72_3", 72 )
}

ite_itemCopyEdit(argss, pList) {
	optionObj := cen_getFromEnyObject(argss)
	if(IsObject(optionObj)) {
		StringRight, rChar, argss, 1		; 右端が数字かどうか調べる
		copyName =
		rNum = 0
		If rChar is digit
		{
			rChar++						; 数字だったら copy2 を copy3 にする
			StringTrimRight, argss, argss, 1
			copyName := argss  . rChar
			rNum := rChar				; 下のループ処理で使うかもしれない変数
		} else {
			copyName := argss  . "2"	; 数字でなかったら copy を copy2にする
			rNum = 2
		}
		Loop , 10
		{
			optObj2 := cen_getFromEnyObject(copyName)		; それがすでに登録されているか調べる
			if(IsObject(optObj2)) {
				rNum++
				copyName := argss . rNum
			} else {
				if(rNum >= 10){
					guit_errorAppend("現時点では左の数字、９以上の数字は適用できない。")
					return
				}
				; 登録されてなかったら実行
				ite_newItemEntry(copyName, optionObj[1], optionObj[2], optionObj[3], optionObj[4], optionObj[5], optionObj[6], optionObj[7], optionObj[8], optionObj[9])
				break
			}
		}
		res := guit_checkErrorLevelOutput("アイテムのコピーのエラー", A_LineFile, A_LineNumber, ErrorLevel)
		if(res){
			;guit_setExplain(copyName . " のアイテムを新規登録した", 63)
			cen_anyFileEntryDisplay("アイテムの新規登録", copyName . " のアイテムを新規登録した")
			guf_setControl( copyName  . "||", pList, 73 )
		}

	} else {
		guit_errorAppend("登録アイテムが見つかりません")
	}
	
}

ite_itemPathConfilrm(str) {
	str := Trim(str)
	if(str == "") {
		GuiControl, 72:+cFF0000, Text72_3
		GuiControl, 72:, Text72_3, リンク先は必要です(&L)
	} else {
		GuiControl, 72:+c000000, Text72_3
		GuiControl, 72:, Text72_3, リンク先(&L)
	}
}

ite_itemKeywordConfilrm(str, editFlag) {
	if( ite_itemNameExistNGCharacter(str) ){
		return
	}
	if(editFlag == 0){			;新規か編集か
		if( cen_keyWordIsObject(str) ) {
			GuiControl, 72:+cFF0000, Text72_1
			GuiControl, 72:, Text72_1,  そのアイテム名は使われている(&E)
		} else {
			GuiControl, 72:+c000000, Text72_1
			GuiControl, 72:, Text72_1,  アイテム名(&E)
		}
	}
}

; アイテムに使う名前に無効な文字が入っていたら True を返し、警告する
ite_itemNameExistNGCharacter(name){
/*
	res := RegExMatch(name, "^[0-9a-zA-Z_@-]+$")
	if(res != 1) {
		GuiControl, 72:+cFF0000, Text72_1
		GuiControl, 72:, Text72_1, 無効な文字が入っている(&E)
		return True
	}
*/
	if(name == ""){
		return False
	}

	if( ite_itemNameNGCharacterConfirm(name) == False ){
		GuiControl, 72:+cFF0000, Text72_1
		GuiControl, 72:, Text72_1,  無効な文字が入っている(&E)
		return True
	}
	GuiControl, 72:+c000000, Text72_1
	GuiControl, 72:, Text72_1,  アイテム名(&E)
	return False
}

ite_itemRemoveFromEnyObj(beforeKeyName){
	num := cen_keyWordIsObjectNumber(beforeKeyName)
	if(num == 1){
		glob_softObj.Remove(beforeKeyName)
	} else if(num == 2){
		glob_folderObj.Remove(beforeKeyName)
	} else if(num == 3){
		glob_itemCommandObj.Remove(beforeKeyName)
	} else if(num == 4){
		glob_multipleObj.Remove(beforeKeyName)
	} else {
		; guit_errorAppend("削除するアイテムのオブジェが見つからない")
	}
}

ite_editItemEntry(arg1, arg2, arg3, arg4, arg5, arg6=1, image="", beforeKeyName="", iconNum=1, dbQuout=0, afterTmpItem=0){
	func_folderCheckMakeFolder(gloco_userDir)
	optionObj := cen_getFromEnyObject(beforeKeyName)
	if( optionObj[10] == 2 ){
		guit_setExplain("このアイテムはコマンドから登録したものなので変更できない", 63)
		return  False
	} else if( optionObj[10] == 3 ){
		guit_setExplain("このアイテムは fromFileName から登録したものなので変更できない", 63)
		return  False
	}

	beforeTmpItem := optionObj[9]
	commandFile := gloco_userDir . glob_commandFileName
	commandListFile := gloco_userDir . glob_commandListFileName
	if(beforeTmpItem == 1){
		commandFile := gloco_userDir . glob_tmpCommandFileName
		commandListFile := gloco_userDir . glob_tmpCommandListFileName
	}

	; 一時的に保存の項目を変更したら、少し変わった処理をする
	if(beforeTmpItem != afterTmpItem){
		if( ite_deleteItemLogic(beforeKeyName) ){
			res := ite_newItemEntry(arg1, arg2, arg3, arg4, arg5, arg6, image, iconNum, dbQuout, afterTmpItem)
			if(res){
				return  True
			}
		}
		return  False
	}

	ite_itemRemoveFromEnyObj(beforeKeyName)		;再起動するまでのリストの変更
												;どちらにしろ１度、元の登録は破棄する
	init_itemInsertToObj(arg1, arg2, arg3, arg4, arg5,arg6, image, iconNum, dbQuout, beforeTmpItem)
	guit_checkErrorLevelOutput("アイテムの登録の変数登録時にエラー", A_LineFile, A_LineNumber)

	if(beforeKeyName != arg1) {
		;アイテム名が違う場合の処理
		IniDelete, %commandFile%, %beforeKeyName%

		; ファイルから 元のアイテム名と一致している行以外 全て読み込む
		listStr := ite_wordTrimfileRead(beforeKeyName, commandListFile, A_LineFile, A_LineNumber)
		FileDelete, %commandListFile%
		; 新しいアイテム名を加えて ファイルに上書き
		arg1_n := arg1 . "`n"
		listStr .= arg1_n
		
		FileAppend, %listStr%, %commandListFile%

	}
	guit_checkErrorLevelOutput("前のアイテムのデータの削除時にエラー", A_LineFile, A_LineNumber)

	ite_itemWriteiniFile(arg1, arg2, arg3, arg4, arg5,arg6, image, iconNum, dbQuout, beforeTmpItem)
	res := guit_checkErrorLevelOutput("アイテムのiniファイル書き込み時にエラー", A_LineFile, A_LineNumber)
	if(res){
		return  True
	}
	return  False
}


ite_itemWriteiniFile(arg1, arg2, arg3, arg4, arg5,arg6, image="", iconNum=1, dbQuout=0, tmpItem=0) {

	func_folderCheckMakeFolder(gloco_userDir . glob_userItemDirName)
	; 一時的に保存のか、普通のに保存かを分ける
	commandFile := gloco_userDir . glob_commandFileName
	if(tmpItem == 1){
		func_folderCheckMakeFolder(gloco_userDir . glob_userTmpTmpItemDirName)
		commandFile := gloco_userDir . glob_tmpCommandFileName
	}

	IfInString, arg5, `n
	{
		StringReplace, arg5, arg5, `n, ###n, All
	}
	; ini ファイルの設定上、"" が両端にあったら読み込み時に削除されるので""を２重につける
	StringLeft, lChr, arg3, 1
	if(lChr == """"){
		StringRight, rChr, arg3, 1
		if(lChr == """"){
			arg3 := """" . arg3  . """"
		}
	}

	IniWrite, %arg2%, %commandFile%, %arg1%, pathUrl
	IniWrite, %arg3%, %commandFile%, %arg1%, argss
	IniWrite, %arg4%, %commandFile%, %arg1%, workingdir
	IniWrite, %arg5%, %commandFile%, %arg1%, explanation
	IniWrite, %arg6%, %commandFile%, %arg1%, category
	IniWrite, %image%, %commandFile%, %arg1%, imagePath
	IniWrite, %iconNum%, %commandFile%, %arg1%, iconNum
	IniWrite, %dbQuout%, %commandFile%, %arg1%, fileDbQuout
}


ite_newItemEntry(arg1, arg2, arg3, arg4, arg5, arg6=1, image="", iconNum=1, dbQuout=0, tmpItem=0){
	init_itemInsertToObj(arg1, arg2, arg3, arg4, arg5,arg6, image, iconNum, dbQuout, tmpItem)
	guit_checkErrorLevelOutput("アイテムの登録のオブジェクト登録時にエラー", A_LineFile, A_LineNumber)

	; 一時的に保存のか、普通のに保存かを分ける
	commandListFile := gloco_userDir . glob_commandListFileName
	if(tmpItem == 1){
		commandListFile := gloco_userDir . glob_tmpCommandListFileName
	}

	ite_itemWriteiniFile(arg1, arg2, arg3, arg4, arg5,arg6, image, iconNum, dbQuout, tmpItem)
	res := guit_checkErrorLevelOutput("アイテムのiniファイルへの書き込み時にエラー", A_LineFile, A_LineNumber)
	if(res == False){
		return  False
	}

	arg1 := arg1 . "`n"
	FileAppend, %arg1%, %commandListFile%
	res := guit_checkErrorLevelOutput("アイテムのアイテム名のファイルへの書き込み時にエラー", A_LineFile, A_LineNumber)
	if(res){
		return  True
	}
	return  False
}

ite_autoSetPicture( str, pBoxEdit1, pBoxEdit2, pPicture, pText1, pText2, pText3 ){
	optionObj := cen_getFromEnyObject(str)
	if(IsObject(optionObj)){
		guf_setControl( optionObj[4], pBoxEdit1, 73 )
		guf_setControl( optionObj[1], pBoxEdit2, 73 )
		tmpItemFlag := optionObj[9]
		if(tmpItemFlag){
			GuiControl, 73:+c36A2FF, %pText1%
			guf_setControl( "一時的な保存", pText1, 73 )
			guf_setControl( "", pText2, 73 )
			guf_setControl( "", pText3, 73 )
		} else {
			fileFlag := optionObj[10]
			if( fileFlag == 1 ){
				guf_setControl( "", pText1, 73 )
				guf_setControl( "", pText2, 73 )
				guf_setControl( "", pText3, 73 )
			} else if( fileFlag == 2 ){
				GuiControl, 73:+c46D82E, %pText1%
				guf_setControl( "コマンドから登録", pText1, 73 )
				guf_setControl( "", pText2, 73 )
				guf_setControl( "", pText3, 73 )
			} else if( fileFlag == 3 ){
				GuiControl, 73:+cFFB255, %pText1%
				guf_setControl( "fromFileName から登録", pText1, 73 )
				guf_setControl( optionObj[11], pText2, 73 )
				guf_setControl( optionObj[12], pText3, 73 )
			}
		}
		; テキストのアイコンと同じ処理
		aut_pictuerSetByFileOrObj( str, glob_textNoneFile, glob_textHaveFile, "", 71, pPicture, 73, False, "*w32 *h32 ")
	}
}

/*
ite_autoSetPicture( str, pBoxEdit1, pBoxEdit2, pPicture, pText ){
	optionObj := cen_getFromEnyObject(str)
	if(IsObject(optionObj)){
		guf_setControl( optionObj[4], pBoxEdit1, 73 )
		guf_setControl( optionObj[1], pBoxEdit2, 73 )
		tmpItemFlag := optionObj[9]
		if(tmpItemFlag){
			guf_setControl( "一時的な保存", pText, 73 )
		} else {
			guf_setControl( "", pText, 73 )
		}
		if(optionObj[6] == "") {
			if(optionObj[5] == 2) {
				str2 := "*icon4 *w32 *h32 " . glob_SHELL32DLL
				guf_setControl( str2, pPicture, 73 )
			} else if(optionObj[5] == 3) {
				str2 := "*icon25 *w32 *h32 " . glob_SHELL32DLL
				guf_setControl( str2, pPicture, 73 )
			} else if(optionObj[5] == 4) {
				str2 := "*icon71 *w32 *h32 " . glob_SHELL32DLL
				guf_setControl( str2, pPicture, 73 )
			}
		} else {
			imgPath := outs_textOutTrimss(optionObj[6])
			str2 := "*icon" . optionObj[7]  . " *w32 *h32 " . imgPath
			guf_setControl( str2, pPicture, 73 )
		}
	}
}
*/

ite_setPopUpSoftObjList(str, maxCount, pControl, GuiNum) {
	listStr =
	listStr .= auts_pupupSoftObj(str, maxCount)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
}

ite_setFolderObjList(str, maxCount, pControl, GuiNum) {
	listStr =
	listStr .= auts_pupupFolderObj(str, maxCount)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
}

ite_setItemCommandObjList(str, maxCount, pControl, GuiNum) {
	listStr =
	listStr .= auts_pupupItemCommandObj(str, maxCount)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
}

ite_setMultipleObjList(str, maxCount, pControl, GuiNum) {
	listStr =
	listStr .= auts_pupupMultipleObj(str, maxCount)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
}

ite_setItemList(){
	ite_setPopUpSoftObjList("", 500, "List73_1", 73)
	ite_setFolderObjList("", 500, "List73_2", 73)
	ite_setItemCommandObjList("", 500, "List73_3", 73)
	ite_setMultipleObjList("", 500, "List73_7_1", 73)
}

ite_showGui73() {
	ite_setItemList()

	Sleep, 200
	Gui, 73:Show
}

ite_itemLookGuiToggle(){
	IfWinExist, %gGlob_Gui73Title%
	{
		Gui, 73:Hide
	} else {
		ite_showGui73()
	}
}

ite_updateGui73(){
	IfWinExist, %gGlob_Gui73Title%
	{
		ite_setItemList()
	}
}

ite_deleteItemLogic(argss){

	; 二行以上のアイテムなら、違う処理
	tmpOptionObj := glob_multipleObj[argss]
	if(IsObject(tmpOptionObj)) {
		res := musc_multipleScriptsDelete(argss)
		return  res
	}

	if( cen_keyWordIsObject(argss) ) {
		; 一時的に保存のか、普通のかに分ける
		optionObj := cen_getFromEnyObject(argss)
		if(optionObj[10] == 1){
			func_folderCheckMakeFolder(gloco_userDir)
			commandFile := gloco_userDir . glob_commandFileName
			commandListFile := gloco_userDir . glob_commandListFileName
			if(optionObj[9] == 1){
				commandFile := gloco_userDir . glob_tmpCommandFileName
				commandListFile := gloco_userDir . glob_tmpCommandListFileName
			}

			IniDelete, %commandFile%, %argss%
			res := guit_checkErrorLevelOutput("アイテムの ini ファイルの削除に失敗している`n" . argss)
			if( res ){
				cen_anyFileEntryDisplay("アイテムの削除", argss . " のアイテムを削除した")
			} else {
				; エラーなら中断
				return  False
			}

			; ファイルから 元のアイテム名と一致している行以外 全て読み込む
			listStr := ite_wordTrimfileRead(argss, commandListFile, A_LineFile, A_LineNumber)
			FileDelete, %commandListFile%
			FileAppend, %listStr%, %commandListFile%
		}
		ite_itemRemoveFromEnyObj(argss)			;再起動するまでのリストの変更
		res := guit_checkErrorLevelOutput("アイテム削除のエラー`n" . argss, A_LineFile, A_LineNumber)
		if(res){
			return  True
		}
	} else {
		guit_errorAppend("登録アイテムが見つかりません")
	}
	return  False
}

ite_deleteCommand(argss, GuiNum) {
	res := ite_deleteItemLogic(argss)
	if(res){
		guit_setExplain(argss . " のアイテムを削除した", GuiNum)
		; アイテム一覧が出てたら更新する
		ite_updateGui73()
	}
}

ite_sysCommanddeleteCommand(argss, pControl, GuiNum) {
	str := "消したいアイテムの名前をいれる。`n-tmp で一時保存のアイテムを全て消す"
	if( edc_helpViewIfHyphenH(str, argss, GuiNum) ){
		return
	}
	if(argss == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}

	if(argss == "-tmp"  ){
		buff =
		if( ite_tmpItemDeleteObjectAndFile() ){
			buff := "一時的に保存したアイテムを削除した`n"
		}
		if( musc_tmpMultipleItemDeleteObjectAndFile() ){
			buff .= "一時的に保存した二行以上アイテムを削除した`n"
		}
		if(buff == ""){
			guit_setExplain("削除する一時的に保存したアイテムがない", GuiNum)
		} else {
			guit_setExplain(buff, GuiNum)
			;guf_setControl( "", pControl, GuiNum )
		}
		return
	}
	ite_deleteCommand(argss, GuiNum)
	;guf_setControl( "", pControl, GuiNum )
}

ite_tmpItemDeleteObjectAndFile(){
	tmpCommandFile := gloco_userDir . glob_tmpCommandFileName
	tmpCommandListFile := gloco_userDir . glob_tmpCommandListFileName
	func_folderCheckMakeFolder(gloco_userDir)
	Loop, Read, %tmpCommandListFile%
	{
		itemName := Trim(A_LoopReadLine)
		if(itemName != null){
			ite_itemRemoveFromEnyObj(itemName)
		}
	}
	FileDelete, %tmpCommandFile%
	FileDelete, %tmpCommandListFile%

	FileAppend, %null%, %tmpCommandFile%
	FileAppend, %null%, %tmpCommandListFile%
	if( guit_checkErrorLevelOutput("一時的に保存したアイテムの削除の時にエラーあり") ){
		return  True
	}
	return  False
}


ite_editCommand(argss){

	; 二行以上のアイテムなら、違う処理
	tmpOptionObj := glob_multipleObj[argss]
	if(IsObject(tmpOptionObj)) {
		musc_editMultipleScriptsGui(argss)
		return
	}

	optionObj := cen_getFromEnyObject(argss)
	if(IsObject(optionObj)) {

		guf_setControl( 1, "HiddenCheckbox72_1", 72 )	;編集用の目印
		guf_setControl( argss, "HiddenEdit72_2", 72 )	;アイテム名変更に備えて保存
		
		guf_setControl( argss, "Edit72_1", 72 )
		guf_setControl( optionObj[4], "BoxEdit72_1", 72 )

		guf_setRadioControl(optionObj[5], "Radio72_1", "Radio72_2", "Radio72_3", "", 72)

		guf_setControl( optionObj[8], "Checkbox72_1", 72 )
		guf_setControl( optionObj[9], "Checkbox72_2", 72 )

		GuiControl, 72:Choose, Tab72_1, 1
		GuiControl, 72:+c000000, Text72_1
		GuiControl, 72:, Text72_1, アイテム名(&E)

		GuiControl, 72:Focus, Edit72_1
		; 画像を 表示させる
		guf_setControl( optionObj[7], "UpDown72_2_1", 72 )
		guf_setControl( optionObj[6], "Edit72_2_1", 72 )

		; 文字数でテキスト欄のサイズが自動で変更する処理に影響があるため、ここで表示しておく
		Gui, 72:Show
		guf_setControl( optionObj[2], "Edit72_4", 72 )
		; 画像の表示の関係があるため、Edit72_2_1 の後に表示させる
		guf_setControl( optionObj[1], "Edit72_3", 72 )

		Sleep, 1000					; WorkDirが自動補完されるトラブルのため遅らせる
		; ラジオボタンの影響をここでだす
		ite_autoItemRadioChange()

		guf_setControl( optionObj[3], "Edit72_5", 72 )

		fileFlag := optionObj[10]
		if( fileFlag == 1 ){
			GuiControl, 72:+c000000, Text72_3
			GuiControl, 72:, Text72_3, リンク先(&L)
		} else if( fileFlag == 2 ){
			GuiControl, 72:+cFF0000, Text72_3
			GuiControl, 72:, Text72_3, コマンドから登録したので編集不可
		} else if( fileFlag == 3 ){
			GuiControl, 72:+cFF0000, Text72_3
			GuiControl, 72:, Text72_3, fromFileName から登録したので編集不可
		}

		;imgPath := outs_textOutTrimss(optionObj[6])
		;if(imgPath != ""){
		;	str2 := "*icon" . optionObj[7]  . " *w32 *h32 " . imgPath
		;	guf_setControl( str2, "Picture72_1_1", 72 )
		;	guf_setControl( str2, "Picture72_2_1", 72 )
		;}

	} else {
		; ファイルがあったらプロパティを表示する
		res := syf_viewPropertiesOfFile(argss)
		if(res == False){
			guit_errorAppend("登録アイテムが見つかりません")
		}
	}
}

ite_workDirAutoSet(str , changeStr, pOutControl, GuiNum){
	type := FileExist(changeStr)
	if(type != "") {
		IfNotInString, type, D
		{
			StringRight, rChar, str, 1	;	ここでいらん一工夫
			if(rChar == "#"){		;	 ##で囲まれているなら(item名なら)
				str .= "\"			;	その親フォルダをかえすようにする(\を付け足す)
			} else {
				StringGetPos, num, str, \, R1
				num++
				StringLeft, str, str, num
			}
		}
		guf_setControl( str, pOutControl, GuiNum )
	}
}

ite_pictuerOfPath72_1( changStr ) {
	pictureStr := guf_getControl( "Edit72_2_1", 72 )
	pictureStr := Trim(pictureStr)
	if(pictureStr != ""){
		return
	}

	radioNum := guf_guiRadioControl(72, "Radio72_1", "Radio72_2", "Radio72_3", "_")
	if(radioNum == 3){
		return
	}

	type := FileExist(changStr)
	if(type != "") {
		IfInString, type, D
		{
			str2 := "*icon4 *w32 *h32 " . glob_SHELL32DLL
			guf_setControl( str2 , "Picture72_1_1", 72 )
			guf_setControl( str2 , "Picture72_2_1", 72 )
		} else {
			StringRight, suffix, changStr, 4
			StringLower, suffix, suffix
			if(suffix == ".exe") {
				str2 := "*w32 *h32 " . changStr
				guf_setControl( str2, "Picture72_1_1", 72 )
				guf_setControl( str2, "Picture72_2_1", 72 )
			} else if(suffix == ".txt"){
				str2 := "*icon71 *w32 *h32 " . glob_SHELL32DLL
				guf_setControl( str2, "Picture72_1_1", 72 )
				guf_setControl( str2, "Picture72_2_1", 72 )
			} else if(suffix == ".jpg" || suffix == ".gif" || suffix == ".png"){
				str2 := "*icon303 *w32 *h32 " . glob_SHELL32DLL
				guf_setControl( str2, "Picture72_1_1", 72 )
				guf_setControl( str2, "Picture72_2_1", 72 )
			} else {
				; 何らかのファイルなら、不明なファイルとして表示
				guf_setControl( "*icon44 *w32 *h32 " . glob_SHELL32DLL, "Picture72_1_1", 72 )
				guf_setControl( "*icon44 *w32 *h32 " . glob_SHELL32DLL, "Picture72_2_1", 72 )
			}
		}
	} else {
		guf_setControl( "", "Picture72_1_1", 72 )
		guf_setControl( "", "Picture72_2_1", 72 )
	}
}

ite_itemPictuerOfPath( str, iconNum, defaultImg, pControl, GuiNum) {
	if(str == ""){
		guf_setControl( defaultImg, pControl, GuiNum )
		return
	}

	if( func_myFileExist(str) ){
		StringLower, tmpStr, str
		StringRight, suffix, tmpStr, 4
		if(suffix == ".exe" || suffix == ".dll" || suffix == ".ico" || suffix == ".cpl") {
			str2 := "*Icon" . iconNum . " *w32 *h32 " . str
			guf_setControl( str2, pControl, GuiNum )
			return
		}
	}
	; アイコンが不明なら、何らかのファイルとして表示
	guf_setControl( "*icon44 *w32 *h32 " . glob_SHELL32DLL, pControl, GuiNum )
}

 ; ファイルから 指定した文字と一致している行以外 全て読み込む
ite_wordTrimfileRead(str, file, lineFile, lineNumber) {
	buff =
	IfExist, %file%
	{
		Loop, Read, %file%
		{
			if(str != A_LoopReadLine) {
				buff .= A_LoopReadLine  . "`n"
			}
		}
	} else {
		;guit_errorAppend("読み込むファイルが見つからず", lineFile, lineNumber)
	}
	return  buff
}


ite_showGui72(itemName, script, radioNum) {
	GuiControl, 72:Focus, Edit72_1
	;GuiControl, 72:+cFF0000, Text72_3
	;GuiControl, 72:, Text72_3, リンク先は必要です(&L)
	guf_setControl( itemName, "Edit72_1", 72 )
	guf_setControl( "", "BoxEdit72_1", 72 )
	;guf_setControl( 1, "Radio72_1", 72 )
	guf_setRadioControl(radioNum, "Radio72_1", "Radio72_2", "Radio72_3", "Radio72_1", 72)

	; ラジオボタンによる影響を元に戻す
	;guf_switchEnableByFlag(True, "Edit72_4", 72)
	;guf_switchEnableByFlag(True, "Edit72_5", 72)
	;guf_switchEnableByFlag(True, "Checkbox72_1", 72)
	;guf_switchEnableByFlag(True, "Text72_4", 72)

	guf_setControl( 0, "HiddenCheckbox72_1", 72 )
	guf_setControl( "", "HiddenEdit72_2", 72 )
	guf_setControl( 0, "Checkbox72_1", 72 )
	guf_setControl( 0, "Checkbox72_2", 72 )
	guf_setControl( "", "Edit72_2_1", 72 )
	guf_setControl( 1, "UpDown72_2_1", 72 )
	guf_setControl( "", "Picture72_1_1", 72 )
	guf_setControl( "", "Picture72_2_1", 72 )
	; ラジオボタンの影響をここでだす
	ite_autoItemRadioChange()
	GuiControl, 72:Choose, Tab72_1, 1

	Gui, 72:Show
	guf_setControl( "", "Edit72_4", 72 )
	guf_setControl( "", "Edit72_5", 72 )
	guf_setControl( script, "Edit72_3", 72 )

}


ite_hideConfirmGui72() {
	if( guf_controlHideDisable("List72_1", 72) ) {
		return  True
	} else if( guf_controlHideDisable("List72_2", 72) ) {
		return  True
	} else if( guf_controlHideDisable("List72_3", 72) ) {
		return  True
	}
	return  False
}

; アイテムに使う名前に無効な文字が入っていたら False を返す
ite_itemNameNGCharacterConfirm(name){
	comma = ,
	percent := "%"
	if(name == ""){
		return False
	}
	If name contains !,",#,$,&,',(,),=,-,^,~,\,+,:,*,],},<,.,>,/,;,?	;"
	{
		return False
	}
	IfInString, name, %comma%
	{
		return False
	}
	IfInString, name, %A_Space%
	{
		return False
	}
	IfInString, name, %A_Tab%
	{
		return False
	}
	IfInString, name, %percent%
	{
		return False
	}
	IfInString, name, @
	{
		return False
	}
	IfInString, name, [
	{
		return False
	}
	IfInString, name, ``
	{
		return False
	}
	IfInString, name, |
	{
		return False
	}
	IfInString, name, {
	{
		return False
	}
	return True
}

ite_submitItemEntry(itemName, script, args, workDir, explanation, imagePath, iconNum, beforeItemName){

	itemName := Trim(itemName)
	explanation := Trim(explanation)
	script := Trim(script)
	args := Trim(args)
	workDir := Trim(workDir)
	imagePath := Trim(imagePath)

	radioNum := guf_guiRadioControl(72, "Radio72_1", "Radio72_2", "Radio72_3", "_")

	dbQuoutFlag := guf_getControl( "Checkbox72_1", 72 )
	tmpItemFlag := guf_getControl( "Checkbox72_2", 72 )

	editFlag := guf_getControl( "HiddenCheckbox72_1", 72 )

	if( ita_pushEnterFromList72( ) ) {
		return
	}

	if(itemName == ""){
		GuiControl, 72:+cFF0000, Text72_1
		GuiControl, 72:, Text72_1, アイテム名は必要(&E)
		return
	}
	if( ite_itemNameExistNGCharacter(itemName) ) {
		;GuiControl, 72:+cFF0000, Text72_1
		;GuiControl, 72:, Text72_1, 無効な文字が入っている(&E)
		return
	}
	script := Trim( script, """" )
	workDir := Trim( workDir, """" )

	; タイプ 1 か 2 なら、右端の\は取る
	if(radioNum == 1){
		script := RTrim(script, "\\")
	} else if(radioNum == 2){
		script := RTrim(script, "\\")
	}

	script := Trim(script)
	if(script == "") {
		guit_errorAppend("アイテムのパスがカラ")
		return
	}
	; ループを避けるため、アイテム名とパスが同じものはエラーにする
	StringLower, itemNameLower, itemName
	StringLower, scriptLower, script
	if(itemNameLower == scriptLower) {
		guit_errorAppend("アイテム名とリンク先が同じものは、禁止にしている")
		return
	}

	if(imagePath == ""){
		iconNum = 1
	}

	if(radioNum == 1){
		tempStr := outs_textOutDqAllTrim(script)		; %%と##を展開する(でも登録はしない)
		type := FileExist(tempStr)
		IfInString, type, D
		{
			if(radioNum != 2){		;フォルダにチェックを入れていない
				radioNum = 2
				guit_appendExplain("アイテムをフォルダとして登録します")
			}
		} else {
			; フォルダが存在していなくても登録できるようにする
			;if(radioNum == 2){
			;	; リンク先がフォルダではない時、フォルダにチェックを入れてればエラー
			;	GuiControl, 72:+cFF0000, Text72_3
			;	GuiControl, 72:, Text72_3, 種類を確認してください(&L)
			;	return
			;}
		}
	}
	workDir := RTrim(workDir, "\\")
	StringRight, rChar, workDir, 1	;	ここでいらん一工夫
	if(rChar == "#"){			;	 ##で囲まれているなら(item名なら)
		workDir .= "\"			;	その親フォルダをかえすようにする(\をやっぱり付け足す)
	}

	if(radioNum == 2){			; フォルダかスクリプトなら、引数と作業フォルダをカラに
		args := ""
		workDir := ""
	}
	if(radioNum == 3){
		args := ""
		workDir := ""
	}

	Gui, 72:Show, Hide

	res := False
	str =
	;新規登録か  編集か
	if( editFlag ) {
		str := "編集"
		errFlag := False
		; 編集前と同じアイテム名なら問題なし
		if(itemName != beforeItemName){
			str := "新規登録と、  " . beforeItemName . "  を削除"
			; アイテム名がすでに存在してるならエラーに
			if( cen_keyWordIsObject(itemName) ) {
				errFlag := True
			}
		}
		if( errFlag ){
			guit_errorAppend(itemName . "  のアイテムはすでに登録されている。")
			return
		}
		res := ite_editItemEntry(itemName, script, args, workDir, explanation, radioNum ,imagePath, beforeItemName, iconNum, dbQuoutFlag, tmpItemFlag)
	} else {
		str := "新規登録"
		if( cen_keyWordIsObject(itemName) ) {			;アイテム名がかぶってるかどうか
			guit_errorAppend("アイテムの登録が失敗している")
			return
		}
		res := ite_newItemEntry(itemName, script, args, workDir, explanation, radioNum ,imagePath, iconNum, dbQuoutFlag, tmpItemFlag)
	}
	if(res){
		;guit_setExplain(itemName . " のアイテムを" . str . "した", 63)
		cen_anyFileEntryDisplay("アイテムの" . str, itemName . " のアイテムを" . str . "した")
		; アイテム一覧が出てたら更新する
		ite_updateGui73()
	}
}

; 何も文字が無いときも、 ite_pictuerOfPath72_1 を使用しているので、、アイコンをセットする
ite_autoSetPictuerOfPath(){
	str := guf_getControl( "Edit72_2_1", 72 )
	str := outs_textOutTrimss(str)
	str := aut_checkDangerStr(str)
	str := Trim(str)
	num := guf_getControl( "UpDown72_2_1", 72 )

	; カラにしたとき、自動的に、ファイル名やアイテムの種類からアイコンを表示するようにした
	if(str == ""){
		radioNum := guf_guiRadioControl(72, "Radio72_1", "Radio72_2", "Radio72_3", "_")
		if(radioNum == 3){
			str2 := "*icon25 *w32 *h32 " . glob_SHELL32DLL
			guf_setControl( str2 , "Picture72_1_1", 72 )
			guf_setControl( str2 , "Picture72_2_1", 72 )
		} else {
			Edit72_3 := guf_getControl( "Edit72_3", 72 )
			changeEdit72_3 := outs_textOutDqAllTrim(Edit72_3)
			changeEdit72_3 := aut_checkDangerStr(changeEdit72_3)
			ite_pictuerOfPath72_1( changeEdit72_3 )
		}
		return
	}
	ite_itemPictuerOfPath( str, num, "", "Picture72_1_1", 72)
	ite_itemPictuerOfPath( str, num, "", "Picture72_2_1", 72)
}

ite_itemIconButtonOfPath(){
	str := guf_getControl( "Edit72_2_1", 72 )
	num := guf_getControl( "UpDown72_2_1", 72 )
	str := outs_textOutTrimss(str)
	if( func_isFolder(str) ){
		FileSelectFile, OutputVar, 3, %str%, アイコンの選択
	} else {
		FileSelectFile, OutputVar, 3, %A_WorkingDir%, アイコンの選択
	}
	if(OutputVar != "") {
		OutputVar := aut_checkDangerStr(OutputVar)
		ite_itemPictuerOfPath( OutputVar, num, "", "Picture72_1_1", 72)
		ite_itemPictuerOfPath( OutputVar, num, "", "Picture72_2_1", 72)

		guf_setControl( OutputVar, "Edit72_2_1", 72 )
	}
}

; ite_pictuerOfPath72_1 を使用しているので、アイコンをセットする
ite_autoItemRadioChange(){
	flag = 0
	radioNum := guf_guiRadioControl(72, "Radio72_1", "Radio72_2", "Radio72_3", "_")
	if(radioNum == 1){
		flag = 1
	}

	guf_switchEnableByFlag(flag, "Edit72_4", 72)
	guf_switchEnableByFlag(flag, "Edit72_5", 72)
	guf_switchEnableByFlag(flag, "Checkbox72_1", 72)
	guf_switchEnableByFlag(flag, "Text72_4", 72)

	pictureStr := guf_getControl( "Edit72_2_1", 72 )
	pictureStr := Trim(pictureStr)
	if(pictureStr != ""){
		return
	}

	if(radioNum == 3){
		str2 := "*icon25 *w32 *h32 " . glob_SHELL32DLL
		guf_setControl( str2 , "Picture72_1_1", 72 )
		guf_setControl( str2 , "Picture72_2_1", 72 )
	} else {
		Edit72_3 := guf_getControl( "Edit72_3", 72 )
		changeEdit72_3 := outs_textOutDqAllTrim(Edit72_3)
		changeEdit72_3 := aut_checkDangerStr(changeEdit72_3)
		ite_pictuerOfPath72_1( changeEdit72_3 )
	}
}
