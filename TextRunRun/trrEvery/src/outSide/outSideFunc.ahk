; 必須 glob guf func


; リスト名を更新するときに使う
outs_reloadListTitle(iniFile, dir, outList, GuiNum, loopCount){
	;func_fileCheckMakeFolderAndFolder(iniFile, dir)
	buff := "|"
	Loop , %loopCount%
	{
		IniRead, titleTmp, %iniFile%, __listTitle, titleName%A_Index% , set%A_Index%
		titleTmp := Trim(titleTmp)
		if(titleTmp == ""){
			titleTmp := "set" . A_Index
		}
		if(A_Index == 1){
			buff .= titleTmp  . "|"
		} else {
			buff .= "|" . titleTmp
		}
	}

	buff := RTrim(buff, "|")
	guf_setControl( buff, outList, GuiNum )
}

outs_deleteAndMakeFile(file, parentFolder=""){
	if( func_myFileExist(file) ){
		func_folderCheckMakeFolder(parentFolder)
		FileDelete, %file%
		FileAppend, %null%, %file%
		if( reouts_checkErrorLevel(file  . "`n`tを空にする時にエラー") ){
			return  True
		}
	}
	return  False
}

outs_checkIsLabel(name, GuiNum){
	num := IsLabel(name)
	if(num == 1){
		return True
	}
	reouts_easyExplain("そのサブルーチンは存在しない`n" . name, GuiNum)
	return False
}

; 指定した画像ファイルがあったら、バックグラウンドとして使用する。
/*
outs_bgPictureAdd(file, option, GuiNum){
	if( func_myFileExist(file) ){
		Gui, %GuiNum%:Add, Picture, %option%, %file%
		return True
	}
	return False
}
*/

; 拡張子なしのファイルパスを指定する。
; 指定した画像ファイルがあったら、バックグラウンドとして使用する。
outs_bgPictureAddEnyExtFile(noExtFile, option, GuiNum){
	; noExtFile は拡張子がないファイル名
	; いろんな拡張子に対応させる
	existFlag := False
	file =

	gifFile := noExtFile . ".gif"
	jpgFile := noExtFile . ".jpg"
	jpegFile := noExtFile . ".jpeg"
	pngFile := noExtFile . ".png"

	if( func_myFileExist(gifFile) ){
		existFlag := True
		file := gifFile
	} else if( func_myFileExist(jpgFile) ){
		existFlag := True
		file := jpgFile
	} else if( func_myFileExist(jpegFile) ){
		existFlag := True
		file := jpegFile
	} else if( func_myFileExist(pngFile) ){
		existFlag := True
		file := pngFile
	}

	if( existFlag ){
		Gui, %GuiNum%:Add, Picture, %option%, %file%
	}
	return existFlag
}

; outs_bgPictureAddEnyExtFile()  を使い、
; 指定した画像が無かった場合は、Text を追加して代用する
outs_bgPictureAddEnyExtFileOrText(secondStr, noExtFile, option, GuiNum){
	existFlag := outs_bgPictureAddEnyExtFile(noExtFile, option, GuiNum)
	if( existFlag == False ){
		Gui, %GuiNum%:Add, Text, %option% Center Border, %secondStr%
		return existFlag
	}
	return existFlag
}

; アイコンに使う画像ファイルを返り値に返す。無ければカラの文字
outs_iconPictureEnyExtFile(noExtFile){
	; noExtFile は拡張子がないファイル名
	; いろんな拡張子に対応させる
	file =

	pngFile := noExtFile . ".png"
	gifFile := noExtFile . ".gif"
	iconFile := noExtFile . ".ico"

	if( func_myFileExist(pngFile) ){
		file := pngFile
	} else if( func_myFileExist(gifFile) ){
		file := gifFile
	} else if( func_myFileExist(iconFile) ){
		file := iconFile
	}
	return file
}

outs_isNotFile(str, errorMessage) {
	IfExist, %str%
	{
		return False
	}
	reouts_errorMessageOutput(errorMessage)
	return True
}

outs_isNotFolder(str, errorMessage) {
	type := FileExist(str)
	IfInString, type, D
	{
		return False
	}
	reouts_errorMessageOutput(errorMessage)
	return True
}

; 特殊なファイル名の場合エラーにするようにする
; 特殊な文字の場合、True を返す
outs_checkErrorFile(fileName){
	StringRight, str4, fileName, 4
	if(str4 == "\con" || str4 == "\prn" || str4 == "com1" || str4 == "com2"){		; 謎のファイル con だったら
		reouts_errorMessageOutput("例外の文字でファイルが開けません")
		return  True
	}
	return  False
}

outs_similarTxtFile(file){
	;やっぱり拡張子がないのはファイル扱いしない。
	;拡張子がないのも txtファイル扱いする。
	;IfNotInString, file, .
	;{
	;	return True
	;}

	StringLower, file, file
	StringRight, rStr, file, 4
	if(rStr == ".txt" || rStr == ".ahk" || rStr == ".cvs" || rStr == ".log" || rStr == ".trr"){
		return True
	}
	return False
}

outs_getWithinNumOrErrMsg(value, min, max){
	If value is not integer
	{
		reouts_errorMessageOutput("数字以外が指定されている`n値  " . value)
		return "error"
	}
	if(value <= min){
		reouts_errorMessageOutput("数字が小さすぎる`n値  " . value)
		return "error"
	} else if(value >= max){
		reouts_errorMessageOutput("数字が大きすぎる`n値  " . value)
		return "error"
	}
	return value
}

outs_errMsgIfErrorStr(str, viewMsg){
	if( str == "error" ){
		reouts_errorMessageOutput(viewMsg)
		return True
	}
	return False
}

outs_getWithinNumOrBasicAndErrMsg(value, basicValue, min, max, valueName){
	errMsg := valueName . "  の代入のエラー`n初期値を設定する"
	str := outs_getWithinNumOrErrMsg(value, min, max)
	if( outs_errMsgIfErrorStr(str, errMsg) ){
		return basicValue
	}
	return value
}

