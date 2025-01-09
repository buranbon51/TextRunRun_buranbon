; 必須 glob guf edi func


init_checkFileAndFolderMakeFolderAndFile(){
	func_easyFolderCheckMakeFolder(gloco_userDir . glob_userTmpDirName)
	func_easyFolderCheckMakeFolder(gloco_userDir . glob_userItemDirName)
	func_easyFolderCheckMakeFolder(gloco_userDir . glob_userTmpTmpItemDirName)
	func_easyFolderCheckMakeFolder(gloco_userDir . glob_userHotKeyItemDirName)
	func_easyFolderCheckMakeFolder(gloco_userDir . glob_userTmpHotkeyItemDirName)
	func_easyFolderCheckMakeFolder(gloco_docDir)
	func_easyFolderCheckMakeFolder(glob_addListDir)
	;func_easyFolderCheckMakeFolder(glob_defaultDir)
	;init_fileExistAdvice(gloco_docDir . glob_syscommFileName)
	;init_fileExistAdvice(gloco_docDir . glob_specialWordFileName)
	;init_fileExistAdvice(gloco_docDir . glob_ahkCommFileName)
	;init_fileExistAdvice(gloco_docDir . glob_variableFileName)
	glob_SHELL32DLL := init_fileNotExistReturnNull(glob_SHELL32DLL)
	;glob_iconName := init_fileNotExistReturnNull(glob_iconName)

	;init_userFileCheck()
	;init_userFileCheck()の後にしないと、defaultからコピーできない。
	; fromFileName関係
	firstFfnDir = %glob_fromFileNameDir%\%glob_firstFfnDirNameOnly%
	IfNotExist, %firstFfnDir%
	{
		itemFromFileNameDir = %glob_fromFileNameDir%\%glob_firstFfnDirNameOnly%%glob_itemFfnDirName%
		func_easyFileCheckMakeFolderAndFile(itemFromFileNameDir . "\sampleItem\script.txt", itemFromFileNameDir . "\sampleItem", "&newItem`n&hotkeyOnTextNew")
		func_easyFileCheckMakeFolderAndFile(itemFromFileNameDir . "\sampleItem\configure.txt", itemFromFileNameDir . "\sampleItem", "[ comment`ntype=4`ndoubleQuout=0`nargument=`nworkingFolder=`niconFile=`niconNumber=1`nexplanation=説明文###nと改行")
		onTextDir = %glob_fromFileNameDir%\%glob_firstFfnDirNameOnly%%glob_hotkeyOnTextFfnDirName%
		func_easyFileCheckMakeFolderAndFile(onTextDir . "\Ctrl_Alt_Shift_Enter.txt", onTextDir, "Gosub, E_showEverInputGuiToggle %--")
		startupDir = %glob_fromFileNameDir%\%glob_firstFfnDirNameOnly%%glob_startupFfnDirName%
		func_easyFolderCheckMakeFolder(startupDir)
	}

	if(A_IsCompiled != 1){
		semicolon := "`;"
		cen_fileCheckMakeFolderAndFileUtf8(glob_userMakeStartExeFile, glob_userMakeScriptDir, semicolon . " ソースコード版のみで有効。起動時に実行する処理を記述する`n")
		cen_fileCheckMakeFolderAndFileUtf8(glob_userMakeSubFuncFile, glob_userMakeScriptDir, semicolon . " ソースコード版のみで有効。サブルーチンや関数を記述する。`n")
		; Plugins のファイルを作る
		cen_fileCheckMakeFolderAndFileUtf8(glob_pluginsStartUpExeFile, glob_pluginsDir, semicolon . " ソースコード版のみで有効。起動時に実行する処理を記述する`n")
		cen_fileCheckMakeFolderAndFileUtf8(glob_pluginsSubAndFuncFile, glob_pluginsDir, semicolon . " ソースコード版のみで有効。サブルーチンや関数を記述する。`n")
	}
	func_easyFileCheckMakeFolderAndFile(glob_addListDir . glob_addWordListName, glob_addListDir, "word1/// 説明文###nが改行`nword2`nword3`n")
}

/*
init_userFileCheck(){
	;user
	init_userFileCheckAndMakeFromDefault(glob_checkListFileName)
	init_userFileCheckAndMakeFromDefault(glob_configFileName)
	init_userFileCheckAndMakeFromDefault(glob_historyListFileName)
	init_userFileCheckAndMakeFromDefault(glob_commStockFile77Name)
	init_userFileCheckAndMakeFromDefault(glob_commStockFile78Name)
	init_userFileCheckAndMakeFromDefault(glob_outputFileName)
	init_userFileCheckAndMakeFromDefault(glob_errorOutputFileName)
	init_userFileCheckAndMakeFromDefault(glob_defaultLogFileName)
	init_userFileCheckAndMakeFromDefault(glob_lastWordExeConfigFileName)
	init_userFileCheckAndMakeFromDefault(glob_needReloadConfigFileName)
	;item
	init_userFileCheckAndMakeFromDefault(glob_commandFileName)
	init_userFileCheckAndMakeFromDefault(glob_commandListFileName)
	;hotKeyItem
	init_userFileCheckAndMakeFromDefault(glob_hotkeyItemListName)
	init_userFileCheckAndMakeFromDefault(glob_hotkeyItemIniFileName)
	;temp
	init_userFileCheckAndMakeFromDefault(glob_tmpAhkGuiSizePosFileName)
	;tempItem
	init_userFileCheckAndMakeFromDefault(glob_tmpCommandFileName)
	init_userFileCheckAndMakeFromDefault(glob_tmpCommandListFileName)
	;tmpHotkeyItem
	init_userFileCheckAndMakeFromDefault(glob_tmpHotkeyItemListName)
	init_userFileCheckAndMakeFromDefault(glob_tmpHotkeyItemIniFileName)
	;userMakeScript
	init_userFileCheckAndMakeFromDefault(glob_userMakeStartExeFile)
	init_userFileCheckAndMakeFromDefault(glob_userMakeSubFuncFile)
}
*/

init_fileExistAdvice(file){
	IfNotExist, %file%
	{
		init_appendStartUpErrorBuff(file  . "  が見つからない")
	}
}

init_fileNotExistReturnNull(file){
	IfNotExist,  %file%
	{
		returnValue := ""
		Return  returnValue
	}
	Return  file
}

; userないのファイルがないならデフォルトのファイルをコピー
/*
init_userFileCheckAndMakeFromDefault(excludeUserDirFileName){
	file := gloco_userDir . excludeUserDirFileName
	if( func_myFileExist(file) == False ){
		fileinDrfault := glob_defaultDir . excludeUserDirFileName
		; デフォルトのファイルがあればコピーする。なければ何もしない
		if( func_myFileExist(fileinDrfault) == True ){
			FileCopy, %fileinDrfault%, %file% , 0
			res := init_checkErrorLevelStartUpBuff("defaultからのコピーに失敗がある`n    " . excludeUserDirFileName)
			if( res ){
				init_appendStartUpBuff(fileinDrfault . " を " . file . " に コピーした")
			}
		}
	}
}
*/

;Subroutine1 から Subroutine30 までの空のアイテムを登録する
; 現在はセーブの問題があるので、あきらめて使わない
/*
init_forItemSubroutinesInsert(){
	itemName =
	Loop , 30
	{
		itemName := "Subroutine" . A_Index
		; すでにセーブされていたアイテムなら、加えない
		if( cen_keyWordIsObject(itemName) == False ){
			init_itemInsertToObj(itemName, "", "", "", "", 3, "", 1, 0, 0)
		}
	}
}
*/

init_itemInsertToObj(arg1, arg2, arg3, arg4, arg5, arg6, image="", iconNum=1, dbQuout=0, tmpItem=0) {
	optionObj := Object()
	optionObj.Insert(1, arg2)
	optionObj.Insert(2, arg3)
	optionObj.Insert(3, arg4)
	optionObj.Insert(4, arg5)
	optionObj.Insert(5, arg6)
	optionObj.Insert(6, image)
	optionObj.Insert(7, iconNum)
	optionObj.Insert(8, dbQuout)
	optionObj.Insert(9, tmpItem)
	optionObj.Insert(10, 1)
	; カテゴリーフォルダ
	optionObj.Insert(11, "")
	optionObj.Insert(12, "")

	if(arg6 == 1) {
		glob_softObj.Insert(arg1, optionObj)
	} else if (arg6 ==  2) {
		glob_folderObj.Insert(arg1, optionObj)
	} else if (arg6 ==  3) {
		glob_itemCommandObj.Insert(arg1, optionObj)
	} else {
		;glob_multipleObj.Insert(arg1, optionObj)
	}
}

init_itemObjSetting(tmpFileFlag) {

	; 一時的に保存のか、普通のに保存かを分ける
	commandFile := gloco_userDir . glob_commandFileName
	commandListFile := gloco_userDir . glob_commandListFileName
	out9 = 0
	if(tmpFileFlag){
		commandFile := gloco_userDir . glob_tmpCommandFileName
		commandListFile := gloco_userDir . glob_tmpCommandListFileName
		out9 = 1
	}

	Loop, Read, %commandListFile%
	{
		IniRead, out1, %commandFile%, %A_LoopReadLine%, pathUrl,    -1
		if(out1 != -1) {
			IniRead, out2, %commandFile%, %A_LoopReadLine%, argss
			IniRead, out3, %commandFile%, %A_LoopReadLine%, workingdir
			IniRead, out4, %commandFile%, %A_LoopReadLine%, explanation
			IniRead, out5, %commandFile%, %A_LoopReadLine%, category, 1
			IniRead, out6, %commandFile%, %A_LoopReadLine%, imagePath
			IniRead, out7, %commandFile%, %A_LoopReadLine%, iconNum, 1
			IniRead, out8, %commandFile%, %A_LoopReadLine%, fileDbQuout, 0
			IfInString, out4, ###n
			{
				StringReplace, out4, out4, ###n , `n, All
			}
			init_itemInsertToObj(A_LoopReadLine, out1, out2, out3, out4, out5, out6, out7, out8, out9)
		}
	}
}

