

F_setControl(GuiNum, controlVar, value){
	GuiControl,%GuiNum%: , %controlVar%, %value%
	;guit_setExplainNotShow("F_setControl( )`n引数   " . GuiNum . ",  " . controlVar . ",  " . value . "`nを実行した", 71)
}

F_getControl(GuiNum, controlVar){
	GuiControlGet, %controlVar%, %GuiNum%:
	str := %controlVar%
	return  str
}

F_GuiControl(GuiNum,controlVar,option,value="_"){
	; option を指定しないときは、カラにしても、_の文字でもよくする
	if( option == "_" ){
		option =
	}
	guf_GuiControl(controlVar, GuiNum, option, value)
	guit_setExplainNotShow("F_GuiControl( )`n引数   " . GuiNum . ",  " . controlVar . ",  " . option . ",  " . value . "`nを実行した", 71)
}

F_GuiControlGet(GuiNum,controlVar,option="_", value="_"){
	str := guf_GuiControlGet(controlVar, GuiNum, option, value)
	return str
}

F_Gui(GuiNum, option, value1="_", value2="_", value3="_"){
	guf_Gui(option, GuiNum, value1, value2, value3)
	;guit_setExplainNotShow("F_Gui( )`n引数   " . GuiNum . ",  " . option . ",  " . value1 . ",  " . value2 . ",  " . value3 . "`nを実行した", 71)
}

; 画像ファイルがあるかを確認して、画像を追加する。
; 画像が見つかれば True を返す。
; 見つからなければ、何もせず False を返す。
F_GuiAddPictureFileExist(GuiNum, file, option){
	if( func_myFileExist(file) ){
		Gui, %GuiNum%:Add, Picture, %option%, %file%
		return True
	}
	return False
}

; 画像を追加する。
; noExtFile には、拡張子なしでファイルパスを指定する。
; noExtFile プラス、.gif  .jpg  .jpeg  .png  のいずれかのファイルが見つかれば画像を追加する。
; noExtFile のファイルが存在するなら、そちらを使用する
; 画像が見つかれば True を返す。
; 見つからなければ、何もせず False を返す。
F_GuiAddPictureNoExtFile(GuiNum, noExtFile, option){
	if( noExtFile == "" ){
		return False
	}
	flag := F_GuiAddPictureFileExist(GuiNum, noExtFile, option)
	if( flag ){
		return True
	}
	flag := outs_bgPictureAddEnyExtFile(noExtFile, option, GuiNum)
	return flag
}

F_textExe(command){
	edi_outPutSucceedFlagStopCommandExe(command, "", "", 71, null, True)
}

F_textExeTextSplit(text1, text2, text3, workFolder, text5, text6, text7, text8, dbqFlag=True){
	edc_editssCommExeLogic(text1, text2, text3, workFolder, text5, text6, text7, text8, dbqFlag, 71, True, True)
}

F_output(append){
	guit_appendExplain(append)
}

F_tmpOutput(str){
	guit_setBoxEdit68_1CustSingle(str)
	;return str
}

F_errorOutput(append){
	guit_errorAppend(append)
}

; O_toolTipX と O_toolTipY の位置に表示させるツールチップ
F_toolTipOutput(str){
	timf_toolTipFunc(str, O_toolTipX, O_toolTipY, O_toolTipSecond)
}

F_toolTipOutputAssign(str, posX, posY, sec=3){
	timf_toolTipFunc(str, posX, posY, sec)
}

; ツールチップの種類 2 を使用するだけ
F_toolTipOutputAssignNumber2(str, posX, posY, sec=3){
	timf_toolTipClose2(sec)
	if(sec <= 0){
		return
	}
	ToolTip , %str%, %posX%, %posY%, 2
}

;テキストのウインドウを閉じるのに使う。
;「テキストを閉じるとき、最小化する」の設定の影響を受ける。
;説明表示のウインドウも一緒に閉じる。
F_hideGuiTextPattern(GuiNum){
	edi_hideOrMinimizeGuiTextPattern(GuiNum, True, True, False)
}

;minimizeOption  が 1 なら「テキストを閉じるとき、最小化する」の設定の影響を受ける
;outGuiHideFlag  が 1 なら説明表示のウインドウも一緒に閉じるようになる
F_hideGuiTextPatternOption(GuiNum, outGuiHideFlag="1", minimizeOption="1"){
	edi_hideOrMinimizeGuiTextPattern(GuiNum, minimizeOption, outGuiHideFlag, False)
}

F_showToggleGui(GuiNum, option="_"){
	winTitle := gGlob_Gui%GuiNum%Title
	guf_showHideGuiToggle(winTitle, GuiNum, option)
	;guit_setExplainNotShow("F_showToggleGui( )`n引数   " . GuiNum . ",  " . option . "`nを実行した", 71)
}

F_showToggleGuiWinTitle(GuiNum, winTitle, option="_"){
	guf_showHideGuiToggle(winTitle, GuiNum, option)
	;guit_setExplainNotShow("F_showToggleGuiWinTitle( )`n引数   " . GuiNum . ",  " . winTitle . ",  " . option . "`nを実行した", 71)
}

;テキストのウインドウを表示するのに使う。
;閉じるときの動作に  F_hideGuiTextPattern(GuiNum)  と同じ動作を使用。
;閉じている場合と最小化している場合、前面に表示する
F_showToggleGuiTextPattern(GuiNum, pOrder="_"){
	edi_showHideGuiTextPattern(GuiNum, True, True, pOrder)
}

