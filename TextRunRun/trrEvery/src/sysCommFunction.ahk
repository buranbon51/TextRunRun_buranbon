

syf_OutFileToFileGui(com2, pOut, GuiNum){
	outs_fileReadOnGuiEny(gloco_userDir . glob_outputFileName, gGlob_hwndBoxEdit69_1, "BoxEdit69_1", 69, "_")
}

syf_OutErrFileToFileGui(com2, pOut, GuiNum){
	outs_fileReadOnGuiEny(gloco_userDir . glob_errorOutputFileName, gGlob_hwndBoxEdit69_1, "BoxEdit69_1", 69, "_")
}

syf_OutOutGuiToFile(rightStr, pOut, GuiNum){
	res := outs_fileAppendFromBoxEdit(gloco_userDir . glob_outputFileName, "BoxEdit66_1", 66)
	if(res){
		guit_setExplain(gloco_userDir . glob_outputFileName  . "`nファイルに書き込んだ", GuiNum)
	}
}

syf_OutErrGuiToErrFile(rightStr, pOut, GuiNum){
	res := outs_fileAppendFromBoxEdit(gloco_userDir . glob_errorOutputFileName, "BoxEdit67_1", 67)
	if(res){
		guit_setExplain(gloco_userDir . glob_errorOutputFileName  . "`nファイルに書き込んだ", GuiNum)
	}
}

syf_OutTmpOutGuiToTmpFile(rightStr, pOut, GuiNum){
	file := gloco_userDir . glob_outputTmpFileName
	if(func_txtFileCheck(file) == False){
		guit_errorAppend("txtファイルしか指定できない。`n書き込もうとしたファイル`n" . file)
		return
	}

	if( func_myFileExist(file) ){
		FileDelete, %file%
		res := guit_checkErrorLevelOutput("ファイルの削除時でエラー`n" . file)
		if( res == False ){
			return
		}
	}

	res := outs_fileAppendFromBoxEdit(file, "BoxEdit68_1", 68)
	if(res){
		guit_appendExplain("説明欄の文字を一時保存のファイルに上書きした")
		;guit_appendExplain("説明欄の文字を一時保存用のファイルに書き加えた")
	}
}

syf_outTmpOutGuiToOutFile(rightStr, pOut, GuiNum){
	res := outs_fileAppendFromBoxEdit(gloco_userDir . glob_outputFileName, "BoxEdit68_1", 68)
	if(res){
		guit_appendExplain("説明欄の文字をファイルに書き加えた")
	}
}

syf_OutTmpOutGuiToComm(rightStr, pOut, GuiNum){
	value := guf_getControl( "BoxEdit68_1", 68 )
	value := Trim(value)
	value := Trim(value, "`n")
	guf_setControl( value, "Edit64_1", 64 )
	;edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
	Gui, 68:Hide

	guf_showGuiAssign(64)
}

syf_OutTmpOutGuiToOutGui(rightStr, pOut, GuiNum){
	value := guf_getControl( "BoxEdit68_1", 68 )
	tmpValue := Trim(value, "`n")
	if(tmpValue == ""){
		return
	}
	time := func_getHourMinSec()
	guit_appendBoxEdit66_1(time  . "`n" . value)
}

syf_OutTextToFileAssign(rightStr, GuiNum, textOutFlag){
	str := "引数１にファイル名を指定する。`n引数２以降の文字を指定したファイルに書き出す。`n例`n&outArgsToFileAssign #itemName#\file.txt 記入する文字`n引数１はtextOutされる"
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

	; 引数１が , だったら、 , で区切る仕様に変える
	if(arg_1 == ","){
		arg_1 := func_leftStrOrAllFromSearchStr(rightStr, ",")
		rightStr2 := func_rightStrOrNullFromSearchStrTurnAssign(rightStr, ",", 1)
	}

	if(rightStr2 == ""){
		guit_setExplain(str, GuiNum)
		guit_errorAppend("&outArgsToFileAssign のエラー`n引数の指定が正しくない`n" . rightStr)
		return
	}

	arg_1 := outs_textOutTrimss(arg_1)

	if( outs_similarTxtFile(arg_1) == False ){
		guit_errorAppend("&outArgsToFileAssign のエラー`nこのファイルは拡張子の問題で使えないようにしている`n" . arg_1)
		return
	}

	;day := func_getYearMonthDayHourMinSec()
	;rightStr2 := day  . "`n" . rightStr2

	if(textOutFlag){
		rightStr2 := outs_textOutTrimss(rightStr2)
		; `n などを改行に変える。でも止める
		;Transform, rightStr2, Deref, %rightStr2%
	}
	rightStr2 .= "`n"
	FileAppend , %rightStr2%, %arg_1%

	if( guit_checkErrorLevelOutput("&outArgsToFileAssign のエラー`nファイルの書き出しに失敗している") ){
		guit_setExplain("コマンドの文字をファイルに書き出した`nファイル  " . arg_1, GuiNum)
	}
}

syf_outArgsTestType1(pOut, GuiNum){
	str := "type1。入力補完用のコマンドの参照する文字列をチェック。`ntype1では、引数は無しになる"

	editVar := guf_getControl( pOut, GuiNum )
	if(editVar == ""){
		guit_setExplain(str, GuiNum)
		return
	}
	buff := "引数`n無し`n"
	buff .= "参照する文字列`n" . editVar . "`n"
	buff .= "実行元コントロール`n" . pOut . "`n"
	buff .= "実行元Gui番号`n" . GuiNum
	guit_appendExplain(buff)
}

syf_outArgsTestType2_3_5(rightStr, pOut, GuiNum){
	str := "引数を表示する。ただそれだけ。"
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}
	if(rightStr == ""){
		guit_setExplain(str, GuiNum)
		return
	}

	buff := "引数全て`n" . rightStr
	;buff := "引数全て`n" . rightStr . "`n"
	;buff .= "実行元コントロール`n" . pOut . "`n"
	;buff .= "実行元Gui番号`n" . GuiNum
	guit_appendExplain(buff)
}

syf_outArgsTestType4(rightStr, editAll, rightStrAll, hwnd, pOut, GuiNum){
	str := "引数を表示する。ただそれだけ。"
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}
	if(rightStr == ""){
		guit_setExplain(str, GuiNum)
		return
	}
	buff := "引数全て`n" . rightStr . "`n"
	buff .= "テキスト全て`n" . editAll . "`n"
	buff .= "大本の引数`n" . rightStrAll . "`n"
	buff .= "実行元ハンドル`n" . hwnd . "`n"
	buff .= "実行元コントロール`n" . pOut . "`n"
	buff .= "実行元Gui番号`n" . GuiNum
	guit_appendExplain(buff)
}

syf_outArgsTestType6(com2, com3, com4, com5, com6, com7, GuiNum){
	str := "引数を表示する。ただそれだけ。"
	if( edc_helpViewIfHyphenH(str, com2, GuiNum) ){
		return
	}
	if(com2 == ""){
		guit_setExplain(str, GuiNum)
		return
	}

	buff =
	if(com2 != ""){
		buff := "引数１`n" . com2 . "`n"
	}
	if(com3 != ""){
		buff .= "引数２`n" . com3 . "`n"
	}
	if(com4 != ""){
		buff .= "引数３`n" . com4 . "`n"
	}
	if(com5 != ""){
		buff .= "引数４`n" . com5 . "`n"
	}
	if(com6 != ""){
		buff .= "引数５`n" . com6 . "`n"
	}
	if(com7 != ""){
		buff .= "引数６`n" . com7 . "`n"
	}

	guit_appendExplain(buff)
}

syf_OutCommToOutFile(rightStr, pOut, GuiNum){
	rightStr .= "`n"
	file := gloco_userDir . glob_outputFileName

	;day := func_getYearMonthDayHourMinSec()
	;rightStr := day  . "`n" . rightStr

	FileAppend , %rightStr%, %file%
	if( guit_checkErrorLevelOutput("ファイルの書き出しに失敗している") ){
		guit_setExplain("コマンドの文字をファイルに書き出した", GuiNum)
	}
}

/*
syf_defaultMake(com2, com3, pOut, GuiNum){
	helpStr := "今のuserの中身をdefaultにバックアップ。`nuser\defaultLog.txtにログを残す。`n３つめの引数にメモを書けば、メモがログに残る"
	if( edc_helpViewIfHyphenH(helpStr, com2, GuiNum) ){
		return
	}
	if( func_myFileExist(gloco_userDir) == False ){
		guit_errorAppend("userフォルダがないのでバックアップができない")
		return
	}
	day := func_getYearMonthDayHourMinSec()
	str := day . "  にuser内のファイルをdefaultにコピーした`n"
	if(com3 == ""){
		str .= "`n"
	} else {
		str .= com3 . "`n"
	}
	FileAppend , %str%, %gloco_userDir%%glob_defaultLogFileName%
	guit_checkErrorLevelOutput("user\defaultLog.txtにログを残す際にエラーあり")
	FileCopyDir, %gloco_userDir%, %glob_defaultDir%, 1
	res := guit_checkErrorLevelOutput("defaultへのコピー時にエラーあり")
	if(res) {
		guit_appendExplainNotShow(str)
		cen_anyFileEntryDisplay("今のuserの中身をdefaultにバックアップ", "")
	}
	edc_cleanEditEasy(pOut, GuiNum)
}
*/

syf_shutdownLogic(){
	;DetectHiddenWindows, On
	Gui, 88:Hide

/*
	SetTitleMatchMode, RegEx
	Loop, 20
	{
		WinClose, [\w\W]+
		IfWinNotActive , [\w\W]+
		{
			break
		}
		WinActivate ,[\w\W]+
		Sleep, 700
	}
*/


	if(glob_shutDownType == 1){
		Run, C:\WINDOWS\system32\shutdown.exe -s -t 0
	} else if(glob_shutDownType == 2) {
		Run, C:\WINDOWS\system32\shutdown.exe -r -f -t 0
	} else if(glob_shutDownType == 3){
		Run, C:\WINDOWS\system32\shutdown.exe -l
	} else if(glob_shutDownType == 4){
		Shutdown, %glob_ahkShutdownCode%
	}
}

syf_historyObjSave(){
	file := gloco_userDir . glob_historyListFileName
	func_folderCheckMakeFolder(gloco_userDir)
	if( func_myFileExist(file) ){
		FileDelete, %file%
	}

	str =
	for key, command in glob_tmpHistoryObj {
		if(command != "") {
			str .= command  . "`n"
		}
	}
	FileAppend , %str%, %file%
	guit_checkErrorLevelOutput("履歴のファイル保存時にエラー")
	;Sleep, 300
}


