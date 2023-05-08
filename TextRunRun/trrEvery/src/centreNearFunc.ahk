



; 設定で コマンドの実行過程を表示にチェックを入れてる時のみ追加する
cen_easyCheckAppend(append, str2="@", str3="@", str4="@"){
	if(glob_iniEasyCheck == 1){
		append := Trim(append, "`n")
		guit_appendExplain(append, str2, str3, str4)
	}
}

cen_easyCheckAppendNotShow(append, str2="@", str3="@", str4="@"){
	if(glob_iniEasyCheck == 1){
		append := Trim(append, "`n")
		guit_appendExplainNotShow(append, str2, str3, str4)
	}
}

; エラーレベルをチェック。 1から5 の間なら、エラーのフラグを立てる
cen_checkCommSuccess(){
	if(ErrorLevel >= 1  && ErrorLevel < 5){
		glob_commSuccessFlag := False
	}
}

; func_easyFileCheckMakeFolderAndFile  と同じ。UTF-8 で保存するようにしたもの
cen_fileCheckMakeFolderAndFileUtf8(file, parentFolder, defaultStr){
	IfNotExist, %file%
	{
		type := FileExist(parentFolder)
		if(type == ""){
			FileCreateDir, %parentFolder%
		} else {
			IfNotInString, type, D
			{
				ToolTip , %parentFolder%はフォルダ名ではない, A_CaretX, A_CaretY, 2
				return
			}
		}
		FileAppend , %defaultStr%, %file%, UTF-8
	}
}

cen_switchEnableLastWordGui(flag){
	guf_switchEnableByFlag(flag, "Checkbox84_2", 84)
	guf_switchEnableByFlag(flag, "Checkbox84_3", 84)
	guf_switchEnableByFlag(flag, "Checkbox84_4", 84)
	guf_switchEnableByFlag(flag, "Checkbox84_5", 84)
	guf_switchEnableByFlag(flag, "Checkbox84_7", 84)
	guf_switchEnableByFlag(flag, "Checkbox84_8", 84)
	guf_switchEnableByFlag(flag, "Checkbox84_9", 84)
	guf_switchEnableByFlag(flag, "Checkbox84_10", 84)
	guf_switchEnableByFlag(flag, "Edit84_2", 84)
	guf_switchEnableByFlag(flag, "Edit84_6", 84)
	guf_switchEnableByFlag(flag, "Edit84_3", 84)
	guf_switchEnableByFlag(flag, "Edit84_4", 84)
	guf_switchEnableByFlag(flag, "Edit84_5", 84)
	guf_switchEnableByFlag(flag, "Edit84_7", 84)
	guf_switchEnableByFlag(flag, "Edit84_8", 84)
	guf_switchEnableByFlag(flag, "Edit84_9", 84)
	guf_switchEnableByFlag(flag, "Edit84_10", 84)
}

cen_switchEnableLastWordAnyTab(flag, tabNum){
	pEdit1_1 = Edit84_%tabNum%_1_1
	pEdit2_1 = Edit84_%tabNum%_2_1
	pEdit3_1 = Edit84_%tabNum%_3_1
	pEdit4_1 = Edit84_%tabNum%_4_1
	pEdit5_1 = Edit84_%tabNum%_5_1
	pEdit6_1 = Edit84_%tabNum%_6_1
	pEdit7_1 = Edit84_%tabNum%_7_1
	pEdit8_1 = Edit84_%tabNum%_8_1
	pEdit9_1 = Edit84_%tabNum%_9_1
	pEdit10_1 = Edit84_%tabNum%_10_1

	pEdit1_2 = Edit84_%tabNum%_1_2
	pEdit2_2 = Edit84_%tabNum%_2_2
	pEdit3_2 = Edit84_%tabNum%_3_2
	pEdit4_2 = Edit84_%tabNum%_4_2
	pEdit5_2 = Edit84_%tabNum%_5_2
	pEdit6_2 = Edit84_%tabNum%_6_2
	pEdit7_2 = Edit84_%tabNum%_7_2
	pEdit8_2 = Edit84_%tabNum%_8_2
	pEdit9_2 = Edit84_%tabNum%_9_2
	pEdit10_2 = Edit84_%tabNum%_10_2

	guf_switchEnableByFlag(flag, pEdit1_1, 84)
	guf_switchEnableByFlag(flag, pEdit2_1, 84)
	guf_switchEnableByFlag(flag, pEdit3_1, 84)
	guf_switchEnableByFlag(flag, pEdit4_1, 84)
	guf_switchEnableByFlag(flag, pEdit5_1, 84)
	guf_switchEnableByFlag(flag, pEdit6_1, 84)
	guf_switchEnableByFlag(flag, pEdit7_1, 84)
	guf_switchEnableByFlag(flag, pEdit8_1, 84)
	guf_switchEnableByFlag(flag, pEdit9_1, 84)
	guf_switchEnableByFlag(flag, pEdit10_1, 84)

	guf_switchEnableByFlag(flag, pEdit1_2, 84)
	guf_switchEnableByFlag(flag, pEdit2_2, 84)
	guf_switchEnableByFlag(flag, pEdit3_2, 84)
	guf_switchEnableByFlag(flag, pEdit4_2, 84)
	guf_switchEnableByFlag(flag, pEdit5_2, 84)
	guf_switchEnableByFlag(flag, pEdit6_2, 84)
	guf_switchEnableByFlag(flag, pEdit7_2, 84)
	guf_switchEnableByFlag(flag, pEdit8_2, 84)
	guf_switchEnableByFlag(flag, pEdit9_2, 84)
	guf_switchEnableByFlag(flag, pEdit10_2, 84)
}

