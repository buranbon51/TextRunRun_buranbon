
init_checkErrorLevelStartUpBuff("Guiとメニューの作成時にエラーあり")
guinif_cleatedDate("v1", "1")

O_inputListY := guaf_anyOfNumFromDpi(30, 33, 36)
O_inputListReverseY := guaf_anyOfNumFromDpi(340, 395, 450)


init_checkFileAndFolderMakeFolderAndFile()
init_checkErrorLevelStartUpBuff("ファイルの存在を確認時にエラーあり")
init_myConfigRead()
init_checkErrorLevelStartUpBuff("設定ファイルの読み込み時にエラーあり")
init_managerConfigRead()
init_checkErrorLevelStartUpBuff("管理者設定ファイルの読み込み時にエラーあり")
init_exceptionOfUserRead()
init_checkErrorLevelStartUpBuff("再起動が必要な設定ファイルの読み込み時にエラーあり")

init_widthBasisCommboxAndEntryItem()

init_commWinTitleSet()

init_initGuiAll()
guinif_initGui88()

;Guiの位置とサイズを前の状態にする。あきらかに起動のスピードに変化があるのでコメントにするのもあり。
cen_ahkGuiSizePosLoad()
init_checkErrorLevelStartUpBuff("Guiの位置とサイズを読み出し時にエラーあり")

init_itemObjSetting(True)
init_itemObjSetting(False)
init_checkErrorLevelStartUpBuff("アイテムファイルを読み込み時にエラーあり")
init_multipleObjSetting(True)
init_multipleObjSetting(False)
init_checkErrorLevelStartUpBuff("二行以上アイテムを読み込み時にエラーあり")

init_sysCommObjMake()
init_checkErrorLevelStartUpBuff("既定のコマンドファイルを読み込み時にエラーあり")
init_specialWordObjMake()
init_checkErrorLevelStartUpBuff("コマンドに使う単語ファイルを読み込み時にエラーあり")
init_ahkCommObjMake()
init_checkErrorLevelStartUpBuff("Ahkコマンドファイルを読み込み時にエラーあり")
init_variableWordObjMake()
init_checkErrorLevelStartUpBuff("変数ファイルを読み込み時にエラーあり")
init_userVariableWordObjMake()
init_checkErrorLevelStartUpBuff("ユーザー用の変数ファイルを読み込み時にエラーあり")
cen_userMakeWordObjSetting(glob_addListDir . glob_addWordListName)
init_checkErrorLevelStartUpBuff("addWordList.txt ファイルを読み込み時にエラーあり")
init_optionVariableWordObjMake()
init_checkErrorLevelStartUpBuff("設定用の変数を読み込み時にエラーあり")
init_optionSetterFuncWordObjMake()
init_historyObjSetting()
init_checkErrorLevelStartUpBuff("コマンド履歴ファイルを読み込み時にエラーあり")
init_snippetAddDefault()
init_snippetObjSetting()
init_checkErrorLevelStartUpBuff("簡易入力の読み込み時にエラーあり")
syfl_systemHotkeyObjInsert()

init_commShortcatKeySetting()
init_checkErrorLevelStartUpBuff("ショートカットキーのセッティング時にエラーあり")

cen_iniSetAnyList()

init_lastWordConfigRead()
init_checkErrorLevelStartUpBuff("lastWord設定ファイルの読み込み時にエラーあり")


init_startUpBuffOutput()
init_startUpErrorBuffOutput()

init_hotkeyItemObjSetting(True)
init_hotkeyItemObjSetting(False)

frfnf_setAllFromFileName()