syf_cmdCommand(str, pControl, GuiNum) {
	if( str != "" ) {
		str := outs_textOutToAbsolePath(str, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
		type := func_myFileExistReturnType(str)
		IfInString, type, D
		{
			Run, %ComSpec%, %str%
		} else {
			guit_errorAppendOrSetExplain("&cmdのエラー`nフォルダ名が見つからない`n" . str, GuiNum)
		}
	} else {
		Run, %ComSpec%
	}
	;guf_setControl( "", pControl, GuiNum )
	;edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
}


syf_currentDirChange( EditVar, pOut, GuiNum ) {
	if(EditVar == "")
	{
		glob_pwdBackup = %A_WorkingDir%
		SetWorkingDir, %A_ScriptDir%
	} else if(EditVar == "-") {
		tmpStr = %A_WorkingDir%
		SetWorkingDir, %glob_pwdBackup%
		glob_pwdBackup = %tmpStr%
	} else {
		EditVar := outs_textOutDqAllTrim(EditVar)
		type := func_myFileExistReturnType(EditVar)
		IfInString, type, D
		{
			glob_pwdBackup = %A_WorkingDir%
			SetWorkingDir, %EditVar%
		} else {
			guit_errorAppendOrSetExplain("&cdのエラー`nフォルダ名が見つからない`n" . EditVar, GuiNum)
			return
		}
	}
	;guf_setControl( "", pOut, GuiNum )
	guit_setExplain(A_WorkingDir, GuiNum)

}


syf_sysCommandls(arg1, GuiNum){
	if(arg1 == "") {
		listFiless := func_getListFiles( ".\" )
		listFiless := RTrim(listFiless, "`n")
		guit_setExplainPurpose(listFiless, GuiNum)
	} else {
		arg1 := outs_textOutDqAllTrim(arg1)
		type := func_myFileExistReturnType(arg1)
		IfInString, type, D
		{
			listFiless := func_getListFiles( arg1 )
			listFiless := RTrim(listFiless, "`n")
			guit_setExplainPurpose(listFiless, GuiNum)
		} else {
			guit_setExplainPurpose("フォルダ名ではありません。`n" . arg1, GuiNum)
		}
	}
}


syf_myAsc(com2, com3, pControl, GuiNum=1) {
	if(com2 == "-hex") {
		num := Asc(com3)
		SetFormat, Integer, H
;		StringLeft, trimNum, num, 1		; こうすると 0x5 から 5 になる
		guit_setExplain(num, GuiNum)
	} else {
		str := Asc(com2)
		guit_setExplain(str, GuiNum)
	}
}

syf_myChr(com2, com3, pControl, GuiNum=1) {
	if(com2 == "-hex") {
		StringLeft, OutputVar, com3, 2
		if(OutputVar != "0x") {
			com3 := "0x" . com3
		}
		str := Chr(com3)
		guit_setExplain(str, GuiNum)
	} else {
		str := Chr(com2)
		guit_setExplain(str, GuiNum)
	}
}

syf_sysCommandmkdir(file, GuiNum) {
	str := "フォルダを作成する。`nFileCreateDir  を使った場合と何ら変わりはない"
	if( edc_helpViewIfHyphenH(str, file, GuiNum) ){
		return
	}
	if(file == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}

	file := outs_textOutDqAllTrim(file)
	FileCreateDir, %file%
	res1 := guit_checkErrorLevelOutput("&mkdir  のエラー。`n以下のフォルダを作れていない`n" . file)
	if(res1) {
		guit_setExplain(file . "  のフォルダを作成した", GuiNum)
	}
}

syf_menuShow(com2){
	if(com2 == ""){
		windc_anyWaitActive()
		Sleep, 100
		Menu, D_menuMain, Show, 10, 50
		return
	}
	res := syf_viewPropertiesOfFile(com2)
	if(res == False){
		guit_appendExplain("詳細を表示するファイルが見つからない")
	}
}

; ファイルがあったらプロパティを表示する
; 成功なら True
syf_viewPropertiesOfFile(file){
	file := outs_textOutToAbsolePath(file, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if( func_myFileExist(file) ){
		str := "properties " . file
		Run, %str% , , UseErrorLevel
		res := guit_checkErrorLevelOutput("詳細の表示に失敗している", A_LineFile, A_LineNumber)
		return  res
	}
	return  False
}

syf_cdmydocuComm(pOut, GuiNum){
	glob_pwdBackup = %A_WorkingDir%
	SetWorkingDir, %A_MyDocuments%
	;guf_setControl( "", pOut, GuiNum )
	guit_setExplain(A_WorkingDir, GuiNum)
}

syf_cdmainComm(pOut, GuiNum){
	glob_pwdBackup = %A_WorkingDir%
	SetWorkingDir, %A_ScriptDir%
	;guf_setControl( "", pOut, GuiNum )
	guit_setExplain(A_WorkingDir, GuiNum)
}

; コマンドストックＧｕｉのリストを変更
; 引数の数字のリストを表示する
; 引数がない場合は、次の数字のリストを表示する
; 引数が - の場合は、一つ前のリストを表示
syf_changeStockBlue(com2, com3, pOut, GuiNum){
	explain := "引数の数字のリストを表示する`n引数がない場合は、次の数字のリストを表示する`n-  一つ前のリストを表示`n-hide  表示させずにリストを変更させる。`n-tooltip  リストを変更させるが、リストのタイトルをツールチップで表示するだけにする。左下に２秒ほど表示するだけ。`n+数字  数字分スキップして変更する`n-数字  数字分スキップして変更する"
	if( edc_helpViewIfHyphenH(explain, com2, GuiNum) ){
		return
	}

	viewType = 1
	StringLower, tmpCom2, com2
	if(tmpCom2 == "-hide"){
		viewType = 2
		com2 := com3
	} else if( tmpCom2 == "-tooltip" ){
		viewType = 3
		com2 := com3
	}

	if(com2 == ""){
		com2 := guf_getControl( "ListBox77_1", 77 )
		com2++
	} else if(com2 == "-"){
		com2 := guf_getControl( "ListBox77_1", 77 )
		com2--
	} else {
		; +1 や -1 だった場合
		StringLeft, lChar, com2, 1
		if(lChar == "-"){
			StringTrimLeft, com2TrimLeft, com2, 1
			If com2TrimLeft is integer
			{
				listNum := guf_getControl( "ListBox77_1", 77 )
				com2 := listNum - com2TrimLeft
			}
		} else if(lChar == "+"){
			StringTrimLeft, com2TrimLeft, com2, 1
			If com2TrimLeft is integer
			{
				listNum := guf_getControl( "ListBox77_1", 77 )
				com2 := listNum + com2TrimLeft
			}
		}
	}

	If com2 is not integer
	{
		guit_setExplain(explain, GuiNum)
		return
	}
	if(com2 > 30  ||  com2 < 1){
		guit_setExplain(explain, GuiNum)
		return
	}
	listName := "type" . com2

	listTitle := chec_commStockListLoadLogic(listName, gloco_userDir . glob_commStockFile77Name, 77)
	guf_GuiControl("ListBox77_1", 77, "Choose", com2)
	guit_checkErrorLevelOutput("&stockChangeBlue 時のエラー")

	if(viewType == 2){
		return
	} else if( viewType == 3 ){
		guit_setExplainToolTip(listTitle)
		return
	}
	if( glob_iniStock_sec == 0 ){
		guf_showGuiAssign(77, " NA")
		return
	}
	guit_showGuiEnyAutoClose(glob_iniStock_sec, "gGlob_timerGui77", "SubGui77Close", "77", " NA")
}

syf_changeStockGreen(com2, com3, pOut, GuiNum){
	explain := "引数の数字のリストを表示する`n引数がない場合は、次の数字のリストを表示する`n-  一つ前のリストを表示`n-hide  表示させずにリストを変更させる。`n-tooltip  リストを変更させるが、リストのタイトルをツールチップで表示するだけにする。左下に２秒ほど表示するだけ。`n+数字  数字分スキップして変更する`n-数字  数字分スキップして変更する"
	if( edc_helpViewIfHyphenH(explain, com2, GuiNum) ){
		return
	}

	viewType = 1
	StringLower, tmpCom2, com2
	if(tmpCom2 == "-hide"){
		viewType = 2
		com2 := com3
	} else if( tmpCom2 == "-tooltip" ){
		viewType = 3
		com2 := com3
	}

	if(com2 == ""){
		com2 := guf_getControl( "ListBox78_1", 78 )
		com2++
	} else if(com2 == "-"){
		com2 := guf_getControl( "ListBox78_1", 78 )
		com2--
	} else {
		; +1 や -1 だった場合
		StringLeft, lChar, com2, 1
		if(lChar == "-"){
			StringTrimLeft, com2TrimLeft, com2, 1
			If com2TrimLeft is integer
			{
				listNum := guf_getControl( "ListBox78_1", 78 )
				com2 := listNum - com2TrimLeft
			}
		} else if(lChar == "+"){
			StringTrimLeft, com2TrimLeft, com2, 1
			If com2TrimLeft is integer
			{
				listNum := guf_getControl( "ListBox78_1", 78 )
				com2 := listNum + com2TrimLeft
			}
		}
	}

	If com2 is not integer
	{
		guit_setExplain(explain, GuiNum)
		return
	}
	if(com2 > 30  ||  com2 < 1){
		guit_setExplain(explain, GuiNum)
		return
	}
	listName := "type" . com2

	listTitle := chec_commStockListLoadLogic(listName, gloco_userDir . glob_commStockFile78Name, 78)
	guf_GuiControl("ListBox78_1", 78, "Choose", com2)
	guit_checkErrorLevelOutput("&stockChangeGreen 時のエラー")

	if(viewType == 2){
		return
	} else if( viewType == 3 ){
		guit_setExplainToolTip(listTitle)
		return
	}
	if( glob_iniStock_sec == 0 ){
		guf_showGuiAssign(78, " NA")
		return
	}
	guit_showGuiEnyAutoClose(glob_iniStock_sec, "gGlob_timerGui78", "SubGui78Close", "78", " NA")
}

syf_showGui75AndSetting(){
	guf_setControl( glob_runAsStatus, "Text75_1", 75 )
	admin = 
	if(A_ISAdmin == 1){
		admin := "True"
	} else {
		admin := "False"
	}
	guf_setControl( admin, "Text75_2", 75 )
	Gui, 75:Show
}

syf_spaceOptionFlagChange(flagStr, GuiNum){
	if( func_checkFlagStr(flagStr) == False ){
		guit_errorAppend("&config のエラー`n引数２には on か off を入れること")
		return
	}
	flag := func_getFlagByOnOffStr(flagStr)
	;glob_iniSpaceFileNotFlag := flag
	O_spaceFileNotFlag := flag
	guf_setControl( flag, "Checkbox74_1", 74 )
	configFile := gloco_userDir . glob_configFileName
	;IniWrite, %glob_iniSpaceFileNotFlag%,     %configFile%, config, spaceFile
	IniWrite, %O_spaceFileNotFlag%,     %configFile%, config, spaceFile
	res := guit_checkErrorLevelOutput("設定ファイルの書き込み時にエラーあり")
	if( res ){
		flagStr := func_trueFalseStr(flag)
		guit_setExplain("「空白のあるファイルを自動的に調べて対応する、という処理をしない」を " . flagStr . " に設定した。", GuiNum)
	}
}

syf_startUpOptionFlagChange(flagStr, GuiNum){
	if( func_checkFlagStr(flagStr) == False ){
		guit_errorAppend("&config のエラー`n引数２には on か off を入れること")
		return
	}
	flag := func_getFlagByOnOffStr(flagStr)
	glob_iniStartUpOptionFlag := flag
	guf_setControl( flag, "Checkbox74_8", 74 )
	configFile := gloco_userDir . glob_configFileName
	IniWrite, %glob_iniStartUpOptionFlag%,     %configFile%, config, startUpOptionFlag
	res := guit_checkErrorLevelOutput("設定ファイルの書き込み時にエラーあり")
	if( res ){
		flagStr := func_trueFalseStr(flag)
		guit_setExplain("「起動時に実行する１」を " . flagStr . " に設定した。", GuiNum)
	}
}

syf_startUpOptionTextChange(str, GuiNum){
	glob_iniStartUpOptionText := str
	guf_setControl( str, "Edit74_4", 74 )
	configFile := gloco_userDir . glob_configFileName
	IniWrite, %glob_iniStartUpOptionText%,     %configFile%, config, startUpOptionText
	res := guit_checkErrorLevelOutput("設定ファイルの書き込み時にエラーあり")
	if( res ){
		if(str == ""){
			str := "空"
		}
		guit_setExplain("「起動時に実行する１の処理を」  " . str  . "  に設定した。", GuiNum)
	}
}

syf_clickOnlyGuiOptionChange(flagStr, GuiNum){
	if( func_checkFlagStr(flagStr) == False ){
		guit_errorAppend("&config のエラー`n引数２には on か off を入れること")
		return
	}
	flag := func_getFlagByOnOffStr(flagStr)
	res := syf_clickOnlyGuiOptionChangeLogic(flag)
	if( res ){
		flagStr := func_trueFalseStr(flag)
		guit_setExplain("「起動時にマウス操作のためのウインドウを表示しない」を " . flagStr . " に設定した。", GuiNum)
	}
}

syf_clickOnlyGuiOptionChangeLogic(flag){
	glob_iniClickOnlyGuiNotFlag := flag
	guf_setControl( flag, "Checkbox74_9", 74 )
	configFile := gloco_userDir . glob_configFileName
	IniWrite, %glob_iniClickOnlyGuiNotFlag%,     %configFile%, config, clickOnlyGuiFlag
	res := guit_checkErrorLevelOutput("設定ファイルの書き込み時にエラーあり")
	; クリックのためのウインドウを表示
	;cen_clickOnlyGuiShow()
	return  res
}

syf_lastWordAllOptionChange(flagStr, GuiNum){
	if( func_checkFlagStr(flagStr) == False ){
		guit_errorAppend("&config のエラー`n引数２には on か off を入れること")
		return
	}
	flag := func_getFlagByOnOffStr(flagStr)
	glob_iniLastWordExeAllFlag := flag

	guf_setControl( flag, "Checkbox84_1", 84 )

	lastConfigFile := gloco_userDir . glob_lastWordExeConfigFileName
	IniWrite, %glob_iniLastWordExeAllFlag%,     %lastConfigFile%, lastConfig, lastWordExeAllFlag
	res := guit_checkErrorLevelOutput("設定ファイルの書き込み時にエラーあり")
	if( res ){
		flagStr := func_trueFalseStr(flag)
		guit_setExplain("「最後の文字によって、自動的に決定する」を " . flagStr . " に設定した。", GuiNum)
	}
}

syf_popupOptionFlagChange(flagStr, GuiNum){
	if( func_checkFlagStr(flagStr) == False ){
		guit_errorAppend("&config のエラー`n引数２には on か off を入れること")
		return
	}
	flag := func_getFlagByOnOffStr(flagStr)

	;glob_iniAutoPopupNotViewFlag := flag
	O_inputListAutoNotFlag := flag
	guf_setControl( flag, "Checkbox74_10", 74 )
	configFile := gloco_userDir . glob_configFileName
	;IniWrite, %glob_iniAutoPopupNotViewFlag%,     %configFile%, config, autoPopupViewFlag
	IniWrite, %O_inputListAutoNotFlag%,     %configFile%, config, autoPopupViewFlag
	res := guit_checkErrorLevelOutput("設定ファイルの書き込み時にエラーあり")
	if( res ){
		flagStr := func_trueFalseStr(flag)
		guit_setExplain("「自動で入力補完を表示しない」を " . flagStr . " に設定した。", GuiNum)
	}
}

syf_configCommand(com2, com3, pOut, GuiNum){
	str := "引数なしなら、設定のGUIを表示`n引数１で各種設定を指示し、引数２に on か off を入れる。（TrueかFalseでも可能）`n引数１の種類`n-startupflag`n-startuptext`n-clickwindow`n-space`n-popup`n-lastword`n"
	if( edc_helpViewIfHyphenH(str, com2, GuiNum) ){
		return
	}
	if(com2 == ""){
		syf_showGui74SetConfig()
		return
	}

	if(com2 == "-startupflag"){
		syf_startUpOptionFlagChange(com3, GuiNum)
	} else if(com2 == "-startuptext"){
		syf_startUpOptionTextChange(com3, GuiNum)
	} else if(com2 == "-clickwindow"){
		syf_clickOnlyGuiOptionChange(com3, GuiNum)
	} else if(com2 == "-space"){
		syf_spaceOptionFlagChange(com3, GuiNum)
	} else if(com2 == "-lastword"){
		syf_lastWordAllOptionChange(com3, GuiNum)
	} else if(com2 == "-popup"){
		syf_popupOptionFlagChange(com3, GuiNum)
	} else {
		guit_setExplain(str, GuiNum)
	}
}

syf_startupFlagCommand(com2, GuiNum){
	str := "設定の「起動時に実行」のチェックを操作する。`n&config startupflag  と同じ`n引数１に on か off を入れる。（TrueかFalseでも可能）"
	if( edc_helpViewIfHyphenH(str, com2, GuiNum) ){
		return
	}
	syf_startUpOptionFlagChange(com2, GuiNum)
}

syf_managerGuiSet(){
	guf_setControl( glob_iniEasyCheck, "Checkbox81_1", 81 )

	;なぜか最前面に表示されないので遅らせる
	Sleep, 300
	Gui, 81:Show
}

syf_managerConfigWrite(){
	glob_iniEasyCheck := guf_getControl( "Checkbox81_1", 81 )

	IniWrite, %glob_iniEasyCheck%,     %glob_managerConfigFile%, config, commOutput

	guit_checkErrorLevelOutput("管理者用設定ファイルの書き込み時にエラーあり")
	Gui, 81:Show, Hide
}

syf_showAndLastWordConfigGuiSet(order="_", sleepFlag=True){
	; コントロールを有効にしてから設定
	;cen_switchEnableLastWordGui(True)
	;cen_switchEnableLastWordAnyTab(True, 2)
	;cen_switchEnableLastWordAnyTab(True, 3)
	;cen_switchEnableLastWordAnyTab(True, 4)
	;cen_switchEnableLastWordAnyTab(True, 5)

	guf_setControl( glob_iniLastWordExeAllFlag, "Checkbox84_1", 84 )
	guf_setControl( glob_iniLastWordExeEnterFlag, "Checkbox84_2", 84 )
	guf_setControl( glob_iniLastWordExeEnterText, "Edit84_2", 84 )
	guf_setControl( glob_iniLastWordExeCtrlNumFlag, "Checkbox84_3", 84 )
	guf_setControl( glob_iniLastWordExeCtrlNumText, "Edit84_3", 84 )
	guf_setControl( glob_iniLastWordExeShiftCtrlNumFlag, "Checkbox84_4", 84 )
	guf_setControl( glob_iniLastWordExeShiftCtrlNumText, "Edit84_4", 84 )
	guf_setControl( glob_iniLastWordExePuppupViewFlag, "Checkbox84_5", 84 )
	guf_setControl( glob_iniLastWordExePuppupViewText, "Edit84_5", 84 )
	guf_setControl( glob_iniLastWordExeEnterText2, "Edit84_6", 84 )
	guf_setControl( glob_iniLastWordTextCleanFlag, "Checkbox84_7", 84 )
	guf_setControl( glob_iniLastWordTextCleanText, "Edit84_7", 84 )
	guf_setControl( glob_iniLastWordExeUseTextNumFlag, "Checkbox84_8", 84 )
	guf_setControl( glob_iniLastWordExeUseTextNumText, "Edit84_8", 84 )
	guf_setControl( glob_iniLastWordAsHeadExeFlag, "Checkbox84_9", 84 )
	guf_setControl( glob_iniLastWordAsHeadExeText, "Edit84_9", 84 )
	guf_setControl( glob_iniLastWordSpaceSendFlag, "Checkbox84_10", 84 )
	guf_setControl( glob_iniLastWordSpaceSendText, "Edit84_10", 84 )

	guf_setControl( O_lastWordTabAllFlag2, "Checkbox84_2_1", 84 )
	guf_setControl( O_lastWordScript2_1, "Edit84_2_1_1", 84 )
	guf_setControl( O_lastWordScript2_2, "Edit84_2_2_1", 84 )
	guf_setControl( O_lastWordScript2_3, "Edit84_2_3_1", 84 )
	guf_setControl( O_lastWordScript2_4, "Edit84_2_4_1", 84 )
	guf_setControl( O_lastWordScript2_5, "Edit84_2_5_1", 84 )
	guf_setControl( O_lastWordScript2_6, "Edit84_2_6_1", 84 )
	guf_setControl( O_lastWordScript2_7, "Edit84_2_7_1", 84 )
	guf_setControl( O_lastWordScript2_8, "Edit84_2_8_1", 84 )
	guf_setControl( O_lastWordScript2_9, "Edit84_2_9_1", 84 )
	guf_setControl( O_lastWordScript2_10, "Edit84_2_10_1", 84 )

	guf_setControl( O_lastWordKey2_1, "Edit84_2_1_2", 84 )
	guf_setControl( O_lastWordKey2_2, "Edit84_2_2_2", 84 )
	guf_setControl( O_lastWordKey2_3, "Edit84_2_3_2", 84 )
	guf_setControl( O_lastWordKey2_4, "Edit84_2_4_2", 84 )
	guf_setControl( O_lastWordKey2_5, "Edit84_2_5_2", 84 )
	guf_setControl( O_lastWordKey2_6, "Edit84_2_6_2", 84 )
	guf_setControl( O_lastWordKey2_7, "Edit84_2_7_2", 84 )
	guf_setControl( O_lastWordKey2_8, "Edit84_2_8_2", 84 )
	guf_setControl( O_lastWordKey2_9, "Edit84_2_9_2", 84 )
	guf_setControl( O_lastWordKey2_10, "Edit84_2_10_2", 84 )


	guf_setControl( O_lastWordTabAllFlag3, "Checkbox84_3_1", 84 )
	guf_setControl( O_lastWordScript3_1, "Edit84_3_1_1", 84 )
	guf_setControl( O_lastWordScript3_2, "Edit84_3_2_1", 84 )
	guf_setControl( O_lastWordScript3_3, "Edit84_3_3_1", 84 )
	guf_setControl( O_lastWordScript3_4, "Edit84_3_4_1", 84 )
	guf_setControl( O_lastWordScript3_5, "Edit84_3_5_1", 84 )
	guf_setControl( O_lastWordScript3_6, "Edit84_3_6_1", 84 )
	guf_setControl( O_lastWordScript3_7, "Edit84_3_7_1", 84 )
	guf_setControl( O_lastWordScript3_8, "Edit84_3_8_1", 84 )
	guf_setControl( O_lastWordScript3_9, "Edit84_3_9_1", 84 )
	guf_setControl( O_lastWordScript3_10, "Edit84_3_10_1", 84 )

	guf_setControl( O_lastWordKey3_1, "Edit84_3_1_2", 84 )
	guf_setControl( O_lastWordKey3_2, "Edit84_3_2_2", 84 )
	guf_setControl( O_lastWordKey3_3, "Edit84_3_3_2", 84 )
	guf_setControl( O_lastWordKey3_4, "Edit84_3_4_2", 84 )
	guf_setControl( O_lastWordKey3_5, "Edit84_3_5_2", 84 )
	guf_setControl( O_lastWordKey3_6, "Edit84_3_6_2", 84 )
	guf_setControl( O_lastWordKey3_7, "Edit84_3_7_2", 84 )
	guf_setControl( O_lastWordKey3_8, "Edit84_3_8_2", 84 )
	guf_setControl( O_lastWordKey3_9, "Edit84_3_9_2", 84 )
	guf_setControl( O_lastWordKey3_10, "Edit84_3_10_2", 84 )


	guf_setControl( O_lastWordTabAllFlag4, "Checkbox84_4_1", 84 )
	guf_setControl( O_lastWordScript4_1, "Edit84_4_1_1", 84 )
	guf_setControl( O_lastWordScript4_2, "Edit84_4_2_1", 84 )
	guf_setControl( O_lastWordScript4_3, "Edit84_4_3_1", 84 )
	guf_setControl( O_lastWordScript4_4, "Edit84_4_4_1", 84 )
	guf_setControl( O_lastWordScript4_5, "Edit84_4_5_1", 84 )
	guf_setControl( O_lastWordScript4_6, "Edit84_4_6_1", 84 )
	guf_setControl( O_lastWordScript4_7, "Edit84_4_7_1", 84 )
	guf_setControl( O_lastWordScript4_8, "Edit84_4_8_1", 84 )
	guf_setControl( O_lastWordScript4_9, "Edit84_4_9_1", 84 )
	guf_setControl( O_lastWordScript4_10, "Edit84_4_10_1", 84 )

	guf_setControl( O_lastWordKey4_1, "Edit84_4_1_2", 84 )
	guf_setControl( O_lastWordKey4_2, "Edit84_4_2_2", 84 )
	guf_setControl( O_lastWordKey4_3, "Edit84_4_3_2", 84 )
	guf_setControl( O_lastWordKey4_4, "Edit84_4_4_2", 84 )
	guf_setControl( O_lastWordKey4_5, "Edit84_4_5_2", 84 )
	guf_setControl( O_lastWordKey4_6, "Edit84_4_6_2", 84 )
	guf_setControl( O_lastWordKey4_7, "Edit84_4_7_2", 84 )
	guf_setControl( O_lastWordKey4_8, "Edit84_4_8_2", 84 )
	guf_setControl( O_lastWordKey4_9, "Edit84_4_9_2", 84 )
	guf_setControl( O_lastWordKey4_10, "Edit84_4_10_2", 84 )

	guf_setControl( O_lastWordTabAllFlag5, "Checkbox84_5_1", 84 )
	guf_setControl( O_lastWordScript5_1, "Edit84_5_1_1", 84 )
	guf_setControl( O_lastWordScript5_2, "Edit84_5_2_1", 84 )
	guf_setControl( O_lastWordScript5_3, "Edit84_5_3_1", 84 )
	guf_setControl( O_lastWordScript5_4, "Edit84_5_4_1", 84 )
	guf_setControl( O_lastWordScript5_5, "Edit84_5_5_1", 84 )
	guf_setControl( O_lastWordScript5_6, "Edit84_5_6_1", 84 )
	guf_setControl( O_lastWordScript5_7, "Edit84_5_7_1", 84 )
	guf_setControl( O_lastWordScript5_8, "Edit84_5_8_1", 84 )
	guf_setControl( O_lastWordScript5_9, "Edit84_5_9_1", 84 )
	guf_setControl( O_lastWordScript5_10, "Edit84_5_10_1", 84 )

	guf_setControl( O_lastWordKey5_1, "Edit84_5_1_2", 84 )
	guf_setControl( O_lastWordKey5_2, "Edit84_5_2_2", 84 )
	guf_setControl( O_lastWordKey5_3, "Edit84_5_3_2", 84 )
	guf_setControl( O_lastWordKey5_4, "Edit84_5_4_2", 84 )
	guf_setControl( O_lastWordKey5_5, "Edit84_5_5_2", 84 )
	guf_setControl( O_lastWordKey5_6, "Edit84_5_6_2", 84 )
	guf_setControl( O_lastWordKey5_7, "Edit84_5_7_2", 84 )
	guf_setControl( O_lastWordKey5_8, "Edit84_5_8_2", 84 )
	guf_setControl( O_lastWordKey5_9, "Edit84_5_9_2", 84 )
	guf_setControl( O_lastWordKey5_10, "Edit84_5_10_2", 84 )


	guf_setControl( glob_iniBetweenExeWordEndFlag, "Checkbox84_sendEnd", 84 )
	guf_setControl( glob_iniBetweenExeWordEndKey, "Edit84_sendEnd", 84 )

	guf_setControl( O_betweenWordTabAllFlag1, "Checkbox84_6_1", 84 )
	guf_setControl( O_betweenWordScript1_1, "Edit84_6_1_1", 84 )
	guf_setControl( O_betweenWordScript1_2, "Edit84_6_2_1", 84 )
	guf_setControl( O_betweenWordScript1_3, "Edit84_6_3_1", 84 )
	guf_setControl( O_betweenWordScript1_4, "Edit84_6_4_1", 84 )
	guf_setControl( O_betweenWordScript1_5, "Edit84_6_5_1", 84 )
	guf_setControl( O_betweenWordScript1_6, "Edit84_6_6_1", 84 )
	guf_setControl( O_betweenWordScript1_7, "Edit84_6_7_1", 84 )
	guf_setControl( O_betweenWordScript1_8, "Edit84_6_8_1", 84 )
	guf_setControl( O_betweenWordScript1_9, "Edit84_6_9_1", 84 )
	guf_setControl( O_betweenWordScript1_10, "Edit84_6_10_1", 84 )

	guf_setControl( O_betweenWordKey1_1, "Edit84_6_1_2", 84 )
	guf_setControl( O_betweenWordKey1_2, "Edit84_6_2_2", 84 )
	guf_setControl( O_betweenWordKey1_3, "Edit84_6_3_2", 84 )
	guf_setControl( O_betweenWordKey1_4, "Edit84_6_4_2", 84 )
	guf_setControl( O_betweenWordKey1_5, "Edit84_6_5_2", 84 )
	guf_setControl( O_betweenWordKey1_6, "Edit84_6_6_2", 84 )
	guf_setControl( O_betweenWordKey1_7, "Edit84_6_7_2", 84 )
	guf_setControl( O_betweenWordKey1_8, "Edit84_6_8_2", 84 )
	guf_setControl( O_betweenWordKey1_9, "Edit84_6_9_2", 84 )
	guf_setControl( O_betweenWordKey1_10, "Edit84_6_10_2", 84 )

	guf_setControl( glob_iniLastWordChangeHalfNumFlag, "Checkbox84_7_num", 84 )
	guf_setControl( glob_iniLastWordChangeFlag1, "Checkbox84_7_1", 84 )
	guf_setControl( glob_iniLastWordChangeAfter1, "Edit84_7_1_1", 84 )
	guf_setControl( glob_iniLastWordChangeChoice1_1, "Edit84_7_1_2", 84 )
	guf_setControl( glob_iniLastWordChangeChoice1_2, "Edit84_7_1_3", 84 )
	guf_setControl( glob_iniLastWordChangeChoice1_3, "Edit84_7_1_4", 84 )
	guf_setControl( glob_iniLastWordChangeFlag2, "Checkbox84_7_2", 84 )
	guf_setControl( glob_iniLastWordChangeAfter2, "Edit84_7_2_1", 84 )
	guf_setControl( glob_iniLastWordChangeChoice2_1, "Edit84_7_2_2", 84 )
	guf_setControl( glob_iniLastWordChangeChoice2_2, "Edit84_7_2_3", 84 )
	guf_setControl( glob_iniLastWordChangeChoice2_3, "Edit84_7_2_4", 84 )
	guf_setControl( glob_iniLastWordChangeFlag3, "Checkbox84_7_3", 84 )
	guf_setControl( glob_iniLastWordChangeAfter3, "Edit84_7_3_1", 84 )
	guf_setControl( glob_iniLastWordChangeChoice3_1, "Edit84_7_3_2", 84 )
	guf_setControl( glob_iniLastWordChangeChoice3_2, "Edit84_7_3_3", 84 )
	guf_setControl( glob_iniLastWordChangeChoice3_3, "Edit84_7_3_4", 84 )


	cen_switchEnableLastWordGui(glob_iniLastWordExeAllFlag)
	cen_switchEnableLastWordAnyTab(O_lastWordTabAllFlag2, 2)
	cen_switchEnableLastWordAnyTab(O_lastWordTabAllFlag3, 3)
	cen_switchEnableLastWordAnyTab(O_lastWordTabAllFlag4, 4)
	cen_switchEnableLastWordAnyTab(O_lastWordTabAllFlag5, 5)
	cen_switchEnableLastWordAnyTab(O_betweenWordTabAllFlag1, 6)

	cen_switchEnableLastWordChangeChoice(glob_iniLastWordChangeFlag1, "Edit84_7_1_1", "Edit84_7_1_2", "Edit84_7_1_3", "Edit84_7_1_4")
	cen_switchEnableLastWordChangeChoice(glob_iniLastWordChangeFlag2, "Edit84_7_2_1", "Edit84_7_2_2", "Edit84_7_2_3", "Edit84_7_2_4")
	cen_switchEnableLastWordChangeChoice(glob_iniLastWordChangeFlag3, "Edit84_7_3_1", "Edit84_7_3_2", "Edit84_7_3_3", "Edit84_7_3_4")

	;GuiControl, 84:Choose, Tab84_1, 1

	;なぜか最前面に表示されないので遅らせる
	if( sleepFlag ){
		Sleep, 300
	}
	guf_showGuiAssign(84, order)
}

syf_showSetLastWordConfigToggle(order="_", sleepFlag=True){
	IfWinExist, %gGlob_Gui84Title%
	{
		Gui, 84:Hide
	} else {
		syf_showAndLastWordConfigGuiSet(order, sleepFlag)
	}
}

syf_lastWordConfigGuiSetting(){
	Edit84_2 := guf_getControl( "Edit84_2", 84 )
	Edit84_3 := guf_getControl( "Edit84_3", 84 )
	Edit84_4 := guf_getControl( "Edit84_4", 84 )
	Edit84_5 := guf_getControl( "Edit84_5", 84 )
	Edit84_6 := guf_getControl( "Edit84_6", 84 )
	Edit84_7 := guf_getControl( "Edit84_7", 84 )
	Edit84_8 := guf_getControl( "Edit84_8", 84 )
	Edit84_9 := guf_getControl( "Edit84_9", 84 )
	Edit84_10 := guf_getControl( "Edit84_10", 84 )

	if( lasw_errorLastWord(Edit84_2) ){
		guit_errorAppend("（１）の文字が記入されていない。`n初期値を設定する。")
		Edit84_2 := init_trimBrackets(defa_defaultIniLastWordExeEnterText)
	}
	if( lasw_errorLastWord(Edit84_3) ){
		guit_errorAppend("（３）の文字が記入されていない。`n初期値を設定する。")
		Edit84_3 := init_trimBrackets(defa_defaultIniLastWordExeCtrlNumText)
	}
	if( lasw_errorLastWord(Edit84_4) ){
		guit_errorAppend("（４）の文字が記入されていない。`n初期値を設定する。")
		Edit84_4 := init_trimBrackets(defa_defaultIniLastWordExeShiftCtrlNumText)
	}
	if( lasw_errorLastWord(Edit84_5) ){
		guit_errorAppend("（６）の文字が記入されていない。`n初期値を設定する。")
		Edit84_5 := init_trimBrackets(defa_defaultIniLastWordExePuppupViewText)
	}
	if( lasw_errorLastWord(Edit84_6) ){
		guit_errorAppend("（２）の文字が記入されていない。`n初期値を設定する。")
		Edit84_6 := init_trimBrackets(defa_defaultIniLastWordExeEnterText2)
	}
	if( lasw_errorLastWord(Edit84_7) ){
		guit_errorAppend("（７）の文字が記入されていない。`n初期値を設定する。")
		Edit84_7 := init_trimBrackets(defa_defaultIniLastWordTextCleanText)
	}
	if( lasw_errorLastWord(Edit84_8) ){
		guit_errorAppend("（５）の文字が記入されていない。`n初期値を設定する。")
		Edit84_8 := init_trimBrackets(defa_defaultIniLastWordExeUseTextNumText)
	}
	if( lasw_errorLastWord(Edit84_9) ){
		guit_errorAppend("（８）の文字が記入されていない。`n初期値を設定する。")
		Edit84_9 := init_trimBrackets(defa_defaultIniLastWordAsHeadExeText)
	}
	if( lasw_errorLastWord(Edit84_10) ){
		guit_errorAppend("（９）の文字が記入されていない。`n初期値を設定する。")
		Edit84_10 := init_trimBrackets(defa_defaultIniLastWordSpaceSendText)
	}

	glob_iniLastWordExeAllFlag := guf_getControl( "Checkbox84_1", 84 )

	glob_iniLastWordExeEnterFlag := guf_getControl( "Checkbox84_2", 84 )
	glob_iniLastWordExeEnterText := Edit84_2

	glob_iniLastWordExeCtrlNumFlag := guf_getControl( "Checkbox84_3", 84 )
	glob_iniLastWordExeCtrlNumText := Edit84_3

	glob_iniLastWordExeShiftCtrlNumFlag := guf_getControl( "Checkbox84_4", 84 )
	glob_iniLastWordExeShiftCtrlNumText := Edit84_4

	glob_iniLastWordExePuppupViewFlag := guf_getControl( "Checkbox84_5", 84 )
	glob_iniLastWordExePuppupViewText := Edit84_5
	glob_iniLastWordExeEnterText2 := Edit84_6

	glob_iniLastWordTextCleanFlag := guf_getControl( "Checkbox84_7", 84 )
	glob_iniLastWordTextCleanText := Edit84_7

	glob_iniLastWordExeUseTextNumFlag := guf_getControl( "Checkbox84_8", 84 )
	glob_iniLastWordExeUseTextNumText := Edit84_8

	glob_iniLastWordAsHeadExeFlag := guf_getControl( "Checkbox84_9", 84 )
	glob_iniLastWordAsHeadExeText := Edit84_9

	glob_iniLastWordSpaceSendFlag := guf_getControl( "Checkbox84_10", 84 )
	glob_iniLastWordSpaceSendText := Edit84_10


	O_lastWordTabAllFlag2 := guf_getControl( "Checkbox84_2_1", 84 )
	O_lastWordScript2_1 := guf_getControl( "Edit84_2_1_1", 84 )
	O_lastWordScript2_2 := guf_getControl( "Edit84_2_2_1", 84 )
	O_lastWordScript2_3 := guf_getControl( "Edit84_2_3_1", 84 )
	O_lastWordScript2_4 := guf_getControl( "Edit84_2_4_1", 84 )
	O_lastWordScript2_5 := guf_getControl( "Edit84_2_5_1", 84 )
	O_lastWordScript2_6 := guf_getControl( "Edit84_2_6_1", 84 )
	O_lastWordScript2_7 := guf_getControl( "Edit84_2_7_1", 84 )
	O_lastWordScript2_8 := guf_getControl( "Edit84_2_8_1", 84 )
	O_lastWordScript2_9 := guf_getControl( "Edit84_2_9_1", 84 )
	O_lastWordScript2_10 := guf_getControl( "Edit84_2_10_1", 84 )


	O_lastWordScript2_1 := Trim(O_lastWordScript2_1)
	O_lastWordScript2_2 := Trim(O_lastWordScript2_2)
	O_lastWordScript2_3 := Trim(O_lastWordScript2_3)
	O_lastWordScript2_4 := Trim(O_lastWordScript2_4)
	O_lastWordScript2_5 := Trim(O_lastWordScript2_5)
	O_lastWordScript2_6 := Trim(O_lastWordScript2_6)
	O_lastWordScript2_7 := Trim(O_lastWordScript2_7)
	O_lastWordScript2_8 := Trim(O_lastWordScript2_8)
	O_lastWordScript2_9 := Trim(O_lastWordScript2_9)
	O_lastWordScript2_10 := Trim(O_lastWordScript2_10)


	O_lastWordKey2_1 := guf_getControl( "Edit84_2_1_2", 84 )
	O_lastWordKey2_2 := guf_getControl( "Edit84_2_2_2", 84 )
	O_lastWordKey2_3 := guf_getControl( "Edit84_2_3_2", 84 )
	O_lastWordKey2_4 := guf_getControl( "Edit84_2_4_2", 84 )
	O_lastWordKey2_5 := guf_getControl( "Edit84_2_5_2", 84 )
	O_lastWordKey2_6 := guf_getControl( "Edit84_2_6_2", 84 )
	O_lastWordKey2_7 := guf_getControl( "Edit84_2_7_2", 84 )
	O_lastWordKey2_8 := guf_getControl( "Edit84_2_8_2", 84 )
	O_lastWordKey2_9 := guf_getControl( "Edit84_2_9_2", 84 )
	O_lastWordKey2_10 := guf_getControl( "Edit84_2_10_2", 84 )

	if( lasw_errorLastWord(O_lastWordKey2_1) ){
		O_lastWordKey2_1 =
	}
	if( lasw_errorLastWord(O_lastWordKey2_2) ){
		O_lastWordKey2_2 =
	}
	if( lasw_errorLastWord(O_lastWordKey2_3) ){
		O_lastWordKey2_3 =
	}
	if( lasw_errorLastWord(O_lastWordKey2_4) ){
		O_lastWordKey2_4 =
	}
	if( lasw_errorLastWord(O_lastWordKey2_5) ){
		O_lastWordKey2_5 =
	}
	if( lasw_errorLastWord(O_lastWordKey2_6) ){
		O_lastWordKey2_6 =
	}
	if( lasw_errorLastWord(O_lastWordKey2_7) ){
		O_lastWordKey2_7 =
	}
	if( lasw_errorLastWord(O_lastWordKey2_8) ){
		O_lastWordKey2_8 =
	}
	if( lasw_errorLastWord(O_lastWordKey2_9) ){
		O_lastWordKey2_9 =
	}
	if( lasw_errorLastWord(O_lastWordKey2_10) ){
		O_lastWordKey2_10 =
	}


	O_lastWordTabAllFlag3 := guf_getControl( "Checkbox84_3_1", 84 )
	O_lastWordScript3_1 := guf_getControl( "Edit84_3_1_1", 84 )
	O_lastWordScript3_2 := guf_getControl( "Edit84_3_2_1", 84 )
	O_lastWordScript3_3 := guf_getControl( "Edit84_3_3_1", 84 )
	O_lastWordScript3_4 := guf_getControl( "Edit84_3_4_1", 84 )
	O_lastWordScript3_5 := guf_getControl( "Edit84_3_5_1", 84 )
	O_lastWordScript3_6 := guf_getControl( "Edit84_3_6_1", 84 )
	O_lastWordScript3_7 := guf_getControl( "Edit84_3_7_1", 84 )
	O_lastWordScript3_8 := guf_getControl( "Edit84_3_8_1", 84 )
	O_lastWordScript3_9 := guf_getControl( "Edit84_3_9_1", 84 )
	O_lastWordScript3_10 := guf_getControl( "Edit84_3_10_1", 84 )

	O_lastWordScript3_1 := Trim(O_lastWordScript3_1)
	O_lastWordScript3_2 := Trim(O_lastWordScript3_2)
	O_lastWordScript3_3 := Trim(O_lastWordScript3_3)
	O_lastWordScript3_4 := Trim(O_lastWordScript3_4)
	O_lastWordScript3_5 := Trim(O_lastWordScript3_5)
	O_lastWordScript3_6 := Trim(O_lastWordScript3_6)
	O_lastWordScript3_7 := Trim(O_lastWordScript3_7)
	O_lastWordScript3_8 := Trim(O_lastWordScript3_8)
	O_lastWordScript3_9 := Trim(O_lastWordScript3_9)
	O_lastWordScript3_10 := Trim(O_lastWordScript3_10)


	O_lastWordKey3_1 := guf_getControl( "Edit84_3_1_2", 84 )
	O_lastWordKey3_2 := guf_getControl( "Edit84_3_2_2", 84 )
	O_lastWordKey3_3 := guf_getControl( "Edit84_3_3_2", 84 )
	O_lastWordKey3_4 := guf_getControl( "Edit84_3_4_2", 84 )
	O_lastWordKey3_5 := guf_getControl( "Edit84_3_5_2", 84 )
	O_lastWordKey3_6 := guf_getControl( "Edit84_3_6_2", 84 )
	O_lastWordKey3_7 := guf_getControl( "Edit84_3_7_2", 84 )
	O_lastWordKey3_8 := guf_getControl( "Edit84_3_8_2", 84 )
	O_lastWordKey3_9 := guf_getControl( "Edit84_3_9_2", 84 )
	O_lastWordKey3_10 := guf_getControl( "Edit84_3_10_2", 84 )

	if( lasw_errorLastWord(O_lastWordKey3_1) ){
		O_lastWordKey3_1 =
	}
	if( lasw_errorLastWord(O_lastWordKey3_2) ){
		O_lastWordKey3_2 =
	}
	if( lasw_errorLastWord(O_lastWordKey3_3) ){
		O_lastWordKey3_3 =
	}
	if( lasw_errorLastWord(O_lastWordKey3_4) ){
		O_lastWordKey3_4 =
	}
	if( lasw_errorLastWord(O_lastWordKey3_5) ){
		O_lastWordKey3_5 =
	}
	if( lasw_errorLastWord(O_lastWordKey3_6) ){
		O_lastWordKey3_6 =
	}
	if( lasw_errorLastWord(O_lastWordKey3_7) ){
		O_lastWordKey3_7 =
	}
	if( lasw_errorLastWord(O_lastWordKey3_8) ){
		O_lastWordKey3_8 =
	}
	if( lasw_errorLastWord(O_lastWordKey3_9) ){
		O_lastWordKey3_9 =
	}
	if( lasw_errorLastWord(O_lastWordKey3_10) ){
		O_lastWordKey3_10 =
	}


	O_lastWordTabAllFlag4 := guf_getControl( "Checkbox84_4_1", 84 )
	O_lastWordScript4_1 := guf_getControl( "Edit84_4_1_1", 84 )
	O_lastWordScript4_2 := guf_getControl( "Edit84_4_2_1", 84 )
	O_lastWordScript4_3 := guf_getControl( "Edit84_4_3_1", 84 )
	O_lastWordScript4_4 := guf_getControl( "Edit84_4_4_1", 84 )
	O_lastWordScript4_5 := guf_getControl( "Edit84_4_5_1", 84 )
	O_lastWordScript4_6 := guf_getControl( "Edit84_4_6_1", 84 )
	O_lastWordScript4_7 := guf_getControl( "Edit84_4_7_1", 84 )
	O_lastWordScript4_8 := guf_getControl( "Edit84_4_8_1", 84 )
	O_lastWordScript4_9 := guf_getControl( "Edit84_4_9_1", 84 )
	O_lastWordScript4_10 := guf_getControl( "Edit84_4_10_1", 84 )


	O_lastWordScript4_1 := Trim(O_lastWordScript4_1)
	O_lastWordScript4_2 := Trim(O_lastWordScript4_2)
	O_lastWordScript4_3 := Trim(O_lastWordScript4_3)
	O_lastWordScript4_4 := Trim(O_lastWordScript4_4)
	O_lastWordScript4_5 := Trim(O_lastWordScript4_5)
	O_lastWordScript4_6 := Trim(O_lastWordScript4_6)
	O_lastWordScript4_7 := Trim(O_lastWordScript4_7)
	O_lastWordScript4_8 := Trim(O_lastWordScript4_8)
	O_lastWordScript4_9 := Trim(O_lastWordScript4_9)
	O_lastWordScript4_10 := Trim(O_lastWordScript4_10)


	O_lastWordKey4_1 := guf_getControl( "Edit84_4_1_2", 84 )
	O_lastWordKey4_2 := guf_getControl( "Edit84_4_2_2", 84 )
	O_lastWordKey4_3 := guf_getControl( "Edit84_4_3_2", 84 )
	O_lastWordKey4_4 := guf_getControl( "Edit84_4_4_2", 84 )
	O_lastWordKey4_5 := guf_getControl( "Edit84_4_5_2", 84 )
	O_lastWordKey4_6 := guf_getControl( "Edit84_4_6_2", 84 )
	O_lastWordKey4_7 := guf_getControl( "Edit84_4_7_2", 84 )
	O_lastWordKey4_8 := guf_getControl( "Edit84_4_8_2", 84 )
	O_lastWordKey4_9 := guf_getControl( "Edit84_4_9_2", 84 )
	O_lastWordKey4_10 := guf_getControl( "Edit84_4_10_2", 84 )

	if( lasw_errorLastWord(O_lastWordKey4_1) ){
		O_lastWordKey4_1 =
	}
	if( lasw_errorLastWord(O_lastWordKey4_2) ){
		O_lastWordKey4_2 =
	}
	if( lasw_errorLastWord(O_lastWordKey4_3) ){
		O_lastWordKey4_3 =
	}
	if( lasw_errorLastWord(O_lastWordKey4_4) ){
		O_lastWordKey4_4 =
	}
	if( lasw_errorLastWord(O_lastWordKey4_5) ){
		O_lastWordKey4_5 =
	}
	if( lasw_errorLastWord(O_lastWordKey4_6) ){
		O_lastWordKey4_6 =
	}
	if( lasw_errorLastWord(O_lastWordKey4_7) ){
		O_lastWordKey4_7 =
	}
	if( lasw_errorLastWord(O_lastWordKey4_8) ){
		O_lastWordKey4_8 =
	}
	if( lasw_errorLastWord(O_lastWordKey4_9) ){
		O_lastWordKey4_9 =
	}
	if( lasw_errorLastWord(O_lastWordKey4_10) ){
		O_lastWordKey4_10 =
	}


	O_lastWordTabAllFlag5 := guf_getControl( "Checkbox84_5_1", 84 )
	O_lastWordScript5_1 := guf_getControl( "Edit84_5_1_1", 84 )
	O_lastWordScript5_2 := guf_getControl( "Edit84_5_2_1", 84 )
	O_lastWordScript5_3 := guf_getControl( "Edit84_5_3_1", 84 )
	O_lastWordScript5_4 := guf_getControl( "Edit84_5_4_1", 84 )
	O_lastWordScript5_5 := guf_getControl( "Edit84_5_5_1", 84 )
	O_lastWordScript5_6 := guf_getControl( "Edit84_5_6_1", 84 )
	O_lastWordScript5_7 := guf_getControl( "Edit84_5_7_1", 84 )
	O_lastWordScript5_8 := guf_getControl( "Edit84_5_8_1", 84 )
	O_lastWordScript5_9 := guf_getControl( "Edit84_5_9_1", 84 )
	O_lastWordScript5_10 := guf_getControl( "Edit84_5_10_1", 84 )

	O_lastWordScript5_1 := Trim(O_lastWordScript5_1)
	O_lastWordScript5_2 := Trim(O_lastWordScript5_2)
	O_lastWordScript5_3 := Trim(O_lastWordScript5_3)
	O_lastWordScript5_4 := Trim(O_lastWordScript5_4)
	O_lastWordScript5_5 := Trim(O_lastWordScript5_5)
	O_lastWordScript5_6 := Trim(O_lastWordScript5_6)
	O_lastWordScript5_7 := Trim(O_lastWordScript5_7)
	O_lastWordScript5_8 := Trim(O_lastWordScript5_8)
	O_lastWordScript5_9 := Trim(O_lastWordScript5_9)
	O_lastWordScript5_10 := Trim(O_lastWordScript5_10)


	O_lastWordKey5_1 := guf_getControl( "Edit84_5_1_2", 84 )
	O_lastWordKey5_2 := guf_getControl( "Edit84_5_2_2", 84 )
	O_lastWordKey5_3 := guf_getControl( "Edit84_5_3_2", 84 )
	O_lastWordKey5_4 := guf_getControl( "Edit84_5_4_2", 84 )
	O_lastWordKey5_5 := guf_getControl( "Edit84_5_5_2", 84 )
	O_lastWordKey5_6 := guf_getControl( "Edit84_5_6_2", 84 )
	O_lastWordKey5_7 := guf_getControl( "Edit84_5_7_2", 84 )
	O_lastWordKey5_8 := guf_getControl( "Edit84_5_8_2", 84 )
	O_lastWordKey5_9 := guf_getControl( "Edit84_5_9_2", 84 )
	O_lastWordKey5_10 := guf_getControl( "Edit84_5_10_2", 84 )

	if( lasw_errorLastWord(O_lastWordKey5_1) ){
		O_lastWordKey5_1 =
	}
	if( lasw_errorLastWord(O_lastWordKey5_2) ){
		O_lastWordKey5_2 =
	}
	if( lasw_errorLastWord(O_lastWordKey5_3) ){
		O_lastWordKey5_3 =
	}
	if( lasw_errorLastWord(O_lastWordKey5_4) ){
		O_lastWordKey5_4 =
	}
	if( lasw_errorLastWord(O_lastWordKey5_5) ){
		O_lastWordKey5_5 =
	}
	if( lasw_errorLastWord(O_lastWordKey5_6) ){
		O_lastWordKey5_6 =
	}
	if( lasw_errorLastWord(O_lastWordKey5_7) ){
		O_lastWordKey5_7 =
	}
	if( lasw_errorLastWord(O_lastWordKey5_8) ){
		O_lastWordKey5_8 =
	}
	if( lasw_errorLastWord(O_lastWordKey5_9) ){
		O_lastWordKey5_9 =
	}
	if( lasw_errorLastWord(O_lastWordKey5_10) ){
		O_lastWordKey5_10 =
	}

	glob_iniBetweenExeWordEndFlag := guf_getControl( "Checkbox84_sendEnd", 84 )
	glob_iniBetweenExeWordEndKey := guf_getControl( "Edit84_sendEnd", 84 )
	if( lasw_errorLastWord(glob_iniBetweenExeWordEndKey) ){
		glob_iniBetweenExeWordEndKey := init_trimBrackets(defa_defaultIniBetweenExeWordEndKey)
	}

	O_betweenWordTabAllFlag1 := guf_getControl( "Checkbox84_6_1", 84 )
	O_betweenWordScript1_1 := guf_getControl( "Edit84_6_1_1", 84 )
	O_betweenWordScript1_2 := guf_getControl( "Edit84_6_2_1", 84 )
	O_betweenWordScript1_3 := guf_getControl( "Edit84_6_3_1", 84 )
	O_betweenWordScript1_4 := guf_getControl( "Edit84_6_4_1", 84 )
	O_betweenWordScript1_5 := guf_getControl( "Edit84_6_5_1", 84 )
	O_betweenWordScript1_6 := guf_getControl( "Edit84_6_6_1", 84 )
	O_betweenWordScript1_7 := guf_getControl( "Edit84_6_7_1", 84 )
	O_betweenWordScript1_8 := guf_getControl( "Edit84_6_8_1", 84 )
	O_betweenWordScript1_9 := guf_getControl( "Edit84_6_9_1", 84 )
	O_betweenWordScript1_10 := guf_getControl( "Edit84_6_10_1", 84 )

	O_betweenWordScript1_1 := Trim(O_betweenWordScript1_1)
	O_betweenWordScript1_2 := Trim(O_betweenWordScript1_2)
	O_betweenWordScript1_3 := Trim(O_betweenWordScript1_3)
	O_betweenWordScript1_4 := Trim(O_betweenWordScript1_4)
	O_betweenWordScript1_5 := Trim(O_betweenWordScript1_5)
	O_betweenWordScript1_6 := Trim(O_betweenWordScript1_6)
	O_betweenWordScript1_7 := Trim(O_betweenWordScript1_7)
	O_betweenWordScript1_8 := Trim(O_betweenWordScript1_8)
	O_betweenWordScript1_9 := Trim(O_betweenWordScript1_9)
	O_betweenWordScript1_10 := Trim(O_betweenWordScript1_10)


	O_betweenWordKey1_1 := guf_getControl( "Edit84_6_1_2", 84 )
	O_betweenWordKey1_2 := guf_getControl( "Edit84_6_2_2", 84 )
	O_betweenWordKey1_3 := guf_getControl( "Edit84_6_3_2", 84 )
	O_betweenWordKey1_4 := guf_getControl( "Edit84_6_4_2", 84 )
	O_betweenWordKey1_5 := guf_getControl( "Edit84_6_5_2", 84 )
	O_betweenWordKey1_6 := guf_getControl( "Edit84_6_6_2", 84 )
	O_betweenWordKey1_7 := guf_getControl( "Edit84_6_7_2", 84 )
	O_betweenWordKey1_8 := guf_getControl( "Edit84_6_8_2", 84 )
	O_betweenWordKey1_9 := guf_getControl( "Edit84_6_9_2", 84 )
	O_betweenWordKey1_10 := guf_getControl( "Edit84_6_10_2", 84 )

	if( lasw_errorLastWord(O_betweenWordKey1_1) ){
		O_betweenWordKey1_1 =
	}
	if( lasw_errorLastWord(O_betweenWordKey1_2) ){
		O_betweenWordKey1_2 =
	}
	if( lasw_errorLastWord(O_betweenWordKey1_3) ){
		O_betweenWordKey1_3 =
	}
	if( lasw_errorLastWord(O_betweenWordKey1_4) ){
		O_betweenWordKey1_4 =
	}
	if( lasw_errorLastWord(O_betweenWordKey1_5) ){
		O_betweenWordKey1_5 =
	}
	if( lasw_errorLastWord(O_betweenWordKey1_6) ){
		O_betweenWordKey1_6 =
	}
	if( lasw_errorLastWord(O_betweenWordKey1_7) ){
		O_betweenWordKey1_7 =
	}
	if( lasw_errorLastWord(O_betweenWordKey1_8) ){
		O_betweenWordKey1_8 =
	}
	if( lasw_errorLastWord(O_betweenWordKey1_9) ){
		O_betweenWordKey1_9 =
	}
	if( lasw_errorLastWord(O_betweenWordKey1_10) ){
		O_betweenWordKey1_10 =
	}

	glob_iniLastWordChangeHalfNumFlag := guf_getControl( "Checkbox84_7_num", 84 )
	glob_iniLastWordChangeFlag1 := guf_getControl( "Checkbox84_7_1", 84 )
	glob_iniLastWordChangeAfter1 := guf_getControl( "Edit84_7_1_1", 84 )
	glob_iniLastWordChangeChoice1_1 := guf_getControl( "Edit84_7_1_2", 84 )
	glob_iniLastWordChangeChoice1_2 := guf_getControl( "Edit84_7_1_3", 84 )
	glob_iniLastWordChangeChoice1_3 := guf_getControl( "Edit84_7_1_4", 84 )
	glob_iniLastWordChangeFlag2 := guf_getControl( "Checkbox84_7_2", 84 )
	glob_iniLastWordChangeAfter2 := guf_getControl( "Edit84_7_2_1", 84 )
	glob_iniLastWordChangeChoice2_1 := guf_getControl( "Edit84_7_2_2", 84 )
	glob_iniLastWordChangeChoice2_2 := guf_getControl( "Edit84_7_2_3", 84 )
	glob_iniLastWordChangeChoice2_3 := guf_getControl( "Edit84_7_2_4", 84 )
	glob_iniLastWordChangeFlag3 := guf_getControl( "Checkbox84_7_3", 84 )
	glob_iniLastWordChangeAfter3 := guf_getControl( "Edit84_7_3_1", 84 )
	glob_iniLastWordChangeChoice3_1 := guf_getControl( "Edit84_7_3_2", 84 )
	glob_iniLastWordChangeChoice3_2 := guf_getControl( "Edit84_7_3_3", 84 )
	glob_iniLastWordChangeChoice3_3 := guf_getControl( "Edit84_7_3_4", 84 )

	if( lasw_errorLastWordChangeAfte(glob_iniLastWordChangeAfter1) ){
		glob_iniLastWordChangeAfter1 = %defa_defaultIniLastWordChangeAfter1%
		guit_errorAppend("空白のみは設定できない。`n初期値を設定する。`n" . defa_defaultIniLastWordChangeAfter1)
	}
	if( glob_iniLastWordChangeChoice1_1 == "" ){
		glob_iniLastWordChangeChoice1_1 = %defa_defaultIniLastWordChangeChoice1_1%
		guit_errorAppend("文字が記入されていないので、初期値を設定する。`n" . defa_defaultIniLastWordChangeChoice1_1)
	}
	if( glob_iniLastWordChangeChoice1_2 == "" ){
		glob_iniLastWordChangeChoice1_2 = %defa_defaultIniLastWordChangeChoice1_2%
		guit_errorAppend("文字が記入されていないので、初期値を設定する。`n" . defa_defaultIniLastWordChangeChoice1_2)
	}
	if( glob_iniLastWordChangeChoice1_3 == "" ){
		glob_iniLastWordChangeChoice1_3 = %defa_defaultIniLastWordChangeChoice1_3%
		guit_errorAppend("文字が記入されていないので、初期値を設定する。`n" . defa_defaultIniLastWordChangeChoice1_3)
	}

	if( lasw_errorLastWordChangeAfte(glob_iniLastWordChangeAfter2) ){
		glob_iniLastWordChangeAfter2 =
	}
	if( lasw_errorLastWordChangeAfte(glob_iniLastWordChangeAfter3) ){
		glob_iniLastWordChangeAfter3 =
	}

	lastConfigFile := gloco_userDir . glob_lastWordExeConfigFileName
	func_folderCheckMakeFolder(gloco_userDir)
	; 半角スペースが取り除かれてしまうため、テキスト部分は  ( ) で囲む
	IniWrite, %glob_iniLastWordExeAllFlag%, %lastConfigFile%, lastConfig, lastWordExeAllFlag
	IniWrite, %glob_iniLastWordExeEnterFlag%, %lastConfigFile%, lastConfig, enterFlag
	IniWrite, (%glob_iniLastWordExeEnterText%), %lastConfigFile%, lastConfig, enterText
	IniWrite, %glob_iniLastWordExeCtrlNumFlag%, %lastConfigFile%, lastConfig, ctrlNumFlag
	IniWrite, (%glob_iniLastWordExeCtrlNumText%), %lastConfigFile%, lastConfig, ctrlNumText
	IniWrite, %glob_iniLastWordExeShiftCtrlNumFlag%, %lastConfigFile%, lastConfig, shiftCtrlNumFlag
	IniWrite, (%glob_iniLastWordExeShiftCtrlNumText%), %lastConfigFile%, lastConfig, shiftCtrlNumText
	IniWrite, %glob_iniLastWordExePuppupViewFlag%, %lastConfigFile%, lastConfig, puppupViewFlag
	IniWrite, (%glob_iniLastWordExePuppupViewText%), %lastConfigFile%, lastConfig, puppupViewText
	IniWrite, (%glob_iniLastWordExeEnterText2%), %lastConfigFile%, lastConfig, enterText2
	IniWrite, %glob_iniLastWordTextCleanFlag%, %lastConfigFile%, lastConfig, textCleanFlag
	IniWrite, (%glob_iniLastWordTextCleanText%), %lastConfigFile%, lastConfig, textCleanText
	IniWrite, %glob_iniLastWordExeUseTextNumFlag%, %lastConfigFile%, lastConfig, useTextNumFlag
	IniWrite, (%glob_iniLastWordExeUseTextNumText%), %lastConfigFile%, lastConfig, useTextNumText
	IniWrite, %glob_iniLastWordAsHeadExeFlag%, %lastConfigFile%, lastConfig, asHeadExeFlag
	IniWrite, (%glob_iniLastWordAsHeadExeText%), %lastConfigFile%, lastConfig, asHeadExeText
	IniWrite, %glob_iniLastWordSpaceSendFlag%, %lastConfigFile%, lastConfig, spaceSendFlag
	IniWrite, (%glob_iniLastWordSpaceSendText%), %lastConfigFile%, lastConfig, spaceSendText
	IniWrite, %O_lastWordTabAllFlag2%, %lastConfigFile%, lastTab2, tabFlag2
	IniWrite, %O_lastWordScript2_1%, %lastConfigFile%, lastTab2, assignComm1
	IniWrite, %O_lastWordScript2_2%, %lastConfigFile%, lastTab2, assignComm2
	IniWrite, %O_lastWordScript2_3%, %lastConfigFile%, lastTab2, assignComm3
	IniWrite, %O_lastWordScript2_4%, %lastConfigFile%, lastTab2, assignComm4
	IniWrite, %O_lastWordScript2_5%, %lastConfigFile%, lastTab2, assignComm5
	IniWrite, %O_lastWordScript2_6%, %lastConfigFile%, lastTab2, assignComm6
	IniWrite, %O_lastWordScript2_7%, %lastConfigFile%, lastTab2, assignComm7
	IniWrite, %O_lastWordScript2_8%, %lastConfigFile%, lastTab2, assignComm8
	IniWrite, %O_lastWordScript2_9%, %lastConfigFile%, lastTab2, assignComm9
	IniWrite, %O_lastWordScript2_10%, %lastConfigFile%, lastTab2, assignComm10
	IniWrite, (%O_lastWordKey2_1%), %lastConfigFile%, lastTab2, assignText1
	IniWrite, (%O_lastWordKey2_2%), %lastConfigFile%, lastTab2, assignText2
	IniWrite, (%O_lastWordKey2_3%), %lastConfigFile%, lastTab2, assignText3
	IniWrite, (%O_lastWordKey2_4%), %lastConfigFile%, lastTab2, assignText4
	IniWrite, (%O_lastWordKey2_5%), %lastConfigFile%, lastTab2, assignText5
	IniWrite, (%O_lastWordKey2_6%), %lastConfigFile%, lastTab2, assignText6
	IniWrite, (%O_lastWordKey2_7%), %lastConfigFile%, lastTab2, assignText7
	IniWrite, (%O_lastWordKey2_8%), %lastConfigFile%, lastTab2, assignText8
	IniWrite, (%O_lastWordKey2_9%), %lastConfigFile%, lastTab2, assignText9
	IniWrite, (%O_lastWordKey2_10%), %lastConfigFile%, lastTab2, assignText10
	IniWrite, %O_lastWordTabAllFlag3%, %lastConfigFile%, lastTab3, tabFlag3
	IniWrite, %O_lastWordScript3_1%, %lastConfigFile%, lastTab3, assignComm3_1
	IniWrite, %O_lastWordScript3_2%, %lastConfigFile%, lastTab3, assignComm3_2
	IniWrite, %O_lastWordScript3_3%, %lastConfigFile%, lastTab3, assignComm3_3
	IniWrite, %O_lastWordScript3_4%, %lastConfigFile%, lastTab3, assignComm3_4
	IniWrite, %O_lastWordScript3_5%, %lastConfigFile%, lastTab3, assignComm3_5
	IniWrite, %O_lastWordScript3_6%, %lastConfigFile%, lastTab3, assignComm3_6
	IniWrite, %O_lastWordScript3_7%, %lastConfigFile%, lastTab3, assignComm3_7
	IniWrite, %O_lastWordScript3_8%, %lastConfigFile%, lastTab3, assignComm3_8
	IniWrite, %O_lastWordScript3_9%, %lastConfigFile%, lastTab3, assignComm3_9
	IniWrite, %O_lastWordScript3_10%, %lastConfigFile%, lastTab3, assignComm3_10
	IniWrite, (%O_lastWordKey3_1%), %lastConfigFile%, lastTab3, assignText3_1
	IniWrite, (%O_lastWordKey3_2%), %lastConfigFile%, lastTab3, assignText3_2
	IniWrite, (%O_lastWordKey3_3%), %lastConfigFile%, lastTab3, assignText3_3
	IniWrite, (%O_lastWordKey3_4%), %lastConfigFile%, lastTab3, assignText3_4
	IniWrite, (%O_lastWordKey3_5%), %lastConfigFile%, lastTab3, assignText3_5
	IniWrite, (%O_lastWordKey3_6%), %lastConfigFile%, lastTab3, assignText3_6
	IniWrite, (%O_lastWordKey3_7%), %lastConfigFile%, lastTab3, assignText3_7
	IniWrite, (%O_lastWordKey3_8%), %lastConfigFile%, lastTab3, assignText3_8
	IniWrite, (%O_lastWordKey3_9%), %lastConfigFile%, lastTab3, assignText3_9
	IniWrite, (%O_lastWordKey3_10%), %lastConfigFile%, lastTab3, assignText3_10
	IniWrite, %O_lastWordTabAllFlag4%, %lastConfigFile%, lastTab4, tabFlag4
	IniWrite, %O_lastWordScript4_1%, %lastConfigFile%, lastTab4, assignComm4_1
	IniWrite, %O_lastWordScript4_2%, %lastConfigFile%, lastTab4, assignComm4_2
	IniWrite, %O_lastWordScript4_3%, %lastConfigFile%, lastTab4, assignComm4_3
	IniWrite, %O_lastWordScript4_4%, %lastConfigFile%, lastTab4, assignComm4_4
	IniWrite, %O_lastWordScript4_5%, %lastConfigFile%, lastTab4, assignComm4_5
	IniWrite, %O_lastWordScript4_6%, %lastConfigFile%, lastTab4, assignComm4_6
	IniWrite, %O_lastWordScript4_7%, %lastConfigFile%, lastTab4, assignComm4_7
	IniWrite, %O_lastWordScript4_8%, %lastConfigFile%, lastTab4, assignComm4_8
	IniWrite, %O_lastWordScript4_9%, %lastConfigFile%, lastTab4, assignComm4_9
	IniWrite, %O_lastWordScript4_10%, %lastConfigFile%, lastTab4, assignComm4_10
	IniWrite, (%O_lastWordKey4_1%), %lastConfigFile%, lastTab4, assignText4_1
	IniWrite, (%O_lastWordKey4_2%), %lastConfigFile%, lastTab4, assignText4_2
	IniWrite, (%O_lastWordKey4_3%), %lastConfigFile%, lastTab4, assignText4_3
	IniWrite, (%O_lastWordKey4_4%), %lastConfigFile%, lastTab4, assignText4_4
	IniWrite, (%O_lastWordKey4_5%), %lastConfigFile%, lastTab4, assignText4_5
	IniWrite, (%O_lastWordKey4_6%), %lastConfigFile%, lastTab4, assignText4_6
	IniWrite, (%O_lastWordKey4_7%), %lastConfigFile%, lastTab4, assignText4_7
	IniWrite, (%O_lastWordKey4_8%), %lastConfigFile%, lastTab4, assignText4_8
	IniWrite, (%O_lastWordKey4_9%), %lastConfigFile%, lastTab4, assignText4_9
	IniWrite, (%O_lastWordKey4_10%), %lastConfigFile%, lastTab4, assignText4_10
	IniWrite, %O_lastWordTabAllFlag5%, %lastConfigFile%, lastTab5, tabFlag5
	IniWrite, %O_lastWordScript5_1%, %lastConfigFile%, lastTab5, assignComm5_1
	IniWrite, %O_lastWordScript5_2%, %lastConfigFile%, lastTab5, assignComm5_2
	IniWrite, %O_lastWordScript5_3%, %lastConfigFile%, lastTab5, assignComm5_3
	IniWrite, %O_lastWordScript5_4%, %lastConfigFile%, lastTab5, assignComm5_4
	IniWrite, %O_lastWordScript5_5%, %lastConfigFile%, lastTab5, assignComm5_5
	IniWrite, %O_lastWordScript5_6%, %lastConfigFile%, lastTab5, assignComm5_6
	IniWrite, %O_lastWordScript5_7%, %lastConfigFile%, lastTab5, assignComm5_7
	IniWrite, %O_lastWordScript5_8%, %lastConfigFile%, lastTab5, assignComm5_8
	IniWrite, %O_lastWordScript5_9%, %lastConfigFile%, lastTab5, assignComm5_9
	IniWrite, %O_lastWordScript5_10%, %lastConfigFile%, lastTab5, assignComm5_10
	IniWrite, (%O_lastWordKey5_1%), %lastConfigFile%, lastTab5, assignText5_1
	IniWrite, (%O_lastWordKey5_2%), %lastConfigFile%, lastTab5, assignText5_2
	IniWrite, (%O_lastWordKey5_3%), %lastConfigFile%, lastTab5, assignText5_3
	IniWrite, (%O_lastWordKey5_4%), %lastConfigFile%, lastTab5, assignText5_4
	IniWrite, (%O_lastWordKey5_5%), %lastConfigFile%, lastTab5, assignText5_5
	IniWrite, (%O_lastWordKey5_6%), %lastConfigFile%, lastTab5, assignText5_6
	IniWrite, (%O_lastWordKey5_7%), %lastConfigFile%, lastTab5, assignText5_7
	IniWrite, (%O_lastWordKey5_8%), %lastConfigFile%, lastTab5, assignText5_8
	IniWrite, (%O_lastWordKey5_9%), %lastConfigFile%, lastTab5, assignText5_9
	IniWrite, (%O_lastWordKey5_10%), %lastConfigFile%, lastTab5, assignText5_10
	IniWrite, %glob_iniBetweenExeWordEndFlag%, %lastConfigFile%, lastTab6, betweenEndFlag
	IniWrite, (%glob_iniBetweenExeWordEndKey%), %lastConfigFile%, lastTab6, betweenEndKey
	IniWrite, %O_betweenWordTabAllFlag1%, %lastConfigFile%, lastTab6, betweenFlag1
	IniWrite, %O_betweenWordScript1_1%, %lastConfigFile%, lastTab6, betweenScript1_1
	IniWrite, %O_betweenWordScript1_2%, %lastConfigFile%, lastTab6, betweenScript1_2
	IniWrite, %O_betweenWordScript1_3%, %lastConfigFile%, lastTab6, betweenScript1_3
	IniWrite, %O_betweenWordScript1_4%, %lastConfigFile%, lastTab6, betweenScript1_4
	IniWrite, %O_betweenWordScript1_5%, %lastConfigFile%, lastTab6, betweenScript1_5
	IniWrite, %O_betweenWordScript1_6%, %lastConfigFile%, lastTab6, betweenScript1_6
	IniWrite, %O_betweenWordScript1_7%, %lastConfigFile%, lastTab6, betweenScript1_7
	IniWrite, %O_betweenWordScript1_8%, %lastConfigFile%, lastTab6, betweenScript1_8
	IniWrite, %O_betweenWordScript1_9%, %lastConfigFile%, lastTab6, betweenScript1_9
	IniWrite, %O_betweenWordScript1_10%, %lastConfigFile%, lastTab6, betweenScript1_10
	IniWrite, (%O_betweenWordKey1_1%), %lastConfigFile%, lastTab6, betweenKey1_1
	IniWrite, (%O_betweenWordKey1_2%), %lastConfigFile%, lastTab6, betweenKey1_2
	IniWrite, (%O_betweenWordKey1_3%), %lastConfigFile%, lastTab6, betweenKey1_3
	IniWrite, (%O_betweenWordKey1_4%), %lastConfigFile%, lastTab6, betweenKey1_4
	IniWrite, (%O_betweenWordKey1_5%), %lastConfigFile%, lastTab6, betweenKey1_5
	IniWrite, (%O_betweenWordKey1_6%), %lastConfigFile%, lastTab6, betweenKey1_6
	IniWrite, (%O_betweenWordKey1_7%), %lastConfigFile%, lastTab6, betweenKey1_7
	IniWrite, (%O_betweenWordKey1_8%), %lastConfigFile%, lastTab6, betweenKey1_8
	IniWrite, (%O_betweenWordKey1_9%), %lastConfigFile%, lastTab6, betweenKey1_9
	IniWrite, (%O_betweenWordKey1_10%), %lastConfigFile%, lastTab6, betweenKey1_10
	IniWrite, %glob_iniLastWordChangeHalfNumFlag%, %lastConfigFile%, lastChange, changeHalfNumFlag
	IniWrite, %glob_iniLastWordChangeFlag1%, %lastConfigFile%, lastChange, changeFlag1
	IniWrite, %glob_iniLastWordChangeAfter1%, %lastConfigFile%, lastChange, changeAfter1
	IniWrite, %glob_iniLastWordChangeChoice1_1%, %lastConfigFile%, lastChange, changeChoice1_1
	IniWrite, %glob_iniLastWordChangeChoice1_2%, %lastConfigFile%, lastChange, changeChoice1_2
	IniWrite, %glob_iniLastWordChangeChoice1_3%, %lastConfigFile%, lastChange, changeChoice1_3
	IniWrite, %glob_iniLastWordChangeFlag2%, %lastConfigFile%, lastChange, changeFlag2
	IniWrite, %glob_iniLastWordChangeAfter2%, %lastConfigFile%, lastChange, changeAfter2
	IniWrite, %glob_iniLastWordChangeChoice2_1%, %lastConfigFile%, lastChange, changeChoice2_1
	IniWrite, %glob_iniLastWordChangeChoice2_2%, %lastConfigFile%, lastChange, changeChoice2_2
	IniWrite, %glob_iniLastWordChangeChoice2_3%, %lastConfigFile%, lastChange, changeChoice2_3
	IniWrite, %glob_iniLastWordChangeFlag3%, %lastConfigFile%, lastChange, changeFlag3
	IniWrite, %glob_iniLastWordChangeAfter3%, %lastConfigFile%, lastChange, changeAfter3
	IniWrite, %glob_iniLastWordChangeChoice3_1%, %lastConfigFile%, lastChange, changeChoice3_1
	IniWrite, %glob_iniLastWordChangeChoice3_2%, %lastConfigFile%, lastChange, changeChoice3_2
	IniWrite, %glob_iniLastWordChangeChoice3_3%, %lastConfigFile%, lastChange, changeChoice3_3

	guit_checkErrorLevelOutput("lastWord設定ファイルの書き込み時にエラーあり")
}

syf_userDirChangeDefaultButton(){
	guf_setControl( gloco_defaultUserDir, "Edit86_1", 86 )
	guf_setControl( gloco_defaultDocDir, "Edit86_2", 86 )

/*
	フォルダが存在しなかったとき、うまく動作しないので使わない
	relativ := outs_absolePathToRelativPath(A_ScriptDir , gloco_defaultUserDir, A_LineFile, A_LineNumber)
	str := "%A_ScriptDir%\"  . relativ
	guf_setControl( str, "Edit86_1", 86 )
	relativ := outs_absolePathToRelativPath(A_ScriptDir , gloco_defaultDocDir, A_LineFile, A_LineNumber)
	str := "%A_ScriptDir%\"  . relativ
	guf_setControl( str, "Edit86_2", 86 )
*/
}

syf_showAndExceptionOfUserGuiSet(){
	; あえて、設定ファイルを利用して読み込む。
	; gloco_userDir などは、起動時に絶対パスに変換されるので、iniファイルに保存した内容と違ったりする。
	IniRead, Output1, %glob_exceptionOfUserFile%, exceptionOfUser, userDirChangeFlag ,%glob_reloadIniUserDirChangeFlag%
	IniRead, Output2, %glob_exceptionOfUserFile%, exceptionOfUser, userDir ,  %gloco_userDir%
	IniRead, Output3, %glob_exceptionOfUserFile%, exceptionOfUser, docDir ,  %gloco_docDir%

	; カラなら、今の状態を表示
	if(Output2 == ""){
		Output2 := gloco_userDir
	}
	if(Output3 == ""){
		Output3 := gloco_docDir
	}

	guf_setControl( Output1, "Checkbox86_1", 86 )

	; コントロールを有効にしてから設定
	guf_switchEnableByFlag(True, "Edit86_1", 86)
	guf_switchEnableByFlag(True, "Edit86_2", 86)

	guf_setControl( Output2, "Edit86_1", 86 )
	guf_setControl( Output3, "Edit86_2", 86 )

	guf_switchEnableByFlag(Output1, "Edit86_1", 86)
	guf_switchEnableByFlag(Output1, "Edit86_2", 86)


	guf_setControl( glob_reloadIniCommGuiOnlyFlag, "Checkbox86_3", 86 )
	guf_setControl( glob_reloadIniStartUpText3, "Edit86_5", 86 )

	guf_setControl( glob_reloadIniShortKeyOffFlag, "Checkbox86_4", 86 )
	guf_setControl( glob_reloadIniExceptCommKeyOff, "Checkbox86_5", 86 )
	guf_setControl( glob_reloadIniCommWinTitle, "Edit86_6", 86 )

	guf_setControl( glob_reloadIniTextWidthAutoNotFlag, "Checkbox86_2_1", 86 )
	guf_setControl( glob_reloadIniCommWidthBasis, "UpDown86_2_1", 86 )
	guf_setControl( glob_reloadIniCommWindowWidthBasis, "UpDown86_2_2", 86 )

	guf_setControl( glob_reloadIniOneLineTextTitle, "Edit86_2_1", 86 )
	guf_setControl( glob_reloadIniTextSplitTitle, "Edit86_2_2", 86 )
	GuiControl, 86:Choose, Tab86_1, 1

	;なぜか最前面に表示されないので遅らせる
	Sleep, 300
	Gui, 86:Show
}

; ニセの関数
; RGBの書式を判別したいが 面倒なので保留していつかまともなのを作る
/*
syf_isRgbFormat(str){
	if(str == ""){
		return True
	}
	res := RegExMatch(str, "^[0-9a-zA-Z_@-]+$")
	if(res == 1) {
		return True
	}
	return False
}
*/

syf_exceptionOfUserGuiSettingConfirm(){
	MsgBox , 4129, 再起動が必要な設定の確認, 設定をするには１度終了する。`nそれでいいか？, 60
	IfMsgBox, OK
	{
		syf_exceptionOfUserGuiSetting()
	}
}

syf_exceptionOfUserGuiSetting(){
	userDir =
	docDir =
	userDirChangeFlag := guf_getControl( "Checkbox86_1", 86 )
	userDir := guf_getControl( "Edit86_1", 86 )
	docDir := guf_getControl( "Edit86_2", 86 )
	if( userDirChangeFlag ){
		userDirTmp := outs_textOutTrimss(userDir)
		if( func_isNotFolder(userDirTmp) ){
			guit_errorAppend(userDir . "`nはフォルダではない。`n設定変更は中断している。")
			return
		}
		docDirTmp := outs_textOutTrimss(docDir)
		if( func_isNotFolder(docDirTmp) ){
			guit_errorAppend(docDir . "`nはフォルダではない。`n設定変更は中断している。")
			return
		}
	}

	commGuiOnlyFlag := guf_getControl( "Checkbox86_3", 86 )
	startUpText3 := guf_getControl( "Edit86_5", 86 )

	shortKeyOffFlag := guf_getControl( "Checkbox86_4", 86 )
	exceptCommKeyOff := guf_getControl( "Checkbox86_5", 86 )
	commWinTitle := guf_getControl( "Edit86_6", 86 )

	textWidthAutoFlag := guf_getControl( "Checkbox86_2_1", 86 )
	commWidthBasis := guf_getControl( "UpDown86_2_1", 86 )
	commWindowWidthBasis := guf_getControl( "UpDown86_2_2", 86 )

	; カラ や マイナス や 1371 以上なら初期化する
	if( commWidthBasis == "" ){
		commWidthBasis := defa_defaultReloadIniCommWidthBasis
		guit_errorAppend("入力欄の長さの設定でエラー`n数値がないので設定できない。")
	} else if( commWidthBasis <= -1 ){
		commWidthBasis := defa_defaultReloadIniCommWidthBasis
		guit_errorAppend("入力欄の長さの設定でエラー`n値がマイナスなので設定できない。")
	} else if( commWidthBasis >= 1371 ){
		commWidthBasis := defa_defaultReloadIniCommWidthBasis
		guit_errorAppend("入力欄の長さの設定でエラー`n 1371 を超える値は設定できない。")
	}

	; カラ や 99 以下 や 1401 以上なら初期化する
	if( commWindowWidthBasis == "" ){
		commWindowWidthBasis := defa_defaultReloadIniCommWindowWidthBasis
		guit_errorAppend("ウインドウの幅の設定でエラー`n数値がないので設定できない。")
	} else if( commWindowWidthBasis <= 99 ){
		commWindowWidthBasis := defa_defaultReloadIniCommWindowWidthBasis
		guit_errorAppend("ウインドウの幅の設定でエラー`n 99 以下の数値は設定できない。")
	} else if( commWindowWidthBasis >= 1401 ){
		commWindowWidthBasis := defa_defaultReloadIniCommWindowWidthBasis
		guit_errorAppend("ウインドウの幅の設定でエラー`n 1401 を超える値は設定できない。")
	}

	oneLineTextTitle := guf_getControl( "Edit86_2_1", 86 )
	textSplitTitle := guf_getControl( "Edit86_2_2", 86 )

	func_folderCheckMakeFolder(gloco_userDir)
	IniWrite, %userDirChangeFlag%, %glob_exceptionOfUserFile%, exceptionOfUser, userDirChangeFlag
	IniWrite, %userDir%, %glob_exceptionOfUserFile%, exceptionOfUser, userDir
	IniWrite, %docDir%, %glob_exceptionOfUserFile%, exceptionOfUser, docDir
	IniWrite, %commGuiOnlyFlag%, %glob_exceptionOfUserFile%, exceptionOfUser, commGuiOnlyFlag
	IniWrite, %startUpText3%, %glob_exceptionOfUserFile%, exceptionOfUser, startUpText3
	IniWrite, %shortKeyOffFlag%, %glob_exceptionOfUserFile%, exceptionOfUser, shortKeyOffFlag
	IniWrite, %exceptCommKeyOff%, %glob_exceptionOfUserFile%, exceptionOfUser, exceptCommKeyOff
	IniWrite, %commWinTitle%, %glob_exceptionOfUserFile%, exceptionOfUser, commWinTitle
	IniWrite, %textWidthAutoFlag%, %glob_exceptionOfUserFile%, exceptionOfUser, textWidthAutoFlag
	IniWrite, %commWidthBasis%, %glob_exceptionOfUserFile%, exceptionOfUser, commWidthBasis
	IniWrite, %commWindowWidthBasis%, %glob_exceptionOfUserFile%, exceptionOfUser, commWindowWidthBasis
	IniWrite, %oneLineTextTitle%, %glob_exceptionOfUserFile%, exceptionOfUser, oneLineTextTitle
	IniWrite, %textSplitTitle%, %glob_exceptionOfUserFile%, exceptionOfUser, textSplitTitle

	res := guit_checkErrorLevelOutput("userフォルダに加えない設定のファイルの書き込み時にエラーあり`n確認して、もう１度設定をしたほうがいいと思われる。")
	if( res ){
		Sleep, 800
		Reload
	}
}

syf_showAndNeedReloadGuiSet(){

	guf_setControl( glob_needReloadIniCommTitleNotFlag, "Checkbox85_1", 85 )

	guf_GuiControl("DropDownList85_1", 85, "Choose", StO_fontSizeAllOption)
	guf_setControl( StO_fontNameAll, "Edit85_7", 85 )

	guf_setControl( glob_needReloadIniCommFontOption, "Edit85_1", 85 )
	guf_setControl( glob_needReloadIniCommFontName, "Edit85_2", 85 )
	guf_setControl( glob_needReloadIniCommBoxFontOption, "Edit85_3", 85 )
	guf_setControl( glob_needReloadIniCommBoxFontName, "Edit85_4", 85 )
	guf_setControl( glob_needReloadIniExplainFontOption, "Edit85_5", 85 )
	guf_setControl( glob_needReloadIniExplainFontName, "Edit85_6", 85 )

	guf_setControl( glob_needReloadIniCommMenuNotFlag, "Checkbox85_2", 85 )

	;なぜか最前面に表示されないので遅らせる
	Sleep, 300
	Gui, 85:Show
}

syf_needReloadGuiSetting(){
	commTitleFlag := guf_getControl( "Checkbox85_1", 85 )
	allFontSize := guf_getControl( "DropDownList85_1", 85 )
	allFontName := guf_getControl( "Edit85_7", 85 )
	commFontOption := guf_getControl( "Edit85_1", 85 )
	commFontName := guf_getControl( "Edit85_2", 85 )
	commBoxFontOption := guf_getControl( "Edit85_3", 85 )
	commBoxFontName := guf_getControl( "Edit85_4", 85 )
	explainFontOption := guf_getControl( "Edit85_5", 85 )
	explainFontName := guf_getControl( "Edit85_6", 85 )
	commMenuFlag := guf_getControl( "Checkbox85_2", 85 )

	needReloadConfigFile := gloco_userDir . glob_needReloadConfigFileName
	func_folderCheckMakeFolder(gloco_userDir)
	IniWrite, %commTitleFlag%, %needReloadConfigFile%, needReloadConfig, commTitleFlag
	IniWrite, %allFontSize%, %needReloadConfigFile%, needReloadConfig, allFontSize
	IniWrite, %allFontName%, %needReloadConfigFile%, needReloadConfig, allFontName
	IniWrite, %commFontOption%, %needReloadConfigFile%, needReloadConfig, commFontOption
	IniWrite, %commFontName%, %needReloadConfigFile%, needReloadConfig, commFontName
	IniWrite, %commBoxFontOption%, %needReloadConfigFile%, needReloadConfig, commBoxFontOption
	IniWrite, %commBoxFontName%, %needReloadConfigFile%, needReloadConfig, commBoxFontName
	IniWrite, %explainFontOption%, %needReloadConfigFile%, needReloadConfig, explainFontOption
	IniWrite, %explainFontName%, %needReloadConfigFile%, needReloadConfig, explainFontName
	IniWrite, %commMenuFlag%, %needReloadConfigFile%, needReloadConfig, commMenuFlag
	
	res := guit_checkErrorLevelOutput("再起動が必要な設定のファイルの書き込み時にエラーあり`n確認して、もう１度設定をしたほうがいいと思われる。")
	if( res ){
		Sleep, 800
		Reload
	}
}

syf_needReloadGuiSettingConfirm(){
	MsgBox , 4129, 再起動が必要な設定の確認, 設定をするには１度終了する。`nそれでいいか？, 60
	IfMsgBox, OK
	{
		syf_needReloadGuiSetting()
	}
}

syf_showSetConfigToggle(){
	IfWinExist, %gGlob_Gui74Title%
	{
		Gui, 74:Hide
	} else {
		syf_showGui74SetConfig()
	}
}

syf_showGui74SetConfig(){
	;guf_setControl( glob_iniSpaceFileNotFlag, "Checkbox74_1", 74 )
	guf_setControl( O_spaceFileNotFlag, "Checkbox74_1", 74 )
	guf_setControl( glob_iniAbsolePathNotFlag, "Checkbox74_4", 74 )
	;guf_setControl( glob_iniHistoryCount, "UpDown74_1", 74 )
	guf_setControl( O_textHistory, "UpDown74_1", 74 )
	guf_setControl( glob_iniTimerTextPeriod_sec, "Edit74_2", 74 )
	guf_setControl( glob_iniCommListCloseNotSaveFlag, "Checkbox74_7", 74 )
	guf_setControl( glob_iniStartUpOptionFlag, "Checkbox74_8", 74 )

	; コントロールを有効にしてから設定
	guf_switchEnableByFlag(True, "Edit74_4", 74)
	guf_setControl( glob_iniStartUpOptionText, "Edit74_4", 74 )
	guf_switchEnableByFlag(glob_iniStartUpOptionFlag, "Edit74_4", 74)

	guf_setControl( glob_iniStartUpOptionTextPattern2, "Edit74_5", 74 )
	guf_setControl( glob_iniClickOnlyGuiNotFlag, "Checkbox74_9", 74 )
	;guf_setControl( glob_iniAutoPopupNotViewFlag, "Checkbox74_10", 74 )
	guf_setControl( O_inputListAutoNotFlag, "Checkbox74_10", 74 )
	guf_setControl( glob_iniChangeStockInsertNotFlag, "Checkbox74_1_12", 74 )
	;guf_setControl( glob_iniMultipleExplainNotFlag, "Checkbox74_11", 74 )
	guf_setControl( O_tmpOutputMultipleTextFlag, "Checkbox74_11", 74 )

	guf_setControl( glob_iniTmpOutput_sec, "UpDown74_2_1", 74 )
	guf_setControl( glob_iniOutput_sec, "UpDown74_2_2", 74 )
	guf_setControl( glob_iniError_sec, "UpDown74_2_3", 74 )
	guf_setControl( glob_iniStock_sec, "UpDown74_2_4", 74 )
	guf_setControl( glob_iniTimerGui_sec, "UpDown74_2_5", 74 )
	guf_setControl( glob_iniTmpOutputNotViewFlag, "Checkbox74_2_1", 74 )
	guf_setControl( glob_iniOutputNotViewFlag, "Checkbox74_2_2", 74 )
	guf_setControl( glob_iniErrorNotViewFlag, "Checkbox74_2_3", 74 )

	guf_setControl( glob_iniFileCleanTextFlag , "Checkbox74_3_1", 74 )
	guf_setControl( glob_iniScriptCleanTextFlag, "Checkbox74_3_2", 74 )
	guf_setControl( glob_iniMultipleCleanTextFlag, "Checkbox74_3_3", 74 )
	guf_setControl( glob_iniFileGuiNotHide, "Checkbox74_3_4", 74 )
	guf_setControl( glob_iniScriptGuiHide, "Checkbox74_3_5", 74 )
	guf_setControl( glob_iniMultipleGuiHide, "Checkbox74_3_6", 74 )
	guf_setControl( glob_iniAhkCommExeGuiHide, "Checkbox74_3_7", 74 )
	;guf_setControl( glob_iniTextGuiMinimize, "Checkbox74_3_9", 74 )
	guf_setControl( O_minimizeTextFlag, "Checkbox74_3_9", 74 )
	;guf_setControl( glob_iniSpacePlusFlag, "Checkbox74_3_10", 74 )
	guf_setControl( O_spacePlusFlag, "Checkbox74_3_10", 74 )
	;guf_setControl( glob_iniFuncExeGuiHide, "Checkbox74_3_8", 74 )

	GuiControl, 74:Choose, Tab74_1 , 1

	;なぜか最前面に表示されないので遅らせる
	Sleep, 300
	Gui, 74:Show
}

syf_configGui(){

	;glob_iniSpaceFileNotFlag := guf_getControl( "Checkbox74_1", 74 )
	O_spaceFileNotFlag := guf_getControl( "Checkbox74_1", 74 )
	glob_iniAbsolePathNotFlag := guf_getControl( "Checkbox74_4", 74 )
	;glob_iniHistoryCount := guf_getControl( "UpDown74_1", 74 )
	O_textHistory := guf_getControl( "UpDown74_1", 74 )

	;if(glob_iniHistoryCount >= 100){
	if(O_textHistory >= 100){
		guit_errorAppend("コマンドの履歴の数でエラー`n履歴の数は99までしか設定できないため、`n初期値に設定する。")
		;glob_iniHistoryCount := defa_defaultIniHistoryCount
		O_textHistory := defa_defaultIniHistoryCount
	}

	glob_iniTimerTextPeriod_sec := guf_getControl( "Edit74_2", 74 )
	if(glob_iniTimerTextPeriod_sec <= 0){
		guit_errorAppend("タイマーの秒数の間隔の設定でエラー`n秒数が設定できない値のため、`n初期値に設定する。")
		glob_iniTimerTextPeriod_sec := defa_defaultIniTimerTextPeriod_sec
	}
	if(glob_iniTimerTextPeriod_sec >= 1000){
		guit_errorAppend("タイマーの秒数の間隔の設定でエラー`n1000秒数以上の設定はできないため、`n初期値に設定する。")
		glob_iniTimerTextPeriod_sec := defa_defaultIniTimerTextPeriod_sec
	}

	glob_iniCommListCloseNotSaveFlag := guf_getControl( "Checkbox74_7", 74 )
	glob_iniStartUpOptionFlag := guf_getControl( "Checkbox74_8", 74 )
	glob_iniStartUpOptionText := guf_getControl( "Edit74_4", 74 )
	glob_iniStartUpOptionTextPattern2 := guf_getControl( "Edit74_5", 74 )
	glob_iniClickOnlyGuiNotFlag := guf_getControl( "Checkbox74_9", 74 )
	;glob_iniAutoPopupNotViewFlag := guf_getControl( "Checkbox74_10", 74 )
	O_inputListAutoNotFlag := guf_getControl( "Checkbox74_10", 74 )
	glob_iniChangeStockInsertNotFlag := guf_getControl( "Checkbox74_1_12", 74 )
	;glob_iniMultipleExplainNotFlag := guf_getControl( "Checkbox74_11", 74 )
	O_tmpOutputMultipleTextFlag := guf_getControl( "Checkbox74_11", 74 )

	glob_iniTmpOutput_sec := guf_getControl( "UpDown74_2_1", 74 )
	if(glob_iniTmpOutput_sec >= 1000){
		guit_errorAppend("閉じる時間の設定でエラー`n1000秒数以上の設定はできないため、`n初期値に設定する。")
		glob_iniTmpOutput_sec = 7
	}
	glob_iniOutput_sec := guf_getControl( "UpDown74_2_2", 74 )
	if(glob_iniOutput_sec >= 1000){
		guit_errorAppend("閉じる時間の設定でエラー`n1000秒数以上の設定はできないため、`n初期値に設定する。")
		glob_iniOutput_sec = 7
	}
	glob_iniError_sec := guf_getControl( "UpDown74_2_3", 74 )
	if(glob_iniError_sec >= 1000){
		guit_errorAppend("閉じる時間の設定でエラー`n1000秒数以上の設定はできないため、`n初期値に設定する。")
		glob_iniError_sec = 10
	}
	glob_iniStock_sec := guf_getControl( "UpDown74_2_4", 74 )
	if(glob_iniStock_sec >= 1000){
		guit_errorAppend("閉じる時間の設定でエラー`n1000秒数以上の設定はできないため、`n初期値に設定する。")
		glob_iniStock_sec = 7
	}
	glob_iniTimerGui_sec := guf_getControl( "UpDown74_2_5", 74 )
	if(glob_iniTimerGui_sec >= 1000){
		guit_errorAppend("閉じる時間の設定でエラー`n1000秒数以上の設定はできないため、`n初期値に設定する。")
		glob_iniTimerGui_sec = 7
	}

	glob_iniTmpOutputNotViewFlag := guf_getControl( "Checkbox74_2_1", 74 )
	glob_iniOutputNotViewFlag := guf_getControl( "Checkbox74_2_2", 74 )
	glob_iniErrorNotViewFlag := guf_getControl( "Checkbox74_2_3", 74 )

	glob_iniFileCleanTextFlag := guf_getControl( "Checkbox74_3_1", 74 )
	glob_iniScriptCleanTextFlag := guf_getControl( "Checkbox74_3_2", 74 )
	glob_iniMultipleCleanTextFlag := guf_getControl( "Checkbox74_3_3", 74 )
	glob_iniFileGuiNotHide := guf_getControl( "Checkbox74_3_4", 74 )
	glob_iniScriptGuiHide := guf_getControl( "Checkbox74_3_5", 74 )
	glob_iniMultipleGuiHide := guf_getControl( "Checkbox74_3_6", 74 )
	glob_iniAhkCommExeGuiHide := guf_getControl( "Checkbox74_3_7", 74 )
	;glob_iniTextGuiMinimize := guf_getControl( "Checkbox74_3_9", 74 )
	O_minimizeTextFlag := guf_getControl( "Checkbox74_3_9", 74 )
	;glob_iniSpacePlusFlag := guf_getControl( "Checkbox74_3_10", 74 )
	O_spacePlusFlag := guf_getControl( "Checkbox74_3_10", 74 )
	;glob_iniFuncExeGuiHide := guf_getControl( "Checkbox74_3_8", 74 )

	configFile := gloco_userDir . glob_configFileName
	func_folderCheckMakeFolder(gloco_userDir)
	;IniWrite, %glob_iniSpaceFileNotFlag%, %configFile%, config, spaceFile
	;IniWrite, %glob_iniHistoryCount%,     %configFile%, config, historyCount
	;IniWrite, %glob_iniAutoPopupNotViewFlag%,     %configFile%, config, autoPopupViewFlag
	;IniWrite, %glob_iniMultipleExplainNotFlag%,     %configFile%, config, multipleExplainFlag
	;IniWrite, %glob_iniTextGuiMinimize%,     %configFile%, config, textGuiMinimize
	;IniWrite, %glob_iniSpacePlusFlag%,     %configFile%, config, spacePlusFlag
	;IniWrite, %glob_iniFuncExeGuiHide%,     %configFile%, config, funcExeGuiHide
	IniWrite, %O_spaceFileNotFlag%, %configFile%, config, spaceFile
	IniWrite, %glob_iniAbsolePathNotFlag%,     %configFile%, config, argsToAbsolePath
	IniWrite, %O_textHistory%,     %configFile%, config, historyCount
	IniWrite, %glob_iniTimerTextPeriod_sec%,     %configFile%, config, textPeriod_sec
	IniWrite, %glob_iniCommListCloseNotSaveFlag%,     %configFile%, config, commListEscSaveFlag
	IniWrite, %glob_iniStartUpOptionFlag%,     %configFile%, config, startUpOptionFlag
	IniWrite, %glob_iniStartUpOptionText%,     %configFile%, config, startUpOptionText
	IniWrite, %glob_iniStartUpOptionTextPattern2%,     %configFile%, config, startUpOptionTextPattern2
	IniWrite, %glob_iniClickOnlyGuiNotFlag%,     %configFile%, config, clickOnlyGuiFlag
	IniWrite, %O_inputListAutoNotFlag%,     %configFile%, config, autoPopupViewFlag
	IniWrite, %glob_iniChangeStockInsertNotFlag%,     %configFile%, config, changeStockInsertNotFlag
	IniWrite, %O_tmpOutputMultipleTextFlag%,     %configFile%, config, multipleExplainFlag
	IniWrite, %glob_iniTmpOutput_sec%,     %configFile%, config, tmpOutput_sec
	IniWrite, %glob_iniOutput_sec%,     %configFile%, config, output_sec
	IniWrite, %glob_iniError_sec%,     %configFile%, config, error_sec
	IniWrite, %glob_iniStock_sec%,     %configFile%, config, stock_sec
	IniWrite, %glob_iniTimerGui_sec%,     %configFile%, config, timerGui_sec
	IniWrite, %glob_iniTmpOutputNotViewFlag%,     %configFile%, config, tmpOutputNotViewFlag
	IniWrite, %glob_iniOutputNotViewFlag%,     %configFile%, config, outputNotViewFlag
	IniWrite, %glob_iniErrorNotViewFlag%,     %configFile%, config, errorNotViewFlag
	IniWrite, %glob_iniFileCleanTextFlag%,     %configFile%, config, fileCleanTextFlag
	IniWrite, %glob_iniScriptCleanTextFlag%,     %configFile%, config, scriptCleanTextFlag
	IniWrite, %glob_iniMultipleCleanTextFlag%,     %configFile%, config, multipleCleanTextFlag
	IniWrite, %glob_iniFileGuiNotHide%,     %configFile%, config, fileGuiNotHide
	IniWrite, %glob_iniScriptGuiHide%,     %configFile%, config, scriptGuiHide
	IniWrite, %glob_iniMultipleGuiHide%,     %configFile%, config, multipleGuiHide
	IniWrite, %glob_iniAhkCommExeGuiHide%,     %configFile%, config, ahkCommExeGuiHide
	IniWrite, %O_minimizeTextFlag%,     %configFile%, config, textGuiMinimize
	IniWrite, %O_spacePlusFlag%,     %configFile%, config, spacePlusFlag

	guit_checkErrorLevelOutput("設定ファイルの書き込み時にエラーあり")
	
	;cen_clickOnlyGuiShow()
}