outs_getFlagByOnOffStrOrBasicAndErrMsg(value, basicValue, valueName){
	errMsg := valueName . "  の代入のエラー`n値  " . value . "`n初期値を設定する"
	flag := func_getFlagByOnOffStrOrErrMsg(value)
	if( outs_errMsgIfErrorStr(flag, errMsg) ){
		return basicValue
	}
	return flag
}

; テキストファイルをＧＵＩに読み込む
outs_fileReadOnGuiEny(file, hwndBoxEdit, pOut, GuiNum, pOrder){
	if(func_txtFileCheck(file) == False){
		reouts_errorMessageOutput("txtファイル以外は読み込めない")
		return
	}
	FileRead, OutputVar, %file%
	res := reouts_checkErrorLevel("ファイルの読み込みにエラーがある")
	if(res == False){
		return
	}

	guf_setControl( OutputVar, pOut, GuiNum )
	guf_showGuiAssign(GuiNum, pOrder)
	ControlSend , , ^{End}, ahk_id  %hwndBoxEdit%
}

outs_getStrFromReadFile(file){
	if( outs_similarTxtFile(file) == False ){
		reouts_errorMessageOutput("このファイルは拡張子の問題で読み込めないようにしている`n" . file)
		return ""
	}
	if( func_myFileNotExit(file) ){
		reouts_errorMessageOutput("このファイルは存在しないので読み込めない`n" . file)
		return ""
	}
	FileRead, outValue, %file%
	res := reouts_checkErrorLevel("ファイルの読み込みにエラーがある")
	if(res == False){
		return ""
	}
	return outValue
}

outs_fileAppendFromBoxEdit(file, pControl, GuiNum){
	if(func_txtFileCheck(file) == False){
		reouts_errorMessageOutput("txtファイルしか指定できない。`n書き込もうとしたファイル`n" . file)
		return  False
	}

	GuiControlGet, %pControl%, %GuiNum%:
	text := %pControl%  . "`n"

	;day := func_getYearMonthDayHourMinSec()
	;text := day  . "`n" . text

	FileAppend , %text%, %file%
	res := reouts_checkErrorLevel("ファイルの書き込みにエラーがある")
	return res
}


/*
outs_strToOutputFile(str, file, parentDir, GuiNum){
	func_folderCheckMakeFolder(parentDir)
	str .= "`n"
	FileAppend , %str%, %file%
	reouts_easyExplain(str  . "  をファイルに追加", GuiNum)
}
*/


; 何度も使うので関数化した。１つのファイルのみ入力してる場合のみ対応
; ##  %%  を処理 し "" を全て取り除いたあと  絶対パスに変更する
; errViewをTrueにするとエラーを表示する
outs_textOutToAbsolePath(com2, absolePathNotFlag, errView=False, LineFile="", LineNumber=""){
	com2 := outs_textOutDqAllTrim(com2)
	if(absolePathNotFlag == False){
		com2 := outs_relativeToAbsoluteFromWorkDir(com2,  LineFile, LineNumber, errView)
	}
	return  com2
}

; ##  %%  を処理 し "" を全て取り除く
outs_textOutDqAllTrim(com2) {
	com2 := outs_textOutTrimss(com2)
	com2 := outs_dbQuouteAllTrim(com2)	; "" を全て取り除く
	com2 := Trim( com2 )
	return  com2
}

; # で囲まれたアイテムのパスを表示させる % で囲まれた変数の中身を表示させる
outs_textOutTrimss(com2) {
	com2 := outs_textOutTrimssSharp(com2)
	com2 := outs_textOutTrimssParsent(com2)
	;com2 := func_linefeedReplace(com2)
	return  com2
}

; # で囲まれたアイテムのパスを表示させる
; 展開後の # でネストされている場合も対応する
outs_textOutTrimssSharp(com2) {
	shapeChar := "#"
	IfNotInString, com2, %shapeChar%
	{
		return com2
	}

	changeStr := com2
	shapeNum = 1

	; 最大でも30回限定
	Loop, 30
	{
		res := False
		if(A_Index >= 30){
			reouts_errorMessageOutput("##の展開を３０回して、停止した`n" . com2)
		}
		IfInString, changeStr, %shapeChar%
		{
			StringGetPos, index, changeStr, %shapeChar%, L%shapeNum%
			if(index <= -1){
				break
			}
			indexPlus := index + 1
			StringTrimLeft, rightStr, changeStr, %indexPlus%
			IfInString, rightStr, %shapeChar%
			{
				StringGetPos, index2, rightStr, %shapeChar%
				StringLeft, center, rightStr, %index2%
				if( reouts_itemNameNGCharacterConfirm(center) ){
					script := reouts_getPathOfItem(center)		; リンク先を調べる
					if(script != ""){
						StringLeft, leftStr, changeStr, %index%
						index2 += 1
						StringTrimLeft, rightStr_rStr, rightStr, %index2%
						if(rightStr_rStr == ""){
							changeStr := leftStr . script
						} else {
							script := outs_fileBackDir(script, rightStr_rStr)
							changeStr := leftStr . script . rightStr_rStr
						}
						res := True
					}
				}
			} else {
				; 右の # がない場合
				break
			}
		} else {
			; # がない場合
			break
		}
		if( res == False ){
			shapeNum++
		}
	}	; Loop

	return changeStr
}

