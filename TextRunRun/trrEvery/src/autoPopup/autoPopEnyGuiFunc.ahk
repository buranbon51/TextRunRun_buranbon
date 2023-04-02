; 必須 glob outs
; aut auts


;入力補完の時
autg_pushEnterFromListEditss(GuiNum) {
	pEdit1 := "Edit" . GuiNum  . "_1"
	pEdit2 := "Edit" . GuiNum  . "_2"
	pEdit3 := "Edit" . GuiNum  . "_3"
	pEdit4 := "Edit" . GuiNum  . "_4"
	pEdit5 := "Edit" . GuiNum  . "_5"
	pList1 :=  "List" . GuiNum  . "_1"
	pList2 :=  "List" . GuiNum  . "_2"
	pList3 :=  "List" . GuiNum  . "_3"
	pList4 :=  "List" . GuiNum  . "_4"
	pList5 :=  "List" . GuiNum  . "_5"
	pButton1 :=  "Button" . GuiNum  . "_1"
	OutputVar := func_focusVGet(GuiNum)
	if(OutputVar == pEdit1) {			;Editにフォーカスが行ってる時
		if( aut_varSetItem(pEdit1, pList1, GuiNum) ) {
			return True
		}
		return False
	} else if (OutputVar == pEdit2) {
		if( aut_varSetFileItem(pEdit2, GuiNum, pList2, GuiNum) ) {
			return True
		}
		return False
	} else if (OutputVar == pEdit3) {
		if ( aut_varSetFileItem(pEdit3, GuiNum, pList3 ,GuiNum) ){
			return True
		}
		return False
	} else if (OutputVar == pEdit4) {
		if ( aut_varSetFileItem(pEdit4, GuiNum, pList4 ,GuiNum) ){
			return True
		}
		return False
	} else if (OutputVar == pEdit5) {
		if ( aut_varSetFileItem(pEdit5, GuiNum, pList5 ,GuiNum) ){
			return True
		}
		return False
	} else if (OutputVar == pList1) {			;Listに選択肢が行ってる時
		aut_varSetItem(pEdit1, pList1, GuiNum)		; Editと違い絶対にTrueが返されるのでif文を減らしている
		return True
	} else if (OutputVar == pList2) {
		aut_varSetFileItem(pEdit2, GuiNum, pList2, GuiNum)
		return True
	} else if (OutputVar == pList3) {
		aut_varSetFileItem(pEdit3, GuiNum, pList3 ,GuiNum)
		return True
	} else if (OutputVar == pList4) {
		aut_varSetFileItem(pEdit4, GuiNum, pList4 ,GuiNum)
		return True
	} else if (OutputVar == pList5) {
		aut_varSetFileItem(pEdit5, GuiNum, pList5 ,GuiNum)
		return True
	} else if (OutputVar == pButton1) {
		; ボタンにフォーカスがあり、入力補完が表示されていたら、それを決定する。
		if( autg_focusButtonIfListVisible(pList1, pList2, pList3, pList4, pList5, GuiNum) ){
			return True
		}
	}

	return False
}

autg_focusButtonIfListVisible(pList1, pList2, pList3, pList4, pList5, GuiNum){
	pEdit =
	GuiControlGet, OutputVar , %GuiNum%:Visible, %pList5%
	if(OutputVar == 1) {
		pEdit := "Edit" . GuiNum  . "_5"
		aut_varSetFileItem(pEdit, GuiNum, pList5, GuiNum)
		return True
	}
	GuiControlGet, OutputVar , %GuiNum%:Visible, %pList4%
	if(OutputVar == 1) {
		pEdit := "Edit" . GuiNum  . "_4"
		aut_varSetFileItem(pEdit, GuiNum, pList4, GuiNum)
		return True
	}
	GuiControlGet, OutputVar , %GuiNum%:Visible, %pList3%
	if(OutputVar == 1) {
		pEdit := "Edit" . GuiNum  . "_3"
		aut_varSetFileItem(pEdit, GuiNum, pList3, GuiNum)
		return True
	}
	GuiControlGet, OutputVar , %GuiNum%:Visible, %pList2%
	if(OutputVar == 1) {
		pEdit := "Edit" . GuiNum  . "_2"
		aut_varSetFileItem(pEdit, GuiNum, pList2, GuiNum)
		return True
	}
	GuiControlGet, OutputVar , %GuiNum%:Visible, %pList1%
	if(OutputVar == 1) {
		pEdit := "Edit" . GuiNum  . "_1"
		aut_varSetItem(pEdit, pList1, GuiNum)
		return True
	}
	return False
}

autg_editssUpDownKey(GuiNum, key) {
	pEdit1 := "Edit" . GuiNum  . "_1"
	pEdit2 := "Edit" . GuiNum  . "_2"
	pEdit3 := "Edit" . GuiNum  . "_3"
	pEdit4 := "Edit" . GuiNum  . "_4"
	pEdit5 := "Edit" . GuiNum  . "_5"
	pList1 :=  "List" . GuiNum  . "_1"
	pList2 :=  "List" . GuiNum  . "_2"
	pList3 :=  "List" . GuiNum  . "_3"
	pList4 :=  "List" . GuiNum  . "_4"
	pList5 :=  "List" . GuiNum  . "_5"
	GuiControlGet, OutputVar, %GuiNum%:FocusV
	if(OutputVar == pEdit1) {
		;うまく行かなかったためテスト版を使用する
		aut_controlKeyUpDownTestList1(False, key, pList1, GuiNum)
		;aut_controlKeyUpDown(hwnd1, key, pList1, GuiNum)
	} else if (OutputVar == pEdit2) {
		aut_controlKeyUpDownTestList2(False, key, pList2, GuiNum)
		;aut_controlKeyUpDown(hwnd2, key, pList2, GuiNum)
	} else if (OutputVar == pEdit3) {
		aut_controlKeyUpDownTestList3(False, key, pList3, GuiNum)
		;aut_controlKeyUpDown(hwnd3, key, pList3, GuiNum)
	} else if (OutputVar == pEdit4) {
		aut_controlKeyUpDownTestList4(False, key, pList4, GuiNum)
	} else if (OutputVar == pEdit5) {
		aut_controlKeyUpDownTestList5(False, key, pList5, GuiNum)
	} else {
		if(key == 1) {
			Send, {Blind}{Up}
		} else if(key == 2) {
			Send, {Blind}{Down}
		} else if(key == 3) {
			Send, {Blind}{PgUp}
		} else if(key == 4) {
			Send, {Blind}{PgDn}
		} else if(key == 5) {
			Send, {Blind}{Home}
		} else {
			guit_errorAppend("key_notFound")
		}
	}
}


