




frfnpluf_entryAllGroundKeyFromTextFileName(fileFullName, folderName, categoryDir){

	SplitPath, fileFullName , outFileName, outDir, outExtension, noExtFileName

	if( func_isFolder(fileFullName) ){
		guit_errorAppend("fromFileName  から常駐キー登録のエラー。`nこのファイルはフォルダーである`n" . fileFullName)
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
			guit_errorAppend("fromFileName  から常駐キー登録のエラー。`nこのファイルは拡張子の問題で読み込めない`n" . fileFullName)
			return False
		}
	}

	FileRead, script, %fileFullName%
	;FileReadLine, script, %fileFullName%, 1

	script := Trim(script)
	;if( script == "" ) {
	;	guit_errorAppend("fromFileName  から常駐キー登録のエラー。`nスクリプトがカラなので登録できない`nキー名   " . noExtFileName . "`nこのキーの登録は中断する。")
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

	res := hotitpf_entryAllGroundKeyLogic(noExtFileName, script, "", False, 3, categoryDir, 71, folderName)
	if( res ){
		return  True
	}
	return  False
}

; ファイル名のみ検索
frfnpluf_entryAllGroundKeyFromTextFileNameLoop(folderFullPath, folderName, categoryDir){

	IfNotExist, %folderFullPath%
	{
		return
	}

	if(glob_allGFfnCount >= glob_allGFfnMax){
		return
	}

	; 全角スペース は 半角スペース に変換
	IfInString, folderName,　
	{
		StringReplace, folderName, folderName,　,%A_Space%, All
	}

	; フォルダ名をウインドウタイトルに
	if( folderName != "" ){
		Hotkey, IfWinActive , %folderName%
	}

	Loop, %folderFullPath%\*, 0, 0
	{
		if(A_LoopFileFullPath != ""){
			if(glob_allGFfnCount >= glob_allGFfnMax){
				guit_errorAppend("fromFileName  から常駐キー登録のエラー。`n" . glob_allGFfnMax . "  を超える数のキーは登録できない。`n以下のものは登録していない`n" . A_LoopFileName)

				; 元に戻すのを必ず実行させる
				if( folderName != "" ){
					Hotkey, IfWinActive
				}
				return
			}

			frfnpluf_entryAllGroundKeyFromTextFileName(A_LoopFileFullPath, folderName, categoryDir)

			glob_allGFfnCount++
		}
	}

	; 元に戻すのを必ず実行させる
	if( folderName != "" ){
		Hotkey, IfWinActive
	}
}

; フォルダ名のみ検索
frfnpluf_entryAllGroundKeyFromFolderNameLoop(folderFullPath, categoryDir){

	IfNotExist, %folderFullPath%
	{
		return
	}

	if(glob_allGWindowFfnCount >= glob_allGWindowFfnMax){
		return
	}

	Loop, %folderFullPath%\*, 2, 0
	{
		if(A_LoopFileName != ""){
			if(glob_allGWindowFfnCount >= glob_allGWindowFfnMax){
				guit_errorAppend("fromFileName  から常駐キー登録のエラー。`n" . glob_allGWindowFfnMax . "  を超える数のアイテムは登録できない。`n以下のものは登録していない`n" . A_LoopFileName)
				return
			}

			; さらに、中のファイル名をループさせる
			frfnpluf_entryAllGroundKeyFromTextFileNameLoop(A_LoopFileFullPath, A_LoopFileName, categoryDir)

			glob_allGWindowFfnCount++
		}
	}
}