;閉じる動作は  F_hideGuiTextPatternOption(GuiNum, outGuiHideFlag="1", minimizeOption="1")  を使用するので
;minimizeOption  と  outGuiHideFlag を指定する
F_showToggleGuiTextPatternOption(GuiNum, outGuiHideFlag="1", minimizeOption="1", pOrder="_"){
	edi_showHideGuiTextPattern(GuiNum, minimizeOption, outGuiHideFlag, pOrder)
}

F_showLastWord(option="_", toggleFlag=True, sleepFlag=False){
	if( toggleFlag ){
		syf_showSetLastWordConfigToggle(option, sleepFlag)
	} else {
		syf_showAndLastWordConfigGuiSet(option, sleepFlag)
	}
}

F_minimizeGui(GuiNum){
	Gui, %GuiNum%:Minimize
}

F_multiplelineExe(command){
	musc_multipleScriptsExe(command, "", 82, "", False, 1)
}

F_dateAndTimeNow(){
	FormatTime,returnValue, %A_Now%, yyyy年MM月dd日 HH時mm分ss秒`n
	return returnValue
}

F_transformDeref(str){
	Transform, str, Deref, %str%
	return str
}

F_textOut(str){
	str := outs_textOutTrimss(str)
	return str
}

; ErrorLevel_TextRunRun が 1 以上なら、errorMessageをエラー表示し、False を返す。
F_ErrorLevel_TextRunRunCheck(errorMessage){
	if(ErrorLevel_TextRunRun >= 1){
		F_errorOutput("ErrorLevel_TextRunRun   " . ErrorLevel_TextRunRun  . "`n" . errorMessage)
		return False
	}
	return True
}

F_ErrorLevel_TextRunRunRestore(){
	ErrorLevel_TextRunRun = 0
	guit_setExplainNotShow("F_ErrorLevel_TextRunRunRestore( )`nを実行した", 71)
}

F_imeGet(){
	flag := othli_IME_GET("A")
	return flag
}

F_imeSet(flag=1){
	othli_IME_SET(flag, "A")
}

F_setTextGuiAssign(value, GuiNum, number="1", textOutFlag=True, addFlag=False){
	;controlVar := "Edit" . GuiNum . "_" . number
	;GuiControl,%GuiNum%: , %controlVar%, %value%

	args := GuiNum . " " . number . " " . value
	edi_outTextToTextGuiAssign(args, 71, textOutFlag, addFlag)
}

F_getTextGuiAssign(GuiNum, number="1", trimFlag=True){
	;controlVar := "Edit" . GuiNum . "_" . number
	;GuiControlGet, %controlVar%, %GuiNum%:
	;str := %controlVar%

	str := edi_getTextGuiAssign(GuiNum, number)
	if( trimFlag ){
		str := Trim( str )
	}
	return  str
}

F_getTextEditExecutor(trimFlag=True){
	returnValue = 
	targetGui = %A_Gui%
	typeNum := guit_editTypeNumGet(targetGui)
	if(typeNum == 1){
		GuiControlGet, focusEdit , %targetGui%:FocusV
		focusEdit := guaf_focusCheck(focusEdit, targetGui)
		if( focusEdit != "" ){
			returnValue := guf_getControl( focusEdit, targetGui )
		}
	} else if(typeNum == 3){
		; 何もしない
	} else if(typeNum == 4){
		; 何もしない
	} else if(typeNum == 2){
		Edit1 := "Edit" . targetGui  . "_1"
		returnValue := guf_getControl( Edit1, targetGui )
	} else if(typeNum == 0){
		Edit1 := "Edit" . targetGui  . "_1"
		returnValue := guf_getControl( Edit1, targetGui )
	}
	if( trimFlag ){
		returnValue := Trim( returnValue )
	}
	return returnValue
}

F_itemExe(itemName, args=""){
	flag := excof_itemExecute(itemName, args, "", "", 71, "", "", True, args, args, False, 1)
	return  flag
}

F_lastWordTabChange(number="1"){
	GuiControl, 84:Choose, Tab84_1, %number%
}

F_inputListUpDownKey(number){
	aut_controlKeyUpDownTestAnotherGui(False, number)
}

F_inputListSelectOutputAssign(GuiNum){
	flag := edi_pushEnterFromListEditAnotherGui(GuiNum, False)
	return  flag
}

F_snippetAdd(key, sentence, spaceFlag=False){
	cinp_snippetAdd(key, sentence, spaceFlag, "", 71)
}

; D_stockBlue_1$$ などの文字を変換して返す
F_getConvertCollabTextWord(str){
	str := edi_replaceOtherEditAll(str, 1)
	return str
}

F_getItemScript(itemName){
	optionObj := cen_getFromEnyObject(itemName)
	if(IsObject(optionObj)) {
		return optionObj[1]
	}
	return  ""
}

F_getItemArgument(itemName){
	optionObj := cen_getFromEnyObject(itemName)
	if(IsObject(optionObj)) {
		optionObj := glob_softObj[itemName]
		if(IsObject(optionObj)) {
			return optionObj[2]
		}
		guit_errorAppend("F_getItemArgument() の関数のエラー。`n種類がソフト・ファイル名でしか使えない`nアイテム名  " . itemName)
	}
	return  ""
}

