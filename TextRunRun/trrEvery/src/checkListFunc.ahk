; 必須  glob guf 

chec_commStockListOnEscLogic(listNum, title, iniFile, closeFlag, GuiNum){
	if( glob_iniCommListCloseNotSaveFlag == False ){
		chec_commStockListSave(listNum, title, iniFile, closeFlag, GuiNum)
	}
}

chec_commStockListLoadBackupSave(listNum, iniFile, GuiNum) {
	MsgBox, 4129, やり直しの確認, Save時のバックアップを表示する？, 60
	IfMsgBox, OK
	{
		tmpBackupName := "_tmpBackupSave" . listNum
		chec_commStockListLoadLogic(tmpBackupName, iniFile, GuiNum)
	}
}

chec_commStockListLoadBackupLoad(listNum, iniFile, GuiNum) {
	MsgBox, 4129, やり直しの確認, Load時のバックアップを表示する？, 60
	IfMsgBox, OK
	{
		tmpBackupName := "_tmpBackupLoad" . listNum
		chec_commStockListLoadLogic(tmpBackupName, iniFile, GuiNum)
	}
}

chec_tmpBackUpCommStockList(listName, listNum, iniFile){
	;func_fileCheckMakeFolderAndFolder(iniFile, gloco_userDir)
	IniRead, OutTitle, %iniFile%, %listName%, titleEdit , %A_Space%
	IniRead, Out1, %iniFile%, %listName%, Edit_1 , %A_Space%
	IniRead, Out2, %iniFile%, %listName%, Edit_2 , %A_Space%
	IniRead, Out3, %iniFile%, %listName%, Edit_3 , %A_Space%
	IniRead, Out4, %iniFile%, %listName%, Edit_4 , %A_Space%
	IniRead, Out5, %iniFile%, %listName%, Edit_5 , %A_Space%
	IniRead, Out6, %iniFile%, %listName%, Edit_6 , %A_Space%
	IniRead, Out7, %iniFile%, %listName%, Edit_7 , %A_Space%
	IniRead, Out8, %iniFile%, %listName%, Edit_8 , %A_Space%
	IniRead, Out9, %iniFile%, %listName%, Edit_9 , %A_Space%
	IniRead, Out10, %iniFile%, %listName%, Edit_10 , %A_Space%
	tmpBackupName := "_tmpBackupSave" . listNum

	func_folderCheckMakeFolder(gloco_userDir)
	OutTitle := Trim(OutTitle)
	IniWrite, %OutTitle%, %iniFile%, %tmpBackupName%, titleEdit
	IniWrite, %Out1%, %iniFile%, %tmpBackupName%, Edit_1
	IniWrite, %Out2%, %iniFile%, %tmpBackupName%, Edit_2
	IniWrite, %Out3%, %iniFile%, %tmpBackupName%, Edit_3
	IniWrite, %Out4%, %iniFile%, %tmpBackupName%, Edit_4
	IniWrite, %Out5%, %iniFile%, %tmpBackupName%, Edit_5
	IniWrite, %Out6%, %iniFile%, %tmpBackupName%, Edit_6
	IniWrite, %Out7%, %iniFile%, %tmpBackupName%, Edit_7
	IniWrite, %Out8%, %iniFile%, %tmpBackupName%, Edit_8
	IniWrite, %Out9%, %iniFile%, %tmpBackupName%, Edit_9
	IniWrite, %Out10%, %iniFile%, %tmpBackupName%, Edit_10
}

chec_commStockListSave(listNum, title, iniFile, closeFlag, GuiNum) {
	if(listNum != ""){
		title := Trim(title)
		listName := "type" . listNum
		chec_tmpBackUpCommStockList(listName, listNum, iniFile)
		chec_commStockListSaveLogic(listName, title, iniFile, GuiNum)
		; タイトル名の保存
		IniWrite, %title%, %iniFile%, __listTitle, titleName%listNum%
		res := guit_checkErrorLevelOutput(listName  . " のリストの保存時に`n何らかのエラーがあります。")
		if(res) {
			if( closeFlag ){
				guit_setExplainNotShow("コマンド一覧の`n" . listName . "  をセーブした", 63)
			} else {
				timf_toolTipFuncOptionPos(listName  . " に保存")
			}
		}

		;リストを更新
		chec_changeStockListTitle(iniFile, GuiNum)
		;今のリストを選択状態に
		pControlList := "ListBox" . GuiNum  . "_1"
		guf_GuiControl(pControlList, GuiNum, "Choose", listNum)
		guit_checkErrorLevelOutput("リスト の更新時にエラーあり")
	} else {
		guit_appendExplain("保存するリストが選ばれていない")
	}
}