cen_switchEnableLastWordChangeChoice(flag, pEdit1, pEdit2, pEdit3, pEdit4){
	guf_switchEnableByFlag(flag, pEdit1, 84)
	guf_switchEnableByFlag(flag, pEdit2, 84)
	guf_switchEnableByFlag(flag, pEdit3, 84)
	guf_switchEnableByFlag(flag, pEdit4, 84)
}

cen_clickOnlyGuiShow(){
	if( glob_iniClickOnlyGuiNotFlag == False ){
		guf_showGuiAssign(76, "NA")
	} else {
		Gui, 76:Hide
	}
}

	; 使わないのでコメントにする
/*
cen_clickOnlyGuiShowHide(){
	GuiControlGet, OutputVar, 76:Visible, Picture76_1
	if(OutputVar == 1){
		Gui, 76:Show, Hide
		glob_iniClickOnlyGuiNotFlag := True
	} else {
		guf_showGuiAssign(76, "NA")
		glob_iniClickOnlyGuiNotFlag := False
	}
}
*/


cen_ahkGuiSizePosSave(){
	DetectHiddenWindows, On
	func_folderCheckMakeFolder(gloco_userDir . glob_userTmpDirName)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui61Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui62Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui66Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui68Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui63Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui64Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui74Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui65Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui70Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui72Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui73Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui77Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui78Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui87Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui67Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui69Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui75Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui76Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui84Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui86Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui85Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui79Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui80Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui82Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui83Title)
	cen_ahkGuiSizePosSaveIniWrite(gGlob_Gui89Title)
	guit_checkErrorLevelOutput("Guiの位置とサイズを保存時にエラーあり")
}



cen_ahkGuiSizePosSaveIniWrite(winTitle){
	; 最大化か最小化してる場合は諦める
	if( func_isWindowMaxSize(winTitle) ){
		return
	}
	; 非表示のウインドウは DetectHiddenWindows,Off なら、最小化されていてもTrueになってしまうので
	; func_isWindowMinimizeSize(winTitle) の使用が変更になった場合は注意
	if( func_isWindowMinimizeSize(winTitle) ){
		return
	}

	; 指定のウインドウが見つからないなら、飛ばす。現時点では意味はないが、
	; func_isWindowMinimizeSize(winTitle) の使用が変更になった場合にそなえて。
/*
	if( func_ifWinExist(winTitle) == False ){
		return
	}
*/

	WinGetPos, X, Y, Width, Height, %winTitle%
	tmpAhkGuiSizePosFile := gloco_userDir . glob_tmpAhkGuiSizePosFileName
	IniWrite, %X%, %tmpAhkGuiSizePosFile%, %winTitle%, guiX
	IniWrite, %Y%, %tmpAhkGuiSizePosFile%, %winTitle%, guiY
	IniWrite, %Width%, %tmpAhkGuiSizePosFile%, %winTitle%, guiWidth
	IniWrite, %Height%, %tmpAhkGuiSizePosFile%, %winTitle%, guiHeight
}

cen_ahkGuiSizePosLoad(){
	DetectHiddenWindows, On
	tmpAhkGuiSizePosFile := gloco_userDir . glob_tmpAhkGuiSizePosFileName
	;func_easyFileCheckMakeFolderAndFile(tmpAhkGuiSizePosFile, gloco_userDir . glob_userTmpDirName)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui61Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui62Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui66Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui68Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui63Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui64Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui74Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui65Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui70Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui72Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui73Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui77Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui78Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui87Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui67Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui69Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui75Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui76Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui84Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui86Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui85Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui79Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui80Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui82Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui83Title)
	cen_ahkGuiSizePosSaveIniRead(gGlob_Gui89Title)
	;guit_checkErrorLevelOutput_StartUp("Guiの位置とサイズを読み出し時にエラーあり")
	;後で DetectHiddenWindows, Off をするのでここではしない
	;DetectHiddenWindows, Off
}