F_getItemWorkingFolder(itemName){
	optionObj := cen_getFromEnyObject(itemName)
	if(IsObject(optionObj)) {
		optionObj := glob_softObj[itemName]
		if(IsObject(optionObj)) {
			return optionObj[3]
		}
		guit_errorAppend("F_getItemWorkingFolder() の関数のエラー。`n種類がソフト・ファイル名でしか使えない`nアイテム名  " . itemName)
	}
	return  ""
}

; アイテムの種類の番号を返す。アイテムがなければ、0 を返す
F_getItemType(itemName){
	optionObj := cen_getFromEnyObject(itemName)
	if(IsObject(optionObj)) {
		return optionObj[5]
	}
	return  "0"
}

; 実行元のテキストを非表示にした後、どれかのウインドウがアクティブになるのを待つ
F_hideGuiTextAndWaitActiveAny(){
	if(A_Gui != ""){
		edi_hideOrMinimizeGuiTextPattern(A_Gui, True, False, False)
	}
	windc_anyWaitActive()
}

; ウインドウタイトルで A を指定していた場合のみ、上の F_hideGuiTextAndWaitActiveAny() を実行する
F_hideGuiTextAndWaitActiveIfA(winTitle="A"){
	if(winTitle == "A"){
		if(A_Gui != ""){
			edi_hideOrMinimizeGuiTextPattern(A_Gui, True, False, False)
		}
	}
}

F_winActiveAndWait(winTitle="A"){
	WinActivate , %winTitle%
	WinWaitActive , %winTitle%, , 1
}

; 指定のウインドウがアクティブになるのを待つ
F_winWaitActive(winTitle="A"){
	WinWaitActive , %winTitle%, , 1
}

F_getShortcutPath(shortcutFile){
	file := outs_textOutDqAllTrim(shortcutFile)
	if( func_myFileExist(file) ){
		FileGetShortcut, %file% , OutTarget
		if(OutTarget != ""  ){
			return OutTarget
		}
	}
	guit_errorAppend("F_getShortcutPath() のエラー`n以下のファイルパスはリンクではない`n引数  " . shortcutFile)
	return ""
}

F_getShortcutPathAndArgs(shortcutFile){
	file := outs_textOutDqAllTrim(shortcutFile)
	if( func_myFileExist(file) ){
		FileGetShortcut, %file% , OutTarget, OutDir, OutArgs
		if(OutTarget != ""  ){
			pathArgs := OutTarget  . " " . OutArgs
			pathArgs := RTrim(pathArgs)
			return pathArgs
		}
	}
	guit_errorAppend("F_getShortcutPathAndArgs() のエラー`n以下のファイルパスはリンクではない`n引数  " . shortcutFile)
	return ""
}

; 上位のフォルダを返す
; textOutFlag が True なら、##\などを展開した返り値を返す。 False なら、##\などを展開しないままにする
; ファイルが見つからない場合は カラの文字を返す
F_getParentFolder(file, textOutFlag=False){
	fileTextOut := outs_textOutTrimss(file)
	if( func_myFileExist(fileTextOut) ){
		returnValue =
		if( textOutFlag ){
			returnValue := outs_getParentDir(fileTextOut, 1, A_LineFile, A_LineNumber, False)
		} else {
			; ##\ などで記入している場合、それをそのままにするため、単純な処理で済ます
			returnValue := func_getBackDir(file, 1)
		}
		if( guit_checkErrorLevelOutput("F_getParentFolder() のエラー`n以下のファイルパスの上位フォルダは所得出来ない`n" . file) ){
			returnValue := RTrim( returnValue, "\" )
			return returnValue
		}
		return ""
	}
	guit_errorAppend("F_getParentFolder() のエラー`n以下のファイルパスが存在しない`n" . file)
	return ""
}

; str の値に searchText の文字があるか調べて、あったら置換
F_stringReplace(str, searchText, replaceText, allFlag=False){
	IfInString, str, %searchText%
	{
		if( allFlag ){
			StringReplace, str, str, %searchText% , %replaceText%, All
		} else {
			StringReplace, str, str, %searchText% , %replaceText%
		}
	}
	return  str
}

F_linefeedReplace(str){
	IfInString, str, ``n
	{
		StringReplace, str, str,``n,`n, All
	}
	IfInString, str, ``r
	{
		StringReplace, str, str,``r,`r, All
	}
	return str
}

F_linefeedReplaceOnEscapeCharacter(str){
	IfInString, str, `n
	{
		StringReplace, str, str,`n,``n, All
	}
	IfInString, str, `r
	{
		StringReplace, str, str,`r,``r, All
	}
	return str
}

F_sendToWindow(key, winTitle, beforeWinDelay=100, afterSleepDelay=0){
	If beforeWinDelay is not integer
	{
		guit_errorAppend(A_ThisFunc . "() のエラー。`nbeforeWinDelay に整数以外の値を指定している")
		return
	}
	If afterSleepDelay is not integer
	{
		guit_errorAppend(A_ThisFunc . "() のエラー。`nafterSleepDelay に整数以外の値を指定している")
		return
	}
	if(beforeWinDelay <= -1){
		guit_errorAppend(A_ThisFunc . "() のエラー。`nbeforeWinDelay にマイナスの値を指定している")
		return
	}
	if(afterSleepDelay <= -1){
		guit_errorAppend(A_ThisFunc . "() のエラー。`nafterSleepDelay にマイナスの値を指定している")
		return
	}
	SetWinDelay, %beforeWinDelay%
	WinGetClass, exeClass , A
	F_winActiveAndWait(winTitle)
	Send, %key%
	if( afterSleepDelay != 0){
		Sleep, %afterSleepDelay%
	}
	WinActivate , ahk_class %exeClass%
}

