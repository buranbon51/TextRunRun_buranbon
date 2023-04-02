; 必須  glob  guf
; IME  outs cof



hotk_myGuiShortKat(com1) {
	glob_shortKeyFlag := True
	glob_shortKeyComm = %com1%
	Send, !n
}

hotk_wordReplaceAndLower(keyName, SearchText, ReplaceText){
	StringLower, tmpKeyName, keyName
	IfInString, tmpKeyName, %SearchText%
	{
		StringReplace, keyName, tmpKeyName, %SearchText% , %ReplaceText%
	}
	return keyName
}

; + を shift+ に変える場合、Ctrl+A などロングネームがある場合、無駄に置換されてしまう。
; Ctrl+やAlt+などの文字を１度削除してから、+ を Shift+ に置換する。
; さらにこの関数は Win+Ctrl+Alt+Shift+ の順番に並び替える役割も担っている。
; あと、hotk_wordReplaceAndLower() で ^ ! # を置換した後でこの関数を使わないと、順番の並び替えができない。
hotk_shiftShortNameToLongName(keyName){
	; + がなかったら、何にもせずに終わる。 ^ や ! や # があった場合、すでに + があるはず。
	IfNotInString, keyName, +
	{
		return keyName
	}

	StringLower, keyName, keyName
	buff =
	IfInString, keyName, win+
	{
		StringReplace, keyName, keyName, win+
		buff .= "Win+"
	}
	IfInString, keyName, ctrl+
	{
		StringReplace, keyName, keyName, ctrl+
		buff .= "Ctrl+"
	}
	IfInString, keyName, alt+
	{
		StringReplace, keyName, keyName, alt+
		buff .= "Alt+"
	}
	IfInString, keyName, shift+
	{
		StringReplace, keyName, keyName, shift+
		buff .= "Shift+"
	}
	IfInString, keyName, +
	{
		StringReplace, keyName, keyName, + , Shift+
	}
	keyName := buff . keyName
	return keyName
}

; 無理なキー名なら True
hotk_checkErrorKeyName(keyName){
	IfInString, keyName, +
	{
		return False
	}
	andStr := " & "
	IfInString, keyName, %andStr%
	{
		return False
	}
	return True
}

; キーのショートネームをロングネームに変える
; さらにこの関数は Win+Ctrl+Alt+Shift+ の順番に並び替える役割も担っている。
hotk_shortKeyNameToLongName(keyName){
	; キーのショートネームをロングネームに変える
	longKeyName := hotk_wordReplaceAndLower(keyName, "^", "ctrl+")
	longKeyName := hotk_wordReplaceAndLower(longKeyName, "!", "alt+")
	longKeyName := hotk_wordReplaceAndLower(longKeyName, "#", "win+")
	; + を shift+ に変える場合、Ctrl+A などロングネームがある場合、無駄に置換されてしまう。
	; Ctrl+やAlt+などの文字を１度削除してから、+ を shift+ に置換する。
	; さらにこの関数は Win+Ctrl+Alt+Shift+ の順番に並び替える役割も担っている。
	longKeyName := hotk_shiftShortNameToLongName(longKeyName)

	; 右端が + だった場合にエラーになるようにした
	StringRight, rChr, longKeyName, 1
	if(rChr == "+"){
		str := "エラー  " . keyName
		return str
	}
	return longKeyName
}