; 改良版。% でネストされている場合でも１度しか展開しない。
; % で囲まれた変数の中身を表示させる
; # と違って、展開後の % でネストされているものは無視する
outs_textOutTrimssParsent(com2) {
	pasentChar := "%"
	IfNotInString, com2, %pasentChar%
	{
		return com2
	}

	returnValue = [error]
	changeStr := com2
	buff =
	pasentNum = 1

	; 最大でも15回限定
	Loop, 15
	{
		res := False
		if(A_Index >= 15){
			reouts_errorMessageOutput("%%の展開を１５回して、停止した`n" . com2)
			buff .= changeStr
			returnValue := buff
			break
		}
		IfInString, changeStr, %pasentChar%
		{
			StringGetPos, index, changeStr, %pasentChar%, L%pasentNum%
			if(index <= -1){
				buff .= changeStr
				returnValue := buff
				break
			}
			indexPlus := index + 1
			StringTrimLeft, rightStr, changeStr, %indexPlus%
			IfInString, rightStr, %pasentChar%
			{
				StringGetPos, index2, rightStr, %pasentChar%
				StringLeft, center, rightStr, %index2%
				resValue := outs_valueValidatorRulesNot(center)
				if( resValue == False ){
					centerValue := outs_ansValuePersent(center)		; 変数の中身を取得
					; ## の時と違い、中身がカラでも続行する

					StringLeft, leftStr, changeStr, %index%
					index2 += 1
					StringTrimLeft, rightStr_rStr, rightStr, %index2%

					buff .= leftStr . centerValue
					if(rightStr_rStr == ""){
						returnValue := buff
						break
					}
					changeStr := rightStr_rStr
					; changeStr は、右側以外は全て取り除いているので、pasentNum は 1 に戻す
					pasentNum = 1
					res := True
				}
			} else {
				; 右の % がない場合
				buff .= changeStr
				returnValue := buff
				break
			}
		} else {
			; % がない場合
			buff .= changeStr
			returnValue := buff
			break
		}
		if( res == False ){
			pasentNum++
		}
	}	; Loop

	if( returnValue == "[error]" ){
		guit_errorAppend("% の展開でエラー`n" . com2)
	}
	return returnValue
}


/*

; % で囲まれた変数の中身を表示させる
 昔のバージョン
outs_textOutTrimssParsent(com2) {
	pasentChar := "%"
	IfNotInString, com2, %pasentChar%
	{
		return com2
	}

	changeStr := com2
	pasentNum = 1

	; 最大でも30回限定
	Loop, 30
	{
		res := False
		if(A_Index >= 30){
			reouts_errorMessageOutput("%%の展開を３０回して、停止した`n" . com2)
		}
		IfInString, changeStr, %pasentChar%
		{
			StringGetPos, index, changeStr, %pasentChar%, L%pasentNum%
			if(index <= -1){
				break
			}
			indexPlus := index + 1
			StringTrimLeft, rightStr, changeStr, %indexPlus%
			IfInString, rightStr, %pasentChar%
			{
				StringGetPos, index2, rightStr, %pasentChar%
				StringLeft, center, rightStr, %index2%
				resValue := outs_valueValidatorRulesNot(center)
				if( resValue == False ){
					centerValue := outs_ansValuePersent(center)		; 変数の中身を取得
					; ## の時と違い、中身がカラでも続行する

					StringLeft, leftStr, changeStr, %index%
					index2 += 1
					StringTrimLeft, rightStr_rStr, rightStr, %index2%
					if(rightStr_rStr == ""){
						changeStr := leftStr . centerValue
					} else {
						changeStr := leftStr . centerValue . rightStr_rStr
					}
					res := True
				}
			} else {
				; 右の % がない場合
				break
			}
		} else {
			; % がない場合
			break
		}
		if( res == False ){
			pasentNum++
		}
	}	; Loop

	return changeStr
}

outs_textOutTrimssSharpOldVersion(com2) {
	shapeChar := "#"
	IfInString, com2, %shapeChar%
	{
		; 最大でも30回限定
		Loop, 30
		{
			if(A_Index >= 30){
				reouts_errorMessageOutput("##の展開を３０回して、停止した")
			}
			res1 := RegExMatch(com2, "i)^([^#]*)#(\w+)#([\w\W]*)" , val_ )
			if(val_2 != ""){
				val_2 := reouts_getPathOfItem(val_2)		; リンク先を調べる
				if(val_2 == ""){
					; リンク先が見つからないので中断
					break
				} else {
					val_2 := outs_fileBackDir(val_2, val_3)
					com2 := val_1 . val_2 . val_3
				}
			} else {
				break
			}
		}
	}
	return com2
}

; % で囲まれた変数の中身を表示させる
outs_textOutTrimssParsentOldVersion(com2) {
	pasentChar := "%"
	IfInString, com2, %pasentChar%
	{
		; 最大でも30回限定
		Loop, 30
		{
			if(A_Index >= 30){
				reouts_errorMessageOutput("%%の展開を３０回して、停止した")
			}
			res := RegExMatch(com2, "i)^([^%]*)%(\w+)%([\w\W]*)" , val_ )
			; ちなみに \s は半角Space \D は半角以外の文字 \\ は \  \wは[0-9a-zA-Z_]と同じ
			if(val_2 != ""){
				val_2 := outs_ansValuePersent(val_2)		; 変数の中身を取得
				if(val_2 == ""){
					; 値が空なので中断
					break
				}
				com2 := val_1 . val_2 . val_3		; 元の値を変更して、ループを繰り返す
			} else {
				break
			}
		}
	}
	return com2
}

outs_dbQuouteStrGet(str) {
	RegExMatch(com2, "i)^([^""]*)""([^""]+)""([\w\W]*)$" , dq_ )	; "
	if(dq_2 != "") {
		return  dq_2
	}
	return  str
}

*/


outs_ansValuePersent(str) {
	res := RegExMatch(str, "^[0-9a-zA-Z_@#$]+$")
	if(res == 1) {
		if (%str% == "") {			; 変数を表示させる
			;reouts_errorMessageOutput("%の値が見つかりません")
		} else {
			str_value2 := %str%
			return str_value2
		}
	} else {
		reouts_errorMessageOutput("変数として使用不可能の文字が入ってます。`n" . str)
	}
	reouts_checkErrorLevel(A_LineFile, A_LineNumber)
	return ""
}

outs_valueValidatorRulesNot(str){
	IfInString, str, %A_Space%
	{
		return True
	}
	res := RegExMatch(str, "^[0-9a-zA-Z_@#$]+$")
	if(res == 1) {
		; 左の文字が数字なら、変数名として認めない
		StringLeft, LChar, str, 1
		If LChar is not number
		{
			return False
		}
	}
	return True
}

; outs_textOutTrimss の １度のみ展開するバージョン
outs_textOutTrimssMinute(com2) {
	com2 := outs_textOutTrimssSharpMinute(com2)
	com2 := outs_textOutTrimssParsentMinute(com2)
	return  com2
}