F_conversion16To10( hex ){
	SetFormat, Integer, D
	trimStr_local := Trim( hex )
	if(trimStr_local == "") {
		guit_errorAppend(A_ThisFunc . "() のエラー`n引数の値がカラ")
		return "error"
	}
	If hex is not xdigit
	{
		guit_errorAppend(A_ThisFunc . "() のエラー`n引数の値が16進数以外の文字になっている`nhex   " . hex)
		return "error"
	}
	if(hex == 0){
		return "0"
	}
	if(hex == "0x"){
		guit_errorAppend(A_ThisFunc . "() のエラー`n引数の値が0xだけの文字になっている`nhex   " . hex)
		return "error"
	}
	StringLen, hexLen_local, hex
	if(hexLen_local <= 2){
		hex := LTrim(hex, "0")
		if(hex == "") {
			guit_errorAppend(A_ThisFunc . "() のエラー`n0を除くと引数の値がカラになってしまう")
			return "error"
		}
		hex = 0x%hex%
	} else {
		; hexLen_local が 3以上の場合
		StringLeft, hexChar2_local, hex, 2
		if(hexChar2_local != "0x"){
			hex := LTrim(hex, "0")
			if(hex == "") {
				guit_errorAppend(A_ThisFunc . "() のエラー`n0を除くと引数の値がカラになってしまう")
				return "error"
			}
			hex = 0x%hex%
		}
	}
	hexChange_local := hex + 0
	if(hexChange_local == "") {
		guit_errorAppend(A_ThisFunc . "() のエラー`n何らかの理由で値がカラに変換されてしまう`nhex   " . hex)
		return "error"
	}
	If hexChange_local is not number
	{
		guit_errorAppend(A_ThisFunc . "() のエラー`n何らかの理由で値が数字以外に変換されてしまう`nhex   " . hex . "`n変換後   " . hexChange_local)
		return "error"
	}
	return hexChange_local
}

F_conversion10To16( number, trim0xFlag=False ){
	trimStr_local := Trim( number )
	if(trimStr_local == "") {
		guit_errorAppend(A_ThisFunc . "() のエラー`n引数の値がカラ")
		SetFormat, Integer, D
		return "error"
	}
	If number is not integer
	{
		guit_errorAppend(A_ThisFunc . "() のエラー`n引数の値が整数以外の文字になっている`nnumber   " . number)
		SetFormat, Integer, D
		return "error"
	}
	if(number <= -1) {
		guit_errorAppend(A_ThisFunc . "() のエラー`nマイナス値は変換できない`nnumber   " . number)
		SetFormat, Integer, D
		return "error"
	}

	SetFormat, Integer, H
	; １度計算する。でないと16進数にならない
	hexValue_local := number + 0
	if(hexValue_local == "") {
		guit_errorAppend(A_ThisFunc . "() のエラー`n何らかの理由で値がカラに変換されてしまう`nnumber   " . number)
		SetFormat, Integer, D
		return "error"
	}
	if(trim0xFlag) {
		; 0xを取り除く
		StringTrimLeft, hexValue_local, hexValue_local, 2
	}
	If hexValue_local is not xdigit
	{
		guit_errorAppend(A_ThisFunc . "() のエラー`n変換後の文字が１６進数にならない`nnumber   " . number . "`n変換後   " . hexValue_local)
		SetFormat, Integer, D
		return "error"
	}

	StringLower, hexValue_local, hexValue_local
	SetFormat, Integer, D
	return hexValue_local
}

F_trim0xFrom16( hex ){
	trimStr_local := Trim( hex )
	if(trimStr_local == "") {
		guit_errorAppend(A_ThisFunc . "() のエラー`n引数の値がカラ")
		return hex
	}
	If hex is not xdigit
	{
		guit_errorAppend(A_ThisFunc . "() のエラー`n引数の値が16進数以外の文字になっている`nhex   " . hex)
		return hex
	}
	if(hex == 0){
		return "0"
	}
	if(hex == "0x"){
		guit_errorAppend(A_ThisFunc . "() のエラー`n引数の値が0xだけの文字になっている`nhex   " . hex)
		return hex
	}
	StringLen, hexLen_local, hex
	if(hexLen_local >= 3){
		StringLeft, hexChar2_local, hex, 2
		if(hexChar2_local == "0x"){
			; 0xを取り除く
			StringTrimLeft, hexValue_local, hex, 2
			return hexValue_local
		}
	}
	return hex
}

F_confirmDateTime6Char(str){
	returnStr := linu_getDateTimeOfAt(str)
	if(returnStr == "error"){
		return False
	}
	return True
}

F_confirmHMSSentence(str){
	allSec := linu_confirmTimerArgss(str)
	if(allSec == "error"){
		return False
	} else if(allSec > 0){
		if( allSec >= 86400 ){
			;guit_errorAppend( A_ThisFunc . "() のエラー。現時点では２４時間以上先の指定はできない" )
			return False
		}
		return True
	}
	return False
}

