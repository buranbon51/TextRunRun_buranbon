; 必須 glob guf
; aut  heard


auts_popUpEny( str, pControl, GuiNum) {
	if(glob_pupupNum == 1) {
		auts_autoPopUpFileItemList( str, pControl, GuiNum )
	} else if (glob_pupupNum == 2) {
		auts_autoPopUpSoftObjList( str, pControl, GuiNum )
	} else if (glob_pupupNum == 3) {
		auts_autoPupupFileList( str, pControl, GuiNum )
	} else if (glob_pupupNum == 4) {
		auts_autoPopUpFolderObjList( str, pControl, GuiNum )
	} else if (glob_pupupNum == 5) {
		auts_autoPopUpitemCommandObjList( str, pControl, GuiNum )
	} else if (glob_pupupNum == 6) {
		auts_autoPopHistoryList( str, pControl, GuiNum )
	} else if (glob_pupupNum == 7) {
		auts_autoPopHistoryFilterList( str, pControl, GuiNum )
	} else if (glob_pupupNum == 8) {
		auts_autoPouUpListUserMakeWordFilter( str, pControl, GuiNum )
	} else if (glob_pupupNum == 9) {
		auts_autoPouUpListSpecialWord( str, pControl, GuiNum )
	}
}

auts_autoPopUpFileItemList( str, pControl, GuiNum=1 ) {
	;static listStr =
	listStr =
	str := auts_takeLastStr(str)
	listStr .= auts_pupupSnippetInteriorNullIfStrNull(str)
	listStr .= auts_pupupSnippetObjNullIfStrNull(str, 30)
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
	listStr .= auts_pupupHistoryObj(str, 100)
	listStr .= auts_pupupUserMakeWordNullIfStrNull(str, 30)
	listStr .= auts_pupupOptionVariableWordNullIfStrNull(str, 30)
	listStr .= auts_pupupOptionSetterFuncWordNullIfStrNull(str, 30)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
	;listStr = 
}


auts_autoPopUpSoftObjList( str, pControl, GuiNum=1 ) {
	;static listStr =
	listStr =
	str := auts_takeLastStr(str)
	listStr .= auts_pupupSoftObj(str, 30)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
	;listStr = 
}

auts_autoPopUpFolderObjList( str, pControl, GuiNum=1 ) {
	;static listStr =
	listStr =
	str := auts_takeLastStr(str)
	listStr .= auts_pupupFolderObj(str, 30)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
	;listStr = 
}

auts_autoPopUpitemCommandObjList( str, pControl, GuiNum=1 ) {
	;static listStr =
	listStr =
	str := auts_takeLastStr(str)
	listStr .= auts_pupupItemCommandObj(str, 30)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
	;listStr = 
}


auts_autoPupupFileList( str, pControl, GuiNum=1 ) {
	;static listStr =
	listStr =
	str := auts_takeLastStr(str)
	listStr .= auts_pupupOnlyFolders(str, 30)
	listStr .= auts_pupupOnlyFiles(str, 30)

	if(listStr == "") {
		listStr = |
	}
	GuiControl,%GuiNum%: , %pControl%, %listStr%
	;listStr = 
}

auts_autoPupupOnlyFolderList( str, pControl, GuiNum=1 ) {	;作業フォルダを選ぶとき使用
	;static listStr =
	listStr =
	str := auts_takeLastStr(str)
	listStr .= auts_pupupOnlyFolders(str, 30)
	if(listStr == "") {
		listStr = |
	}
	GuiControl,%GuiNum%: , %pControl%, %listStr%
	;listStr = 
}


auts_pupupSoftObj(str, maxCount){
	softStr =
	count = 1
	for key, optionObj in glob_softObj {
		if(key != "") {
			if( RegExMatch(key, "i)^"str) )
			{
				softStr .= "|" . key
				if(count >= maxCount){
					softStr := RTrim(softStr, "|")
					return  softStr
				}
				count++
			}
		}
	}
	softStr := RTrim(softStr, "|")
	return  softStr
}

auts_pupupSoftObjNullIfStrNull(str, maxCount){
	if(str == ""){
		listStr =
		return listStr
	}
	listStr := auts_pupupSoftObj(str, maxCount)
	return listStr
}

auts_pupupFolderObj(str, maxCount){
	folderStr =
	count = 1
	for key, optionObj in glob_folderObj {
		if(key != "") {
			if( RegExMatch(key, "i)^"str) )
			{
				folderStr .= "|" .  key
				if(count >= maxCount){
					folderStr := RTrim(folderStr, "|")
					return  folderStr
				}
				count++
			}
		}
	}
	folderStr := RTrim( folderStr, "|")
	return  folderStr
}

