
linu_sleep(rightStr, pOut, GuiNum, outPutSucceedFlag){

	advice := "&wait  時間指定  &&& 処理させる項目`n時間指定は  1h  3m  3s の形で指定可`nまたは、`n&wait -n [数字] 時間指定 &&& 処理させる項目`nの場合、[数字]の部分が、どのタイマーを使用するかの指定になる"

	timerLogStr =
	assignNum = 0

	timerLogFlag := False

	rightStr_right := func_rightStrOrNullFromSearchStr(rightStr, "&&& ")
	if( rightStr_right == "" ){
		guit_setExplainPurpose(advice, GuiNum)
		return
	}

	leftStr := func_leftStrOrAllFromSearchStr(rightStr, "&&& ")
	; >>> があれば outputの種類を変更する
	leftStr := guit_outPutControl(leftStr, outPutSucceedFlag)

	param_local := "--output"
	IfInString, leftStr, %param_local%
	{
		timerLogFlag := True
		StringReplace, leftStr, leftStr, %param_local%
		leftStr := Trim( leftStr )
	}
	param_local := "--number"
	IfInString, leftStr, %param_local%
	{
		paramLeft := func_leftStrOrAllFromSearchStr(leftStr, param_local)
		paramRight := func_rightStrOrNullFromSearchStr(leftStr, param_local)
		; --number の右の文字の 次のスペースまでの文字を取得
		leftStrTmp := func_separationSpaceLeftOrAll(paramRight)
		; さらに右の文字と
		paramRight_right := func_separationSpaceRightOrNull(paramRight)
		; --number の左の文字と paramRight_right を引数にする
		leftStr := paramLeft . " " . paramRight_right

		; textOut
		leftStrTmp := outs_textOutTrimss(leftStrTmp)

		If leftStrTmp is not integer
		{
			guit_errorAppend("&waitのエラー`n--number の後にタイマーの番号を指定していない`n" . rightStr)
			return
		}
		If leftStrTmp not between 1 and 10
		{
			guit_errorAppend("&waitのエラー`nタイマーの指定の数字が１から１０以内ではない`n" . rightStr)
			return
		}
		assignNum = %leftStrTmp%
	}

	noOptionFlag := True
	StringLeft, lChr, leftStr, 1
	if( lChr == "-" ){
		StringLeft, rChr2, leftStr, 2
		if( rChr2 == "--" ){
			guit_errorAppend("&timerのエラー`n-- を使った不明な引数がある`n" . rightStr)
			return
		}
		leftStr_left := func_separationSpaceLeftOrAll(leftStr)
		; - の右のスペースより右の文字を 引数にする
		leftStr := func_separationSpaceRightOrNull(leftStr)
		; 左の - を取り除く
		StringTrimLeft, leftStr_left, leftStr_left, 1
		; textOut
		leftStr_left := outs_textOutTrimss(leftStr_left)
		IfInString, leftStr_left, o
		{
			timerLogFlag := True
			StringReplace, leftStr_left, leftStr_left, o
			noOptionFlag := False
		}
		IfInString, leftStr_left, n
		{
			; タイマーの番号を指定
			;StringReplace, leftStr_left, leftStr_left, n
			leftStrTmp := func_separationSpaceLeftOrAll(leftStr)
			; さらに右の文字を引数にする
			leftStr := func_separationSpaceRightOrNull(leftStr)

			; textOut
			leftStrTmp := outs_textOutTrimss(leftStrTmp)

			If leftStrTmp is not integer
			{
				guit_errorAppend("&waitのエラー`n-n の後にタイマーの番号を指定していない`n" . rightStr)
				return
			}
			If leftStrTmp not between 1 and 10
			{
				guit_errorAppend("&waitのエラー`nタイマーの指定の数字が１から１０以内ではない`n" . rightStr)
				return
			}
			assignNum = %leftStrTmp%
			noOptionFlag := False
		}
		; タイマーの番号を指定
		If leftStr_left is integer
		{
			If leftStr_left not between 1 and 10
			{
				guit_errorAppend("&waitのエラー`nタイマーの指定の数字が１から１０以内ではない`n" . rightStr)
				return
			}
			assignNum = %leftStr_left%
			noOptionFlag := False
		}
		if( noOptionFlag ){
			guit_errorAppend("waitのエラー`n- の後に設定で使える文字が無い。`n" . rightStr)
			return
		}
	}

	; - の確認を２回繰り返す
	StringLeft, lChr, leftStr, 1
	if( lChr == "-" ){
		StringLeft, rChr2, leftStr, 2
		if( rChr2 == "--" ){
			guit_errorAppend("&timerのエラー`n-- を使った不明な引数がある`n" . rightStr)
			return
		}
		leftStr_left := func_separationSpaceLeftOrAll(leftStr)
		; - の右のスペースより右の文字を 引数にする
		leftStr := func_separationSpaceRightOrNull(leftStr)
		; 左の - を取り除く
		StringTrimLeft, leftStr_left, leftStr_left, 1
		; textOut
		leftStr_left := outs_textOutTrimss(leftStr_left)
		IfInString, leftStr_left, o
		{
			timerLogFlag := True
			StringReplace, leftStr_left, leftStr_left, o
			noOptionFlag := False
		}
		IfInString, leftStr_left, n
		{
			; タイマーの番号を指定
			;StringReplace, leftStr_left, leftStr_left, n
			leftStrTmp := func_separationSpaceLeftOrAll(leftStr)
			; さらに右の文字を引数にする
			leftStr := func_separationSpaceRightOrNull(leftStr)

			; textOut
			leftStrTmp := outs_textOutTrimss(leftStrTmp)

			If leftStrTmp is not integer
			{
				guit_errorAppend("&waitのエラー`n-n の後にタイマーの番号を指定していない`n" . rightStr)
				return
			}
			If leftStrTmp not between 1 and 10
			{
				guit_errorAppend("&waitのエラー`nタイマーの指定の数字が１から１０以内ではない`n" . rightStr)
				return
			}
			assignNum = %leftStrTmp%
			noOptionFlag := False
		}
		; タイマーの番号を指定
		If leftStr_left is integer
		{
			If leftStr_left not between 1 and 10
			{
				guit_errorAppend("&waitのエラー`nタイマーの指定の数字が１から１０以内ではない`n" . rightStr)
				return
			}
			assignNum = %leftStr_left%
			noOptionFlag := False
		}
		if( noOptionFlag ){
			guit_errorAppend("waitのエラー`n- の後に設定で使える文字が無い。`n" . rightStr)
			return
		}
	}


	; textOut
	leftStr := outs_textOutTrimss(leftStr)
	if( leftStr == "" ){
		guit_errorAppend("&waitのエラー`n1h  3m  3s の形での記述がない`n" . rightStr)
		return
	}

	if( timerLogFlag ){
		timerLogStr := "&wait  " . leftStr . "  により`n"
	}

	allSec := linu_confirmTimerArgss(leftStr)
	if(allSec == "error"){

	} else if(allSec > 0){
		if( allSec >= 86400 ){
			guit_errorAppend("&waitのエラー。現時点では２４時間以上先の指定はできない")
			return
		}
		linu_sleepLogic(allSec, rightStr_right, pOut, GuiNum, assignNum, timerLogStr, False)
		return
	}
	guit_errorAppendOrSetExplain(advice, GuiNum)
}