F_getTimerInformation(listNumber, inforNumber=1){

	If listNumber is not integer
	{
		guit_errorAppend(A_ThisFunc . "() のエラー`nlistNumber にタイマーの番号を指定していない`n" . listNumber)
		return "error"
	}
	If listNumber not between 1 and 10
	{
		guit_errorAppend(A_ThisFunc . "() のエラー`nlistNumber の指定が１から１０以内ではない`n" . listNumber)
		return "error"
	}

	If inforNumber is not integer
	{
		guit_errorAppend(A_ThisFunc . "() のエラー`ninforNumber に番号を指定していない`ninforNumber  " . inforNumber)
		return "error"
	}

	flag_local := glob_timerFlag%listNumber%
	if( inforNumber == 3 ){
		if( flag_local ){
			return 1
		}
		return 0
	}

	if( flag_local == False ){
		guit_errorAppend(A_ThisFunc . "() のエラー`nlistNumber に指定した番号のタイマーは実行中ではない。`nlistNumber  " . listNumber)
		return "error"
	}

	if( inforNumber == 1 ){
		dateTime := glob_timer%listNumber%
		todaySec := timf_dateTimeToSec( dateTime )
		; todaySec は日付は関係なく、時間のみで取得しているため
		; nowSec より低い場合、その対処をする
		; 現時点では ２４時間以上先は指定できないため、この処理でよい
		nowSec := timf_dateTimeToSec( A_Now )
		if(todaySec <= nowSec){
			oneDay_sec := timf_minHourToSec(24, 0, 0)
			todaySec += oneDay_sec
		}
		ans_local := todaySec - nowSec
		; タイマーの実行中の時と違い、A_Now が変わる訳ではないので
		; 日付をまたいで nowSec が小さくなったりしないので以下の事はしない
		;if(ans_local >= 86400){
		;	ans_local -= 86400
		;}
		return ans_local
	}
	if( inforNumber == 2 ){
		ans_local := glob_timeArgStr%listNumber%
		return ans_local
	}
	guit_errorAppend(A_ThisFunc . "() のエラー`ninforNumber の指定が１から３以内ではない`n" . inforNumber)
	return "error"
}

; fromFileName のアイテムを一つだけ読み込む。
; itemCategoryDir の引数には、アイテムのカテゴリー用のフォルダ内にある場合に、フォルダ名を記入する(最後に _ があるフォルダ)
; categoryDir の引数には、直下カテゴリー用のフォルダ名を記入する。カラ なら first を指定した事と同じになる。
; エラーがある場合は 0 。編集した場合は 1 。新規登録の場合なら、2 を返す。
; アイテムを削除した後、エラーがある場合は 3 を返す
F_itemReloadOneFromFileName(itemName, itemCategoryDir="", categoryDir=""){
	itemName := Trim( itemName )
	if(itemName == ""){
		guit_errorAppend("F_itemReloadOneFromFileName() のエラー。`nアイテム名がカラになっている")
		return "0"
	}
	returnValue := cen_itemReloadOneFromFileNameLogic(itemName, itemCategoryDir, categoryDir, A_ThisFunc . "()")
	return returnValue
}

; アイテムを新規登録する。
; エラーがある場合は 0 。新規登録した場合は 1 を返す。
F_newItemFromCommand(radioNum, itemName, script, args="", workDir="", dbQuoutFlag=False){
	itemName := Trim( itemName )
	if(itemName == ""){
		guit_errorAppend("F_newItemFromCommand() のエラー。`nアイテム名がカラになっている")
		return "0"
	}
	returnValue := musc_newItemFromCommandLogic(radioNum, itemName, script, args, workDir, dbQuoutFlag, A_ThisFunc . "()")
	return returnValue
}

; 漢数字と全角文字の数字を半角の数字に変換する
; 現時点では 万の桁までしか対応できない
F_kanjiAndFullNumeralReplaceInteger(sentence, errorNotViewFlag=False){
	errorViewFlag := True
	if( errorNotViewFlag ){
		errorViewFlag := False
	}
	sentence := outs_kanjiAndFullNumeralReplaceInteger(sentence, sentence, errorViewFlag)
	return sentence
}