chec_commStockListSaveLogic(listName, title, iniFile, GuiNum) {
	pControlName := "Edit" . GuiNum
	edit1 := guf_getControl( pControlName . "_1", GuiNum )
	edit2 := guf_getControl( pControlName . "_2", GuiNum )
	edit3 := guf_getControl( pControlName . "_3", GuiNum )
	edit4 := guf_getControl( pControlName . "_4", GuiNum )
	edit5 := guf_getControl( pControlName . "_5", GuiNum )
	edit6 := guf_getControl( pControlName . "_6", GuiNum )
	edit7 := guf_getControl( pControlName . "_7", GuiNum )
	edit8 := guf_getControl( pControlName . "_8", GuiNum )
	edit9 := guf_getControl( pControlName . "_9", GuiNum )
	edit10 := guf_getControl( pControlName . "_10", GuiNum )

	func_folderCheckMakeFolder(gloco_userDir)
	IniWrite, %title%, %iniFile%, %listName%, titleEdit
	IniWrite, %edit1%, %iniFile%, %listName%, Edit_1
	IniWrite, %edit2%, %iniFile%, %listName%, Edit_2
	IniWrite, %edit3%, %iniFile%, %listName%, Edit_3
	IniWrite, %edit4%, %iniFile%, %listName%, Edit_4
	IniWrite, %edit5%, %iniFile%, %listName%, Edit_5
	IniWrite, %edit6%, %iniFile%, %listName%, Edit_6
	IniWrite, %edit7%, %iniFile%, %listName%, Edit_7
	IniWrite, %edit8%, %iniFile%, %listName%, Edit_8
	IniWrite, %edit9%, %iniFile%, %listName%, Edit_9
	IniWrite, %edit10%, %iniFile%, %listName%, Edit_10
}

chec_commStockListLoad(listNum, title, iniFile, GuiNum) {
	listName := "type" . listNum
	if(listNum != ""){
		MsgBox, 4129, 読み込みの確認, %listName% を表示していい？, 60
		IfMsgBox, OK
		{
			tmpBackupName := "_tmpBackupLoad" . listNum
			title := Trim(title)
			chec_commStockListSaveLogic(tmpBackupName, title, iniFile, GuiNum)
			chec_commStockListLoadLogic(listName, iniFile, GuiNum)
		}
	} else {
		guit_appendExplain("読み出すリストが選ばれていない")
	}
}

chec_commStockListLoadLogic(listName, iniFile, GuiNum){
	;func_fileCheckMakeFolderAndFolder(iniFile, gloco_userDir)
	IniRead, OutTitle, %iniFile%, %listName%, titleEdit , %A_Space%
	IniRead, Out1, %iniFile%, %listName%, Edit_1 , %A_Space%
	IniRead, Out2, %iniFile%, %listName%, Edit_2 , %A_Space%
	IniRead, Out3, %iniFile%, %listName%, Edit_3 , %A_Space%
	IniRead, Out4, %iniFile%, %listName%, Edit_4 , %A_Space%
	IniRead, Out5, %iniFile%, %listName%, Edit_5 , %A_Space%
	IniRead, Out6, %iniFile%, %listName%, Edit_6 , %A_Space%
	IniRead, Out7, %iniFile%, %listName%, Edit_7 , %A_Space%
	IniRead, Out8, %iniFile%, %listName%, Edit_8 , %A_Space%
	IniRead, Out9, %iniFile%, %listName%, Edit_9 , %A_Space%
	IniRead, Out10, %iniFile%, %listName%, Edit_10 , %A_Space%

	pControlName := "Edit" . GuiNum
	pControlTitle := "Edit" . GuiNum  . "_11"
	guf_setControl( OutTitle, pControlTitle, GuiNum )

	if(glob_iniChangeStockInsertNotFlag == False){
		; 空白なら　&stockChangeGreen　を入れる
		Out1 := Trim(Out1)
		Out2 := Trim(Out2)
		if(GuiNum == 77){
			if(Out1 == ""){
				Out1 := "&stockChangeGreen 1 %--"
			}
			if(Out2 == ""){
				Out2 := "&stockChangeGreen"
			}
		}
		if(GuiNum == 78){
			if(Out1 == ""){
				Out1 := "&stockChangeBlue 1 %--"
			}
			if(Out2 == ""){
				Out2 := "&stockChangeBlue"
			}
		}
	}

	guf_setControl( Out1, pControlName . "_1", GuiNum )
	guf_setControl( Out2, pControlName . "_2", GuiNum )

	guf_setControl( Out3, pControlName . "_3", GuiNum )
	guf_setControl( Out4, pControlName . "_4", GuiNum )
	guf_setControl( Out5, pControlName . "_5", GuiNum )
	guf_setControl( Out6, pControlName . "_6", GuiNum )
	guf_setControl( Out7, pControlName . "_7", GuiNum )
	guf_setControl( Out8, pControlName . "_8", GuiNum )
	guf_setControl( Out9, pControlName . "_9", GuiNum )
	guf_setControl( Out10, pControlName . "_10", GuiNum )

	if(OutTitle == ""){
		OutTitle := listName
	}
	return OutTitle
}

chec_changeStockListTitle(iniFile, GuiNum){
	;func_fileCheckMakeFolderAndFolder(iniFile, gloco_userDir)
	buff := "|"
	Loop , 30
	{
		IniRead, titleTmp, %iniFile%, __listTitle, titleName%A_Index% , type%A_Index%
		titleTmp := Trim(titleTmp)
		if(titleTmp == ""){
			titleTmp := "type" . A_Index
		}
		if(A_Index == 1){
			buff .= titleTmp  . "|"
		} else {
			buff .= "|" . titleTmp
		}
	}

	buff := RTrim(buff, "|")
	pControlList := "ListBox" . GuiNum  . "_1"
	guf_setControl( buff, pControlList, GuiNum )
}




chec_stockSaveOnCommand(pList, pEditTitle, stockGuiNum, fileName){
	listValue := guf_getControl( pList, stockGuiNum )
	editValue := guf_getControl( pEditTitle, stockGuiNum )

	chec_commStockListSave(listValue, editValue, fileName, False, stockGuiNum)
}
