





guaf_anyOfNumFromDpi(lessThan110, lessThan140, moreThan140){
	if(StO_dpiNum <= 110){
		return lessThan110
	} else if(StO_dpiNum <= 140){
		return lessThan140
	} else if(StO_dpiNum >= 140){
		return moreThan140
	}
	return lessThan110
}

guaf_setValueMultipleText(com2, GuiNum){
	str := "&setValueMultipleText1  (登録する変数)`n二行以上のテキストの文字を、指定する変数に代入する"
	if( edc_helpViewIfHyphenH(str, com2, GuiNum) ){
		return
	}
	if(com2 == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}

	str := guf_getControl( "BoxEdit82_1", 82 )
	tmpStr := Trim(str)
	if(tmpStr == ""){
		guit_appendExplain("&setValueMultipleText1のエラー`n二行以上のテキストがカラ")
		return
	}

	if( outs_valueValidatorRulesNot(com2) ){
		guit_errorAppend("&setValueMultipleText1のエラー`n変数としては使えない文字がある`n" . com2)
		return
	}

	%com2% := str
	res := guit_checkErrorLevelOutput("&setValueMultipleText1のエラー`n変数に登録できていない")
	if(res == 1) {
		guit_setExplain(com2 . "  に二行以上のテキストの文字を代入した", GuiNum)
	}
}

guaf_sizeChangeStockGui(GuiNum){
	if( O_stockTextLengthNotFlag ){
		return
	}
	width := A_GuiWidth - 95
	width2 := A_GuiWidth - 105
	width3 := A_GuiWidth - 150
	GuiControl, %GuiNum%:Move, Edit%GuiNum%_1, w%width%
	GuiControl, %GuiNum%:Move, Edit%GuiNum%_2, w%width%
	GuiControl, %GuiNum%:Move, Edit%GuiNum%_3, w%width%
	GuiControl, %GuiNum%:Move, Edit%GuiNum%_4, w%width%
	GuiControl, %GuiNum%:Move, Edit%GuiNum%_5, w%width%
	GuiControl, %GuiNum%:Move, Edit%GuiNum%_6, w%width%
	GuiControl, %GuiNum%:Move, Edit%GuiNum%_7, w%width%
	GuiControl, %GuiNum%:Move, Edit%GuiNum%_8, w%width%
	GuiControl, %GuiNum%:Move, Edit%GuiNum%_9, w%width%
	GuiControl, %GuiNum%:Move, Edit%GuiNum%_10, w%width2%
	GuiControl, %GuiNum%:Move, Edit%GuiNum%_11, w%width3%
}

guaf_clickWindowCloseOrMinimize(){
	if( O_ClickWindowCloseFlag ){
		Gui, 76:Hide
		return
	}
	Gui, 76:Minimize
}

guaf_listVisibleEditss(GuiNum) {
	list1 := "List"  . GuiNum . "_1"
	list2 := "List"  . GuiNum . "_2"
	list3 := "List"  . GuiNum . "_3"
	list4 := "List"  . GuiNum . "_4"
	list5 := "List"  . GuiNum . "_5"
	if( guf_controlHideDisable(list1, GuiNum) ) {
		return  True
	} else if( guf_controlHideDisable(list2, GuiNum) ) {
		return  True
	} else if( guf_controlHideDisable(list3, GuiNum) ) {
		return  True
	} else if( guf_controlHideDisable(list4, GuiNum) ) {
		return  True
	} else if( guf_controlHideDisable(list5, GuiNum) ) {
		return  True
	}
	return  False
}

; フォーカス位置が　Edit の場合以外なら Edit2 にフォーカスがあるようにする
guaf_focusCheck(focusEdit, GuiNum){
	returnValue =
	Edit1 := "Edit" . GuiNum  . "_1"
	Edit2 := "Edit" . GuiNum  . "_2"
	Edit3 := "Edit" . GuiNum  . "_3"
	Edit4 := "Edit" . GuiNum  . "_4"
	Edit5 := "Edit" . GuiNum  . "_5"
	Edit6 := "Edit" . GuiNum  . "_6"
	Edit7 := "Edit" . GuiNum  . "_7"
	Edit8 := "Edit" . GuiNum  . "_8"

	if(focusEdit == Edit1){
		returnValue = %focusEdit%
	} Else if(focusEdit == Edit2){
		returnValue = %focusEdit%
	} Else if(focusEdit == Edit3){
		returnValue = %focusEdit%
	} Else if(focusEdit == Edit4){
		returnValue = %focusEdit%
	} Else if(focusEdit == Edit5){
		returnValue = %focusEdit%
	} Else if(focusEdit == Edit6){
		returnValue = %focusEdit%
	} Else if(focusEdit == Edit7){
		returnValue = %focusEdit%
	} Else if(focusEdit == Edit8){
		returnValue = %focusEdit%
	} Else {
		;returnValue := Edit2
		returnValue =
		;GuiControl, %GuiNum%:Focus, %Edit2%
	}
	return  returnValue
}


guaf_openSetMiniEdit(pathStr, argss, workStr, GuiNum){
	if(workStr == "") {
		str := pathStr  . " " . argss
	} else {
		str := pathStr  . " " . argss  . " <" . workStr  . ">"
	}
	str := Trim(str)
	if(GuiNum == 63){
		Gui, 64:Show
		GuiControl,64: , Edit64_1, %str%
	} else {
		Gui, 63:Show
		GuiControl,63: , Edit63_1, %str%
	}
}

;Gui88は閉じてはいけない。閉じるのではなく最小化させる
;もともと閉じていたのなら、閉じたまま。
guaf_closeGui88(){
	IfWinExist, %gGlob_Gui88Title%
	{
		Gui, 88:Minimize
	}
}


;アクティブでないなら隠す。　閉じるのではなく最小化させる
guaf_hideGui88NotActive(){
	IfWinNotActive , %gGlob_Gui88Title%
	{
		guaf_closeGui88()
	}
}

guaf_hideGui68NotActive(){
	IfWinNotActive , %gGlob_Gui68Title%
	{
		Gui, 68:Hide
	}
}

guaf_hideGui66NotActive(){
	IfWinNotActive , %gGlob_Gui66Title%
	{
		Gui, 66:Hide
	}
}

guaf_cleanBoxEdit66_1(){
	BoxEdit66_1 := guf_getControl( "BoxEdit66_1", 66 )
	tmpStr := Trim( BoxEdit66_1 )
	if(tmpStr == ""){
		return
	}
	gGlob_backUpBoxEdit66_1 = %BoxEdit66_1%
	GuiControl, 66:, BoxEdit66_1, %null%
}

guaf_returnBoxEdit66_1(){
	tmpBoxEdit66_1 := guf_getControl( "BoxEdit66_1", 66 )
	GuiControl, 66:, BoxEdit66_1, %gGlob_backUpBoxEdit66_1%
	gGlob_backUpBoxEdit66_1  = %tmpBoxEdit66_1%
}