auts_pupupFolderObjNullIfStrNull(str, maxCount){
	if(str == ""){
		listStr =
		return listStr
	}
	listStr := auts_pupupFolderObj(str, maxCount)
	return listStr
}

auts_pupupItemCommandObj(str, maxCount){
	itemComStr =
	count = 1
	for key, optionObj in glob_itemCommandObj {
		if(key != "") {
			if( RegExMatch(key, "i)^"str) )
			{
				itemComStr .= "|" .  key
				if(count >= maxCount){
					itemComStr := RTrim(itemComStr, "|")
					return  itemComStr
				}
				count++
			}
		}
	}
	itemComStr := RTrim( itemComStr, "|" )
	return  itemComStr
}

auts_pupupItemCommandObjNullIfStrNull(str, maxCount){
	if(str == ""){
		listStr =
		return listStr
	}
	listStr := auts_pupupItemCommandObj(str, maxCount)
	return listStr
}

auts_pupupMultipleObj(str, maxCount){
	fileStr =
	count = 1
	for key, optionObj in glob_multipleObj {
		if(key != "") {
			if( RegExMatch(key, "i)^"str) )
			{
				fileStr .= "|" .  key
				if(count >= maxCount){
					fileStr := RTrim(fileStr, "|")
					return  fileStr
				}
				count++
			}
		}
	}
	fileStr := RTrim( fileStr, "|" )
	return  fileStr
}

auts_pupupMultipleObjNullIfStrNull(str, maxCount){
	if(str == ""){
		listStr =
		return listStr
	}
	listStr := auts_pupupMultipleObj(str, maxCount)
	return listStr
}


auts_pupupOnlyFiles(str, maxCount) {
	fileStr =
	count = 1
	Loop, %str%*, 0, 0
	{
		if(A_LoopFileName != ""){
			fileStr .= "|" .  A_LoopFileName
			if(count >= maxCount){
				fileStr := RTrim(fileStr, "|")
				return  fileStr
			}
			count++
		}
	}
	fileStr := RTrim( fileStr, "|" )
	return  fileStr
}

auts_pupupOnlyFolders(str, maxCount) {			; フォルダ名の後に\をつけるため
	fileStr =
	count = 1
	Loop, %str%*, 2, 0
	{
		if(A_LoopFileName != ""){
			fileStr .= "|" .  A_LoopFileName . "\"
			if(count >= maxCount){
				fileStr := RTrim(fileStr, "|")
				return  fileStr
			}
			count++
		}
	}
	fileStr := RTrim( fileStr, "|" )
	return  fileStr
}

auts_autoPouUpListSyscomm( str, pControl, GuiNum=1 ) {
	;static listStr =
	listStr =
	str := auts_takeLastStr(str)		; 一工夫  最後の文字から入力補完の判定をさせるため必要

	listStr .=  auts_pupupSysComm(str, 30)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
	;listStr = 
}

auts_autoPouUpListSyscommUserMakeWord( str, pControl, GuiNum ) {
	;static listStr =
	listStr =
	str := auts_takeLastStr(str)		; 一工夫  最後の文字から入力補完の判定をさせるため必要
	listStr .=  auts_pupupSysComm(str, 30)
	listStr .=  auts_pupupUserMakeWordNullIfStrNull(str, 30)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
	;listStr = 
}

auts_pupupSysComm(str, maxCount) {
	sysStr =
	count = 1
	for key, optionObj in glob_sysCommObj {
		if(key != "") {
			if( RegExMatch(key, "i)^"str) )
			{
				sysStr .= "|" . key
				if(count >= maxCount){
					sysStr := RTrim(sysStr, "|")
					return  sysStr
				}
				count++
			}
		}
	}
	sysStr := RTrim(sysStr, "|")
	return  sysStr
}

auts_pupupSysCommNullIfStrNull(str, maxCount){
	if(str == ""){
		listStr =
		return listStr
	}
	listStr := auts_pupupSysComm(str, maxCount)
	return listStr
}

auts_pupupAhkComm(str, maxCount) {
	sysStr =
	count = 1
	for key, value in glob_ahkCommObj {
		if(value != "") {
			if( RegExMatch(value, "i)^"str) )
			{
				sysStr .= "|" . value
				if(count >= maxCount){
					sysStr := RTrim(sysStr, "|")
					return  sysStr
				}
				count++
			}
		}
	}
	sysStr := RTrim(sysStr, "|")
	return  sysStr
}

auts_pupupAhkCommNullIfStrNull(str, maxCount){
	if(str == ""){
		listStr =
		return listStr
	}
	listStr := auts_pupupAhkComm(str, maxCount)
	return listStr
}