outs_textOutTrimssSharpMinute(com2) {
	shapeChar := "#"
	IfNotInString, com2, %shapeChar%
	{
		return com2
	}

	changeStr := com2
	shapeNum = 1

	; 最大でも30回限定
	Loop, 30
	{
		res := False
		if(A_Index >= 30){
			reouts_errorMessageOutput("##の展開を３０回して、停止した`n" . com2)
		}
		IfInString, changeStr, %shapeChar%
		{
			StringGetPos, index, changeStr, %shapeChar%, L%shapeNum%
			if(index <= -1){
				break
			}
			indexPlus := index + 1
			StringTrimLeft, rightStr, changeStr, %indexPlus%
			IfInString, rightStr, %shapeChar%
			{
				StringGetPos, index2, rightStr, %shapeChar%
				StringLeft, center, rightStr, %index2%
				if( reouts_itemNameNGCharacterConfirm(center) ){
					script := reouts_getPathOfItem(center)		; リンク先を調べる
					if(script != ""){
						StringLeft, leftStr, changeStr, %index%
						index2 += 1
						StringTrimLeft, rightStr_rStr, rightStr, %index2%
						if(rightStr_rStr == ""){
							changeStr := leftStr . script
						} else {
							script := outs_fileBackDir(script, rightStr_rStr)
							changeStr := leftStr . script . rightStr_rStr
						}
						return changeStr
					}
				}
			} else {
				; 右の # がない場合
				break
			}
		} else {
			; # がない場合
			break
		}
		if( res == False ){
			shapeNum++
		}
	}	; Loop

	return changeStr
}

outs_textOutTrimssParsentMinute(com2) {
	pasentChar := "%"
	IfNotInString, com2, %pasentChar%
	{
		return com2
	}

	changeStr := com2
	pasentNum = 1

	; 最大でも30回限定
	Loop, 30
	{
		res := False
		if(A_Index >= 30){
			reouts_errorMessageOutput("##の展開を３０回して、停止した`n" . com2)
		}
		IfInString, changeStr, %pasentChar%
		{
			StringGetPos, index, changeStr, %pasentChar%, L%pasentNum%
			if(index <= -1){
				break
			}
			indexPlus := index + 1
			StringTrimLeft, rightStr, changeStr, %indexPlus%
			IfInString, rightStr, %pasentChar%
			{
				StringGetPos, index2, rightStr, %pasentChar%
				StringLeft, center, rightStr, %index2%
				resValue := outs_valueValidatorRulesNot(center)
				if( resValue == False ){
					centerValue := outs_ansValuePersent(center)		; 変数の中身を取得
					; ## の時と違い、中身がカラでも続行する

					StringLeft, leftStr, changeStr, %index%
					index2 += 1
					StringTrimLeft, rightStr_rStr, rightStr, %index2%
					if(rightStr_rStr == ""){
						changeStr := leftStr . centerValue
					} else {
						changeStr := leftStr . centerValue . rightStr_rStr
					}
					return changeStr
				}
			} else {
				; 右の % がない場合
				break
			}
		} else {
			; % がない場合
			break
		}
		if( res == False ){
			pasentNum++
		}
	}	; Loop

	return changeStr
}

outs_textOutTrimssSharpMinuteOldVersion(com2) {
	res1 := RegExMatch(com2, "i)^([^#]*)#(\w+)#([\w\W]*)" , val_ )
	if(val_2 != ""){

		val_2 := reouts_getPathOfItem(val_2)
		if(val_2 == ""){
			;reouts_errorMessageOutput("リンク先が見つかりません")
		} else {
			val_2 := outs_fileBackDir(val_2, val_3)
			com2 := val_1 . val_2 . val_3
		}
	}
	return  com2
}

outs_textOutTrimssParsentMinuteOldVersion(com2) {
	res := RegExMatch(com2, "i)^([^%]*)%(\w+)%([\w\W]*)" , val_ )

	; ちなみに \s は半角Space \D は半角以外の文字 \\ は \  \wは[0-9a-zA-Z_]と同じ
	if(val_2 != ""){
		val_2 := outs_ansValuePersent(val_2)		; 変数の中身を取得
		if(val_2 == ""){				; 変数の中身がなかったら中断
			;reouts_errorMessageOutput("値が空なので中断します")
		} else {
			com2 := val_1 . val_2 . val_3		; 元の値を変更して、ループを繰り返す
		}
	}
	return  com2
}