; 漢数字や全角文字から 時間を表す６桁の数字を返す。
; 時  分  秒  の単語から、時間を解析する。
; ２、４、６桁の数字のみの指定の場合、時間を表す数字かどうかを調べて、６桁の数字を返す
; dateTime の数字の場合も、６桁の数字のみを返す
; エラーがあった場合、error の文字を返す
F_getDateTime6CharFromKanji(sentence="二十三時三分三十秒", errorNotViewFlag=False){

	errorViewFlag := True
	if( errorNotViewFlag ){
		errorViewFlag := False
	}

	sentence := Trim(sentence)

	; dateTime の場合、6 桁の数字のみ返す
	If sentence is time
	{
		StringRight, timeOnly, sentence, 6
		return timeOnly
	}

	; 23:59:59 などの書式なら、６桁の数字にして返す
	tmpSentence := outs_getDateTime6CharColon(sentence)
	; 2 4 6桁の数字でも、6 桁の数字のみ返す
	dateTime := linu_getDateTimeOfAt(tmpSentence)
	if( dateTime != "error" ){
		StringRight, timeOnly, dateTime, 6
		return timeOnly
	}

	; sentence はとっておくので、別の変数を用意してそちらを使う
	timeWord := sentence
	; 全角スペースを半角スペースに
	timeWord := func_stringReplace(timeWord, "　", A_Space, True)

	; hour の初期値は ?? に
	hour := "??"
	min := "00"
	sec := "00"

	; 時 ではなく 時間 の文字で指定してたらエラーにする
	IfInString, timeWord, 時間
	{
		guit_errorAppendViewFlag(errorViewFlag, "F_getDateTime6CharFromKanji() の関数のエラー。`n「時」ではなく「時間」の文字が指定されている。`n元の文字列  " . sentence)
		return "error"
	}

	target := "時"
	IfInString, timeWord, %target%
	{
		StringGetPos, index, timeWord, %target%
		StringLeft, leftStr, timeWord, %index%
		leftStr := Trim(leftStr)
		; 時 の左側の文字に空白があったら、その右端のみを参考にする
		IfInString, leftStr, %A_Space%
		{
			StringGetPos, index2, leftStr, %A_Space%, R1
			StringTrimLeft, rightStr, leftStr, %index2%
			leftStr := LTrim( rightStr )
		}
		; 左端に 午後 の文字があれば、 hour に12を足す
		pmFlag := False
		StringLen, num, leftStr
		if(num >= 3){
			StringLeft, leftStr_chr2, leftStr, 2
			if(leftStr_chr2 == "午後"){
				pmFlag := True
				StringTrimLeft, leftStr, leftStr, 2
			} else if(leftStr_chr2 == "午前"){
				StringTrimLeft, leftStr, leftStr, 2
			}
		}

		if(leftStr == ""){
			guit_errorAppendViewFlag(errorViewFlag, "F_getDateTime6CharFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n指定がカラ。`n元の文字列  " . sentence)
			return "error"
		}
		hour := outs_kanjiAndFullNumeralReplaceInteger(leftStr, sentence, errorViewFlag)
		if(hour == "error"){
			guit_errorAppendViewFlag(errorViewFlag, "F_getDateTime6CharFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n元の文字列  " . sentence)
			return "error"
		}
		hour := Trim(hour)
		If hour is not number
		{
			guit_errorAppendViewFlag(errorViewFlag, "F_getDateTime6CharFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n時間が数字ではない。`n時間  " . hour . "`n元の文字列  " . sentence)
			return "error"
		}

		if( pmFlag ){
			hour += 12
		}

		; 時間 の文字の右のみを timeWord に変える
		StringGetPos, index, timeWord, %target%
		indexPlus := index + 1
		StringTrimLeft, timeWord, timeWord, %indexPlus%

		; 半 の文字は ３０分 扱い
		StringLeft, lChr, timeWord, 1
		if( lChr == "半" ){
			min = 30
			; 半 の文字の右のみを timeWord に変える
			StringTrimLeft, timeWord, timeWord, 1
		}
	}

	target := "分"
	IfInString, timeWord, %target%
	{
		StringGetPos, index, timeWord, %target%
		StringLeft, leftStr, timeWord, %index%
		leftStr := Trim(leftStr)
		; 分 の左側の文字に空白があったら、その右端のみを参考にする
		IfInString, leftStr, %A_Space%
		{
			StringGetPos, index2, leftStr, %A_Space%, R1
			StringTrimLeft, rightStr, leftStr, %index2%
			leftStr := LTrim( rightStr )
		}
		if(leftStr == ""){
			guit_errorAppendViewFlag(errorViewFlag, "F_getDateTime6CharFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n指定がカラ。`n元の文字列  " . sentence)
			return "error"
		}
		min := outs_kanjiAndFullNumeralReplaceInteger(leftStr, sentence, errorViewFlag)
		if(min == "error"){
			guit_errorAppendViewFlag(errorViewFlag, "F_getDateTime6CharFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n元の文字列  " . sentence)
			return "error"
		}
		min := Trim(min)
		If min is not number
		{
			guit_errorAppendViewFlag(errorViewFlag, "F_getDateTime6CharFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n分が数字ではない。`n分  " . min . "`n元の文字列  " . sentence)
			return "error"
		}

		; 分 の文字の右のみを timeWord に変える
		StringGetPos, index, timeWord, %target%
		indexPlus := index + 1
		StringTrimLeft, timeWord, timeWord, %indexPlus%

		; 半 の文字は ３０秒 扱い
		StringLeft, lChr, timeWord, 1
		if( lChr == "半" ){
			sec = 30
			; 半 の文字の右のみを timeWord に変える
			StringTrimLeft, timeWord, timeWord, 1
		}
	}

	target := "秒"
	IfInString, timeWord, %target%
	{
		StringGetPos, index, timeWord, %target%
		StringLeft, leftStr, timeWord, %index%
		leftStr := Trim(leftStr)
		; 秒 の左側の文字に空白があったら、その右端のみを参考にする
		IfInString, leftStr, %A_Space%
		{
			StringGetPos, index2, leftStr, %A_Space%, R1
			StringTrimLeft, rightStr, leftStr, %index2%
			leftStr := LTrim( rightStr )
		}
		if(leftStr == ""){
			guit_errorAppendViewFlag(errorViewFlag, "F_getDateTime6CharFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n指定がカラ。`n元の文字列  " . sentence)
			return "error"
		}
		sec := outs_kanjiAndFullNumeralReplaceInteger(leftStr, sentence, errorViewFlag)
		if(sec == "error"){
			guit_errorAppendViewFlag(errorViewFlag, "F_getDateTime6CharFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n元の文字列  " . sentence)
			return "error"
		}
		sec := Trim(sec)
		If sec is not number
		{
			guit_errorAppendViewFlag(errorViewFlag, "F_getDateTime6CharFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n秒が数字ではない。`n秒  " . sec . "`n元の文字列  " . sentence)
			return "error"
		}
	}

	if(hour == "??"){
		guit_errorAppendViewFlag(errorViewFlag, "F_getDateTime6CharFromKanji() の関数のエラー。`n何時かの部分が指定されていない。`n元の文字列  " . sentence)
		return "error"
	}
	StringLen, num, hour
	if(num == 1){
		hour := "0" . hour
	} else if(num != 2){
		guit_errorAppendViewFlag(errorViewFlag, "F_getDateTime6CharFromKanji() の関数のエラー。`n桁数が不自然。`n時間  " . hour . "`n元の文字列  " . sentence)
		return "error"
	}
	StringLen, num, min
	if(num == 1){
		min := "0" . min
	} else if(num != 2){
		guit_errorAppendViewFlag(errorViewFlag, "F_getDateTime6CharFromKanji() の関数のエラー。`n桁数が不自然。`n分  " . min . "`n元の文字列  " . sentence)
		return "error"
	}
	StringLen, num, sec
	if(num == 1){
		sec := "0" . sec
	} else if(num != 2){
		guit_errorAppendViewFlag(errorViewFlag, "F_getDateTime6CharFromKanji() の関数のエラー。`n桁数が不自然。`n秒  " . sec . "`n元の文字列  " . sentence)
		return "error"
	}

	dateTime = %hour%%min%%sec%
	return dateTime
}

