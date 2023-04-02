

ita_autoPupupFileItemList( str, pControl, GuiNum=1 ) {
	static listStr =
	str := aut_checkDangerStr(str)
	listStr .= auts_pupupOnlyFolders(str, 30)
	listStr .= auts_pupupOnlyFiles(str, 30)
	listStr .= auts_pupupSoftObjNullIfStrNull(str, 30)
	listStr .= auts_pupupFolderObjNullIfStrNull(str, 30)
	listStr .= auts_pupupItemCommandObjNullIfStrNull(str, 30)
	listStr .= auts_pupupMultipleObjNullIfStrNull(str, 30)
	listStr .= auts_pupupSpecialWordNullIfStrNull(str, 30)
	listStr .= auts_pupupVariableWordNullIfStrNull(str, 30)
	listStr .= auts_pupupUserVariableWordNullIfStrNull(str, 10)
	listStr .= auts_pupupAhkCommNullIfStrNull(str, 30)
	listStr .= auts_pupupUserMakeWordNullIfStrNull(str, 30)
	
	if(listStr == "") {
		listStr = |
	}
	GuiControl,%GuiNum%: , %pControl%, %listStr%
	listStr = 
}

ita_autoPupupFileItemListForArgs( str, pControl, GuiNum=1 ) {
	static listStr =
	str := aut_checkDangerStr(str)
	str := auts_takeLastStr(str)
	listStr .= auts_pupupOnlyFolders(str, 30)
	listStr .= auts_pupupOnlyFiles(str, 30)
	listStr .= auts_pupupSoftObjNullIfStrNull(str, 30)
	listStr .= auts_pupupFolderObjNullIfStrNull(str, 30)
	listStr .= auts_pupupItemCommandObjNullIfStrNull(str, 30)
	listStr .= auts_pupupMultipleObjNullIfStrNull(str, 30)
	listStr .= auts_pupupSpecialWordNullIfStrNull(str, 30)
	listStr .= auts_pupupVariableWordNullIfStrNull(str, 30)
	listStr .= auts_pupupUserVariableWordNullIfStrNull(str, 10)
	listStr .= auts_pupupAhkCommNullIfStrNull(str, 30)
	listStr .= auts_pupupUserMakeWordNullIfStrNull(str, 30)
	
	if(listStr == "") {
		listStr = |
	}
	GuiControl,%GuiNum%: , %pControl%, %listStr%
	listStr = 
}


ita_autoPupupItemOnlyFolderList( str, pControl, GuiNum=1 ) {	;作業フォルダを選ぶとき使用
	static listStr =
	str := aut_checkDangerStr(str)
	listStr .= auts_pupupOnlyFolders(str, 30)
	listStr .= auts_pupupSoftObjNullIfStrNull(str, 30)
	listStr .= auts_pupupFolderObjNullIfStrNull(str, 30)
	listStr .= auts_pupupItemCommandObjNullIfStrNull(str, 30)

	if(listStr == "") {
		listStr = |
	}
	GuiControl,%GuiNum%: , %pControl%, %listStr%
	listStr = 
}


;入力補完の時 に Enter
ita_pushEnterFromList72( ) {
	GuiControlGet, OutputVar , 72:FocusV
	if(OutputVar == "Edit72_3") {			;Editにフォーカスが行ってる時
		if( aut_varSetFileItem("Edit72_3", 72, "List72_1", 72) ) {
			return True
		}
		return False
	} else if (OutputVar == "Edit72_4") {
		if( aut_varSetFileItem("Edit72_4", 72, "List72_2", 72) ) {
			return True
		}
		return False
	} else if (OutputVar == "Edit72_5") {
		if ( aut_varSetFileItem("Edit72_5", 72, "List72_3" ,72) ){
			return True
		}
		return False
	} else if (OutputVar == "List72_1") {			;Listに選択肢が行ってる時
		aut_varSetFileItem("Edit72_3", 72, "List72_1", 72)		; Editと違い絶対にTrueが返されるのでif文を減らしている
		return True
	} else if (OutputVar == "List72_2") {
		aut_varSetFileItem("Edit72_4", 72, "List72_2", 72)
		return True
	} else if (OutputVar == "List72_3") {
		aut_varSetFileItem("Edit72_5", 72, "List72_3" ,72)
		return True
	}

	return False
}


; エディットにカーソルがあるときPopupを表示
ita_pupUpShowGui72() {
	popY := guaf_anyOfNumFromDpi(13, 16, 19)
	if(glob_needReloadIniCommTitleNotFlag == False){
		subY := guaf_anyOfNumFromDpi(23, 29, 35)
		popY -= subY
	}

	GuiControlGet, OutputVar, 72:FocusV			; 入力補完を表示させる
	if(OutputVar == "Edit72_3") {
		aut_visiblePopUpList("List72_1", 72, 0, popY, 2)
	} else if (OutputVar == "Edit72_4") {
		aut_visiblePopUpList("List72_2", 72, 0, popY, 2)
	} else if (OutputVar == "Edit72_5") {
		aut_visiblePopUpList("List72_3", 72, 0, popY, 2)
	} else if(OutputVar == "List72_1") {
		GuiControl, 72:Focus, Edit72_3
	} else if(OutputVar == "List72_2") {
		GuiControl, 72:Focus, Edit72_4
	} else if(OutputVar == "List72_3") {
		GuiControl, 72:Focus, Edit72_5
	} else {
		ite_hideConfirmGui72()
	}
}

ita_gui72UpDownKey(key) {
	GuiControlGet, OutputVar, 72:FocusV
	if(OutputVar == "Edit72_3") {
		;うまく行かなかったためテスト版を使用する
		aut_controlKeyUpDownTestList1(False, key, "List72_1", 72)
		;aut_controlKeyUpDown(hwnd1, key, "List72_1", 72)
	} else if (OutputVar == "Edit72_4") {
		aut_controlKeyUpDownTestList2(False, key, "List72_2", 72)
		;aut_controlKeyUpDown(hwnd2, key, "List72_2", 72)
	} else if (OutputVar == "Edit72_5") {
		aut_controlKeyUpDownTestList3(False, key, "List72_3", 72)
		;aut_controlKeyUpDown(hwnd3, key, "List72_3", 72)
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

