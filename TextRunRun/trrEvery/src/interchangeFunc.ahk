

intchf_showHotkeyListGui() {
	hoit_setCommShortLongKeyNameList("", 150, "List80_1", 80)
	hoit_setSystemHotkeyList("", 150, "List80_2", 80)
	Sleep, 200
	Gui, 80:Show
}

intchf_showHotkeyListGuiToggle(){
	IfWinExist, %gGlob_Gui80Title%
	{
		Gui, 80:Hide
	} else {
		intchf_showHotkeyListGui()
	}
}

intchf_tmpDelete(com2, pOut, GuiNum){
	helpStr := "-all  tmpフォルダのファイルを全て空に`n-gui  Guiの位置とサイズを保存するファイルをカラに`n-item  一時的に保存のアイテムを全てカラに`n-2gyo  一時的に保存の二行以上アイテムを全てカラに`n-hotkeyOnText  一時的に保存のテキスト上のキーを全て削除"
	if( edc_helpViewIfHyphenH(helpStr, com2, GuiNum) ){
		return
	}

	StringLower, com2, com2
	if(com2 == "-hotkeyOnText"){
		; 再起動が必要  一時的に保存のテキスト上のキーを全て削除
		hoit_tmpHotkeyDeleteFile()
	} else if(com2 == "-hotkeyAllGround"){
		; 再起動が必要  一時的に保存の常駐キーを全て削除
 		;hotitpf_tmpAllGroundDeleteFile()
	} else if(com2 == "-item"){
		if( ite_tmpItemDeleteObjectAndFile() ){
			guit_setExplain("一時的に保存したアイテムを削除", GuiNum)
		}
	} else if(com2 == "-2gyo"){
		if( musc_tmpMultipleItemDeleteObjectAndFile() ){
			guit_setExplain("一時的に保存した二行以上アイテムを削除", GuiNum)
		}
	} else if(com2 == "-gui"){
		if( outs_deleteAndMakeFile(gloco_userDir . glob_tmpAhkGuiSizePosFileName, gloco_userDir . glob_userTmpDirName) ){
			guit_setExplain("GUIの位置とサイズを保存したファイルを削除", GuiNum)
		}
	} else if(com2 == "-all"){
		buff =
		if( ite_tmpItemDeleteObjectAndFile() ){
			buff .= "一時的に保存したアイテムを削除`n"
		}
		if( musc_tmpMultipleItemDeleteObjectAndFile() ){
			buff .= "一時的に保存した二行以上アイテムを削除`n"
		}
		if( outs_deleteAndMakeFile(gloco_userDir . glob_tmpAhkGuiSizePosFileName, gloco_userDir . glob_userTmpDirName) ){
			buff .= "GUIの位置とサイズを保存したファイルを削除`n"
		}
		guit_setExplain(buff, GuiNum)
		;一時的に保存のホットキーを全て削除。再起動が必要なので、最後に
		MsgBox, 4097, 再起動の確認, キーの消去には再起動が必要になる。`nよろしいか?, 60
		IfMsgBox, OK
		{
			iniFile := gloco_userDir . glob_tmpHotkeyItemIniFileName
			file := gloco_userDir . glob_tmpHotkeyItemListName
			FileDelete, %iniFile%
			FileDelete, %file%

			;iniFile2 := gloco_userDir . glotaip_tmpAllGroundKeyIniFileName
			;file2 := gloco_userDir . glotaip_tmpAllGroundKeyListName
			;FileDelete, %iniFile2%
			;FileDelete, %file2%
			if( guit_checkErrorLevelOutput("一時的に保存したキーの削除の時にエラーあり") ){
				Sleep, 800
				Reload
			}
		}
	} else {
		guit_setExplainPurpose(helpStr, GuiNum)
	}
}