frfnpluf_makeOneSnippetFromTextFileName(fileFullName, categoryDir){
	sentence =
	spaceFlag := False

	SplitPath, fileFullName , outFileName, outDir, outExtension, noExtFileName

	if( func_isFolder(fileFullName) ){
		guit_errorAppend("fromFileNameから簡易入力の登録のエラー。`nこのファイルはフォルダーである`n" . fileFullName)
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
			guit_errorAppend("fromFileNameから簡易入力の登録のエラー。`nこのファイルは拡張子の問題で読み込めない`n" . fileFullName)
			return False
		}
	}

	FileReadLine, sentence, %fileFullName%, 1
	;FileReadLine, spaceStr, %fileFullName%, 2

	tmpSentence := Trim(sentence)
	if( tmpSentence == "" ) {
		guit_errorAppend("fromFileNameから簡易入力の登録のエラー。`n展開後の文字がカラなので登録できない`nキー名   " . noExtFileName . "`nこの簡易入力の登録は中断する。")
		return  False
	}

	;if( spaceStr == "" ){
	;	spaceStr = 0
	;}
	;spaceStr := func_getFlagByOnOffStrOrErrMsg(spaceStr)
	;if( spaceStr == "error" ){
	;	spaceStr := False
	;}
	;spaceFlag := spaceStr


	; ループを避けるため、キー名と展開後の文字が同じものはエラーにする
	StringLower, keyWordLower, noExtFileName
	StringLower, sentenceLower, sentence
	if(keyWordLower == sentenceLower){
		guit_errorAppend("fromFileNameから簡易入力の登録のエラー。`nキー名と展開後の文字が同じものは、禁止にしている`nキー名   " . noExtFileName . "`nこの簡易入力の登録は中断する。")
		return  False
	}

	if( IsObject( glob_snippetObj[noExtFileName] ) ){
		guit_errorAppend("fromFileNameから簡易入力の登録のエラー。`n同じキー名がすでに存在している`nキー名   " . noExtFileName . "`nこの簡易入力の登録は中断する。")
		return  False
	}

	optionObj := Object()
	optionObj.Insert(1, sentence)
	optionObj.Insert(2, 3)
	optionObj.Insert(3, spaceFlag)
	; 現時点では、4 に直下のカテゴリーフォルダを入れる
	optionObj.Insert(4, categoryDir)
	;optionObj.Insert(5, categoryDir)
	glob_snippetObj.Insert(noExtFileName, optionObj)
	return  True
}

; ファイル名のみ検索。簡易入力
frfnpluf_entrySnippetFromFileNameLoop(folderFullPath, categoryDir){

	IfNotExist, %folderFullPath%
	{
		return
	}

	if(glob_snippetFfnCount >= glob_snippetFfnMax){
		return
	}

	Loop, %folderFullPath%\*, 0, 0
	{
		if(A_LoopFileFullPath != ""){
			if(glob_snippetFfnCount >= glob_snippetFfnMax){
				guit_errorAppend("fromFileNameから簡易入力の登録のエラー。`n" . glob_snippetFfnMax . "  を超える数は登録できない。`n以下のものは登録していない`n" . A_LoopFileName)
				return
			}

			frfnpluf_makeOneSnippetFromTextFileName(A_LoopFileFullPath, categoryDir)

			glob_snippetFfnCount++
		}
	}
}

frfnpluf_setOneCategoryFromFileNamePlus(categoryDir){
	itemFromFileNameDir = %glob_fromFileNameDir%\%categoryDir%%glob_itemFfnDirName%
	frfnf_entryItemsFromFolderNameWrapper(itemFromFileNameDir, categoryDir)
	;frfnf_entryItemsFromFolderName(itemFromFileNameDir, categoryDir, "")
	frfnf_entryItemsFromTextFileNameOnly(itemFromFileNameDir, categoryDir, "")

	snippetDir = %glob_fromFileNameDir%\%categoryDir%%glotaip_snippetFfnDirName%
	frfnpluf_entrySnippetFromFileNameLoop(snippetDir, categoryDir)

	onTextDir = %glob_fromFileNameDir%\%categoryDir%%glob_hotkeyOnTextFfnDirName%
	frfnf_entryHotkeyOnTextFromTextFileNameAll(onTextDir, categoryDir)

	allGroundKeyDir = %glob_fromFileNameDir%\%categoryDir%%glotaip_allGroundKeyFfnDirName%
	frfnpluf_entryAllGroundKeyFromTextFileNameLoop(allGroundKeyDir, "", categoryDir)
	; フォルダ名 を ウインドウタイトル扱い。30 種類に限定する
	frfnpluf_entryAllGroundKeyFromFolderNameLoop(allGroundKeyDir, categoryDir)
}

frfnpluf_setAllFromFileNamePlus(){

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
				frfnpluf_setOneCategoryFromFileNamePlus(A_LoopFileName)
				count++
			}
		}
	}
}