; outs_textOutDqAllTrim  の  ループを使わないバージョン
outs_textOutDqAllTrimMinute(com2) {
	IfInString, com2, #
	{
		com2 := outs_textOutTrimssMinute(com2)
	} else {
		IfInString, com2, `%
		{
			com2 := outs_textOutTrimssMinute(com2)
		}
	}
	return  com2
}


;  bluewind と同じように 最後に\ をつけると上のフォルダを表すようにする
outs_fileBackDir(val_2, val_3){
	StringLeft, OutputVar, val_3, 1			; val_3 の最初が \ だったら
	if(OutputVar == "\"){
		; outs_textOutTrimssSharpMinute は再帰的処理になる
		; 一度だけでなく、## がなくなるまで十分再帰的処理を繰り返す
		tmpVal_2 := outs_textOutTrimssSharpMinute(val_2)
		; 一度だけでなく、 %% も無くなるまで繰り返す
		tmpVal_2 := outs_textOutTrimssParsent(tmpVal_2)
		type := FileExist(tmpVal_2)
		if(type != ""){
			IfNotInString, type, D		; フォルダではないとき
			{
				;tmpVal_2 := outs_relativeToAbsoluteFromWorkDir(tmpVal_2, A_LineFile, A_LineNumber, False)
				dir := outs_getParentDir(tmpVal_2, 1, A_LineFile, A_LineNumber, False)
				val_2 := RTrim( dir, "\" )
			}
		}
	}
	return  val_2
}


; "" を全て取り除く
outs_dbQuouteAllTrim(com2) {
	dbQuouteChar := """"
	IfInString, com2, %dbQuouteChar%
	{
		Loop , 10
		{
			res := RegExMatch(com2, "i)^([^""]*)""([^""]*)""([\w\W]*)$" , dq_ )	; "
			if(res == 1) {
				com2 := dq_1  . " " . dq_2  . " " . dq_3
			} else {
				break
			}
		}
	}
	;com2 := Trim( com2 )
	return  com2
}

; ファイル名なら""をつけて返すようにする
outs_orFileToDbQuoute(str){
	tmpStr := outs_textOutTrimss(str)
	if( func_myFileExist(tmpStr) )
	{
		dbQuCha := """"
		str := dbQuCha  . str  . dbQuCha
	}
	return str
}

; ファイル名なら""をつけて返すようにする
outs_orFileToDbQuouteNotTextOut(str){
	if(func_myFileExist(str))
	{
		dbQuCha := """"
		str := dbQuCha  . str  . dbQuCha
	}
	return str
}

outs_relativeToAbsoluteFromWorkDir(p_strArg, LineFile, LineNumber, errView=True){
	str := outs_relativePathToAbsolutePath(p_strArg, A_WorkingDir, LineFile, LineNumber, errView=True)
	return  str
}

; 現時点ではフォルダ名のあとに \ が付いたり付かなかったりするので、後にファイル名をつける場合は注意が必要
outs_relativePathToAbsolutePath(p_strArg, curDir, LineFile, LineNumber, errView=True){
	; はじめに " " で囲まれてるファイルに対する処理を追加した
	dbQuouteFlag  := False
	p_str := p_strArg
	p_strTrim := Trim(p_str)
	if(p_strTrim == ""){
		return  p_strArg
	}
	type := func_myFileExistReturnType(curDir)
	IfNotInString, type, D
	{
		if( errView ){
			reouts_errorMessageOutput("絶対パスの変換のエラー。`n基準の位置がフォルダではない`n" . curDir)
		}
		return  p_strArg
	}
	StringLeft, lchr, p_str, 1
	if(lchr == """"){
		StringRight, rchr, p_str, 1
		if(rchr == """"){
			dbQuouteFlag  := True
			p_str := Trim( p_str, """" )
		}
	}
	if( func_myFileNotExit(p_str) )
	{
		curDir := RTrim( curDir, "\" )
		tmpConfilmp_str := curDir  . "\" . p_str
		if( func_myFileNotExit(tmpConfilmp_str) )
		{
			if(errView){
				reouts_errorMessageOutput("絶対パスの変換のエラー`n  ファイルが見つからない`n  " . p_str, LineFile, LineNumber)
			}
			return p_strArg
		}
	}
	curDir := RTrim( curDir, "\" )
	StringLeft, one_char, p_str, 1
	StringLeft, two_chars, p_str, 2
	StringLeft, three_chars, p_str, 3
	StringTrimLeft, rest1, p_str, 1
	StringTrimLeft, rest2, p_str, 2
	StringTrimLeft, rest3, p_str, 3

	StringRight, twoChr, two_chars, 1
	if(twoChr == ":"){
		returnValue :=  p_str
	} else if ((one_char = "\" ) and (two_chars != "\\" )) { ; top directory
		;; 現在のパスから、ドライブ名を取得する
		SplitPath, A_WorkingDir, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
		returnValue := OutDrive . "\" . rest1
	} else if (two_chars = ".\" ) { ; current directory
		returnValue := curDir  . "\" . rest2
	} else if (three_chars = "..\" ) { ; parent directory
		i := 1
		Loop
		{
			StringLeft, three_chars, rest3, 3
			if (three_chars = "..\") {
				i++
				StringTrimLeft, rest3, rest3, 3
			} else {
				no_upper_dir := True
			}
		} until (no_upper_dir)

		returnValue := outs_getParentDir(curDir, i, LineFile, LineNumber, errView)  . rest3
	} else if(two_chars = "\\") {
		returnValue :=  p_str
	} else {
		returnValue := curDir  . "\" . p_str
	}
	; 一度絶対パスを表示させて使う
	; 文字の途中で ..\ の文字があった時に対応させる
	returnValue := outs_toAbsolutePath_Cust(returnValue, LineFile, LineNumber, errView)
	if(dbQuouteFlag){
		returnValue := """" . returnValue . """"
	}
	return returnValue
}

; 最後に \ がつく問題があるが、必要な場合もあるのでこのままにする
outs_getParentDir(filePath, num, LineFile, LineNumber, errView=True){
	tmp_path := RTrim(filePath, "\")
	StringGetPos, index, tmp_path, \, R%num%
	if (index = -1) { ; "..\" が想定以上に出現したとき
		;; ディレクトリのトップ (Z:\) に設定しておく
		index := 2
	}
	index++
	StringLeft, new_path, tmp_path, %index%
	if( func_myFileExist(new_path) )
	{
		return new_path
	}
	if(errView){
		reouts_errorMessageOutput("上位のフォルダが見つからず", filePath, LineFile, LineNumber)
	}
	return filePath
}

; 一度絶対パスを表示させて使う
; 文字の途中で ..\ の文字があった時に対応させる
outs_toAbsolutePath_Cust(returnValue, LineFile, LineNumber, errView=True){
	IfInString, returnValue, ..
	{
		; \.. で終わるフォルダにトラブルがあったのでそれに対応させる
		type := func_myFileExistReturnType(returnValue)
		IfInString, type, D
		{
			returnValue := Trim( returnValue, "\" )
			returnValue .= "\"
		}

		StringGetPos, index, returnValue, ..\ , L1
		StringLeft, headPath, returnValue, %index%
		index += 3
		StringTrimLeft, footPath, returnValue, %index%
		j = 1
		Loop
		{
			StringLeft, three_chars, footPath, 3
			if (three_chars = "..\") {
				j++
				StringTrimLeft, footPath, footPath, 3
			} else {
				Break
			}
		}
		returnValue := outs_getParentDir(headPath, j, LineFile, LineNumber, errView)  . footPath
		returnValue := RTrim( returnValue, "\" )
	}
	return  returnValue
}

outs_getRightOfEn(path, num){
	tmp_path := RTrim(path, "\")
	StringGetPos, index, tmp_path, \, R%num%
	if (index = -1) { ; "..\" が想定以上に出現したとき
		;; ディレクトリのトップ (Z:\) に設定しておく
		index := 2
	}
	index++
	StringTrimLeft, new_path, tmp_path, %index%
	return new_path
}


outs_miniEditWorkDir(rightStr){
	IfInString, rightStr, <
	{
		IfInString, rightStr, >
		{
			res := RegExMatch(rightStr, "i)^([^<]*)<([^<>]+)>([\w\W]*)$" , val_ )
			if(val_2 != ""){
				val_2 := Trim(val_2)
				val_2 := Trim(val_2, """")
				return  val_2
			}
		}
	}
	return  ""
}

outs_miniEditExceptingWorkDir(rightStr){
	IfInString, rightStr, <
	{
		IfInString, rightStr, >
		{
			res := RegExMatch(rightStr, "i)^([^<]*)<([^<>]+)>([\w\W]*)$" , val_ )
			if(val_2 != ""){
				rightStr := val_1  . val_3
				rightStr := Trim(rightStr)
			}
		}
	}
	return  rightStr
}

outs_workDirCheck(workStr, errorMsg) {
	if(workStr != "") {
		if( func_isNotFolder(workStr) ){
			reouts_errorMessageOutput(errorMsg)
		}
	}
}

; 現時点ではフォルダ名のあとに \ が付いたり付かなかったりするので、後にファイル名をつける場合は注意が必要
outs_absolePathToRelativPath(curDirArg , targetArg, LineFile, LineNumber){
	; はじめに " " で囲まれてるファイルに対する処理を追加した
	dbQuouteFlag := False
	target := targetArg
	StringLeft, lchr, targetArg, 1
	if(lchr == """"){
		StringRight, rchr, targetArg, 1
		if(rchr == """"){
			dbQuouteFlag := True
			target := Trim( targetArg, """" )
		}
	}

	if( func_myFileNotExit(target) ) {
		return  targetArg
	}
	type := func_myFileExistReturnType(curDirArg)
	IfNotInString, type, D
	{
		reouts_errorMessageOutput("相対パスの変換のエラー。`n基準の位置がフォルダではない`n" . curDirArg)
		return  targetArg
	}
	; 絶対パスに
	curDir := outs_relativePathToAbsolutePath(curDirArg, A_WorkingDir, LineFile, LineNumber, False)
	target := outs_relativePathToAbsolutePath(target, curDirArg, LineFile, LineNumber, False)

	; C:\ などが同じかどうか
	StringLeft, lChr1, target, 3
	StringLeft, lChr2, curDir, 3
	if(lChr1 != lChr2){
		return  targetArg
	}
	curDir := RTrim( curDir, "\" )
	curDir .= "\"
	
	if( func_isFolder(target) ){
		target := RTrim( target, "\" )
		target .= "\"
	}

	if(curDir == target) {
		if(dbQuouteFlag){
			return  """.\"""
		}
		return  ".\"
	}


	commonDir =
	j = 1
	Loop, 50	; 最大でも50まで 回ループ
	{
		StringGetPos, curIndex, curDir, \ , L%j%
		if(curIndex == -1){
			commonDir = %curDir%
			break
		}
		curIndex++
		StringLeft, curLeft, curDir, %curIndex%

		StringGetPos, tarIndex, target, \ , L%j%
		if(tarIndex == -1){
			; target がファイルだった場合、親フォルダにする。フォルダなら、そのまま
			res := func_isNotFolder(target)
			if(res){
				commonDir := outs_getParentDir(target, 1, LineFile, LineNumber, False)
			} else {
				commonDir = %target%
			}
			break
		}
		tarIndex++
		StringLeft, tarLeft, target, %tarIndex%

		if(curLeft != tarLeft){
			break
		}
		commonDir = %curLeft%
		j++
	}

	i = 1
	upperMarkBuff =
	tmpCurDir := curDir
	Loop, 50	; 最大でも50まで 回ループ
	{
		if(commonDir == tmpCurDir){
			break
		}
		twoStr := RTrim( tmpCurDir, "\" )
		StringRight, left2, twoStr, 1
		if(left2 == ":"){
			break
		}
		tmpCurDir := outs_getParentDir(curDir, i, LineFile, LineNumber, False)
		i++
		upperMarkBuff .= "..\"
	}

	residuePath =
	i = 1
	if(target != commonDir){
		Loop, 50	; 最大でも50まで 回ループ
		{
			new_target := outs_getParentDir(target, i, LineFile, LineNumber, False)
			if(new_target == commonDir){
				residuePath := outs_getRightOfEn(target, i)
				break
			}
			i++
;reouts_errorMessageOutput(new_target)
		}
	}
	relativPath := upperMarkBuff  . residuePath
	if(dbQuouteFlag){
		relativPath := """" . relativPath  . """"
	}

	return  relativPath
}

outs_controlValueToOtherControl(pControl, pOut, GuiNum){
	listStr := guf_getControl( pControl, GuiNum )
	str := outs_ansValuePersent(listStr)
	guf_setControl( str, pOut, GuiNum )
}

; 23:59:59 などの書式なら、６桁の数字にして返す。
; 書式が違うなら、元の文字列を返す
outs_getDateTime6CharColon(str){
	IfNotInString, str, :
	{
		return str
	}
	hour =
	min =
	sec =
	sentence = %str%
	pmFlag := False

	StringLeft, leftStr, sentence, 2
	; 午後か午前の文字が先頭にあったら
	if( leftStr == "午前" ){
		StringTrimLeft, sentence, sentence, 2
		StringLeft, leftStr, sentence, 2
	} else if( leftStr == "午後" ){
		StringTrimLeft, sentence, sentence, 2
		StringLeft, leftStr, sentence, 2
		pmFlag := True
	}

	; 時間が１桁なら
	StringRight, rChr, leftStr, 1
	if( rChr == ":" ){
		StringTrimRight, leftStr2, leftStr, 1
		If leftStr2 is not integer
		{
			return str
		}
		hour = %leftStr2%
		if( pmFlag ){
			hour += 12
		} else {
			hour := "0" . leftStr2
		}

		StringTrimLeft, sentence, sentence, 2
	} else {
		StringLeft, leftStr, sentence, 3
		StringRight, rChr, leftStr, 1
		if( rChr != ":" ){
			; ３文字目が : でないなら違う
			return str
		} 
		StringTrimRight, hour, leftStr, 1
		If hour is not integer
		{
			return str
		}
		if( pmFlag ){
			hour += 12
		}
		if( hour >= 24 ){
			return str
		}
		StringTrimLeft, sentence, sentence, 3
	}

	StringLen, strLen, sentence
	if( strLen == 1 ){
		If sentence is not integer
		{
			return str
		}
		min := "0" . sentence
		returnValue := hour . min . "00"
		return returnValue
	} else if( strLen == 2 ){
		If sentence is not integer
		{
			return str
		}
		min := sentence
		if( min >= 60 ){
			return str
		}
		returnValue := hour . min . "00"
		return returnValue
	}


	StringLeft, leftStr, sentence, 2
	StringRight, rChr, leftStr, 1
	if( rChr == ":" ){
		StringTrimRight, leftStr2, leftStr, 1
		If leftStr2 is not integer
		{
			return str
		}
		min := "0" . leftStr2
		StringTrimLeft, sentence, sentence, 2
	} else {
		StringLeft, leftStr, sentence, 3
		StringRight, rChr, leftStr, 1
		if( rChr != ":" ){
			; ３文字目が : でないなら違う
			return str
		} 
		StringTrimRight, min, leftStr, 1
		If min is not integer
		{
			return str
		}
		if( min >= 60 ){
			return str
		}
		StringTrimLeft, sentence, sentence, 3
	}

	StringLen, strLen, sentence
	if( strLen == 1 ){
		If sentence is not integer
		{
			return str
		}
		sec := "0" . sentence
		returnValue := hour . min . sec
		return returnValue
	} else if( strLen == 2 ){
		If sentence is not integer
		{
			return str
		}
		sec := sentence
		if( sec >= 60 ){
			return str
		}
		returnValue := hour . min . sec
		return returnValue
	}
	; sentence が 2文字でないなら、違う
	return str
}

; 23:59:59 などの書式なら、23h 59m 59s の文字列に変換して返す。
; 書式が違うなら、元の文字列を返す
outs_getHMSSentenceColon(str){
	IfNotInString, str, :
	{
		return str
	}
	hour =
	min =
	sec =
	sentence = %str%

	; 時間が１桁なら
	StringLeft, leftStr, sentence, 2
	StringRight, rChr, leftStr, 1
	if( rChr == ":" ){
		StringTrimRight, leftStr2, leftStr, 1
		If leftStr2 is not integer
		{
			return str
		}
		hour := leftStr2
		StringTrimLeft, sentence, sentence, 2
	} else {
		StringLeft, leftStr, sentence, 3
		StringRight, rChr, leftStr, 1
		if( rChr != ":" ){
			; ３文字目が : でないなら違う
			return str
		} 
		StringTrimRight, hour, leftStr, 1
		If hour is not integer
		{
			return str
		}
		if( hour >= 24 ){
			return str
		}
		StringTrimLeft, sentence, sentence, 3
	}

	StringLen, strLen, sentence
	if( strLen == 1 ){
		If sentence is not integer
		{
			return str
		}
		min := sentence
		returnValue := hour . "h " . min . "m"
		return returnValue
	} else if( strLen == 2 ){
		If sentence is not integer
		{
			return str
		}
		min := sentence
		if( min >= 60 ){
			return str
		}
		returnValue := hour . "h " . min . "m"
		return returnValue
	}

	StringLeft, leftStr, sentence, 2
	StringRight, rChr, leftStr, 1
	if( rChr == ":" ){
		StringTrimRight, leftStr2, leftStr, 1
		If leftStr2 is not integer
		{
			return str
		}
		min := leftStr2
		StringTrimLeft, sentence, sentence, 2
	} else {
		StringLeft, leftStr, sentence, 3
		StringRight, rChr, leftStr, 1
		if( rChr != ":" ){
			; ３文字目が : でないなら違う
			return str
		} 
		StringTrimRight, min, leftStr, 1
		If min is not integer
		{
			return str
		}
		if( min >= 60 ){
			return str
		}
		StringTrimLeft, sentence, sentence, 3
	}

	StringLen, strLen, sentence
	if( strLen == 1 ){
		If sentence is not integer
		{
			return str
		}
		sec := sentence
		returnValue := hour . "h " . min . "m " . sec . "s"
		return returnValue
	} else if( strLen == 2 ){
		If sentence is not integer
		{
			return str
		}
		sec := sentence
		if( sec >= 60 ){
			return str
		}
		returnValue := hour . "h " . min . "m " . sec . "s"
		return returnValue
	}
	; sentence が 2文字でないなら、違う
	return str
}

; 全角文字の数字を半角の数字に変換
outs_fullNumeralReplacehalf(timeWord){
	timeWord := func_stringReplace(timeWord, "０", "0", True)
	timeWord := func_stringReplace(timeWord, "１", "1", True)
	timeWord := func_stringReplace(timeWord, "２", "2", True)
	timeWord := func_stringReplace(timeWord, "３", "3", True)
	timeWord := func_stringReplace(timeWord, "４", "4", True)
	timeWord := func_stringReplace(timeWord, "５", "5", True)
	timeWord := func_stringReplace(timeWord, "６", "6", True)
	timeWord := func_stringReplace(timeWord, "７", "7", True)
	timeWord := func_stringReplace(timeWord, "８", "8", True)
	timeWord := func_stringReplace(timeWord, "９", "9", True)
	return timeWord
}

; 漢数字を半角の数に変換する
; ここでは単純に数字のみを変換する
outs_kanjiReplaceIntegerSimplicity(timeWord){
	timeWord := func_stringReplace(timeWord, "零", "0", True)
	timeWord := func_stringReplace(timeWord, "一", "1", True)
	timeWord := func_stringReplace(timeWord, "二", "2", True)
	timeWord := func_stringReplace(timeWord, "三", "3", True)
	timeWord := func_stringReplace(timeWord, "四", "4", True)
	timeWord := func_stringReplace(timeWord, "五", "5", True)
	timeWord := func_stringReplace(timeWord, "六", "6", True)
	timeWord := func_stringReplace(timeWord, "七", "7", True)
	timeWord := func_stringReplace(timeWord, "八", "8", True)
	timeWord := func_stringReplace(timeWord, "九", "9", True)
	return timeWord
}

; 現時点では 万 までしか対応できない
; 右の文字から、下の桁の 0 の追加が必要か判断して 0 を追加して返す。
; fullChar が 万 で指定しているとしたら、underDigit は 4 にする。
outs_getUnderDigitAndRightStr(rightStr, underDigit, originWord, errorViewFlag){
	StringLen, num, rightStr
	digitTmp := underDigit + 1
	; 右の文字が 5 文字以上でテストしてみる
	if(num >= digitTmp){
		StringLeft, rightStr_left, rightStr, %digitTmp%
		; fullChar の右 5 文字が 全部数字なら解析できない。
		If rightStr_left is integer
		{
			if( errorViewFlag ){
				reouts_errorMessageOutput("漢数字を数値に変換する関数のエラー。`n以下の文字は解析できない。`n解析中の文字列  " . rightStr . "`n元の文字列  " . originWord)
			}
			return "error"
		}
	}

	; 右の文字が 4 文字以上の場合
	if(num >= underDigit){
		StringLeft, rightStr_left, rightStr, %underDigit%
		; fullChar の右 4 文字が 全部数字なら何もしない。そのまま返す。
		If rightStr_left is integer
		{
			return rightStr
		}
	}

	underDigit -= 1
	; 十 なら underDigit は 0 なので、ここで終了する。
	if(underDigit <= 0){
		rightStr := "0" . rightStr
		return rightStr
	}
	; 右の文字が 3 文字以上の場合
	if(num >= underDigit){
		StringLeft, rightStr_left, rightStr, %underDigit%
		; fullChar の右 3 文字が 数字なら 0 を一つ足すだけ
		; 万123時間 の場合、0123時間 が下の桁
		If rightStr_left is integer
		{
			rightStr := "0" . rightStr
			return rightStr
		}
	}

	underDigit -= 1
	; 百 なら underDigit は 0 なので、ここで終了する。
	if(underDigit <= 0){
		rightStr := "00" . rightStr
		return rightStr
	}
	; 右の文字が 2 文字以上の場合
	if(num >= underDigit){
		StringLeft, rightStr_left, rightStr, %underDigit%
		; fullChar の右 2 文字が 数字なら 0 を二つ足す
		; 万23時間 の場合、0023時間 が下の桁
		If rightStr_left is integer
		{
			rightStr := "00" . rightStr
			return rightStr
		}
	}

	underDigit -= 1
	; 千 なら underDigit は 0 なので、ここで終了する。
	if(underDigit <= 0){
		rightStr := "000" . rightStr
		return rightStr
	}
	; 右の文字が 1 文字以上の場合
	if(num >= underDigit){
		StringLeft, rightStr_left, rightStr, %underDigit%
		; fullChar の右 1 文字が 数字なら 0 を三つ足す
		; 万3時間 の場合、0003時間 が下の桁
		If rightStr_left is integer
		{
			rightStr := "000" . rightStr
			return rightStr
		}
	}
	; fullChar の右 1文字が 数字でないなら 0 を四つ足す
	; 万時間 の場合、0000時間 が下の桁
	rightStr := "0000" . rightStr
	return rightStr
}

