

inv2pf_checkFileAndFolderMakePlus(){
	firstFfnDir = %glob_fromFileNameDir%\%glob_firstFfnDirNameOnly%
	IfNotExist, %firstFfnDir%
	{
		allGroundKeyDir = %glob_fromFileNameDir%\%glob_firstFfnDirNameOnly%%glotaip_allGroundKeyFfnDirName%
		func_easyFolderCheckMakeFolder(allGroundKeyDir)
		snippetDir = %glob_fromFileNameDir%\%glob_firstFfnDirNameOnly%%glotaip_snippetFfnDirName%
		func_easyFolderCheckMakeFolder(snippetDir)
	}
}

inv2pf_softWinTitleSetPlus(){
	gglobap_Gui90Title := "常時使用できるキーの登録_" . gGlob_GuiAllTitle
}

inv2pf_allGroundKeyItemObjSetting(tmpItem){

	; 一時的に保存のか、普通のに保存かを分ける
	file := gloco_userDir . glotaip_allGroundKeyListName
	iniFile := gloco_userDir . glotaip_allGroundKeyIniFileName
	if(tmpItem == 1){
		file := gloco_userDir . glotaip_tmpAllGroundKeyListName
		iniFile := gloco_userDir . glotaip_tmpAllGroundKeyIniFileName
	}

	Loop, Read, %file%
	{
		IniRead, out1, %iniFile%, %A_LoopReadLine%, scriptAllGround,    -1
		if(out1 != -1) {
			IfInString, out1, ###n
			{
				StringReplace, out1, out1, ###n , `n, All
			}
			IniRead, out2, %iniFile%, %A_LoopReadLine%, explanationAllGround, %A_Space%
			IfInString, out2, ###n
			{
				StringReplace, out2, out2, ###n , `n, All
			}
			IniRead, out3, %iniFile%, %A_LoopReadLine%, winTitleAllGround, %A_Space%
			IniRead, longKeyNameOnly, %iniFile%, %A_LoopReadLine%, longKeyOnlyAllGround, %A_Space%
			hotitpf_entryAllGroundKeyLogic(longKeyNameOnly, out1, out2, tmpItem, 1, "", 71, out3)
		}
	}
}
