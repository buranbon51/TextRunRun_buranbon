; 必須 glob  guf  func
; timf




; 	Gui を自動で閉じるようにする
guit_showGuiEnyAutoClose(sec, timerWord, subLutinName, GuiNum, pOrder="_"){
	guf_showGuiAssign(GuiNum, pOrder)
	if(sec == 0){
		return
	}
	; SetTimer を重複して動作させないように、timer用の変数の値が 0 の時だけ SetTimer を使う
	timerValue_local := %timerWord%
	begin_local := False
	if( timerValue_local == 0 ){
		begin_local := True
	}
	dateTime = %A_Now%
	EnvAdd, dateTime, %sec% , Seconds
	%timerWord% = %dateTime%
	if( begin_local ){
		SetTimer, %subLutinName%, 1000
	}
}

guit_appendBoxEditEnyGui(append, pBoxEditName, GuiNum, hwndBoxEdit, sec, timerName, subLutinWord, pOrder="") {
	guf_appendBoxEditBasisPlan(append, pBoxEditName, GuiNum)
	guit_showGuiEnyAutoClose(sec, timerName, subLutinWord, GuiNum, pOrder)
	DetectHiddenWindows, On
	ControlSend , , ^{End}, ahk_id  %hwndBoxEdit%
	DetectHiddenWindows, Off
}

/*
guit_appendBoxEdit66_1(append) {
	pBoxEditName	:= "BoxEdit66_1"
	GuiNum			:= 66
	hwndBoxEdit		:= gGlob_hwndBoxEdit66_1
	sec				:= gGlob_Gui66Close_sec
	timerName		:= "gGlob_timerGui66"
	subLutinWord	:= "SubGui66Close"
	pOrder			:= "NA"
	guit_appendBoxEditEnyGui(append, pBoxEditName, GuiNum, hwndBoxEdit, sec, timerName, subLutinWord, pOrder)
}
*/

guit_appendBoxEdit66_1(append) {
	GuiControlGet, BoxEdit66_1, 66:
	after := BoxEdit66_1 . append  . "`n"
	GuiControl,66: , BoxEdit66_1, %after%

	if( glob_iniOutputNotViewFlag == False ){
		guit_showGuiEnyAutoClose(glob_iniOutput_sec, "gGlob_timerGui66", "SubGui66Close", 66, "NA")
	}

	DetectHiddenWindows, On
	ControlSend , , ^{End}, ahk_id  %gGlob_hwndBoxEdit66_1%
	DetectHiddenWindows, Off
;	GuiControlGet, OutputVar , 66:Visible, BoxEdit66_1
;	if(OutputVar != 1){
;		guit_showGuiEnyAutoClose(glob_iniOutput_sec, "gGlob_timerGui66", "SubGui66Close", 66, "NA")
;	}
}

guit_appendBoxEdit66_1Cust(append="", str2="@", str3="@", str4="@") {
	GuiControlGet, BoxEdit66_1, 66:
	if(append == "@") {
		;GuiControl,66: , BoxEdit66_1, %BoxEdit66_1%
	} else if (str2 == "@") {
		GuiControl,66: , BoxEdit66_1, %BoxEdit66_1%%append%`n
	} else if (str3 == "@") {
		GuiControl,66: , BoxEdit66_1, %BoxEdit66_1%%append%`n%str2%`n
	} else if (str4 == "@") {
		GuiControl,66: , BoxEdit66_1, %BoxEdit66_1%%append%`n%str2%`n%str3%`n
	} else {
		GuiControl,66: , BoxEdit66_1, %BoxEdit66_1%%append%`n%str2%`n%str3%`n%str4%`n
	}

	if( glob_iniOutputNotViewFlag == False ){
		guit_showGuiEnyAutoClose(glob_iniOutput_sec, "gGlob_timerGui66", "SubGui66Close", 66, "NA")
	}

	DetectHiddenWindows, On
	ControlSend , , ^{End}, ahk_id  %gGlob_hwndBoxEdit66_1%
	DetectHiddenWindows, Off
;	GuiControlGet, OutputVar , 66:Visible, BoxEdit66_1
;	if(OutputVar != 1){
;		guit_showGuiEnyAutoClose(glob_iniOutput_sec, "gGlob_timerGui66", "SubGui66Close", 66, "NA")
;	}
}