; ２箇所で使うので関数にした。 正しく登録できた場合は True を 失敗したら False を返す
hotk_entryKeyOnTextCommandLogic(com2, com3, explanation, tmpItem, fileFlag, categoryDir, GuiNum){

	if(glob_commShortCutKeyUsedCount >= 50){
		guit_errorAppend("テキスト上のホットキーは、数の制限により、これ以上登録できない`n" . com2 . "`nのキーの登録は中止している")
		return False
	}

	; キーのショートネームをロングネームに変える
	; さらにこの関数は Win+Ctrl+Alt+Shift+ の順番に並び替える役割も担っている。
	longKeyName := hotk_shortKeyNameToLongName(com2)

	;キー名が被ってるかどうか
	if( IsObject( glob_commShortLongKeyNameObj[longKeyName] ) ) {
		guit_errorAppend("テキスト上のキー登録のエラー`n" . com2 . "  はすでに設定されている。")
		return False
	}

	;if( hotk_checkErrorKeyName(longKeyName) ){
	;	guit_errorAppend("テキスト上のキー登録のエラー`nこのキーは登録できない`n" . com2)
	;	return False
	;}

	; キーのロングネームをショートネームに変える
	keyName := hotk_wordReplaceAndLower(longKeyName, "ctrl+", "^")
	keyName := hotk_wordReplaceAndLower(keyName, "alt+", "!")
	keyName := hotk_wordReplaceAndLower(keyName, "win+", "#")
	keyName := hotk_wordReplaceAndLower(keyName, "shift+", "+")


	returnValue := False

	; fromFileName から登録の場合、まとめて指定するのでいらない
	if( fileFlag != 3 ){
		Hotkey, IfWinActive , %gGlob_GuiCommandTitle%
	}
	StringLower, com3Tmp, com3
	if(com3Tmp == "on"){
		Hotkey, %keyName% , On, UseErrorLevel
		res := guit_checkErrorLevelOutput("テキスト上のキーのエラー`nキーの操作に失敗している。", "引数１  " . com2, "引数２  " . com3)
		if( res ){
			guit_setExplain("ホットキーをOnにした。`n引数１  " . com2, GuiNum)
			returnValue := True
		}
	} else if(com3Tmp == "off"){
		Hotkey, %keyName% , Off, UseErrorLevel
		res := guit_checkErrorLevelOutput("テキスト上のキーのエラー`nキーの操作に失敗している。", "引数１  " . com2, "引数２  " . com3)
		if( res ){
			guit_setExplain("ホットキーをOffにした。`n引数１  " . com2, GuiNum)
			returnValue := True
		}
	} else {
		res := True
		; すでに登録されているホットキーがあった場合、ErrorLevel は 0 を返すので そうなら、res を False にする
		Hotkey, %keyName% , , UseErrorLevel
		if(ErrorLevel == 0){
			guit_errorAppend("テキスト上のキー登録のエラー`nすでに設定されている、または何らかの理由でこのキーは登録できない。`nキー名１  " . keyName . "`nキー名２  " . longKeyName)
			res := False
		}

		; res が False なら、新規登録をしない
		if( res ){
			count := glob_commShortCutKeyUsedCount
			count++

			sublutinName := "SubCommShortCutKey" . count
			Hotkey, %keyName% , %sublutinName%, UseErrorLevel
			errorStr := hotk_errorMsgForHotkey(ErrorLevel, com2, com3)
			res := guit_checkErrorLevelOutput(errorStr)
			if( res ){
				; 成功したときのみグローバル変数の数を足す
				glob_commShortCutKeyUsedCount += 1
				glob_commShortCutKeyObj.Insert(count, com3)

				optionObj := Object()
				optionObj.Insert(1, count)
				optionObj.Insert(2, explanation)
				optionObj.Insert(3, tmpItem)
				optionObj.Insert(4, fileFlag)
				optionObj.Insert(5, categoryDir)
				glob_commShortLongKeyNameObj.Insert(longKeyName, optionObj)
				if(fileFlag == 2){
					guit_setExplain("ホットキーを登録した。`n引数１  " . com2 . "`n引数２  " . com3 . "`n" . count . " つ目のホットキー", GuiNum)
				}
				returnValue := True
			}
		}
	}

	; fromFileName から登録の場合、まとめて指定するのでいらない
	if( fileFlag != 3 ){
		Hotkey, IfWinActive
	}

	return returnValue
}

hotk_hotkeyOnTextFromCommand(com2, com3, pOut, GuiNum){
	str := "Hotkey と似た形で記入する。`nHotkey, KeyName [, Label, Options]`n引数1に KeyName と同じ書式で記述する。`n引数2に サブルーチンではなく、処理させたいスクリプトを記述。`n（例  &hotkeyOnTextNewFromCommand  ^t  &textOut）`nなお、引数１は Ctrl+Alt+Shift+t という書式でも可能ではある。`n登録できる数は 50 に限定している。`n`n引数2に Off をいれると、指定したキーを停止する。`n引数2に On をいれると、停止したのを再開する。`n&hotkeyOnTextNewで登録する場合と違い、再起動した後は無効になる"
	if( edc_helpViewIfHyphenH(str, com2, GuiNum) ){
		return
	}
	if(com2 == ""){
		guit_setExplainPurpose(str, GuiNum)
		return
	}
	;if(com3 == ""){
	;	guit_setExplainPurpose(str, GuiNum)
	;	return
	;}
	hotk_entryKeyOnTextCommandLogic(com2, com3, "", False, 2, "", GuiNum)
	;guf_setControl( "", pOut, GuiNum )
}

hotk_HotkeyNew(rightStr, pOut, GuiNum){
	str := "ホットキーを登録するGuiを表示する`n登録したホットキーはファイルに登録されるため、再起動しても使える"
	if( edc_helpViewIfHyphenH(str, rightStr, GuiNum) ){
		return
	}
	hoit_everHotkeyShow(rightStr)
}

hotk_errorMsgForHotkey(errlevel, com2, com3){
	errorStr =
	if(errlevel == 1){
		errorStr := "ホットキーの登録に失敗している。`n指定のサブルーチンが存在しない。`n引数１  " . com2 . "`n引数２  " . com3
	} else if(errlevel == 2){
		errorStr := "ホットキーの登録に失敗している。`n指定したキーは登録できない。`n引数１  " . com2 . "`n引数２  " . com3
	} else {
		errorStr := "ホットキーの登録に失敗している。`n引数１  " . com2 . "`n引数２  " . com3
	}
	return errorStr
}