auts_autoPouUpListSpecialWord( str, pControl, GuiNum=1 ) {
	;static listStr =
	listStr =
	str := auts_takeLastStr(str)		; 一工夫  最後の文字から入力補完の判定をさせるため必要

	listStr .=  auts_pupupSpecialWord(str, 30)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
	;listStr = 
}

auts_pupupSpecialWord(str, maxCount) {
	sysStr =
	count = 1
	for key, optionObj in glob_specialWordObj {
		if(key != "") {
			if( RegExMatch(key, "i)^"str) )
			{
				sysStr .= "|" . key
				if(count >= maxCount){
					sysStr := RTrim(sysStr, "|")
					return  sysStr
				}
				count++
			}
		}
	}
	sysStr := RTrim(sysStr, "|")
	return  sysStr
}

auts_pupupSpecialWordNullIfStrNull(str, maxCount){
	if(str == ""){
		listStr =
		return listStr
	}
	listStr := auts_pupupSpecialWord(str, maxCount)
	return listStr
}

auts_pupupVariableWord(str, maxCount) {
	sysStr =
	count = 1
	for key, value in glob_variableWordObj {
		if(value != "") {
			if( RegExMatch(value, "i)^"str) )
			{
				sysStr .= "|" . value
				if(count >= maxCount){
					sysStr := RTrim(sysStr, "|")
					return  sysStr
				}
				count++
			}
		}
	}
	sysStr := RTrim(sysStr, "|")
	return  sysStr
}

auts_pupupVariableWordNullIfStrNull(str, maxCount){
	if(str == ""){
		listStr =
		return listStr
	}
	listStr := auts_pupupVariableWord(str, maxCount)
	return listStr
}

auts_pupupUserVariableWord(str, maxCount) {
	sysStr =
	count = 1
	for key, value in glob_userVariableWordObj {
		if(value != "") {
			if( RegExMatch(value, "i)^"str) )
			{
				sysStr .= "|" . value
				if(count >= maxCount){
					sysStr := RTrim(sysStr, "|")
					return  sysStr
				}
				count++
			}
		}
	}
	sysStr := RTrim(sysStr, "|")
	return  sysStr
}

auts_pupupUserVariableWordNullIfStrNull(str, maxCount){
	if(str == ""){
		listStr =
		return listStr
	}
	listStr := auts_pupupUserVariableWord(str, maxCount)
	return listStr
}

auts_autoPouUpListUserMakeWordFilter( str, pControl, GuiNum ) {
	;static listStr =
	listStr =
	str := auts_takeLastStr(str)		; 一工夫  最後の文字から入力補完の判定をさせるため必要

	listStr .=  auts_pupupUserMakeWordFilterNullIfStrNull(str, 30)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
	;listStr = 
}

auts_pupupUserMakeWord(str, maxCount) {
	listStr =
	count = 1
	for key, optionObj in glob_userMakeWordObj {
		if(key != "") {
			if( RegExMatch(key, "i)^"str) )
			{
				listStr .= "|" . key
				if(count >= maxCount){
					listStr := RTrim(listStr, "|")
					return  listStr
				}
				count++
			}
		}
	}
	listStr := RTrim(listStr, "|")
	return  listStr
}

auts_pupupUserMakeWordNullIfStrNull(str, maxCount){
	if(str == ""){
		listStr =
		return listStr
	}
	listStr := auts_pupupUserMakeWord(str, maxCount)
	return listStr
}

auts_pupupUserMakeWordFilterNullIfStrNull(str, maxCount) {
	listStr =
	count = 1

	if(str == ""){
		return ""
	}
	StringLower, str, str

	for key, optionObj in glob_userMakeWordObj {
		if(key != "") {
			StringLower, lowkey, key
			IfInString, lowkey, %str%
			{
				listStr .= "|" . key
				if(count >= maxCount){
					listStr := RTrim(listStr, "|")
					return  listStr
				}
				count++
			}
		}
	}
	listStr := RTrim(listStr, "|")
	return  listStr
}

auts_pupupOptionVariableWord(str, maxCount){
	listStr =
	count = 1
	for key, optionObj in glob_optionVariableWordObj {
		if(key != "") {
			if( RegExMatch(key, "i)^"str) )
			{
				listStr .= "|" . key
				if(count >= maxCount){
					listStr := RTrim(listStr, "|")
					return  listStr
				}
				count++
			}
		}
	}
	listStr := RTrim(listStr, "|")
	return  listStr
}

auts_pupupOptionVariableWordNullIfStrNull(str, maxCount){
	if(str == ""){
		listStr =
		return listStr
	}
	listStr := auts_pupupOptionVariableWord(str, maxCount)
	return listStr
}

