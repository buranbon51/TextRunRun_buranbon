; 必須  glob  guf  

;ウインドウキャプチャでソフトを登録
;MouseGestureL で取ってきた関数を利用している
excof_windowCaptureItem(winTitle=""){
	if(winTitle == ""){
		winTitle := "A"
	}
	WinActivate , %winTitle%
	windc_titleIfA(winTitle)
	WinGet,pid,PID,%winTitle%
	softPath := othli_MG_ExePath(pid)
	if(softPath == ""){
		guit_errorAppend("ウインドウからパスを取得できない")
		return
	}
	excof_sysCommandnew(softPath, "", 71)
}

excof_windowCaptureItemFromComm(com2, pOut, GuiNum){
	guf_hideGuiAssign(GuiNum)
	com2 := Trim(com2)
	excof_windowCaptureItem(com2)
}

excof_sysCommandnew(com2, pControl, GuiNum) {
	str := "アイテムを登録するGuiの表示。`n引数1`n-2gyo または 4   二行以上のアイテムを登録するGuiの表示。`n1 から 3  の数字なら、アイテムの種類を指定。"
	if( edc_helpViewIfHyphenH(str, com2, GuiNum) ){
		return
	}
	radioNum = 1
	com2 := Trim(com2)
	leftStr := func_separationSpaceLeftOrAll(com2)
	if( leftStr == "-2gyo" ){
		com2 := func_separationSpaceRightOrNull(com2)
		musc_showMultipleScriptsGui(com2)
		return
	} else if( leftStr == "1" ){
		com2 := func_separationSpaceRightOrNull(com2)
		;radioNum = 1
	} else if( leftStr == "2" ){
		com2 := func_separationSpaceRightOrNull(com2)
		radioNum = 2
	} else if( leftStr == "3" ){
		com2 := func_separationSpaceRightOrNull(com2)
		radioNum = 3
	} else if( leftStr == "4" ){
		com2 := func_separationSpaceRightOrNull(com2)
		musc_showMultipleScriptsGui(com2)
		return
	}

	com2Tmp := com2
	textOutCom2 := outs_textOutToAbsolePath(com2Tmp, glob_iniAbsolePathNotFlag, False, A_LineFile, A_LineNumber)
	if( func_myFileExist(textOutCom2) ){
		SplitPath, textOutCom2, , , , OutNameNoExt
		com2Tmp := Trim( com2Tmp, """" )
		;guf_setControl( com2Tmp, "Edit72_3", 72 )
		;guf_setControl( OutNameNoExt, "Edit72_1", 72 )
		ite_showGui72(OutNameNoExt, com2Tmp, radioNum)
	} else {
		;guf_setControl( com2, "Edit72_3", 72 )
		ite_showGui72("", com2, radioNum)
	}
	;edc_hideCommGuiwithoutChangeIfCommOnly(GuiNum)
}

excof_itemExecute(key, rightStr, otherArgss, pOut, GuiNum, hwnd, historyStr, andFlag, rightStrAll, useAndStr, outPutSucceedFlag, openNum=1) {
	key := Trim( key, """" )
	key := Trim( key )
	res := cen_keyWordIsObjectNumber(key)
	if(res == 1) {							;ソフト

		; 文字を消す。閉じる。 edc_hideAfterCommExe() と hideFlag の効果が逆になっている
		edc_cleanHideAfterCommExeFileType(glob_iniFileCleanTextFlag, glob_iniFileGuiNotHide, pOut, GuiNum, andFlag)

		optionObj := glob_softObj[key]
		pathStr := outs_textOutDqAllTrim(optionObj[1])
		pathStr := outs_relativeToAbsoluteFromWorkDir(pathStr,  A_LineFile, A_LineNumber, False)
		; 引数の処理工夫
		argss := heard_itemArgssUse_Cust(optionObj[2], rightStr, otherArgss)
		if(optionObj[8] == 1){
			; ""で囲む設定のアイテムなら O_spaceFileNotFlag の設定がどうであれ、空白のあるファイルを自動で判別させる
			argss := heard_fileAllAbsoluteOrDbQuoute(argss, A_LineFile, A_LineNumber, True, glob_iniAbsolePathNotFlag)
		} else if(glob_iniAbsolePathNotFlag == False){
			;if(glob_iniSpaceFileNotFlag == False){
			if(O_spaceFileNotFlag == False){
				; ""で囲む設定ではないが、空白のファイルを自動判別
				argss := heard_fileAllAbsoluteOrDbQuoute(argss, A_LineFile, A_LineNumber, False, glob_iniAbsolePathNotFlag)
			} else {
				; ""で囲む設定でなく、空白のファイルを自動判別もしないが、絶対パスにはする
				argss := heard_absoluteAllEasy(argss, A_LineFile, A_LineNumber)
			}
		}
		workDir := outs_textOutDqAllTrim(optionObj[3])
		workDir := outs_relativeToAbsoluteFromWorkDir(workDir,  A_LineFile, A_LineNumber, False)
		if(workDir == ""){
			workDir = %A_WorkingDir%
		}

		dbQuouteChar := """"

		runPath := dbQuouteChar . pathStr . dbQuouteChar . " " . argss
		runPath := Trim(runPath)
		tmpRunPath := pathStr  . " " . argss
		tmpRunPath := Trim(tmpRunPath)

		cen_easyCheckAppendNotShow("ErrorLevel  "  . ErrorLevel, "path  " . runPath, "work  " . workDir . "`n" . A_ThisFunc . "`nA_LineNumber  " . A_LineNumber)


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

		if(openNum == 1){
			if( outs_isNotFile(pathStr, "ソフト・ファイルのアイテムの実行時のエラー`nファイル名ではないので実行できない`n" . pathStr) ) {
				return True
			}
			outs_workDirCheck(workDir, "作業フォルダが不明`n" . workDir)
			Run, %runPath% , %workDir%, UseErrorLevel, OutputVarPID
			cen_checkCommSuccess()
			guit_checkErrorLevelOutput("アイテムの実行に失敗。", "名`t" . key, "パス`t" . runPath)
		} else if(openNum == 2){
			edi_openSetEditBoxss(pathStr, argss, workDir, GuiNum)
		} else if(openNum == 3){
			guaf_openSetMiniEdit(pathStr, argss, workDir, GuiNum)
		}
		; コマンドの終わりの処理をここで実行させる
		edi_commEndMiniEdit(historyStr, hwnd, andFlag, useAndStr, pOut, GuiNum, outPutSucceedFlag)
		return True
	} else if (res == 2) {					;フォルダ
		; 文字を消す。閉じる。 edc_hideAfterCommExe() と hideFlag の効果が逆になっている
		edc_cleanHideAfterCommExeFileType(glob_iniFileCleanTextFlag, glob_iniFileGuiNotHide, pOut, GuiNum, andFlag)

		optionObj := glob_folderObj[key]
		pathStr := outs_textOutDqAllTrim(optionObj[1])
		pathStr := outs_relativeToAbsoluteFromWorkDir(pathStr,  A_LineFile, A_LineNumber, False)

		; 設定で、拡張子によって開くソフトを変える場合
		if( cen_openFolderMethodChangeFromFolderVar(pathStr) ){
			runPath = %pathStr%
			pathStr := cen_getScriptBeforeExeSoftItem(O_folderOpenSoftItem, "O_folderOpenSoftItem", runPath)
			argss := cen_getArgssBeforeExeSoftItem(O_folderOpenSoftItem, runPath)
			workDir := cen_getWorkDirBeforeExeSoftItem(O_folderOpenSoftItem)

			; ソフトのパスの返り値(pathStr)が、元のファイル名(runPath)だった場合、引数は無しにする
			if(runPath == pathStr){
				argss =
			}
			dbQuouteChar := """"
			runPath := dbQuouteChar . pathStr . dbQuouteChar . " " . argss
			runPath := Trim(runPath)

			if(openNum == 1){
				Run, %runPath%, workDir, UseErrorLevel, OutputVarPID
				cen_checkCommSuccess()
				guit_checkErrorLevelOutput("アイテムの実行に失敗。", "名`t" . key, "パス`t" . runPath)
			} else if(openNum == 2){
				edi_openSetEditBoxss(pathStr, argss, workDir, GuiNum)
			} else if(openNum == 3){
				guaf_openSetMiniEdit(pathStr, argss, workDir, GuiNum)
			}
			; コマンドの終わりの処理をここで実行させる
			edi_commEndMiniEdit(historyStr, hwnd, andFlag, useAndStr, pOut, GuiNum, outPutSucceedFlag)
			return True
		}

		if(openNum == 1){
			if( outs_isNotFolder(pathStr, "フォルダのアイテムの実行時のエラー`nフォルダ名が不明なので実行できない`n" . pathStr) ) {
				return True
			}
			Run, %pathStr%, , UseErrorLevel, OutputVarPID
			cen_checkCommSuccess()
			guit_checkErrorLevelOutput("アイテムの実行に失敗。", "名`t" . key, "パス`t" . pathStr)
		} else if(openNum == 2){
			edi_openSetEditBoxss(pathStr, "", "", GuiNum)
		} else if(openNum == 3){
			guaf_openSetMiniEdit(pathStr, "", "", GuiNum)
		}
		; コマンドの終わりの処理をここで実行させる
		edi_commEndMiniEdit(historyStr, hwnd, andFlag, useAndStr, pOut, GuiNum, outPutSucceedFlag)
		return True
	} else if (res == 3) {					; スクリプト
		edc_cleanHideAfterCommExe(glob_iniScriptCleanTextFlag, glob_iniScriptGuiHide, pOut, GuiNum, andFlag)
		optionObj := glob_itemCommandObj[key]
		useEdit := optionObj[1]
		;argStr := rightStr  . " " . otherArgss
		argStr := rightStrAll
		argStr := Trim(argStr)
		argStrAll =

		; 利用するEdit に %1 などが入ってるなら特殊な処理をする
		argStrAll := heard_itemArgssLogic_Cust(useEdit, argStr, "")

		if(openNum == 1){
			;アイテムから実行した場合、outputの設定を引き継ぐ
			; outputの設定が変えられていたら、引き継がせるため、Trueを返す
			;outPutSucceedFlag := cen_outPutSucceedFlagTrueIfNotBasic()
			;edi_outPutSucceedFlagInCaseTrueCommandExeLogic(argStrAll, pOut, GuiNum, hwnd, True, outPutSucceedFlag)

			; 出力先の変更を引き継がないように使用変更したので、こちらを使う
			edi_outPutSucceedFlagStopCommandExe(argStrAll, historyStr, pOut, GuiNum, hwnd, andFlag)
		} else if(openNum == 2){
			edi_openSetEditBoxss(argStrAll, "", "", GuiNum)
		} else if(openNum == 3){
			guaf_openSetMiniEdit(argStrAll, "", "", GuiNum)
		}
		; なお、スクリプトなら &&& の処理はしない。
		; この時点では履歴の保存と、テキスト右端に移動もしない
		;edi_historyInsert(historyStr, hwnd, andFlag)
		return True
	} else if (res == 4) {					; コマンド(ソフトの)
		edc_cleanHideAfterCommExe(glob_iniMultipleCleanTextFlag, glob_iniMultipleGuiHide, pOut, GuiNum, andFlag)
		optionObj := glob_multipleObj[key]
		scripts := optionObj[1]
		rightStrAll := Trim(rightStrAll)

		; B_itemNameOwn にアイテム名を
		; B_itemArg1 などの変数に、テキストの引数を代入する（二行以上のアイテムのみ）
		delimiter := ","
		delimiterSpace := ", "
		; 後で戻すため、バックアップ
		tmpItemName = %B_itemNameOwn%
		tmpArgAll = %B_itemArgAll%
		tmpArg0 = %B_itemArg0%
		tmpArg1 = %B_itemArg1%
		tmpArg2 = %B_itemArg2%
		tmpArg3 = %B_itemArg3%
		tmpArg4 = %B_itemArg4%
		tmpArg5 = %B_itemArg5%
		tmpArg6 = %B_itemArg6%
		tmpArg7 = %B_itemArg7%
		tmpArg8 = %B_itemArg8%
		tmpArg9 = %B_itemArg9%

		B_itemNameOwn = %key%
		;B_itemArgAll = %rightStrAll%
		; アイテムの引数に %B_itemArgAll% を指定する場合に備えて、一時的な変数に退避して、最後に代入する
		argAll = %rightStrAll%
		if( rightStrAll == "" ){
			B_itemArg0 = 0
			; 全て初期化
			B_itemArgAll =
			B_itemArg1 =
			B_itemArg2 =
			B_itemArg3 =
			B_itemArg4 =
			B_itemArg5 =
			B_itemArg6 =
			B_itemArg7 =
			B_itemArg8 =
			B_itemArg9 =

		} else {
			arg_0 =
			arg_1 =
			arg_2 =
			arg_3 =
			arg_4 =
			arg_5 =
			arg_6 =
			arg_7 =
			arg_8 =
			arg_9 =

			; 引数１が , であれば、 , を区切り文字として使用する（%1 などが無くてもそうする）
			StringLeft, lChr, rightStrAll, 2
			if( lChr == delimiterSpace ){
				; 左端の , を取り除く。これをすることで
				; B_itemArg1 にカラの文字が入り、B_itemArg2 以降に１つずつずれるのを解消する
				StringTrimLeft, tmpRightStr, rightStrAll, 2
				IfInString, tmpRightStr, %delimiter%
				{
					StringSplit, arg_ , tmpRightStr, %delimiter%, %A_Space%
					B_itemArg0 = %arg_0%
				} else {
					; 左端の , を取り除いた場合、, が他にない場合
					B_itemArg0 = 1
					arg_1 = %tmpRightStr%
				}
			} else {
				IfInString, rightStrAll, %A_Space%
				{
					tmpRightStr := func_spaceChangeOnlyOne(rightStrAll)
					StringSplit, arg_, tmpRightStr, %A_Space%
					B_itemArg0 = %arg_0%
				} else {
					B_itemArg0 = 1
					arg_1 = %rightStrAll%
				}
			}
			B_itemArgAll := outs_textOutTrimss(argAll)
			B_itemArg1 := outs_textOutTrimss(arg_1)
			B_itemArg2 := outs_textOutTrimss(arg_2)
			B_itemArg3 := outs_textOutTrimss(arg_3)
			B_itemArg4 := outs_textOutTrimss(arg_4)
			B_itemArg5 := outs_textOutTrimss(arg_5)
			B_itemArg6 := outs_textOutTrimss(arg_6)
			B_itemArg7 := outs_textOutTrimss(arg_7)
			B_itemArg8 := outs_textOutTrimss(arg_8)
			B_itemArg9 := outs_textOutTrimss(arg_9)
		}


		; 履歴に保存して、右端に移動するかどうか
		if( andFlag == False ){
			smicron := "`;"		; コメントの文字
			historyFlag := True
			oneLineTmp := func_leftStrOrAllFromSearchStr(scripts, "`n")
			oneLineTmp := LTrim( oneLineTmp )
			StringLeft, lChar, oneLineTmp, 1
			if(lChar == smicron){
				StringTrimLeft, oneLineTmp, oneLineTmp, 1
				oneLineTmp := LTrim( oneLineTmp )
				StringLeft, lChar, oneLineTmp, 1
				if(lChar == "-"){
					StringLen, oneLineTmpLen, oneLineTmp
					if( oneLineTmpLen >= 2 ){
						StringLeft, l2Char, oneLineTmp, 2
						if(l2Char == "-n"){
							historyFlag := False
						}
					}
					if( oneLineTmpLen >= 10 ){
						StringLeft, l10Char, oneLineTmp, 10
						StringLower, l10Char, l10Char
						if(l10Char == "--norecord"){
							historyFlag := False
						}
					}
				}
			}
			if(historyFlag){
				; 二行以上アイテムなら &&& の処理はしない。
				; 履歴に保存。右端に移動する
				edi_historyInsert(historyStr, hwnd, andFlag)
			}
		}


		; 利用するEdit に %1 などが入ってるなら特殊な処理をする
		argStrAll := heard_itemArgssLogic_Cust(scripts, rightStrAll, "")
		if(openNum == 1){
			; outputの設定が変えられていたら、引き継がせるため、Trueを返す
			outPutSucceedFlag := cen_outPutSucceedFlagTrueIfNotBasic()
			;アイテムから実行した場合、outputの設定を引き継ぐ

			musc_multipleScriptsExe(argStrAll, pOut, GuiNum, hwnd, outPutSucceedFlag, 1)
		} else if(openNum == 2){
			guf_setControl( argStrAll, "BoxEdit82_1", 82 )
			Gui, 82:Show
		} else if(openNum == 3){
			guf_setControl( argStrAll, "BoxEdit82_1", 82 )
			Gui, 82:Show
		}

		B_itemNameOwn = %tmpItemName%
		B_itemArgAll = %tmpArgAll%
		B_itemArg0 = %tmpArg0%
		B_itemArg1 = %tmpArg1%
		B_itemArg2 = %tmpArg2%
		B_itemArg3 = %tmpArg3%
		B_itemArg4 = %tmpArg4%
		B_itemArg5 = %tmpArg5%
		B_itemArg6 = %tmpArg6%
		B_itemArg7 = %tmpArg7%
		B_itemArg8 = %tmpArg8%
		B_itemArg9 = %tmpArg9%

		return True
	}
	return False
}
