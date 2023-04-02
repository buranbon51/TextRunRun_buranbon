; guf func glob outs 必須
; heard 


craf_useAsHead(str, pOutControl, hwnd, GuiNum){
	str := Trim(str)
	IfInString, str, %A_Space%
	{
		StringGetPos, index, str, %A_Space%, R1
		index++
		StringLeft, leftStr, str, index
		StringTrimLeft, rightStr, str, index
		str := rightStr  . " " . leftStr
		guf_setControl( str, pOutControl, GuiNum )
		func_sendEndToHwndControle(hwnd)
	}
}

craf_setValue(com2, com3, pOut, GuiNum){
	if(com2 == "") {
		guit_setExplainPurpose("&setValue  (登録する変数) (登録する値か文字)`n（変数はV_var1とかに限られるが）", GuiNum)
		return
	}

	res := RegExMatch(com2, "^[0-9a-zA-Z_\$]+$")
	if(res == 1) {
		%com2% := com3
		guit_setExplain(com2  . "  に  " . com3 . "  の値を登録", GuiNum)
	} else {
		guit_errorAppend("変数名が使えない文字あり")
	}
	guit_checkErrorLevelOutput("変数に登録できていない")
}

craf_setValueTmpOutGui(com2, com3, pOut, GuiNum){
	if(com2 == "") {
		guit_appendExplain("&setValueTmpOutGui  (登録する変数)`n説明欄の文字を、指定する変数に代入する")
		return
	}
	str := guit_getExplain(GuiNum)
	str := Trim(str, "`n")
	str := Trim(str)
	if(str == ""){
		guit_appendExplain("説明欄の文字がない")
		return
	}


	res := RegExMatch(com2, "^[0-9a-zA-Z_\$]+$")
	if(res == 1) {
		%com2% := str
		guit_appendExplain( com2  . "  に  説明欄の値を登録" )

	} else {
		guit_errorAppend("変数名に使えない文字あり")
	}
	guit_checkErrorLevelOutput("変数に登録できていない")
}

craf_setVar(num, rightStr, pOut, GuiNum){
	rightStr := outs_textOutTrimss(rightStr)
	if(rightStr == null){
		guit_appendExplain("&setVar" . num  . "  (代入する文字列)`nV_var" . num  . " の変数に代入する")
		return
	}

	if(num == 1){
		V_var1 := rightStr
	} else if(num == 2){
		V_var2 := rightStr
	} else if(num == 3){
		V_var3 := rightStr
	} else if(num == 4){
		V_var4 := rightStr
	} else if(num == 5){
		V_var5 := rightStr
	}
	guit_appendExplain("V_var" . num  . "  に  " . rightStr  . "  の値を登録")
	guit_checkErrorLevelOutput("変数に登録できていない")
}

craf_setHwndVar(num, rightStr, pOut, GuiNum){
	rightStr := outs_textOutTrimss(rightStr)
	rightStr := Trim(rightStr)
	if(rightStr == null){
		guit_appendExplain("&setHwndVar" . num  . "  (ウインドウハンドルのID)`nHwndVar" . num  . " の変数に代入する")
		return
	}

	If rightStr is integer
	{
		StringLeft, l2Str, var1, 2
		if(l2Str != "0x"){
			guit_errorAppend("ウインドウハンドルの数値しか登録できない")
			return
		}

		valueName =
		if(num == 1){
			HwndVar1 := rightStr
		} else if(num == 2){
			HwndVar2 := rightStr
		} else if(num == 3){
			HwndVar3 := rightStr
		} else if(num == 4){
			HwndVar4 := rightStr
		} else if(num == 5){
			HwndVar5 := rightStr
		}
		guit_appendExplain("HwndVar" . num  . "  に  " . rightStr  . "  の値を登録")
	} else {
		guit_errorAppend("文字列は登録できない")
	}
	guit_checkErrorLevelOutput("変数に登録できていない")
}

craf_commandListOuttoDir(com2, pOutControl, hwnd, GuiNum){
	dirPath := func_getBackDir(com2, 1)
	tmpDir := outs_textOutTrimss(dirPath)
	IfExist, %tmpDir%
	{
		glob_backOfBackPath = %com2%
		com2 = %dirPath%
	}
	guf_setControl( com2, pOutControl, GuiNum )
	func_sendEndToHwndControle(hwnd)
}

craf_OuttoDirBackComm(pOutControl, hwnd, GuiNum){
	if(glob_backOfBackPath == ""){
		return
	}
	guf_setControl( glob_backOfBackPath, pOutControl, GuiNum )
	func_sendEndToHwndControle(hwnd)
}

craf_FullPathComm(com2, pOutControl, hwnd, GuiNum){
	com2 := outs_textOutTrimss(com2)
	returnValue := outs_relativeToAbsoluteFromWorkDir(com2, "", 0)
	guf_setControl( returnValue, pOutControl, GuiNum )
	func_sendEndToHwndControle(hwnd)
}