init_multipleObjSetting(tmpFileFlag) {
	listFile := gloco_userDir . glob_scriptsItemListName
	iniFile := gloco_userDir . glob_scriptsItemName
	scriptsTextDir := gloco_userDir . glob_scriptsTextDirName
	tmpItem = 0
	; 一時的に保存のか、普通のに保存かを分ける
	if(tmpFileFlag){
		listFile := gloco_userDir . glob_tmpScriptsItemListName
		iniFile := gloco_userDir . glob_tmpScriptsItemName
		scriptsTextDir := gloco_userDir . glob_tmpScriptsTextDirName
		tmpItem = 1
	}

	Loop, Read, %listFile%
	{
		textFile := scriptsTextDir . "\" . A_LoopReadLine . ".ahk"
		FileRead, scripts, %textFile%
		if(scripts != "") {
			IniRead, out1, %iniFile%, %A_LoopReadLine%, explanation
			IfInString, out1, ###n
			{
				StringReplace, out1, out1, ###n , `n, All
			}
			IniRead, out2, %iniFile%, %A_LoopReadLine%, imagePath
			IniRead, out3, %iniFile%, %A_LoopReadLine%, iconNum, 1
			musc_multipleScriptstToObj(A_LoopReadLine, scripts, out1, out2, out3, tmpItem)
		}
	}
}

/*		もう使わないからコメントにする
init_sysCommObjSetting(){
	division := "///"
	command =
	explanation =
	syscommFile := gloco_docDir . glob_syscommFileName
	Loop, Read, %syscommFile%
	{
		IfInString, A_LoopReadLine, %division%
		{
			StringGetPos, index, A_LoopReadLine, %division%
			StringLeft, command, A_LoopReadLine, index
			index := index + 3
			StringTrimLeft, explanation, A_LoopReadLine, index
			IfInString, explanation, ###n
			{
				StringReplace, explanation, explanation, ###n , `n, All
			}
			command := Trim(command)
			explanation := Trim(explanation)
		} else {
			command := Trim(A_LoopReadLine)
			explanation := ""
		}
		if(command != ""){
			glob_sysCommObj.Insert(command, explanation)
		}
	}
}

init_specialWordObjSetting(){
	specialWordFile := gloco_docDir . glob_specialWordFileName
	Loop, Read, %specialWordFile%
	{
		command := Trim(A_LoopReadLine)
		if(command != ""){
			glob_specialWordObj.Insert(command)
		}
	}
}

init_variableWordObjSetting(){
	variableWordFile := gloco_docDir . glob_variableFileName
	Loop, Read, %variableWordFile%
	{
		command := Trim(A_LoopReadLine)
		if(command != ""){
			glob_variableWordObj.Insert(command)
		}
	}
}

init_ahkCommObjSetting(){
	ahkCommFile := gloco_docDir . glob_ahkCommFileName
	Loop, Read, %ahkCommFile%
	{
		command := Trim(A_LoopReadLine)
		if(command != ""){
			glob_ahkCommObj.Insert(command)
		}
	}
}

*/

init_historyObjSetting(){
	;loopCount := glob_iniHistoryCount
	loopCount := O_textHistory
	file := gloco_userDir . glob_historyListFileName
	Loop, Read, %file%
	{
		glob_tmpHistoryObj.Insert(A_LoopReadLine)
		loopCount--
		if(loopCount <= 0){
			Break
		}
	}
	edi_historyObjSwap()
}

init_ahkCommObjMake(){

	clist := ahli_ahkCommList()

	Loop, Parse, clist , `n
	{
		command := Trim(A_LoopField)
		if(command != ""){
			glob_ahkCommObj.Insert(command)
		}
	}
}

init_specialWordObjMake(){

	clist := speli_specialWordList()

	division := "///"
	command =
	explanation =
	Loop, Parse, clist , `n
	{
		tmpStr := Trim(A_LoopField)
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
			command := Trim(command)
			explanation := Trim(explanation)
		} else {
			command := Trim(tmpStr)
			explanation := ""
		}
		if(command != ""){
			glob_specialWordObj.Insert(command, explanation)
		}
	}
}

init_variableWordObjMake(){

	clist := varli_variableList()

	Loop, Parse, clist , `n
	{
		command := Trim(A_LoopField)
		if(command != ""){
			glob_variableWordObj.Insert(command)
		}
	}
}

init_userVariableWordObjMake(){

	clist := usvali_userVariableList()

	Loop, Parse, clist , `n
	{
		command := Trim(A_LoopField)
		if(command != ""){
			glob_userVariableWordObj.Insert(command)
		}
	}
}

init_optionVariableWordObjMake(){

	clist := opvali_optionVariableList()

	division := "///"
	command =
	explanation =
	Loop, Parse, clist , `n
	{
		tmpStr := Trim(A_LoopField)
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
			command := Trim(command)
			explanation := Trim(explanation)
		} else {
			command := Trim(tmpStr)
			explanation := ""
		}
		if(command != ""){
			glob_optionVariableWordObj.Insert(command, explanation)
		}
	}
}

init_optionSetterFuncWordObjMake(){

	clist := opsefli_optionSetterFuncList()

	Loop, Parse, clist , `n
	{
		command := Trim(A_LoopField)
		if(command != ""){
			glob_optionSetterFuncWordObj.Insert(command)
		}
	}
}

init_snippetObjSetting(){

	listFile := gloco_userDir . glob_snippetListFileName
	iniFile := gloco_userDir . glob_snippetFileName

	Loop, Read, %listFile%
	{
		IniRead, out1, %iniFile%, %A_LoopReadLine%, sentence,    -1
		if(out1 != -1) {
			IniRead, out2, %iniFile%, %A_LoopReadLine%, spaceFlag
			cen_snippetObjInsert(A_LoopReadLine, out1, out2, 1, "", "")
		}
	}
}

init_sysCommObjMake(){

	clist := sysli_sysComList()

	division := "///"
	command =
	explanation =
	Loop, Parse, clist , `n
	{
		tmpStr := Trim(A_LoopField)
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
			command := Trim(command)
			explanation := Trim(explanation)
		} else {
			command := Trim(tmpStr)
			explanation := ""
		}
		if(command != ""){
			glob_sysCommObj.Insert(command, explanation)
		}
	}
}

init_hotkeyItemObjSetting(tmpItem){

	; 一時的に保存のか、普通のに保存かを分ける
	file := gloco_userDir . glob_hotkeyItemListName
	iniFile := gloco_userDir . glob_hotkeyItemIniFileName
	if(tmpItem == 1){
		file := gloco_userDir . glob_tmpHotkeyItemListName
		iniFile := gloco_userDir . glob_tmpHotkeyItemIniFileName
	}

	Loop, Read, %file%
	{
		IniRead, out1, %iniFile%, %A_LoopReadLine%, exeScriptKey,    -1
		if(out1 != -1) {
			IniRead, out2, %iniFile%, %A_LoopReadLine%, explanationKey
			IfInString, out2, ###n
			{
				StringReplace, out2, out2, ###n , `n, All
			}
			hotk_entryKeyOnTextCommandLogic(A_LoopReadLine, out1, out2, tmpItem, 1, "", 63)
		}
	}
}

init_appendStartUpBuff(append){
	glob_startUpBuff .= append . "`n"
}

init_appendStartUpErrorBuff(append){
	glob_startUpErrorBuff .= append . "`n"
}

init_checkErrorLevelStartUpBuff(append="") {
	if(ErrorLevel >= 1  && ErrorLevel < 5){
		init_appendStartUpErrorBuff("ErrorLevel   " . ErrorLevel  . "`n" . append)
		ErrorLevel = 0
		return False
	}
	return True
}

init_startUpBuffOutput(){
	if(glob_startUpBuff != ""){
		guit_appendExplainWithoutTime(glob_startUpBuff)
	}
}

init_startUpErrorBuffOutput(){
	if(glob_startUpErrorBuff != ""){
		time := func_getHourMinSec()
		guit_appendBoxEdit67_1Cust(time  . "`n" . glob_startUpErrorBuff)
	}
}