auts_pupupOptionSetterFuncWord(str, maxCount){
	listStr =
	count = 1
	for key, value in glob_optionSetterFuncWordObj {
		if(value != "") {
			if( RegExMatch(value, "i)^"str) )
			{
				listStr .= "|" . value
				if(count >= maxCount){
					listStr := RTrim(listStr, "|")
					return  listStr
				}
				count++
			}
		}
	}
	listStr := RTrim(listStr, "|")
	return  listStr
}

auts_pupupOptionSetterFuncWordNullIfStrNull(str, maxCount){
	if(str == ""){
		listStr =
		return listStr
	}
	listStr := auts_pupupOptionSetterFuncWord(str, maxCount)
	return listStr
}

auts_pupupCommShortLongKeyName(str, maxCount) {
	listStr =
	count = 1
	for key, value in glob_commShortLongKeyNameObj {
		if(key != "") {
			if( RegExMatch(key, "i)^"str) )
			{
				listStr .= "|" . key
				if(count >= maxCount){
					listStr := RTrim(listStr, "|")
					return  listStr
				}
				count++
			}
		}
	}
	listStr := RTrim(listStr, "|")
	return  listStr
}

auts_pupupSnippetObj(str, maxCount){
	listStr =
	count = 1
	for key, optionObj in glob_snippetObj {
		if(key != "") {
			if( RegExMatch(key, "i)^"str) )
			{
				StringUpper, keyUpper, key
				listStr .= "|" .  keyUpper
				if(count >= maxCount){
					listStr := RTrim(listStr, "|")
					return  listStr
				}
				count++
			}
		}
	}
	listStr := RTrim( listStr, "|" )
	return  listStr
}

auts_pupupSnippetObjNullIfStrNull(str, maxCount){
	listStr =
	if(str == ""){
		return listStr
	}

	listStr := auts_pupupSnippetObj(str, maxCount)
	return  listStr
}

auts_pupupSnippetInteriorNullIfStrNull(str){
	if(str == ""){
		return ""
	}

	if( IsObject( glob_snippetObj[str] ) ){
		optionObj := glob_snippetObj[str]
		listStr := "|" .  optionObj[1]
		if( optionObj[3] ){
			listStr .= " "
		}
		return  listStr
	}
	return  ""
}

auts_pupupHistoryObj(str, maxCount){
	historyStr =
	count = 1
	for key, optionObj in glob_historyObj {
		if(optionObj != "") {
			if( RegExMatch(optionObj, "i)^"str) )
			{
				historyStr .= "|" .  optionObj
				if(count >= maxCount){
					historyStr := RTrim(historyStr, "|")
					return  historyStr
				}
				count++
			}
		}
	}
	historyStr := RTrim( historyStr, "|" )
	return  historyStr
}

auts_pupupHistoryObjFilter(str, maxCount){
	historyStr =
	count = 1
	StringLower, str, str

	for key, optionObj in glob_historyObj {
		if(optionObj != "") {
			StringLower, lowObj, optionObj
			IfInString, lowObj, %str%
			{
				historyStr .= "|" .  optionObj
				if(count >= maxCount){
					historyStr := RTrim(historyStr, "|")
					return  historyStr
				}
				count++
			}
		}
	}
	historyStr := RTrim( historyStr, "|" )
	return  historyStr
}


auts_autoPopHistoryList( str, pControl, GuiNum=1 ) {
	;static listStr =
	listStr =
	str := auts_takeLastStr(str)
	listStr .= auts_pupupHistoryObj(str, 100)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
	;listStr = 
}

auts_autoPopHistoryFilterList( str, pControl, GuiNum=1 ) {
	;static listStr =
	listStr =
	str := auts_takeLastStr(str)
	listStr .= auts_pupupHistoryObjFilter(str, 100)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
	;listStr = 
}

auts_autoPopUpItemAndFolderList( str, pControl, GuiNum=1 ) {
	;static listStr =
	listStr =
	str := auts_takeLastStr(str)
	listStr .= auts_pupupOnlyFolders(str, 30)
	listStr .= auts_pupupSoftObjNullIfStrNull(str, 30)
	listStr .= auts_pupupFolderObjNullIfStrNull(str, 30)
	if(listStr == "") {
		listStr = |
	}
	guf_setControl( listStr, pControl, GuiNum )
	;listStr = 
}

; 一工夫  最後の文字から入力補完の判定をさせるため必要
auts_takeLastStr(str) {
	StringGetPos, index, str, %A_Space%, R1
	if(index > -1) {			; スペースがある場合
		index++
		StringTrimLeft, lastStr, str, index
		; \があるかどうかでファイル名かを判定する
		; なければファイル名でないと判定する
		IfInString, lastStr, \		;あるなら、ややこしい処理が必要
		{
			str := heard_fileNameConfirm(lastStr, str)
		} else {
			str := lastStr
		}
		str := LTrim(str)
	}
	return  str
}
