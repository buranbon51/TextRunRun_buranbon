




frfnf_twoSelectOptionSet(oneLineText, defaultFlag, errorMsg1, errorMsg2){
	rightStr := func_rightStrOrNullFromSearchStr(oneLineText, "=")
	if(rightStr == ""){
		return defaultFlag
	}

	; ON や OFF の文字列か True や False の文字列なら Trueをかえす
	if( func_checkFlagStr(rightStr) ){
		rightStr := func_getFlagByOnOffStr(rightStr)
		return rightStr
	}

	guit_errorAppend(errorMsg1 . "`nTrueかFalse以外が指定されているのでエラー`n" . oneLineText . "`n" . errorMsg2)
	return defaultFlag
}

frfnf_numberAssignOptionSet(oneLineText, defaultNum, smallestThan, greatestThan, errorMsg1, errorMsg2){
	rightStr := func_rightStrOrNullFromSearchStr(oneLineText, "=")
	if(rightStr == ""){
		rightStr = %defaultNum%
	}
	If rightStr is integer
	{
		if(rightStr <= smallestThan){
			guit_errorAppend(errorMsg1 . "`n" . smallestThan . "以下の値になっているのでエラー`n" . oneLineText . "`n" . errorMsg2)
			rightStr = %defaultNum%
		} else if(rightStr >= greatestThan){
			guit_errorAppend(errorMsg1 . "`n" . greatestThan . "以上の値になっているのでエラー`n" . oneLineText . "`n" . errorMsg2)
			rightStr = %defaultNum%
		}
		return rightStr
	}
	guit_errorAppend(errorMsg1 . "`n数字以外が指定されているのでエラー`n" . oneLineText . "`n" . errorMsg2)
	return defaultNum
}