; init_commShortcatKeySettingより前に使用すること
init_commWinTitleSet(){
	glob_reloadIniCommWinTitle := Trim(glob_reloadIniCommWinTitle)
	if(glob_reloadIniCommWinTitle != ""){
		gGlob_GuiAllTitle := "__" . glob_reloadIniCommWinTitle . "_TextRunRun"
	}
	oneLineTextTitle := "テキスト"
	textSplitTitle := "ブンカツ"
	if(glob_reloadIniOneLineTextTitle != ""){
		oneLineTextTitle = %glob_reloadIniOneLineTextTitle%
	}
	if(glob_reloadIniTextSplitTitle != ""){
		textSplitTitle = %glob_reloadIniTextSplitTitle%
	}

	gGlob_GuiTextNearTitle := gGlob_GuiAllTitle . "_in"
	gGlob_GuiCommandTitle := gGlob_GuiTextNearTitle . "put_"
	gGlob_GuiTextSplitTitle := gGlob_GuiCommandTitle . textSplitTitle
	;gGlob_oneLineTextTitle := gGlob_GuiCommandTitle . "テキスト"

	gGlob_Gui61Title := gGlob_GuiTextSplitTitle . "1"
	gGlob_Gui62Title := gGlob_GuiTextSplitTitle . "2"
	gGlob_Gui66Title := "蓄え式_説明_" . gGlob_GuiAllTitle
	gGlob_Gui72Title := gGlob_GuiTextNearTitle . "アイテムの登録"
	gGlob_Gui73Title := "アイテム一覧_" . gGlob_GuiAllTitle
	gGlob_Gui68Title := "説明表示（一時的）_" . gGlob_GuiAllTitle
	;gGlob_Gui63Title := gGlob_oneLineTextTitle . "1"
	gGlob_Gui63Title := gGlob_GuiCommandTitle . oneLineTextTitle . "1"
	;gGlob_Gui64Title := gGlob_oneLineTextTitle . "2"
	gGlob_Gui64Title := gGlob_GuiCommandTitle . oneLineTextTitle . "2"
	gGlob_Gui88Title := "カウントダウン" . gGlob_GuiAllTitle
	gGlob_Gui74Title := "設定" . gGlob_GuiAllTitle
	gGlob_Gui77Title := "ストック1_Ctrl＋数字_" . gGlob_GuiAllTitle
	gGlob_Gui78Title := "ストック2_Shift＋Ctrl＋数字_" . gGlob_GuiAllTitle
	;gGlob_Gui65Title := gGlob_oneLineTextTitle . "3"
	gGlob_Gui65Title := gGlob_GuiCommandTitle . oneLineTextTitle . "3"
	gGlob_Gui87Title := "_タイマー一覧" . gGlob_GuiAllTitle
	gGlob_Gui67Title := "エラー表示_" . gGlob_GuiAllTitle
	gGlob_Gui69Title := "ファイル表示用_" . gGlob_GuiAllTitle
	gGlob_Gui75Title := "状態の確認" . gGlob_GuiAllTitle
	gGlob_Gui76Title := "マウス操作のためのウインドウ" . gGlob_GuiAllTitle
	gGlob_Gui84Title := "テキストの文字で自動的に実行" . gGlob_GuiAllTitle
	gGlob_Gui86Title := "userフォルダに加えない設定" . gGlob_GuiAllTitle
	gGlob_Gui85Title := "再起動が必要な設定" . gGlob_GuiAllTitle
	gGlob_Gui79Title := "テキスト上のショートカットキー登録" . gGlob_GuiAllTitle
	gGlob_Gui80Title := "ショートカットキーの一覧" . gGlob_GuiAllTitle
	gGlob_Gui82Title := "二行以上のテキスト" . gGlob_GuiAllTitle
	gGlob_Gui83Title := "二行以上のスクリプトの登録" . gGlob_GuiAllTitle
	gGlob_Gui70Title := "入力補完" . gGlob_GuiAllTitle
	gGlob_Gui89Title := "入力補完の一覧" . gGlob_GuiAllTitle


	; ユーザーが使用する変数も、ここで代入する
	B_WinTitleText1 := gGlob_Gui63Title
	B_WinTitleText2 := gGlob_Gui64Title
	B_WinTitleText3 := gGlob_Gui65Title
	B_WinTitleTextSplit1 := gGlob_Gui61Title
	B_WinTitleTextSplit2 := gGlob_Gui62Title
	B_WinTitleMultipleText1 := gGlob_Gui82Title
	B_WinTitleStock1 := gGlob_Gui77Title
	B_WinTitleStock2 := gGlob_Gui78Title
	B_WinTitleClickWindow := gGlob_Gui76Title
	B_WinTitleOutput := gGlob_Gui66Title
	B_WinTitleErrorOutput := gGlob_Gui67Title
	B_WinTitleTmpOutput := gGlob_Gui68Title
	B_WinTitleReadFileOut := gGlob_Gui69Title
	B_WinTitleTimer := gGlob_Gui87Title
	B_WinTitleNoCloseTimer := gGlob_Gui88Title

	;アイコンのツールチップも変更する
	;Menu, Tray, Tip, %gGlob_GuiAllTitle%
}

init_commShortcatKeySetting(){
	if( glob_reloadIniExceptCommKeyOff == 0 ){
		hotk_exceptCommKeyStartup()
	}
	if( glob_reloadIniShortKeyOffFlag ){
		; ウインドウ指定をオフ
		Hotkey, IfWinActive
		guf_setControl( "Offの状態", "Text80_2_1", 80 )
		GuiControl, 80:+cFFB200, Text80_2_1
		return
	}
	hotk_commShortcatKeyStartup()
}

; このソフトを識別しやすくするための文字列を追加する
/*
init_discriminationTextInsert(){
	if( glob_reloadIniDiscriminationFlag ){
		if( glob_reloadIniDiscriminationText != "" ){
			Gui, 61:Font, S12
			Gui, 61:Add, Text, X150 Y3 cAA172E , %glob_reloadIniDiscriminationText%
			Gui, 62:Font, S12
			Gui, 62:Add, Text, X150 Y3 c00FF00 , %glob_reloadIniDiscriminationText%
			Gui, 66:Font, S12
			Gui, 66:Add, Text, X20 y+10 cAA172E , %glob_reloadIniDiscriminationText%
			Gui, 68:Font, S12
			Gui, 68:Add, Text, X20 y+10 c00D100 , %glob_reloadIniDiscriminationText%
			Gui, 63:Font, S12
			Gui, 63:Add, Text, X130 Y3 cAA172E , %glob_reloadIniDiscriminationText%
			Gui, 64:Font, S12
			Gui, 64:Add, Text, X130 Y3 cAA172E , %glob_reloadIniDiscriminationText%
			Gui, 74:Font, S12
			Gui, 74:Add, Text, X20 y+10 c00D100 , %glob_reloadIniDiscriminationText%
			Gui, 65:Font, S12
			Gui, 65:Add, Text, X130 Y3 cFF0000 , %glob_reloadIniDiscriminationText%
			Gui, 67:Font, S12
			Gui, 67:Add, Text, X20 y+10 c0000FF , %glob_reloadIniDiscriminationText%
			Gui, 75:Font, S12
			Gui, 75:Add, Text, X20 y+10 c00D100 , %glob_reloadIniDiscriminationText%
			Gui, 84:Font, S12
			Gui, 84:Add, Text, X20 y+10 c00D100 , %glob_reloadIniDiscriminationText%
			Gui, 86:Font, S12
			Gui, 86:Add, Text, X20 y+10 c00D100 , %glob_reloadIniDiscriminationText%
		}
	}
}
*/

init_showFromCommGuiOnlyFlag(){
	if( glob_reloadIniCommGuiOnlyFlag ){
		guf_showGuiAssign("63")
	}
}

init_textIconSetIfExistFile(){
	glob_stockNoneFile := outs_iconPictureEnyExtFile(gloco_docDir . glob_stockNoneName)
	glob_stockHaveFile := outs_iconPictureEnyExtFile(gloco_docDir . glob_stockHaveName)
	glob_textNoneFile := outs_iconPictureEnyExtFile(A_ScriptDir . glob_textNoneName)
	glob_textHaveFile := outs_iconPictureEnyExtFile(A_ScriptDir . glob_textHaveName)

	if( glob_stockHaveFile == "" ){
		; アイコンのサイズはあえて指定しない
		;glob_stockHaveFile := "*icon24 *w32 *h32 " . glob_SHELL32DLL
		glob_stockHaveFile := "*icon24 " . glob_SHELL32DLL
	}
	if( glob_textNoneFile == "" ){
		; アイコンのサイズはあえて指定しない
		;glob_textNoneFile := "*w32 *h32 " . glob_iconName
		glob_textNoneFile := glob_iconName
	}
	if( glob_textHaveFile == "" ){
		; アイコンのサイズはあえて指定しない
		;glob_textHaveFile := "*w32 *h32 " . glob_iconName
		glob_textHaveFile := glob_iconName
	}
}

init_snippetAddDefault(){
	cen_snippetObjInsert("g.sub", "G_subroutine", 0, 0, "", "")
	cen_snippetObjInsert("b.gui", "B_GuiNum", 0, 0, "", "")
	cen_snippetObjInsert("b.win", "B_WinTitle", 0, 0, "", "")
}

; 分割テキストとアイテム登録Ｇｕｉの幅の基準を決める
init_widthBasisCommboxAndEntryItem(){
	;GuiControlGet, edit1_, 61:Pos, Edit61_1
	;glob_commboxWidth := edit1_W + 24
	; アイテム登録の Tab2 の幅と同じにする
	tabW := cen_anyOfNumFromDpiAndFontSize(13, 27, 350, 320, 290)
	glob_entryItemWidth := tabW + 10
}

init_startUpOptionExecute(ahkArg1, ahkArg2, ahkArg3, ahkArg4, ahkArg5, ahkArg6, ahkArg7, ahkArg8, ahkArg9){
	parsentHyphen := "%--"
	; 起動時に引数がある場合
	if(ahkArg1 != "") {
		argsWord := "args="
		ahkArgAll := ahkArg1  . " " . ahkArg2  . " " . ahkArg3  . " " . ahkArg4  . " " . ahkArg5  . " " . ahkArg6  . " " . ahkArg7  . " " . ahkArg8  . " " . ahkArg9
		ahkArgAll := Trim(ahkArgAll)
		if(glob_iniStartUpOptionFlag == True){
			; 起動時に引数があり、かつ起動時に動作するコマンドがある場合

			; %-- のみなら、何もしない
			if(glob_iniStartUpOptionText == parsentHyphen){
				return
			}

			; args= の右の文字のみ取得
			paramComm := func_rightStrOrNullFromSearchStr(ahkArgAll, argsWord)
			if( paramComm == "" ){
				if(glob_iniStartUpOptionText == ""){
					; 何もしない。あえて「起動時に　　を実行」を表示させる
				} else {
					; 起動時１の処理がある場合は、args= の文字が無くてもいいようにする。
					paramComm = %ahkArgAll%
				}
			}

			strAll := heard_itemArgssLogic_Cust(glob_iniStartUpOptionText, paramComm, "")
			guit_appendExplainNotShow("起動時に`n" . strAll  . "`nを実行")
			edi_commandExeLogicWrapper(strAll, "", "", 71, null, True, True)
			guit_checkErrorLevelOutput_StartUp("引数を利用したスクリプトと起動時に設定したスクリプトでエラーあり`n" . strAll)
		} else {
			; args= の右の文字のみ取得
			paramComm := func_rightStrOrNullFromSearchStr(ahkArgAll, argsWord)
			if( paramComm == "" ){
				return
			}

			guit_appendExplainNotShow("起動時に`n" . paramComm  . "`nを実行")
			edi_commandExeLogicWrapper(paramComm, "", "", 71, null, True, True)
			guit_checkErrorLevelOutput_StartUp("引数を利用したスクリプトでエラーあり`n" . ahkArgAll)
		}
		; あとで設定するのでコメントにする
		;DetectHiddenWindows, Off
		return
	}

	; 起動時に動作するコマンドがある場合
	if(glob_iniStartUpOptionFlag == True){
		if(glob_iniStartUpOptionText == ""){
			return
		}
		; %-- のみなら、何もしない
		if(glob_iniStartUpOptionText == parsentHyphen){
			return
		}
		tmpStr := glob_iniStartUpOptionText
		; %-- が最後にあるなら、それだけ取り除く
		StringLen, strLength, glob_iniStartUpOptionText
		if(strLength >= 3){
			StringRight, right3Str, glob_iniStartUpOptionText, 3
			if(right3Str == parsentHyphen){
				; %--  の文字を消す
				StringTrimRight, tmpStr, glob_iniStartUpOptionText, 3
				;tmpStr := RTrim( tmpStr )
			}
		}

		guit_appendExplainNotShow("起動時に`n" . tmpStr  . "`n　　を実行")
		edi_commandExeLogicWrapper(tmpStr, "", "", 71, null, True, True)
		guit_checkErrorLevelOutput_StartUp("起動時に設定したスクリプトでエラーあり(オン・オフできる方)`n" . glob_iniStartUpOptionText)

		; あとで設定するのでコメントにする
		;DetectHiddenWindows, Off
	}
}

