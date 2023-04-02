; 必須 glob outs
; auts

; 入力補完の時に使うと危険な文字をチェックする
; 戻り値あり
aut_checkDangerStr(str) {
	StringLower, tmpStr, str
	IfInString, tmpStr, a:
	{
		guit_errorAppend("A:\は使わないように")
		return  "@@@@@"
	}
	; \\ と、２つあっても、ファイル扱いしてしまうので、通さないように
	IfInString, str, \\
	{
		return  "@@@@@"
	}

	return  str
}


aut_varSetItem(pEdit, pList, GuiNum=1){
	GuiControlGet, OutputVar , %GuiNum%:Visible, %pList%
	if(OutputVar == 1) {
		GuiControlGet, %pList% ,%GuiNum%:
		if(%pList% == ""){					; 何も選択してない場合１番目を選択させる
			GuiControl, %GuiNum%:Choose, %pList%, 1
			GuiControlGet, %pList% ,%GuiNum%:
		}
		listStr := guf_getControl( pList, GuiNum )
		if(listStr != ""){
			guf_setControl( listStr, pEdit, GuiNum )
		}
		GuiControl, %GuiNum%:Focus, %pEdit%
		Send, {End}
		; 「自動で入力補完を表示する」場合、再表示されてしまうため遅らせる
		;if( glob_iniAutoPopupNotViewFlag == False ){
		if( O_inputListAutoNotFlag == False ){
			Sleep, 200
		}
		GuiControl, %GuiNum%:Disable, %pList%
		GuiControl, %GuiNum%:Hide, %pList%

		return True
	}
	return False
}

aut_varSetFileItem(pEdit, GuiNum, pList, listGuiNum) {
	GuiControlGet, OutputVar , %listGuiNum%:Visible, %pList%
	if(OutputVar == 1) {
		GuiControlGet, %pEdit% ,%GuiNum%:
		GuiControlGet, %pList% ,%listGuiNum%:
		if(%pList% == ""){					; 何も選択してない場合１番目を選択させる
			GuiControl, %listGuiNum%:Choose, %pList%, 1
			GuiControlGet, %pList% ,%listGuiNum%:
		}


		; 最後の文字の部分のみ変更するようにする( 空白の前の部分を残す)
		StringGetPos, spaceIndex, %pEdit%, %A_Space%, R1
		beforeStr =
		if(spaceIndex <= -1 ) {		; Spaceがない場合
			; フォルダ名の次に文字を継ぎ足すようにする
			StringGetPos, enIndex , %pEdit%, \ , R1
			if(enIndex > -1) {
				enIndex++
				StringLeft, beforeStr, %pEdit%, enIndex
			}
		} else {		; Spaceがある場合
			StringGetPos, enIndex , %pEdit%, \ , R1
			if(enIndex > -1) {				;スペースも\ もある場合
				if(spaceIndex > enIndex) {		; どちらが後にあるかで判定
					spaceIndex++
					StringLeft, beforeStr, %pEdit%, spaceIndex
				} else {						; \ が後にある場合
					enIndex++
					StringLeft, beforeStr, %pEdit%, enIndex
				}
			} else {		; Spaceはあるが、\はない場合
				spaceIndex++
				StringLeft, beforeStr, %pEdit%, spaceIndex
			}
		}
		listStr := %pList%
		rChr =
		; 入力補完のほうがカラだったら、文字を変えない
		if(listStr != ""){
			StringRight, rChr, listStr, 1
			str := beforeStr . listStr
			; 半角スペース追加の設定がオンなら
			;if( glob_iniSpacePlusFlag ){
			if( O_spacePlusFlag ){
				; フォルダ名の入力以外なら、半角スペース追加
				if(rChr != "\") {
					str .= A_Space
				}
			}
			guf_setControl( str, pEdit, GuiNum )
		}
		GuiControl, %GuiNum%:Focus, %pEdit%
		Send, {End}

		if(rChr == "\") {
			; 入力補完を続けて表示。（Gui のサイズの変更は SubEdit のやつにまかせる）
			aut_visiblePopUpListEnyType(pList, pEdit, GuiNum, 1, 0)
		} else {
			; 「自動で入力補完を表示する」場合、再表示されてしまうため遅らせる
			;if( glob_iniAutoPopupNotViewFlag == False ){
			if( O_inputListAutoNotFlag == False ){
				Sleep, 200
			}

			editType := guit_editTypeNumGet(GuiNum)
			if(editType == 1) {
				GuiControl, %listGuiNum%:Disable, %pList%
				GuiControl, %listGuiNum%:Hide, %pList%
			} else if( editType == 2) {
				;edi_commListHide(pList, pEdit, GuiNum)
				edi_commListHideAnotherGui()
			} else if( editType == 0) {
				edi_commListHideAnotherGui()
			}
		}
		return True
	}
	return False
}

/* AnotherGui版を用意するのではなくて、aut_varSetFileItem 自体を改良した
aut_varSetFileItem(pEdit, pList, GuiNum) {
	GuiControlGet, OutputVar , %GuiNum%:Visible, %pList%
	if(OutputVar == 1) {
		GuiControlGet, %pEdit% ,%GuiNum%:
		GuiControlGet, %pList% ,%GuiNum%:
		if(%pList% == ""){					; 何も選択してない場合１番目を選択させる
			GuiControl, %GuiNum%:Choose, %pList%, 1
			GuiControlGet, %pList% ,%GuiNum%:
		}


		; 最後の文字の部分のみ変更するようにする( 空白の前の部分を残す)
		StringGetPos, spaceIndex, %pEdit%, %A_Space%, R1
		beforeStr =
		if(spaceIndex <= -1 ) {		; Spaceがない場合
			; フォルダ名の次に文字を継ぎ足すようにする
			StringGetPos, enIndex , %pEdit%, \ , R1
			if(enIndex > -1) {
				enIndex++
				StringLeft, beforeStr, %pEdit%, enIndex
			}
		} else {		; Spaceがある場合
			StringGetPos, enIndex , %pEdit%, \ , R1
			if(enIndex > -1) {				;スペースも\ もある場合
				if(spaceIndex > enIndex) {		; どちらが後にあるかで判定
					spaceIndex++
					StringLeft, beforeStr, %pEdit%, spaceIndex
				} else {						; \ が後にある場合
					enIndex++
					StringLeft, beforeStr, %pEdit%, enIndex
				}
			} else {		; Spaceはあるが、\はない場合
				spaceIndex++
				StringLeft, beforeStr, %pEdit%, spaceIndex
			}
		}
		listStr := %pList%
		; 入力補完のほうがカラだったら、文字を変えない
		if(listStr != ""){
			str := beforeStr . listStr
			guf_setControl( str, pEdit, GuiNum )
		}
		GuiControl, %GuiNum%:Focus, %pEdit%
		Send, {End}

		StringRight, OutputVar, listStr, 1
		if(OutputVar == "\") {
			; 入力補完を続けて表示。（Gui のサイズの変更は SubEdit のやつにまかせる）
			aut_visiblePopUpListEnyType(pList, pEdit, GuiNum, 1, 0)
		} else {
			; 「自動で入力補完を表示する」場合、再表示されてしまうため遅らせる
			;if( glob_iniAutoPopupNotViewFlag == False ){
			if( O_inputListAutoNotFlag == False ){
				Sleep, 200
			}

			editType := guit_editTypeNumGet(GuiNum)
			if(editType == 1) {
				GuiControl, %GuiNum%:Disable, %pList%
				GuiControl, %GuiNum%:Hide, %pList%
			} else if( editType == 2) {
				edi_commListHide(pList, pEdit, GuiNum)
			}
		}
		return True
	}
	return False
}
*/

aut_pictuerSetByFileName( str, defaultImg, pControl, GuiNum, iconSizeStr ) {

	;iconSizeStr := "*w32 *h32 "
	type := FileExist(str)
	if(type == "") {
		guf_setControl( iconSizeStr . defaultImg, pControl, GuiNum )
		return
	}


	IfInString, type, D
	{
		guf_setControl( "*icon4 " . iconSizeStr . glob_SHELL32DLL , pControl, GuiNum )
	} else {
		StringRight, suffix, str, 4
		StringLower, suffix, suffix
		if(suffix == ".exe") {
			str2 := iconSizeStr . str
			guf_setControl( str2, pControl, GuiNum )
		} else if(suffix == ".txt") {
			guf_setControl( "*icon71 " . iconSizeStr . glob_SHELL32DLL , pControl, GuiNum )
		} else if(suffix == ".jpg" || suffix == ".gif" || suffix == ".png") {
			guf_setControl( "*icon303 " . iconSizeStr . glob_SHELL32DLL , pControl, GuiNum )
		} else if(suffix == ".lnk") {
			FileGetShortcut, %str% , OutTarget, OutDir, OutArgs, OutDescription, OutIcon, OutIconNum, OutRunState
			if(OutIcon == ""){
				; 再帰的処理
				aut_pictuerSetByFileName( OutTarget, defaultImg, pControl, GuiNum, iconSizeStr )
			} else {
				OutIcon := outs_textOutTrimssParsent(OutIcon)
				if( func_myFileExist(OutIcon) ){
					str2 := "*icon" . OutIconNum . " " . iconSizeStr . OutIcon
					guf_setControl( str2 , pControl, GuiNum )
				} else {
					guf_setControl( iconSizeStr . defaultImg, pControl, GuiNum )
				}
			}
		} else {
			guf_setControl( "*icon44 " . iconSizeStr . glob_SHELL32DLL , pControl, GuiNum )
		}
	}
}

aut_pictuerSetByFileOrObj( str, noneImg, anyHaveImg, pOut, outGuiNum, pPicture, picGuiNum, explainFlag, iconSizeStr ){
	;iconSizeStr := "*w32 *h32 "

	if(str == ""){
		if(noneImg == ""){
			; アイコンのサイズは、次利用するアイコンに依存する
			guf_setControl( "", pPicture, picGuiNum )
		} else {
			guf_setControl( iconSizeStr . noneImg, pPicture, picGuiNum )
		}
		return
	}

	optionObj := cen_getFromEnyObject(str)
	if(IsObject(optionObj)){
		if(explainFlag){
			guf_setControl( optionObj[4], pOut, outGuiNum )
		}
		if(optionObj[6] == "") {
			if(optionObj[5] == 2) {
				;str2 := "*icon4 " . iconSizeStr . glob_SHELL32DLL
				;guf_setControl( str2, pPicture, picGuiNum )
				filePath := outs_textOutTrimss(optionObj[1])
				aut_pictuerSetByFileName( filePath, anyHaveImg, pPicture, picGuiNum, iconSizeStr )
			} else if(optionObj[5] == 1) {
				filePath := outs_textOutTrimss(optionObj[1])
				aut_pictuerSetByFileName( filePath, anyHaveImg, pPicture, picGuiNum, iconSizeStr )
			} else if(optionObj[5] == 3) {
				str2 := "*icon25 " . iconSizeStr . glob_SHELL32DLL
				guf_setControl( str2, pPicture, picGuiNum )
			} else if(optionObj[5] == 4) {
				str2 := "*icon71 " . iconSizeStr . glob_SHELL32DLL
				guf_setControl( str2, pPicture, picGuiNum )
			}
		} else {
			; アイコンを指定していても、ファイルや、フォルダのアイテムなら、ファイルが存在するか、確認する
			if(optionObj[5] == 1 || optionObj[5] == 2) {
				filePath := outs_textOutTrimss(optionObj[1])
				type := FileExist(filePath)
				if(type == "") {
					guf_setControl( iconSizeStr . anyHaveImg, pPicture, picGuiNum )
					return
				}
			}


			imgPath := outs_textOutTrimss(optionObj[6])
			if( func_myFileExist(imgPath) ){
				StringLower, tmpStr, imgPath
				StringRight, suffix, tmpStr, 4
				if(suffix == ".exe" || suffix == ".dll" || suffix == ".ico" || suffix == ".cpl") {
					str2 := "*icon" . optionObj[7] . " " . iconSizeStr . imgPath
					guf_setControl( str2, pPicture, picGuiNum )
					return
				}
			}
			; アイコンが不明なら、何らかのファイルとして表示
			guf_setControl( "*icon44 " . iconSizeStr . glob_SHELL32DLL, pPicture, picGuiNum )
			;guf_setControl( iconSizeStr . anyHaveImg, pPicture, picGuiNum )
		}
	} else {
		aut_pictuerSetByFileName( str, anyHaveImg, pPicture, picGuiNum, iconSizeStr )
	}
}

aut_autoSysCommExplanation( str, pControl, GuiNum ) {
	explanation := glob_sysCommObj[str]
	if(explanation != "") {
		guf_setControl( explanation, pControl, GuiNum )
		return
	}
	explanation := glob_specialWordObj[str]
	if(explanation != "") {
		guf_setControl( explanation, pControl, GuiNum )
		return
	}
	explanation := glob_userMakeWordObj[str]
	if(explanation != "") {
		guf_setControl( explanation, pControl, GuiNum )
	}
}

; テスト版
aut_controlKeyUpDownTestList1(iniFlag, key=1, pList="", GuiNum=1) {
	static  sta_num := 0
	if(iniFlag) {
		sta_num = 0
	} else {
		;str := "ahk_id " . hwnd
		GuiControlGet, OutputVar, %GuiNum%:Visible, %pList%		;リストが表示してるなら
		if(OutputVar == 1) {
			tmpSta_num = %sta_num%
			if(key == 1) {				; Up
				if(sta_num <= 1){
					sta_num = 1
				} else {
					sta_num--
				}
			} else if(key == 2) {		;Down
				if(sta_num > 60) {
					sta_num = 61
				} else {
					sta_num++
				}
			} else if(key == 3) {		;PgUp
				if(sta_num <= 7) {
					sta_num = 1
				} else {
					sta_num -= 7
				}
			} else if(key == 4) {		;PgDown
				if(sta_num > 60) {
					sta_num = 61
				} else {
					sta_num += 7
				}
			} else if(key == 5) {		; Home
				sta_num = 1
			}
			;Control, Choose , %sta_num%, , %str%
			GuiControl, %GuiNum%:Choose ,%pList%, %sta_num%
			; リストにない番号を選んだ場合の対処
			if(ErrorLevel == 1){
				sta_num = %tmpSta_num%
				GuiControl, %GuiNum%:Choose ,%pList%, %sta_num%
				ErrorLevel = 0
			}
		}
	}
}

; テスト版
aut_controlKeyUpDownTestList2(iniFlag, key=1, pList="", GuiNum=1) {
	static  sta_num := 0
	if(iniFlag) {
		sta_num = 0
	} else {
		;str := "ahk_id " . hwnd
		GuiControlGet, OutputVar, %GuiNum%:Visible, %pList%		;リストが表示してるなら
		if(OutputVar == 1) {
			tmpSta_num = %sta_num%
			if(key == 1) {				; Up
				if(sta_num <= 1){
					sta_num = 1
				} else {
					sta_num--
				}
			} else if(key == 2) {		;Down
				if(sta_num > 60) {
					sta_num = 61
				} else {
					sta_num++
				}
			} else if(key == 3) {		;PgUp
				if(sta_num <= 7) {
					sta_num = 1
				} else {
					sta_num -= 7
				}
			} else if(key == 4) {		;PgDown
				if(sta_num > 60) {
					sta_num = 61
				} else {
					sta_num += 7
				}
			} else if(key == 5) {		; Home
				sta_num = 1
			}
			;Control, Choose , %sta_num%, , %str%
			GuiControl, %GuiNum%:Choose ,%pList%, %sta_num%
			; リストにない番号を選んだ場合の対処
			if(ErrorLevel == 1){
				sta_num = %tmpSta_num%
				GuiControl, %GuiNum%:Choose ,%pList%, %sta_num%
				ErrorLevel = 0
			}
		}
	}
}


; テスト版
aut_controlKeyUpDownTestList3(iniFlag, key=1, pList="", GuiNum=1) {
	static  sta_num := 0
	if(iniFlag) {
		sta_num = 0
	} else {
		;str := "ahk_id " . hwnd
		GuiControlGet, OutputVar, %GuiNum%:Visible, %pList%		;リストが表示してるなら
		if(OutputVar == 1) {
			tmpSta_num = %sta_num%
			if(key == 1) {				; Up
				if(sta_num <= 1){
					sta_num = 1
				} else {
					sta_num--
				}
			} else if(key == 2) {		;Down
				if(sta_num > 60) {
					sta_num = 61
				} else {
					sta_num++
				}
			} else if(key == 3) {		;PgUp
				if(sta_num <= 7) {
					sta_num = 1
				} else {
					sta_num -= 7
				}
			} else if(key == 4) {		;PgDown
				if(sta_num > 60) {
					sta_num = 61
				} else {
					sta_num += 7
				}
			} else if(key == 5) {		; Home
				sta_num = 1
			}
			;Control, Choose , %sta_num%, , %str%
			GuiControl, %GuiNum%:Choose ,%pList%, %sta_num%
			; リストにない番号を選んだ場合の対処
			if(ErrorLevel == 1){
				sta_num = %tmpSta_num%
				GuiControl, %GuiNum%:Choose ,%pList%, %sta_num%
				ErrorLevel = 0
			}
		}
	}
}

; テスト版
aut_controlKeyUpDownTestList4(iniFlag, key=1, pList="", GuiNum=1) {
	static  sta_num := 0
	if(iniFlag) {
		sta_num = 0
	} else {
		;str := "ahk_id " . hwnd
		GuiControlGet, OutputVar, %GuiNum%:Visible, %pList%		;リストが表示してるなら
		if(OutputVar == 1) {
			tmpSta_num = %sta_num%
			if(key == 1) {				; Up
				if(sta_num <= 1){
					sta_num = 1
				} else {
					sta_num--
				}
			} else if(key == 2) {		;Down
				if(sta_num > 60) {
					sta_num = 61
				} else {
					sta_num++
				}
			} else if(key == 3) {		;PgUp
				if(sta_num <= 7) {
					sta_num = 1
				} else {
					sta_num -= 7
				}
			} else if(key == 4) {		;PgDown
				if(sta_num > 60) {
					sta_num = 61
				} else {
					sta_num += 7
				}
			} else if(key == 5) {		; Home
				sta_num = 1
			}
			;Control, Choose , %sta_num%, , %str%
			GuiControl, %GuiNum%:Choose ,%pList%, %sta_num%
			; リストにない番号を選んだ場合の対処
			if(ErrorLevel == 1){
				sta_num = %tmpSta_num%
				GuiControl, %GuiNum%:Choose ,%pList%, %sta_num%
				ErrorLevel = 0
			}
		}
	}
}

; テスト版
aut_controlKeyUpDownTestList5(iniFlag, key=1, pList="", GuiNum=1) {
	static  sta_num := 0
	if(iniFlag) {
		sta_num = 0
	} else {
		;str := "ahk_id " . hwnd
		GuiControlGet, OutputVar, %GuiNum%:Visible, %pList%		;リストが表示してるなら
		if(OutputVar == 1) {
			tmpSta_num = %sta_num%
			if(key == 1) {				; Up
				if(sta_num <= 1){
					sta_num = 1
				} else {
					sta_num--
				}
			} else if(key == 2) {		;Down
				if(sta_num > 60) {
					sta_num = 61
				} else {
					sta_num++
				}
			} else if(key == 3) {		;PgUp
				if(sta_num <= 7) {
					sta_num = 1
				} else {
					sta_num -= 7
				}
			} else if(key == 4) {		;PgDown
				if(sta_num > 60) {
					sta_num = 61
				} else {
					sta_num += 7
				}
			} else if(key == 5) {		; Home
				sta_num = 1
			}
			;Control, Choose , %sta_num%, , %str%
			GuiControl, %GuiNum%:Choose ,%pList%, %sta_num%
			; リストにない番号を選んだ場合の対処
			if(ErrorLevel == 1){
				sta_num = %tmpSta_num%
				GuiControl, %GuiNum%:Choose ,%pList%, %sta_num%
				ErrorLevel = 0
			}
		}
	}
}

; AnotherGui版
aut_controlKeyUpDownTestAnotherGui(iniFlag, key) {
	static  sta_num := 0
	if(iniFlag) {
		sta_num = 0
	} else {
		;リストが表示してるなら
		IfWinExist, %gGlob_Gui70Title%
		{
			;str := "ahk_id " . gGlob_hwndList70_1
			tmpSta_num = %sta_num%
			if(key == 1) {				; Up
				if(sta_num <= 1){
					sta_num = 1
				} else {
					sta_num--
				}
			} else if(key == 2) {		;Down
				if(sta_num > 60) {
					sta_num = 61
				} else {
					sta_num++
				}
			} else if(key == 3) {		;PgUp
				if(sta_num <= 7) {
					sta_num = 1
				} else {
					sta_num -= 7
				}
			} else if(key == 4) {		;PgDown
				if(sta_num > 60) {
					sta_num = 61
				} else {
					sta_num += 7
				}
			} else if(key == 5) {		; Home
				sta_num = 1
			}
			;Control, Choose , %sta_num%, , %str%
			GuiControl, 70:Choose ,List70_1, %sta_num%
			; リストにない番号を選んだ場合の対処
			if(ErrorLevel == 1){
				sta_num = %tmpSta_num%
				GuiControl, 70:Choose ,List70_1, %sta_num%
				ErrorLevel = 0
			}
		}
	}
}

; テスト版ではない方  しかしうまくいかないので使えない
aut_controlKeyUpDown(hwnd, key, pList, GuiNum=1) {
	GuiControlGet, OutputVar, %GuiNum%:Visible, %pList%		;リストが表示してるなら
	if(OutputVar == 1) {
		str := "ahk_id " . hwnd
		if(key) {						; 上か下か
			ControlSend , , Send{Blind}{Up}, %str%
		} else {
			ControlSend , , Send{Blind}{Down}, %str%
		}
	}
}

; viewTypeは 0 なら表示  1 なら閉じる  2 ならトグル
/*
aut_visiblePopUpListMini(pList, pEdit, GuiNum, x, y, viewType) {
	if(viewType == 2){
		GuiControlGet, viewType, %GuiNum%:Visible, %pList%
	}
	if(viewType == 1) {
		;GuiControl, %GuiNum%:Focus, %pList%		;リストにフォーカスを移す

		; Edit　に　フォーカスがあるとき、入力補完のキーをもう１度押すと、入力補完を閉じる
		edi_commListHide(pList, pEdit, GuiNum)
	} else {
		listX := A_CaretX + x
		listY := A_CaretY + y

		; スクリーンの右端にあるなら、表示位置が画面からはみ出さないようにする
		WinGetPos , winX, winY, , , A
		warningLineX := gloco_maxWinWidth - 146
		absoleX := listX + winX
		if(absoleX > warningLineX){
			listX := gloco_maxWinWidth - winX - 266
		}
		warningLineY := gloco_maxWinHeight - 200
		GuiControlGet, value, %GuiNum%:Pos, %pEdit%
		if(winY > warningLineY){
			newY := winY - 300
			WinMove, A, , %winX%, %newY%
			editY := valueY + 295
			editYStr := "Y" . editY
			pictureY := editY - 5
			pictureYStr := "Y" . pictureY
			pPicture := "Picture" . GuiNum  . "_1"
			guf_GuiControl(pEdit, GuiNum, "Move", editYStr)
			guf_GuiControl(pPicture, GuiNum, "Move", pictureYStr)
			listY := 5
		}
		; ファイル名の入力補完の自動表示のさい必要
		if(valueY >= 280){
			listY := 5
		}
		GuiControl, %GuiNum%:Move, %pList%, X%listX%  Y%listY%
		GuiControl, %GuiNum%:Enable, %pList%
		GuiControl, %GuiNum%:Show, %pList%
		guf_showGuiParams(GuiNum, "AutoSize")
	}
}
*/

; viewTypeは 0 なら表示  1 なら閉じる  2 ならトグル
aut_visiblePopUpListAnotherGui(x, y, viewType, commWinTitle) {
	if(viewType == 2){
		IfWinExist, %gGlob_Gui70Title%
		{
			viewType = 1
		} else {
			viewType = 0
		}
	}
	if(viewType == 1) {
		; 入力補完のキーをもう１度押すと、入力補完を閉じる
		edi_commListHideAnotherGui()
	} else {
		WinGetPos, winX, winY, Width, Height, %commWinTitle%
		listX := winX + A_CaretX + x
		listY := winY + A_CaretY + y

		; スクリーンの右端にあるなら、表示位置が画面からはみ出さないようにする
		warningLineX := gloco_maxWinWidth - 200
		absoleX := listX
		if(absoleX > warningLineX){
			listX := gloco_maxWinWidth - O_inputListReverseX
		}

		warningLineY := gloco_maxWinHeight - 250
		if(winY > warningLineY){
			;subY := guaf_anyOfNumFromDpi(340, 395, 450)
			listY := listY - O_inputListReverseY
		}

		; ファイル名の入力補完の自動表示のさい必要
		;if(valueY >= 280){
		;	listY := 5
		;}

		Gui, 70:Show, x%listX% y%listY% NA
	}
}

; 入力補完を表示させる  x y は位置の微調整よう
; viewTypeは 0 なら表示  1 なら閉じる  2 ならトグル
aut_visiblePopUpList(pList, GuiNum, x, y, viewType) {
	if(viewType == 2){
		GuiControlGet, viewType, %GuiNum%:Visible, %pList%
	}
	if(viewType == 1) {
		;GuiControl, %GuiNum%:Focus, %pList%		;リストにフォーカスを移す

		; Edit　に　フォーカスがあるとき、入力補完のキーをもう１度押すと、入力補完を閉じる
		guf_controlHideDisable(pList, GuiNum)
	} else {
		listX := A_CaretX + x
		listY := A_CaretY + y

		; スクリーンの右端にあるなら、表示位置が画面からはみ出さないようにする
		WinGetPos , winX, winY, , , A
		warningLineX := gloco_maxWinWidth - 146
		absoleX := listX + winX
		if(absoleX > warningLineX){
			listX := gloco_maxWinWidth - winX - 266
		}

		GuiControl, %GuiNum%:Move, %pList%, X%listX%  Y%listY%
		GuiControl, %GuiNum%:Enable, %pList%
		GuiControl, %GuiNum%:Show, %pList%
	}
}

aut_visiblePopUpListEnyType(pList, pEdit, GuiNum, pupNum, viewType){
	glob_pupupNum = %pupNum%
	editType := guit_editTypeNumGet(GuiNum)
	if(editType == 1) {
		popY := guaf_anyOfNumFromDpi(12, 17, 22)
		if(glob_needReloadIniCommTitleNotFlag == False){
			subY := guaf_anyOfNumFromDpi(22, 28, 34)
			popY -= subY
		}
		if(glob_needReloadIniCommMenuNotFlag == False){
			subY := guaf_anyOfNumFromDpi(20, 26, 32)
			popY -= subY
		}
		aut_visiblePopUpList(pList, GuiNum, -5, popY, viewType)
	} else if( editType == 2) {
		; 今動作中のコマンドのＧｕｉを設定
		glob_nowAutoPopGui = %GuiNum%
		commWinTitle := gGlob_Gui%GuiNum%Title
		;popY := guaf_anyOfNumFromDpi(27, 30, 33)
		;aut_visiblePopUpListAnotherGui(0, popY, viewType, commWinTitle)
		aut_visiblePopUpListAnotherGui(O_inputListX, O_inputListY, viewType, commWinTitle)
/*
		popY = 16
		if(glob_needReloadIniCommTitleNotFlag == False){
			popY -= 22
		}
		if(glob_needReloadIniCommMenuNotFlag == False){
			popY -= 20
		}
		aut_visiblePopUpListMini(pList, pEdit, GuiNum, -5, popY, viewType)
*/
	} else if( editType == 0){
		glob_nowAutoPopGui = %GuiNum%
		commWinTitle := gGlob_Gui%GuiNum%Title
		aut_visiblePopUpListAnotherGui(O_inputListX, O_inputListY, viewType, commWinTitle)
	}
}