;  追加するのではなく、単独表示
guit_setBoxEdit66_1CustSingle(before, after="@", str3="@", str4="@", str5="@") {
	if(after == "@") {
		GuiControl,66: , BoxEdit66_1, %before%`n
	} else if (str3 == "@") {
		GuiControl,66: , BoxEdit66_1, %before%`n%after%`n
	} else if (str4 == "@") {
		GuiControl,66: , BoxEdit66_1, %before%`n%after%`n%str3%`n
	} else if (str5 == "@") {
		GuiControl,66: , BoxEdit66_1, %before%`n%after%`n%str3%`n%str4%`n
	} else {
		GuiControl,66: , BoxEdit66_1, %before%`n%after%`n%str3%`n%str4%`n%str5%`n
	}

	if( glob_iniOutputNotViewFlag == False ){
		guit_showGuiEnyAutoClose(glob_iniOutput_sec, "gGlob_timerGui66", "SubGui66Close", 66, "NA")
	}

	DetectHiddenWindows, On
	ControlSend , , ^{End}, ahk_id  %gGlob_hwndBoxEdit66_1%
	DetectHiddenWindows, Off
;	GuiControlGet, OutputVar , 66:Visible, BoxEdit66_1
;	if(OutputVar != 1){
;		guit_showGuiEnyAutoClose(glob_iniOutput_sec, "gGlob_timerGui66", "SubGui66Close", 66, "NA")
;	}
}

guit_appendBoxEdit66_1NotShow(append){
	GuiControlGet, BoxEdit66_1, 66:
	after := BoxEdit66_1 . append . "`n"
	GuiControl,66: , BoxEdit66_1, %after%
	DetectHiddenWindows, On
	ControlSend , , ^{End}, ahk_id  %gGlob_hwndBoxEdit66_1%
	DetectHiddenWindows, Off
	;Gui, 66:Hide
}

guit_appendBoxEdit66_1CustNotShow(append, str2="@", str3="@", str4="@") {
	GuiControlGet, BoxEdit66_1, 66:
	if(append == "@") {
		;GuiControl,66: , BoxEdit66_1, %BoxEdit66_1%
	} else if (str2 == "@") {
		GuiControl,66: , BoxEdit66_1, %BoxEdit66_1%%append%`n
	} else if (str3 == "@") {
		GuiControl,66: , BoxEdit66_1, %BoxEdit66_1%%append%`n%str2%`n
	} else if (str4 == "@") {
		GuiControl,66: , BoxEdit66_1, %BoxEdit66_1%%append%`n%str2%`n%str3%`n
	} else {
		GuiControl,66: , BoxEdit66_1, %BoxEdit66_1%%append%`n%str2%`n%str3%`n%str4%`n
	}
	DetectHiddenWindows, On
	ControlSend , , ^{End}, ahk_id  %gGlob_hwndBoxEdit66_1%
	DetectHiddenWindows, Off
	;Gui, 66:Hide
}

guit_appendBoxEdit68_1(append) {
	GuiControlGet, BoxEdit68_1, 68:
	after := BoxEdit68_1  . append  . "`n"
	GuiControl,68: , BoxEdit68_1, %after%
	if( glob_iniTmpOutputNotViewFlag == False ){
		guit_showGuiEnyAutoClose(glob_iniTmpOutput_sec, "gGlob_timerGui68", "SubGui68Close", 68, "NA")
	}
	ControlSend , , ^{End}, ahk_id  %gGlob_hwndBoxEdit68_1%
}



; 追加するのではなく単独表示
guit_setBoxEdit68_1CustSingle(before, after="@", str3="@", str4="@", str5="@") {
	if(after == "@") {
		GuiControl,68: , BoxEdit68_1, %before%`n
	} else if (str3 == "@") {
		GuiControl,68: , BoxEdit68_1, %before%`n%after%`n
	} else if (str4 == "@") {
		GuiControl,68: , BoxEdit68_1, %before%`n%after%`n%str3%`n
	} else if (str5 == "@") {
		GuiControl,68: , BoxEdit68_1, %before%`n%after%`n%str3%`n%str4%`n
	} else {
		GuiControl,68: , BoxEdit68_1, %before%`n%after%`n%str3%`n%str4%`n%str5%`n
	}
	if( glob_iniTmpOutputNotViewFlag ){
		return
	}
	guit_showGuiEnyAutoClose(glob_iniTmpOutput_sec, "gGlob_timerGui68", "SubGui68Close", 68, "NA")
	;ControlSend , , ^{End}, ahk_id  %gGlob_hwndBoxEdit68_1%
}

; ファイルを読み込むＧＵＩ用
guit_appendBoxEdit69_1(append) {
	guf_appendBoxEditBasisPlan(append, "BoxEdit69_1", 69)
	guf_showGuiAssign(69, "NA")
	;DetectHiddenWindows, On
	ControlSend , , ^{End}, ahk_id %gGlob_hwndBoxEdit69_1%
	;DetectHiddenWindows, Off
}

; エラー表示用
guit_appendBoxEdit67_1(append) {
	GuiControlGet, BoxEdit67_1, 67:
	after := BoxEdit67_1 . append  . "`n"
	GuiControl,67: , BoxEdit67_1, %after%

	if( glob_iniErrorNotViewFlag == False ){
		guit_showGuiEnyAutoClose(glob_iniError_sec, "gGlob_timerGui67", "SubGui67Close", 67, "NA")
	}

	DetectHiddenWindows, On
	ControlSend , , ^{End}, ahk_id  %gGlob_hwndBoxEdit67_1%
	DetectHiddenWindows, Off
}

guit_errorAppendWithoutTime(append) {
	if( guit_errOutputFromOutChangeNum(append) ){
		return
	}

	guit_appendBoxEdit67_1(append)
}

guit_appendBoxEdit67_1Cust(append="", str2="@", str3="@", str4="@") {

	GuiControlGet, BoxEdit67_1, 67:
	if(append == "@") {
		;GuiControl,67: , BoxEdit67_1, %BoxEdit67_1%
	} else if (str2 == "@") {
		GuiControl,67: , BoxEdit67_1, %BoxEdit67_1%%append%`n
	} else if (str3 == "@") {
		GuiControl,67: , BoxEdit67_1, %BoxEdit67_1%%append%`n%str2%`n
	} else if (str4 == "@") {
		GuiControl,67: , BoxEdit67_1, %BoxEdit67_1%%append%`n%str2%`n%str3%`n
	} else {
		GuiControl,67: , BoxEdit67_1, %BoxEdit67_1%%append%`n%str2%`n%str3%`n%str4%`n
	}
	if( glob_iniErrorNotViewFlag == False ){
		guit_showGuiEnyAutoClose(glob_iniError_sec, "gGlob_timerGui67", "SubGui67Close", 67, "NA")
	}
	DetectHiddenWindows, On
	ControlSend , , ^{End}, ahk_id  %gGlob_hwndBoxEdit67_1%
	DetectHiddenWindows, Off
}

;  追加するのではなく、単独表示
guit_appendBoxEdit67_1CustSingle(before, after="@", str3="@", str4="@", str5="@") {
	if(after == "@") {
		GuiControl,67: , BoxEdit67_1, %before%`n
	} else if (str3 == "@") {
		GuiControl,67: , BoxEdit67_1, %before%`n%after%`n
	} else if (str4 == "@") {
		GuiControl,67: , BoxEdit67_1, %before%`n%after%`n%str3%`n
	} else if (str5 == "@") {
		GuiControl,67: , BoxEdit67_1, %before%`n%after%`n%str3%`n%str4%`n
	} else {
		GuiControl,67: , BoxEdit67_1, %before%`n%after%`n%str3%`n%str4%`n%str5%`n
	}

	if( glob_iniErrorNotViewFlag == False ){
		guit_showGuiEnyAutoClose(glob_iniError_sec, "gGlob_timerGui67", "SubGui67Close", 67, "NA")
	}

	DetectHiddenWindows, On
	ControlSend , , ^{End}, ahk_id  %gGlob_hwndBoxEdit67_1%
	DetectHiddenWindows, Off
}

guit_errorAppend(append="", str2="@", str3="@", str4="@") {
	if( guit_errOutputFromOutChangeNum(append, str2, str3, str4) ){
		return
	}

	time := func_getHourMinSec()
	guit_appendBoxEdit67_1Cust(time  . "`n" . append, str2, str3, str4)
}

guit_errorAppendViewFlag(viewFlag, append){
	if( viewFlag ){
		guit_errorAppend(append)
	}
}

; 二行以上のスクリプトならエラーを出力するが、そうでないなら一時的な説明に表示するだけ
guit_errorAppendOrSetExplain(str, GuiNum){
	typeNum := guit_editTypeNumGet(GuiNum)
	if(typeNum == 3){
		guit_errorAppend(str)
		return
	} 
	guit_setExplain(str, GuiNum)
}

;  エラーレベルがあるならFalseを  なければTrueに
guit_checkErrorLevelOutput(append="", str2="@", str3="@", str4="@") {
	if(ErrorLevel >= 1){
		ErrorLevel_TextRunRun = %ErrorLevel%
		guit_errorAppend( "ErrorLevel   " . ErrorLevel  . "`n" . append , str2, str3, str4)
		return False
	}
	return True
}

; エラーレベルが5以上の数値なら放置する  エラーレベルがあるならFalseを  なければTrueに
guit_checkErrorLevelOutput_Cust(append="", str2="@", str3="@", str4="@") {
	if(ErrorLevel == "ERROR"){
		guit_errorAppend( "ErrorLevel   " . ErrorLevel  . "`n" . append , str2, str3, str4)
		return False
	}
	if(ErrorLevel >= 1  && ErrorLevel < 5){
		ErrorLevel_TextRunRun = %ErrorLevel%
		guit_errorAppend( "ErrorLevel   " . ErrorLevel  . "`n" . append , str2, str3, str4)
		return False
	}
	return True
}

; 起動時でのみ使用。DetectHiddenWindows, On　を避けるため、こちらを使う
guit_checkErrorLevelOutput_StartUp(append="") {
	if(ErrorLevel == "ERROR"){
		guit_errorLevelOutput_StartUp(append)
		return False
	}
	if(ErrorLevel >= 1  && ErrorLevel < 5){
		guit_errorLevelOutput_StartUp(append)
		return False
	}
	return True
}

guit_errorLevelOutput_StartUp(append=""){
	pBoxEditName	:= "BoxEdit67_1"
	GuiNum			:= 67
	hwndBoxEdit		:= gGlob_hwndBoxEdit67_1
	pOrder			:= "NA"
	append := "ErrorLevel   " . ErrorLevel  . "`n" . append
	GuiControlGet, %pBoxEditName%, %GuiNum%:
	after := %pBoxEditName% . append  . "`n"
	GuiControl,%GuiNum%: , %pBoxEditName%, %after%
	guf_showGuiAssign(GuiNum, pOrder)
	ControlSend , , ^{End}, ahk_id  %hwndBoxEdit%
}

; 説明を一時的に表示する用
guit_setExplain(str, GuiNum){
	if( guit_outputFromOutChangeNum(str) ){
		return
	}

	typeNum := guit_editTypeNumGet(GuiNum)
	if(typeNum == 1){
		BoxEdit1 := "BoxEdit" . GuiNum  . "_1"
		guf_setControl( str, BoxEdit1, GuiNum )
	} else if(typeNum == 3){
		; 表示せず、影で出力する
		;if( glob_iniMultipleExplainNotFlag == False ){
		if( O_tmpOutputMultipleTextFlag ){
			guf_setControl( str, "BoxEdit68_1", 68 )
		}
	} else if(typeNum == 4){
		; 表示せず、影で出力する
		guf_setControl( str, "BoxEdit68_1", 68 )
	} else if(typeNum == 2){
		guit_setBoxEdit68_1CustSingle(str)
	} else {
		guit_setBoxEdit68_1CustSingle(str)
	}
}

; 「結果を表示しない」の設定にかかわらず、表示させる用
guit_setExplainPurpose(str, GuiNum){
	if( guit_outputFromOutChangeNum(str) ){
		return
	}

	typeNum := guit_editTypeNumGet(GuiNum)
	if(typeNum == 1){
		BoxEdit1 := "BoxEdit" . GuiNum  . "_1"
		guf_setControl( str, BoxEdit1, GuiNum )
	} else if(typeNum == 3){
		;「結果を表示しない」の設定にかかわらず、影で出力する
		guf_setControl( str, "BoxEdit68_1", 68 )
	} else if(typeNum == 4){
		; 影で出力する
		guf_setControl( str, "BoxEdit68_1", 68 )
	} else if(typeNum == 2){
		guit_setBoxEdit68_1CustSingle(str)
	} else {
		guit_setBoxEdit68_1CustSingle(str)
	}
}

; コマンドを介さない場合の説明表示用
guit_setExplainOtherThanCommand(str){
	guit_setExplain(str, 63)
}

; 説明を表示しないが、影で書き込む場合
guit_setExplainNotShow(str, GuiNum){
	if( guit_outputFromOutChangeNum(str) ){
		return
	}

	typeNum := guit_editTypeNumGet(GuiNum)
	if(typeNum == 1){
		BoxEdit1 := "BoxEdit" . GuiNum  . "_1"
		guf_setControl( str, BoxEdit1, GuiNum )
	} else if(typeNum == 3){
		;if( glob_iniMultipleExplainNotFlag == False ){
		if( O_tmpOutputMultipleTextFlag ){
			guf_setControl( str, "BoxEdit68_1", 68 )
		}
	} else if(typeNum == 2){
		guf_setControl( str, "BoxEdit68_1", 68 )
	} else {
		guf_setControl( str, "BoxEdit68_1", 68 )
	}
}

guit_setExplainOtherThanCommandNotShow(str){
	guit_setExplainNotShow(str, 63)
}

; 説明を蓄える場合に使う。時間を表示しない
guit_appendExplainWithoutTime(append){
	if( guit_outputFromOutChangeNum(append) ){
		return
	}

	guit_appendBoxEdit66_1(append)
}

; 説明を蓄える場合に使う
guit_appendExplain(append="", str2="@", str3="@", str4="@"){
	if( guit_outputFromOutChangeNum(append, str2, str3, str4) ){
		return
	}

	time := func_getHourMinSec()
	guit_appendBoxEdit66_1Cust(time  . "`n" . append, str2, str3, str4)
}

guit_appendExplainNotShow(append="", str2="@", str3="@", str4="@"){
	if( guit_outputFromOutChangeNum(append, str2, str3, str4) ){
		return
	}

	time := func_getHourMinSec()
	guit_appendBoxEdit66_1CustNotShow(time  . "`n" . append, str2, str3, str4)
}

; ツールチップで表示用
guit_setExplainToolTip(str){
	if( guit_outputFromOutChangeNum(str) ){
		return
	}

	timf_toolTipFuncOptionPos(str)
}

guit_getExplain(GuiNum){
	returnValue =
	typeNum := guit_editTypeNumGet(GuiNum)
	if(typeNum == 1){
		BoxEdit1 := "BoxEdit" . GuiNum  . "_1"
		returnValue := guf_getControl( BoxEdit1, GuiNum )
	} else if(typeNum == 2){
		returnValue := guf_getControl( "BoxEdit68_1", 68 )
	} else {
		returnValue := guf_getControl( "BoxEdit68_1", 68 )
	}
	return  returnValue
}

; Gui61 や Gui62 なら 1 、Gui82 なら 3 、Gui71 なら 4、それ以外なら 2
guit_editTypeNumGet(GuiNum){
	num = 0
	if(GuiNum == 61){
		num = 1
	} else if(GuiNum == 62){
		num = 1
	} else if(GuiNum == 82){
		num = 3
	} else if(GuiNum == 71){
		num = 4
	} else if(GuiNum == 72){
		num = 5
	} else if(GuiNum == 63){
		num = 2
	} else if(GuiNum == 64){
		num = 2
	} else if(GuiNum == 65){
		num = 2
	}
	return num
}

guit_setEditBoxssAct(Edit1="__", Edit2="__", Edit3="__", Edit4="__", GuiNum=1){
	pOut1 := "Edit" . GuiNum  . "_1"
	pOut2 := "Edit" . GuiNum  . "_2"
	pOut3 := "Edit" . GuiNum  . "_3"
	pOut4 := "Edit" . GuiNum  . "_4"

	; テキストのサイズが自動で変更するので、この順番にしている。
	if(Edit4 != "__"){
		guf_setControl( Edit4, pOut4, GuiNum )
	}
	if(Edit3 != "__"){
		guf_setControl( Edit3, pOut3, GuiNum )
	}
	if(Edit1 != "__"){
		guf_setControl( Edit1, pOut1, GuiNum )
	}
	if(Edit2 != "__"){
		guf_setControl( Edit2, pOut2, GuiNum )
	}
}

guit_appendArgssConsolidation(append="", str2="@", str3="@", str4="@"){
	if (append == "@") {
		append =
	} else if (str2 == "@") {

	} else if (str3 == "@") {
		append .= "`n" . str2
	} else if (str4 == "@") {
		append .= "`n" . str2 . "`n" . str3
	} else {
		append .= "`n" . str2 . "`n" . str3 . "`n" . str4
	}
	return append
}

guit_outputFromOutChangeNum(append="", str2="@", str3="@", str4="@"){
	if(glob_outputChangeNum == 0){
		return True
	} else if(glob_outputChangeNum == 3){
		append := guit_appendArgssConsolidation(append, str2, str3, str4)
		time := func_getHourMinSec()
		guit_appendBoxEdit66_1(time  . "`n" . append)
		return True
	} else if(glob_outputChangeNum == 4){
		append := guit_appendArgssConsolidation(append, str2, str3, str4)
		guit_setBoxEdit68_1CustSingle(append)
		return True
	} else if(glob_outputChangeNum == 5){
		append := guit_appendArgssConsolidation(append, str2, str3, str4)
		time := func_getHourMinSec()
		guit_appendBoxEdit67_1(time  . "`n" . append)
		return True
	} else if(glob_outputChangeNum == 6){
		append := guit_appendArgssConsolidation(append, str2, str3, str4)
		guit_appendBoxEdit69_1(append)
		return True
	} else if(glob_outputChangeNum == 7){
		append := guit_appendArgssConsolidation(append, str2, str3, str4)
		file := gloco_userDir . glob_outputTmpFileName

		; 現時点では上書きはしない
		;if( func_myFileExist(file) ){
		;	FileDelete, %file%
		;}

		;day := func_getYearMonthDayHourMinSec()
		;append := day  . "`n" . append
		FileAppend , %append%`n, %file%
		if(ErrorLevel >= 1){
			time := func_getHourMinSec()
			guit_appendBoxEdit67_1(time . "`nErrorLevel   " . ErrorLevel  . "`n" . glob_outputChangeFile . "`nへのファイルへの書き込みに失敗している")
		}
		return True
	} else if(glob_outputChangeNum == 8){
		append := guit_appendArgssConsolidation(append, str2, str3, str4)
		FileAppend , %append%`n, *
		if(ErrorLevel >= 1){
			time := func_getHourMinSec()
			guit_appendBoxEdit67_1(time . "`nErrorLevel   " . ErrorLevel  . "`n標準出力への書き込みに失敗している")
		}
		return True
	} else if(glob_outputChangeNum == 2){
		append := guit_appendArgssConsolidation(append, str2, str3, str4)
		;day := func_getYearMonthDayHourMinSec()
		;append := day  . "`n" . append
		FileAppend , %append%`n, %glob_outputChangeFile%
		if(ErrorLevel >= 1){
			time := func_getHourMinSec()
			guit_appendBoxEdit67_1(time . "`nErrorLevel   " . ErrorLevel  . "`n" . glob_outputChangeFile . "`nへのファイルへの書き込みに失敗している")
		}
		return True
	}
	return False
}


guit_errOutputFromOutChangeNum(append="", str2="@", str3="@", str4="@"){
	if(glob_errorOutputChangeNum == 0){
		return True
	} else if(glob_errorOutputChangeNum == 3){
		append := guit_appendArgssConsolidation(append, str2, str3, str4)
		time := func_getHourMinSec()
		guit_appendBoxEdit66_1(time  . "`n" . append)
		return True
	} else if(glob_errorOutputChangeNum == 4){
		append := guit_appendArgssConsolidation(append, str2, str3, str4)
		guit_setBoxEdit68_1CustSingle(append)
		return True
	} else if(glob_errorOutputChangeNum == 5){
		append := guit_appendArgssConsolidation(append, str2, str3, str4)
		time := func_getHourMinSec()
		guit_appendBoxEdit67_1(time  . "`n" . append)
		return True
	} else if(glob_errorOutputChangeNum == 6){
		append := guit_appendArgssConsolidation(append, str2, str3, str4)
		guit_appendBoxEdit69_1(append)
		return True
	} else if(glob_errorOutputChangeNum == 7){
		append := guit_appendArgssConsolidation(append, str2, str3, str4)
		file := gloco_userDir . glob_outputTmpFileName

		; 現時点では上書きしない
		;if( func_myFileExist(file) ){
		;	FileDelete, %file%
		;}

		;day := func_getYearMonthDayHourMinSec()
		;append := day  . "`n" . append
		FileAppend , %append%`n, %file%
		if(ErrorLevel >= 1){
			time := func_getHourMinSec()
			guit_appendBoxEdit67_1(time . "`nErrorLevel   " . ErrorLevel  . "`n" . glob_outputChangeFile . "`nへのファイルへの書き込みに失敗している")
		}
		return True
	} else if(glob_errorOutputChangeNum == 8){
		append := guit_appendArgssConsolidation(append, str2, str3, str4)
		FileAppend , %append%`n, *
		if(ErrorLevel >= 1){
			time := func_getHourMinSec()
			guit_appendBoxEdit67_1(time . "`nErrorLevel   " . ErrorLevel  . "`n標準出力への書き込みに失敗している")
		}
		return True
	} else if(glob_errorOutputChangeNum == 2){
		append := guit_appendArgssConsolidation(append, str2, str3, str4)
		;day := func_getYearMonthDayHourMinSec()
		;append := day  . "`n" . append
		FileAppend , %append%`n, %glob_outputChangeFile%
		if(ErrorLevel >= 1){
			time := func_getHourMinSec()
			guit_appendBoxEdit67_1(time . "`nErrorLevel   " . ErrorLevel  . "`n" . glob_outputChangeFile . "`nへのファイルへの書き込みに失敗している")
		}
		return True
	}
	return False
}

guit_outPutDifferentiate(str){
	StringLower, strLower, str
	if(strLower == "null" || strLower == "no" ||  strLower == "d_none"){
		glob_outputChangeNum = 0
	} else if(strLower == "d_outputgui"){
		glob_outputChangeNum = 3
	} else if(strLower == "d_tmpoutputgui"){
		glob_outputChangeNum = 4
	} else if(strLower == "d_errorgui"){
		glob_outputChangeNum = 5
	} else if(strLower == "d_readfilegui"){
		glob_outputChangeNum = 6
	} else if(strLower == "d_tmpoutputfile"){
		glob_outputChangeNum = 7
	} else if(strLower == "*" || strLower == "comspec" ||  strLower == "d_systemout"){
		glob_outputChangeNum = 8
	} else {
		str := outs_textOutDqAllTrim(str)
		if( func_isFolder(str) ){
			guit_errorAppend(str . "`nはフォルダなので書き込めない")
		} else {
			if( outs_similarTxtFile(str) ){
				glob_outputChangeNum = 2
				glob_outputChangeFile := str
			} else {
				guit_errorAppend(str . "`nこのファイルは拡張子の問題で出力に使えないようにしている")
			}
		}
	}
}

guit_outPutDifferentiatePlusError(str){
	StringLower, strLower, str
	if(strLower == "null" || strLower == "no" ||  strLower == "d_none"){
		glob_outputChangeNum = 0
		glob_errorOutputChangeNum = 0
	} else if(strLower == "d_outputgui"){
		glob_outputChangeNum = 3
		glob_errorOutputChangeNum = 3
	} else if(strLower == "d_tmpoutputgui"){
		glob_outputChangeNum = 4
		glob_errorOutputChangeNum = 4
	} else if(strLower == "d_errorgui"){
		glob_outputChangeNum = 5
		glob_errorOutputChangeNum = 5
	} else if(strLower == "d_readfilegui"){
		glob_outputChangeNum = 6
		glob_errorOutputChangeNum = 6
	} else if(strLower == "d_tmpoutputfile"){
		glob_outputChangeNum = 7
		glob_errorOutputChangeNum = 7
	} else if(strLower == "*" || strLower == "comspec" ||  strLower == "d_systemout"){
		glob_outputChangeNum = 8
		glob_errorOutputChangeNum = 8
	} else {
		str := outs_textOutDqAllTrim(str)
		if( func_isFolder(str) ){
			guit_errorAppend(str . "`nはフォルダなので書き込めない")
		} else {
			if( outs_similarTxtFile(str) ){
				glob_outputChangeNum = 2
				glob_errorOutputChangeNum = 2
				glob_outputChangeFile := str
			} else {
				guit_errorAppend(str . "`nこのファイルは拡張子の問題で出力に使えないようにしている")
			}
		}
	}
}

guit_abstractOutputWord(argStr, searchStr, plus){
	argStr := func_leftStrOrAllFromSearchStr(argStr, "&&& ")
	StringGetPos, index, argStr, %searchStr%
	index += plus
	StringTrimLeft, rightStr, argStr, %index%
	rightStr := Trim(rightStr)
	return rightStr
}

; 不完全なので使わない
; " " で囲まれてるファイルを一度変換してから確認する
/*
guit_ifNotInStringComplexity(argStr, searchStr, lineFile, lineNumber){
	tmpArgStr := heard_dbQuouteReplace(argStr, False)
	guit_dbQuouteTmpValueInitial()
	IfNotInString, tmpArgStr, %searchStr%
	{
		return True
	}
	return False
}
*/

; outputの一時的な変更。>>> などがあるなら それの左の文字を返す
guit_outPutControl(argStr, outPutSucceedFlag){
	; outputの設定を引き継ぐなら変更しない
	if( outPutSucceedFlag ){
		return argStr
	}

	; 引数から、この関数を呼び出した場合、
	; 一つめの引数が >>> だった場合があるので、argStr に一時的に 半角スペース を左に入れる
	argStr2 := " " . argStr

	searchStr := " >>> "
	IfInString, argStr2, %searchStr%
	{
		;tmpStr := func_leftStrOrAllFromSearchStr(argStr2, "&&& ")
		rightStr := func_rightStrOrNullFromSearchStr(argStr2, searchStr)
		if(rightStr == ""){
			return argStr
		}
		guit_outPutDifferentiate(rightStr)
		leftStr := func_leftStrOrAllFromSearchStr(argStr2, searchStr)
		return leftStr
	}
	searchStr := " 1>> "
	IfInString, argStr2, %searchStr%
	{
		;tmpStr := func_leftStrOrAllFromSearchStr(argStr2, "&&& ")
		rightStr := func_rightStrOrNullFromSearchStr(argStr2, searchStr)
		if(rightStr == ""){
			return argStr
		}
		guit_outPutDifferentiate(rightStr)
		leftStr := func_leftStrOrAllFromSearchStr(argStr2, searchStr)
		return leftStr
	}
	searchStr := " >>& "
	IfInString, argStr2, %searchStr%
	{
		;tmpStr := func_leftStrOrAllFromSearchStr(argStr2, "&&& ")
		rightStr := func_rightStrOrNullFromSearchStr(argStr2, searchStr)
		if(rightStr == ""){
			return argStr
		}
		guit_outPutDifferentiatePlusError(rightStr)
		leftStr := func_leftStrOrAllFromSearchStr(argStr2, searchStr)
		return leftStr
	}
	searchStr := " 2>> "
	IfInString, argStr2, %searchStr%
	{
		;tmpStr := func_leftStrOrAllFromSearchStr(argStr2, "&&& ")
		rightStr := func_rightStrOrNullFromSearchStr(argStr2, searchStr)
		if(rightStr == ""){
			return argStr
		}
		guit_outPutDifferentiatePlusError(rightStr)
		leftStr := func_leftStrOrAllFromSearchStr(argStr2, searchStr)
		return leftStr
	}
	return argStr
}

/*
guit_dbQuouteTmpValueInitial(){
	glob_backUp_dq_1 =
	glob_backUp_dq_2 =
	glob_backUp_dq_3 =
	glob_backUp_dq_4 =
	glob_backUp_dq_5 =
	glob_backUp_dq_6 =
	glob_backUp_dq_7 =
	glob_backUp_dq_8 =
	glob_backUp_dq_9 =
}
*/

; 不完全なので使わない
/*
guit_trimOutputWordComplexity(argStr, searchStr){
	tmpArgStr := heard_dbQuouteReplace(argStr, False)
	IfInString, tmpArgStr, %searchStr%
	{
		argStr := guit_outPutControlTrimOutputWordLogic(argStr, searchStr)
	}
	guit_dbQuouteTmpValueInitial()
	return argStr
}
*/

guit_guiShowWaitExecutor(rightStr, GuiNum){
	str := "実行元のテキストを遅れて表示させる。`n引数1  秒数（30 秒以内の指定しかできない。）`n0 なら直ぐに表示する。`n 1s の形でも指定可`n引数2以降  表示の仕方を指定（Gui, Show, Param2  のParam2と同じ指定方法）。`n引数なし  0.5 の指定と同じ"
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}
	if(rightStr == ""){
		rightStr = 0.5
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

	; 0 を指定しているなら、すぐ表示するだけ
	if(rightStr_left == 0){
		guf_showGuiAssign(A_Gui, rightStr_right)
		return
	}

	allSec = 0
	If rightStr_left is number
	{
		if(rightStr_left >= 31){
			guit_errorAppend("&guiShowWaitExecutorのエラー`n30秒数以内の指定しかできない`n引数  " . rightStr)
			return
		}
		allSec = %rightStr_left%
	} else {
		allSec := linu_confirmTimerArgss(rightStr_left)
		if(allSec == "error"){
			guit_errorAppend("&guiShowWaitExecutorのエラー`n引数の指定が認識できない。`n引数  " . rightStr)
			return
		} else {
			if( allSec >= 31 ){
				guit_errorAppend("&guiShowWaitExecutorのエラー`n30秒数以内の指定しかできない`n引数  " . rightStr)
				return
			}
		}
	}

	begin_local := False
	if( gGlob_timerShowWaitExecutor == 0 ){
		begin_local := True
	}
	dateTime = %A_Now%
	EnvAdd, dateTime, %allSec% , Seconds
	gGlob_timerShowWaitExecutor = %dateTime%
	gGlob_tmpGuiNumShowWaitExecutor = %A_Gui%
	gGlob_tmpOrderShowWaitExecutor = %rightStr_right%
	if( begin_local ){
		SetTimer, SubShowWaitExecutor , 300
	}
}

guit_guiHideAndShowWaitExecutor(rightStr, GuiNum){
	str := "実行元のテキストを一度閉じて、その後遅れて表示させる。`n引数1  秒数（30 秒以内の指定しかできない。）`n 1s の形でも指定可`n引数2以降  表示の仕方を指定（Gui, Show, Param2  のParam2と同じ指定方法）。`n引数なし  0.5 の指定と同じ"
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}
	edi_hideOrMinimizeGuiTextPattern(A_Gui, True, False, False)
	guit_guiShowWaitExecutor(rightStr, GuiNum)
	windc_anyWaitActive()
}