cen_ahkGuiSizePosSaveIniRead(winTitle){
	tmpAhkGuiSizePosFile := gloco_userDir . glob_tmpAhkGuiSizePosFileName
	IniRead, posX, %tmpAhkGuiSizePosFile%, %winTitle%, guiX , 0
	IniRead, posY, %tmpAhkGuiSizePosFile%, %winTitle%, guiY , 0
	IniRead, Width, %tmpAhkGuiSizePosFile%, %winTitle%, guiWidth , 0
	IniRead, Height, %tmpAhkGuiSizePosFile%, %winTitle%, guiHeight , 0
	if(posX == 0){
		; guit_errorAppend("Guiの位置とサイズを読み出し時にエラーあり", winTitle . " の時のエラー")
		return
	}
	WinMove, %WinTitle%, , %posX%, %posY% , %Width%, %Height%
}

cen_ahkGuiPosOnlySaveIniRead(winTitle){
	tmpAhkGuiSizePosFile := gloco_userDir . glob_tmpAhkGuiSizePosFileName
	IniRead, posX, %tmpAhkGuiSizePosFile%, %winTitle%, guiX , 0
	IniRead, posY, %tmpAhkGuiSizePosFile%, %winTitle%, guiY , 0
	if(posX == 0){
		; guit_errorAppend("Guiの位置とサイズを読み出し時にエラーあり", winTitle . " の時のエラー")
		return
	}
	WinMove, %winTitle%, , %posX%, %posY%
}

cen_setSysComList(str, maxCount, pControl, GuiNum) {
	listStr =
	listStr .= auts_pupupSysComm(str, maxCount)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
}

cen_setSpecialWordList(str, maxCount, pControl, GuiNum) {
	listStr =
	listStr .= auts_pupupSpecialWord(str, maxCount)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
}

cen_setVariableWordList(str, maxCount, pControl, GuiNum) {
	listStr =
	listStr .= auts_pupupVariableWord(str, maxCount)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
}

cen_setUserVariableWordList(str, maxCount, pControl, GuiNum) {
	listStr =
	listStr .= auts_pupupUserVariableWord(str, maxCount)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
}

cen_setUserMakeWordList(str, maxCount, pControl, GuiNum) {
	listStr =
	listStr .= auts_pupupUserMakeWord(str, maxCount)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
}

cen_setOptionVariableWordList(str, maxCount, pControl, GuiNum){
	listStr := auts_pupupOptionVariableWord(str, maxCount)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
}

cen_setSnippetObjList(str, maxCount, pControl, GuiNum){
	listStr := auts_pupupSnippetObj(str, maxCount)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
}

cen_iniSetAnyList(){
	cen_setSysComList("", 200, "List89_1_1", 89)
	cen_setSpecialWordList("", 150, "List89_3_1", 89)
	cen_setVariableWordList("", 200, "List89_2_1", 89)
	;cen_setUserVariableWordList("", 500, "List89_5_1", 89)
	;cen_setUserMakeWordList("", 500, "List89_4_1", 89)
	cen_setOptionVariableWordList("", 200, "List89_6_1", 89)
	;cen_setSnippetObjList("", 500, "List89_7_1", 89)
}

cen_showEverInputGui(){
	IfWinExist, %gGlob_Gui89Title%
	{
		Gui, 89:Hide
	} else {
		cen_setUserVariableWordList("", 500, "List89_5_1", 89)
		cen_setUserMakeWordList("", 500, "List89_4_1", 89)
		cen_setSnippetObjList("", 500, "List89_7_1", 89)
		Sleep, 200
		Gui, 89:Show
	}
}

cen_sysCommandeditCommand(argss, pControl, GuiNum) {
	str := "登録した物を一覧表示する。引数にアイテム名があると、そのアイテムを編集する状態になる。`n引数が  -e  なら、入力補完の一覧のウインドウを表示する。`nおまけで、ファイル名だった場合はファイルのプロパティを表示するようにしている"
	if( edc_helpViewIfHyphenH(str, argss, GuiNum) ){
		return
	}
	if(argss == ""){
		ite_showGui73()
	} else if(argss == "-e"){
		cen_showEverInputGui()
	} else {
		ite_editCommand(argss)
	}
	;guf_setControl( "", pControl, GuiNum )
}

cen_updateEveryInputGui(){
	IfWinExist, %gGlob_Gui89Title%
	{
		cen_setSnippetObjList("", 500, "List89_7_1", 89)
	}
}

cen_autoEditSysExplanation(pList, pBoxEdit, GuiNum){
	listStr := guf_getControl( pList, GuiNum )
	explanation := glob_sysCommObj[listStr]
	guf_setControl( explanation, pBoxEdit, GuiNum )
}