craf_RelativePathComm(com2, pOutControl, hwnd, GuiNum){
	com2 := outs_textOutTrimss(com2)
	returnValue := outs_absolePathToRelativPath(A_WorkingDir , com2, "", 0)
	guf_setControl( returnValue, pOutControl, GuiNum )
	func_sendEndToHwndControle(hwnd)
}

; ## をつけるやつの改良版
craf_commandsharpssCustom(com2, pControl, hwnd, GuiNum){
	if(com2 == "") {
		return
	}
	com2 := RTrim( com2, "\" )
	StringGetPos, index, com2, %A_Space%, R1
	if(index > -1) {
		StringTrimLeft, com2Last, com2, index
		StringLeft, com2Before, com2, index
		com2Before := RTrim(com2Before)
		com2Last := Trim(com2Last)
		com2Last := Trim(com2Last, "#")		;  間違って２回連続使ってもいいように
		com2 := com2Before  . " #" . com2Last  . "#\"
	} else {
		com2 := Trim(com2, "#")
		com2 := "#" . com2  . "#\"
	}
	guf_setControl( com2 , pControl, GuiNum )
	guf_setFocus(pControl, GuiNum)
	;Sleep, 10
	func_sendEndToHwndControle(hwnd)
}

craf_commandsharpss(com2, pControl, hwnd, GuiNum){
	if(com2 == "") {
		return
	}
	com2 := RTrim( com2, "\" )
	StringGetPos, index, com2, %A_Space%, R1
	if(index > -1) {
		StringTrimLeft, com2Last, com2, index
		StringLeft, com2Before, com2, index
		com2Before := RTrim(com2Before)
		com2Last := Trim(com2Last)
		com2Last := Trim(com2Last, "#")		;  間違って２回連続使ってもいいように
		com2 := com2Before  . " #" . com2Last  . "#"
	} else {
		com2 := Trim(com2, "#")
		com2 := "#" . com2  . "#"
	}
	guf_setControl( com2 , pControl, GuiNum )
	guf_setFocus(pControl, GuiNum)
	;Sleep, 10
	func_sendEndToHwndControle(hwnd)
}

craf_commandparsentss(com2, pControl, hwnd, GuiNum){
	if(com2 == "") {
		return
	}
	StringGetPos, index, com2, %A_Space%, R1
	if(index > -1) {
		StringTrimLeft, com2Last, com2, index
		StringLeft, com2Before, com2, index
		com2Before := RTrim(com2Before)
		com2Last := Trim(com2Last)
		com2Last := Trim(com2Last, "%")		;   間違って２回連続使ってもいいように
		com2 := com2Before  . " %" . com2Last  . "%"
	} else {
		com2 := Trim(com2, "%")
		com2 := "%" . com2  . "%"
	}

	guf_setControl( com2 , pControl, GuiNum )
	guf_setFocus(pControl, GuiNum)
	;Sleep, 10
	func_sendEndToHwndControle(hwnd)
}

craf_commanddoubleQuoute(com2, pControl, hwnd, GuiNum) {
	str = `"%com2%`"
	guf_setControl( str, pControl, GuiNum )
	func_sendEndToHwndControle(hwnd)
}

craf_doubleQuouteCustomComm(com2, dbQuFlag, absoleNotFlag, pControl, hwnd, GuiNum){
	; 空白のファイルの自動判別の設定にかかわらず、この関数を使う
	str := heard_fileAllAbsoluteOrDbQuoute(com2, A_LineFile, A_LineNumber, dbQuFlag, absoleNotFlag)
	guf_setControl( str, pControl, GuiNum )
	func_sendEndToHwndControle(hwnd)
}

craf_fullPathAll(com2, dbQuFlag, absoleNotFlag, pControl, hwnd, GuiNum){
	str =
	com2 := outs_textOutTrimss(com2)
	; 空白のファイルを自動判別の設定で、動作を変える
	;if(glob_iniSpaceFileNotFlag == False){
	if(O_spaceFileNotFlag == False){
		str := heard_fileAllAbsoluteOrDbQuoute(com2, "", 0, dbQuFlag, absoleNotFlag)
	} else {
		; 絶対パスにはするが、空白のあるファイルがあったら対処できない簡易版
		str := heard_absoluteAllEasy(com2, "", 0)
	}
	guf_setControl( str, pControl, GuiNum )
	func_sendEndToHwndControle(hwnd)
}

craf_commandtextOut(com2, pOutControl, hwnd, GuiNum) {
	str := outs_textOutTrimssMinute(com2)
	guf_setControl( str, pOutControl, GuiNum )
	GuiControl,%GuiNum%:Focus, %pOutControl%
	;Sleep, 10
	func_sendEndToHwndControle(hwnd)
}

craf_commandvarGet(com2, pOutControl, hwnd, GuiNum) {
	str := outs_ansValuePersent(com2)
	guf_setControl( str, pOutControl, GuiNum )
	GuiControl,%GuiNum%:Focus, %pOutControl%
	;Sleep, 10
	func_sendEndToHwndControle(hwnd)
}


craf_sysCommandpath( str, pOut1, hwnd, GuiNum1 ) {
	if(str == "") {
		return
	}
	IfInString, str, \
	{
		guit_setExplain("アイテム名が見つからず", GuiNum1)
	} else {
		optionObj := cen_getFromEnyObject(str)
		if(IsObject(optionObj)) {
			appPath := optionObj[1]
			if(optionObj[5] == 2){
				appPath .= "\"
			} else if(optionObj[5] == 4){
				guit_setExplain("二行以上のアイテムは表示できない`n" . str, GuiNum1)
				return
			}
			guf_setControl( appPath, pOut1, GuiNum1 )
			GuiControl, %GuiNum1%:Focus, %pOut1%
			;Sleep, 10
			func_sendEndToHwndControle(hwnd)
		} else {
			guit_setExplain("アイテム名が見つからず", GuiNum1)
		}
	}
}

craf_RelativeAssignComm(com2, com3, pOutControl, GuiNum){
	if(com3 == ""){
		;returnValue := outs_absolePathToRelativPath(A_WorkingDir , com2, LineFile, LineNumber)
		guit_setExplainPurpose("１つめの引数に基準のフォルダを`n２つめの引数に相対パスにしたいファイルパスをいれる", GuiNum)
	} else {
		;com2 := outs_textOutDqAllTrim(com2)
		;com3 := outs_textOutTrimss(com3)
		returnValue := outs_absolePathToRelativPath(com2 , com3, "", 0)
		guf_setControl( returnValue, pOutControl, GuiNum )
	}
}

craf_FullPathAssignComm(com2, com3, pOutControl, GuiNum){
	if(com3 == ""){
		;returnValue := outs_relativePathToAbsolutePath(com2, A_WorkingDir, A_LineFile, A_LineNumber, False)
		guit_setExplainPurpose("１つめの引数に基準のフォルダを`n２つめの引数に絶対パスにしたいファイルパスをいれる", GuiNum)
	} else {
		;com2 := outs_textOutDqAllTrim(com2)
		;com3 := outs_textOutTrimss(com3)
		returnValue := outs_relativePathToAbsolutePath(com3, com2, "", 0, True)
		guf_setControl( returnValue, pOutControl, GuiNum )
	}
}

; オブジェクトの valueの方を 改行 で区切った文字にする
craf_objectValueToLineStr(obj){
	buff =
	for key, value in  obj {
		if(key != ""){
			buff .= value  . "`n"
		}
	}
	buff := RTrim(buff, "`n")
	return  buff
}

craf_getObjOrStr(obj, keyName){
	if(IsObject( obj )){
		if(keyName == ""){
			returnValue := func_objectKeyToLineStr(obj)
		} else {
			nextObj := obj[keyName]
			returnValue := craf_getObjOrStr(nextObj, "")
		}
	} else {
		returnValue := obj
	}
	return  returnValue
}

craf_getObjLogic(com2, com3, com4, com5, com6){
	returnValue =
	if(com3 == ""){
		obj1 := %com2%
		if(IsObject(obj1)) {
			returnValue := func_objectKeyToLineStr(obj1)
		} else {
			returnValue := "オブジェクト名ではない`n" . com2
		}
		return  returnValue
	}
	obj2 := %com2%[com3]
	if(IsObject( obj2 )){
		if(com4 == ""){
			returnValue := func_objectKeyToLineStr(obj2)
		} else {
			obj3 := obj2[com4]
			returnValue := craf_getObjOrStr(obj3, com5)
		}
	} else {
		returnValue := obj2
	}
	return  returnValue
}

craf_ObjGet(com2, com3, com4, com5, com6, pOut, GuiNum){
	str := "オブジェクトの中身を調べる。`n引数１  オブジェクトなら、オブジェクトの中身を表示する。`n引数２  引数１がオブジェクトなら、さらにそのキーを入れると、そのキーの中身を表示"
	if( edc_helpViewIfHyphenH(str, com2, GuiNum) ){
		return
	}
	if(com2 == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	str := craf_getObjLogic(com2, com3, com4, com5, com6)
	guit_setExplain(str, GuiNum)
}

craf_ObjRemoveComm(com2, com3){
	if(com3 == ""){
		%com2%.Remove()
	} else {
		%com2%.Remove(com3)
	}
	guit_checkErrorLevelOutput(A_ThisFunc, A_LineNumber)
}