; 漢数字や全角文字から、 1h  1m  1s といった文字に変換して返す。
; 時間  分  秒  の単語から、時間を解析する。
; 元々、1h  1m  1s といった文字なら、そのまま返す。
; 数字のみの場合も、そのまま返す。
; エラーがあった場合、error の文字を返す
F_getHMSSentenceFromKanji(sentence="三分三十秒", errorNotViewFlag=False){

	errorViewFlag := True
	if( errorNotViewFlag ){
		errorViewFlag := False
	}

	sentence := Trim(sentence)

	; 数字だけの場合も、エラーを返す
	If sentence is integer
	{
		return "error"
	}

	; 23:59:59 などの書式なら、23h 59m 59s の文字列にして返す
	tmpSentence := outs_getHMSSentenceColon(sentence)
	; 1h 1m 1s などの文字なら、そのまま返す
	allSec := linu_confirmTimerArgss(tmpSentence)
	if(allSec != "error"){
		return tmpSentence
	}

	; sentence はとっておくので、別の変数を用意してそちらを使う
	timeWord := sentence
	; 全角スペースを半角スペースに
	timeWord := func_stringReplace(timeWord, "　", A_Space, True)

	anyFlag := False
	hour =
	min =
	sec =
	target := "時間"
	; 「時間」の文字で確認するところだが、とりあえず「時」の文字で通す
	IfInString, timeWord, 時
	{
		; 時 だけで、時間 の文字がなければエラーにする
		IfNotInString, timeWord, %target%
		{
			guit_errorAppendViewFlag(errorViewFlag, "F_getHMSSentenceFromKanji() の関数のエラー。`n「時間」ではなく「時」の文字だけで指定している。`n元の文字列  " . sentence)
			return "error"
		}

		StringGetPos, index, timeWord, %target%
		StringLeft, leftStr, timeWord, %index%
		leftStr := Trim(leftStr)
		; 時間 の左側の文字に空白があったら、その右端のみを参考にする
		IfInString, leftStr, %A_Space%
		{
			StringGetPos, index2, leftStr, %A_Space%, R1
			StringTrimLeft, rightStr, leftStr, %index2%
			leftStr := LTrim( rightStr )
		}
		if(leftStr == ""){
			guit_errorAppendViewFlag(errorViewFlag, "F_getHMSSentenceFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n指定がカラ。`n元の文字列  " . sentence)
			return "error"
		}
		hour := outs_kanjiAndFullNumeralReplaceInteger(leftStr, sentence, errorViewFlag)
		if(hour == "error"){
			guit_errorAppendViewFlag(errorViewFlag, "F_getHMSSentenceFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n元の文字列  " . sentence)
			return "error"
		}
		hour := Trim(hour)
		If hour is not number
		{
			guit_errorAppendViewFlag(errorViewFlag, "F_getHMSSentenceFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n時間が数字ではない。`n時間  " . hour . "`n元の文字列  " . sentence)
			return "error"
		}

		; 時間 の文字の右のみを timeWord に変える
		StringGetPos, index, timeWord, %target%
		indexPlus := index + 2
		StringTrimLeft, timeWord, timeWord, %indexPlus%
		hour := hour . "h "

		; 半 の文字は ３０分 扱い
		StringLeft, lChr, timeWord, 1
		if( lChr == "半" ){
			min := "30m "
			; 半 の文字の右のみを timeWord に変える
			StringTrimLeft, timeWord, timeWord, 1
		}
		anyFlag := True
	}

	target := "分"
	IfInString, timeWord, %target%
	{
		StringGetPos, index, timeWord, %target%
		StringLeft, leftStr, timeWord, %index%
		leftStr := Trim(leftStr)
		; 分 の左側の文字に空白があったら、その右端のみを参考にする
		IfInString, leftStr, %A_Space%
		{
			StringGetPos, index2, leftStr, %A_Space%, R1
			StringTrimLeft, rightStr, leftStr, %index2%
			leftStr := LTrim( rightStr )
		}
		if(leftStr == ""){
			guit_errorAppendViewFlag(errorViewFlag, "F_getHMSSentenceFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n指定がカラ。`n元の文字列  " . sentence)
			return "error"
		}
		min := outs_kanjiAndFullNumeralReplaceInteger(leftStr, sentence, errorViewFlag)
		if(min == "error"){
			guit_errorAppendViewFlag(errorViewFlag, "F_getHMSSentenceFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n元の文字列  " . sentence)
			return "error"
		}
		min := Trim(min)
		If min is not number
		{
			guit_errorAppendViewFlag(errorViewFlag, "F_getHMSSentenceFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n分が数字ではない。`n分  " . min . "`n元の文字列  " . sentence)
			return "error"
		}

		; 分 の文字の右のみを timeWord に変える
		StringGetPos, index, timeWord, %target%
		indexPlus := index + 1
		StringTrimLeft, timeWord, timeWord, %indexPlus%
		min := min . "m "

		; 半 の文字は ３０秒 扱い
		StringLeft, lChr, timeWord, 1
		if( lChr == "半" ){
			sec := "30s "
			; 半 の文字の右のみを timeWord に変える
			StringTrimLeft, timeWord, timeWord, 1
		}
		anyFlag := True
	}


	target := "秒"
	IfInString, timeWord, %target%
	{
		StringGetPos, index, timeWord, %target%
		StringLeft, leftStr, timeWord, %index%
		leftStr := Trim(leftStr)
		; 秒 の左側の文字に空白があったら、その右端のみを参考にする
		IfInString, leftStr, %A_Space%
		{
			StringGetPos, index2, leftStr, %A_Space%, R1
			StringTrimLeft, rightStr, leftStr, %index2%
			leftStr := LTrim( rightStr )
		}
		if(leftStr == ""){
			guit_errorAppendViewFlag(errorViewFlag, "F_getHMSSentenceFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n指定がカラ。`n元の文字列  " . sentence)
			return "error"
		}
		sec := outs_kanjiAndFullNumeralReplaceInteger(leftStr, sentence, errorViewFlag)
		if(sec == "error"){
			guit_errorAppendViewFlag(errorViewFlag, "F_getHMSSentenceFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n元の文字列  " . sentence)
			return "error"
		}
		sec := Trim(sec)
		If sec is not number
		{
			guit_errorAppendViewFlag(errorViewFlag, "F_getHMSSentenceFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n秒が数字ではない。`n秒  " . sec . "`n元の文字列  " . sentence)
			return "error"
		}
		sec := sec . "s"

		anyFlag := True
	}

	if( anyFlag == False ){
		guit_errorAppendViewFlag(errorViewFlag, "F_getHMSSentenceFromKanji() の関数のエラー。`n時間の指定がされていない。`n文字列  " . sentence)
		return "error"
	}

	returnValue := hour . min . sec
	returnValue := Trim(returnValue)
	return returnValue
}

