

lasw_checkLastWordKeyForSetter(word, basicWord, valueName){
	wordTrim := Trim( word )
	; 空白のみなら、エラー
	if( wordTrim == "" ){
		return basicWord
	}

	; ２文字以上でなけらばならない
/*
	現時点では、２文字以上でなくてもよい
	StringLen, length, wordTrim
	if( length <= 1 ){
		errMsg := valueName . "  の代入のエラー。`n１文字以下の文字になっている。`n初期値を設定する"
		guit_errorAppend(errMsg)
		return basicWord
	}
*/
	return word
}

lasw_errorLastWord(lastWord){
	tmpLastWord := Trim(lastWord)
	if(tmpLastWord == ""){
		;guit_errorAppend("何も入力されていない箇所がある。`n設定変更は中断している。")
		return True
	}

	; ２文字以上でなけらばならない
/*
	現時点では、２文字以上でなくてもよい
	StringLen, length, tmpLastWord
	if( length <= 1 ){
		guit_errorAppend("２文字以上でなければならない。`nエラー文字  " . lastWord)
		return True
	}
*/

	; 左端は半角スペースであること。
/*
	左端が半角スペースでなくてもよくした
	StringLeft, OutputVar, lastWord, 1
	if(OutputVar == " "){
		return  False
	}
	guit_errorAppend(lastWord . "`nの文字はNG。`n左端は半角スペースを入れること。`n設定変更は中断している。")
	return True

*/
	return False
}

lasw_errorLastWordChangeAfte(wordLocal){
	; 全角の空白は、半角に変える
	StringReplace, tmpWordLocal, wordLocal, 　 , %A_Space%, All
	tmpWordLocal := Trim(tmpWordLocal)
	if(tmpWordLocal == ""){
		return True
	}
}

lasw_autoBetweenWordExecuteSendEnd( str, pControl, GuiNum ){

	betweenWordTrim := Trim(glob_iniBetweenExeWordEndKey)
	if( betweenWordTrim == "" ){
		return False
	}

	IfInString, str, %glob_iniBetweenExeWordEndKey%
	{
		; ２文字以上でなければ、受け付けない
		;StringLen, trimLength, betweenWordTrim
		;if( trimLength <= 1 ){
		;	return False
		;}

		StringLen, strLength, str
		StringLen, length, glob_iniBetweenExeWordEndKey
		if(strLength >= length){
			; 指定文字を取り除いた文字列を作る
			; StringReplace, trimStr, str, %glob_iniBetweenExeWordEndKey%
			StringGetPos, count, str, %glob_iniBetweenExeWordEndKey%
			StringLeft, leftStr, str, %count%
			count += length
			StringTrimLeft, rightStr , str, %count%
			trimStr := leftStr . rightStr

			;BlockInput, On
			guf_setControl( trimStr, pControl, GuiNum )
			;BlockInput, Off
			edc_commListHideEnyType(GuiNum)
			; 入力補完が１度だけ表示されないようにする
			if( O_inputListAutoNotFlag == False ){
				glob_lastWordInputListStop := True
			}
			Send, {End}
			return True
		}
	}
	return False
}

lasw_autoBetweenWordExecuteAssign( str, betweenWord, headComm, pControl, GuiNum ){
	betweenWordTrim := Trim(betweenWord)
	if( betweenWordTrim == "" ){
		return False
	}
	headComm := Trim(headComm)
	if( headComm == "" ){
		return False
	}

	IfInString, str, %betweenWord%
	{
		; ２文字以上でなければ、受け付けない
		;StringLen, trimLength, betweenWordTrim
		;if( trimLength <= 1 ){
		;	return False
		;}
		StringLen, length, betweenWord
		StringLen, strLength, str
		if(strLength < length){
			return False
		}

		; 指定文字を取り除いた文字列を作る
		; StringReplace, trimStr, str, %betweenWord%
		StringGetPos, count, str, %betweenWord%
		StringLeft, leftStr, str, %count%
		count += length
		StringTrimLeft, rightStr , str, %count%
		trimStr := leftStr . rightStr

		;BlockInput, On
		guf_setControl( trimStr, pControl, GuiNum )
		;BlockInput, Off
		edc_commListHideEnyType(GuiNum)
		; 入力補完が１度だけ表示されないようにする
		if( O_inputListAutoNotFlag == False ){
			glob_lastWordInputListStop := True
		}
		lasw_rightEndForLastWord()
		hotk_myGuiShortKat(headComm)
		return True
	}
	return False
}

