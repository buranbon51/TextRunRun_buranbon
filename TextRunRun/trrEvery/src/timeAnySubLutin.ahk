






SubTimerShutDown:
	glob_textShutDownTimer += glob_timePeriod_sec
	if(glob_textShutDownTimer >= glob_iniTimerTextPeriod_sec){
		timf_timerSetTextShutDown()
	}
	if(A_Now >= glob_shutDownTimer_dateTime) {
		SetTimer, SubTimerShutDown , Off
		syf_shutdownLogic()
	}
	return


SubToolTipClose:
	if(glob_timerToolTip < A_Now){
		SetTimer, SubToolTipClose , Off
		func_toolTipClose(1)
		glob_timerToolTip = 0
	}
	return

SubToolTipClose2:
	if(glob_timerToolTip2 < A_Now){
		SetTimer, SubToolTipClose2 , Off
		func_toolTipClose(2)
		glob_timerToolTip2 = 0
	}
	return

SubSendScriptToText:
	if(glob_sendToTextTimer < A_Now){
		SetTimer, SubSendScriptToText, Off
		edi_sendScriptToTextTimer()
	}
	return

SubGui88Close:
	if(gGlob_timerGui88 < A_Now){
		SetTimer, SubGui88Close , Off
		guaf_hideGui88NotActive()
		gGlob_timerGui88 = 0
	}
	return

SubGui77Close:
	if(gGlob_timerGui77 < A_Now){
		SetTimer, SubGui77Close , Off
		guf_hideGuiIfNotActive(gGlob_Gui77Title, 77)
		gGlob_timerGui77 = 0
	}
	return

SubGui78Close:
	if(gGlob_timerGui78 < A_Now){
		SetTimer, SubGui78Close , Off
		guf_hideGuiIfNotActive(gGlob_Gui78Title, 78)
		gGlob_timerGui78 = 0
	}
	return

SubGui87Close:
	if(gGlob_timerGui87 < A_Now){
		SetTimer, SubGui87Close , Off
		guf_hideGuiIfNotActive(gGlob_Gui87Title, 87)
		gGlob_timerGui87 = 0
	}
	return

SubGui87Show:
	WinWaitActive , A, , 1
	timf_showOrHideTimerGui()
	return

SubCommTimer1:
	glob_timerText_sec1 += glob_timePeriod_sec
	if( glob_timerText_sec1 >= glob_iniTimerTextPeriod_sec ){
		timf_commTimerSetText(1)
	}

	if( A_Now >= glob_timer1 ){
		SetTimer, SubCommTimer1 , Off
		timf_timerCommExeLogic(1)
	}
	return

SubCommTimer2:
	glob_timerText_sec2 += glob_timePeriod_sec
	if( glob_timerText_sec2 >= glob_iniTimerTextPeriod_sec ){
		timf_commTimerSetText(2)
	}

	if( A_Now >= glob_timer2 ){
		SetTimer, SubCommTimer2 , Off
		timf_timerCommExeLogic(2)
	}
	return

SubCommTimer3:
	glob_timerText_sec3 += glob_timePeriod_sec
	if( glob_timerText_sec3 >= glob_iniTimerTextPeriod_sec ){
		timf_commTimerSetText(3)
	}

	if( A_Now >= glob_timer3 ){
		SetTimer, SubCommTimer3 , Off
		timf_timerCommExeLogic(3)
	}
	return

SubCommTimer4:
	glob_timerText_sec4 += glob_timePeriod_sec
	if( glob_timerText_sec4 >= glob_iniTimerTextPeriod_sec ){
		timf_commTimerSetText(4)
	}

	if( A_Now >= glob_timer4 ){
		SetTimer, SubCommTimer4 , Off
		timf_timerCommExeLogic(4)
	}
	return

SubCommTimer5:
	glob_timerText_sec5 += glob_timePeriod_sec
	if( glob_timerText_sec5 >= glob_iniTimerTextPeriod_sec ){
		timf_commTimerSetText(5)
	}

	if( A_Now >= glob_timer5 ){
		SetTimer, SubCommTimer5 , Off
		timf_timerCommExeLogic(5)
	}
	return

SubCommTimer6:
	glob_timerText_sec6 += glob_timePeriod_sec
	if( glob_timerText_sec6 >= glob_iniTimerTextPeriod_sec ){
		timf_commTimerSetText(6)
	}

	if( A_Now >= glob_timer6 ){
		SetTimer, SubCommTimer6 , Off
		timf_timerCommExeLogic(6)
	}
	return

SubCommTimer7:
	glob_timerText_sec7 += glob_timePeriod_sec
	if( glob_timerText_sec7 >= glob_iniTimerTextPeriod_sec ){
		timf_commTimerSetText(7)
	}

	if( A_Now >= glob_timer7 ){
		SetTimer, SubCommTimer7 , Off
		timf_timerCommExeLogic(7)
	}
	return

SubCommTimer8:
	glob_timerText_sec8 += glob_timePeriod_sec
	if( glob_timerText_sec8 >= glob_iniTimerTextPeriod_sec ){
		timf_commTimerSetText(8)
	}

	if( A_Now >= glob_timer8 ){
		SetTimer, SubCommTimer8 , Off
		timf_timerCommExeLogic(8)
	}
	return

SubCommTimer9:
	glob_timerText_sec9 += glob_timePeriod_sec
	if( glob_timerText_sec9 >= glob_iniTimerTextPeriod_sec ){
		timf_commTimerSetText(9)
	}

	if( A_Now >= glob_timer9 ){
		SetTimer, SubCommTimer9 , Off
		timf_timerCommExeLogic(9)
	}
	return

SubCommTimer10:
	glob_timerText_sec10 += glob_timePeriod_sec
	if( glob_timerText_sec10 >= glob_iniTimerTextPeriod_sec ){
		timf_commTimerSetText(10)
	}

	if( A_Now >= glob_timer10 ){
		SetTimer, SubCommTimer10 , Off
		timf_timerCommExeLogic(10)
	}
	return

; Gui を自動で閉じるためのサブルーチン
SubGui66Close:
	if(gGlob_timerGui66 < A_Now){
		SetTimer, SubGui66Close, Off
		guaf_hideGui66NotActive()
		gGlob_timerGui66 = 0
	}
	return

SubGui68Close:
	if(gGlob_timerGui68 < A_Now){
		SetTimer, SubGui68Close, Off
		guaf_hideGui68NotActive()
		gGlob_timerGui68 = 0
	}
	return

SubGui67Close:
	if(gGlob_timerGui67 < A_Now){
		SetTimer, SubGui67Close, Off
		guf_hideGuiIfNotActive(gGlob_Gui67Title, 67)
		gGlob_timerGui67 = 0
	}
	return

SubShowWaitExecutor:
	if(gGlob_timerShowWaitExecutor < A_Now){
		SetTimer, SubShowWaitExecutor, Off
		guf_showGuiAssign(gGlob_tmpGuiNumShowWaitExecutor, gGlob_tmpOrderShowWaitExecutor)
		gGlob_timerShowWaitExecutor = 0
	}
	return