linu_sleepLogic(leftStr, rightStr, pOut, GuiNum, assignNum, timerLogStr, atFlag){
	; &wait で実行するか &timer で実行するかで違う
	if( atFlag ){
		dateTime := leftStr
	} else {
		dateTime := A_Now
		EnvAdd, dateTime, %leftStr% , Seconds
	}

	useNum =
	if( assignNum != 0 ){
		; どのタイマーかを指定した場合
		; SetTimer を重複して動作させないように、glob_timerFlag番号 の変数の値が False の時だけ SetTimer を使う
		timerFlag_local := glob_timerFlag%assignNum%
		if( timerFlag_local == False ){
			SetTimer, SubCommTimer%assignNum% , %glob_timePeriod%
		}
		linu_sleepTimeSet(assignNum, dateTime, rightStr, timerLogStr, pOut, GuiNum)
		useNum = %assignNum%
	} else if( glob_timerFlag1 == False){
		linu_sleepTimeSet(1, dateTime, rightStr, timerLogStr, pOut, GuiNum)
		useNum = 1
		SetTimer, SubCommTimer1 , %glob_timePeriod%
	} else if(glob_timerFlag2 == False){
		linu_sleepTimeSet(2, dateTime, rightStr, timerLogStr, pOut, GuiNum)
		useNum = 2
		SetTimer, SubCommTimer2 , %glob_timePeriod%
	} else if(glob_timerFlag3 == False){
		linu_sleepTimeSet(3, dateTime, rightStr, timerLogStr, pOut, GuiNum)
		useNum = 3
		SetTimer, SubCommTimer3 , %glob_timePeriod%
	} else if(glob_timerFlag4 == False){
		linu_sleepTimeSet(4, dateTime, rightStr, timerLogStr, pOut, GuiNum)
		useNum = 4
		SetTimer, SubCommTimer4 , %glob_timePeriod%
	} else if(glob_timerFlag5 == False){
		linu_sleepTimeSet(5, dateTime, rightStr, timerLogStr, pOut, GuiNum)
		useNum = 5
		SetTimer, SubCommTimer5 , %glob_timePeriod%
	} else if(glob_timerFlag6 == False){
		linu_sleepTimeSet(6, dateTime, rightStr, timerLogStr, pOut, GuiNum)
		useNum = 6
		SetTimer, SubCommTimer6 , %glob_timePeriod%
	} else if(glob_timerFlag7 == False){
		linu_sleepTimeSet(7, dateTime, rightStr, timerLogStr, pOut, GuiNum)
		useNum = 7
		SetTimer, SubCommTimer7 , %glob_timePeriod%
	} else if(glob_timerFlag8 == False){
		linu_sleepTimeSet(8, dateTime, rightStr, timerLogStr, pOut, GuiNum)
		useNum = 8
		SetTimer, SubCommTimer8 , %glob_timePeriod%
	} else if(glob_timerFlag9 == False){
		linu_sleepTimeSet(9, dateTime, rightStr, timerLogStr, pOut, GuiNum)
		useNum = 9
		SetTimer, SubCommTimer9 , %glob_timePeriod%
	} else if(glob_timerFlag10 == False){
		linu_sleepTimeSet(10, dateTime, rightStr, timerLogStr, pOut, GuiNum)
		useNum = 10
		SetTimer, SubCommTimer10 , %glob_timePeriod%
	} else {
		guit_errorAppend("タイマーのエラー。`nタイマーは１０個とも使用中。`n以下の処理は実行されない`n" . rightStr)
		return
	}
	if(atFlag == True){
		FormatTime,textTime, %dateTime%, HH時mm分ss秒
		pOut := "Text87_" . useNum  . "_1"
		guf_setControl( textTime  . " まで", pOut, 87 )
	}
	guit_setExplain(rightStr  . "`nの処理を" . useNum  . " のタイマーで待機", GuiNum)

	timf_heightChangeTimerGui()
}

