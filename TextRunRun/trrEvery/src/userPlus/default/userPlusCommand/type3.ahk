

uptype3_notSaveHistoryCommand(command, allArgs, useControl, useGuiNum){

/*
	if(command == "newCommand1" ) {
		userMakeFunc1(command, allArgs, useControl, useGuiNum)
		return True
	} else if(command == "newCommand2" ) {
		userMakeFunc2(command, allArgs, useControl, useGuiNum)
		return True
	}
*/


	return  False
}

/*
タイプ３
の特徴
==========================================
	引数は、半角スペースで分割されない。一つの文字列同然になる。

-----------------------------
	<<< での動作
	読み込む
-----------------------------
	履歴に残すか
	残さない
-----------------------------
	&&& での動作
	無視する
-----------------------------
	>>> での動作
	無視する
-----------------------------
	##と%%を展開するかどうか
	しない
-----------------------------
	" " があった場合
	無視する
-----------------------------
	分割テキストでの動作
		フォーカスされた位置は関係ない。
-----------------------------
	該当する規定のコマンド
	&newItem
	&stockAddBlue
	&hotkeyOnTextNew
	&outCommToOutGui
	&outCommToMultipleComm
	&outTmpOutGuiToOutGui
==========================================
*/