F_lastWordSetOneLineStr(firstNum, secondNum, oneLineStr, blankComment="#", passComment="[", keyTrimBefore="<", keyTrimAfter=">"){
	if( oneLineStr == "" ){
		; カラの行はとばす
		return
	}
	StringLeft, lChr, oneLineStr, 1
	if( lChr == blankComment ){
		O_lastWordKey%firstNum%_%secondNum%    =
		O_lastWordScript%firstNum%_%secondNum% =
		return
	}
	if( lChr == passComment ){
		return
	}

	leftStr := func_leftStrOrNullFromSearchStrTurnAssign(oneLineStr, "=", 1)
	rightStr := func_rightStrOrNullFromSearchStr(oneLineStr, "=")
	StringLeft, lChr, leftStr, 1
	if( lChr == keyTrimBefore ){
		StringTrimLeft, leftStr, leftStr, 1
	}
	StringRight, rChr, leftStr, 1
	if( rChr == keyTrimAfter ){
		StringTrimRight, leftStr, leftStr, 1
	}
	O_lastWordKey%firstNum%_%secondNum%    := leftStr
	O_lastWordScript%firstNum%_%secondNum% = %rightStr%
}

F_lastWordSetOneFromAllLineStr(firstNum, secondNum, allLineStr, blankComment="#", passComment="[", keyTrimBefore="<", keyTrimAfter=">"){
	oneLineStr := func_leftStrOrAllFromSearchStr(allLineStr, "`n")
	rightStr := func_rightStrOrNullFromSearchStr(allLineStr, "`n")
	oneLineStr := Trim( oneLineStr, "`r`n" )
	oneLineStr := Trim( oneLineStr )
	rightStr := Trim( rightStr, "`r`n" )
	rightStr := Trim( rightStr )
	F_lastWordSetOneLineStr(firstNum, secondNum, oneLineStr, blankComment, passComment, keyTrimBefore, keyTrimAfter)
	return rightStr
}

F_lastWordSetFirstNumAllFromAllLineStr(firstNum, allLineStr, blankComment="#", passComment="[", keyTrimBefore="<", keyTrimAfter=">"){
	O_lastWordTabAllFlag%firstNum% := True
	if( allLineStr == "" ){
		return ""
	}

	Loop, 10
	{
		allLineStr := F_lastWordSetOneFromAllLineStr(firstNum, A_Index, allLineStr, blankComment, passComment, keyTrimBefore, keyTrimAfter)
		if( allLineStr == "" ){
			return ""
		}
	}
	return allLineStr
}