init_startUpOptionExecuteCommon(text){
	text := Trim(text)
	if(text != ""){
		;guit_appendExplainNotShow("起動時に`n" . text  . "`n　　を実行")
		edi_commandExeLogicWrapper(text, "", "", 71, null, True, True)
		guit_checkErrorLevelOutput_StartUp("起動時に設定したスクリプトでエラーあり`n" . text)
	}
}

; guinif_initGui88()のみ、例外にする
init_initGuiAll(){
	guinif_initGui61()
	guinif_initGui62()
	guinif_initGui66()
	guinif_initGui72()
	guinif_initGui73()
	guinif_initGui68()
	guinif_initGui63()
	guinif_initGui64()
	; guinif_initGui88()のみ、例外にする
	;guinif_initGui88()
	guinif_initGui74()
	guinif_initGui77()
	guinif_initGui78()
	guinif_initGui65()
	guinif_initGui87()
	guinif_initGui67()
	guinif_initGui69()
	guinif_initGui75()
	guinif_initGui76()
	guinif_initGui84()
	guinif_initGui86()
	guinif_initGui85()
	guinif_initGui79()
	guinif_initGui80()
	guinif_initGui81()
	guinif_initGui82()
	guinif_initGui83()
	guinif_initGui89()
	guinif_initGui70()
}

