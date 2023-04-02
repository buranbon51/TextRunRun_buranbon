





;Menu, multipleScripts, Add, 二行以上の処理を実行(&O), enys_SubShowMultipleScriptsGui
;Menu, multipleScripts, Add, 二行以上の処理を登録(&N), enys_SubShowMultipleScriptsEntryGui


Menu, stockMenuBlue, Add, ロードする１つ前に戻す(&L), SubButton77_2
Menu, stockMenuBlue, Add, セーブする１つ前に戻す(&S), SubButton77_4
Menu, stockMenuBlue, Add
Menu, stockMenuBlue, Add, キャンセル(&C), enys_SubCancel

Menu, stockMenuGreen, Add, ロードする１つ前に戻す(&L), SubButton78_2
Menu, stockMenuGreen, Add, セーブする１つ前に戻す(&S), SubButton78_4
Menu, stockMenuGreen, Add
Menu, stockMenuGreen, Add, キャンセル(&C), enys_SubCancel


Menu, otherMyMake, Add, タイマー一覧(&T), SubGui87Show
Menu, otherMyMake, Add, テキストのストック一覧(&M), enys_SubShowCommList
Menu, otherMyMake, Add, アイテム一覧(&E), enys_SubShowEverItemGui
Menu, otherMyMake, Add, キーの一覧(&K), enys_SubShowHotkeyListGui
Menu, otherMyMake, Add, 入力補完の一覧(&N), enys_SubShowEverInputGui
Menu, otherMyMake, Add, マウス操作のためのウインドウを表示(&L), enys_SubShowClickWindow
Menu, otherMyMake, Add, ファイル表示用ウインドウを表示(&U), enys_SubShowOutputTxtGui
Menu, otherMyMake, Add, 状態(&A), enys_SubThisSoftStatus
Menu, otherMyMake, Add
Menu, otherMyMake, Add, ウインドウの位置とサイズを保存(&G), enys_SubGuiSizePosSave
Menu, otherMyMake, Add, 初期の位置とサイズに戻す(&I), enys_SubGuiSizePosInit
Menu, otherMyMake, Add
Menu, otherMyMake, Add, Suspendオン(&S), enys_SubSuspendOn
Menu, otherMyMake, Add, Suspendオフ(&o), enys_SubSuspendOff
Menu, otherMyMake, Add, Pauseオン(&P), enys_SubPauseOn
Menu, otherMyMake, Add, Pauseオフ(&F), enys_SubPauseOff
Menu, otherMyMake, Add
Menu, otherMyMake, Add, キャンセル(&C), enys_SubCancel



Menu, D_menuMain, Add, %glob_oneLineTextAlias%1(&1), enys_SubShowMiniEditGui1
Menu, D_menuMain, Add, %glob_oneLineTextAlias%2(&2), enys_SubShowMiniEditGui2
Menu, D_menuMain, Add, %glob_oneLineTextAlias%3(&3), enys_SubShowMiniEditGui3
Menu, D_menuMain, Add, %glob_textSplitAlias%1(&4), enys_SubShowEditssGui1
Menu, D_menuMain, Add, %glob_textSplitAlias%2(&5), enys_SubShowEditssGui2
Menu, D_menuMain, Add, 二行以上のテキスト(&N), enys_SubShowMultipleScriptsGui
Menu, D_menuMain, Add
Menu, D_menuMain, Add, 一時的な説明表示(&P), enys_SubShowExplainGui
Menu, D_menuMain, Add, 蓄え式説明表示(&U), enys_SubShowAppendExplainGui
Menu, D_menuMain, Add, エラー表示(&E), enys_SubShowErrorGui
Menu, D_menuMain, Add
Menu, D_menuMain, Add, 設定(&o), enys_SubShowConfig
Menu, D_menuMain, Add, 他(&M), :otherMyMake
Menu, D_menuMain, Add
Menu, D_menuMain, Add, キャンセル(&C), enys_SubCancel
Menu, D_menuMain, Add, ソフトの終了(&X), enys_SubExitAppFromMenu

Menu, CtrlNum, Add, Ctrl＋1(&1), SubCommMenuCtrl1
Menu, CtrlNum, Add, Ctrl＋2(&2), SubCommMenuCtrl2
Menu, CtrlNum, Add, Ctrl＋3(&3), SubCommMenuCtrl3
Menu, CtrlNum, Add, Ctrl＋4(&4), SubCommMenuCtrl4
Menu, CtrlNum, Add, Ctrl＋5(&5), SubCommMenuCtrl5
Menu, CtrlNum, Add, Ctrl＋6(&6), SubCommMenuCtrl6
Menu, CtrlNum, Add, Ctrl＋7(&7), SubCommMenuCtrl7
Menu, CtrlNum, Add, Ctrl＋8(&8), SubCommMenuCtrl8
Menu, CtrlNum, Add, Ctrl＋9(&9), SubCommMenuCtrl9
Menu, CtrlNum, Add, Ctrl＋0(&0), SubCommMenuCtrl10

