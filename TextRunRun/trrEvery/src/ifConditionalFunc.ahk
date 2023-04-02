
; 一番左の{ } を取り除いて、中身をとりだす。
; 現時点では左端が { でないと、認識しない。
; しかも不完全なとこが多く、複雑な構造は認識できない。
; 下にある　ifco_rightStrFromBlockTrimFirstLeft　も、同じ構造を使っている。
ifco_blockTrimFirstLeft(str, before, after, lineFile, lineNumber){
	IfNotInString, str, %before%
	{
		guit_errorAppend(before . "  が見つからないので、元の文字列を返した。`n" . str . "`n")
		return  str
	}
	IfNotInString, str, %after%
	{
		guit_errorAppend(after . "  が見つからないので、元の文字列を返した。`n" . str . "`n")
		return  str
	}
	str := Trim(str)
	; "{aa{ bbb{ cccc{ ddddd  } {ee { ff } } gg} {hh} ii}} else if(True){ aaa }" を参考にする

	turnNum1 = 1
	leftStr := func_leftStrOrNullFromSearchStrTurnAssign(str, after, turnNum1)
	; {aa{ bbb{ cccc{ ddddd  になる		{ が４つ
	tmpLeftStr := func_rightStrOrNullFromSearchStr(leftStr, before)
	if(tmpLeftStr == ""){
		return ""
	}
	StringSplit, split_, tmpLeftStr , %before%
	if(split_0 == 1){
		tmpLeftStr := Trim(tmpLeftStr)
		if( ifco_blockTrimCompletionComfirm(tmpLeftStr, before, after) ){
			return tmpLeftStr
		}
		guit_errorAppend(before . "  " . after . "  が正しく認識できていないので、元の文字列を返した。`n" . str . "`n")
		return str
	}
	; ４になる
	turnNum2 := split_0

	; ここからが複雑
	turnNum3 =
	split_0 = 0
	Loop , 7
	{
		; } が４つめの位置をTrim   (最後の } は取り除かれている)
		leftStr := func_leftStrOrNullFromSearchStrTurnAssign(str, after, turnNum2)
		if(leftStr == ""){
			guit_errorAppend(before . " の数が " . after . " より多いようなので正しく認識できていない。元の文字列を返した。`n" . str . "`n")
			return str
		}
		; {aa{ bbb{ cccc{ ddddd} {ee { ff } } gg
		tmpRightStr := func_rightStrOrNullFromSearchStrTurnAssign(leftStr, after, turnNum1)
		;  {ee { ff } } gg		{ が２つ
		if(tmpRightStr == ""){
			split_0 = 1
		} else {
			StringSplit, split_, tmpRightStr , %before%
		}

		if(split_0 == 1){
			;左端をTrimしておわり
			leftStr := func_rightStrOrNullFromSearchStr(leftStr, before)
			leftStr := Trim(leftStr)
			if(leftStr == ""){
				return leftStr
			}
			if( ifco_blockTrimCompletionComfirm(leftStr, before, after) ){
				return leftStr
			}
			guit_errorAppend(before . "  " . after . "  が正しく認識できていないので、元の文字列を返した。`n" . str . "`n")
			return str
		}
		turnNumPlus := split_0 - 1
		turnNum3 := turnNum2 + turnNumPlus
		turnNum1 := turnNum2
		turnNum2 := turnNum3
	}

	guit_errorAppend(before . "  " . after . "  の構造が複雑すぎて正しく認識できない。`n" . str . "`n")
	return str
}

; 上の ifco_blockTrimFirstLeft のまるパクリ。 返り値は、左端のブロックの右の文字列を返す関数。
ifco_rightStrFromBlockTrimFirstLeft(str, before, after, lineFile, lineNumber){
	IfNotInString, str, %before%
	{
		guit_errorAppend("左端のブロックの右の文字列を返す関数のエラー`n" . before . "  が見つからない。`n" . str)
		return  "ブロックの右が返せないエラー"
	}
	IfNotInString, str, %after%
	{
		guit_errorAppend("左端のブロックの右の文字列を返す関数のエラー`n" . after . "  が見つからない。`n" . str)
		return  "ブロックの右が返せないエラー"
	}
	str := Trim(str)
	; "{aa{ bbb{ cccc{ ddddd  } {ee { ff } } gg} {hh} ii}} else if(True){ aaa }" を参考にする

	turnNum1 = 1
	leftStr := func_leftStrOrNullFromSearchStrTurnAssign(str, after, turnNum1)
	; {aa{ bbb{ cccc{ ddddd  になる		{ が４つ
	tmpLeftStr := func_rightStrOrNullFromSearchStr(leftStr, before)
	if(tmpLeftStr == ""){
		rightStrFromBlock := func_rightStrOrNullFromSearchStrTurnAssign(str, after, turnNum1)
		return rightStrFromBlock
	}
	StringSplit, split_, tmpLeftStr , %before%
	if(split_0 == 1){
		tmpLeftStr := Trim(tmpLeftStr)
		if( ifco_blockTrimCompletionComfirm(tmpLeftStr, before, after) ){
			rightStrFromBlock := func_rightStrOrNullFromSearchStrTurnAssign(str, after, turnNum1)
			return rightStrFromBlock
		}
		guit_errorAppend("左端のブロックの右の文字列を返す関数のエラー`n" . before . "  " . after . "  が正しく認識できていない。`n" . str)
		return "ブロックの右が返せないエラー"
	}
	; ４になる
	turnNum2 := split_0

	; ここからが複雑
	turnNum3 =
	split_0 = 0
	Loop , 7
	{
		; } が４つめの位置をTrim   (最後の } は取り除かれている)
		leftStr := func_leftStrOrNullFromSearchStrTurnAssign(str, after, turnNum2)
		if(leftStr == ""){
			guit_errorAppend("左端のブロックの右の文字列を返す関数のエラー`n" . before . " の数が " . after . " より多いようなので正しく認識できていない。`n" . str)
			return "ブロックの右が返せないエラー"
		}
		; {aa{ bbb{ cccc{ ddddd} {ee { ff } } gg
		tmpRightStr := func_rightStrOrNullFromSearchStrTurnAssign(leftStr, after, turnNum1)
		;  {ee { ff } } gg		{ が２つ
		if(tmpRightStr == ""){
			split_0 = 1
		} else {
			StringSplit, split_, tmpRightStr , %before%
		}

		if(split_0 == 1){
			;左端をTrimしておわり
			leftStr := func_rightStrOrNullFromSearchStr(leftStr, before)
			leftStr := Trim(leftStr)
			if(leftStr == ""){
				rightStrFromBlock := func_rightStrOrNullFromSearchStrTurnAssign(str, after, turnNum2)
				return rightStrFromBlock
			}
			if( ifco_blockTrimCompletionComfirm(leftStr, before, after) ){
				rightStrFromBlock := func_rightStrOrNullFromSearchStrTurnAssign(str, after, turnNum2)
				return rightStrFromBlock
			}
			guit_errorAppend("左端のブロックの右の文字列を返す関数のエラー`n" . before . "  " . after . "  が正しく認識できていない。`n" . str)
			return "ブロックの右が返せないエラー"
		}
		turnNumPlus := split_0 - 1
		turnNum3 := turnNum2 + turnNumPlus
		turnNum1 := turnNum2
		turnNum2 := turnNum3
	}

	guit_errorAppend("左端のブロックの右の文字列を返す関数のエラー`n" . before . "  " . after . "  の構造が複雑すぎて正しく認識できない。`n" . str)
	return "ブロックの右が返せないエラー"
}

; 前のブロックと後ろのブロックの数を確認。同じ数であれば True を返す
ifco_blockTrimCompletionComfirm(str, before, after){
	StringSplit, before_ , str , %before%
	StringSplit, after_ , str , %after%
	if(before_0 == after_0){
		return True
	}
	return False
}

; 関数か、計算か、文字を連結した値を返す
ifco_answerEnyCalcOrStringOrFunc(rStr, textAll){

	; 関数の文字列が書かれていたら実行するようにする
	advice := ahkc_isFuncStr(rStr)
	if( advice == null ) {
		ansValue := ahkc_GoFunc_sub(rStr)
		guit_checkErrorLevelOutput("関数のエラー`n" . textAll)

		return ansValue
	}

	; value++ の処理
	;rStr := ifco_valueIfOnePlusMinusOperationNotShow(rStr, True, textAll)

	ansValue := ifco_answerFromEnyCalcOrString(rStr, textAll, True)
	return ansValue
}

ifco_equalSubstitution(com1, editAll, GuiNum, globalFlag, com1Value, noEqualFlag){
	; %変数名% も textOut して使えるようにする
	com1 := outs_textOutTrimss(com1)
	if(com1 == ""){
		guit_errorAppend("代入させる変数名自体がカラになっている`n代入は中止している`n" . editAll)
		return
	}
	if( outs_valueValidatorRulesNot(com1) ){
		guit_errorAppend("変数としては使えない文字がある`n" . com1 . "`n代入は中止している`n" . editAll)
		return
	}

	; 初期値を指定せずに global宣言をする場合
	; 右に = をプラスするだけ
	if( noEqualFlag ){
		editAll .= " ="
	}

	; globalの宣言の場合で、すでに変数が作られていたらスルーするようにする
	if( globalFlag ){
		if(com1Value != ""){
			; ifco_globalVarMakeを使った後では、 com1 の値は初期化されるので、前の値を代入する
			%com1% := com1Value
			return
		}
	}

	rStr  := func_rightStrOrNullFromSearchStr(editAll, "=")
	; あえて、1度しか展開しないようにする（やっぱり止める）
	;rStr := outs_textOutTrimssMinute(rStr)
	rStr := outs_textOutTrimss(rStr)
	; `n の文字列を改行に置換。（やっぱり止める）
	;rStr := func_linefeedReplace(rStr)

	; この時点でもまだ、rStr の前後に 空白 がある可能性があり、
	; その場合 com1 と rStr の確認の際、食い違いが生じるため、Trimする
	rStr := Trim(rStr)
	%com1% = %rStr%

	if( globalFlag ){
		if( rStr == "" ){
			; com1 が カラなら、使える変数かどうか分からないので、値を入れてみる
			%com1% := "@globalMake@"
			if( ifco_confirmSetValueForGlobalNot(com1, "@globalMake@") ){
				guit_errorAppend("global変数の宣言に失敗している。`n" . com1 . "  はもう、変数として使えない")
				;guit_setExplain("global変数の宣言に失敗している。`n" . com1 . "  はもう、変数として使えない", GuiNum)
				return
			}
			; カラを代入
			%com1% =
		} else {
			if( ifco_confirmSetValueForGlobalNot(com1, rStr) ){
				guit_errorAppend("global変数の宣言に失敗している。`n" . com1 . "  はもう、変数として使えない")
				;guit_setExplain("global変数の宣言に失敗している。`n" . com1 . "  はもう、変数として使えない", GuiNum)
				return
			}
		}
		; 入力補完に加える
		;glob_userVariableWordObj.Insert(com1)
	}

	; 関数を変えて変数がちゃんと代入されているか確認する
	ifco_confirmSetValueAndExplain(com1, rStr, GuiNum, 1, editAll, True)
}

ifco_colonEqualSubstitution(com1, editAll, GuiNum, globalFlag, com1Value){
	; %変数名% も textOut して使えるようにする
	com1 := outs_textOutTrimss(com1)
	if(com1 == ""){
		guit_errorAppend("代入させる変数名自体がカラになっている`n代入は中止している`n" . editAll)
		return
	}
	if( outs_valueValidatorRulesNot(com1) ){
		guit_errorAppend("変数としては使えない文字がある`n" . com1 . "`n代入は中止している`n" . editAll)
		return
	}

	; globalの宣言の場合で、すでに変数が作られていたらスルーするようにする
	if( globalFlag ){
		if(com1Value != ""){
			; ifco_globalVarMakeを使った後では、 com1 の値は初期化されるので、前の値を代入する
			%com1% := com1Value
			return
		}
	}

	rStr := func_rightStrOrNullFromSearchStr(editAll, ":=")
	if(rStr == ""){
		guit_errorAppend("代入する値がカラ`n代入は中止している`n" . editAll)
		return
	}

	ansValue := ifco_answerEnyCalcOrStringOrFunc(rStr, editAll)
	if(ansValue == "@error@"){
		guit_errorAppend("次の計算はうまく処理されていない。`n代入は中止している`n" . editAll)
		return
	}

	%com1% := ansValue

	if( globalFlag ){
		if( ansValue == "" ){
			; com1 が カラなら、使える変数かどうか分からないので、値を入れてみる
			%com1% := "@globalMake@"
			if( ifco_confirmSetValueForGlobalNot(com1, "@globalMake@") ){
				guit_errorAppend("global変数の宣言に失敗している。`n" . com1 . "  はもう、変数として使えない")
				;guit_setExplain("global変数の宣言に失敗している。`n" . com1 . "  はもう、変数として使えない", GuiNum)
				return
			}
			; カラを代入
			%com1% =
		} else {
			if( ifco_confirmSetValueForGlobalNot(com1, ansValue) ){
				guit_errorAppend("global変数の宣言に失敗している。`n" . com1 . "  はもう、変数として使えない")
				;guit_setExplain("global変数の宣言に失敗している。`n" . com1 . "  はもう、変数として使えない", GuiNum)
				return
			}
		}
		; 入力補完に加える
		;glob_userVariableWordObj.Insert(com1)
	}

	; 関数を変えて変数がちゃんと代入されているか確認する
	ifco_confirmSetValueAndExplain(com1, ansValue, GuiNum, 1, editAll, True)
}

; 変数が代入されてるか確認
ifco_confirmSetValueAndExplain(com1, com3Value, GuiNum, viewType, textAll, errViewFlag){
	varValue := %com1%
	if(varValue == com3Value){
		if(com3Value == ""){
			com3Value := "カラの値"
		}
		if(viewType == 1){
			guit_setExplain(com1 . "  に`n" . com3Value . "`nを代入", GuiNum)
		} else if(viewType == 2){
			guit_setExplainNotShow(com1 . "  に`n" . com3Value . "`nを代入", GuiNum)
		}
		; viewType == 0 は表示しない
		return True
	}
	guit_errorAppendViewFlag(errViewFlag, "変数の代入に失敗している。`n" . com1 . "  は変数として使えない`n" . textAll)
	return False
}

; global で使うバージョン。変数が代入されてるか、関数を変えて確認
ifco_confirmSetValueForGlobalNot(com1, com3Value){
	varValue := %com1%
	if(varValue == com3Value){
		return False
	}
	return True
}

; += や -= で使うよう。計算だけをする
ifco_answerFromCalcOnly(rightStr, textAll){

	; 空白がないなら、変数名か数値 扱い
	IfNotInString, rightStr, %A_Space%
	{
		rightStr := ifco_valueIfAnySimplexOperationNotShow(rightStr, True, textAll, True)
		rightStrValue := ahkc_dbQuouteOrVariable(rightStr, True)
		return rightStrValue
	}

	rightStr := func_spaceChangeOnlyOne(rightStr)
	StringSplit, arg_, rightStr, %A_Space%

	if(arg_2 == ""){
		arg_1 := ifco_valueIfAnySimplexOperationNotShow(arg_1, True, textAll, True)
		arg_1Value := ahkc_dbQuouteOrVariable(arg_1, True)
		return arg_1Value
	}

	if(arg_3 == ""){
		return "@error@"
	}

	arg_1 := ifco_valueIfAnySimplexOperationNotShow(arg_1, True, textAll, True)
	arg_3 := ifco_valueIfAnySimplexOperationNotShow(arg_3, True, textAll, True)

	arg_1Value := ahkc_dbQuouteOrVariable(arg_1, True)
	arg_3Value := ahkc_dbQuouteOrVariable(arg_3, True)

	returnValue =
	if( ifco_isEnyCalcText(arg_2) ){
		returnValue := ifco_answerFromEnyCalc(arg_1Value, arg_2, arg_3Value, arg_4, textAll)
	} else {
		guit_errorAppend("この演算子に対応していない`n" . arg_2 . "`n" . textAll)
	}
	if(returnValue == ""){
		returnValue := "@error@"
	}
	return returnValue
}

; += や -= で使うよう。関数か、計算を実行する
ifco_answerCalcOrFuncOnly(rStr, textAll){
	; 関数の文字列が書かれていたら実行するようにする
	advice := ahkc_isFuncStr(rStr)
	if( advice == null ) {
		ansValue := ahkc_GoFunc_sub(rStr)
		guit_checkErrorLevelOutput("関数のエラー`n" . textAll)
	} else {
		; value++ の処理
		;rStr := ifco_valueIfOnePlusMinusOperationNotShow(rStr, True, textAll)

		ansValue := ifco_answerFromCalcOnly(rStr, textAll)
		if(ansValue == "@error@"){
			guit_errorAppend("計算が不自然`n" . textAll)
			return "@error@"
		}
	}

	If ansValue is integer
	{
		return ansValue
	}
	guit_errorAppend("計算結果が整数ではない`n結果  " . ansValue . "`n" . textAll)
	return "@error@"
}

; += や -= で使うよう。
ifco_anyEqualSubstitution(com1, com2, editAll, GuiNum, typeNum){
	; %変数名% も textOut して使えるようにする
	com1 := outs_textOutTrimss(com1)
	if(com1 == ""){
		guit_errorAppend("代入させる変数名自体がカラになっている`n代入は中止している`n" . editAll)
		return
	}
	if( outs_valueValidatorRulesNot(com1) ){
		guit_errorAppend("変数としては使えない文字がある`n" . com1 . "`n代入は中止している`n" . editAll)
		return
	}

	com1Value := %com1%
	If com1Value is not integer
	{
		guit_errorAppend("変数の値が整数ではない`n変数   " . com1 . "`n値   " . com1Value . "`n代入は中止している`n" . editAll)
		return
	}

	rStr := func_rightStrOrNullFromSearchStr(editAll, com2)
	if(rStr == ""){
		guit_errorAppend("代入する値がカラ`n代入は中止している`n" . editAll)
		return
	}
	ansValue := ifco_answerCalcOrFuncOnly(rStr, editAll)
	if(ansValue == "@error@"){
		guit_errorAppend("次の計算はうまく処理されていない。`n代入は中止している`n" . editAll)
		return
	}

	if(typeNum == 1){
		com1Value += ansValue
	} else if(typeNum == 2){
		com1Value -= ansValue
	} else if(typeNum == 3){
		com1Value *= ansValue
	} else if(typeNum == 4){
		com1Value /= ansValue
	} else if(typeNum == 5){
		com1Value //= ansValue
	}

	%com1% := com1Value

	; 関数を変えて変数がちゃんと代入されているか確認する
	ifco_confirmSetValueAndExplain(com1, com1Value, GuiNum, 1, editAll, True)
}

; .= の代入で使う用
ifco_stringEqualSubstitution(com1, com2, editAll, GuiNum){
	; %変数名% も textOut して使えるようにする
	com1 := outs_textOutTrimss(com1)
	if(com1 == ""){
		guit_errorAppend("代入させる変数名自体がカラになっている`n代入は中止している`n" . editAll)
		return
	}
	if( outs_valueValidatorRulesNot(com1) ){
		guit_errorAppend("変数としては使えない文字がある`n" . com1 . "`n代入は中止している`n" . editAll)
		return
	}

	rStr := func_rightStrOrNullFromSearchStr(editAll, com2)
	if(rStr == ""){
		guit_errorAppend("代入する値がカラ`n代入は中止している`n" . editAll)
		return
	}

	ansValue := ifco_answerEnyCalcOrStringOrFunc(rStr, editAll)
	if(ansValue == "@error@"){
		guit_errorAppend("次の計算はうまく処理されていない。`n" . editAll)
		return
	}

	com1Value := %com1%
	com1Value .= ansValue

	%com1% := com1Value

	; 関数を変えて変数がちゃんと代入されているか確認する
	ifco_confirmSetValueAndExplain(com1, com1Value, GuiNum, 1, editAll, True)
}

; value++ の処理。グローバル変数への代入はこちらで行う
ifco_onePlusMinusOperation(com1Trim, com1Backup, typeNum, beforeFlag, GuiNum, viewType, textAll, errViewFlag){
	com1TextOut := outs_textOutTrimss(com1Trim)
	if(com1TextOut == ""){
		guit_errorAppendViewFlag(errViewFlag, "代入させる変数名自体がカラになっている`n" . com1Backup . "`n" . textAll)
		return  "@error@"
	}

	if( outs_valueValidatorRulesNot(com1TextOut) ){
		guit_errorAppendViewFlag(errViewFlag, "変数としては使えない文字がある`n" . com1Backup . "`n" . textAll)
		return  "@error@"
	}

	com1Value := %com1TextOut%
	if(com1Value == ""){
		guit_errorAppendViewFlag(errViewFlag, "変数の値がカラ`n変数   " . com1Backup . "`n" . textAll)
		return  "@error@"
	}

	If com1Value is not integer
	{
		guit_errorAppendViewFlag(errViewFlag, "整数以外は計算できない`n変数   " . com1TextOut . "`n値   " . com1Value . "`n元の変数   " . com1Backup . "`n" . textAll)
		return  "@error@"
	}
	newValue = 0
	if(typeNum == 1){
		newValue := com1Value + 1
	} else if(typeNum == 2){
		newValue := com1Value - 1
	}

	%com1TextOut% := newValue

	; 関数を変えて変数がちゃんと代入されているか確認する。影で表示する
	res := ifco_confirmSetValueAndExplain(com1TextOut, newValue, GuiNum, viewType, textAll, errViewFlag)
	if( res == False ){
		guit_errorAppendViewFlag(errViewFlag, "変数が代入されていないため、カラの値を返す`n" . com1Backup . "`n" . textAll)
		return  ""
	}

	; ++V_var なら
	if( beforeFlag ){
		; 代入した後の値を返す
		return  newValue
	}
	; 代入する前の値を返す
	return  com1Value
}

; value++ の処理
ifco_valueIfOnePlusMinusOperation(com1, outputFlag, GuiNum, viewType, textAll, errViewFlag){
	returnValue = 0
	IfInString, com1, %A_Space%
	{
		if( outputFlag ){
			returnValue := com1
		}
		; 変数と考えられない場合
		return returnValue
	}
	StringLen, com1Length, com1
	if(com1Length >= 3){
		StringLeft, L2Char, com1, 2
		if(L2Char == "++"){
			StringTrimLeft, com1_right, com1, 2
			com1 := ifco_onePlusMinusOperation(com1_right, com1, 1, True, GuiNum, viewType, textAll, errViewFlag)
			returnValue = 1
		} else if(L2Char == "--"){
			StringTrimLeft, com1_right, com1, 2
			com1 := ifco_onePlusMinusOperation(com1_right, com1, 2, True, GuiNum, viewType, textAll, errViewFlag)
			returnValue = 1
		}
		StringRight, r2Char, com1, 2
		if(r2Char == "++"){
			StringTrimRight, com1_left, com1, 2
			com1 := ifco_onePlusMinusOperation(com1_left, com1, 1, False, GuiNum, viewType, textAll, errViewFlag)
			returnValue = 1
		} else if(r2Char == "--"){
			StringTrimRight, com1_left, com1, 2
			com1 := ifco_onePlusMinusOperation(com1_left, com1, 2, False, GuiNum, viewType, textAll, errViewFlag)
			returnValue = 1
		}
	}

	if( outputFlag ){
		; グローバル変数への代入は  ifco_onePlusMinusOperation()  で済ませているので、
		; com1 は 元の値か、表示用に使う値（V_var++なら、元の値の方）。または @error@
		return com1
	}
	return returnValue
}

; -Var  !Var  not Var  ~Var の処理。グローバル変数への代入はこちらで行う
ifco_simplexOperation(com1Trim, com1Backup, typeNum, GuiNum, viewType, textAll, errViewFlag){
	com1TextOut := outs_textOutTrimss(com1Trim)
	; -Var の場合
	if(typeNum == 1){
		If com1TextOut is number
		{
			; -1 などだった場合は元通りにする
			return  com1Backup
		}
	}

	if(com1TextOut == ""){
		guit_errorAppendViewFlag(errViewFlag, "代入させる変数名自体がカラになっている`n" . com1Backup . "`n" . textAll)
		return  "@error@"
	}

	if( outs_valueValidatorRulesNot(com1TextOut) ){
		guit_errorAppendViewFlag(errViewFlag, "変数としては使えない文字がある`n" . com1Backup . "`n" . textAll)
		return  "@error@"
	}

	com1Value := %com1TextOut%
	if(com1Value == ""){
		guit_errorAppendViewFlag(errViewFlag, "変数の値がカラ`n変数   " . com1Backup . "`n" . textAll)
		return  "@error@"
	}

	If com1Value is not integer
	{
		guit_errorAppendViewFlag(errViewFlag, "整数以外は計算できない`n変数   " . com1TextOut . "`n値   " . com1Value . "`n元の変数   " . com1Backup . "`n" . textAll)
		return  "@error@"
	}
	newValue = 0
	if(typeNum == 1){
		newValue := -com1Value
	} else if(typeNum == 2){
		newValue := !com1Value
	} else if(typeNum == 3){
		newValue := not com1Value
	} else if(typeNum == 4){
		newValue := ~com1Value
	}

	if(newValue == ""){
		guit_errorAppendViewFlag(errViewFlag, "単項演算しで計算結果がカラである`n" . com1Backup . "`n" . textAll)
		return  ""
	}

	; 表示
	if(viewType == 1){
		guit_setExplain(newValue, GuiNum)
	}

	return  newValue
}

; -Var  !Var  ~Var の処理。
ifco_valueIfSimplexOperation(com1, outputFlag, GuiNum, viewType, textAll, errViewFlag){
	returnValue = 0
	IfInString, com1, %A_Space%
	{
		if( outputFlag ){
			returnValue := com1
		}
		; 変数と考えられない場合
		return returnValue
	}
	StringLen, com1Length, com1
	if(com1Length >= 2){
		StringLeft, L2Char, com1, 1
		if(L2Char == "-"){
			com1Backup := com1
			StringTrimLeft, com1_right, com1, 1
			com1 := ifco_simplexOperation(com1_right, com1, 1, GuiNum, viewType, textAll, errViewFlag)
			returnValue = 1
			; 元の変数名が返った場合は 1 を返さない
			if(com1 == com1Backup){
				returnValue = 0
			}
		} else if(L2Char == "!"){
			StringTrimLeft, com1_right, com1, 1
			com1 := ifco_simplexOperation(com1_right, com1, 2, GuiNum, viewType, textAll, errViewFlag)
			returnValue = 1
		} else if(L2Char == "~"){
			StringTrimLeft, com1_right, com1, 1
			com1 := ifco_simplexOperation(com1_right, com1, 4, GuiNum, viewType, textAll, errViewFlag)
			returnValue = 1
		}
	}

	if( outputFlag ){
		; グローバル変数への代入は済ませているので、
		; com1 は 元の値か、表示用に使う値。または @error@
		return com1
	}
	return returnValue
}

; V_var++  -V_var  !V_var  ~V_var  not V_var  の処理
ifco_anySimplexOperationExe(com1, com2, outputFlag, GuiNum, viewType, textAll){
/*
	if( com1 == "not" ){
		com1 := ifco_simplexOperation(com2, com1, 3, GuiNum, viewType, textAll, True)
		if( outputFlag ){
			; グローバル変数への代入は済ませているので、
			; com1 は 元の値か、表示用に使う値。または @error@
			return com1
		}
		return True
	}
*/

	res := ifco_valueIfOnePlusMinusOperation(com1, outputFlag, GuiNum, viewType, textAll, True)
	if( res ){
		return res
	}
	res := ifco_valueIfSimplexOperation(com1, outputFlag, GuiNum, viewType, textAll, True)
	return res
}

; value++ の処理。影で結果表示
ifco_valueIfOnePlusMinusOperationNotShow(com1, outputFlag, textAll){
	com1 := ifco_valueIfOnePlusMinusOperation(com1, outputFlag, 71, 2, textAll, True)
	return com1
}

; 影で結果表示。V_var++  -V_var  !V_var  ~V_var  の処理
ifco_valueIfAnySimplexOperationNotShow(com1, outputFlag, textAll, errViewFlag){
	com1 := ifco_valueIfOnePlusMinusOperation(com1, outputFlag, 71, 2, textAll, errViewFlag)
	if(com1 == "@error@"){
		guit_errorAppendViewFlag(errViewFlag, "++などの計算時にエラーあり")
		return "@error@"
	}
	com1 := ifco_valueIfSimplexOperation(com1, outputFlag, 71, 2, textAll, errViewFlag)
	if(com1 == "@error@"){
		guit_errorAppendViewFlag(errViewFlag, "単項演算の計算時にエラーあり")
		return "@error@"
	}
	return com1
}

; 結果表示をしない。V_var++  -V_var  !V_var  ~V_var  の処理
ifco_valueIfAnySimplexOperationNoView(com1, outputFlag, textAll, errViewFlag){
	com1 := ifco_valueIfOnePlusMinusOperation(com1, outputFlag, 71, 0, textAll, errViewFlag)
	if(com1 == "@error@"){
		guit_errorAppendViewFlag(errViewFlag, "++などの計算時にエラーあり")
		return "@error@"
	}
	com1 := ifco_valueIfSimplexOperation(com1, outputFlag, 71, 0, textAll, errViewFlag)
	if(com1 == "@error@"){
		guit_errorAppendViewFlag(errViewFlag, "単項演算の計算時にエラーあり")
		return "@error@"
	}
	return com1
}

ifco_ifOnlyPattern(ansFlag, command, hwnd, pOut, GuiNum){
	if( ansFlag ){
		cen_easyCheckAppendNotShow("条件文の結果から`n" . command . "  のコマンドを実行する。`n" . A_ThisFunc . "`nA_LineNumber  " . A_LineNumber)
		;edi_outPutSucceedFlagInCaseTrueCommandExeLogic(command, pOut, GuiNum, hwnd, True, False)
		; 出力先の変更を引き継がないように使用変更したので、こちらを使う
		edi_outPutSucceedFlagStopCommandExe(command, "", pOut, GuiNum, hwnd, True)
	}
}

ifco_ifElsePattern(ansFlag, trueCommand, falseCommand, hwnd, pOut, GuiNum){
	if( ansFlag ){
		cen_easyCheckAppendNotShow("条件文の結果から`n" . trueCommand . "  のコマンドを実行する。`n" . A_ThisFunc . "`nA_LineNumber  " . A_LineNumber)
		;edi_outPutSucceedFlagInCaseTrueCommandExeLogic(trueCommand, pOut, GuiNum, hwnd, True, False)
		; 出力先の変更を引き継がないように使用変更したので、こちらを使う
		edi_outPutSucceedFlagStopCommandExe(trueCommand, "", pOut, GuiNum, hwnd, True)
	} else {
		cen_easyCheckAppendNotShow("条件文の結果から`n" . falseCommand . "  のコマンドを実行する。`n" . A_ThisFunc . "`nA_LineNumber  " . A_LineNumber)
		;edi_outPutSucceedFlagInCaseTrueCommandExeLogic(falseCommand, pOut, GuiNum, hwnd, True, False)
		; 出力先の変更を引き継がないように使用変更したので、こちらを使う
		edi_outPutSucceedFlagStopCommandExe(falseCommand, "", pOut, GuiNum, hwnd, True)

	}
}

ifco_stringConcatenationLogic(dbReplaceStr, textAll, errViewFlag){
	;dbReplaceStr := heard_dbQuouteReplaceToValueName(rightStr, True)
	;dbReplaceStr := func_spaceChangeOnlyOne(dbReplaceStr)

	StringSplit, arg_, dbReplaceStr, %A_Space%

	if(arg_1 == ""){
		return ""
	}
	arg_1Value := ahkc_dbQuouteOrVariable(arg_1, errViewFlag)
	buff := arg_1Value

	if(arg_2 == ""){
		return buff
	}

	count := arg_0 - 1
	count := count // 2

	if(count <= 0){
		guit_errorAppendViewFlag(errViewFlag, "文字列の連結の構造が解析できない。`n繰り返す数が０以下`ncount   "  . count . "`n" . textAll)
		return ""
	}
	If count is not integer
	{
		guit_errorAppendViewFlag(errViewFlag, "文字列の連結の構造が解析できない。`n繰り返す数が整数値ではない`ncount   "  . count . "`n" . textAll)
		return ""
	}

	Loop , %count%
	{
		number := A_Index * 2
		plus2 := number
		plus3 := number + 1
		if(arg_%plus2% != "."){
			guit_errorAppendViewFlag(errViewFlag, "文字列の連結の構造が解析できない。`n連結に使う文字以外がある`n謎の文字   "  . arg_%plus2% . "`n" . textAll)
			return ""
		}
		if(arg_%plus3% == ""){
			guit_errorAppendViewFlag(errViewFlag, "文字列の連結の構造が解析できない。`n . があるのにその後連結する文字が存在しない。" . "`n" . textAll)
			return ""
		}
		buff .= ahkc_dbQuouteOrVariable(arg_%plus3%, errViewFlag)
	}

	return buff
}

; 計算式の場合なら True を返す
ifco_isEnyCalcText(com2){
	returnValue := False

	if(com2 == "+"){
		returnValue := True
	} else if(com2 == "-"){
		returnValue := True
	} else if(com2 == "*"){
		returnValue := True
	} else if(com2 == "/"){
		returnValue := True
	} else if(com2 == "//"){
		returnValue := True
	} else if(com2 == "**"){
		returnValue := True
	}
	return returnValue
}

ifco_answerFromEnyCalc(com1, com2, com3, com4, textAll){
	returnValue =
	if(com4 != ""){
		guit_errorAppend("引数の多い計算式に、現時点では対応していない。`n " . com4 . " 以降は処理できない`n" . textAll)
		return ""
	}

	if(com2 == "+"){
		returnValue := com1 + com3
	} else if(com2 == "-"){
		returnValue := com1 - com3
	} else if(com2 == "*"){
		returnValue := com1 * com3
	} else if(com2 == "/"){
		returnValue := com1 / com3
	} else if(com2 == "//"){
		returnValue := com1 // com3
	} else if(com2 == "**"){
		returnValue := com1 ** com3
	}
	return returnValue
}

ifco_isEnyOperationAll(com2){
	returnValue := False

	StringLower, com2, com2
	if(com2 == "+"){
		returnValue := True
	} else if(com2 == "-"){
		returnValue := True
	} else if(com2 == "*"){
		returnValue := True
	} else if(com2 == "/"){
		returnValue := True
	} else if(com2 == "//"){
		returnValue := True
	} else if(com2 == "**"){
		returnValue := True
	} else if(com2 == "=="){
		returnValue := True
	} else if(com2 == "!="){
		returnValue := True
	} else if(com2 == ">="){
		returnValue := True
	} else if(com2 == "<="){
		returnValue := True
	} else if(com2 == ">"){
		returnValue := True
	} else if(com2 == "<"){
		returnValue := True
	} else if(com2 == "||"){
		returnValue := True
	} else if(com2 == "or"){
		returnValue := True
	} else if(com2 == "&&"){
		returnValue := True
	} else if(com2 == "and"){
		returnValue := True
	} else if(com2 == "|"){
		returnValue := True
	} else if(com2 == "&"){
		returnValue := True
	} else if(com2 == "^"){
		returnValue := True
	} else if(com2 == ">>"){
		returnValue := True
	} else if(com2 == "<<"){
		returnValue := True
	} else if(com2 == "<>"){
		returnValue := True
	} else if(com2 == "="){
		returnValue := True
	}
	return returnValue
}

ifco_answerFromOperationAll(com1, com2, com3, com4, textAll, errViewFlag){
	returnValue =
	if(com4 != ""){
		guit_errorAppendViewFlag(errViewFlag, "引数の多い計算式に、現時点では対応していない。`n " . com4 . " 以降は処理できない`n" . textAll)
		return ""
	}

	StringLower, com2, com2
	if(com2 == "+"){
		returnValue := com1 + com3
	} else if(com2 == "-"){
		returnValue := com1 - com3
	} else if(com2 == "*"){
		returnValue := com1 * com3
	} else if(com2 == "/"){
		returnValue := com1 / com3
	} else if(com2 == "//"){
		returnValue := com1 // com3
	} else if(com2 == "**"){
		returnValue := com1 ** com3
	} else if(com2 == "=="){
		returnValue := com1 == com3
	} else if(com2 == "!="){
		returnValue := com1 != com3
	} else if(com2 == ">="){
		returnValue := com1 >= com3
	} else if(com2 == "<="){
		returnValue := com1 <= com3
	} else if(com2 == ">"){
		returnValue := com1 > com3
	} else if(com2 == "<"){
		returnValue := com1 < com3
	} else if(com2 == "||"){
		returnValue := com1 || com3
	} else if(com2 == "or"){
		returnValue := com1 OR com3
	} else if(com2 == "&&"){
		returnValue := com1 && com3
	} else if(com2 == "and"){
		returnValue := com1 AND com3
	} else if(com2 == "|"){
		returnValue := com1 | com3
	} else if(com2 == "&"){
		returnValue := com1 & com3
	} else if(com2 == "^"){
		returnValue := com1 ^ com3
	} else if(com2 == ">>"){
		returnValue := com1 >> com3
	} else if(com2 == "<<"){
		returnValue := com1 << com3
	} else if(com2 == "<>"){
		returnValue := com1 <> com3
	} else if(com2 == "="){
		returnValue := com1 = com3
	}
	return returnValue
}

ifco_answerFromEnyCalcUseValue(dbReplaceStr, textAll, errViewFlag){
	;rightStr := func_spaceChangeOnlyOne(rightStr)
	StringSplit, arg_, dbReplaceStr, %A_Space%

	arg_1 := ifco_valueIfAnySimplexOperationNoView(arg_1, True, textAll, errViewFlag)
	arg_3 := ifco_valueIfAnySimplexOperationNoView(arg_3, True, textAll, errViewFlag)

	arg_1Value := ahkc_dbQuouteOrVariable(arg_1, errViewFlag)
	arg_3Value := ahkc_dbQuouteOrVariable(arg_3, errViewFlag)

	returnValue := ifco_answerFromOperationAll(arg_1Value, arg_2, arg_3Value, arg_4, textAll, errViewFlag)
	return returnValue
}

; 関数の引数としても使えるように ifco_colonEqualSubstitution() から切り分けた
ifco_answerFromEnyCalcOrString(rightStr, textAll, errViewFlag){
	if( rightStr == "" ){
		return ""
	}

	; 空白がないなら、変数名か数値 扱い
	IfNotInString, rightStr, %A_Space%
	{
		rightStr := ifco_valueIfAnySimplexOperationNoView(rightStr, True, textAll, errViewFlag)
		rightStrValue := ahkc_dbQuouteOrVariable(rightStr, errViewFlag)
		return rightStrValue
	}

	dbReplaceStr := heard_dbQuouteReplaceToValueName(rightStr, True)
	dbReplaceStr := func_spaceChangeOnlyOne(dbReplaceStr)
	StringSplit, arg_, dbReplaceStr, %A_Space%
	if(arg_1 == ""){
		return ""
	}

	if(arg_2 == ""){
		arg_1 := ifco_valueIfAnySimplexOperationNoView(arg_1, True, textAll, errViewFlag)
		arg_1Value := ahkc_dbQuouteOrVariable(arg_1, errViewFlag)
		return arg_1Value
	}

	returnValue = 
	if(arg_2 == "."){
		returnValue := ifco_stringConcatenationLogic(dbReplaceStr, textAll, errViewFlag)
	} else {
		returnValue := ifco_answerFromEnyCalcUseValue(dbReplaceStr, textAll, errViewFlag)
		if(returnValue == ""){
			returnValue := "@error@"
		}
	}
	return returnValue
}

ifco_answerFromEnyCalcOrStringUseFunc(rightStr, funcName, textAll, errViewFlag){
	if( rightStr == "" ){
		guit_errorAppendViewFlag(errViewFlag, "関数に使う引数で、引数が記入されていない`n関数名   " . funcName . "`n" . textAll)
		return ""
	}
	returnValue := ifco_answerFromEnyCalcOrString(rightStr, textAll, True)
	if(returnValue == "@error@"){
		guit_errorAppend("関数に使う引数で、何らかのエラーがある`n関数名   " . funcName . "`n問題の引数   " . rightStr)
		return ""
	}
	return returnValue
}

ifco_flagFromRequirement(com1, com2, com3){
	returnValue = 4
	if(com2 == "=="){
		returnValue := com1 == com3
	} else if(com2 == "!="){
		returnValue := com1 != com3
	} else if(com2 == ">="){
		returnValue := com1 >= com3
	} else if(com2 == "<="){
		returnValue := com1 <= com3
	}
	return returnValue
}

; 返り値 1 True, 0 False, 2 if文でなはい（素通り）, 3 説明のみ表示, 4 エラー
ifco_answerFromEnyCalcOrStringUseIfSentence(editAll){
	ansNum = 4
	; 左端の ( を取り除く 
	StringTrimLeft, LTrim, editAll, 1
	; ) の左
	LStr := func_leftStrOrNullFromSearchStrTurnAssign(LTrim, ")", 1)
	LStr := Trim(LStr)
	ansNum := ifco_answerFromEnyCalcOrString(LStr, editAll, True)
	if(ansNum == 0 || ansNum == 1){

	} else {
		guit_errorAppend("カッコ内が条件文の値ではないのでエラー`nカッコ内の値   " . ansNum . "`n" . editAll)
		return 4
	}
	return ansNum
}



; 返り値 1 True, 0 False, 2 if文でなはい（素通り）, 3 説明のみ表示, 4 エラー
/*
ifco_parenthesisLogic(com1, com2, com3, com4, editAll){
	ansNum = 4
	; 左端の ( を取り除く 
	StringTrimLeft, LTrim, editAll, 1
	; ) の左
	LStr := func_leftStrOrNullFromSearchStrTurnAssign(LTrim, ")", 1)
	; ( ) の中が、変数のみか
	IfInString, LStr, %A_Space%
	{
		interior1 =
		interior2 =
		interior3 =
		; 引数１が ( のみかどうか
		if(com1 == "("){
			interior1 := com2
			interior2 := com3

			;com4 := RTrim( com4, ")")
			;interior3 := com4
		} else {
			StringTrimLeft, interior1, com1, 1
			interior2 := com2

			;com3 := RTrim( com3, ")")
			;interior3 := com3
		}
		; interior2 の右全てが ( ) 内の右側
		interior3 := func_rightStrOrNullFromSearchStr(LStr, interior2)

		if(interior3 == ""){
			guit_errorAppend("条件文の３つめの引数がないのでエラー")
			return ""
		}

		interior1Value := ahkc_dbQuouteOrVariable(interior1, True)
		interior3Value := ahkc_dbQuouteOrVariable(interior3, True)

		; "" の文字があったら
		dbQuouteChar := """"
		dbdbQuouteDb := dbQuouteChar . dbQuouteChar
		if(interior1 == dbdbQuouteDb){
			;interior1Value := "@@@"
			interior1Value := ""
		}
		if(interior3 == dbdbQuouteDb){
			;interior3Value := "@@@"
			interior3Value := ""
		}

		cen_easyCheckAppendNotShow("条件文の確認`n" . interior1Value  . "`n" . interior2  . "`n" . interior3Value . "`n" . A_ThisFunc . "`nA_LineNumber  " . A_LineNumber)

		;ansNum := ifco_flagFromRequirement(interior1Value, interior2, interior3Value)
		ansNum := ifco_answerFromOperationAll(interior1Value, interior2, interior3Value, "", editAll, , True)
	} else {
		ansNum := ahkc_dbQuouteOrVariable(LStr, True)
	}
	if(ansNum == 0 || ansNum == 1){

	} else {
		guit_errorAppend("カッコ内が条件文の値ではないのでエラー")
		return 4
	}
	return ansNum
}
*/


ifco_hatenaSentenceLogic(com1, com2, com3, com4, com5, editAll, hwnd, pOut, GuiNum){
	; ( ) の中身を検証
	ansNum := ifco_answerFromEnyCalcOrStringUseIfSentence(editAll)
	if(ansNum == 4){
		return
	}

	rStrHatena := func_rightStrOrNullFromSearchStr(editAll, "? ")
	IfInString, rStrHatena, :
	{
		LStrColon := func_leftStrOrNullFromSearchStrTurnAssign(rStrHatena, ":", 1)
		LStrColon := Trim(LStrColon)
		rStrColon := func_rightStrOrNullFromSearchStr(rStrHatena, ":")
		rStrColon := Trim(rStrColon)
		ifco_ifElsePattern(ansNum, LStrColon, rStrColon, hwnd, pOut, GuiNum)
	} else {
		ifco_ifOnlyPattern(ansNum, rStrHatena, hwnd, pOut, GuiNum)
	}
}

ifco_hatenaSentence(com1, com2, com3, com4, com5, editAll, hwnd, pOut, GuiNum){
	; 左端が (  か確認
	StringLeft, LChr, com1, 1
	if(LChr == "("){
		IfInString, editAll, )
		{
			rStr := func_rightStrOrNullFromSearchStr(editAll, ")")
			if(rStr == ""){
				return False
			}
			; ) の 次が ? か確認
			StringLeft, LChr, rStr, 2
			if(LChr == "? "){
				; ? の次に実行する処理がある
				StringTrimLeft, otherStr, rStr, 2
				otherStr := Trim(otherStr)
				if(otherStr != ""){
					ifco_hatenaSentenceLogic(com1, com2, com3, com4, com5, editAll, hwnd, pOut, GuiNum)
					return True
				}
			}
		}
	}
	return False
}

ifco_ifSentenceCommandExe(ansFlag, editAll, hwnd, pOut, GuiNum){
	trueCommand := editAll
	if(trueCommand == ""){
		return
	}
	kakko := "{"
	StringLeft, LChar, editAll, 1
	if(LChar == kakko){
		IfNotInString, editAll, }
		{
			guit_errorAppend("if文の { } が閉じられていないようなのでエラー`n" . editAll)
			return
		}
		; 左端のブロックの中身を取得
		trueCommand := ifco_blockTrimFirstLeft(editAll, "{", "}", A_LineFile, A_LineNumber)
		; 左端のブロックの右の文字列
		editAllKakko := ifco_rightStrFromBlockTrimFirstLeft(editAll, "{", "}", A_LineFile, A_LineNumber)
		if(editAllKakko != ""){

			StringLeft, L4EditAllKakko, editAllKakko, 4
			StringLower, L4EditAllKakkoLower, L4EditAllKakko
			if(L4EditAllKakkoLower == "else"){
				StringTrimLeft, L4TrimEditAllKakko, editAllKakko, 4
				editAllElse := Trim(L4TrimEditAllKakko)
				if(editAllElse == ""){
					guit_appendExplain("else の後がカラなのでエラー")
					return
				}

				elseCommand := editAllElse
				StringLeft, LChar, editAllElse, 1
				if(LChar == kakko){
					elseCommand := ifco_blockTrimFirstLeft(editAllElse, "{", "}", A_LineFile, A_LineNumber)
					;if(elseCommand == ""){
					;	guit_errorAppend("else文の の中身がカラなのでエラー`n" . editAll)
					;	return
					;}
				}
				ifco_ifElsePattern(ansFlag, trueCommand, elseCommand, hwnd, pOut, GuiNum)
				return
			} else {
				guit_errorAppend("{ } の右に無効な文字がある`n" . editAll)
				return
			}	; if(L4EditAllKakkoLower == "else")
		}	; if(editAllKakko != ""){
	}	; if(LChar == kakko){
	ifco_ifOnlyPattern(ansFlag, trueCommand, hwnd, pOut, GuiNum)
}

ifco_ifSentenceLogic(com1, com2, com3, com4, editAll, hwnd, pOut, GuiNum, notMultipleFlag){
	; ( ) の中身を検証
	ansNum := ifco_answerFromEnyCalcOrStringUseIfSentence(editAll)
	if(ansNum == 4){
		return ansNum
	}

	if( notMultipleFlag ){
		rStr := func_rightStrOrNullFromSearchStr(editAll, ")")
		ifco_ifSentenceCommandExe(ansNum, rStr, hwnd, pOut, GuiNum)
	}
	return ansNum
}

; 返り値 1 True, 0 False, 2 if文でなはい（素通り）, 3 説明のみ表示, 4 エラー
ifco_ifSentence(com1, com2, com3, com4, com5, editAll, hwnd, pOut, GuiNum, notMultipleFlag){
	ansNum = 2
	StringLeft, L2Chr, com1, 2
	StringLower, L2ChrLower, L2Chr
	if(L2ChrLower == "if"){
		StringTrimLeft, L2Trim, editAll, 2
		L2Trim := Trim(L2Trim)
		; 左端が (  か確認
		StringLeft, LChr, L2Trim, 1
		if(LChr == "("){
			IfInString, L2Trim, )
			{
				; com1 が if のみと、if(xxx) となっている場合に対処
				StringLower, com1Lower, com1
				if(com1Lower == "if"){
					ansNum := ifco_ifSentenceLogic(com2, com3, com4, com5, L2Trim, hwnd, pOut, GuiNum, notMultipleFlag)
				} else {
					StringTrimLeft, com1, com1, 2
					ansNum := ifco_ifSentenceLogic(com1, com2, com3, com4, L2Trim, hwnd, pOut, GuiNum, notMultipleFlag)
				}
			}
		}
	}
	return ansNum
}

; "" があったら、none の文字列に置き換える。if文を使う際必要だった。
ifco_existDbquouteNullReplaceNullWord(rightStr){
	dbQuouteChar := """"
	dbdbQuouteDb := dbQuouteChar . dbQuouteChar
	IfInString, rightStr, %dbdbQuouteDb%
	{
		StringReplace, rightStr, rightStr, %dbdbQuouteDb% , none, All
	}
	return rightStr
}

; 条件文かどうかを確認して、返り値のナンバーを得る。（if文は実行しない）
; 返り値 1 True, 0 False, 2 if文でなはい（素通り）, 3 説明のみ表示, 4 エラー
ifco_flagFromIfConditional(ifSentence, pOut, GuiNum){

	delimiter := ","
	IfInString, ifSentence, %delimiter%
	{
		StringSplit, arg_ , ifSentence , %delimiter% , %A_Space%
		ansNum := cof_autohotIfConditional(arg_1, ifSentence, pOut, GuiNum, False)
		if( ansNum != 2 ){
			return  ansNum
		}
	}

	; if文かどうかを確認するだけなので、コマンドのときのように余計な処理はしない
	ifSentenceReplace := RegExReplace(ifSentence, "\s+" , " ")
	;mainCom := func_separationSpaceLeftOrAll(ifSentenceReplace)
	;rightStr := func_separationSpaceRightOrNull(ifSentenceReplace)
	;rightStr := outs_textOutTrimss(rightStr)
	StringSplit, str_, ifSentenceReplace, %A_Space%

	StringLower, str_1Lower, str_1
	if(str_1Lower == "if"){
		ansNum := ifcah_ifSentenceAhkVersion(str_2, str_3, str_4, str_5, str_6, str_7, ifSentence, "", pOut, GuiNum, False)
		if( ansNum != 2 ){
			return  ansNum
		}
	}

	ansNum := ifco_ifSentence(str_1, str_2, str_3, str_4, str_5, ifSentence, "", pOut, GuiNum, False)

	return ansNum
}

; ifco_flagFromIfConditional() の引数が二行以上あった場合、最初の一行以外は余計なのでこちらを使う
ifco_flagFromIfConditionalByBuffComm(buffComm, pOut, GuiNum){
	IfInString, buffComm, `n
	{
		StringGetPos, index, buffComm, `n
		StringLeft, buffComm, buffComm, %index%
		buffComm := Trim( buffComm, "`r" )
	}
	ansNum := ifco_flagFromIfConditional(buffComm, pOut, GuiNum)
	return ansNum
}

; ブロックとして成立してるかを確認。 before がないならブロック文でもないので True
; 前のブロックと後ろのブロックの数が同じであれば True を返す
ifco_blockConfirmOnly(str, before, after){
	IfNotInString, str, %before%
	{
		; before が無いならむしろ True 
		return  True
	}
	IfNotInString, str, %after%
	{
		return  False
	}
	res := ifco_blockTrimCompletionComfirm(str, before, after)
	return  res
}

ifco_calcParsentTextOut(str, textAll){
	StringLeft, L2Char, str, 2
	if(L2Char == "% "){
		StringTrimLeft, rStr, str, 2
		rStr := Trim(rStr)
		rStr := ifco_answerEnyCalcOrStringOrFunc(rStr, textAll)
		if(rStr == "@error@"){
			guit_errorAppend("文字の展開の計算でエラーがある。`n" . str . "`n" . textAll)
			return
		}
		str := rStr
	}
	return str
}

; １度目に カラ 扱いした変数は、２度目以降も カラ 扱いする傾向にある
ifco_globalVarExist(com2){
	if(%com2% == ""){
		return False
	}
	return True
}

ifco_globalVarMake(com2){
	global
	%com2% =
}
