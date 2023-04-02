

sysli_sysComList(){
	clist =
(LTrim
&cd /// 指定のフォルダに移動  引数なしなら A_ScriptDir に移動する###n- で前にいたフォルダに戻れる
&cdmydocu /// マイドキュメントにcd したのと同じ
&cdmain /// スクリプトのあるフォルダに戻る
&ls /// 引数で対象のフォルダを指定可能
&mkdir
&pwd /// 今の位置を確認
&timer
&timerStop
&timerView
&more
&moreTextOut
&outArgsToOutGuiAddLinefeed
&outArgsToTmpOutGui
&outArgsToTextEditExecutor
&outArgsToTextEditExecutorTextOut
&outArgsToTextGuiAssign
&outArgsToTextGuiAssignTextOut
&outArgsToTextGuiAssignAdd
&outArgsToTextGuiAssignAddTextOut
&outArgsToMultipleText1AddLinefeed
&outArgsToMultipleText1AddLinefeedTextOut
&outOutGuiToOutFileAddLinefeed
&outArgsToOutFileAddLinefeed
&outTmpOutGuiToText
&outTmpOutGuiToTmpFile
&outTmpOutGuiToOutFileAddLinefeed
&outTmpOutGuiToOutGuiAddLinefeed
&outArgsToOutGuiAddLinefeedTextOut
&outArgsToTmpOutGuiTextOut
&outArgsToOutFileAddLinefeedTextOut
&outArgsToFileAssignAddLinefeed
&outArgsToFileAssignAddLinefeedTextOut
&outOutFileToFileGui
&outErrGuiToErrFileAddLinefeed
&outErrFileToFileGui
&outArgsTestType1
&outArgsTestType2
&outArgsTestType3
&outArgsTestType4
&outArgsTestType5
&outArgsTestType6
&collabText
&pctime /// PCを起動してからの時間
&goFunc
&openConfirm /// アイテムやファイルパスを実行せずに内容を表示
&openConfirmOneLine
&returnOutputGui /// 一度消した出力を復元
&pathLink /// 登録したアイテムのリンク先を表示###nAlt+P
&textOut
&getValue /// 変数を表示
&setValue
&setValueTmpOutGui
&setValueMultipleText1
&popList /// 入力補完を表示###nCtrl+Space
&popItemSoftList /// 登録したアイテムの入力補完を表示###nAlt+L
&popFileList /// ファイルの入力補完を表示
&popHistoryList /// 履歴の入力補完を表示###nAlt+H
&popItemScriptList
&popItemFolderList
&popHistoryFilterList /// 履歴の一部一致での入力補完を表示###nShift+Alt+H
&popAddWordFilterList
&popSpecialWordList
&backOneDir /// １つ上のフォルダに移動###nAlt+←
&reBackOneDir /// &backOneDirしたのを戻す###nAlt+→
&fullPath /// 絶対パスを表示
&fullPathAll
&fullPathAssign
&relativePath
&relativeAssign
&lastAsHead /// 最後の単語を１番前に持っていく
&lastAsHeadExecute
&winCapture
&fileDialog
&folderDialog
&shortCutPath
&guiShow
&guiHideTextExecutor
&guiShowWaitExecutor
&guiHideAndShowWaitExecutor
&itemReloadAll
&getObj
&doubleQuoute
&doubleQuouteCustom
&parsentss
&sharpss /// 引数を # でくくる
&sharpssCustom /// 引数を # でくくる###nそれに￥をつける###nAlt+3
&open /// アイテムやファイルパスのみを実行
&openTextOut
&cleanTextEasy
&cleanTextAssign
&cleanText
&cleanTextExecutor
&tmpDelete
&newItem /// ソフトなどを登録する###nCtrl+N
&newMultipleItem
&newItemFromCommand
&editItem /// 登録した物を一覧表示する###n 引数があるとそのアイテム名の内容を変更する###nAlt+Enter
&deleteItem /// 登録した物を削除する###nアイテム名を指定する
&itemReloadOneFromFileName
&cmd /// コマンドプロンプト
&stockChangeBlue
&stockChangeGreen
&menuShow
&config
&startupFlag
&hotkeyOnTextNewFromCommand
&hotkeyOnTextEdit
&hotkeyOnTextDelete
&hotkeyOnTextNew
&stockExeAllBlue
&stockExeAllGreen
&readFile
&stockAddBlue
&stockAddGreen
&stockSaveBlue
&stockSaveGreen
&wait /// 指定時間待機させて起動
&shutdown /// シャットダウン
&shutdown_r /// 再起動
&logoff
&multiplelineExe
&multiplelineExeFromFile
&addWordListAdd
&addWordListAddFromFile
&hideInputList
&hideInputListExecutor
&enterForLastWord
&inputListSelectOnly
&snippetAdd
&snippetAddFromFile
&snippetOpen
&snippetDelete
&sendPaste
&sendPasteTextOut
&sendPasteFromFile
&sendPasteFromFileTextOut
&sendTextItself
&sendScriptToText
&sendEndToTextEditExecutor
&hotkeyAllGroundNew
&hotkeyAllGroundNewFromCommand
&hotkeyAllGroundEdit
&hotkeyAllGroundDelete
)

	return clist
}