;  アイテム名からオブジェが返せるか確認
cen_keyWordIsObject(keyWord) {
	if( IsObject(glob_softObj[keyWord]) ) {
		return True
	} else if ( IsObject(glob_folderObj[keyWord]) ){
		return True
	} else if ( IsObject(glob_itemCommandObj[keyWord]) ){
		return True
	} else if ( IsObject(glob_multipleObj[keyWord]) ){
		return True
	}
	return  False
}

;  アイテム名からオブジェの種類のナンバーを返す  なければ 0
cen_keyWordIsObjectNumber(keyWord) {
	if( IsObject(glob_softObj[keyWord]) ) {
		return 1
	} else if ( IsObject(glob_folderObj[keyWord]) ){
		return 2
	} else if ( IsObject(glob_itemCommandObj[keyWord]) ){
		return 3
	} else if ( IsObject(glob_multipleObj[keyWord]) ){
		return 4
	}
	return  0
}

; アイテム名からアイテムのオプションのオブジェを返す。なければ空文字
cen_getFromEnyObject(keyWord) {
	if( IsObject(glob_softObj[keyWord]) ) {
		return glob_softObj[keyWord]
	} else if ( IsObject(glob_folderObj[keyWord]) ){
		return glob_folderObj[keyWord]
	} else if ( IsObject(glob_itemCommandObj[keyWord]) ){
		return glob_itemCommandObj[keyWord]
	} else if ( IsObject(glob_multipleObj[keyWord]) ){
		return glob_multipleObj[keyWord]
	}
	return  ""
}

cen_ansPathOfItem(key) {
	optionObj := cen_getFromEnyObject(key)
	if(IsObject(optionObj)) {
		if(optionObj[5] == 4){
			;reouts_errorMessageOutput("二行以上のアイテムは##で表示できない")
			return key
		}
		return optionObj[1]
	}
	return  ""
}