Menu, ShiftCtrlNum, Add, Ctrl＋Shift＋1(&1), SubCommMenuShiftCtrl1
Menu, ShiftCtrlNum, Add, Ctrl＋Shift＋2(&2), SubCommMenuShiftCtrl2
Menu, ShiftCtrlNum, Add, Ctrl＋Shift＋3(&3), SubCommMenuShiftCtrl3
Menu, ShiftCtrlNum, Add, Ctrl＋Shift＋4(&4), SubCommMenuShiftCtrl4
Menu, ShiftCtrlNum, Add, Ctrl＋Shift＋5(&5), SubCommMenuShiftCtrl5
Menu, ShiftCtrlNum, Add, Ctrl＋Shift＋6(&6), SubCommMenuShiftCtrl6
Menu, ShiftCtrlNum, Add, Ctrl＋Shift＋7(&7), SubCommMenuShiftCtrl7
Menu, ShiftCtrlNum, Add, Ctrl＋Shift＋8(&8), SubCommMenuShiftCtrl8
Menu, ShiftCtrlNum, Add, Ctrl＋Shift＋9(&9), SubCommMenuShiftCtrl9
Menu, ShiftCtrlNum, Add, Ctrl＋Shift＋0(&0), SubCommMenuShiftCtrl10

Menu, AltCtrlNum, Add, テキスト１を先頭にして実行(&1), SubCommMenuAltCtrl1
Menu, AltCtrlNum, Add, テキスト２を先頭にして実行(&2), SubCommMenuAltCtrl2
Menu, AltCtrlNum, Add, テキスト３を先頭にして実行(&3), SubCommMenuAltCtrl3
Menu, AltCtrlNum, Add
Menu, AltCtrlNum, Add, 分割テキスト１を先頭にして実行(&4), SubCommMenuAltCtrl4
Menu, AltCtrlNum, Add, 分割テキスト２を先頭にして実行(&5), SubCommMenuAltCtrl5

;Menu, enyCommMenu, Add, 決定(&E), SubCommEnter
Menu, enyCommMenu, Add, 入力補完(Ctrl＋Space)(&L), SubCommPopupShow
Menu, enyCommMenu, Add, ##で囲み、￥をつける(Alt＋#)(&U), SubCommMenuAlt3
Menu, enyCommMenu, Add, ％％で囲む(Alt＋5)(&5), SubCommMenuAlt5
Menu, enyCommMenu, Add, カラにする(Alt＋C)(&C), SubCommMenuAltC
Menu, enyCommMenu, Add, ％％や##で囲んだ文字を分解する(Alt＋T)(&T), SubCommMenuAltT
Menu, enyCommMenu, Add, アイテムの動作を確認(Alt＋O)(&S), SubCommMenuAltO
Menu, enyCommMenu, Add, アイテムの動作を確認２(Shift＋Alt＋O)(&N), SubCommMenuShiftAltO
Menu, enyCommMenu, Add, 最後の単語を先頭にもっていく(Alt＋Semicolon)(&Q), SubCommMenuAltSemicolon
Menu, enyCommMenu, Add, アイテムのパスを表示(Alt＋P)(&P), SubCommMenuAltP
Menu, enyCommMenu, Add, ””で囲む(Alt＋2)(&2), SubCommMenuAlt2
Menu, enyCommMenu, Add, ＆lastAsHeadExecute(&X), SubCommMenuLastAsHeadExecute

Menu, D_menuTextGui, Add, 決定(&E), SubCommEnter
Menu, D_menuTextGui, Add, ストック1(&A), :CtrlNum
Menu, D_menuTextGui, Add, ストック2(&B), :ShiftCtrlNum
Menu, D_menuTextGui, Add, 別のテキストを利用(&T), :AltCtrlNum
Menu, D_menuTextGui, Add, いろいろ(&I), :enyCommMenu
Menu, D_menuTextGui, Add, メインのメニュー(&M), :D_menuMain
Menu, D_menuTextGui, Add
Menu, D_menuTextGui, Add, キャンセル(&C), enys_SubCancel

Menu, D_menuTextGuiTop, Add, メニュー(&M), :D_menuTextGui
Menu, D_menuTextGuiTop, Add, 閉じる(&X), SubCommClose

Menu, D_menuClickWindow, Add, メインのメニュー(&M), :D_menuMain
Menu, D_menuClickWindow, Add, このウインドウを閉じる(&X), enys_SubHideClickWindow

Menu, D_menuClickWindowTop, Add, メニュー(&M), :D_menuClickWindow




;Menu, Tray, Add, テキスト(&T), enys_SubTrayMenuDefault
;Menu, Tray, Add, メインのメニュー(&M), :D_menuMain
;Menu, Tray, Add
;Menu, Tray, Add, メニューのキャンセル(&C), enys_SubCancel
;Menu, Tray, Add, TextRunRunの終了(&X), enys_SubExitAppFromMenu

;Menu, Tray, NoStandard
;Menu, Tray, Default, テキスト(&T)

;Menu, Tray, Click, 1




; 後で変更する  init_commWinTitleSet()
;Menu, Tray, Tip, __AhkCommLaunch_

