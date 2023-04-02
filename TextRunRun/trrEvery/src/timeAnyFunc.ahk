; 必須 glob  guf  outs



timf_toolTipClose(sec){
	begin_local := False
	if( glob_timerToolTip == 0 ){
		begin_local := True
	}
	dateTime = %A_Now%
	EnvAdd, dateTime, %sec% , Seconds
	glob_timerToolTip =  %dateTime%
	if( begin_local ){
		SetTimer, SubToolTipClose , 1000
	}
}

timf_toolTipClose2(sec){
	begin_local := False
	if( glob_timerToolTip2 == 0 ){
		begin_local := True
	}
	dateTime = %A_Now%
	EnvAdd, dateTime, %sec% , Seconds
	glob_timerToolTip2 =  %dateTime%
	if( begin_local ){
	SetTimer, SubToolTipClose2 , 1000
	}
}

timf_Gui88Close(sec){
	begin_local := False
	if( gGlob_timerGui88 == 0 ){
		begin_local := True
	}
	dateTime = %A_Now%
	EnvAdd, dateTime, %sec% , Seconds
	gGlob_timerGui88 = %dateTime%
	if( begin_local ){
		SetTimer, SubGui88Close , 2000
	}
}

timf_toolTipFunc(text, X, Y, sec=3){
	timf_toolTipClose(sec)
	if(sec <= 0){
		return
	}
	ToolTip , %text%, %X%, %Y%, 1
}

; O_toolTipX と O_toolTipY の位置に表示させるツールチップ
timf_toolTipFuncOptionPos(text){
	timf_toolTipFunc(text, O_toolTipX, O_toolTipY, O_toolTipSecond)
}

; あと何秒か表示する
timf_timerSetTextShutDown(){
	nowSec := timf_dateTimeToSec( A_Now )
	ans := glob_shutDownTimer_dateTime_sec  -  nowSec

	; 日付をまたぐと nowSec は小さい数字になる。
	; 現時点では２４時間以上先は指定できないため、
	; 86400秒を超えたときは、glob_shutDownTimer_dateTime_sec に oneDay_secの変数がプラスされていた場合と判断する
	if(ans >= 86400){
		ans -= 86400
	}
	if(ans < 1){
		ans = 0
	}
	guf_setControl( "あと " . ans, "Text88_2", 88 )
	glob_textShutDownTimer = 0
}

; dateTimeの 時間、分、秒を 秒の合計に変換する。
; 日付が違う場合は対応出来ないので注意
timf_dateTimeToSec(dateTime) {
	FormatTime,hour, %dateTime%, H
	FormatTime,min, %dateTime%, m
	FormatTime,sec, %dateTime%, s
	allSec := timf_minHourToSec(hour, min, sec)
	return  allSec
}

timf_minHourToSec(hour, min, sec){
	minToSec := min * 60
	hourToSec := hour * 3600
	allSec := hourToSec + minToSec + sec
	return  allSec
}

