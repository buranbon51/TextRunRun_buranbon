﻿

uptype5_argNotSplitSpaceCommand(command, allArgs, useControl, useGuiNum){

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
タイプ５
の特徴
==========================================
	引数は、半角スペースで分割されない。一つの文字列同然になる。

-----------------------------
	<<< での動作
	読み込む
-----------------------------
	履歴に残すか
	残す
-----------------------------
	&&& での動作
	認識して処理する
-----------------------------
	>>> での動作
	認識して処理する

-----------------------------
	##と%%を展開するかどうか
	展開する
-----------------------------
	" " があった場合
	無視するが、コマンドによって、取り除く
-----------------------------
	分割テキストでの動作
		&&& や >>> を認識して実行するが、
		&&& や >>> の引数　の入力欄に入れなければ、認識しない。
-----------------------------
	該当する規定のコマンド
	&cd
	&readFile
	&goFunc
==========================================
*/