; fromFileName のアイテムを一つだけ読み込む。
; エラーがある場合は 0 。編集した場合は 1 。新規登録の場合なら、2 を返す。
; アイテムを削除した後、エラーがある場合は 3 を返す
cen_itemReloadOneFromFileNameLogic(itemName, itemCategoryDir, categoryDir, funcName){
	returnValue = 0
	itemName := RTrim( itemName, "\" )
	if(itemName == ""){
		return returnValue
	}

	newFlag := True
	; アイテム名が見つかる場合
	if( cen_keyWordIsObject(itemName) ) {
		optionObj := cen_getFromEnyObject(itemName)
		if(optionObj[10] != 3){
			guit_errorAppend(funcName . " のエラー。`nfromFileName 以外の方法で登録をしたアイテムが指定されている。`nこの処理は中断する。`nアイテム名  " . itemName)
			return returnValue
		}
		; アイテムを削除
		ite_itemRemoveFromEnyObj(itemName)

		; カテゴリーフォルダの指定が無い場合は、アイテムの設定から読み込む
		categoryDir := RTrim( categoryDir, "\" )
		if(categoryDir == ""){
			categoryDir := optionObj[11]
		}
		itemCategoryDir := RTrim( itemCategoryDir, "\" )
		if(itemCategoryDir == ""){
			itemCategoryDir := optionObj[12]
		}

		newFlag := False
		; アイテムを削除 して、失敗した場合は 3 を返すようにする
		returnValue = 3
	}

	categoryDir := RTrim( categoryDir, "\" )
	if(categoryDir == ""){
		categoryDir = %glob_firstFfnDirNameOnly%
	}
	itemFromFileNameDir = %glob_fromFileNameDir%\%categoryDir%%glob_itemFfnDirName%
	itemFullPath = %itemFromFileNameDir%\%itemName%
	if(itemCategoryDir != ""){
		itemCategoryDir := RTrim( itemCategoryDir, "\" )
		itemFromFileNameDir .= "\" . itemCategoryDir
		if( func_isNotFolder(itemFromFileNameDir) ){
			guit_errorAppend(funcName . " のエラー。`n以下の指定のアイテムのフォルダが見つからない`n直下のカテゴリー  " . categoryDir . "`nアイテムのカテゴリー  " . itemCategoryDir . "`nアイテム名  " . itemName)
			return returnValue
		}
		itemFullPath = %itemFromFileNameDir%\%itemName%
	}

	if( func_myFileExist(itemFullPath) ){
		if( func_isFolder(itemFullPath) ){
			res := frfnf_makeOneItemFromFolderName(itemFullPath, itemName, categoryDir, itemCategoryDir)
			if( res ){
				returnValue = 1
				if( newFlag ){
					returnValue = 2
				}
				return returnValue
			} else {
				guit_errorAppend(funcName . " のエラー。`n以下のアイテム名用のフォルダが認識できない`nフォルダのパス`n" . itemFullPath)
				return returnValue
			}
		}
	}

	scriptFile =
	; ファイル名の場合、拡張子に対応させる
	noExtScriptFile1 = %itemFullPath%
	if( func_myFileExist(noExtScriptFile1 . ".txt") ){
		scriptFile := noExtScriptFile1 . ".txt"
	} else if( func_myFileExist(noExtScriptFile1 . ".ahk") ){
		scriptFile := noExtScriptFile1 . ".ahk"
	} else if( func_myFileExist(noExtScriptFile1 . ".trr") ){
		scriptFile := noExtScriptFile1 . ".trr"
	} else if( func_myFileExist(noExtScriptFile1) ){
		scriptFile := noExtScriptFile1
	} else {
		guit_errorAppend(funcName . " のエラー。`n以下のアイテム名用のファイルやフォルダが見つからない`n" . itemName)
		return returnValue
	}
	if( func_isFolder(scriptFile) ){
		guit_errorAppend(funcName . " のエラー。`n以下のアイテム名用のファイルがフォルダになっている`nフォルダのパス`n" . scriptFile)
		return returnValue
	}
	res := frfnf_makeOneItemFromTextFileName(scriptFile, categoryDir, itemCategoryDir)
	if( res ){
		returnValue = 1
		if( newFlag ){
			returnValue = 2
		}
	}
	return returnValue
}

cen_itemReloadOneFromFileName(com2, com3, com4, GuiNum){
	str =
(LTrim
fromFileName のアイテムを一つだけ読み込む。
引数１  直下のカテゴリーフォルダ
引数２  アイテムのカテゴリーフォルダ
引数３  アイテム名

引数が２つの場合、fromFileName直下のカテゴリーフォルダ と アイテム名 の指定として扱う。アイテムのカテゴリーフォルダは無いアイテムとして扱う。
引数が１つの場合、アイテム名のみの指定として扱う。
)
	if( edc_helpViewIfHyphenH(str, com2, GuiNum) ){
		return
	}
	if(com2 == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	itemName = %com4%
	itemCategoryDir = %com3%
	categoryDir = %com2%
	; 引数３が無いなら、引数２がアイテム名になる
	; アイテムのカテゴリーフォルダは無い事になる
	if(com4 == ""){
		itemName = %com3%
		itemCategoryDir =
		categoryDir = %com2%
	}

	; 引数２が無いなら、引数１がアイテム名になる
	if(com3 == ""){
		itemName = %com2%
		;itemCategoryDir =
		categoryDir =
	}

	returnNum := cen_itemReloadOneFromFileNameLogic(itemName, itemCategoryDir, categoryDir, "&itemReloadOneFromFileName")
	if( returnNum == 1 ){
		guit_setExplain(itemName . " のアイテムを編集した", GuiNum)
	} else if( returnNum == 2 ){
		guit_setExplain(itemName . " のアイテムを新規登録した", GuiNum)
	} else if( returnNum == 3 ){
		guit_setExplain("エラーあり。`n" . itemName . " のアイテムは削除されている", GuiNum)
	}
}

; アイテムだけを全て最初から読み込み直す
cen_itemReloadAll(rightStr, GuiNum){
	str := "アイテムだけを全て最初から読み込み直す。`nアイテム登録のウインドウから登録した物と、fromFileNameから登録した物を再び読み込む。`nなので、&newItemFromCommand から登録した物は読み込めない"
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}

	glob_softObj := Object()
	glob_folderObj := Object()
	glob_itemCommandObj := Object()
	glob_multipleObj := Object()

	init_itemObjSetting(True)
	init_itemObjSetting(False)
	init_multipleObjSetting(True)
	init_multipleObjSetting(False)
	frfnf_setAllItemOnlyFromFileName()
	guit_appendExplain("アイテムを全て読み込み直した")
}

cen_selectFolderButton(pControl, GuiNum){
	FileSelectFolder, OutputVar, %A_WorkingDir%, 3, フォルダの選択
	if(OutputVar != ""){
		guf_setControl( OutputVar, pControl, GuiNum )
	}
}

cen_relativButton(pControl, GuiNum){
	file := guf_getControl( pControl, GuiNum )
	if(file == ""){
		return
	}
	file := outs_textOutTrimss(file)
	; C:\ などが違った場合は何もしない。
	SplitPath, A_ScriptDir , , , , , curDrive
	SplitPath, file , , , , , targetDrive
	if(curDrive == targetDrive){
		relativ := outs_absolePathToRelativPath(A_ScriptDir , file, A_LineFile, A_LineNumber)
		str := "%A_ScriptDir%\"  . relativ
	} else {
		str := file
	}
	guf_setControl( str, pControl, GuiNum )
}

cen_absoleButton(pControl, GuiNum){
	file := guf_getControl( pControl, GuiNum )
	if(file == ""){
		return
	}
	file := outs_textOutTrimss(file)
	str := outs_relativePathToAbsolutePath(file, A_ScriptDir, LineFile, LineNumber, False)
	guf_setControl( str, pControl, GuiNum )
}

; アイテムの登録などの表示に使用。
cen_anyFileEntryDisplay(str1, str2){
	guit_appendExplain(str1 . "`n" . str2)
	;TrayTip, %str1%, %str2%, 5
}

; outputの設定が変えられていたら、引き継がせるため、Trueを返す
cen_outPutSucceedFlagTrueIfNotBasic(){
	if( glob_outputChangeNum == 1 ){
		return False
	}
	return True
}

; エラーだった場合、元のファイル名を返す
cen_getScriptBeforeExeSoftItem(key, openValueName, basisStr){
	optionObj := glob_softObj[key]
	pathStr := outs_textOutDqAllTrim(optionObj[1])
	pathStr := outs_relativeToAbsoluteFromWorkDir(pathStr,  A_LineFile, A_LineNumber, False)
	if( func_myFileNotExit(pathStr) ){
		guit_errorAppend(openValueName . "  のエラー`nソフトのファイルが存在しない`n" . key . "`nファイル`n" . pathStr)
		return basisStr
	}
	StringLower, tmpStr, pathStr
	StringGetPos, count, tmpStr, . ,R1
	StringTrimLeft, suffix, tmpStr, %count%
	if(suffix == ".exe"){
		return pathStr
	}
	guit_errorAppend(openValueName . "  のエラー`nファイルがソフトの拡張子ではない`n" . key . "`nファイル`n" . pathStr)
	return basisStr
}

cen_getArgssBeforeExeSoftItem(key, rightStr){
	;  " " でくくる
	dbQuoute := """"
	rightStr := dbQuoute . rightStr . dbQuoute

	optionObj := glob_softObj[key]
	; 引数の処理工夫
	argss := heard_itemArgssUse_Cust(optionObj[2], rightStr, "")
	if(optionObj[8] == 1){
		; ""で囲む設定のアイテムなら O_spaceFileNotFlag の設定がどうであれ、空白のあるファイルを自動で判別させる
		argss := heard_fileAllAbsoluteOrDbQuoute(argss, A_LineFile, A_LineNumber, True, glob_iniAbsolePathNotFlag)
	} else if(glob_iniAbsolePathNotFlag == False){
		;if(glob_iniSpaceFileNotFlag == False){
		if(O_spaceFileNotFlag == False){
			; ""で囲む設定ではないが、空白のファイルを自動判別
			argss := heard_fileAllAbsoluteOrDbQuoute(argss, A_LineFile, A_LineNumber, False, glob_iniAbsolePathNotFlag)
		} else {
			; ""で囲む設定でなく、空白のファイルを自動判別もしないが、絶対パスにはする
			argss := heard_absoluteAllEasy(argss, A_LineFile, A_LineNumber)
		}
	}
	return argss
}

cen_getWorkDirBeforeExeSoftItem(key){
	optionObj := glob_softObj[key]
	workDir := outs_textOutDqAllTrim(optionObj[3])
	workDir := outs_relativeToAbsoluteFromWorkDir(workDir,  A_LineFile, A_LineNumber, False)
	if(workDir == ""){
		workDir = %A_WorkingDir%
	}
	return workDir
}

cen_openMethodChangeFromVar(optionOpenSoftVar, optionVarName, textStr, targetSuffix){
	if( optionOpenSoftVar == "" ){
		return False
	}

	; .txt など拡張子がついたフォルダの場合に対処
	if( func_isFolder(textStr) ){
			return False
	}
	; ソフトパス と 引数（ファイルパス）の組み合わせはスルーする
	if( func_myFileNotExit(textStr) ){
		return False
	}

	StringLower, tmpStr, textStr
	StringGetPos, count, tmpStr, . ,R1
	StringTrimLeft, suffix, tmpStr, %count%
	if(suffix == targetSuffix){
		res := cen_keyWordIsObjectNumber(optionOpenSoftVar)
		if(res == 1) {
			return True
		} else {
			guit_errorAppend(optionVarName . "  のエラー`nソフト名以外は使用できない`n" . optionOpenSoftVar)
		}
	}
	return False
}

cen_openFolderMethodChangeFromFolderVar(runPath){
	if( O_folderOpenSoftItem == "" ){
		return False
	}

	if( func_isFolder(runPath) ){
		res := cen_keyWordIsObjectNumber(O_folderOpenSoftItem)
		if(res == 1) {
			return True
		} else {
			guit_errorAppend("O_folderOpenSoftItem  のエラー`nソフト名以外は使用できない`n" . O_folderOpenSoftItem)
		}
	}
	return False
}

; ErrorLevel_TextRunRun に代入するだけ。 through0Flag が True なら、ErrorLevel が 1 以上の時のみ代入する
cen_setOnlyErrorLevel_TextRunRun(through0Flag){
	if( through0Flag ){
		if(ErrorLevel >= 1){
			ErrorLevel_TextRunRun = %ErrorLevel%
		}
	} else {
		ErrorLevel_TextRunRun = %ErrorLevel%
	}
}

cen_userMakeWordAdd(com2, com3, GuiNum){
	str := "addWordList.txt によって加えた入力補完の候補をさらに追加する。引数1  追加する文字`n引数2  説明文"
	if( edc_helpViewIfHyphenH(str, com2, GuiNum) ){
		return
	}
	if(com2 == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}

	IfInString, com3, ###n
	{
		StringReplace, com3, com3, ###n , `n, All
	}

	glob_userMakeWordObj.Insert(com2, com3)
	guit_setExplain(com2 . "`nを入力補完に追加した", GuiNum)
}

cen_userMakeWordObjSetting(wordFile){

	division := "///"
	command =
	explanation =
	Loop, Read, %wordFile%
	{
		tmpStr := A_LoopReadLine
		IfInString, tmpStr, %division%
		{
			StringGetPos, index, tmpStr, %division%
			StringLeft, command, tmpStr, index
			index := index + 3
			StringTrimLeft, explanation, tmpStr, index
			IfInString, explanation, ###n
			{
				StringReplace, explanation, explanation, ###n , `n, All
			}
			command := LTrim( command )
			explanation := Trim(explanation)
		} else {
			command := LTrim( tmpStr )
			explanation := ""
		}
		if(command != ""){
			glob_userMakeWordObj.Insert(command, explanation)
		}
	}
}

cen_userMakeWordAddFromFile(rightStr, GuiNum){
	str := "addWordList.txt によって加えた入力補完の候補をさらに追加する。指定したファイルから読み込んで追加する"
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}
	if(rightStr == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}

	if( func_myFileNotExit(rightStr) ){
		guit_errorAppend("&addWordListAddFromFile  のエラー`nファイルが存在しない`n" . rightStr)
		return
	}
	if( outs_similarTxtFile(rightStr) == False ){
		guit_errorAppend("&addWordListAddFromFile  のエラー`nこのファイルは拡張子の問題で読み込むのを中止する`n" . rightStr)
		return
	}

	cen_userMakeWordObjSetting(rightStr)
	res := guit_checkErrorLevelOutput("&addWordListAddFromFile  のエラー`n何かのエラーがある`n" . rightStr)
	if( res ){
		guit_setExplain(rightStr . "`nのファイルの文字を入力補完に追加した", GuiNum)
	}
}

cen_snippetAddFromFileSetting(snippetFile, fileNameOnly){

	division := "///"
	command =
	sentence =
	tmpSentence =
	Loop, Read, %snippetFile%
	{
		tmpStr := A_LoopReadLine
		IfInString, tmpStr, %division%
		{
			StringGetPos, index, tmpStr, %division%
			StringLeft, command, tmpStr, index
			index := index + 3
			StringTrimLeft, sentence, tmpStr, index
			command := Trim(command)
			tmpSentence := Trim(sentence)
			if(command != ""){
				if(tmpSentence != ""){
					cen_snippetObjInsert(command, sentence, False, 4, fileNameOnly, "")
				}
			}
		}
	}
}

cen_snippetAddFromFile(rightStr, GuiNum){
	str := "簡易入力を追加する。ファイルを読み込む。`naddWordList.txt  と同じ様な書式で記入したファイルを読み込む。`n一行に付き１つ追加する。`n/// の文字の後に展開する文字を指定する。"
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}
	if(rightStr == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}

	if( func_myFileNotExit(rightStr) ){
		guit_errorAppend("&snippetAddFromFile  のエラー`nファイルが存在しない`n" . rightStr)
		return
	}
	if( outs_similarTxtFile(rightStr) == False ){
		guit_errorAppend("&snippetAddFromFile  のエラー`nこのファイルは拡張子の問題で読み込むのを中止する`n" . rightStr)
		return
	}

	SplitPath, rightStr , fileNameOnly
	cen_snippetAddFromFileSetting(rightStr, fileNameOnly)
	res := guit_checkErrorLevelOutput("&snippetAddFromFile  のエラー`n何かのエラーがある`n" . rightStr)
	if( res ){
		guit_setExplain(rightStr . "`nのファイルの内容を簡易入力に追加した", GuiNum)
	}
}

cen_snippetObjInsert(key, sentence, spaceFlag, fileFlag, fileNameOnly, categoryDir){
	optionObj := Object()
	optionObj.Insert(1, sentence)
	optionObj.Insert(2, fileFlag)
	optionObj.Insert(3, spaceFlag)
	optionObj.Insert(4, fileNameOnly)
	;optionObj.Insert(5, categoryDir)

	glob_snippetObj.Insert(key, optionObj)
}

; 設定しだいで、Guiのタイトルを取り除く
cen_removeBorderFromCommTitleFlag(GuiNum){
	if(glob_needReloadIniCommTitleNotFlag){
		Gui, %GuiNum%:-Border
	}
}

; 設定したフォントのサイズとDPI（PCの解像度）によって、取得する値が変えられる。
cen_fontNumFromDpiAndFontSize(lessThan110, lessThan140, moreThan140){
	plus = 0
	if(StO_fontSizeAllOption == 1){
		plus := -3
	} else if(StO_fontSizeAllOption == 2){
		plus := -2
	} else if(StO_fontSizeAllOption == 3){
		plus := -1
	} else if(StO_fontSizeAllOption == 5){
		plus := 1
	} else if(StO_fontSizeAllOption == 6){
		plus := 2
	} else if(StO_fontSizeAllOption == 7){
		plus := 3
	} else if(StO_fontSizeAllOption == 8){
		plus := 4
	}
	lessThan110 += plus
	lessThan140 += plus
	moreThan140 += plus
	returnValue := guaf_anyOfNumFromDpi(lessThan110, lessThan140, moreThan140)
	return returnValue
}

; 設定したフォントのサイズとDPI（PCの解像度）によって、取得する値が変えられる。
; variationNum にフォントのサイズによっておこる小さな変化を起こす値を入れる。
cen_anyOfNumFromDpiAndFontSize(variationMinus, variationPlus, lessThan110, lessThan140, moreThan140){
	plus = 0
	if(StO_fontSizeAllOption == 1){
		plus := variationMinus * -3
	} else if(StO_fontSizeAllOption == 2){
		plus := variationMinus * -2
	} else if(StO_fontSizeAllOption == 3){
		plus := variationMinus * -1
	} else if(StO_fontSizeAllOption == 5){
		plus := variationPlus
	} else if(StO_fontSizeAllOption == 6){
		plus := variationPlus * 2
	} else if(StO_fontSizeAllOption == 7){
		plus := variationPlus * 3
	} else if(StO_fontSizeAllOption == 8){
		plus := variationPlus * 4
	}
	lessThan110 += plus
	lessThan140 += plus
	moreThan140 += plus
	returnValue := guaf_anyOfNumFromDpi(lessThan110, lessThan140, moreThan140)
	return returnValue
}

; アイコンがあるかチェックして、あればアイコンを変える。なければ、AutoHotKeyのアイコンで切り替わるようにする。
cen_trayIconChangeFixation(iconFile){
	if( func_extensionConfirm(iconFile, "ico") ){
		Menu, Tray, Icon, %iconFile%, , 1
	} else {
		cen_iconNameFileCheck()
		Menu, Tray, Icon, %glob_iconName%, , 0
	}
}

; SuspendとPauseの状態を確認してアイコンを変える。
; 決められたアイコンがあるかチェックして、あればアイコンを変える。
cen_trayIconChangeFromSuspendOrPause(){
	iconFile =
	if( A_IsSuspended == 1 ){
		if( A_IsPaused == 1 ){
			iconFile := gloco_docDir . glob_pauseSuspendIconName
		} else {
			iconFile := gloco_docDir . glob_suspendIconName
		}
	} else if( A_IsPaused == 1 ){
		iconFile := gloco_docDir . glob_pauseIconName
	} else {
		iconFile := glob_iconName
	}
	cen_trayIconChangeFixation(iconFile)
}

; Pauseの前に使う。サブルーチンが停止する前にアイコンを変えるため。
cen_trayPauseIconChangeBefore(){
	iconFile =
	if( A_IsPaused == 0 ){
		iconFile := gloco_docDir . glob_pauseIconName
		if( A_IsSuspended == 1 ){
			iconFile := gloco_docDir . glob_pauseSuspendIconName
		}
		cen_trayIconChangeFixation(iconFile)
	}
}

; デフォルトのアイコンに使うファイルがあるかチェック。なければスクリプトパスのアイコンを使う
cen_iconNameFileCheck(){
	if( func_myFileNotExit(glob_iconName) ){
		if(A_IsCompiled == 1){
			glob_iconName := A_ScriptFullPath
		} else {
			glob_iconName := A_AhkPath
		}
	}
}