lasw_executeBetweenWordAssign1( str, pControl, GuiNum ){
	if( O_betweenWordScript1_1 != "" ){
		if( lasw_autoBetweenWordExecuteAssign( str, O_betweenWordKey1_1, O_betweenWordScript1_1, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_betweenWordScript1_2 != "" ){
		if( lasw_autoBetweenWordExecuteAssign( str, O_betweenWordKey1_2, O_betweenWordScript1_2, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_betweenWordScript1_3 != "" ){
		if( lasw_autoBetweenWordExecuteAssign( str, O_betweenWordKey1_3, O_betweenWordScript1_3, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_betweenWordScript1_4 != "" ){
		if( lasw_autoBetweenWordExecuteAssign( str, O_betweenWordKey1_4, O_betweenWordScript1_4, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_betweenWordScript1_5 != "" ){
		if( lasw_autoBetweenWordExecuteAssign( str, O_betweenWordKey1_5, O_betweenWordScript1_5, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_betweenWordScript1_6 != "" ){
		if( lasw_autoBetweenWordExecuteAssign( str, O_betweenWordKey1_6, O_betweenWordScript1_6, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_betweenWordScript1_7 != "" ){
		if( lasw_autoBetweenWordExecuteAssign( str, O_betweenWordKey1_7, O_betweenWordScript1_7, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_betweenWordScript1_8 != "" ){
		if( lasw_autoBetweenWordExecuteAssign( str, O_betweenWordKey1_8, O_betweenWordScript1_8, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_betweenWordScript1_9 != "" ){
		if( lasw_autoBetweenWordExecuteAssign( str, O_betweenWordKey1_9, O_betweenWordScript1_9, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_betweenWordScript1_10 != "" ){
		if( lasw_autoBetweenWordExecuteAssign( str, O_betweenWordKey1_10, O_betweenWordScript1_10, pControl, GuiNum ) ){
			return True
		}
	}
	return False
}

lasw_autoExecuteFromBetweenWord( str, pControl, GuiNum ){
	if( glob_iniBetweenExeWordEndFlag ){
		if( lasw_autoBetweenWordExecuteSendEnd( str, pControl, GuiNum ) ){
			return
		}
	}
	if( O_betweenWordTabAllFlag1 ){
		if( lasw_executeBetweenWordAssign1( str, pControl, GuiNum ) ){
			return
		}
	}
}

lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, trimCount ){
	;BlockInput, On
	StringTrimRight, trimStr, str, %trimCount%
	guf_setControl( trimStr, pControl, GuiNum )
	;BlockInput, Off
	edc_commListHideEnyType(GuiNum)
	; 入力補完が１度だけ表示されないようにする
	if( O_inputListAutoNotFlag == False ){
		glob_lastWordInputListStop := True
	}
	lasw_rightEndForLastWord()
	return trimStr
}

; 入力補完を決定するだけ
lasw_inputListSelectOnly(GuiNum){
	typeNum := guit_editTypeNumGet(GuiNum)
	if( typeNum == 1 ){
		autg_pushEnterFromListEditss(GuiNum)
	} else if( typeNum == 2 ){
		pEdit1 := "Edit" . GuiNum  . "_1"
		aut_varSetFileItem(pEdit1, GuiNum, "List70_1", 70)
	} else if( typeNum == 0 ){
		pEdit1 := "Edit" . GuiNum  . "_1"
		aut_varSetFileItem(pEdit1, GuiNum, "List70_1", 70)
	}
}

; カーソルを右端に移動する。現在は End キーを使うだけ
lasw_rightEndForLastWord(){
	;Sleep, 100
	Send, {End}
}

; 決定
lasw_autoLastWordExecuteEnterOrPopupEnter( str, pControl, pList, GuiNum, trimCount ){
	;BlockInput, On
	StringTrimRight, trimStr, str, %trimCount%
	guf_setControl( trimStr, pControl, GuiNum )
	;BlockInput, Off
	edc_commListHideEnyType(GuiNum)

	; 入力補完が１度だけ表示されないようにする
	if( O_inputListAutoNotFlag == False ){
		glob_lastWordInputListStop := True
		; 入力補完が隠れるのを待つ
		Sleep, 200
	}
	lasw_rightEndForLastWord()
	Send, {Enter}

/*
	if( O_inputListAutoNotFlag == False ){
		glob_lastWordInputListStop := True
	}
	hotk_myGuiShortKat("")
*/

}

lasw_enterForLastWord(com1, GuiNum){
	pEdit1 := "Edit" . GuiNum  . "_1"
	editVar := guf_getControl( pEdit1, GuiNum )
	mainCom := func_separationSpaceLeftOrAll(editVar)
	if(mainCom == com1){
		guit_errorAppend(editVar . "`nにより、Enterがループするので、テキスト上に`n" . com1 . "`nを記述しないようにすること。")
		return
	}

	edc_commListHideEnyType(GuiNum)
	; 入力補完が１度だけ表示されないようにする
	if( O_inputListAutoNotFlag == False ){
		glob_lastWordInputListStop := True
		; 入力補完が隠れるのを待つ
		Sleep, 200
	}
	Send, {Enter}
	;hotk_myGuiShortKat("")
}

lasw_autoLastWordExecuteCtrlNumber( str, pControl, pList, GuiNum ){
	lastWordTrim := Trim(glob_iniLastWordExeCtrlNumText)
	if( lastWordTrim == "" ){
		return False
	}

	ctrlWord := glob_iniLastWordExeCtrlNumText
	ctrlWord1 := ctrlWord . "1"		; ctr1
	ctrlWord2 := ctrlWord . "2"		; ctr2
	ctrlWord3 := ctrlWord . "3"
	ctrlWord4 := ctrlWord . "4"
	ctrlWord5 := ctrlWord . "5"
	ctrlWord6 := ctrlWord . "6"
	ctrlWord7 := ctrlWord . "7"
	ctrlWord8 := ctrlWord . "8"
	ctrlWord9 := ctrlWord . "9"
	ctrlWord0 := ctrlWord . "0"

	StringLen, length, ctrlWord1
	StringLen, strLength, str
	if(strLength < length){
		return False
	}
	StringRight, rWord, str, %length%
	;length--
	if(rWord == ctrlWord1){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 6 1")
		return True
	} else if(rWord == ctrlWord2){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 6 2")
		return True
	} else if(rWord == ctrlWord3){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 6 3")
		return True
	} else if(rWord == ctrlWord4){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 6 4")
		return True
	} else if(rWord == ctrlWord5){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 6 5")
		return True
	} else if(rWord == ctrlWord6){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 6 6")
		return True
	} else if(rWord == ctrlWord7){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 6 7")
		return True
	} else if(rWord == ctrlWord8){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 6 8")
		return True
	} else if(rWord == ctrlWord9){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 6 9")
		return True
	} else if(rWord == ctrlWord0){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 6 10")
		return True
	}
	return False
}

lasw_autoLastWordExecuteShiftCtrlNumber( str, pControl, pList, GuiNum ){
	lastWordTrim := Trim(glob_iniLastWordExeShiftCtrlNumText)
	if( lastWordTrim == "" ){
		return False
	}

	ShiftCtrlWord := glob_iniLastWordExeShiftCtrlNumText
	ShiftCtrlWord1 := ShiftCtrlWord . "1"		; shctr1
	ShiftCtrlWord2 := ShiftCtrlWord . "2"		; shctr2
	ShiftCtrlWord3 := ShiftCtrlWord . "3"
	ShiftCtrlWord4 := ShiftCtrlWord . "4"
	ShiftCtrlWord5 := ShiftCtrlWord . "5"
	ShiftCtrlWord6 := ShiftCtrlWord . "6"
	ShiftCtrlWord7 := ShiftCtrlWord . "7"
	ShiftCtrlWord8 := ShiftCtrlWord . "8"
	ShiftCtrlWord9 := ShiftCtrlWord . "9"
	ShiftCtrlWord0 := ShiftCtrlWord . "0"

	StringLen, length, ShiftCtrlWord1
	StringLen, strLength, str
	if(strLength < length){
		return False
	}
	StringRight, rWord, str, %length%
	;length--
	if(rWord == ShiftCtrlWord1){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 7 1")
		return True
	} else if(rWord == ShiftCtrlWord2){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 7 2")
		return True
	} else if(rWord == ShiftCtrlWord3){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 7 3")
		return True
	} else if(rWord == ShiftCtrlWord4){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 7 4")
		return True
	} else if(rWord == ShiftCtrlWord5){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 7 5")
		return True
	} else if(rWord == ShiftCtrlWord6){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 7 6")
		return True
	} else if(rWord == ShiftCtrlWord7){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 7 7")
		return True
	} else if(rWord == ShiftCtrlWord8){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 7 8")
		return True
	} else if(rWord == ShiftCtrlWord9){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 7 9")
		return True
	} else if(rWord == ShiftCtrlWord0){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 7 10")
		return True
	}
	return False
}

lasw_autoLastWordExecuteUseTextNumber( str, pControl, pList, GuiNum ){
	lastWordTrim := Trim(glob_iniLastWordExeUseTextNumText)
	if( lastWordTrim == "" ){
		return False
	}
	useTextWordOnly := glob_iniLastWordExeUseTextNumText
	useTextWord1 := useTextWordOnly . "1"
	useTextWord2 := useTextWordOnly . "2"
	useTextWord3 := useTextWordOnly . "3"
	useTextWord4 := useTextWordOnly . "4"
	useTextWord5 := useTextWordOnly . "5"

	StringLen, length, useTextWord1
	StringLen, strLength, str
	if(strLength < length){
		return False
	}
	StringRight, rWord, str, %length%
	;length--
	if(rWord == useTextWord1){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 1")
		return True
	} else if(rWord == useTextWord2){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 2")
		return True
	} else if(rWord == useTextWord3){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 3")
		return True
	} else if(rWord == useTextWord4){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 4")
		return True
	} else if(rWord == useTextWord5){
		lasw_autoLastWordPrefaceExecute( str, pControl, pList, GuiNum, length )
		hotk_myGuiShortKat("&collabText 5")
		return True
	}
	return False
}

lasw_autoLastWordExecutePopupControl( str, pControl, GuiNum ){
	lastWordTrim := Trim(glob_iniLastWordExePuppupViewText)
	if( lastWordTrim == "" ){
		return False
	}

	StringLen, length, glob_iniLastWordExePuppupViewText
	StringLen, strLength, str
	if(strLength < length){
		return False
	}
	StringRight, rWord, str, %length%
	;length--
	if(rWord == glob_iniLastWordExePuppupViewText){
		;BlockInput, On
		StringTrimRight, trimStr, str, %length%
		guf_setControl( trimStr, pControl, GuiNum )
		;BlockInput, Off
		;if( glob_iniAutoPopupNotViewFlag == False ){
		;if( O_inputListAutoNotFlag == False ){
		;	guit_setExplain("自動で入力補完を表示している場合は  " . glob_iniLastWordExePuppupViewText . "  は無効になる", GuiNum)
		;	return True
		;}
		;lasw_rightEndForLastWord()
		hotk_myGuiShortKat("&popList")

		return True
	}
	return False
}

lasw_autoLastWordExecuteCleanEdit( str, pControl, pList, GuiNum ){
	lastWordTrim := Trim(glob_iniLastWordTextCleanText)
	if( lastWordTrim == "" ){
		return False
	}

	StringLen, length, glob_iniLastWordTextCleanText
	StringLen, strLength, str
	if(strLength < length){
		return False
	}
	StringRight, rWord, str, %length%
	;length--
	if(rWord == glob_iniLastWordTextCleanText){
		hotk_myGuiShortKat("&cleanText")
		return True
	}
	return False
}

lasw_autoLastWordExecuteSpaceSend( str, pControl, GuiNum ){
	lastWordTrim := Trim(glob_iniLastWordSpaceSendText)
	if( lastWordTrim == "" ){
		return False
	}

	StringLen, length, glob_iniLastWordSpaceSendText
	StringLen, strLength, str
	if(strLength < length){
		return False
	}
	StringRight, rWord, str, %length%
	;length--
	if(rWord == glob_iniLastWordSpaceSendText){

		;BlockInput, On
		StringTrimRight, trimStr, str, %length%
		trimStr := trimStr . " "
		guf_setControl( trimStr, pControl, GuiNum )
		;BlockInput, Off
		Sleep, 100
		lasw_rightEndForLastWord()

		return True
	}
	return False
}

lasw_autoLastWordExecuteAssign( str, lastWord, headComm, pControl, GuiNum ){
	lastWordTrim := Trim(lastWord)
	if( lastWordTrim == "" ){
		return False
	}
	headComm := Trim(headComm)
	if( headComm == "" ){
		return False
	}

	StringLen, length, lastWord
	StringLen, strLength, str
	if(strLength < length){
		return False
	}
	StringRight, rWord, str, %length%
	;length--
	if(rWord == lastWord){
		;BlockInput, On
		StringTrimRight, trimStr, str, %length%
		guf_setControl( trimStr, pControl, GuiNum )
		;BlockInput, Off
		edc_commListHideEnyType(GuiNum)
		; 入力補完が１度だけ表示されないようにする
		if( O_inputListAutoNotFlag == False ){
			glob_lastWordInputListStop := True
		}
		lasw_rightEndForLastWord()
		hotk_myGuiShortKat(headComm)
		return True
	}
	return False
}

lasw_executeLastWordBasic( str, pControl, pList, GuiNum ){
	if( glob_iniLastWordExeEnterFlag ){
		StringLen, strLength, str
		lastWordTrim := Trim(glob_iniLastWordExeEnterText)
		if( lastWordTrim != "" ){
			StringLen, length, glob_iniLastWordExeEnterText
			if(strLength >= length){
				StringRight, rWord, str, %length%
				;length--
				if(rWord == glob_iniLastWordExeEnterText){
					lasw_autoLastWordExecuteEnterOrPopupEnter( str, pControl, pList, GuiNum, length )
					return True
				}
			}
		}

		lastWordTrim := Trim(glob_iniLastWordExeEnterText2)
		if( lastWordTrim != "" ){
			StringLen, length, glob_iniLastWordExeEnterText2
			if(strLength >= length){
				StringRight, rWord, str, %length%
				;length--
				if(rWord == glob_iniLastWordExeEnterText2){
					lasw_autoLastWordExecuteEnterOrPopupEnter( str, pControl, pList, GuiNum, length )
					return True
				}
			}
		}
	}
	if( glob_iniLastWordExeCtrlNumFlag ){
		if( lasw_autoLastWordExecuteCtrlNumber( str, pControl, pList, GuiNum ) ){
			return True
		}
	}
	if( glob_iniLastWordExeShiftCtrlNumFlag ){
		if( lasw_autoLastWordExecuteShiftCtrlNumber( str, pControl, pList, GuiNum ) ){
			return True
		}
	}
	if( glob_iniLastWordExeUseTextNumFlag ){
		if( lasw_autoLastWordExecuteUseTextNumber( str, pControl, pList, GuiNum ) ){
			return True
		}
	}
	if( glob_iniLastWordExePuppupViewFlag ){
		if( lasw_autoLastWordExecutePopupControl( str, pControl, GuiNum ) ){
			return True
		}
	}
	if( glob_iniLastWordTextCleanFlag ){
		if( lasw_autoLastWordExecuteCleanEdit( str, pControl, pList, GuiNum ) ){
			return True
		}
	}
	if( glob_iniLastWordAsHeadExeFlag ){
		flag := lasw_autoLastWordExecuteAssign( str, glob_iniLastWordAsHeadExeText, "&lastAsHeadExecute", pControl, GuiNum )
		if( flag ){
			return True
		}
	}
	if( glob_iniLastWordSpaceSendFlag ){
		if( lasw_autoLastWordExecuteSpaceSend( str, pControl, GuiNum ) ){
			return True
		}
	}
	return False
}

lasw_executeLastWordAssign2( str, pControl, pList, GuiNum ){
	if( O_lastWordScript2_1 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey2_1, O_lastWordScript2_1, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript2_2 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey2_2, O_lastWordScript2_2, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript2_3 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey2_3, O_lastWordScript2_3, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript2_4 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey2_4, O_lastWordScript2_4, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript2_5 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey2_5, O_lastWordScript2_5, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript2_6 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey2_6, O_lastWordScript2_6, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript2_7 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey2_7, O_lastWordScript2_7, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript2_8 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey2_8, O_lastWordScript2_8, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript2_9 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey2_9, O_lastWordScript2_9, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript2_10 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey2_10, O_lastWordScript2_10, pControl, GuiNum ) ){
			return True
		}
	}
	return False
}

lasw_executeLastWordAssign3( str, pControl, pList, GuiNum ){
	if( O_lastWordScript3_1 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey3_1, O_lastWordScript3_1, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript3_2 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey3_2, O_lastWordScript3_2, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript3_3 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey3_3, O_lastWordScript3_3, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript3_4 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey3_4, O_lastWordScript3_4, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript3_5 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey3_5, O_lastWordScript3_5, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript3_6 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey3_6, O_lastWordScript3_6, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript3_7 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey3_7, O_lastWordScript3_7, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript3_8 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey3_8, O_lastWordScript3_8, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript3_9 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey3_9, O_lastWordScript3_9, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript3_10 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey3_10, O_lastWordScript3_10, pControl, GuiNum ) ){
			return True
		}
	}
	return False
}

lasw_executeLastWordAssign4( str, pControl, pList, GuiNum ){
	if( O_lastWordScript4_1 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey4_1, O_lastWordScript4_1, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript4_2 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey4_2, O_lastWordScript4_2, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript4_3 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey4_3, O_lastWordScript4_3, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript4_4 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey4_4, O_lastWordScript4_4, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript4_5 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey4_5, O_lastWordScript4_5, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript4_6 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey4_6, O_lastWordScript4_6, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript4_7 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey4_7, O_lastWordScript4_7, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript4_8 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey4_8, O_lastWordScript4_8, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript4_9 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey4_9, O_lastWordScript4_9, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript4_10 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey4_10, O_lastWordScript4_10, pControl, GuiNum ) ){
			return True
		}
	}
	return False
}

lasw_executeLastWordAssign5( str, pControl, pList, GuiNum ){
	if( O_lastWordScript5_1 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey5_1, O_lastWordScript5_1, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript5_2 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey5_2, O_lastWordScript5_2, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript5_3 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey5_3, O_lastWordScript5_3, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript5_4 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey5_4, O_lastWordScript5_4, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript5_5 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey5_5, O_lastWordScript5_5, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript5_6 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey5_6, O_lastWordScript5_6, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript5_7 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey5_7, O_lastWordScript5_7, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript5_8 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey5_8, O_lastWordScript5_8, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript5_9 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey5_9, O_lastWordScript5_9, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript5_10 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey5_10, O_lastWordScript5_10, pControl, GuiNum ) ){
			return True
		}
	}
	return False
}

/*
lasw_executeLastWordAssign6( str, pControl, pList, GuiNum ){
	if( O_lastWordScript6_1 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey6_1, O_lastWordScript6_1, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript6_2 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey6_2, O_lastWordScript6_2, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript6_3 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey6_3, O_lastWordScript6_3, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript6_4 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey6_4, O_lastWordScript6_4, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript6_5 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey6_5, O_lastWordScript6_5, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript6_6 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey6_6, O_lastWordScript6_6, pControl, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordScript6_7 != "" ){
		if( lasw_autoLastWordExecuteAssign( str, O_lastWordKey6_7, O_lastWordScript6_7, pControl, GuiNum ) ){
			return True
		}
	}
	return False
}
*/

lasw_autoExeLastWordOnly( str, pControl, pList, GuiNum ){
	if( glob_iniLastWordExeAllFlag ){
		if( lasw_executeLastWordBasic( str, pControl, pList, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordTabAllFlag2 ){
		if( lasw_executeLastWordAssign2( str, pControl, pList, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordTabAllFlag3 ){
		if( lasw_executeLastWordAssign3( str, pControl, pList, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordTabAllFlag4 ){
		if( lasw_executeLastWordAssign4( str, pControl, pList, GuiNum ) ){
			return True
		}
	}
	if( O_lastWordTabAllFlag5 ){
		if( lasw_executeLastWordAssign5( str, pControl, pList, GuiNum ) ){
			return True
		}
	}
	return False
}

; 全角の数字のみなら、True を返すだけ
lasw_isfullNumeralOnly(str){
	if( str == "０" ){
		return True
	} else if( str == "１" ){
		return True
	} else if( str == "２" ){
		return True
	} else if( str == "３" ){
		return True
	} else if( str == "４" ){
		return True
	} else if( str == "５" ){
		return True
	} else if( str == "６" ){
		return True
	} else if( str == "７" ){
		return True
	} else if( str == "８" ){
		return True
	} else if( str == "９" ){
		return True
	}
	return False
}

lasw_lastWordChangeAfterTrim(str){
	StringLeft, lChr, str, 1
	if( lChr == "<" ){
		StringRight, rChr, str, 1
		if( rChr == ">" ){
			StringTrimLeft, str, str, 1
			StringTrimRight, str, str, 1
		}
	}
	return str
}

lasw_changeAndReExecuteLogic(str, pControl, pList, GuiNum, replaceAfter, replaceChoice1, replaceChoice2, replaceChoice3){
	if( replaceChoice1 != "" ){
		StringLen, num, replaceChoice1
		if( str >= num ){
			StringRight, rightStr, str, num
			if( rightStr == replaceChoice1 ){
				StringTrimRight, str, str, num
				replaceAfter := lasw_lastWordChangeAfterTrim(replaceAfter)
				str .= replaceAfter
				lasw_autoExeLastWordOnly( str, pControl, pList, GuiNum )
				; 実行しなくても終了する
				return True
			}
		}
	}
	if( replaceChoice2 != "" ){
		StringLen, num, replaceChoice2
		if( str >= num ){
			StringRight, rightStr, str, num
			if( rightStr == replaceChoice2 ){
				StringTrimRight, str, str, num
				replaceAfter := lasw_lastWordChangeAfterTrim(replaceAfter)
				str .= replaceAfter
				lasw_autoExeLastWordOnly( str, pControl, pList, GuiNum )
				; 実行しなくても終了する
				return True
			}
		}
	}
	if( replaceChoice3 != "" ){
		StringLen, num, replaceChoice3
		if( str >= num ){
			StringRight, rightStr, str, num
			if( rightStr == replaceChoice3 ){
				StringTrimRight, str, str, num
				replaceAfter := lasw_lastWordChangeAfterTrim(replaceAfter)
				str .= replaceAfter
				lasw_autoExeLastWordOnly( str, pControl, pList, GuiNum )
				; 実行しなくても終了する
				return True
			}
		}
	}
	return False
}

; 最後の文字に、候補にあげた文字があったら変換させて、再アタックをかける
lasw_lastWordChangeAndReExecute(str, pControl, pList, GuiNum){

	; 右端の全角数字を半角数字に
	if( glob_iniLastWordChangeHalfNumFlag ){
		StringRight, rChr, str, 1
		if( lasw_isfullNumeralOnly(rChr) ){
			rChr := outs_fullNumeralReplacehalf(rChr)
			StringTrimRight, str, str, 1
			; 変換させた str はこの後も使う
			str .= rChr
			if( lasw_autoExeLastWordOnly( str, pControl, pList, GuiNum ) ){
				return True
			}
		}
	}

	if( glob_iniLastWordChangeFlag1 ){
		if( glob_iniLastWordChangeAfter1 != "" ){
			if( lasw_changeAndReExecuteLogic(str, pControl, pList, GuiNum, glob_iniLastWordChangeAfter1, glob_iniLastWordChangeChoice1_1, glob_iniLastWordChangeChoice1_2, glob_iniLastWordChangeChoice1_3) ){
				return True
			}
		}
	}
	if( glob_iniLastWordChangeFlag2 ){
		if( glob_iniLastWordChangeAfter2 != "" ){
			if( lasw_changeAndReExecuteLogic(str, pControl, pList, GuiNum, glob_iniLastWordChangeAfter2, glob_iniLastWordChangeChoice2_1, glob_iniLastWordChangeChoice2_2, glob_iniLastWordChangeChoice2_3) ){
				return True
			}
		}
	}
	if( glob_iniLastWordChangeFlag3 ){
		if( glob_iniLastWordChangeAfter3 != "" ){
			if( lasw_changeAndReExecuteLogic(str, pControl, pList, GuiNum, glob_iniLastWordChangeAfter3, glob_iniLastWordChangeChoice3_1, glob_iniLastWordChangeChoice3_2, glob_iniLastWordChangeChoice3_3) ){
				return True
			}
		}
	}
	return False
}

lasw_autoExecuteFromLastWord( pControl, pList, winTitle, GuiNum ){

	; テキストがアクティブでないなら何もしない
	IfWinNotActive , %winTitle%
	{
		return
	}

	; ##や%%を展開する前を参考にするため、入力中の文字のみ取得
	str := guf_getControl( pControl, GuiNum )

	if( lasw_autoExeLastWordOnly( str, pControl, pList, GuiNum ) ){
		return
	}

	; 最後の文字に、候補にあげた文字があったら変換させて、再アタックをかける
	if( lasw_lastWordChangeAndReExecute(str, pControl, pList, GuiNum) ){
		return
	}

	lasw_autoExecuteFromBetweenWord( str, pControl, GuiNum )
}