; エディットにカーソルがあるときPopupを表示
autg_pupUpShowEditss(GuiNum, pupNum, viewType, notAutoFlag) {
	popY := guaf_anyOfNumFromDpi(12, 17, 22)
	if(glob_needReloadIniCommTitleNotFlag == False){
		subY := guaf_anyOfNumFromDpi(22, 28, 34)
		popY -= subY
	}
	if(glob_needReloadIniCommMenuNotFlag == False){
		subY := guaf_anyOfNumFromDpi(20, 26, 32)
		popY -= subY
	}

	; 自動で入力補完を表示する設定で動作をかえる
	if( notAutoFlag ){
		glob_pupupNum = %pupNum%
	}

	pEdit1 := "Edit" . GuiNum  . "_1"
	pEdit2 := "Edit" . GuiNum  . "_2"
	pEdit3 := "Edit" . GuiNum  . "_3"
	pEdit4 := "Edit" . GuiNum  . "_4"
	pEdit5 := "Edit" . GuiNum  . "_5"
	pList1 :=  "List" . GuiNum  . "_1"
	pList2 :=  "List" . GuiNum  . "_2"
	pList3 :=  "List" . GuiNum  . "_3"
	pList4 :=  "List" . GuiNum  . "_4"
	pList5 :=  "List" . GuiNum  . "_5"
	GuiControlGet, OutputVar, %GuiNum%:FocusV			; 入力補完を表示させる
	if(OutputVar == pEdit1) {
		editVar := guf_getControl( pEdit1, GuiNum )
		if( notAutoFlag ){
			auts_autoPouUpListSyscommUserMakeWord( editVar, pList1, GuiNum)
			aut_visiblePopUpList(pList1, GuiNum, -5, popY, viewType)
			return
		}
		if(editVar != ""){
			aut_visiblePopUpList(pList1, GuiNum, -5, popY, viewType)
		}
	} else if (OutputVar == pEdit2) {
		editVar := guf_getControl( pEdit2, GuiNum )
		if( notAutoFlag ){
			editVar := outs_textOutDqAllTrim(editVar)
			editVar := aut_checkDangerStr(editVar)
			auts_popUpEny( editVar, pList2, GuiNum)
			aut_visiblePopUpList(pList2, GuiNum, -5, popY, viewType)
			return
		}
		if(editVar != ""){
			aut_visiblePopUpList(pList2, GuiNum, -5, popY, viewType)
		}
	} else if (OutputVar == pEdit3) {
		editVar := guf_getControl( pEdit3, GuiNum )
		if( notAutoFlag ){
			editVar := outs_textOutDqAllTrim(editVar)
			editVar := aut_checkDangerStr(editVar)
			auts_popUpEny( editVar, pList3, GuiNum)
			aut_visiblePopUpList(pList3, GuiNum, -5, popY, viewType)
			return
		}
		if(editVar != ""){
			aut_visiblePopUpList(pList3, GuiNum, -5, popY, viewType)
		}
	} else if (OutputVar == pEdit4) {
		editVar := guf_getControl( pEdit4, GuiNum )
		if( notAutoFlag ){
			editVar := outs_textOutDqAllTrim(editVar)
			editVar := aut_checkDangerStr(editVar)
			auts_popUpEny( editVar, pList4, GuiNum)
			aut_visiblePopUpList(pList4, GuiNum, -5, popY, viewType)
			return
		}
		if(editVar != ""){
			aut_visiblePopUpList(pList4, GuiNum, -5, popY, viewType)
		}
	} else if (OutputVar == pEdit5) {
		editVar := guf_getControl( pEdit5, GuiNum )
		if( notAutoFlag ){
			editVar := outs_textOutDqAllTrim(editVar)
			editVar := aut_checkDangerStr(editVar)
			auts_popUpEny( editVar, pList5, GuiNum)
			aut_visiblePopUpList(pList5, GuiNum, -5, popY, viewType)
			return
		}
		if(editVar != ""){
			aut_visiblePopUpList(pList5, GuiNum, -5, popY, viewType)
		}
	} else if(OutputVar == pList1) {
		GuiControl, %GuiNum%:Focus, %pEdit1%
	} else if(OutputVar == pList2) {
		GuiControl, %GuiNum%:Focus, %pEdit2%
	} else if(OutputVar == pList3) {
		GuiControl, %GuiNum%:Focus, %pEdit3%
	} else if(OutputVar == pList4) {
		GuiControl, %GuiNum%:Focus, %pEdit4%
	} else if(OutputVar == pList5) {
		GuiControl, %GuiNum%:Focus, %pEdit5%
	} else {
		guaf_listVisibleEditss(GuiNum)
	}
}