; 十 百 千 万 の文字を変換する
; この関数で一つの漢数字ずつ変換する
outs_kanjiReplaceIntegerOneSign(timeWord, fullChar, digitNum, originWord, errorViewFlag){
	IfNotInString, timeWord, %fullChar%
	{
		return timeWord
	}
	StringGetPos, index, timeWord, %fullChar%
	; fullChar の左の文字
	StringLeft, leftStr, timeWord, %index%

	indexPlus := index + 1
	; fullChar の右の文字
	StringTrimLeft, rightStr, timeWord, %indexPlus%

	; 十だったら digitNum は 2
	; underDigit は 1
	underDigit := digitNum - 1

	; 右の文字から、下の桁の 0 の追加が必要か判断して 0 を追加して返す。
	rightStr := outs_getUnderDigitAndRightStr(rightStr, underDigit, originWord, errorViewFlag)
	if(rightStr == "error"){
		return "error"
	}

	; fullChar の左 １文字が 数字なら十を消すだけ。
	; fullChar の左 １文字が 数字でないなら、十を消し、代わりに 1 に置き換える。
	StringLen, num, leftStr
	if(num >= 2){
		; もし、12百 などのように、数値が２つ右にあった場合は、解析できない数字とする。
		StringRight, leftStr_chr2, leftStr, 2
		If leftStr_chr2 is integer
		{
			if( errorViewFlag ){
				reouts_errorMessageOutput("漢数字を数値に変換する関数のエラー。`n以下の文字は解析できない。`n解析中の文字列  " . timeWord . "`n" . fullChar . " の左の文字  " . leftStr . "`n元の文字列  " . originWord)
			}
			return "error"
		}
	}
	if(num >= 1){
		; fullChar の左 １文字が 数字でないなら、十を消し、代わりに 1 に置き換える。
		StringRight, leftStr_lChr, leftStr, 1
		If leftStr_lChr is not integer
		{
			leftStr .= "1"
		}
	}
	if(leftStr == ""){
		; fullChar の左 文字がない場合も、十を消し、代わりに 1 に置き換える。
		leftStr .= "1"
	}
	timeWord := leftStr . rightStr
	return timeWord
}

; 漢数字を半角の数字に変換する
outs_kanjiReplaceInteger(timeWord, originWord, errorViewFlag){
	timeWord := outs_kanjiReplaceIntegerSimplicity(timeWord)
	timeWord := outs_kanjiReplaceIntegerOneSign(timeWord, "十", 2, originWord, errorViewFlag)
	timeWord := outs_kanjiReplaceIntegerOneSign(timeWord, "百", 3, originWord, errorViewFlag)
	timeWord := outs_kanjiReplaceIntegerOneSign(timeWord, "千", 4, originWord, errorViewFlag)
	timeWord := outs_kanjiReplaceIntegerOneSign(timeWord, "万", 5, originWord, errorViewFlag)
	return timeWord
}

; 漢数字と全角文字の数字を半角の数字に変換する
outs_kanjiAndFullNumeralReplaceInteger(timeWord, originWord, errorViewFlag){
	; 全角文字の数字を半角の数字に変換
	timeWord := outs_fullNumeralReplacehalf(timeWord)
	; 漢数字を半角の数字に変換する
	timeWord := outs_kanjiReplaceInteger(timeWord, originWord, errorViewFlag)
	return timeWord
}
