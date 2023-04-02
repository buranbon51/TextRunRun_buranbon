

uptype2_plusDifferentByFocusCommand(command, allArgs, useControl, hwnd, useGuiNum){

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
タイプ２
の特徴
==========================================
	引数は、半角スペースで分割されない。一つの文字列同然になる。

-----------------------------
	<<< での動作
	無視する
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
		フォーカスされた位置の文字を受け取り、
		フォーカスされた位置で動作する。
-----------------------------
	該当する規定のコマンド
	&doubleQuouteCustom
	&parsentss
	&sharpssCustom
==========================================
*/