linu_sleepTimeSet(num, dateTime, rightStr, timerLogStr, pOut, GuiNum){
	; 今の時間より早かったら次の日の時間にする
	tomorrowFlag := False
	if(dateTime <= A_Now){
		EnvAdd, dateTime, 1 , Days
		tomorrowFlag := True
	}


	todaySec := timf_dateTimeToSec( dateTime )
	; todaySec は日付は関係なく、時間のみで取得しているため
	; nowSec より低い場合、その対処をする
	; 現時点では ２４時間以上先は指定できないため、この処理でよい
	nowSec := timf_dateTimeToSec( A_Now )
	if(todaySec <= nowSec){
		tomorrowFlag := True
	}
	
	if(tomorrowFlag){
		oneDay_sec := timf_minHourToSec(24, 0, 0)
		todaySec += oneDay_sec
	}
	glob_timer%num% := dateTime
	glob_timer_sec%num% := todaySec

	glob_timerText_sec%num% = 0
	glob_timeArgStr%num% := rightStr
	; 現時点では pControl は 何も入れない
	glob_timePControl%num% := ""
	; 現時点では GuiNum は Gui71（タイプ４）のみ
	;glob_timeGuiNum%num% := GuiNum
	glob_timeGuiNum%num% = 71
	glob_timerFlag%num% := True
	glob_timerLogStr%num% := timerLogStr
	; 実行する処理を表示させる
	pOut := "Edit87_" . num  . "_3"
	; & のもじを全角の＆に変える
	StringReplace, text, glob_timeArgStr%num%, & , ＆, All
	guf_setControl( text, pOut, 87 )
	timf_commTimerSetText(num)
}