; userフォルダの変更など、早いうちに実行する関数
init_beforehandConfigRead(){
	IniRead, Output1, %glob_exceptionOfUserFile%, exceptionOfUser, userDirChangeFlag ,0
	if( Output1 == 1 ){
		IniRead, Output2, %glob_exceptionOfUserFile%, exceptionOfUser, userDir ,  %gloco_defaultUserDir%

		; userフォルダをここで変更する
		Output2 := outs_textOutDqAllTrim(Output2)
		gloco_userDir := outs_relativePathToAbsolutePath(Output2, A_ScriptDir, A_LineFile, A_LineNumber, False)
		gloco_userDir := RTrim( gloco_userDir, "\" )
		if( gloco_userDir == "" ){
			gloco_userDir := gloco_defaultUserDir
		}
		IniRead, Output3, %glob_exceptionOfUserFile%, exceptionOfUser, docDir ,  %gloco_defaultDocDir%

		glob_reloadIniUserDirChangeFlag = %Output1%

		Output3 := outs_textOutDqAllTrim(Output3)
		if(Output3 == ""){
			Output3 := gloco_defaultDocDir
		}
		gloco_docDir := outs_relativePathToAbsolutePath(Output3, A_ScriptDir, A_LineFile, A_LineNumber, False)
		gloco_docDir := RTrim( gloco_docDir, "\" )
	}

	; アイコンを隠すため、起動時に終了のオプションをここで読み出す
	IniRead, Output5, %glob_exceptionOfUserFile%, exceptionOfUser, commGuiOnlyFlag , 0
	glob_reloadIniCommGuiOnlyFlag = %Output5%

	IniRead, Output6, %glob_exceptionOfUserFile%, exceptionOfUser, commWidthBasis ,  %defa_defaultReloadIniCommWidthBasis%
	IniRead, Output7, %glob_exceptionOfUserFile%, exceptionOfUser, commWindowWidthBasis ,  %defa_defaultReloadIniCommWindowWidthBasis%
	IniRead, Output8, %glob_exceptionOfUserFile%, exceptionOfUser, oneLineTextTitle ,  %A_Space%
	IniRead, Output9, %glob_exceptionOfUserFile%, exceptionOfUser, textSplitTitle ,  %A_Space%
	if(Output6 == ""){
		Output6 := defa_defaultReloadIniCommWidthBasis
	}
	if(Output7 == ""){
		Output7 := defa_defaultReloadIniCommWindowWidthBasis
	}
	glob_reloadIniCommWidthBasis = %Output6%
	O_widthBasisText1 = %Output6%
	O_widthBasisText2 = %Output6%
	O_widthBasisText3 = %Output6%

	glob_reloadIniCommWindowWidthBasis = %Output7%
	O_widthWindowBasisText1 = %Output7%
	O_widthWindowBasisText2 = %Output7%
	O_widthWindowBasisText3 = %Output7%

	glob_reloadIniOneLineTextTitle = %Output8%
	glob_reloadIniTextSplitTitle = %Output9%
	; メニュー名などの変更に使用する
	if(glob_reloadIniOneLineTextTitle != ""){
		glob_oneLineTextAlias = %glob_reloadIniOneLineTextTitle%
	}
	if(glob_reloadIniTextSplitTitle != ""){
		glob_textSplitAlias = %glob_reloadIniTextSplitTitle%
	}

/* アイコンを隠すのをやっぱりやめる
	if( glob_reloadIniCommGuiOnlyFlag ){
		Menu, Tray, NoIcon
	}
*/
}

init_managerConfigRead(){
	IniRead, Output1, %glob_managerConfigFile%, config, commOutput , 0

	glob_iniEasyCheck = %Output1%
}

init_exceptionOfUserRead(){
	IniRead, Output3, %glob_exceptionOfUserFile%, exceptionOfUser, startUpText3 ,  %A_Space%
	IniRead, Output4, %glob_exceptionOfUserFile%, exceptionOfUser, shortKeyOffFlag ,0
	IniRead, Output5, %glob_exceptionOfUserFile%, exceptionOfUser, commWinTitle ,  %A_Space%
	IniRead, Output6, %glob_exceptionOfUserFile%, exceptionOfUser, textWidthAutoFlag ,  0
	IniRead, Output7, %glob_exceptionOfUserFile%, exceptionOfUser, exceptCommKeyOff ,0

	glob_reloadIniStartUpText3 = %Output3%
	glob_reloadIniShortKeyOffFlag = %Output4%
	glob_reloadIniCommWinTitle = %Output5%

	glob_reloadIniTextWidthAutoNotFlag = %Output6%
	O_widthNotFlagText1 = %Output6%
	O_widthNotFlagText2 = %Output6%
	O_widthNotFlagText3 = %Output6%
	O_widthNotFlagTextSplit1 = %Output6%
	O_widthNotFlagTextSplit2 = %Output6%

	glob_reloadIniExceptCommKeyOff = %Output7%
}

init_trimBrackets(str){
	StringTrimLeft, tmpStr, str, 1
	StringTrimRight, tmpStr, tmpStr, 1
	return tmpStr
}

init_lastWordConfigRead(){
	lastConfigFile := gloco_userDir . glob_lastWordExeConfigFileName
	;func_easyFileCheckMakeFolderAndFile(configFile, gloco_userDir, "")
	IniRead, Output1, %lastConfigFile%, lastConfig, lastWordExeAllFlag,0
	IniRead, Output2, %lastConfigFile%, lastConfig, enterFlag ,        0
	IniRead, Output3, %lastConfigFile%, lastConfig, enterText ,        %defa_defaultIniLastWordExeEnterText%
	IniRead, Output4, %lastConfigFile%, lastConfig, ctrlNumFlag ,      0
	IniRead, Output5, %lastConfigFile%, lastConfig, ctrlNumText ,      %defa_defaultIniLastWordExeCtrlNumText%
	IniRead, Output6, %lastConfigFile%, lastConfig, shiftCtrlNumFlag , 0
	IniRead, Output7, %lastConfigFile%, lastConfig, shiftCtrlNumText , %defa_defaultIniLastWordExeShiftCtrlNumText%
	IniRead, Output8, %lastConfigFile%, lastConfig, puppupViewFlag ,   0
	IniRead, Output9, %lastConfigFile%, lastConfig, puppupViewText ,   %defa_defaultIniLastWordExePuppupViewText%
	IniRead, Output10, %lastConfigFile%, lastConfig, enterText2 ,      %defa_defaultIniLastWordExeEnterText2%
	IniRead, Output11, %lastConfigFile%, lastConfig, textCleanFlag ,   0
	IniRead, Output12, %lastConfigFile%, lastConfig, textCleanText ,   %defa_defaultIniLastWordTextCleanText%
	IniRead, Output13, %lastConfigFile%, lastConfig, useTextNumFlag ,  0
	IniRead, Output14, %lastConfigFile%, lastConfig, useTextNumText ,  %defa_defaultIniLastWordExeUseTextNumText%
	IniRead, Output15, %lastConfigFile%, lastConfig, asHeadExeFlag ,   0
	IniRead, Output16, %lastConfigFile%, lastConfig, asHeadExeText ,   %defa_defaultIniLastWordAsHeadExeText%
	IniRead, Output17, %lastConfigFile%, lastConfig, spaceSendFlag ,   0
	IniRead, Output18, %lastConfigFile%, lastConfig, spaceSendText ,   %defa_defaultIniLastWordSpaceSendText%
	IniRead, Output2_check, %lastConfigFile%, lastTab2, tabFlag2 , 0
	IniRead, Output2_1_1, %lastConfigFile%, lastTab2, assignComm1 ,  %A_Space%
	IniRead, Output2_2_1, %lastConfigFile%, lastTab2, assignComm2 ,  %A_Space%
	IniRead, Output2_3_1, %lastConfigFile%, lastTab2, assignComm3 ,  %A_Space%
	IniRead, Output2_4_1, %lastConfigFile%, lastTab2, assignComm4 ,  %A_Space%
	IniRead, Output2_5_1, %lastConfigFile%, lastTab2, assignComm5 ,  %A_Space%
	IniRead, Output2_6_1, %lastConfigFile%, lastTab2, assignComm6 ,  %A_Space%
	IniRead, Output2_7_1, %lastConfigFile%, lastTab2, assignComm7 ,  %A_Space%
	IniRead, Output2_8_1, %lastConfigFile%, lastTab2, assignComm8 ,  %A_Space%
	IniRead, Output2_9_1, %lastConfigFile%, lastTab2, assignComm9 ,  %A_Space%
	IniRead, Output2_10_1, %lastConfigFile%, lastTab2, assignComm10 ,  %A_Space%
	IniRead, Output2_1_2, %lastConfigFile%, lastTab2, assignText1 ,   ()
	IniRead, Output2_2_2, %lastConfigFile%, lastTab2, assignText2 ,   ()
	IniRead, Output2_3_2, %lastConfigFile%, lastTab2, assignText3 ,   ()
	IniRead, Output2_4_2, %lastConfigFile%, lastTab2, assignText4 ,   ()
	IniRead, Output2_5_2, %lastConfigFile%, lastTab2, assignText5 ,   ()
	IniRead, Output2_6_2, %lastConfigFile%, lastTab2, assignText6 ,   ()
	IniRead, Output2_7_2, %lastConfigFile%, lastTab2, assignText7 ,   ()
	IniRead, Output2_8_2, %lastConfigFile%, lastTab2, assignText8 ,   ()
	IniRead, Output2_9_2, %lastConfigFile%, lastTab2, assignText9 ,   ()
	IniRead, Output2_10_2, %lastConfigFile%, lastTab2, assignText10 ,   ()
	IniRead, Output3_check, %lastConfigFile%, lastTab3, tabFlag3 , 0
	IniRead, Output3_1_1, %lastConfigFile%, lastTab3, assignComm3_1 ,  %A_Space%
	IniRead, Output3_2_1, %lastConfigFile%, lastTab3, assignComm3_2 ,  %A_Space%
	IniRead, Output3_3_1, %lastConfigFile%, lastTab3, assignComm3_3 ,  %A_Space%
	IniRead, Output3_4_1, %lastConfigFile%, lastTab3, assignComm3_4 ,  %A_Space%
	IniRead, Output3_5_1, %lastConfigFile%, lastTab3, assignComm3_5 ,  %A_Space%
	IniRead, Output3_6_1, %lastConfigFile%, lastTab3, assignComm3_6 ,  %A_Space%
	IniRead, Output3_7_1, %lastConfigFile%, lastTab3, assignComm3_7 ,  %A_Space%
	IniRead, Output3_8_1, %lastConfigFile%, lastTab3, assignComm3_8 ,  %A_Space%
	IniRead, Output3_9_1, %lastConfigFile%, lastTab3, assignComm3_9 ,  %A_Space%
	IniRead, Output3_10_1, %lastConfigFile%, lastTab3, assignComm3_10 ,  %A_Space%
	IniRead, Output3_1_2, %lastConfigFile%, lastTab3, assignText3_1 ,   ()
	IniRead, Output3_2_2, %lastConfigFile%, lastTab3, assignText3_2 ,   ()
	IniRead, Output3_3_2, %lastConfigFile%, lastTab3, assignText3_3 ,   ()
	IniRead, Output3_4_2, %lastConfigFile%, lastTab3, assignText3_4 ,   ()
	IniRead, Output3_5_2, %lastConfigFile%, lastTab3, assignText3_5 ,   ()
	IniRead, Output3_6_2, %lastConfigFile%, lastTab3, assignText3_6 ,   ()
	IniRead, Output3_7_2, %lastConfigFile%, lastTab3, assignText3_7 ,   ()
	IniRead, Output3_8_2, %lastConfigFile%, lastTab3, assignText3_8 ,   ()
	IniRead, Output3_9_2, %lastConfigFile%, lastTab3, assignText3_9 ,   ()
	IniRead, Output3_10_2, %lastConfigFile%, lastTab3, assignText3_10 ,   ()
	IniRead, Output4_check, %lastConfigFile%, lastTab4, tabFlag4 , 0
	IniRead, Output4_1_1, %lastConfigFile%, lastTab4, assignComm4_1 ,  %A_Space%
	IniRead, Output4_2_1, %lastConfigFile%, lastTab4, assignComm4_2 ,  %A_Space%
	IniRead, Output4_3_1, %lastConfigFile%, lastTab4, assignComm4_3 ,  %A_Space%
	IniRead, Output4_4_1, %lastConfigFile%, lastTab4, assignComm4_4 ,  %A_Space%
	IniRead, Output4_5_1, %lastConfigFile%, lastTab4, assignComm4_5 ,  %A_Space%
	IniRead, Output4_6_1, %lastConfigFile%, lastTab4, assignComm4_6 ,  %A_Space%
	IniRead, Output4_7_1, %lastConfigFile%, lastTab4, assignComm4_7 ,  %A_Space%
	IniRead, Output4_8_1, %lastConfigFile%, lastTab4, assignComm4_8 ,  %A_Space%
	IniRead, Output4_9_1, %lastConfigFile%, lastTab4, assignComm4_9 ,  %A_Space%
	IniRead, Output4_10_1, %lastConfigFile%, lastTab4, assignComm4_10 ,  %A_Space%
	IniRead, Output4_1_2, %lastConfigFile%, lastTab4, assignText4_1 ,   ()
	IniRead, Output4_2_2, %lastConfigFile%, lastTab4, assignText4_2 ,   ()
	IniRead, Output4_3_2, %lastConfigFile%, lastTab4, assignText4_3 ,   ()
	IniRead, Output4_4_2, %lastConfigFile%, lastTab4, assignText4_4 ,   ()
	IniRead, Output4_5_2, %lastConfigFile%, lastTab4, assignText4_5 ,   ()
	IniRead, Output4_6_2, %lastConfigFile%, lastTab4, assignText4_6 ,   ()
	IniRead, Output4_7_2, %lastConfigFile%, lastTab4, assignText4_7 ,   ()
	IniRead, Output4_8_2, %lastConfigFile%, lastTab4, assignText4_8 ,   ()
	IniRead, Output4_9_2, %lastConfigFile%, lastTab4, assignText4_9 ,   ()
	IniRead, Output4_10_2, %lastConfigFile%, lastTab4, assignText4_10 ,   ()
	IniRead, Output5_check, %lastConfigFile%, lastTab5, tabFlag5 , 0
	IniRead, Output5_1_1, %lastConfigFile%, lastTab5, assignComm5_1 ,  %A_Space%
	IniRead, Output5_2_1, %lastConfigFile%, lastTab5, assignComm5_2 ,  %A_Space%
	IniRead, Output5_3_1, %lastConfigFile%, lastTab5, assignComm5_3 ,  %A_Space%
	IniRead, Output5_4_1, %lastConfigFile%, lastTab5, assignComm5_4 ,  %A_Space%
	IniRead, Output5_5_1, %lastConfigFile%, lastTab5, assignComm5_5 ,  %A_Space%
	IniRead, Output5_6_1, %lastConfigFile%, lastTab5, assignComm5_6 ,  %A_Space%
	IniRead, Output5_7_1, %lastConfigFile%, lastTab5, assignComm5_7 ,  %A_Space%
	IniRead, Output5_8_1, %lastConfigFile%, lastTab5, assignComm5_8 ,  %A_Space%
	IniRead, Output5_9_1, %lastConfigFile%, lastTab5, assignComm5_9 ,  %A_Space%
	IniRead, Output5_10_1, %lastConfigFile%, lastTab5, assignComm5_10 ,  %A_Space%
	IniRead, Output5_1_2, %lastConfigFile%, lastTab5, assignText5_1 ,   ()
	IniRead, Output5_2_2, %lastConfigFile%, lastTab5, assignText5_2 ,   ()
	IniRead, Output5_3_2, %lastConfigFile%, lastTab5, assignText5_3 ,   ()
	IniRead, Output5_4_2, %lastConfigFile%, lastTab5, assignText5_4 ,   ()
	IniRead, Output5_5_2, %lastConfigFile%, lastTab5, assignText5_5 ,   ()
	IniRead, Output5_6_2, %lastConfigFile%, lastTab5, assignText5_6 ,   ()
	IniRead, Output5_7_2, %lastConfigFile%, lastTab5, assignText5_7 ,   ()
	IniRead, Output5_8_2, %lastConfigFile%, lastTab5, assignText5_8 ,   ()
	IniRead, Output5_9_2, %lastConfigFile%, lastTab5, assignText5_9 ,   ()
	IniRead, Output5_10_2, %lastConfigFile%, lastTab5, assignText5_10 ,   ()
	IniRead, Output6_endFlag, %lastConfigFile%, lastTab6, betweenEndFlag ,   0
	IniRead, Output6_endKey, %lastConfigFile%, lastTab6, betweenEndKey ,   %defa_defaultIniBetweenExeWordEndKey%
	IniRead, Output6_check, %lastConfigFile%, lastTab6, betweenFlag1 , 0
	IniRead, Output6_1_1, %lastConfigFile%, lastTab6, betweenScript1_1 ,  %A_Space%
	IniRead, Output6_2_1, %lastConfigFile%, lastTab6, betweenScript1_2 ,  %A_Space%
	IniRead, Output6_3_1, %lastConfigFile%, lastTab6, betweenScript1_3 ,  %A_Space%
	IniRead, Output6_4_1, %lastConfigFile%, lastTab6, betweenScript1_4 ,  %A_Space%
	IniRead, Output6_5_1, %lastConfigFile%, lastTab6, betweenScript1_5 ,  %A_Space%
	IniRead, Output6_6_1, %lastConfigFile%, lastTab6, betweenScript1_6 ,  %A_Space%
	IniRead, Output6_7_1, %lastConfigFile%, lastTab6, betweenScript1_7 ,  %A_Space%
	IniRead, Output6_8_1, %lastConfigFile%, lastTab6, betweenScript1_8 ,  %A_Space%
	IniRead, Output6_9_1, %lastConfigFile%, lastTab6, betweenScript1_9 ,  %A_Space%
	IniRead, Output6_10_1, %lastConfigFile%, lastTab6, betweenScript1_10 ,  %A_Space%
	IniRead, Output6_1_2, %lastConfigFile%, lastTab6, betweenKey1_1 ,   ()
	IniRead, Output6_2_2, %lastConfigFile%, lastTab6, betweenKey1_2 ,   ()
	IniRead, Output6_3_2, %lastConfigFile%, lastTab6, betweenKey1_3 ,   ()
	IniRead, Output6_4_2, %lastConfigFile%, lastTab6, betweenKey1_4 ,   ()
	IniRead, Output6_5_2, %lastConfigFile%, lastTab6, betweenKey1_5 ,   ()
	IniRead, Output6_6_2, %lastConfigFile%, lastTab6, betweenKey1_6 ,   ()
	IniRead, Output6_7_2, %lastConfigFile%, lastTab6, betweenKey1_7 ,   ()
	IniRead, Output6_8_2, %lastConfigFile%, lastTab6, betweenKey1_8 ,   ()
	IniRead, Output6_9_2, %lastConfigFile%, lastTab6, betweenKey1_9 ,   ()
	IniRead, Output6_10_2, %lastConfigFile%, lastTab6, betweenKey1_10 ,   ()
	IniRead, outChangeHalfNum, %lastConfigFile%, lastChange, changeHalfNumFlag ,  0
	IniRead, outChangeFlag1, %lastConfigFile%, lastChange, changeFlag1 ,  0
	IniRead, outChangeAfter1, %lastConfigFile%, lastChange, changeAfter1 ,   %defa_defaultIniLastWordChangeAfter1%
	IniRead, outChangeChoice1_1, %lastConfigFile%, lastChange, changeChoice1_1 , %defa_defaultIniLastWordChangeChoice1_1%
	IniRead, outChangeChoice1_2, %lastConfigFile%, lastChange, changeChoice1_2 , %defa_defaultIniLastWordChangeChoice1_2%
	IniRead, outChangeChoice1_3, %lastConfigFile%, lastChange, changeChoice1_3 , %defa_defaultIniLastWordChangeChoice1_3%
	IniRead, outChangeFlag2, %lastConfigFile%, lastChange, changeFlag2 ,  0
	IniRead, outChangeAfter2, %lastConfigFile%, lastChange, changeAfter2 ,   %A_Space%
	IniRead, outChangeChoice2_1, %lastConfigFile%, lastChange, changeChoice2_1 ,   %A_Space%
	IniRead, outChangeChoice2_2, %lastConfigFile%, lastChange, changeChoice2_2 ,   %A_Space%
	IniRead, outChangeChoice2_3, %lastConfigFile%, lastChange, changeChoice2_3 ,   %A_Space%
	IniRead, outChangeFlag3, %lastConfigFile%, lastChange, changeFlag3 ,  0
	IniRead, outChangeAfter3, %lastConfigFile%, lastChange, changeAfter3 ,   %A_Space%
	IniRead, outChangeChoice3_1, %lastConfigFile%, lastChange, changeChoice3_1 ,   %A_Space%
	IniRead, outChangeChoice3_2, %lastConfigFile%, lastChange, changeChoice3_2 ,   %A_Space%
	IniRead, outChangeChoice3_3, %lastConfigFile%, lastChange, changeChoice3_3 ,   %A_Space%


	Output3 := init_trimBrackets(Output3)
	Output5 := init_trimBrackets(Output5)
	Output7 := init_trimBrackets(Output7)
	Output9 := init_trimBrackets(Output9)
	Output10 := init_trimBrackets(Output10)
	Output12 := init_trimBrackets(Output12)
	Output14 := init_trimBrackets(Output14)
	Output16 := init_trimBrackets(Output16)
	Output18 := init_trimBrackets(Output18)

	if(Output3 == ""){
		Output3 := init_trimBrackets(defa_defaultIniLastWordExeEnterText)
	}
	if(Output5 == ""){
		Output5 := init_trimBrackets(defa_defaultIniLastWordExeCtrlNumText)
	}
	if(Output7 == ""){
		Output7 := init_trimBrackets(defa_defaultIniLastWordExeShiftCtrlNumText)
	}
	if(Output9 == ""){
		Output9 := init_trimBrackets(defa_defaultIniLastWordExePuppupViewText)
	}
	if(Output10 == ""){
		Output10 := init_trimBrackets(defa_defaultIniLastWordExeEnterText2)
	}
	if(Output12 == ""){
		Output12 := init_trimBrackets(defa_defaultIniLastWordTextCleanText)
	}
	if(Output14 == ""){
		Output14 := init_trimBrackets(defa_defaultIniLastWordExeUseTextNumText)
	}
	if(Output16 == ""){
		Output16 := init_trimBrackets(defa_defaultIniLastWordAsHeadExeText)
	}
	if(Output18 == ""){
		Output18 := init_trimBrackets(defa_defaultIniLastWordSpaceSendText)
	}

	glob_iniLastWordExeAllFlag = %Output1%
	glob_iniLastWordExeEnterFlag = %Output2%
	glob_iniLastWordExeEnterText := Output3
	glob_iniLastWordExeCtrlNumFlag = %Output4%
	glob_iniLastWordExeCtrlNumText := Output5
	glob_iniLastWordExeShiftCtrlNumFlag = %Output6%
	glob_iniLastWordExeShiftCtrlNumText := Output7
	glob_iniLastWordExePuppupViewFlag = %Output8%
	glob_iniLastWordExePuppupViewText := Output9
	glob_iniLastWordExeEnterText2 := Output10
	glob_iniLastWordTextCleanFlag = %Output11%
	glob_iniLastWordTextCleanText := Output12
	glob_iniLastWordExeUseTextNumFlag = %Output13%
	glob_iniLastWordExeUseTextNumText := Output14
	glob_iniLastWordAsHeadExeFlag = %Output15%
	glob_iniLastWordAsHeadExeText := Output16
	glob_iniLastWordSpaceSendFlag = %Output17%
	glob_iniLastWordSpaceSendText := Output18


	O_lastWordTabAllFlag2 = %Output2_check%
	O_lastWordScript2_1 = %Output2_1_1%
	O_lastWordScript2_2 = %Output2_2_1%
	O_lastWordScript2_3 = %Output2_3_1%
	O_lastWordScript2_4 = %Output2_4_1%
	O_lastWordScript2_5 = %Output2_5_1%
	O_lastWordScript2_6 = %Output2_6_1%
	O_lastWordScript2_7 = %Output2_7_1%
	O_lastWordScript2_8 = %Output2_8_1%
	O_lastWordScript2_9 = %Output2_9_1%
	O_lastWordScript2_10 = %Output2_10_1%

	O_lastWordKey2_1 := init_trimBrackets(Output2_1_2)
	O_lastWordKey2_2 := init_trimBrackets(Output2_2_2)
	O_lastWordKey2_3 := init_trimBrackets(Output2_3_2)
	O_lastWordKey2_4 := init_trimBrackets(Output2_4_2)
	O_lastWordKey2_5 := init_trimBrackets(Output2_5_2)
	O_lastWordKey2_6 := init_trimBrackets(Output2_6_2)
	O_lastWordKey2_7 := init_trimBrackets(Output2_7_2)
	O_lastWordKey2_8 := init_trimBrackets(Output2_8_2)
	O_lastWordKey2_9 := init_trimBrackets(Output2_9_2)
	O_lastWordKey2_10 := init_trimBrackets(Output2_10_2)


	O_lastWordTabAllFlag3 = %Output3_check%
	O_lastWordScript3_1 = %Output3_1_1%
	O_lastWordScript3_2 = %Output3_2_1%
	O_lastWordScript3_3 = %Output3_3_1%
	O_lastWordScript3_4 = %Output3_4_1%
	O_lastWordScript3_5 = %Output3_5_1%
	O_lastWordScript3_6 = %Output3_6_1%
	O_lastWordScript3_7 = %Output3_7_1%
	O_lastWordScript3_8 = %Output3_8_1%
	O_lastWordScript3_9 = %Output3_9_1%
	O_lastWordScript3_10 = %Output3_10_1%

	O_lastWordKey3_1 := init_trimBrackets(Output3_1_2)
	O_lastWordKey3_2 := init_trimBrackets(Output3_2_2)
	O_lastWordKey3_3 := init_trimBrackets(Output3_3_2)
	O_lastWordKey3_4 := init_trimBrackets(Output3_4_2)
	O_lastWordKey3_5 := init_trimBrackets(Output3_5_2)
	O_lastWordKey3_6 := init_trimBrackets(Output3_6_2)
	O_lastWordKey3_7 := init_trimBrackets(Output3_7_2)
	O_lastWordKey3_8 := init_trimBrackets(Output3_8_2)
	O_lastWordKey3_9 := init_trimBrackets(Output3_9_2)
	O_lastWordKey3_10 := init_trimBrackets(Output3_10_2)


	O_lastWordTabAllFlag4 = %Output4_check%
	O_lastWordScript4_1 = %Output4_1_1%
	O_lastWordScript4_2 = %Output4_2_1%
	O_lastWordScript4_3 = %Output4_3_1%
	O_lastWordScript4_4 = %Output4_4_1%
	O_lastWordScript4_5 = %Output4_5_1%
	O_lastWordScript4_6 = %Output4_6_1%
	O_lastWordScript4_7 = %Output4_7_1%
	O_lastWordScript4_8 = %Output4_8_1%
	O_lastWordScript4_9 = %Output4_9_1%
	O_lastWordScript4_10 = %Output4_10_1%

	O_lastWordKey4_1 := init_trimBrackets(Output4_1_2)
	O_lastWordKey4_2 := init_trimBrackets(Output4_2_2)
	O_lastWordKey4_3 := init_trimBrackets(Output4_3_2)
	O_lastWordKey4_4 := init_trimBrackets(Output4_4_2)
	O_lastWordKey4_5 := init_trimBrackets(Output4_5_2)
	O_lastWordKey4_6 := init_trimBrackets(Output4_6_2)
	O_lastWordKey4_7 := init_trimBrackets(Output4_7_2)
	O_lastWordKey4_8 := init_trimBrackets(Output4_8_2)
	O_lastWordKey4_9 := init_trimBrackets(Output4_9_2)
	O_lastWordKey4_10 := init_trimBrackets(Output4_10_2)


	O_lastWordTabAllFlag5 = %Output5_check%
	O_lastWordScript5_1 = %Output5_1_1%
	O_lastWordScript5_2 = %Output5_2_1%
	O_lastWordScript5_3 = %Output5_3_1%
	O_lastWordScript5_4 = %Output5_4_1%
	O_lastWordScript5_5 = %Output5_5_1%
	O_lastWordScript5_6 = %Output5_6_1%
	O_lastWordScript5_7 = %Output5_7_1%
	O_lastWordScript5_8 = %Output5_8_1%
	O_lastWordScript5_9 = %Output5_9_1%
	O_lastWordScript5_10 = %Output5_10_1%

	O_lastWordKey5_1 := init_trimBrackets(Output5_1_2)
	O_lastWordKey5_2 := init_trimBrackets(Output5_2_2)
	O_lastWordKey5_3 := init_trimBrackets(Output5_3_2)
	O_lastWordKey5_4 := init_trimBrackets(Output5_4_2)
	O_lastWordKey5_5 := init_trimBrackets(Output5_5_2)
	O_lastWordKey5_6 := init_trimBrackets(Output5_6_2)
	O_lastWordKey5_7 := init_trimBrackets(Output5_7_2)
	O_lastWordKey5_8 := init_trimBrackets(Output5_8_2)
	O_lastWordKey5_9 := init_trimBrackets(Output5_9_2)
	O_lastWordKey5_10 := init_trimBrackets(Output5_10_2)

	Output6_endKey := init_trimBrackets(Output6_endKey)
	if(Output6_endKey == ""){
		Output6_endKey := init_trimBrackets(defa_defaultIniBetweenExeWordEndKey)
	}

	glob_iniBetweenExeWordEndFlag = %Output6_endFlag%
	glob_iniBetweenExeWordEndKey = %Output6_endKey%

	O_betweenWordTabAllFlag1 = %Output6_check%
	O_betweenWordScript1_1 = %Output6_1_1%
	O_betweenWordScript1_2 = %Output6_2_1%
	O_betweenWordScript1_3 = %Output6_3_1%
	O_betweenWordScript1_4 = %Output6_4_1%
	O_betweenWordScript1_5 = %Output6_5_1%
	O_betweenWordScript1_6 = %Output6_6_1%
	O_betweenWordScript1_7 = %Output6_7_1%
	O_betweenWordScript1_8 = %Output6_8_1%
	O_betweenWordScript1_9 = %Output6_9_1%
	O_betweenWordScript1_10 = %Output6_10_1%

	O_betweenWordKey1_1 := init_trimBrackets(Output6_1_2)
	O_betweenWordKey1_2 := init_trimBrackets(Output6_2_2)
	O_betweenWordKey1_3 := init_trimBrackets(Output6_3_2)
	O_betweenWordKey1_4 := init_trimBrackets(Output6_4_2)
	O_betweenWordKey1_5 := init_trimBrackets(Output6_5_2)
	O_betweenWordKey1_6 := init_trimBrackets(Output6_6_2)
	O_betweenWordKey1_7 := init_trimBrackets(Output6_7_2)
	O_betweenWordKey1_8 := init_trimBrackets(Output6_8_2)
	O_betweenWordKey1_9 := init_trimBrackets(Output6_9_2)
	O_betweenWordKey1_10 := init_trimBrackets(Output6_10_2)

	glob_iniLastWordChangeHalfNumFlag = %outChangeHalfNum%
	glob_iniLastWordChangeFlag1 = %outChangeFlag1%
	glob_iniLastWordChangeAfter1 = %outChangeAfter1%
	glob_iniLastWordChangeChoice1_1 = %outChangeChoice1_1%
	glob_iniLastWordChangeChoice1_2 = %outChangeChoice1_2%
	glob_iniLastWordChangeChoice1_3 = %outChangeChoice1_3%
	glob_iniLastWordChangeFlag2 = %outChangeFlag2%
	glob_iniLastWordChangeAfter2 = %outChangeAfter2%
	glob_iniLastWordChangeChoice2_1 = %outChangeChoice2_1%
	glob_iniLastWordChangeChoice2_2 = %outChangeChoice2_2%
	glob_iniLastWordChangeChoice2_3 = %outChangeChoice2_3%
	glob_iniLastWordChangeFlag3 = %outChangeFlag3%
	glob_iniLastWordChangeAfter3 = %outChangeAfter3%
	glob_iniLastWordChangeChoice3_1 = %outChangeChoice3_1%
	glob_iniLastWordChangeChoice3_2 = %outChangeChoice3_2%
	glob_iniLastWordChangeChoice3_3 = %outChangeChoice3_3%


	; 初期値を保存しておく変数に代入
	B_lastWordTabAllStartFlag2 := O_lastWordTabAllFlag2
	B_lastWordScriptStart2_1 := O_lastWordScript2_1
	B_lastWordScriptStart2_2 := O_lastWordScript2_2
	B_lastWordScriptStart2_3 := O_lastWordScript2_3
	B_lastWordScriptStart2_4 := O_lastWordScript2_4
	B_lastWordScriptStart2_5 := O_lastWordScript2_5
	B_lastWordScriptStart2_6 := O_lastWordScript2_6
	B_lastWordScriptStart2_7 := O_lastWordScript2_7
	B_lastWordScriptStart2_8 := O_lastWordScript2_8
	B_lastWordScriptStart2_9 := O_lastWordScript2_9
	B_lastWordScriptStart2_10 := O_lastWordScript2_10
	B_lastWordKeyStart2_1 := O_lastWordKey2_1
	B_lastWordKeyStart2_2 := O_lastWordKey2_2
	B_lastWordKeyStart2_3 := O_lastWordKey2_3
	B_lastWordKeyStart2_4 := O_lastWordKey2_4
	B_lastWordKeyStart2_5 := O_lastWordKey2_5
	B_lastWordKeyStart2_6 := O_lastWordKey2_6
	B_lastWordKeyStart2_7 := O_lastWordKey2_7
	B_lastWordKeyStart2_8 := O_lastWordKey2_8
	B_lastWordKeyStart2_9 := O_lastWordKey2_9
	B_lastWordKeyStart2_10 := O_lastWordKey2_10
	B_lastWordTabAllStartFlag3 := O_lastWordTabAllFlag3
	B_lastWordScriptStart3_1 := O_lastWordScript3_1
	B_lastWordScriptStart3_2 := O_lastWordScript3_2
	B_lastWordScriptStart3_3 := O_lastWordScript3_3
	B_lastWordScriptStart3_4 := O_lastWordScript3_4
	B_lastWordScriptStart3_5 := O_lastWordScript3_5
	B_lastWordScriptStart3_6 := O_lastWordScript3_6
	B_lastWordScriptStart3_7 := O_lastWordScript3_7
	B_lastWordScriptStart3_8 := O_lastWordScript3_8
	B_lastWordScriptStart3_9 := O_lastWordScript3_9
	B_lastWordScriptStart3_10 := O_lastWordScript3_10
	B_lastWordKeyStart3_1 := O_lastWordKey3_1
	B_lastWordKeyStart3_2 := O_lastWordKey3_2
	B_lastWordKeyStart3_3 := O_lastWordKey3_3
	B_lastWordKeyStart3_4 := O_lastWordKey3_4
	B_lastWordKeyStart3_5 := O_lastWordKey3_5
	B_lastWordKeyStart3_6 := O_lastWordKey3_6
	B_lastWordKeyStart3_7 := O_lastWordKey3_7
	B_lastWordKeyStart3_8 := O_lastWordKey3_8
	B_lastWordKeyStart3_9 := O_lastWordKey3_9
	B_lastWordKeyStart3_10 := O_lastWordKey3_10
	B_lastWordTabAllStartFlag4 := O_lastWordTabAllFlag4
	B_lastWordScriptStart4_1 := O_lastWordScript4_1
	B_lastWordScriptStart4_2 := O_lastWordScript4_2
	B_lastWordScriptStart4_3 := O_lastWordScript4_3
	B_lastWordScriptStart4_4 := O_lastWordScript4_4
	B_lastWordScriptStart4_5 := O_lastWordScript4_5
	B_lastWordScriptStart4_6 := O_lastWordScript4_6
	B_lastWordScriptStart4_7 := O_lastWordScript4_7
	B_lastWordScriptStart4_8 := O_lastWordScript4_8
	B_lastWordScriptStart4_9 := O_lastWordScript4_9
	B_lastWordScriptStart4_10 := O_lastWordScript4_10
	B_lastWordKeyStart4_1 := O_lastWordKey4_1
	B_lastWordKeyStart4_2 := O_lastWordKey4_2
	B_lastWordKeyStart4_3 := O_lastWordKey4_3
	B_lastWordKeyStart4_4 := O_lastWordKey4_4
	B_lastWordKeyStart4_5 := O_lastWordKey4_5
	B_lastWordKeyStart4_6 := O_lastWordKey4_6
	B_lastWordKeyStart4_7 := O_lastWordKey4_7
	B_lastWordKeyStart4_8 := O_lastWordKey4_8
	B_lastWordKeyStart4_9 := O_lastWordKey4_9
	B_lastWordKeyStart4_10 := O_lastWordKey4_10
	B_lastWordTabAllStartFlag5 := O_lastWordTabAllFlag5
	B_lastWordScriptStart5_1 := O_lastWordScript5_1
	B_lastWordScriptStart5_2 := O_lastWordScript5_2
	B_lastWordScriptStart5_3 := O_lastWordScript5_3
	B_lastWordScriptStart5_4 := O_lastWordScript5_4
	B_lastWordScriptStart5_5 := O_lastWordScript5_5
	B_lastWordScriptStart5_6 := O_lastWordScript5_6
	B_lastWordScriptStart5_7 := O_lastWordScript5_7
	B_lastWordScriptStart5_8 := O_lastWordScript5_8
	B_lastWordScriptStart5_9 := O_lastWordScript5_9
	B_lastWordScriptStart5_10 := O_lastWordScript5_10
	B_lastWordKeyStart5_1 := O_lastWordKey5_1
	B_lastWordKeyStart5_2 := O_lastWordKey5_2
	B_lastWordKeyStart5_3 := O_lastWordKey5_3
	B_lastWordKeyStart5_4 := O_lastWordKey5_4
	B_lastWordKeyStart5_5 := O_lastWordKey5_5
	B_lastWordKeyStart5_6 := O_lastWordKey5_6
	B_lastWordKeyStart5_7 := O_lastWordKey5_7
	B_lastWordKeyStart5_8 := O_lastWordKey5_8
	B_lastWordKeyStart5_9 := O_lastWordKey5_9
	B_lastWordKeyStart5_10 := O_lastWordKey5_10

	B_betweenWordTabAllStartFlag1 := O_betweenWordTabAllFlag1
	B_betweenWordScriptStart1_1 := O_betweenWordScript1_1
	B_betweenWordScriptStart1_2 := O_betweenWordScript1_2
	B_betweenWordScriptStart1_3 := O_betweenWordScript1_3
	B_betweenWordScriptStart1_4 := O_betweenWordScript1_4
	B_betweenWordScriptStart1_5 := O_betweenWordScript1_5
	B_betweenWordScriptStart1_6 := O_betweenWordScript1_6
	B_betweenWordScriptStart1_7 := O_betweenWordScript1_7
	B_betweenWordScriptStart1_8 := O_betweenWordScript1_8
	B_betweenWordScriptStart1_9 := O_betweenWordScript1_9
	B_betweenWordScriptStart1_10 := O_betweenWordScript1_10
	B_betweenWordKeyStart1_1 := O_betweenWordKey1_1
	B_betweenWordKeyStart1_2 := O_betweenWordKey1_2
	B_betweenWordKeyStart1_3 := O_betweenWordKey1_3
	B_betweenWordKeyStart1_4 := O_betweenWordKey1_4
	B_betweenWordKeyStart1_5 := O_betweenWordKey1_5
	B_betweenWordKeyStart1_6 := O_betweenWordKey1_6
	B_betweenWordKeyStart1_7 := O_betweenWordKey1_7
	B_betweenWordKeyStart1_8 := O_betweenWordKey1_8
	B_betweenWordKeyStart1_9 := O_betweenWordKey1_9
	B_betweenWordKeyStart1_10 := O_betweenWordKey1_10
}

init_needReloadConfigRead(){
	needReloadConfigFile := gloco_userDir . glob_needReloadConfigFileName
	;func_easyFileCheckMakeFolderAndFile(configFile, gloco_userDir, "")
	IniRead, Output1, %needReloadConfigFile%, needReloadConfig, commTitleFlag, 0
	IniRead, Output2, %needReloadConfigFile%, needReloadConfig, allFontSize, %defa_defaultNeedReloadIniAllFontSize%
	IniRead, Output3, %needReloadConfigFile%, needReloadConfig, commFontOption, %defa_defaultNeedReloadIniCommFontOption%
	IniRead, Output4, %needReloadConfigFile%, needReloadConfig, commFontName, %A_Space%
	IniRead, Output5, %needReloadConfigFile%, needReloadConfig, commBoxFontOption, %defa_defaultNeedReloadIniCommBoxFontOption%
	IniRead, Output6, %needReloadConfigFile%, needReloadConfig, commBoxFontName, %A_Space%
	IniRead, Output7, %needReloadConfigFile%, needReloadConfig, explainFontOption, %defa_defaultNeedReloadIniExplainFontOption%
	IniRead, Output8, %needReloadConfigFile%, needReloadConfig, explainFontName, %A_Space%
	IniRead, Output9, %needReloadConfigFile%, needReloadConfig, commMenuFlag ,  0
	IniRead, Output10, %needReloadConfigFile%, needReloadConfig, allFontName, %A_Space%

	if(Output3 == ""){
		Output3 := defa_defaultNeedReloadIniCommFontOption
	}
	if(Output5 == ""){
		Output5 := defa_defaultNeedReloadIniCommBoxFontOption
	}
	if(Output7 == ""){
		Output7 := defa_defaultNeedReloadIniExplainFontOption
	}

	glob_needReloadIniCommTitleNotFlag = %Output1%
	StO_fontSizeAllOption = %Output2%
	glob_needReloadIniCommFontOption = %Output3%
	glob_needReloadIniCommFontName = %Output4%
	glob_needReloadIniCommBoxFontOption = %Output5%
	glob_needReloadIniCommBoxFontName = %Output6%
	glob_needReloadIniExplainFontOption = %Output7%
	glob_needReloadIniExplainFontName = %Output8%
	glob_needReloadIniCommMenuNotFlag = %Output9%
	StO_fontNameAll = %Output10%
}

init_myConfigRead(){
	configFile := gloco_userDir . glob_configFileName
	;func_easyFileCheckMakeFolderAndFile(configFile, gloco_userDir, "")
	IniRead, Output1, %configFile%, config, spaceFile ,          0
	IniRead, Output3, %configFile%, config, argsToAbsolePath ,   0
	IniRead, Output4, %configFile%, config, historyCount ,       %defa_defaultIniHistoryCount%
	IniRead, Output5, %configFile%, config, textPeriod_sec ,     %defa_defaultIniTimerTextPeriod_sec%
	IniRead, Output9, %configFile%, config, commListEscSaveFlag ,0
	IniRead, Output10, %configFile%, config, startUpOptionFlag , 0
	IniRead, Output11, %configFile%, config, startUpOptionText , %A_Space%
	IniRead, Output12, %configFile%, config, startUpOptionTextPattern2 , %A_Space%
	IniRead, Output13, %configFile%, config, clickOnlyGuiFlag ,  0
	IniRead, Output14, %configFile%, config, autoPopupViewFlag , 0
	IniRead, Output15, %configFile%, config, changeStockInsertNotFlag , 0
	IniRead, Output16, %configFile%, config, multipleExplainFlag , 0

	if(Output4 == ""){
		Output4 := defa_defaultIniHistoryCount
	}
	if(Output5 == ""){
		Output5 := defa_defaultIniTimerTextPeriod_sec
	}

	;glob_iniSpaceFileNotFlag = %Output1%
	O_spaceFileNotFlag = %Output1%
	glob_iniAbsolePathNotFlag = %Output3%
	;glob_iniHistoryCount = %Output4%
	O_textHistory = %Output4%
	glob_iniTimerTextPeriod_sec = %Output5%
	glob_iniCommListCloseNotSaveFlag = %Output9%
	glob_iniStartUpOptionFlag = %Output10%
	glob_iniStartUpOptionText = %Output11%
	glob_iniStartUpOptionTextPattern2 = %Output12%
	glob_iniClickOnlyGuiNotFlag = %Output13%
	;glob_iniAutoPopupNotViewFlag = %Output14%
	O_inputListAutoNotFlag = %Output14%
	glob_iniChangeStockInsertNotFlag = %Output15%
	;glob_iniMultipleExplainNotFlag = %Output16%
	O_tmpOutputMultipleTextFlag = %Output16%

	IniRead, out2_1, %configFile%, config, tmpOutput_sec , 7
	IniRead, out2_2, %configFile%, config, tmpOutputNotViewFlag , 0
	IniRead, out2_3, %configFile%, config, output_sec , 7
	IniRead, out2_4, %configFile%, config, outputNotViewFlag , 0
	IniRead, out2_5, %configFile%, config, error_sec , 10
	IniRead, out2_6, %configFile%, config, errorNotViewFlag , 0
	IniRead, out2_7, %configFile%, config, stock_sec , 7
	IniRead, out2_8, %configFile%, config, timerGui_sec , 7

	glob_iniTmpOutput_sec = %out2_1%
	glob_iniTmpOutputNotViewFlag = %out2_2%
	glob_iniOutput_sec = %out2_3%
	glob_iniOutputNotViewFlag = %out2_4%
	glob_iniError_sec = %out2_5%
	glob_iniErrorNotViewFlag = %out2_6%
	glob_iniStock_sec = %out2_7%
	glob_iniTimerGui_sec = %out2_8%

	IniRead, out3_1, %configFile%, config, fileCleanTextFlag , 0
	IniRead, out3_2, %configFile%, config, scriptCleanTextFlag , 0
	IniRead, out3_3, %configFile%, config, multipleCleanTextFlag , 0
	IniRead, out3_4, %configFile%, config, fileGuiNotHide , 0
	IniRead, out3_5, %configFile%, config, scriptGuiHide , 0
	IniRead, out3_6, %configFile%, config, multipleGuiHide , 0
	IniRead, out3_7, %configFile%, config, ahkCommExeGuiHide , 0
	IniRead, out3_9, %configFile%, config, textGuiMinimize , 0
	IniRead, out3_10, %configFile%, config, spacePlusFlag , 0
	;IniRead, out3_8, %configFile%, config, funcExeGuiHide , 0

	glob_iniFileCleanTextFlag = %out3_1%
	glob_iniScriptCleanTextFlag = %out3_2%
	glob_iniMultipleCleanTextFlag = %out3_3%
	glob_iniFileGuiNotHide = %out3_4%
	glob_iniScriptGuiHide = %out3_5%
	glob_iniMultipleGuiHide = %out3_6%
	glob_iniAhkCommExeGuiHide = %out3_7%
	;glob_iniTextGuiMinimize = %out3_9%
	O_minimizeTextFlag = %out3_9%
	;glob_iniSpacePlusFlag = %out3_10%
	O_spacePlusFlag = %out3_10%
	;glob_iniFuncExeGuiHide = %out3_8%

	; 再起動が必要な設定の項目をここで実行
	if( glob_needReloadIniCommMenuNotFlag == False ){
		Gui, 61:Menu, D_menuTextGuiTop
		Gui, 62:Menu, D_menuTextGuiTop
		Gui, 63:Menu, D_menuTextGuiTop
		Gui, 64:Menu, D_menuTextGuiTop
		Gui, 65:Menu, D_menuTextGuiTop
	}
	Gui, 76:Menu, D_menuClickWindowTop
}