frfnf_makeOneItemFromFolderName(folderFullPath, folderName, categoryDir, itemCategoryDir){
	script =
	radioNum = 4
	dbQuoutFlag = 0
	args =
	workDir =
	iconFile =
	iconNumber = 1
	explanation =

	configFile =
	scriptFile =

	errorMsg1 := "fromFileName からアイテム登録のエラー。"
	errorMsg2 := "アイテム名   " . folderName

	if( cen_keyWordIsObject(folderName) ) {			;アイテム名がかぶってるかどうか
		guit_errorAppend("fromFileName からアイテム登録のエラー。`n同じアイテム名のものがすでに存在している`nアイテム名   " . folderName . "`nこのアイテムの登録は中断する。")
		return  False
	}

	; configureのファイルがあるかどうか
	noExtConfigFile = %folderFullPath%\configure
	if( func_myFileExist(noExtConfigFile . ".txt") ){
		configFile := noExtConfigFile . ".txt"
	} else if( func_myFileExist(noExtConfigFile . ".ahk") ){
		configFile := noExtConfigFile . ".ahk"
	} else if( func_myFileExist(noExtConfigFile . ".ini") ){
		configFile := noExtConfigFile . ".ini"
	} else if( func_myFileExist(noExtConfigFile . ".trr") ){
		configFile := noExtConfigFile . ".trr"
	} else if( func_myFileExist(noExtConfigFile) ){
		configFile := noExtConfigFile
	}

	if( func_isFolder(configFile) ){
		guit_errorAppend(errorMsg1 . "`nconfigFileのファイルがフォルダになっている。`n" . errorMsg2)
		configFile =
	}

	if(configFile != ""){

		;comment := "#"
		comment := "["		; コメントの文字
		loopCount = 0

		Loop, Read, %configFile%
		{
			; 現時点では 10 回までのループ
			if(loopCount >= 10){
				break
			}

			oneLineText := Trim(A_LoopReadLine)
			if(oneLineText != ""){
				StringLeft, leftChar, oneLineText, 1
				if(leftChar != comment){		; # が左にあったらコメント扱い
					loopCount++

					leftStr := func_leftStrOrNullFromSearchStrTurnAssign(oneLineText, "=", 1)
					if(leftStr == ""){
						guit_errorAppend(errorMsg1 . "`nこのパラメータは使用できない`n" . loopCount . " 行目`n" . oneLineText . "`n" . errorMsg2)
						;return  False
					} else {
						StringLower, leftStr, leftStr
						if(leftStr == "type"){
							radioNum := frfnf_numberAssignOptionSet(oneLineText, 4, 0, 5, errorMsg1 . "`n種類の指定", errorMsg2 . "`nこのアイテムの種類は 4 を設定する。")
						} else if(leftStr == "doublequout"){
							dbQuoutFlag := frfnf_twoSelectOptionSet(oneLineText, False, errorMsg1 . "`ndoubleQuoutの値", errorMsg2 . "`nこの設定は 0 を設定する。")
						} else if(leftStr == "argument"){
							args := func_rightStrOrNullFromSearchStr(oneLineText, "=")
						} else if(leftStr == "workingfolder"){
							workDir := func_rightStrOrNullFromSearchStr(oneLineText, "=")
						} else if(leftStr == "iconfile"){
							iconFile := func_rightStrOrNullFromSearchStr(oneLineText, "=")
						} else if(leftStr == "iconnumber"){
							iconNumber := frfnf_numberAssignOptionSet(oneLineText, 1, 0, 500, errorMsg1 . "`nアイコンのナンバーの指定", errorMsg2 . "`nこの設定は 1 を設定する。")
						} else if(leftStr == "explanation"){
							explanation := func_rightStrOrNullFromSearchStr(oneLineText, "=")
						} else {
							guit_errorAppend(errorMsg1 . "`n使用できないオプションがある`n" . oneLineText . "`n" . errorMsg2)
						}
					}	; if(leftStr == "")
				}	; if(leftChar != comment)
			}	; if(oneLineText != "")
		}	; Loop

	}	; if(configFile != "")


	errorMsg1 := "fromFileName からアイテム登録のエラー。`nscript.txt  もしくは" . folderName . ".txt  のファイルが見つからない。`nアイテム名    " . folderName . "`nこのアイテムの登録は中断する。"

	; スクリプトのファイルから
	noExtScriptFile1 = %folderFullPath%\%folderName%
	noExtScriptFile2 = %folderFullPath%\script
	if( func_myFileExist(noExtScriptFile1 . ".txt") ){
		scriptFile := noExtScriptFile1 . ".txt"
	} else if( func_myFileExist(noExtScriptFile1 . ".ahk") ){
		scriptFile := noExtScriptFile1 . ".ahk"
	} else if( func_myFileExist(noExtScriptFile1 . ".trr") ){
		scriptFile := noExtScriptFile1 . ".trr"
	} else if( func_myFileExist(noExtScriptFile1) ){
		scriptFile := noExtScriptFile1
	} else if( func_myFileExist(noExtScriptFile2 . ".txt") ){
		scriptFile := noExtScriptFile2 . ".txt"
	} else if( func_myFileExist(noExtScriptFile2 . ".ahk") ){
		scriptFile := noExtScriptFile2 . ".ahk"
	} else if( func_myFileExist(noExtScriptFile2 . ".trr") ){
		scriptFile := noExtScriptFile2 . ".trr"
	} else if( func_myFileExist(noExtScriptFile2) ){
		scriptFile := noExtScriptFile2
	} else {
		guit_errorAppend(errorMsg1)
		return False
	}

	if( func_isFolder(scriptFile) ){
		guit_errorAppend(errorMsg1)
		return False
	}
	FileRead, script, %scriptFile%

	if(radioNum != 4){
		; 前後の改行を取り除く
		script := Trim(script, "`n`r")
	}

	script := Trim( script, """" )
	workDir := Trim( workDir, """" )

	; タイプ 1 か 2 なら、右端の\は取る
	if(radioNum == 1){
		script := RTrim(script, "\\")
	} else if(radioNum == 2){
		script := RTrim(script, "\\")
	}

	script := Trim(script)
	if( script == "" ) {
		guit_errorAppend("fromFileName からアイテム登録のエラー。`nリンク先がカラなので登録できない`nアイテム名   " . folderName . "`nこのアイテムの登録は中断する。")
		return  False
	}

	if( ite_itemNameExistNGCharacter(folderName) ) {
		guit_errorAppend("fromFileName からアイテム登録のエラー。`nアイテム名として使えない文字がある`nアイテム名   " . folderName . "`nこのアイテムの登録は中断する。")
		return  False
	}

	; ループを避けるため、アイテム名とパスが同じものはエラーにする
	StringLower, itemNameLower, folderName
	StringLower, scriptLower, script
	if(itemNameLower == scriptLower) {
		guit_errorAppend("fromFileName からアイテム登録のエラー。`nアイテム名とリンク先が同じものは、禁止にしている`nアイテム名   " . folderName . "`nこのアイテムの登録は中断する。")
		return  False
	}

	;if(imagePath == ""){
	;	iconNum = 1
	;}

	if(radioNum == 1){
		; 作業フォルダがカラなら、#folderName#\ にする
		if(workDir == ""){
			workDir := "#" . folderName . "#\"
		}
		workDir := RTrim(workDir, "\\")
		StringRight, rChar, workDir, 1	;	ここでいらん一工夫
		if(rChar == "#"){			;	 ##で囲まれているなら(item名なら)
			workDir .= "\"			;	その親フォルダをかえすようにする(\をやっぱり付け足す)
		}

		tempStr := outs_textOutDqAllTrim(script)		; %%と##を展開する(でも登録はしない)
		type := FileExist(tempStr)
		IfInString, type, D
		{
			radioNum = 2
			guit_appendExplain("fromFileName から登録したアイテムをフォルダとして登録する`nアイテム名    " . folderName)
			args := ""
			workDir := ""
		}
	} else if(radioNum == 2){
		args := ""
		workDir := ""
	} else if(radioNum == 3){
		args := ""
		workDir := ""
	} else if(radioNum == 4){
		args := ""
		workDir := ""
	}

	IfInString, explanation, ###n
	{
		StringReplace, explanation, explanation, ###n , `n, All
	}

	;musc_itemToObjFromCommand(folderName, script, args, workDir, radioNum, dbQuoutFlag, iconFile, iconNumber, explanation, 3)

	optionObj := Object()
	optionObj.Insert(1, script)
	optionObj.Insert(2, args)
	optionObj.Insert(3, workDir)
	optionObj.Insert(4, explanation)
	optionObj.Insert(5, radioNum)	; 種類
	optionObj.Insert(6, iconFile)
	optionObj.Insert(7, iconNumber)
	optionObj.Insert(8, dbQuoutFlag)
	optionObj.Insert(9, 0)		; 一時的
	optionObj.Insert(10, 3)		; 何から登録したか
	; カテゴリーフォルダ
	optionObj.Insert(11, categoryDir)
	optionObj.Insert(12, itemCategoryDir)

	if(radioNum == 1) {
		glob_softObj.Insert(folderName, optionObj)
	} else if (radioNum ==  2) {
		glob_folderObj.Insert(folderName, optionObj)
	} else if (radioNum ==  3) {
		glob_itemCommandObj.Insert(folderName, optionObj)
	} else if (radioNum ==  4) {
		glob_multipleObj.Insert(folderName, optionObj)
	}
	return  True
}

; フォルダ名のみ検索
frfnf_entryItemsFromFolderName(folderFullPath, categoryDir, itemCategoryDir){

	IfNotExist, %folderFullPath%
	{
		return
	}

	if(glob_itemFfnCount >= glob_itemFfnMax){
		return
	}

	Loop, %folderFullPath%\*, 2, 0
	{
		if(A_LoopFileName != ""){
			if(glob_itemFfnCount >= glob_itemFfnMax){
				guit_errorAppend("fromFileName からアイテム登録のエラー。`n" . glob_itemFfnMax . "  を超える数のアイテムは登録できない。`n以下のアイテム以下のものは登録していない`n" . A_LoopFileFullPath)
				return
			}

			frfnf_makeOneItemFromFolderName(A_LoopFileFullPath, A_LoopFileName, categoryDir, itemCategoryDir)

			glob_itemFfnCount++
		}
	}
}

frfnf_makeOneItemFromTextFileName(fileFullName, categoryDir, itemCategoryDir){
	script =
	radioNum = 4
	dbQuoutFlag = 0
	args =
	workDir =
	iconFile =
	iconNumber = 1
	explanation =

	SplitPath, fileFullName , outFileName, outDir, outExtension, noExtFileName

	if( func_isFolder(fileFullName) ){
		guit_errorAppend("fromFileName からアイテム登録のエラー。`nこのファイルはフォルダーである`n" . fileFullName)
		return False
	}
	noExtFileName := Trim(noExtFileName)
	if(noExtFileName == ""){
		return False
	}
	; 拡張子がないのはよい
	IfInString, fileFullName, .
	{
		if( outs_similarTxtFile(fileFullName) == False ){
			; 拡張子が .txt .ahk などでなければNG
			guit_errorAppend("fromFileName からアイテム登録のエラー。`nこのファイルは拡張子の問題で読み込めない`n" . fileFullName)
			return False
		}
	}

	FileRead, script, %fileFullName%

	script := Trim(script)
	if( script == "" ) {
		guit_errorAppend("fromFileName からアイテム登録のエラー。`nリンク先がカラなので登録できない`nアイテム名   " . noExtFileName . "`nこのアイテムの登録は中断する。")
		return  False
	}

	if( cen_keyWordIsObject(noExtFileName) ) {			;アイテム名がかぶってるかどうか
		guit_errorAppend("fromFileName からアイテム登録のエラー。`n同じアイテム名のものがすでに存在している`nアイテム名   " . noExtFileName . "`nこのアイテムの登録は中断する。")
		return  False
	}

	nextOneLine =
	smicron := "`;"
	StringLeft, leftChar, script, 1
	; 最初が セミコロン なら、設定を記入しているものとして扱う
	if( leftChar == smicron ){

		errorMsg1 := "fromFileName からアイテム登録のエラー。"
		errorMsg2 := "アイテム名   " . noExtFileName

		;comment := "#"
		comment := "["		; コメントの文字
		loopCount = 0

		Loop, Parse, script , `n, `r
		{
			; 現時点では 11 回までのループ
			if(loopCount >= 11){
				break
			}

			oneLineText := Trim(A_LoopField)
			if(oneLineText != ""){
				StringLeft, leftChar, oneLineText, 1
				; 左端がセミコロンでなければ、その行の文字を取得して、設定をやめる
				if(leftChar != smicron){
					nextOneLine = %oneLineText%
					break
				}
				StringTrimLeft, oneLineText, oneLineText, 1
				oneLineText := LTrim( oneLineText )
				StringLeft, leftChar, oneLineText, 1
				if(leftChar != comment){		; # が左にあったらコメント扱い
					loopCount++

					leftStr := func_leftStrOrNullFromSearchStrTurnAssign(oneLineText, "=", 1)
					if(leftStr == ""){
						;guit_errorAppend(errorMsg1 . "`nこのパラメータは使用できない`n" . loopCount . " 行目`n" . oneLineText . "`n" . errorMsg2)
					} else {
						StringLower, leftStr, leftStr
						if(leftStr == "type"){
							radioNum := frfnf_numberAssignOptionSet(oneLineText, 4, 0, 5, errorMsg1 . "`n種類の指定", errorMsg2 . "`nこのアイテムの種類は 4 を設定する。")
						} else if(leftStr == "doublequout"){
							dbQuoutFlag := frfnf_twoSelectOptionSet(oneLineText, False, errorMsg1 . "`ndoubleQuoutの値", errorMsg2 . "`nこの設定は 0 を設定する。")
						} else if(leftStr == "argument"){
							args := func_rightStrOrNullFromSearchStr(oneLineText, "=")
						} else if(leftStr == "workingfolder"){
							workDir := func_rightStrOrNullFromSearchStr(oneLineText, "=")
						} else if(leftStr == "iconfile"){
							iconFile := func_rightStrOrNullFromSearchStr(oneLineText, "=")
						} else if(leftStr == "iconnumber"){
							iconNumber := frfnf_numberAssignOptionSet(oneLineText, 1, 0, 500, errorMsg1 . "`nアイコンのナンバーの指定", errorMsg2 . "`nこの設定は 1 を設定する。")
						} else if(leftStr == "explanation"){
							explanation := func_rightStrOrNullFromSearchStr(oneLineText, "=")
						} else {
							;guit_errorAppend(errorMsg1 . "`n使用できないオプションがある`n" . oneLineText . "`n" . errorMsg2)
						}
					}	; if(leftStr == "")
				}	; if(leftChar != comment)
			}	; if(oneLineText != "")
		}	; Loop

	}	; if(configFile != "")


	if(radioNum != 4){
		script = %nextOneLine%
		; 前後の改行を取り除く
		script := Trim(script, "`n`r")
	}

	script := Trim( script, """" )
	workDir := Trim( workDir, """" )

	; タイプ 1 か 2 なら、右端の\は取る
	if(radioNum == 1){
		script := RTrim(script, "\\")
	} else if(radioNum == 2){
		script := RTrim(script, "\\")
	}

	; もう一度
	script := Trim(script)
	if( script == "" ) {
		guit_errorAppend("fromFileName からアイテム登録のエラー。`nリンク先がカラなので登録できない`nアイテム名   " . noExtFileName . "`nこのアイテムの登録は中断する。")
		return  False
	}

	if( ite_itemNameExistNGCharacter(noExtFileName) ) {
		guit_errorAppend("fromFileName からアイテム登録のエラー。`nアイテム名として使えない文字がある`nアイテム名   " . noExtFileName . "`nこのアイテムの登録は中断する。")
		return  False
	}

	; ループを避けるため、アイテム名とパスが同じものはエラーにする
	StringLower, itemNameLower, noExtFileName
	StringLower, scriptLower, script
	if(itemNameLower == scriptLower) {
		guit_errorAppend("fromFileName からアイテム登録のエラー。`nアイテム名とリンク先が同じものは、禁止にしている`nアイテム名   " . noExtFileName . "`nこのアイテムの登録は中断する。")
		return  False
	}

	if(radioNum == 1){
		; 作業フォルダがカラなら、#noExtFileName#\ にする
		if(workDir == ""){
			workDir := "#" . noExtFileName . "#\"
		}
		workDir := RTrim(workDir, "\\")
		StringRight, rChar, workDir, 1	;	ここでいらん一工夫
		if(rChar == "#"){			;	 ##で囲まれているなら(item名なら)
			workDir .= "\"			;	その親フォルダをかえすようにする(\をやっぱり付け足す)
		}

		; %%と##を展開する(でも登録はしない)
		tempStr := outs_textOutDqAllTrim(script)
		type := FileExist(tempStr)
		IfInString, type, D
		{
			radioNum = 2
			guit_appendExplain("fromFileName から登録したアイテムをフォルダとして登録する`nアイテム名    " . noExtFileName)
			args := ""
			workDir := ""
		}
	} else if(radioNum == 2){
		args := ""
		workDir := ""
	} else if(radioNum == 3){
		args := ""
		workDir := ""
	} else if(radioNum == 4){
		args := ""
		workDir := ""
	}

	IfInString, explanation, ###n
	{
		StringReplace, explanation, explanation, ###n , `n, All
	}

	;musc_itemToObjFromCommand(noExtFileName, script, args, workDir, radioNum, dbQuoutFlag, iconFile, iconNumber, explanation, 3)

	optionObj := Object()
	optionObj.Insert(1, script)
	optionObj.Insert(2, args)
	optionObj.Insert(3, workDir)
	optionObj.Insert(4, explanation)
	optionObj.Insert(5, radioNum)	; 種類
	optionObj.Insert(6, iconFile)
	optionObj.Insert(7, iconNumber)
	optionObj.Insert(8, dbQuoutFlag)
	optionObj.Insert(9, 0)		; 一時的
	optionObj.Insert(10, 3)		; 何から登録したか
	; カテゴリーフォルダ
	optionObj.Insert(11, categoryDir)
	optionObj.Insert(12, itemCategoryDir)

	if(radioNum == 1) {
		glob_softObj.Insert(noExtFileName, optionObj)
	} else if (radioNum ==  2) {
		glob_folderObj.Insert(noExtFileName, optionObj)
	} else if (radioNum ==  3) {
		glob_itemCommandObj.Insert(noExtFileName, optionObj)
	} else if (radioNum ==  4) {
		glob_multipleObj.Insert(noExtFileName, optionObj)
	}
	return  True
}

/*
  上の関数の昔の。ファイルからの登録はタイプ４のアイテムとしてだけ扱う
frfnf_makeOneItemFromTextFileName(fileFullName, categoryDir, itemCategoryDir){
	script =
	radioNum = 4
	dbQuoutFlag = 0
	args =
	workDir =
	iconFile =
	iconNumber = 1
	explanation =

	SplitPath, fileFullName , outFileName, outDir, outExtension, noExtFileName

	if( func_isFolder(fileFullName) ){
		guit_errorAppend("fromFileName からアイテム登録のエラー。`nこのファイルはフォルダーである`n" . fileFullName)
		return False
	}
	noExtFileName := Trim(noExtFileName)
	if(noExtFileName == ""){
		return False
	}
	; 拡張子がないのはよい
	IfInString, fileFullName, .
	{
		if( outs_similarTxtFile(fileFullName) == False ){
			; 拡張子が .txt .ahk などでなければNG
			guit_errorAppend("fromFileName からアイテム登録のエラー。`nこのファイルは拡張子の問題で読み込めない`n" . fileFullName)
			return False
		}
	}

	FileRead, script, %fileFullName%

	script := Trim(script)
	if( script == "" ) {
		guit_errorAppend("fromFileName からアイテム登録のエラー。`nリンク先がカラなので登録できない`nアイテム名   " . noExtFileName . "`nこのアイテムの登録は中断する。")
		return  False
	}

	if( ite_itemNameExistNGCharacter(noExtFileName) ) {
		guit_errorAppend("fromFileName からアイテム登録のエラー。`nアイテム名として使えない文字がある`nアイテム名   " . noExtFileName . "`nこのアイテムの登録は中断する。")
		return  False
	}
	script := Trim( script, """" )
	workDir := Trim( workDir, """" )

	; ループを避けるため、アイテム名とパスが同じものはエラーにする
	StringLower, itemNameLower, noExtFileName
	StringLower, scriptLower, script
	if(itemNameLower == scriptLower) {
		guit_errorAppend("fromFileName からアイテム登録のエラー。`nアイテム名とリンク先が同じものは、禁止にしている`nアイテム名   " . noExtFileName . "`nこのアイテムの登録は中断する。")
		return  False
	}

	if( cen_keyWordIsObject(noExtFileName) ) {			;アイテム名がかぶってるかどうか
		guit_errorAppend("fromFileName からアイテム登録のエラー。`n同じアイテム名のものがすでに存在している`nアイテム名   " . noExtFileName . "`nこのアイテムの登録は中断する。")
		return  False
	}

	;musc_itemToObjFromCommand(noExtFileName, script, args, workDir, radioNum, dbQuoutFlag, iconFile, iconNumber, explanation, 3)

	optionObj := Object()
	optionObj.Insert(1, script)
	optionObj.Insert(2, args)
	optionObj.Insert(3, workDir)
	optionObj.Insert(4, explanation)
	optionObj.Insert(5, radioNum)	; 種類
	optionObj.Insert(6, iconFile)
	optionObj.Insert(7, iconNumber)
	optionObj.Insert(8, dbQuoutFlag)
	optionObj.Insert(9, 0)		; 一時的
	optionObj.Insert(10, 3)		; 何から登録したか
	; カテゴリーフォルダ
	optionObj.Insert(11, categoryDir)
	optionObj.Insert(12, itemCategoryDir)

	glob_multipleObj.Insert(noExtFileName, optionObj)

	return  True
}
*/

; ファイル名のみ検索
frfnf_entryItemsFromTextFileNameOnly(folderFullPath, categoryDir, itemCategoryDir){

	IfNotExist, %folderFullPath%
	{
		return
	}

	if(glob_itemFfnCount >= glob_itemFfnMax){
		return
	}

	Loop, %folderFullPath%\*, 0, 0
	{
		if(A_LoopFileFullPath != ""){
			if(glob_itemFfnCount >= glob_itemFfnMax){
				guit_errorAppend("fromFileName からアイテム登録のエラー。`n" . glob_itemFfnMax . "  を超える数のアイテムは登録できない。`n以下のアイテム以下のものは登録していない`n" . A_LoopFileFullPath)
				return
			}

			frfnf_makeOneItemFromTextFileName(A_LoopFileFullPath, categoryDir, itemCategoryDir)

			glob_itemFfnCount++
		}
	}
}

; フォルダ名のみ検索
; フォルダ名が _ で終わる場合、そのフォルダを item フォルダと同じようにその中のフォルダとファイルをアイテムに登録する
frfnf_entryItemsFromFolderNameWrapper(itemFullPath, categoryDir){

	IfNotExist, %itemFullPath%
	{
		return
	}

	if(glob_itemFfnCount >= glob_itemFfnMax){
		return
	}

	Loop, %itemFullPath%\*, 2, 0
	{
		if(A_LoopFileName != ""){
			folderFullPath := A_LoopFileFullPath
			; ここでエラー表示をしなくても別に良いが、少し分かりやすくなるかもしれないのであえてする
			if(glob_itemFfnCount >= glob_itemFfnMax){
				guit_errorAppend("fromFileName からアイテム登録のエラー。`n" . glob_itemFfnMax . "  を超える数のアイテムは登録できない。`n以下のフォルダ内以下は登録していない`n" . folderFullPath)
				return
			}

			StringRight, rChr, folderFullPath, 1
			if( rChr == "_" ){
				; アイテムの数を count で引き継ぐ
				;count := frfnf_entryItemsFromFolderName(folderFullPath, categoryDir, A_LoopFileName, count)
				;count := frfnf_entryItemsFromTextFileNameOnly(folderFullPath, categoryDir, A_LoopFileName, count)

				frfnf_entryItemsFromFolderName(folderFullPath, categoryDir, A_LoopFileName)
				frfnf_entryItemsFromTextFileNameOnly(folderFullPath, categoryDir, A_LoopFileName)

			} else {
				frfnf_makeOneItemFromFolderName(folderFullPath, A_LoopFileName, categoryDir, "")
				glob_itemFfnCount++
			}
		}
	}
}

frfnf_oneExecuteFromFileName(fileFullName){
	SplitPath, fileFullName , outFileName, outDir, outExtension, noExtFileName

	noExtFileName := Trim(noExtFileName)
	if(noExtFileName == ""){
		return
	}
	edi_commandExeLogicWrapper(noExtFileName, "", "", 71, null, True, True)
}

; ファイル名とフォルダを検索。フォルダは中身も全て検索する
frfnf_startupExecuteOneCategory(folderFullPath, categoryDir){

	IfNotExist, %folderFullPath%
	{
		return
	}

	Loop, %folderFullPath%\*, 1, 1
	{
		if(A_LoopFileFullPath != ""){
			frfnf_oneExecuteFromFileName(A_LoopFileFullPath)

			if(glob_startupFfnCount >= glob_startupFfnMax){
				guit_errorAppend("fromFileName から起動時に実行の処理のエラー。`n" . glob_startupFfnMax . "  を超えるファイルは実行できない。`n" . A_LoopFileName . "  の処理を実行した後に中断する")
				return
			}
			glob_startupFfnCount++
		}
	}
}

frfnf_startupExecuteFromFileName(){

	count = 1

	IfNotExist, %glob_fromFileNameDir%
	{
		return
	}

	Loop, %glob_fromFileNameDir%\*, 2, 0
	{
		if(A_LoopFileName != ""){
			; ignore の名前なら、何もしない
			if(A_LoopFileName != "ignore"){
				if(count >= glob_categoryFfnMax){
					guit_errorAppend("fromFileName  のstartupのカテゴリーのエラー。`n" . glob_categoryFfnMax . "  を超える数のカテゴリーは利用できない。`n以下のカテゴリー以降は実行していない`n" . A_LoopFileName)
					return
				}
				startupDir = %glob_fromFileNameDir%\%A_LoopFileName%%glob_startupFfnDirName%
				frfnf_startupExecuteOneCategory(startupDir, A_LoopFileName)
				count++
			}
		}
	}
}

frfnf_hotk_entryHotkeyOnTextFromTextFileName(fileFullName, categoryDir){

	SplitPath, fileFullName , outFileName, outDir, outExtension, noExtFileName

	if( func_isFolder(fileFullName) ){
		guit_errorAppend("fromFileName  からキー登録のエラー。`nこのファイルはフォルダーである`n" . fileFullName)
		return False
	}
	noExtFileName := Trim(noExtFileName)
	if(noExtFileName == ""){
		return False
	}
	; 拡張子がないのはよい
	IfInString, fileFullName, .
	{
		if( outs_similarTxtFile(fileFullName) == False ){
			; 拡張子が .txt .ahk などでなければNG
			guit_errorAppend("fromFileName  からキー登録のエラー。`nこのファイルは拡張子の問題で読み込めない`n" . fileFullName)
			return False
		}
	}

	;FileRead, script, %fileFullName%
	FileReadLine, script, %fileFullName%, 1

	script := Trim(script)
	;if( script == "" ) {
	;	guit_errorAppend("fromFileName  からキー登録のエラー。`nスクリプトがカラなので登録できない`nキー名   " . noExtFileName . "`nこのキーの登録は中断する。")
	;	return  False
	;}

	; キー名の置換
	IfInString, noExtFileName, _
	{
		StringReplace, noExtFileName, noExtFileName, _ , +, All
	}
	; 全角スペース は 半角スペース に変換
	IfInString, noExtFileName,　
	{
		StringReplace, noExtFileName, noExtFileName,　,%A_Space%, All
	}
	; 全角の ＆ は 半角の & に変換
	IfInString, noExtFileName, ＆
	{
		StringReplace, noExtFileName, noExtFileName, ＆ , &, All
	}

	res := hotk_entryKeyOnTextCommandLogic(noExtFileName, script, "", False, 3, categoryDir, 71)
	if( res ){
		return  True
	}
	return  False
}

; ファイル名のみ検索
frfnf_entryHotkeyOnTextFromTextFileNameAll(folderFullPath, categoryDir){

	IfNotExist, %folderFullPath%
	{
		return
	}

	if(glob_onTextFfnCount >= glob_onTextFfnMax){
		return
	}

	; 先に指定。全て終わってから元に戻すようにする。
	Hotkey, IfWinActive , %gGlob_GuiCommandTitle%

	Loop, %folderFullPath%\*, 0, 0
	{
		if(A_LoopFileFullPath != ""){
			if(glob_onTextFfnCount >= glob_onTextFfnMax){
				guit_errorAppend("fromFileName  からテキスト上のキー登録のエラー。`n" . glob_onTextFfnMax . "  を超える数のキーは登録できない。`n以下のものは登録していない`n" . A_LoopFileName)
				; 終了前に Hotkey の状態を元にもどすこと
				Hotkey, IfWinActive
				return
			}

			frfnf_hotk_entryHotkeyOnTextFromTextFileName(A_LoopFileFullPath, categoryDir)

			glob_onTextFfnCount++
		}
	}

	; 必ず元に戻す
	Hotkey, IfWinActive
}

frfnf_setOneCategoryItemOnly(categoryDir){
	itemFromFileNameDir = %glob_fromFileNameDir%\%categoryDir%%glob_itemFfnDirName%
	frfnf_entryItemsFromFolderNameWrapper(itemFromFileNameDir, categoryDir)
	;frfnf_entryItemsFromFolderName(itemFromFileNameDir, categoryDir, "")
	frfnf_entryItemsFromTextFileNameOnly(itemFromFileNameDir, categoryDir, "")
}

frfnf_setAllItemOnlyFromFileName(){

	; アイテムのカウントを初期値に戻す
	glob_itemFfnCount = 1

	count = 1

	IfNotExist, %glob_fromFileNameDir%
	{
		return
	}

	Loop, %glob_fromFileNameDir%\*, 2, 0
	{
		if(A_LoopFileName != ""){
			; ignore の名前なら、何もしない
			if(A_LoopFileName != "ignore"){
				if(count >= glob_categoryFfnMax){
					guit_errorAppend("fromFileName  のカテゴリーのエラー。`n" . glob_categoryFfnMax . "  を超える数のカテゴリーは利用できない。`n以下のもの以降は読み込んでいない`n" . A_LoopFileName)
					return
				}
				frfnf_setOneCategoryItemOnly(A_LoopFileName)
				count++
			}
		}
	}
}

frfnf_setOneCategoryFromFileName(categoryDir){
	itemFromFileNameDir = %glob_fromFileNameDir%\%categoryDir%%glob_itemFfnDirName%
	frfnf_entryItemsFromFolderNameWrapper(itemFromFileNameDir, categoryDir)
	;frfnf_entryItemsFromFolderName(itemFromFileNameDir, categoryDir, "")
	frfnf_entryItemsFromTextFileNameOnly(itemFromFileNameDir, categoryDir, "")

	onTextDir = %glob_fromFileNameDir%\%categoryDir%%glob_hotkeyOnTextFfnDirName%
	frfnf_entryHotkeyOnTextFromTextFileNameAll(onTextDir, categoryDir)
}

frfnf_setAllFromFileName(){

	count = 1

	IfNotExist, %glob_fromFileNameDir%
	{
		return
	}

	Loop, %glob_fromFileNameDir%\*, 2, 0
	{
		if(A_LoopFileName != ""){
			; ignore の名前なら、何もしない
			if(A_LoopFileName != "ignore"){
				if(count >= glob_categoryFfnMax){
					guit_errorAppend("fromFileName  のカテゴリーのエラー。`n" . glob_categoryFfnMax . "  を超える数のカテゴリーは利用できない。`n以下のもの以降は読み込んでいない`n" . A_LoopFileName)
					return
				}
				frfnf_setOneCategoryFromFileName(A_LoopFileName)
				count++
			}
		}
	}
}