linu_confirmTimerArgss(argss){
	argss := Trim(argss)
	if( argss == "" ){
		return "error"
	}
	StringLower, argss, argss
	arg_1 =
	arg_2 =
	arg_3 =
	arg_4 =
	IfInString, argss, %A_Space%
	{
		StringSplit, arg_ , argss , %A_Space%, %A_Space%
	} else {
		arg_1 := argss
	}

	if(arg_4 != null){
		return  "error"
	}


	; 時間の指定の仕方が 1h 1m 1s などになっているかチェック
	flagHorMorS := True
	if( linu_confirmHorMorS(arg_1) == False ){
		flagHorMorS := False
	}
	if( linu_confirmHorMorS(arg_2) == False ){
		flagHorMorS := False
	}
	if( linu_confirmHorMorS(arg_3) == False ){
		flagHorMorS := False
	}
	if( flagHorMorS == False ){
		return  "error"
	}



	hour := linu_confirmHourMinSec(arg_1, arg_2, arg_3, "h")
	min := linu_confirmHourMinSec(arg_1, arg_2, arg_3, "m")
	sec := linu_confirmHourMinSec(arg_1, arg_2, arg_3, "s")
	if(hour == "error"){
		return  "error"
	} else if(min == "error"){
		return  "error"
	} else if(min == "error"){
		return  "error"
	}
	if(hour == null){
		hour = 0
	}
	if(min == null){
		min = 0
	}
	if(sec == null){
		sec = 0
	}
	allSec := timf_minHourToSec(hour, min, sec)
	return  allSec
}

; 時間の指定の仕方が 1h 1m 1s などになっているかチェック
linu_confirmHorMorS(arg){
	if( arg == null ){
		return  True
	}
	StringRight, searchChar, arg, 1
	if( searchChar == "h" ){

	} else if(searchChar == "m"){

	} else if(searchChar == "s"){

	} else {
		return  False
	}

	StringTrimRight, leftStr, arg, 1
	If leftStr is not number
	{
		return  False
	}
	return  True
}

linu_confirmHourMinSec(arg_1, arg_2, arg_3, searchChar){
	hour_if := linu_hourOrMinOrSecArgGet(arg_1, searchChar)
	if(hour_if != null){
		return  hour_if
	}
	hour_if := linu_hourOrMinOrSecArgGet(arg_2, searchChar)
	if(hour_if != null){
		return  hour_if
	}
	hour_if := linu_hourOrMinOrSecArgGet(arg_3, searchChar)
	if(hour_if != null){
		return  hour_if
	}
	return  null
}

linu_hourOrMinOrSecArgGet(arg, searchChar){
	IfInString, arg, %searchChar%
	{
		StringGetPos, count, arg, %searchChar%
		StringLeft, str_sec, arg, %count%
		str_sec := LTrim(str_sec)
		If str_sec is  number
		{
			return  str_sec
		}
		return  "error"
	}
	return  null
}


linu_shutdownTimeSet(argss, shutType, GuiNum){
	if(argss == "now"){
		glob_shutDownType := shutType
		guf_hideGuiAssign(GuiNum)
		syf_shutdownLogic()
		return
	}

	errorFlag := False
	allSec = 0

	; -timer の指定があった場合、 246060 の形で指定できる。
	atFlag := False
	dateTime = 0
	IfInString, argss, -timer
	{
		atFlag := True
		StringGetPos, count, argss, -timer
		count += 6
		StringTrimLeft, rightStr, argss, %count%
		rightStr := Trim(rightStr)

		dateTime := linu_getDateTimeOfAt(rightStr)
		if(dateTime == "error"){
			errorFlag := True
		}
	} else {

		If argss is integer
		{
			allSec := timf_minHourToSec(0, argss, 0)
		} else {
			allSec := linu_confirmTimerArgss(argss)
			if(allSec == "error"){
				errorFlag := True
			} else if(allSec > 0){

			} else {
				errorFlag := True
			}
		}

		if( allSec >= 86400 ){
			guit_errorAppend("現時点では２４時間以上先の指定はできない")
			errorFlag := True
		}
	}

	if( errorFlag ){
		guit_setExplain("&shutdown  何分か  now`n1h 1m 1s の形でも指定可`n-timer  240101 の形でも指定可", GuiNum)
		SetTimer, SubTimerShutDown, Off
		Gui, 88:Hide
		return
	} else {
		if( atFlag == False ){
			dateTime := A_Now
			EnvAdd, dateTime, %allSec% , Seconds
		}

		tomorrowFlag := False
		if(dateTime <= A_Now){
			EnvAdd, dateTime, 1 , Days
			tomorrowFlag := True
		}


		todaySec := timf_dateTimeToSec(dateTime)
		nowSec := timf_dateTimeToSec(A_Now)

		; todaySec は日付は関係なく、時間のみで取得しているため
		; nowSec より低い場合、その対処をする
		; 現時点では ２４時間以上先は指定できないため、この処理でよい
		if(todaySec <= nowSec){
			tomorrowFlag := True
		}

		if( tomorrowFlag ){
			oneDay_sec := timf_minHourToSec(24, 0, 0)
			todaySec += oneDay_sec
		}

		glob_shutDownTimer_dateTime := dateTime
		glob_shutDownTimer_dateTime_sec := todaySec
	}

	timf_timerSetTextShutDown()		; あと何秒か表示する
	glob_shutDownType := shutType
	if(shutType == 1){
		guf_setControl( "シャットダウン", "Text88_1", 88 )
	} else if(shutType == 2) {
		guf_setControl( "再起動", "Text88_1", 88 )
	} else if(shutType == 3) {
		guf_setControl( "ログオフ", "Text88_1", 88 )
	} else if(shutType == 4) {
		guf_setControl( "Shutdown, " . glob_ahkShutdownCode, "Text88_1", 88 )
	}
	SetTimer, SubTimerShutDown, %glob_timePeriod%
	timf_showGui88_autoClose()
	guf_hideGuiAssign(GuiNum)
}

