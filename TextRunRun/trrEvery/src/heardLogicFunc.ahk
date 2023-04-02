; 必須 glob  guf  outs func
;

; 空白のあるファイル名  と 引数  があった場合実行できるようにした処理
heard_miniEditFileNameOpen(argStr, GuiNum, LineFile, LineNumber, openNum=1){
	argStrDbReplace := heard_dbQuouteReplace(argStr, False)
	argStrDbReplace := heard_searchReplaceFilePath(argStrDbReplace)
	tmpArgStr := heard_dbQuouteReplaceReturn(argStrDbReplace, A_LineFile, A_LineNumber, True, True)
	tmpArgStr := Trim(tmpArgStr)
	IfInString, tmpArgStr, %A_Space%
	{
		StringGetPos, index, tmpArgStr, %A_Space%, L1
		StringLeft, leftStr, tmpArgStr, %index%
		if( heard_replaceSignWordConfirm(leftStr, "$") ){
			; 単純に２番目の文字を取る
			StringTrimLeft, leftStr, leftStr, 1
			StringLeft, LChar, leftStr, 1
			leftStr := glob_spaceFileObj[LChar]
		}
		index++
		StringTrimLeft, rightStr, tmpArgStr, %index%
		rightStr := heard_searchFilePathReturn(rightStr, A_LineFile, A_LineNumber, False, True)
		glob_spaceFileObj := Object()	; 必ず実行させる

		if( func_myFileExist(leftStr) )
		{
			StringRight, str4, leftStr, 4
			if(str4 == "\con" || str4 == "\prn" || str4 == "com1" || str4 == "com2"){		; 謎のファイル con だったら
				guit_errorAppend("例外の文字でファイルが開けません")
				return  True
			}

			pathStr := outs_relativeToAbsoluteFromWorkDir(leftStr, LineFile, LineNumber, True)

			; < > で囲まれてるのを workDir にする
			workDir := outs_miniEditWorkDir(rightStr)
			argss := outs_miniEditExceptingWorkDir(rightStr)
			workDir := outs_textOutDqAllTrim(workDir)
			workDir := outs_relativeToAbsoluteFromWorkDir(workDir,  A_LineFile, A_LineNumber, False)
			outs_workDirCheck(workDir, "作業フォルダが不明`n" . workDir)
			if(workDir == ""){
				workDir = %A_WorkingDir%
			}

			if(glob_iniAbsolePathNotFlag == False){
				;if(glob_iniSpaceFileNotFlag == False){
				if(O_spaceFileNotFlag == False){
					argss := heard_fileAllAbsoluteOrDbQuoute(argss, A_LineFile, A_LineNumber, False, False)
				} else {
					; 絶対パスにはするが、空白のあるファイルがあったら対処できない簡易版
					argss := heard_absoluteAllEasy(argss, A_LineFile, A_LineNumber)
				}
			}

			dbQuouteChar := """"
			runPath := dbQuouteChar . pathStr . dbQuouteChar . " " . argss
			runPath := Trim(runPath)
			cen_easyCheckAppendNotShow("path  " . runPath,"work  " . workDir, A_ThisFunc, A_LineNumber)


/*
現時点では使わなくてもいいと思われる

			tmpRunPath := pathStr  . " " . argss
			tmpRunPath := Trim(tmpRunPath)

			; 設定で、拡張子によって開くソフトを変える場合
			changeFlag := False
			; まずはフォルダーかどうか
			if( cen_openFolderMethodChangeFromFolderVar(tmpRunPath) ){
				pathStr := cen_getScriptBeforeExeSoftItem(O_folderOpenSoftItem, "O_folderOpenSoftItem", tmpRunPath)
				argss := cen_getArgssBeforeExeSoftItem(O_folderOpenSoftItem, tmpRunPath)
				workDir := cen_getWorkDirBeforeExeSoftItem(O_folderOpenSoftItem)
				changeFlag := True
			}
			if( cen_openMethodChangeFromVar(O_txtOpenSoftItem, "O_txtOpenSoftItem", tmpRunPath, ".txt") ){
				pathStr := cen_getScriptBeforeExeSoftItem(O_txtOpenSoftItem, "O_txtOpenSoftItem", tmpRunPath)
				argss := cen_getArgssBeforeExeSoftItem(O_txtOpenSoftItem, tmpRunPath)
				workDir := cen_getWorkDirBeforeExeSoftItem(O_txtOpenSoftItem)
				changeFlag := True
			}
			if( cen_openMethodChangeFromVar(O_ahkOpenSoftItem, "O_ahkOpenSoftItem", tmpRunPath, ".ahk") ){
				pathStr := cen_getScriptBeforeExeSoftItem(O_ahkOpenSoftItem, "O_ahkOpenSoftItem", tmpRunPath)
				argss := cen_getArgssBeforeExeSoftItem(O_ahkOpenSoftItem, tmpRunPath)
				workDir := cen_getWorkDirBeforeExeSoftItem(O_ahkOpenSoftItem)
				changeFlag := True
			}
			if( changeFlag ){
				; ソフトのパスの返り値(pathStr)が、元のファイル名(tmpRunPath)だった場合、引数は無しにする
				if(tmpRunPath == pathStr){
					argss =
				}
				runPath := dbQuouteChar . pathStr . dbQuouteChar . " " . argss
				runPath := Trim(runPath)
			}
*/


			if(openNum == 1){
				Run, %runPath%, %workDir% , UseErrorLevel
				edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
				cen_checkCommSuccess()
				guit_checkErrorLevelOutput("ファイルの実行に失敗。", "パス`t" . runPath)
			} else if(openNum == 2){
				edi_openSetEditBoxss(pathStr, argss, workDir, GuiNum)
				edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
			} else if(openNum == 3){
				guaf_openSetMiniEdit(pathStr, argss, workDir, GuiNum)
				edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
			}
			return  True
		}
	}
	IfInString, tmpArgStr, $
	{
		; $1$ 用の Obj を初期化する
		glob_spaceFileObj := Object()	; 必ず実行させる
	}
	return  False
}


; 文字列にファイル名があったら、全て絶対パスに変える
; 空白のあるファイルには対処しない簡単な処理
; heard_absoluteAllEasy() の中で使うのが前提
heard_absoluteAllSplitSpaceEasy(argss){
	; 空白がないなら（引数が一つなら）
	IfNotInString, argss, %A_Space%
	{
		if( func_myFileExist(argss) ){
			argss := outs_relativeToAbsoluteFromWorkDir(argss, lineFile, lineNumber, False)
		}
		return argss
	}

	buff =
	Loop, Parse, argss , %A_Space%
	{
		tmpStr := A_LoopField
		if( func_myFileExist(tmpStr) ){
			tmpStr := outs_relativeToAbsoluteFromWorkDir(tmpStr, lineFile, lineNumber, False)
		}
		buff .= tmpStr . " "
	}
	buff := RTrim(buff)
	return buff
}

; heard_fileAllAbsoluteOrDbQuoute の簡易版
; ファイル名があったら、全て絶対パスに変える
; "" で囲んだりしない。そもそも空白のあるパスになんら対処しない。
heard_absoluteAllEasy(argss, lineFile, lineNumber){
	; まずは 初めから " " で囲まれているものを別にする
	tmpArgss := heard_dbQuouteReplace(argss, True)
	; 文字列にファイル名があったら、全て絶対パスに変える
	tmpArgss := heard_absoluteAllSplitSpaceEasy(tmpArgss)

	argss    := heard_dbQuouteReplaceReturn(tmpArgss, lineFile, lineNumber, True, False)
	return  argss
}

; ファイル名を見つけて " " で囲むようにする
; 絶対パスを返すための関数としても利用できる
heard_fileAllAbsoluteOrDbQuoute(argss, lineFile, lineNumber, dbQuoutFlag=False, absoleNotFlag=True){
	; まずは 初めから " " で囲まれているものを別にする
	tmpArgss := heard_dbQuouteReplace(argss, True)
	; ファイル名を見つけて $1$ などにする
	tmpArgss := heard_searchReplaceFilePath(tmpArgss)
	; 元に戻す。その際  絶対パスに変換して、 " " で囲んで、戻す
	tmpArgss := heard_searchFilePathReturn(tmpArgss, lineFile, lineNumber, dbQuoutFlag, absoleNotFlag)
	argss    := heard_dbQuouteReplaceReturn(tmpArgss, lineFile, lineNumber, True, absoleNotFlag)
	IfNotInString, argss, %A_Space%
	{
		; heard_searchReplaceFilePath は 空白を含まないファイルを 無視するのでその対策
		if(absoleNotFlag == False){
			argss := outs_relativeToAbsoluteFromWorkDir(argss, lineFile, lineNumber, False)
		}
		if(dbQuoutFlag){
			argss := outs_orFileToDbQuouteNotTextOut(argss)
		}
	}
	return  argss
}

; 下の heard_searchReplaceFilePath 関数でやった処理を元に戻す
;  $111$ などの文字をファイル名に戻す
; dbQuoutFlag を True にして使うと " " で囲んで戻すようになる
; absoleNotFlag を False にして使うと 絶対パスに変換して返すようになる
heard_searchFilePathReturn(argStr, lineFile, lineNumber, dbQuoutFlag=False, absoleNotFlag=True){
	IfNotInString, argStr, $
	{
		return argStr
	}

	changeStr := argStr
	tagetNum = 1

	dbQuouteChar := """"
	repFlag := False

	Loop, 15
	{
		res := False
		if(A_Index == 15){
			guit_errorAppend("$の展開を15回して、停止した`n" . argStr)
			break
		}
		IfInString, changeStr, $
		{
			StringGetPos, index, changeStr, $, L%tagetNum%
			if(index <= -1){
				break
			}
			indexPlus := index + 1
			StringTrimLeft, rightStr, changeStr, %indexPlus%
			IfInString, rightStr, $
			{
				StringGetPos, index2, rightStr, $
				StringLeft, center, rightStr, %index2%
				center := "$" . center . "$"
				if( heard_replaceSignWordConfirm(center, "$") ){
					; 単純に２番目の文字を取る
					StringTrimLeft, center, center, 1
					StringLeft, LChar, center, 1

					StringLeft, leftStr, changeStr, %index%
					index2 += 1
					StringTrimLeft, rightStr_rStr, rightStr, %index2%

					replaceStr := glob_spaceFileObj[LChar]
					if( replaceStr == "" ){
						guit_errorAppend("$の展開のエラー`n展開したパスがカラ`n元の文字  " . argStr)
					}
					if(absoleNotFlag == False) {
						replaceStr := outs_relativeToAbsoluteFromWorkDir(replaceStr, lineFile, lineNumber, False)
					}
					if(dbQuoutFlag) {
						replaceStr := dbQuouteChar  . replaceStr  . dbQuouteChar
					}
					changeStr := leftStr . replaceStr . rightStr_rStr
					res := True
					repFlag := True
				}
			} else {
				; 右の $ がない場合
				break
			}
		} else {
			; $ がない場合
			break
		}
		if( res == False ){
			tagetNum++
		}
	}	; Loop
	if( repFlag ){
		; 初期化する
		glob_spaceFileObj := Object()
	}
	return changeStr
}

; 下の heard_searchReplaceFilePath 関数でやった処理を元に戻す
;  $1$ などの文字をファイル名に戻す
; dbQuoutFlag を True にして使うと " " で囲んで戻すようになる
; absoleNotFlag を False にして使うと 絶対パスに変換して返すようになる
/*
 昔のバージョン
heard_searchFilePathReturn(argStr, lineFile, lineNumber, dbQuoutFlag=False, absoleNotFlag=True){
	IfInString, argStr, $
	{
		dbQuouteChar := """"
		flag_Not := True
		Loop, 10
		{
			RegExMatch(argStr, "i)^([\w\W]*)\$([\d]+)\$([\w\W]*)$" , re_ )
			if(re_2 != ""){
				If re_2 is integer
				{
					flag_Not := False
					;StringRight, num, re_2, 1
					center := glob_spaceFileObj[re_2]
					if(absoleNotFlag == False) {
						center := outs_relativeToAbsoluteFromWorkDir(center, lineFile, lineNumber, False)
					}
					if(dbQuoutFlag) {
						center := dbQuouteChar  . center  . dbQuouteChar
					}
					argStr := re_1  . center  . re_3
				} else {
					break
				}
			} else {
				if(flag_Not) {
					guit_errorAppend("$の置換ができてません", argStr, lineFile, lineNumber)
				}
				break
			}
		}
		if(flag_Not) {
			;guit_errorAppend("$の置換ができてません", argStr, lineFile, lineNumber)
		} else {
			; 初期化する
			glob_spaceFileObj := Object()
		}
	}
	return  argStr
}
*/



; 文字列の中からファイル名を探して $111$ などの文字に置換する
heard_searchReplaceFilePath(argStr){
	argStr := Trim(argStr)
	IfNotInString, argStr, %A_Space%
	{
		return argStr
	}
	if(func_myFileExist(argStr))
	{
		glob_spaceFileObj.Insert(argStr)
		argStr = $111$
		return  argStr
	}

 	buffObj := Object()
	;buff =
	i = 1
	Loop, 15	;最大でも15回
	{
;guit_errorAppend("初め  " . i  . "  " . A_LineNumber  . "  " . argStr)
		if(func_myFileExist(argStr))
		{
;guit_errorAppend("初めでファイル決定  " . i  . "  " . A_LineNumber  . "  " . argStr)
			glob_spaceFileObj.Insert(argStr)
			buff := "$" . glob_spaceFileNum . glob_spaceFileNum . glob_spaceFileNum  . "$"
			glob_spaceFileNum++
			buffObj.Insert(buff)
			break
		}
		IfInString, argStr, %A_Space%
		{
			StringGetPos, index, argStr, %A_Space% , L1
			StringLeft, leftStr, argStr, %index%
;guit_errorAppend("初め leftStr  " . i  . "  " . A_LineNumber  . "  " . leftStr)
			if(func_myFileExist(leftStr))
			{
				glob_spaceFileObj.Insert(leftStr)
				buff := "$" . glob_spaceFileNum . glob_spaceFileNum . glob_spaceFileNum  . "$"
				glob_spaceFileNum++
				buffObj.Insert(buff)
				index++
				StringTrimLeft, rightStr, argStr, %index%
				rightStr := Trim( rightStr )
				argStr = %rightStr%
;guit_errorAppend("ファイル名決定  leftStr  " . i  . "  " . A_LineNumber  . "  " . leftStr)
			} else {
				; ファイル名の可能性がある場合、ややこしい処理
				if( func_myFileExist(leftStr  . "*") )
				{
					argStr := heard_searchFileLoop(argStr, buffObj)
				} else {
;guit_errorAppend("notFile argStr  " . i  . "  " . A_LineNumber  . "  " . argStr)
					buffObj.Insert(leftStr)
					index++
					StringTrimLeft, rightStr, argStr, %index%
					rightStr := Trim( rightStr )
					argStr = %rightStr%
;guit_errorAppend("notFile rightStr  " . i  . "  " . A_LineNumber  . "  " . argStr)
				}	; 	IfExist, %leftStr%*
			}	; ifExist, %leftStr%
		} else {
			buffObj.Insert(argStr)
;guit_errorAppend("noSpace  " . i  . "  " . A_LineNumber  . "  " . argStr)
			break
		}	; 	IfInString, argStr, %A_Space%
		i++
	}	; Loop
	glob_spaceFileNum = 1	; 元に戻す
	buffStr =
	for key, value in  buffObj {
		buffStr .= value  . " "
	}
	buffStr := RTrim(buffStr)
	return  buffStr
}

; 昔のバージョン
; 文字列の中からファイル名を探して $1$ などの文字に置換する
; textOut もする
heard_searchReplaceFilePathTextOut(argStr){
	; ここで %% と ## を展開
	argStrTmp := outs_textOutTrimss(argStr)
	argStrTmp := Trim(argStrTmp)
	IfNotInString, argStrTmp, %A_Space%
	{
		return argStrTmp
	}
	if(func_myFileExist(argStrTmp))
	{
		glob_spaceFileObj.Insert(argStrTmp)
		argStr = $1$
		return  argStr
	}

 	buffObj := Object()
	;buff =
	i = 1
	Loop, 15	;最大でも15回
	{
;guit_errorAppend("初め  " . i  . "  " . A_LineNumber  . "  " . argStrTmp)
		if(func_myFileExist(argStrTmp))
		{
;guit_errorAppend("初めでファイル決定  " . i  . "  " . A_LineNumber  . "  " . argStrTmp)
			glob_spaceFileObj.Insert(argStrTmp)
			buff := "$" . glob_spaceFileNum  . "$"
			glob_spaceFileNum++
			buffObj.Insert(buff)
			break
		}
		IfInString, argStrTmp, %A_Space%
		{
			StringGetPos, index, argStrTmp, %A_Space% , L1
			StringLeft, leftStr, argStrTmp, %index%
;guit_errorAppend("初め leftStr  " . i  . "  " . A_LineNumber  . "  " . leftStr)
			if(func_myFileExist(leftStr))
			{
				glob_spaceFileObj.Insert(leftStr)
				buff := "$" . glob_spaceFileNum  . "$"
				glob_spaceFileNum++
				buffObj.Insert(buff)
				index++
				StringTrimLeft, rightStr, argStrTmp, %index%
				rightStr := Trim( rightStr )
				argStrTmp = %rightStr%
;guit_errorAppend("ファイル名決定  leftStr  " . i  . "  " . A_LineNumber  . "  " . leftStr)
			} else {
				; ファイル名の可能性がある場合、ややこしい処理
				if( func_myFileExist(leftStr  . "*") )
				{
					argStrTmp := heard_searchFileLoop(argStrTmp, buffObj)
				} else {
;guit_errorAppend("notFile argStr  " . i  . "  " . A_LineNumber  . "  " . argStrTmp)
					buffObj.Insert(leftStr)
					index++
					StringTrimLeft, rightStr, argStrTmp, %index%
					rightStr := Trim( rightStr )
					argStrTmp = %rightStr%
;guit_errorAppend("notFile rightStr  " . i  . "  " . A_LineNumber  . "  " . argStrTmp)
				}	; 	IfExist, %leftStr%*
			}	; ifExist, %leftStr%
		} else {
			buffObj.Insert(argStrTmp)
;guit_errorAppend("noSpace  " . i  . "  " . A_LineNumber  . "  " . argStrTmp)
			break
		}	; 	IfInString, argStrTmp, %A_Space%
		i++
	}	; Loop
	glob_spaceFileNum = 1	; 元に戻す
	buffStr =
	for key, value in  buffObj {
		buffStr .= value  . " "
	}
	buffStr := RTrim(buffStr)
	return  buffStr
}

; ややこしい処理。ファイル名と認識されるまで、または絶対違うと認識するまでループして調べる
heard_searchFileLoop(argStrTmp, buffObj){
	i = 2	; ２からスタート
	rightStr =
	Loop, 20	;最大でも20回 (空白が20以上あるファイル名は諦める)
	{
		StringGetPos, index_2, argStrTmp, %A_Space% , L%i%

		; i 番目の空白がない場合（最後まで調べた場合）(ファイル名でないと分かったので)、1つめの空白で区切った値を返すようにする
		if(index_2 == -1){
			StringGetPos, index_2_1, argStrTmp, %A_Space% , L1
			StringLeft, leftStr_1, argStrTmp, %index_2_1%
			buffObj.Insert(leftStr_1)
			index_2_1++
			StringTrimLeft, rightStr, argStrTmp, %index_2_1%
			rightStr := Trim( rightStr )
;guit_errorAppend("ループ notSpace  rightStr  " . i  . "  " . A_LineNumber . "  " . rightStr)
			break
		}

		StringLeft, leftStr, argStrTmp, %index_2%
		if(func_myFileExist(leftStr))
		{
			glob_spaceFileObj.Insert(leftStr)
			buff := "$" . glob_spaceFileNum . glob_spaceFileNum . glob_spaceFileNum  . "$"
			glob_spaceFileNum++
			buffObj.Insert(buff)
			index_2++
			StringTrimLeft, rightStr, argStrTmp, %index_2%
			rightStr := Trim( rightStr )
;guit_errorAppend("ループ ファイル決定  leftStr  " . i  . "  " . A_LineNumber . "  " . leftStr)
			break
		} else {
			if( func_myFileNotExit(leftStr  . "*") )
			{
				; ファイル名でないと分かった場合、1つめの空白で区切った値を返すようにする
				StringGetPos, index_2_1, argStrTmp, %A_Space% , L1
				StringLeft, leftStr_1, argStrTmp, %index_2_1%
				buffObj.Insert(leftStr_1)
				index_2_1++
				StringTrimLeft, rightStr, argStrTmp, %index_2_1%
				rightStr := Trim( rightStr )
;guit_errorAppend("ループnotFile  leftStr  " . i  . "  " . A_LineNumber . "  " . leftStr)
;guit_errorAppend("ループnotFile  leftStr_2  " . i  . "  " . A_LineNumber . "  " . leftStr_1)
;guit_errorAppend("ループnotFile  rightStr  " . i  . "  " . A_LineNumber . "  " . rightStr)
				break
			}
;guit_errorAppend("ループ繰り返し決定時  " . i  . "  " . A_LineNumber)
		}
		i++
	}	; Loop
	return  rightStr
}

; 改良版。日本語でも、不具合が起きにくくしている。
; " @111@ " とか文字を元に戻す処理
; absoleNotFlag に False を入れると絶対パスに変更して返す
heard_dbQuouteReplaceReturn(inputArgss, lineFile, lineNumber, dbPlusFlag, absoleNotFlag) {
	IfNotInString, inputArgss, @
	{
		return inputArgss
	}

	dbQuouteChar := """"
	changeStr := inputArgss
	tagetNum = 1

	Loop, 15
	{
		res := False
		if(A_Index == 15){
			guit_errorAppend("@の展開を15回して、停止した`n" . inputArgss)
			break
		}

		IfInString, changeStr, @
		{
			StringGetPos, index, changeStr, @, L%tagetNum%
			if(index <= -1){
				break
			}
			indexPlus := index + 1
			StringTrimLeft, rightStr, changeStr, %indexPlus%
			IfInString, rightStr, @
			{
				StringGetPos, index2, rightStr, @
				StringLeft, center, rightStr, %index2%
				center := "@" . center . "@"
				if( heard_replaceSignWordConfirm(center, "@") ){
					; 単純に２番目の文字を取る
					StringTrimLeft, center, center, 1
					StringLeft, LChar, center, 1
					if(LChar != 0){
						StringLeft, leftStr, changeStr, %index%
						index2 += 1
						StringTrimLeft, rightStr_rStr, rightStr, %index2%
						replaceStr := glob_backUp_dq_%LChar%
						if(absoleNotFlag == False){
							replaceStr := outs_relativeToAbsoluteFromWorkDir(replaceStr, lineFile, lineNumber, False)
						}
						; " を付け足す
						if( dbPlusFlag ){
							replaceStr := dbQuouteChar . replaceStr . dbQuouteChar
						}
						changeStr := leftStr . replaceStr . rightStr_rStr
						res := True
					}
				}
			} else {
				; 右の @ がない場合
				break
			}
		} else {
			; @ がない場合
			break
		}
		if( res == False ){
			tagetNum++
		}
	}	; Loop
	return changeStr
}

; 改良版。日本語でも、不具合が起きにくくしている。errorViewFlag を追加した
; "" で囲まれてる文字を glob_backUp_dq_? に保存し @111@ とかに変える処理
heard_dbQuouteReplace(inputArgss, errorViewFlag){
	dbQuouteChar := """"
	IfNotInString, inputArgss, %dbQuouteChar%
	{
		return inputArgss
	}

	changeStr := inputArgss
	dbQuouteNum = 1

	replaceNum = 0
	Loop, 15
	{
		res := False
		if(A_Index == 15){
			if( errorViewFlag ){
				guit_errorAppend("ダブルクオーテの置換を15回して、停止した`n" . inputArgss)
			}
			break
		}
		IfInString, changeStr, %dbQuouteChar%
		{
			StringGetPos, index, changeStr, %dbQuouteChar%, L%dbQuouteNum%
			if(index <= -1){
				break
			}
			indexPlus := index + 1
			StringTrimLeft, rightStr, changeStr, %indexPlus%
			IfInString, rightStr, %dbQuouteChar%
			{
				replaceNum++
				if(replaceNum == 10){
					if( errorViewFlag ){
						guit_errorAppend("ダブルクオーテの置換は９つまでしか対処していない。`n" . inputArgss)
					}
					break
				}

				StringGetPos, index2, rightStr, %dbQuouteChar%
				StringLeft, center, rightStr, %index2%

				StringLeft, leftStr, changeStr, %index%
				index2 += 1
				StringTrimLeft, rightStr_rStr, rightStr, %index2%

				glob_backUp_dq_%replaceNum% := center
				; "@111@" とか
				replaceStr := "@" . replaceNum . replaceNum . replaceNum . "@"
				changeStr := leftStr . replaceStr . rightStr_rStr
				res := True
			} else {
				; 右の " がない場合
				break
			}
		} else {
			; # がない場合
			break
		}
		if( res == False ){
			; % や # の時と違って、" は必ず置換するか、breakで抜けるので、意味はないかもしれない
			dbQuouteNum++
		}
	}	; Loop
	return changeStr
}

; 改良版。日本語でも、不具合が起きにくくしている。errorViewFlag を追加した
; "" で囲まれてる文字を glob_backUp_dq_? に保存し " glob_backUp_dq_? " の文字列に変える
; ついでに "" も Trim する
heard_dbQuouteReplaceToValueName(inputArgss, errorViewFlag){
	dbQuouteChar := """"
	IfNotInString, inputArgss, %dbQuouteChar%
	{
		return inputArgss
	}

	; "" の文字があったら、null の文字に置き換える
	;dbdbQuouteDb := dbQuouteChar . dbQuouteChar
	;IfInString, inputArgss, %dbdbQuouteDb%
	;{
	;	StringReplace, inputArgss, inputArgss, %dbdbQuouteDb% , null, All
	;}

	changeStr := inputArgss
	dbQuouteNum = 1

	replaceNum = 0
	Loop, 15
	{
		res := False
		if(A_Index == 15){
			if( errorViewFlag ){
				guit_errorAppend("ダブルクオーテの置換を15回して、停止した`n" . inputArgss)
			}
			break
		}
		IfInString, changeStr, %dbQuouteChar%
		{
			StringGetPos, index, changeStr, %dbQuouteChar%, L%dbQuouteNum%
			if(index <= -1){
				break
			}
			indexPlus := index + 1
			StringTrimLeft, rightStr, changeStr, %indexPlus%
			IfInString, rightStr, %dbQuouteChar%
			{
				replaceNum++
				if(replaceNum == 10){
					if( errorViewFlag ){
						guit_errorAppend("ダブルクオーテの置換は９つまでしか対処していない。`n" . inputArgss)
					}
					break
				}

				StringGetPos, index2, rightStr, %dbQuouteChar%
				StringLeft, center, rightStr, %index2%

				StringLeft, leftStr, changeStr, %index%
				index2 += 1
				StringTrimLeft, rightStr_rStr, rightStr, %index2%

				;center := Trim( center, dbQuouteChar )
				
				; `n の文字列を改行に置換
				center := func_linefeedReplace(center)
				glob_backUp_dq_%replaceNum% := center
				; " glob_backUp_dq_1 " とかの文字列
				replaceStr := "glob_backUp_dq_" . replaceNum
				changeStr := leftStr . replaceStr . rightStr_rStr
				res := True
			} else {
				; 右の " がない場合
				break
			}
		} else {
			; # がない場合
			break
		}
		if( res == False ){
			; % や # の時と違って、" は必ず置換するか、breakで抜けるので、意味はないかもしれない
			dbQuouteNum++
		}
	}	; Loop
	return changeStr
}


/*
; " @1@ " とか文字を元に戻す処理
; absoleNotFlag に False を入れると絶対パスに変更して返す
 昔のバージョン
heard_dbQuouteReplaceReturn(inputArgss, lineFile, lineNumber, absoleNotFlag=True) {
	IfInString, inputArgss, @
	{
		flag_Not := True
		Loop, 5
		{
			RegExMatch(inputArgss, "i)^([\w\W]*)@([\d]+)@([\w\W]*)" , re_ )
			if(re_2 != ""){
				If re_2 is integer
				{
					flag_Not := False
					;StringRight, num, re_2, 1
					center := glob_backUp_dq_%re_2%
					if(absoleNotFlag == False){
						center := outs_relativeToAbsoluteFromWorkDir(center, lineFile, lineNumber, False)
					}
					inputArgss := re_1  . center  . re_3
				} else {
					break
				}
			} else {
				if(flag_Not) {
					guit_errorAppend("@の置換ができてません", inputArgss, lineFile, lineNumber)
				}
				break
			}
		}
	}
	return  inputArgss
}




; "" で囲まれてる文字を glob_backUp_dq_? に保存し " @1@ " とかに変える処理
 昔のバージョン
heard_dbQuouteReplace(inputArgss, dbTrimFlag, lineFile, lineNumber) {
	dbQuouteChar := """"
	IfInString, inputArgss, %dbQuouteChar%
	{
		i = 0
		Loop, 7		; 最大でも5回。６回目の途中で中断される
		{
			if(A_Index == 7){
				guit_errorAppend("ダブルクオーテの置換は５つまでしか対処できない。`n" . inputArgss)
				break
			}

			res := RegExMatch(inputArgss, "i)^([^""]*)(""[^""]*"")([\w\W]*)" , dq_ )	; "
			if(res == 1){
				i++
				if( dbTrimFlag ){
					dq_2 := Trim( dq_2, dbQuouteChar )
				}
				; `n の文字列を改行に置換
				;dq_2 := func_linefeedReplace(dq_2)

				glob_backUp_dq_%i% := dq_2
				dq_2 :=  " @" . i . "@ "		; " @1@ " とか
				inputArgss := dq_1  . dq_2  . dq_3
			} else {
				if(i == 0) {
					guit_errorAppend("ダブルクオーテの置換ができてません`n" . inputArgss, lineFile, lineNumber)
				}
				break
			}
		}
		if(i == 0) {
			;guit_errorAppend("ダブルクオーテの置換ができてません`n" . inputArgss, lineFile, lineNumber)
		}
	}
	return  inputArgss
}



; "" で囲まれてる文字を glob_backUp_dq_? に保存し " glob_backUp_dq_? " の文字列に変える
; ついでに "" も Trim する
 昔のバージョン
heard_dbQuouteReplaceToValueName(inputArgss, lineFile, lineNumber) {
	dbQuouteChar := """"
	; "" の文字があったら、null の文字に置き換える
	dbdbQuouteDb := dbQuouteChar . dbQuouteChar
	IfInString, inputArgss, %dbdbQuouteDb%
	{
		StringReplace, inputArgss, inputArgss, %dbdbQuouteDb% , null, All
	}

	IfInString, inputArgss, %dbQuouteChar%
	{
		i = 0
		Loop, 7		; 最大でも5回。６回目の途中で中断される
		{
			if(A_Index == 7){
				guit_errorAppend("ダブルクオーテの置換は５つまでしか対処できない。`n" . inputArgss)
				break
			}

			res := RegExMatch(inputArgss, "i)^([^""]*)(""[^""]*"")([\w\W]*)" , dq_ )	; "
			if(res == 1){
				i++
				dq_2 := Trim( dq_2, dbQuouteChar )
				; `n の文字列を改行に置換
				dq_2 := func_linefeedReplace(dq_2)

				glob_backUp_dq_%i% := dq_2
				dq_2 :=  "glob_backUp_dq_" . i		; " glob_backUp_dq_1 " とかの文字列
				inputArgss := dq_1  . dq_2  . dq_3
			} else {
				if(i == 0) {
					guit_errorAppend("ダブルクオーテの置換ができてません`n" . inputArgss, lineFile, lineNumber)
				}
				break
			}
		}
		if(i == 0) {
			;guit_errorAppend("ダブルクオーテの置換ができてません`n" . inputArgss, lineFile, lineNumber)
		}
	}
	return  inputArgss
}
*/


; @111@ や $111$ の文字なら、True
heard_replaceSignWordConfirm(target, replaceSign){
	StringLen, targetLen, target
	if( targetLen != 5 ){
		return False
	}
	StringLeft, LChar, target, 1
	if(LChar != replaceSign){
		return False
	}
	StringRight, rChar, target, 1
	if(rChar != replaceSign){
		return False
	}
	StringTrimLeft, target, target, 1
	StringTrimRight, target, target, 1
	; replaceSign を取り除いた状態
	StringLeft, LChar, target, 1
	StringTrimLeft, target2, target, 1
	StringLeft, centerChar, target2, 1
	StringRight, rChar, target, 1
	if(LChar == centerChar){
		if(LChar == rChar){
			If target is integer
			{
				return True
			}
		}
	}
	return False
}

;  %1 %2 とかの最大値を調べる
heard_maxOfParsentNum(objArgss, lineFile, lineNumber) {
	parsentChar := "%"
	pasentAstrics := "%*"
	argMax = 0
	pasentAstricsFlag := False	; %* があったかどうか(後の確認のため使う)

	Loop , 9		; 最大でも9 回
	{
		IfInString, objArgss, %pasentAstrics%
		{
			pasentAstricsFlag := True
			res := RegExMatch(objArgss, "^([\w\W]*)%\*([\w\W]*)$", reg_ )
			objArgss := reg_1 . reg_2
		}
		; 下の方法では %変数名% などの文字があると、中断してしまう
		;res := RegExMatch(objArgss, "^([^%]*)%(\d)([\w\W]*)$", parsentNum_ )
		res := RegExMatch(objArgss, "^([\w\W]*)%(\d)([\w\W]*)$", parsentNum_ )
		if(res == 1){
			if(parsentNum_2 > argMax) {
				if(parsentNum_2 < 10) {
					argMax = %parsentNum_2%
				}
			}
			;objArgss := parsentNum_3
			parsentD := parsentChar  . parsentNum_2
			StringReplace, objArgss, objArgss, %parsentD% , %A_Space%
		} else {
			break
		}
	}

	if(pasentAstricsFlag){		;  %* があったときはいいが

	} else if(argMax == 0) {	;  それ以外で %num  の最大値が0の場合、トラブル
		guit_errorAppend("%1 %2 などの値がうまく認識されていません", lineFile, lineNumber)
	}

	return  argMax
}


heard_itemArgssUse_Cust(objArgss, inputArgss, file){
	;inputArgss := outs_textOutTrimss(inputArgss)
	;objArgss := outs_textOutTrimss(objArgss)
	; 下の関数
	objArgss := heard_itemArgssLogic_Cust(objArgss, inputArgss, file)
	; ##と%%の処理をする
	objArgss := outs_textOutTrimss(objArgss)
	return  objArgss
}


; %* や %1 などを 引数と置換する
; (" " で囲むと 空白があっても引数を分割しない)
heard_itemArgssLogic_Cust(objArgss, inputArgss, file){

	; %--  の文字があるなら、引数の処理をしない。引数の追加もしない。
	parsentMinus := "%--"
	tmpObjArgss := RTrim( objArgss, "`r`n" )
	tmpObjArgss := RTrim( tmpObjArgss )
	StringRight, right3Str, tmpObjArgss, 3
	if(right3Str == parsentMinus){
		; %--  の文字を消す
		StringTrimRight, tmpObjArgss, tmpObjArgss, 3
		tmpObjArgss := RTrim(tmpObjArgss)
		return  tmpObjArgss
	}

	; 文字の中に %* か %1 などがあるか調べる  あるなら True を返す
	res := heard_confilmArgssParsentReplace(objArgss)
	if(res == False){
		str := objArgss  . " " . inputArgss  . " " . file
		str := Trim(str)
		return  str
	}

	if(file != "") {
		inputArgss := inputArgss  . " " . file
	}

	parsentChar := "%"
	pasentAstrics := "%*"
	dbQuouteChar := """"
	delimiter := ","
	delimiterSpace := ", "
	;objArgss := RegExReplace(objArgss, "\s+" , " ")
	;inputArgss := RegExReplace(inputArgss, "\s+" , " ")

	astricsStr =
	argMax = 0
	inputArg_0 =
	inputArg_1 =
	inputArg_2 =
	inputArg_3 =
	inputArg_4 =
	inputArg_5 =
	inputArg_6 =
	inputArg_7 =
	inputArg_8 =
	inputArg_9 =
	inputArg_10 =

	;  %1 %2 とかの最大値を調べる
	argMax := heard_maxOfParsentNum(objArgss, A_LineFile, A_LineNumber)

	; 引数１が , であれば、 , を区切り文字として使用する（%1 などがある場合のみ）
	StringLeft, lChr, inputArgss, 2
	if( lChr == delimiterSpace ){
		; 左端の , を取り除く。これをすることで
		; inputArg_1 にカラの文字が入り、inputArg_2 以降に１つずつずれるのを解消する。
		StringTrimLeft, inputArgss, inputArgss, 2
		IfInString, inputArgss, %delimiter%
		{
			StringSplit, inputArg_ , inputArgss, %delimiter%, %A_Space%
		} else {
			; 左端の , を取り除いた場合、, が他にない場合
			inputArg_0 = 1
			inputArg_1 = %inputArgss%
		}
	} else {
		; "" で囲まれてる文字を glob_backUp_dq_? に保存し " @111@ " とかに変える処理
		IfInString, inputArgss, %dbQuouteChar%
		{
			inputArgss := heard_dbQuouteReplace(inputArgss, True)
		}

		; ファイル名を見つけて $1$ などに置換する
		;if(glob_iniSpaceFileNotFlag == False){
		if(O_spaceFileNotFlag == False){
			inputArgss := heard_searchReplaceFilePath(inputArgss)
		}


		inputArgss := Trim( inputArgss )

		; 連続してるスペースを１つにする。

		;このやり方では改行まで削除されるので、止める
		;inputArgss := RegExReplace(inputArgss, "\s+" , " ")
		inputArgss := func_spaceChangeOnlyOne(inputArgss)

		; 空白で分割して
		StringSplit, inputArg_ , inputArgss, %A_Space%


		; $1$ などの文字をファイル名に戻す
		;if(glob_iniSpaceFileNotFlag == False){
		if(O_spaceFileNotFlag == False){
			Loop , %inputArg_0%
			{
				IfInString, inputArg_%A_Index%, $
				{
					tmpIndexStr := inputArg_%A_Index%
					tmpIndexStr := Trim(tmpIndexStr)
					if( heard_replaceSignWordConfirm(tmpIndexStr, "$") ){
						; 単純に２番目の文字を取る
						StringTrimLeft, tmpIndexStr, tmpIndexStr, 1
						StringLeft, LChar, tmpIndexStr, 1
						tmpIndexStr := glob_spaceFileObj[LChar]
						inputArg_%A_Index% := Trim(tmpIndexStr)
					}
				}
			}
			glob_spaceFileObj := Object()	; 初期化する
		}


		; その後  ""の文字列を早速戻す
		Loop , %inputArg_0%
		{
			IfInString, inputArg_%A_Index%, @
			{
				tmpIndexStr := inputArg_%A_Index%
				tmpIndexStr := Trim(tmpIndexStr)
				inputArg_%A_Index% := heard_dbQuouteReplaceReturn(tmpIndexStr, A_LineFile, A_LineNumber, True, True)
				;if( heard_replaceSignWordConfirm(tmpIndexStr, "@") ){
				;	; 単純に２番目の文字を取る
				;	StringTrimLeft, tmpIndexStr, tmpIndexStr, 1
				;	StringLeft, LChar, tmpIndexStr, 1
				;	inputArg_%A_Index% := glob_backUp_dq_%LChar%
				;}
			}
		}

		/*
		;  相対パスを絶対パスに変える
		Loop , %inputArg_0%
		{
			IfInString, inputArg_%A_Index%, .\
			{
				inputArg_%A_Index% := outs_relativeToAbsoluteFromWorkDir(inputArg_%A_Index%, A_LineFile, A_LineNumber, False)
			}
		}
		*/
	}

	; %* に入るであろう  引数を前もって作る
	length := inputArg_0 - argMax
	if(length > 0) {
		Loop , %length%
		{
			argMax++
			astricsStr .= inputArg_%argMax%  . " "
		}
	}

	;  %1 %2 と書いてあるのをここで置換していく
	Loop, 10	; 最大でも１０回
	{
		IfInString, objArgss, %pasentAstrics%
		{
			StringReplace, objArgss, objArgss, %pasentAstrics% , %astricsStr%
;guit_errorAppend(A_Index . "  *  objArgss  " . objArgss)
		}
		IfInString, objArgss, %parsentChar%
		{
			; 下の方法では %変数名% などの文字があると、中断してしまう
			;res := RegExMatch(objArgss, "^([^%]*)%(\d)([\w\W]*)$", parsentNum_ )
			res := RegExMatch(objArgss, "^([\w\W]*)%(\d)([\w\W]*)$", parsentNum_ )
;guit_errorAppend(A_Index . "  parsentNum_2  " . parsentNum_2)
			if(res == 1){
				parsentD := parsentChar  . parsentNum_2
				if(parsentNum_2 <= inputArg_0) {
					inputArg_Eny := inputArg_%parsentNum_2%
					StringReplace, objArgss, objArgss, %parsentD% , %inputArg_Eny%
				} else {
					StringReplace, objArgss, objArgss, %parsentD% , %A_Space%
				}
			} else {
				break
			}
		} else {
			break
		}
;guit_errorAppend(A_Index  . "objArgss  " . objArgss)
	}

;guit_errorAppend("end  " . objArgss)
	return  objArgss

}

; 文字の中に %* か %1 などがあるか調べる  あるなら True を返す
heard_confilmArgssParsentReplace(useArgss){
	parsentChar := "%"
	IfNotInString, useArgss, %parsentChar%
	{
		return  False
	}
	pasentAstrics := "%*"
	IfInString, useArgss, %pasentAstrics%
	{
		return  True
	}
	StringGetPos, count, useArgss, %parsentChar%
	count += 2
	StringLeft, leftStr, useArgss, %count%
	StringRight, rChar, leftStr, 1
	If rChar is integer
	{
		if(rChar > 0  &&  rChar < 10){
			return  True
		}
	}
	return  False
}


; ファイル名や  ""の処理を諦めるならこの関数でいい (使わない予定)
heard_itemExecuteArgssLogic(objArgss, inputArgss, file) {
	argStr =
	indexOfStr := "%"
	IfNotInString, objArgss, %indexOfStr%
	{
		argStr = %inputArgss%
	}
	IfInString,objArgss, %indexOfStr%
	{
		objArgss := RegExReplace(objArgss, "\s+" , " ")
		inputArgss := RegExReplace(inputArgss, "\s+" , " ")
		StringSplit, objArg_ , objArgss, %A_Space%
		StringSplit, inputArg_ , inputArgss, %A_Space%

		astricsStr =
		max = 0
		Loop , %objArg_0%
		{
			res := RegExMatch(objArg_%A_Index%, "^%(\d)$", parsentNum_ )
			if(res == 1){
				if(parsentNum_1 > max) {
					if(parsentNum_1 < 10) {
						max = %parsentNum_1%
					}
				}
			}
		}

		length := inputArg_0 - max
		if(length > 0) {
			max++
			Loop , %length%
			{
				astricsStr .= inputArg_%max%  . " "
				max++
			}
		}

		Loop , %objArg_0%
		{
			if(objArg_%A_Index% == "%*") {
				argStr .= astricsStr
			} else {
				res := RegExMatch(objArg_%A_Index%, "^%(\d)$", parsentNum_ )
				if(res == 1){
					if(parsentNum_1 <= inputArg_0) {
						argStr .= inputArg_%parsentNum_1%  . " "
					}
				} else {
					argStr .= objArg_%A_Index%
				}
			}
		}
	}
	return  argStr
}


; 入力補完時にファイル名かどうかを判定するのに使う
heard_fileNameConfirm(lastStr, str) {
	StringGetPos, enIndex, lastStr, \, R1
	StringLeft, lastEnCut, lastStr, enIndex
	; .  や  ..  だけの時も、ファイル名と判断する
	if(lastEnCut == "."  || lastEnCut == ".."){
		return lastStr
	}

	if( func_myFileExist(lastEnCut) ){
		return lastStr		; ファイル名と判定
	}
	; ややこしい処理へ移行
	str :=  heard_findFileOrHeadUntillLoop(str)
	return str
}

; ファイル名と判断されるかどうか先頭まで調べるループ
heard_findFileOrHeadUntillLoop(str){
	i = 1
	Loop
	{
		i++
		StringGetPos, index, str, %A_Space%, R%i%
		if(index > -1){
			index++
			StringTrimLeft, agoSpaceStr, str, index
			agoSpaceStr := LTrim(agoSpaceStr)
			StringGetPos, enIndex, agoSpaceStr, \, R1
			StringLeft, enCut, agoSpaceStr, enIndex
			IfExist, %enCut%			; ファイルと判定
			{
				return agoSpaceStr
			}
		} else {		; 先頭のを調べる
			StringGetPos, enIndex, str, \, R1
			StringLeft, headStrEnCut, str, enIndex
			IfExist, %headStrEnCut%
			{
				return  str
			}
			;  \ がついてるのにファイル名でなかったのでありえない値を返す
			return  "@@@@@"
		}
	}
}
