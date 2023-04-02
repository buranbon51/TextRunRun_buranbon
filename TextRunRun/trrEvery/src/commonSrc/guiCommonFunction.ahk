; 必須  gGlob

guf_setControl( str, pOut, GuiNum ) {
	GuiControl,%GuiNum%: , %pOut%, %str%
}

guf_getControl( pControl, GuiNum ) {
	GuiControlGet, %pControl%, %GuiNum%:
	controlVal := %pControl%
	return  controlVal
}

guf_showGuiAssign(GuiNum, order="_"){
	if(order == "_"){
		Gui, %GuiNum%:Show
	} else {
		Gui, %GuiNum%:Show, %order%
	}
}

; 上の関数 guf_showGuiAssign と同じ
guf_showGuiParams(GuiNum, params){
	Gui, %GuiNum%:Show, %params%
}

guf_hideGuiAssign(GuiNum){
	Gui, %GuiNum%:Hide
}

;  コントロールを非表示にし、操作不能にする
guf_controlHideDisable(pControl, GuiNum) {
	GuiControlGet, OutputVar, %GuiNum%:Visible, %pControl%
	if(OutputVar == 1) {
		GuiControl, %GuiNum%:Disable, %pControl%
		GuiControl, %GuiNum%:Hide, %pControl%
		return  True
	}
	return False
}

guf_GuiControl(pControl, GuiNum, order, param="_"){
	if(param == "_"){
		GuiControl, %GuiNum%:%order% ,%pControl%
	} else {
		GuiControl, %GuiNum%:%order% ,%pControl%, %param%
	}
}

guf_setFocus(pControl, GuiNum) {
	GuiControl, %GuiNum%:Focus ,%pControl%
}

guf_Gui(order, GuiNum, value1="_", value2="_", value3="_"){
	if(value3 != "_"){
		Gui, %GuiNum%:%order% ,%value1%, %value2%, %value3%
	} else if(value2 != "_"){
		Gui, %GuiNum%:%order% ,%value1%, %value2%
	} else if(value1 != "_"){
		Gui, %GuiNum%:%order% ,%value1%
	} else {
		Gui, %GuiNum%:%order%
	}
}

guf_GuiControlGet(pControl, GuiNum, order="_", value="_"){
	if(value != "_"){
		GuiControlGet, OutputVar, %GuiNum%:%order%, %pControl%, %value%
	} else if(order != "_"){
		GuiControlGet, OutputVar, %GuiNum%:%order%, %pControl%
	} else {
		GuiControlGet, %pControl%, %GuiNum%:
		OutputVar := %pControl%
	}
	return  OutputVar
}

guf_guiFontFromSizeAndName(fontNum, fontName, GuiNum){
	if(fontName == ""){
		Gui, %GuiNum%:Font, S%fontNum%
		return
	}
	Gui, %GuiNum%:Font, S%fontNum%, %fontName%
}

guf_textSizeChange(val, pVal, twice, large, GuiNum) {
	StringLen, outCount, val
	if (outCount > 25) {
		if(outCount < 94 ) {
			eStr := outCount * twice
			GuiControl, %GuiNum%:Move, %pVal%, W%eStr%
			Gui, %GuiNum%:Show, AutoSize
		} else {
			eStr := 94 * twice
			GuiControl, %GuiNum%:Move, %pVal%, W%eStr%
			Gui, %GuiNum%:Show, AutoSize
		}
	} else if (outCount <= 25) {
		GuiControl, %GuiNum%:Move, %pVal%, W%large%
		Gui, %GuiNum%:Show, AutoSize
	}
}

; アクティブでないならウインドウを閉じる
guf_hideGuiIfNotActive(guiTitle, GuiNum){
	IfWinNotActive , %guiTitle%
	{
		Gui, %GuiNum%:Hide
	}
}

guf_appendBoxEditBasisPlan(append, pBoxEditName, GuiNum) {
	GuiControlGet, %pBoxEditName%, %GuiNum%:
	after := %pBoxEditName% . append  . "`n"
	GuiControl,%GuiNum%: , %pBoxEditName%, %after%
}

guf_appendBoxEditCursorMove(append, pBoxEditName, GuiNum, hwndBoxEdit) {
	guf_appendBoxEditBasisPlan(append, pBoxEditName, GuiNum)
	DetectHiddenWindows, On
	ControlSend , , ^{End}, ahk_id  %hwndBoxEdit%
	DetectHiddenWindows, Off
}

; ラジオボタンで
guf_switchRadio2Pattern(radio1Value ,p_radio1, p_radio2, GuiNum){
	if(radio1Value == 1){
		guf_setControl( 1, p_radio1, GuiNum )
	} else if(radio1Value == 0) {
		guf_setControl( 1, p_radio2, GuiNum )
	}
}

guf_setRadioControl(radioNum, pRadio1, pRadio2, pRadio3, pRadio4, GuiNum){
	if(radioNum == 1) {
		guf_setControl( 1, pRadio1, GuiNum )
	} else if (radioNum == 2) {
		guf_setControl( 1, pRadio2, GuiNum )
	} else if (radioNum == 3) {
		guf_setControl( 1, pRadio3, GuiNum )
	} else {
		guf_setControl( 1, pRadio4, GuiNum )
	}
}

guf_guiRadioNum(radio1, radio2, radio3, radio4) {
	if(radio1 == 1) {
		return  1
	} else if (radio2 == 1) {
		return  2
	} else if (radio3 == 1) {
		return  3
	} else {
		return  4
	}
}

guf_guiRadioControl(GuiNum, pRadio1, pRadio2, pRadio3="_", pRadio4="_") {
	radio1 := guf_getControl( pRadio1, GuiNum )
	radio2 := guf_getControl( pRadio2, GuiNum )
	radio3 = 0
	if(pRadio3 != "_"){
		radio3 := guf_getControl( pRadio3, GuiNum )
	}
	radio4 = 0
	if(pRadio4 != "_"){
		radio4 := guf_getControl( pRadio4, GuiNum )
	}
	radioNum := guf_guiRadioNum(radio1, radio2, radio3, radio4)
	return radioNum
}

; コントロールを有効・無効を切り替える
guf_switchEnableByFlag(flag, pSwitchControl, GuiNum){
	if( flag ){
		GuiControl, %GuiNum%:Enable, %pSwitchControl%
	} else {
		GuiControl, %GuiNum%:Disable, %pSwitchControl%
	}
}

; コントロールの表示・非表示を切り替える
guf_switchControlShowByFlag(flag, pSwitchControl, GuiNum){
	if( flag ){
		GuiControl, %GuiNum%:Show, %pSwitchControl%
	} else {
		GuiControl, %GuiNum%:Hide, %pSwitchControl%
	}
}

; 表示・非表示をトグルにする
guf_showHideEnyGui(examplControl, GuiNum, order="_"){
	GuiControlGet, OutputVar, %GuiNum%:Visible, %examplControl%
	if(OutputVar == 1){
		Gui, %GuiNum%:Show, Hide
	} else {
		guf_showGuiAssign(GuiNum, order)
	}
}

; 表示・非表示をトグルにする。タイトルで指定
guf_showHideGuiToggle(winTitle, GuiNum, order="_"){
	IfWinExist, %winTitle%
	{
		Gui, %GuiNum%:Hide
	} else {
		guf_showGuiAssign(GuiNum, order)
	}
}

guf_getHwnd(GuiNum, pControl){
	if( pControl == "" ){
		return ""
	}
	GuiControlGet,hwndVar, %GuiNum%:Hwnd, %pControl%
	return hwndVar
}