linu_at(rightStr, pOut, GuiNum, outPutSucceedFlag){

	advice := "&timer (230101  時間 分 秒`nか2301  時間 分`nか24  時間)  実行させる処理`n-l  実行中の一覧を表示`n-d  [削除するタイマーのナンバー]`n&&& があった場合、&&& の後が実行処理になる。`nまたは、`n&timer -n [数字] (指定時間 と 実行させる処理)`nの場合、[数字]の部分が、どのタイマーを使用するかの指定になる"

	timerLogStr =
	assignNum = 0

	deleteFlag := False
	timerLogFlag := False

	if(rightStr == "-l"){
		timf_showGui87_autoClose("NA")
		return
	}
	if(rightStr == "--list"){
		timf_showGui87_autoClose("NA")
		return
	}

	; バックアップ
	rightStrTmp := rightStr

	param_local := "--delete"
	IfInString, rightStrTmp, %param_local%
	{
		deleteFlag := True
		StringReplace, rightStrTmp, rightStrTmp, %param_local%
		rightStrTmp := Trim( rightStrTmp )
	}
	param_local := "--output"
	IfInString, rightStrTmp, %param_local%
	{
		timerLogFlag := True
		StringReplace, rightStrTmp, rightStrTmp, %param_local%
		rightStrTmp := Trim( rightStrTmp )
	}
	param_local := "--number"
	IfInString, rightStrTmp, %param_local%
	{
		paramLeft := func_leftStrOrAllFromSearchStr(rightStrTmp, param_local)
		paramRight := func_rightStrOrNullFromSearchStr(rightStrTmp, param_local)
		; --number の右の文字の 次のスペースまでの文字を取得
		rightStr_left := func_leftStrOrAllFromSearchStr(paramRight, A_Space)
		; さらに右の文字と
		paramRight_right := func_rightStrOrNullFromSearchStr(paramRight, A_Space)
		; --number の左の文字と paramRight_right を引数にする
		rightStrTmp := paramLeft . " " . paramRight_right

		rightStr_left := outs_textOutTrimss(rightStr_left)

		If rightStr_left is not integer
		{
			guit_errorAppend("&timerのエラー`n--number の後にタイマーの番号を指定していない`n" . rightStr)
			return
		}
		If rightStr_left not between 1 and 10
		{
			guit_errorAppend("&timerのエラー`nタイマーの指定の数字が１から１０以内ではない`n" . rightStr)
			return
		}
		assignNum = %rightStr_left%
	}

	noOptionFlag := True
	StringLeft, rChr, rightStrTmp, 1
	if( rChr == "-" ){
		StringLeft, rChr2, rightStrTmp, 2
		if( rChr2 == "--" ){
			guit_errorAppend("&timerのエラー`n-- を使った不明な引数がある`n" . rightStr)
			return
		}
		leftStr := func_leftStrOrAllFromSearchStr(rightStrTmp, A_Space)
		; - の右のスペースより右の文字を 引数にする
		rightStrTmp := func_rightStrOrNullFromSearchStr(rightStrTmp, A_Space)

		; - をはずす
		StringTrimLeft, leftStr, leftStr, 1
		leftStr := outs_textOutTrimss(leftStr)
		IfInString, leftStr, d
		{
			deleteFlag := True
			StringReplace, leftStr, leftStr, d
			noOptionFlag := False
		}
		IfInString, leftStr, o
		{
			timerLogFlag := True
			StringReplace, leftStr, leftStr, o
			noOptionFlag := False
		}
		IfInString, leftStr, n
		{
			; タイマーの番号を指定
			;StringReplace, leftStr, leftStr, n
			rightStr_left := func_leftStrOrAllFromSearchStr(rightStrTmp, A_Space)
			; さらに右の文字を引数にする
			rightStrTmp := func_rightStrOrNullFromSearchStr(rightStrTmp, A_Space)

			rightStr_left := outs_textOutTrimss(rightStr_left)

			If rightStr_left is not integer
			{
				guit_errorAppend("&timerのエラー`n-n の後にタイマーの番号を指定していない`n" . rightStr)
				return
			}
			If rightStr_left not between 1 and 10
			{
				guit_errorAppend("&timerのエラー`nタイマーの指定の数字が１から１０以内ではない`n" . rightStr)
				return
			}
			assignNum = %rightStr_left%
			noOptionFlag := False
		}
		; タイマーの番号を指定
		If leftStr is integer
		{
			If leftStr not between 1 and 10
			{
				guit_errorAppend("&timerのエラー`nタイマーの指定の数字が１から１０以内ではない`n" . rightStr)
				return
			}
			assignNum = %leftStr%
			noOptionFlag := False
		}
		if( noOptionFlag ){
			guit_errorAppend("&timerのエラー`n- の後に設定で使える文字が無い。`n" . rightStr)
			return
		}
	}

	; - の確認を２回繰り返す
	StringLeft, rChr, rightStrTmp, 1
	if( rChr == "-" ){
		StringLeft, rChr2, rightStrTmp, 2
		if( rChr2 == "--" ){
			guit_errorAppend("&timerのエラー`n-- を使った不明な引数がある`n" . rightStr)
			return
		}
		leftStr := func_leftStrOrAllFromSearchStr(rightStrTmp, A_Space)
		; - の右のスペースより右の文字を 引数にする
		rightStrTmp := func_rightStrOrNullFromSearchStr(rightStrTmp, A_Space)

		; - をはずす
		StringTrimLeft, leftStr, leftStr, 1
		leftStr := outs_textOutTrimss(leftStr)
		IfInString, leftStr, d
		{
			deleteFlag := True
			StringReplace, leftStr, leftStr, d
			noOptionFlag := False
		}
		IfInString, leftStr, o
		{
			timerLogFlag := True
			StringReplace, leftStr, leftStr, o
			noOptionFlag := False
		}
		IfInString, leftStr, n
		{
			; タイマーの番号を指定
			;StringReplace, leftStr, leftStr, n
			rightStr_left := func_leftStrOrAllFromSearchStr(rightStrTmp, A_Space)
			; さらに右の文字を引数にする
			rightStrTmp := func_rightStrOrNullFromSearchStr(rightStrTmp, A_Space)

			rightStr_left := outs_textOutTrimss(rightStr_left)

			If rightStr_left is not integer
			{
				guit_errorAppend("&timerのエラー`n-n の後にタイマーの番号を指定していない`n" . rightStr)
				return
			}
			If rightStr_left not between 1 and 10
			{
				guit_errorAppend("&timerのエラー`nタイマーの指定の数字が１から１０以内ではない`n" . rightStr)
				return
			}
			assignNum = %rightStr_left%
			noOptionFlag := False
		}
		; タイマーの番号を指定
		If leftStr is integer
		{
			If leftStr not between 1 and 10
			{
				guit_errorAppend("&timerのエラー`nタイマーの指定の数字が１から１０以内ではない`n" . rightStr)
				return
			}
			assignNum = %leftStr%
			noOptionFlag := False
		}
		if( noOptionFlag ){
			guit_errorAppend("&timerのエラー`n- の後に設定で使える文字が無い。`n" . rightStr)
			return
		}
	}


	if( timerLogFlag ){
		timerLogStr := "&timer により`n"
	}

	if( deleteFlag ){
		rightStrTmp := outs_textOutTrimss(rightStrTmp)
		if( rightStrTmp == "all"){
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
			; -d と -o の指定の場合
			if( timerLogFlag ){
				str := "&timer --delete により " . str
				guit_appendExplainNotShow(str)
			} else {
				guit_setExplain(str, GuiNum)
			}
			timf_heightChangeTimerGui()
			return
		}
		If rightStrTmp is integer
		{
			If rightStrTmp not between 1 and 10
			{
				guit_errorAppend("&timer のエラー`nタイマーの指定の数字が１から１０以内ではない`n" . rightStr)
				return
			}
			str := "タイマー" . rightStrTmp . " を停止した"
			; -d と -o の指定の場合
			if( timerLogFlag ){
				str := "&timer --delete により " . str
				guit_appendExplainNotShow(str)
			} else {
				guit_setExplain(str, GuiNum)
			}
			timf_stopAnyTimer(rightStrTmp)
			timf_heightChangeTimerGui()
			return
		}
		guit_errorAppendOrSetExplain(advice, GuiNum)
		return
	}

	leftStr := func_leftStrOrAllFromSearchStr(rightStrTmp, A_Space)
	rightStr_right := func_rightStrOrNullFromSearchStr(rightStrTmp, A_Space)

	if(rightStr_right == null){
		guit_setExplainPurpose(advice, GuiNum)
		return
	}

	leftStr := outs_textOutTrimss(leftStr)

	; &&& がついていても同じように使えるようにする
	; ちなみに &&& がついてなければ null をかえす関数
	tmpStr := func_rightStrOrNullFromSearchStr(rightStr_right , "&&& ")
	if(tmpStr != ""){
		; &&& があった場合のみ、&&& の左側に >>> があれば outputの種類を変更する
		tmpLeftStr := func_leftStrOrNullFromSearchStrTurnAssign(rightStr_right, "&&& ", 1)
		guit_outPutControl(tmpLeftStr, outPutSucceedFlag)

		rightStr_right := tmpStr
	}

	returnStr := linu_getDateTimeOfAt(leftStr)

	if(returnStr == "error"){
		guit_errorAppendOrSetExplain(advice, GuiNum)
		return
	}
	linu_sleepLogic(returnStr, rightStr_right, pOut, GuiNum, assignNum, timerLogStr, True)
}