timf_commTimerSetText(typeNum){
	nowSec := timf_dateTimeToSec( A_Now )
	pOut =
	ans = 0
	if(typeNum == 1){
		pOut := "Text87_1_2"
		ans := glob_timer_sec1 - nowSec
		glob_timerText_sec1 = 0
	} else if(typeNum == 2){
		pOut := "Text87_2_2"
		ans := glob_timer_sec2 - nowSec
		glob_timerText_sec2 = 0
	} else if(typeNum == 3){
		pOut := "Text87_3_2"
		ans := glob_timer_sec3 - nowSec
		glob_timerText_sec3 = 0
	} else if(typeNum == 4){
		pOut := "Text87_4_2"
		ans := glob_timer_sec4 - nowSec
		glob_timerText_sec4 = 0
	} else if(typeNum == 5){
		pOut := "Text87_5_2"
		ans := glob_timer_sec5 - nowSec
		glob_timerText_sec5 = 0
	} else if(typeNum == 6){
		pOut := "Text87_6_2"
		ans := glob_timer_sec6 - nowSec
		glob_timerText_sec6 = 0
	} else if(typeNum == 7){
		pOut := "Text87_7_2"
		ans := glob_timer_sec7 - nowSec
		glob_timerText_sec7 = 0
	} else if(typeNum == 8){
		pOut := "Text87_8_2"
		ans := glob_timer_sec8 - nowSec
		glob_timerText_sec8 = 0
	} else if(typeNum == 9){
		pOut := "Text87_9_2"
		ans := glob_timer_sec9 - nowSec
		glob_timerText_sec9 = 0
	} else if(typeNum == 10){
		pOut := "Text87_10_2"
		ans := glob_timer_sec10 - nowSec
		glob_timerText_sec10 = 0
	}

	; 日付をまたいだ場合、nowSecは当然小さい数字になる。
	; 現時点では２４時間以上先は指定できない仕様なので、
	; 86400秒を超えたときは、glob_timer_sec に oneDay_secの変数がプラスされていた場合と判断する
	if(ans >= 86400){
		ans -= 86400
	}
	if(ans < 0){
		ans = 0
	}
	guf_setControl( "あと " . ans, pOut, 87 )
}

timf_timerCommExeLogic(num){
	argStr := glob_timeArgStr%num%
	pControl := glob_timePControl%num%
	GuiNum := glob_timeGuiNum%num%
	timerLogStr := glob_timerLogStr%num%
	timf_stopSetTimer(num)
	timf_heightChangeTimerGui()
	if( timerLogStr != "" ){
		str_local := timerLogStr . argStr . "`nの処理を実行した"
		guit_appendExplainNotShow(str_local)
	}
	edi_commandExeLogicWrapper(argStr, "", pControl, GuiNum, null, True, True)
}

/*
timf_heightChangeGui87(){
	plus := cen_anyOfNumFromDpiAndFontSize(2, 3, 0, 15, 30)
	if( glob_timerFlag10 ){
		;gGlob_Gui87Height := 640 + plus
	} else if(glob_timerFlag9){
		gGlob_Gui87Height := 580 + plus
	} else if(glob_timerFlag8){
		gGlob_Gui87Height := 510 + plus
	} else if(glob_timerFlag7){
		gGlob_Gui87Height := 450 + plus
	} else if(glob_timerFlag6){
		gGlob_Gui87Height := 390 + plus
	} else if(glob_timerFlag5){
		gGlob_Gui87Height := 320 + plus
	} else if(glob_timerFlag4){
		gGlob_Gui87Height := 250 + plus
	} else if(glob_timerFlag3){
		gGlob_Gui87Height := 180 + plus
	} else if(glob_timerFlag2){
		gGlob_Gui87Height := 120 + plus
	} else {
		gGlob_Gui87Height := 60 + plus
	}
}
*/

/*
timf_controlShowOrHideTimerGui(num, flag){
	; タイマーの番号が１なら、何もしない
	if(num == 1){
		return
	}

	pText1 := "Text87_" . num . "_1"
	pText2 := "Text87_" . num . "_2"
	pText3 := "Edit87_" . num . "_3"
	pButton1 := "Button87_" . num . "_1"
	guf_switchControlShowByFlag(flag, pText1, 87)
	guf_switchControlShowByFlag(flag, pText2, 87)
	guf_switchControlShowByFlag(flag, pText3, 87)
	guf_switchControlShowByFlag(flag, pButton1, 87)
}
*/

timf_heightChangeTimerGui(){
	num = 1
	if( glob_timerFlag10 ){
		num = 10
	} else if(glob_timerFlag9){
		num = 9
	} else if(glob_timerFlag8){
		num = 8
	} else if(glob_timerFlag7){
		num = 7
	} else if(glob_timerFlag6){
		num = 6
	} else if(glob_timerFlag5){
		num = 5
	} else if(glob_timerFlag4){
		num = 4
	} else if(glob_timerFlag3){
		num = 3
	} else if(glob_timerFlag2){
		num = 2
	}

	timf_heightChangeTimerGuiLogic(num)
}

