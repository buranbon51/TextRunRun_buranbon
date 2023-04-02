




; 簡単な説明表示用
reouts_easyExplain(str, exeGuiNum){

/*
	guit_setExplain(str, exeGuiNum)
*/

	guit_setExplain(str, exeGuiNum)

}



; エラーメッセージ表示用
reouts_errorMessageOutput(errorMessage1, errorMessage2="@", errorMessage3="@", errorMessage4="@"){

/*
	guit_errorAppend(errorMessage1, errorMessage2, errorMessage3, errorMessage4)
*/

	guit_errorAppend(errorMessage1, errorMessage2, errorMessage3, errorMessage4)

}


; ErrorLevel をチェックし、ErrorLevelが 0 なら True を返す
; エラーがあれば、メッセージを表示
reouts_checkErrorLevel(errorMessage1, errorMessage2="@", errorMessage3="@", errorMessage4="@"){

/*
	res := guit_checkErrorLevelOutput(errorMessage1, errorMessage2, errorMessage3, errorMessage4)
	return res
*/

	res := guit_checkErrorLevelOutput(errorMessage1, errorMessage2, errorMessage3, errorMessage4)
	return res
}



; アイテム名からアイテムのリンク先を得る
reouts_getPathOfItem(itemName){

/*
	itemPath := cen_ansPathOfItem(itemName)
	return itemPath
*/

	itemPath := cen_ansPathOfItem(itemName)
	return itemPath

}


; アイテム名として正しい書式かどうか。正しいなら True
reouts_itemNameNGCharacterConfirm(itemName){

/*
	res := ite_itemNameNGCharacterConfirm(itemName)
	return res
*/

	flag := ite_itemNameNGCharacterConfirm(itemName)
	return flag

}
