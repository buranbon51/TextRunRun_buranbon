

uptype4_specialCommand(command, allArgs, allText, useControl, useGuiNum, historyStr, andFlag){

/*
	if(command == "newCommand1" ) {
		userMakeFunc1(command, allArgs, allText, useControl, useGuiNum)
		return True
	} else if(command == "newCommand2" ) {
		userMakeFunc2(command, allArgs, allText, useControl, useGuiNum)
		return True
	}
*/


	return  False
}

/*
タイプ４
の特徴
==========================================
	引数は、半角スペースで分割されない。一つの文字列同然になる。

	ここに属するコマンドの数は少ないが、
	&&& の扱いと
	>>> の扱いが
	コマンドによって違う。

-----------------------------
	<<< での動作
	読み込む
-----------------------------
	履歴に残すか
	残す
-----------------------------
	&&& での動作
	コマンドによって、扱い方が違う
-----------------------------
	>>> での動作
	コマンドによって、扱い方が違う

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
	&wait
	&timer
	&collabText
==========================================
*/