timf_decideTimerGuiHeight(num){
	plus := cen_anyOfNumFromDpiAndFontSize(1, 1, 30, 32, 34)
	pText3 := "Edit87_" . num . "_3"
	GuiControlGet, pos_ , 87:Pos, %pText3%
	heigth := pos_Y + plus
	return heigth
}

timf_heightChangeTimerGuiLogic(num){
	heigth := timf_decideTimerGuiHeight(num)

	; サイズ変更
	GuiControlGet, OutputVar , 87:Visible, Text87_1_1
	if(OutputVar == 1){
		params := "h" . heigth . " NA"
		guf_showGuiAssign(87, params)
		;timf_showGui87_autoClose(params)
	} else {
		params := "Hide h" . heigth
		guf_showGuiAssign(87, params)
	}
}

timf_stopSetTimer(num){
	glob_timer%num% = 0
	glob_timer_sec%num% = 0
	glob_timerText_sec%num% = 0
	glob_timeArgStr%num% = 
	glob_timePControl%num% = 
	glob_timeGuiNum%num% = 
	glob_timerFlag%num% := False
	glob_timerLogStr%num% =

	pOut1 =
	pOut2 =
	pOut3 =
	if(num == 1){
		pOut1 := "Text87_1_1"
		pOut2 := "Text87_1_2"
		pOut3 := "Edit87_1_3"
	} else if(num == 2){
		pOut1 := "Text87_2_1"
		pOut2 := "Text87_2_2"
		pOut3 := "Edit87_2_3"
	} else if(num == 3){
		pOut1 := "Text87_3_1"
		pOut2 := "Text87_3_2"
		pOut3 := "Edit87_3_3"
	} else if(num == 4){
		pOut1 := "Text87_4_1"
		pOut2 := "Text87_4_2"
		pOut3 := "Edit87_4_3"
	} else if(num == 5){
		pOut1 := "Text87_5_1"
		pOut2 := "Text87_5_2"
		pOut3 := "Edit87_5_3"
	} else if(num == 6){
		pOut1 := "Text87_6_1"
		pOut2 := "Text87_6_2"
		pOut3 := "Edit87_6_3"
	} else if(num == 7){
		pOut1 := "Text87_7_1"
		pOut2 := "Text87_7_2"
		pOut3 := "Edit87_7_3"
	} else if(num == 8){
		pOut1 := "Text87_8_1"
		pOut2 := "Text87_8_2"
		pOut3 := "Edit87_8_3"
	} else if(num == 9){
		pOut1 := "Text87_9_1"
		pOut2 := "Text87_9_2"
		pOut3 := "Edit87_9_3"
	} else if(num == 10){
		pOut1 := "Text87_10_1"
		pOut2 := "Text87_10_2"
		pOut3 := "Edit87_10_3"
	}
	guf_setControl( "タイマー" . num, pOut1, 87 )
	guf_setControl( null, pOut2, 87 )
	guf_setControl( null, pOut3, 87 )
}

timf_stopAnyTimer(num){
	if(num == 1){
		SetTimer, SubCommTimer1 , Off
	} else if(num == 2){
		SetTimer, SubCommTimer2 , Off
	} else if(num == 3){
		SetTimer, SubCommTimer3 , Off
	} else if(num == 4){
		SetTimer, SubCommTimer4 , Off
	} else if(num == 5){
		SetTimer, SubCommTimer5 , Off
	} else if(num == 6){
		SetTimer, SubCommTimer6 , Off
	} else if(num == 7){
		SetTimer, SubCommTimer7 , Off
	} else if(num == 8){
		SetTimer, SubCommTimer8 , Off
	} else if(num == 9){
		SetTimer, SubCommTimer9 , Off
	} else if(num == 10){
		SetTimer, SubCommTimer10 , Off
	}
	timf_stopSetTimer(num)
}