hotk_hotkeyOffFromLongKeyName(longKeyName){

	; キーのロングネームをショートネームに変える
	keyName := hotk_wordReplaceAndLower(longKeyName, "ctrl+", "^")
	keyName := hotk_wordReplaceAndLower(keyName, "alt+", "!")
	keyName := hotk_wordReplaceAndLower(keyName, "win+", "#")
	keyName := hotk_wordReplaceAndLower(keyName, "shift+", "+")

	returnValue := False
	Hotkey, IfWinActive , %gGlob_GuiCommandTitle%
	Hotkey, %keyName% , Off, UseErrorLevel
	res := guit_checkErrorLevelOutput("ホットキーの Off に失敗している。`n  " . longKeyName . "  のOff")
	if( res ){
		returnValue := True
	}
	Hotkey, IfWinActive
	return returnValue
}

hotk_commShortcatKeyStartup(){

	Hotkey, IfWinActive, %gGlob_GuiCommandTitle%
	Hotkey, ^Space, CtrlSpaceSub
	Hotkey, !t,AltTSub
	Hotkey, !p,AltPSub
	Hotkey, +!p,ShiftAltPSub
	Hotkey, !Left,AltLeftSub
	Hotkey, !Right,AltRightSub
	Hotkey, !f,AltFSub
	Hotkey, !r,AltRSub
	Hotkey, !sc027,AltSemicolonSub
	Hotkey, !2,Alt2Sub
	Hotkey, !3,Alt3Sub
	Hotkey, !5,Alt5Sub
	Hotkey, ^n,CtrlNSub
	Hotkey, +^n,ShiftCtrlNSub
	Hotkey, !Enter,AltEnterSub
	Hotkey, +!Enter,ShiftAltEnterSub
	Hotkey, !o,AltOSub
	Hotkey, +!o,ShiftAltOSub
	Hotkey, !c,AltCSub
	Hotkey, ^1,Ctrl1Sub
	Hotkey, ^2,Ctrl2Sub
	Hotkey, ^3,Ctrl3Sub
	Hotkey, ^4,Ctrl4Sub
	Hotkey, ^5,Ctrl5Sub
	Hotkey, ^6,Ctrl6Sub
	Hotkey, ^7,Ctrl7Sub
	Hotkey, ^8,Ctrl8Sub
	Hotkey, ^9,Ctrl9Sub
	Hotkey, ^0,Ctrl0Sub
	Hotkey, +^1,ShiftCtrl1Sub
	Hotkey, +^2,ShiftCtrl2Sub
	Hotkey, +^3,ShiftCtrl3Sub
	Hotkey, +^4,ShiftCtrl4Sub
	Hotkey, +^5,ShiftCtrl5Sub
	Hotkey, +^6,ShiftCtrl6Sub
	Hotkey, +^7,ShiftCtrl7Sub
	Hotkey, +^8,ShiftCtrl8Sub
	Hotkey, +^9,ShiftCtrl9Sub
	Hotkey, +^0,ShiftCtrl0Sub
	Hotkey, ^!1,CtrlAlt1Sub
	Hotkey, ^!2,CtrlAlt2Sub
	Hotkey, ^!3,CtrlAlt3Sub
	Hotkey, ^!4,CtrlAlt4Sub
	Hotkey, ^!5,CtrlAlt5Sub

	Hotkey, IfWinActive
}

hotk_exceptCommKeyStartup(){
	; テキスト上や、アイテム登録の上下キー
	Hotkey, IfWinActive, %gGlob_GuiTextNearTitle%
	Hotkey, Up,TextAnyUpSub
	Hotkey, Down,TextAnyDownSub
	Hotkey, PgUp,TextAnyPgUpSub
	Hotkey, PgDn,TextAnyPgDnSub

	;Hotkey, Up up,TextUpUpSub
	;Hotkey, Down up,TextDownUpSub
	;Hotkey, PgUp up,TextPgUpUpSub
	;Hotkey, PgDn up,TextPgDnUpSub

	;Hotkey, IfWinActive

	; 分割テキストで入力補完をダブルクリックで決定できるように
	Hotkey, IfWinActive, %gGlob_GuiTextSplitTitle%
	Hotkey, LButton,TextAnyLClickSub

	;Hotkey, IfWinActive

	; アイテム登録の 入力補完の表示
	Hotkey, IfWinActive, %gGlob_Gui72Title%
	Hotkey, ^Space,ItemCtrlSpaceSub

	;Hotkey, IfWinActive

	; 入力補完上のダブルクリックで決定できるように
	Hotkey, IfWinActive, %gGlob_Gui70Title%
	Hotkey, LButton,InputListLClickSub

	;Hotkey, IfWinActive
}