linu_getDateTimeOfAt(leftStr){
	If leftStr is not integer
	{
		return "error"
	}

	StringLen, length, leftStr
	if(length == 2){
		leftStr .= 0000
	} else if(length == 4){
		leftStr .= 00
	} else if(length == 6){

	} else {
		return "error"
	}

	FormatTime,toDay, %A_Now%, yyyyMMdd
	dateTime := toDay  . leftStr

	If dateTime is not time
	{
		return "error"
	}
	return  dateTime
}

linu_showFileOutputGui(rightStr, fileName, pOut, GuiNum){
	if( rightStr == "" ){
		return
	}
	guf_setControl( fileName, "Edit69_1", 69 )
	guf_setControl( rightStr, "BoxEdit69_1", 69 )
	guf_showGuiAssign(69)
	ControlSend , , ^{End}, ahk_id  %gGlob_hwndBoxEdit69_1%
}

linu_moreFromOutFile(){
	file := gloco_userDir . glob_outputFileName
	file := outs_textOutDqAllTrim(file)
	str := outs_getStrFromReadFile(file)
	linu_showFileOutputGui(str, file, "", 63)
}

linu_more(rightStr, pOut, GuiNum){
	helpStr := "引数を表示するだけ。`nファイルの中身を表示するなら`nmore < fileName`nになる"
	if( edc_helpViewIfHyphenH(helpStr, rightStr, GuiNum) ){
		return
	}

	linu_showFileOutputGui(rightStr, "引数の値", pOut, GuiNum)
}

linu_readFile(rightStr, pOut, GuiNum){
	helpStr := "ファイルの中を表示するだけ。"
	if( edc_helpViewIfHyphenH(helpStr, rightStr, GuiNum) ){
		return
	}
	if(rightStr == ""){
		guit_setExplainPurpose(helpStr, GuiNum)
		return
	}
	rightStr := outs_textOutDqAllTrim(rightStr)
	str := outs_getStrFromReadFile(rightStr)
	linu_showFileOutputGui(str, rightStr, "", 63)
}