timf_stopAnyTimerChangeHeight(num){
	timf_stopAnyTimer(num)
	timf_heightChangeTimerGui()
}

timf_stopTimer(com2, com3, pOut, GuiNum){
	str =
	timerLogFlag := False
	allFlag := False
	stopTimerFlag := False
	stopTimerNum = 0
	
	if( com2 == "--output" ){
		timerLogFlag := True
	}
	if( com2 == "-o" ){
		timerLogFlag := True
	}
	if( com3 == "--output" ){
		timerLogFlag := True
	}
	if( com3 == "-o" ){
		timerLogFlag := True
	}

	if(com2 == "all"){
		allFlag := True
	}
	if(com3 == "all"){
		allFlag := True
	}
	if( allFlag ){
		timf_stopAnyTimer(1)
		timf_stopAnyTimer(2)
		timf_stopAnyTimer(3)
		timf_stopAnyTimer(4)
		timf_stopAnyTimer(5)
		timf_stopAnyTimer(6)
		timf_stopAnyTimer(7)
		timf_stopAnyTimer(8)
		timf_stopAnyTimer(9)
		timf_stopAnyTimer(10)
		str := "全てのタイマー を停止した"
		; -o の指定の場合
		if( timerLogFlag ){
			str := "&timerStop により " . str
			guit_appendExplainNotShow(str)
		} else {
			guit_setExplain(str, GuiNum)
		}
		timf_heightChangeTimerGui()
		return
	}
	If com2 is integer
	{
		If com2 not between 1 and 10
		{
			guit_errorAppend("&timerStopのエラー`nタイマーの指定の数字が１から１０以内ではない`n" . com2)
			return
		}
		stopTimerFlag := True
		stopTimerNum = %com2%
	}
	If com3 is integer
	{
		If com3 not between 1 and 10
		{
			guit_errorAppend("&timerStopのエラー`nタイマーの指定の数字が１から１０以内ではない`n" . com3)
			return
		}
		stopTimerFlag := True
		stopTimerNum = %com3%
	}
	if( stopTimerFlag ){
		str := "タイマー" . stopTimerNum  . " を停止した"
		; -o の指定の場合
		if( timerLogFlag ){
			str := "&timerStop により " . str
			guit_appendExplainNotShow(str)
		} else {
			guit_setExplain(str, GuiNum)
		}
		timf_stopAnyTimer(stopTimerNum)
		timf_heightChangeTimerGui()
		return
	}

	str := "タイマーを停止する。`n引数１  (タイマーのナンバーか all)"
	guit_errorAppendOrSetExplain(str, GuiNum)
}

timf_showGui88_autoClose() {
	Gui, 88:Show,  NA, %gGlob_Gui88Title%
	if(glob_iniTimerGui_sec == 0){
		return
	}
	timf_Gui88Close(glob_iniTimerGui_sec)
}

timf_showGui87_autoClose(params) {
	if( glob_iniTimerGui_sec == 0 ){
		guf_showGuiAssign(87, params)
		return
	}
	guit_showGuiEnyAutoClose(glob_iniTimerGui_sec, "gGlob_timerGui87", "SubGui87Close", 87, params)
}

timf_showOrHideTimerGui(){
	GuiControlGet, OutputVar, 87:Visible, Text87_1_1
	if(OutputVar == 1){
		Gui, 87:Show, Hide
		return
	}
	guf_showGuiAssign(87)
}

; 表示されてるとき、閉じる時間を延長
/*
timf_showGui_act87() {
	GuiControlGet, OutputVar , 87:Visible, Text87_1_1
	if(OutputVar == 1){
		timf_showGui87_autoClose("NA")
	}
}
*/
