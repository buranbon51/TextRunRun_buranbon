




fontNum := cen_fontNumFromDpiAndFontSize(11, 10, 9)
;  アイテムの新規登録
guf_guiFontFromSizeAndName(fontNum, StO_fontNameAll, 72)
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_entryItemBackgName, "X0 Y30", 72)
tmpNumW := cen_anyOfNumFromDpiAndFontSize(13, 27, 350, 370, 390)
tmpNumH := cen_anyOfNumFromDpiAndFontSize(36, 36, 580, 600, 620)
Gui, 72:Add, Tab2, X0 Y5 w%tmpNumW% h%tmpNumH% vTab72_1, 登録１|登録２

Gui, 72:Tab, 1

Gui, 72:Add, Picture,X10 Y50 w32 h32 vPicture72_1_1
tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(17, 21, 250, 230, 210)
Gui, 72:Add, Text,   X80  Y50 w%tmpNumW2% vText72_1, アイテム名(&E)
tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(14, 16, 180, 160, 140)
Gui, 72:Add, Edit,    xp+0  y+5 w%tmpNumW2%  vEdit72_1 gSubEdit72_1
tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(16, 21, 290, 310, 330)
Gui, 72:Add, Text,   X20 y+20 w%tmpNumW2%  vText72_3  cFF0000 ,リンク先は必要です(&L)
Gui, 72:Add, Edit,   X10 y+5 w290    vEdit72_3  gSubEdit72_3
Gui, 72:Add, Button, X100 y+5 gSubButton72_1,    ファイル
Gui, 72:Add, Button,  x+10 yp+0 gSubButton72_2, フォルダ
tmpNumW := cen_anyOfNumFromDpiAndFontSize(8, 10, 110, 120, 130)
Gui, 72:Add, Button, X40 y+5 w%tmpNumW% gSubButton72_3 ,  相対パスに(&R)
Gui, 72:Add, Button,  x+10 yp+0 w%tmpNumW% gSubButton72_4 , 絶対パスに(&A)

Gui, 72:Add, Text,   X20 y+0, 引数(&P)
Gui, 72:Add, Edit,   X10 y+5 w290    vEdit72_4  gSubEdit72_4
Gui, 72:Add, Text,   X20 y+15, 作業フォルダ(&F)
Gui, 72:Add, Edit,   X10 y+5 w290    vEdit72_5  gSubEdit72_5

tmpNumGroupW := cen_anyOfNumFromDpiAndFontSize(16, 26, 320, 340, 360)
tmpNumGroupH := cen_anyOfNumFromDpiAndFontSize(5, 5, 90, 110, 130)
tmpNumW := cen_anyOfNumFromDpiAndFontSize(9, 12, 190, 210, 230)
Gui, 72:Add, GroupBox, X10 y+5  w%tmpNumGroupW% h%tmpNumGroupH%
Gui, 72:Add, Text,       X15 yp+15 , 種類
Gui, 72:Add, Radio,      xp+0   y+10  vRadio72_1 gSubRadio72_1 Checked , ソフト・ファイル(&S)
Gui, 72:Add, Radio,      xp+%tmpNumW% yp+0   vRadio72_2 gSubRadio72_2,  フォルダ(&D)
Gui, 72:Add, Radio,      X15 y+5      vRadio72_3 gSubRadio72_3,  スクリプト(&T)
Gui, 72:Add, Button,      xp+%tmpNumW% yp+0 gSubButton72_7 , 二行以上(&2)

Gui, 72:Add, Checkbox, X10 y+25  vCheckbox72_1, (&Q)
Gui, 72:Add, Text,     x+5 yp+0 vText72_4, 引数のファイルパスを`n自動的に""で囲むようにする`n（種類がソフト・ファイルの時のみ）
Gui, 72:Add, Checkbox, X10 y+15  vCheckbox72_2, (&U)
Gui, 72:Add, Text,     x+5 yp+0, 一時的にのみ保存
Gui, 72:Add, Button, X100 y+5 Default gSubButton72_5, 登録(&O)
Gui, 72:Add, Button,  x+10 yp+0 gSubButton72_6, Cancel


Gui, 72:Add, ListBox,X0 Y0  R15  Hidden  Disabled  vList72_1 VScroll
Gui, 72:Add, ListBox,X0 Y0  R15  Hidden  Disabled  vList72_2 VScroll
Gui, 72:Add, ListBox,X0 Y0  R15  Hidden  Disabled  vList72_3 VScroll
Gui, 72:Add, Button, X0 Y0  Hidden   gSubHidenButton72_1 , HidenButton(&B)
Gui, 72:Add, Button, X0 Y0  Hidden gSubButton72_5, 決定(&N)

Gui, 72:Tab, 2

Gui, 72:Add, Picture, X10 Y50 w32 h32 vPicture72_2_1
Gui, 72:Add, Text,   X10 y+5 , アイコンのファイルを指定(&I)
tmpNumW := cen_anyOfNumFromDpiAndFontSize(16, 20, 230, 250, 270)
Gui, 72:Add, Edit, X10 y+5   w%tmpNumW% vEdit72_2_1   gSubEdit72_2_1
tmpNumW := cen_anyOfNumFromDpiAndFontSize(2, 4, 60, 70, 80)
Gui, 72:Add, Edit, X10 y+5  w%tmpNumW% Number  vUpDown72_2_1  gSubUpDown72_2_1
Gui, 72:Add, UpDown, Range1-50 128, 1
Gui, 72:Add, Button,  x+50 yp+0 gSubButton72_2_1,    ファイル

Gui, 72:Add, Text,   X10 y+50, 説明を記入する(&M)
Gui, 72:Add, Edit,   X10 y+5 w250    vBoxEdit72_1  R6 VScroll

Gui, 72:Add, Checkbox, X0 Y0  Hidden  Disabled  vHiddenCheckbox72_1	;0新規作成  1編集
Gui, 72:Add, Edit,     X0 Y0  Hidden  Disabled  vHiddenEdit72_2		; アイテム名の変更用

Gui, 72:+Resize
Gui, 72:-MaximizeBox
cen_removeBorderFromCommTitleFlag(72)



fontNum := cen_fontNumFromDpiAndFontSize(10, 9, 8)
fontNum2 := cen_fontNumFromDpiAndFontSize(12, 11, 10)

tmpNumW := cen_anyOfNumFromDpiAndFontSize(26, 32, 450, 470, 490)
tmpNumH := cen_anyOfNumFromDpiAndFontSize(36, 36, 550, 570, 590)

tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(14, 18, 200, 220, 240)

tmpNumR := guaf_anyOfNumFromDpi(20, 18, 16)
tmpNumR2 := guaf_anyOfNumFromDpi(7, 5, 3)

tmpNumStartY := cen_anyOfNumFromDpiAndFontSize(0, 6, 40, 60, 80)
guf_guiFontFromSizeAndName(fontNum, StO_fontNameAll, 73)
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_everItemBackgName, "X0 Y30", 73)
Gui, 73:Margin, X10 Y5
Gui, 73:Add, Tab2, X0 Y5 w%tmpNumW% h%tmpNumH% , ソフト|フォルダ|スクリプト|二行以上
guf_guiFontFromSizeAndName(fontNum2, "", 73)
Gui, 73:Tab, 1
Gui, 73:Add, Text,    X10 Y%tmpNumStartY% , ソフト・ファイル(&L)
Gui, 73:Add, ListBox, X10 y+5 w%tmpNumW2%  R%tmpNumR%  VScroll  vList73_1  gSubList73_1
Gui, 73:Add, Edit,    X10 y+5 w%tmpNumW2%  R%tmpNumR2% Multi T8 VScroll  vBoxEdit73_1
Gui, 73:Add, Edit,     x+15 yp+0 w%tmpNumW2%  R%tmpNumR2% Multi T8 VScroll vBoxEdit73_1_2
Gui, 73:Add, Picture,   xp+0 Y%tmpNumStartY% w32 h32 vPicture73_1
Gui, 73:Add, Button,    xp+0 y+20  gSubButton73_1_1  ,編集(&E)
Gui, 73:Add, Button,    xp+0 y+10  gSubButton73_1_4,新規登録(&N)
Gui, 73:Add, Button,    xp+0 y+20  gSubButton73_1_2,コピー(&K)
Gui, 73:Add, Button,    xp+0 y+20  gSubButton73_1_3,削除(&D)

Gui, 73:Add, Text,    xp+0 y+10 w200 c36A2FF vText73_1_2
Gui, 73:Add, Text,    xp+0 y+10 w200 cFFB255 vText73_1_3
Gui, 73:Add, Text,    xp+0 y+10 w200 cFFB255 vText73_1_4

Gui, 73:Tab, 2
Gui, 73:Add, Text,    X10 Y%tmpNumStartY% , フォルダ(&L)
Gui, 73:Add, ListBox, X10 y+5 w%tmpNumW2%  R%tmpNumR%  VScroll  vList73_2  gSubList73_2
Gui, 73:Add, Edit,    X10 y+5 w%tmpNumW2%  R%tmpNumR2% Multi T8 VScroll  vBoxEdit73_2
Gui, 73:Add, Edit,     x+15 yp+0 w%tmpNumW2%  R%tmpNumR2% Multi T8 VScroll  vBoxEdit73_2_2
Gui, 73:Add, Picture,   xp+0 Y%tmpNumStartY% w32 h32 vPicture73_2
Gui, 73:Add, Button,    xp+0 y+20  gSubButton73_2_1  ,編集(&E)
Gui, 73:Add, Button,    xp+0 y+10  gSubButton73_2_4,新規登録(&N)
Gui, 73:Add, Button,    xp+0 y+20  gSubButton73_2_2 ,コピー(&K)
Gui, 73:Add, Button,    xp+0 y+20  gSubButton73_2_3 ,削除(&D)

Gui, 73:Add, Text,    xp+0 y+10 w200 c36A2FF vText73_2_2
Gui, 73:Add, Text,    xp+0 y+10 w200 cFFB255 vText73_2_3
Gui, 73:Add, Text,    xp+0 y+10 w200 cFFB255 vText73_2_4

Gui, 73:Tab, 3
Gui, 73:Add, Text,    X10 Y%tmpNumStartY% , スクリプト(&L)
Gui, 73:Add, ListBox, X10 y+5 w%tmpNumW2%  R%tmpNumR%  VScroll  vList73_3  gSubList73_3
Gui, 73:Add, Edit,    X10 y+5 w%tmpNumW2%  R%tmpNumR2% Multi T8 VScroll  vBoxEdit73_3
Gui, 73:Add, Edit,     x+15 yp+0 w%tmpNumW2%  R%tmpNumR2% Multi T8 VScroll  vBoxEdit73_3_2
Gui, 73:Add, Picture,   xp+0 Y%tmpNumStartY% w32 h32 vPicture73_3
Gui, 73:Add, Button,    xp+0 y+20  gSubButton73_3_1  ,編集(&E)
Gui, 73:Add, Button,    xp+0 y+10  gSubButton73_3_4,新規登録(&N)
Gui, 73:Add, Button,    xp+0 y+20  gSubButton73_3_2 ,コピー(&K)
Gui, 73:Add, Button,    xp+0 y+20  gSubButton73_3_3 ,削除(&D)

Gui, 73:Add, Text,    xp+0 y+10 w200 c36A2FF vText73_3_2
Gui, 73:Add, Text,    xp+0 y+10 w200 cFFB255 vText73_3_3
Gui, 73:Add, Text,    xp+0 y+10 w200 cFFB255 vText73_3_4

Gui, 73:Tab, 4
Gui, 73:Add, Text,    X10 Y%tmpNumStartY% , 二行以上のアイテム(&L)
Gui, 73:Add, ListBox, X10 y+5 w%tmpNumW2%  R%tmpNumR%  VScroll  vList73_7_1  gSubList73_7_1
Gui, 73:Add, Edit,    X10 y+5 w%tmpNumW2%  R%tmpNumR2% Multi T8 VScroll  vBoxEdit73_7_1
Gui, 73:Add, Edit,     x+15 yp+0 w%tmpNumW2%  R%tmpNumR2% Multi T8 VScroll  vBoxEdit73_7_2
Gui, 73:Add, Picture,   xp+0 Y%tmpNumStartY% w32 h32 vPicture73_7_1
Gui, 73:Add, Button,    xp+0 y+20  gSubButton73_7_1  ,編集(&E)
Gui, 73:Add, Button,    xp+0 y+10  gSubButton73_7_2,新規登録(&N)
Gui, 73:Add, Button,    xp+0 y+20  gSubButton73_7_3,コピー(&K)
Gui, 73:Add, Button,    xp+0 y+20  gSubButton73_7_4,削除(&D)

Gui, 73:Add, Text,    xp+0 y+10 w200 c36A2FF vText73_7_2
Gui, 73:Add, Text,    xp+0 y+10 w200 cFFB255 vText73_7_3
Gui, 73:Add, Text,    xp+0 y+10 w200 cFFB255 vText73_7_4


Gui, 73:+Resize
Gui, 73:-MaximizeBox




; 状態
fontNum := cen_fontNumFromDpiAndFontSize(12, 11, 10)
guf_guiFontFromSizeAndName(fontNum, StO_fontNameAll, 75)
Gui, 75:Add, Text,  X100 Y10,    状態
Gui, 75:Add, Text,  X10 y+25,    RunAsの状態：
Gui, 75:Add, Text,    x+20 yp+0 w100  vText75_1,    通常
Gui, 75:Add, Text,  X10 y+25,    管理者で実行：
Gui, 75:Add, Text,    x+20 yp+0 w100  vText75_2,    通常

Gui, 75:+Resize
Gui, 75:-MaximizeBox


; クリック用のＧＵＩ  常に前面表示
;tmpNumW := guaf_anyOfNumFromDpi(128, 150, 190)
fontNum := cen_fontNumFromDpiAndFontSize(10, 9, 8)
guf_guiFontFromSizeAndName(fontNum, StO_fontNameAll, 76)
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_clickWindowBackgName, "X0 Y0", 76)
;Gui, 76:Add, Picture,X0 Y0 w%tmpNumW% h-1  vPicture76_1 gSubPicture76_1 , %gloco_docDir%%glob_clickOnlyGuiBackGroundName%
outs_bgPictureAddEnyExtFileOrText("テキスト１", gloco_docDir . glob_comm1ClickName, "X0 Y0 w128 h64 vPicture76_1 gSubPicture76_1", 76)
outs_bgPictureAddEnyExtFileOrText("テキスト２", gloco_docDir . glob_comm2ClickName, "X128 Y0 w64 h32 vPicture76_2 gSubPicture76_2", 76)
outs_bgPictureAddEnyExtFileOrText("テキスト３", gloco_docDir . glob_comm3ClickName, "X128 Y32 w64 h32 vPicture76_3 gSubPicture76_3", 76)
outs_bgPictureAddEnyExtFileOrText("分割１", gloco_docDir . glob_commbox1ClickName, "X192 Y0 w32 h64 vPicture76_4 gSubPicture76_4", 76)
outs_bgPictureAddEnyExtFileOrText("分割２", gloco_docDir . glob_commbox2ClickName, "X224 Y0 w32 h64 vPicture76_5 gSubPicture76_5", 76)
outs_bgPictureAddEnyExtFileOrText("ストック１", gloco_docDir . glob_commStock1ClickName, "X0 Y64 w32 h64 vPicture76_6 gSubPicture76_6", 76)
outs_bgPictureAddEnyExtFileOrText("ストック２", gloco_docDir . glob_commStock2ClickName, "X32 Y64 w32 h64 vPicture76_7 gSubPicture76_7", 76)
outs_bgPictureAddEnyExtFileOrText("一時的な説明表示", gloco_docDir . glob_tmpOutputName, "X64 Y64 w64 h64 vPicture76_8 gSubPicture76_8", 76)
outs_bgPictureAddEnyExtFileOrText("蓄え式説明表示", gloco_docDir . glob_outputName, "X128 Y64 w64 h64 vPicture76_9 gSubPicture76_9", 76)
outs_bgPictureAddEnyExtFileOrText("エラー表示", gloco_docDir . glob_errorOutputName, "X192 Y64 w64 h64 vPicture76_10 gSubPicture76_10", 76)
outs_bgPictureAddEnyExtFileOrText("設定", gloco_docDir . glob_configClickName, "X0 Y128 w64 h64 vPicture76_11 genys_SubShowConfig", 76)
outs_bgPictureAddEnyExtFileOrText("アイテム一覧", gloco_docDir . glob_everItemGuiClickName, "X64 Y128 w64 h64 vPicture76_12 genys_SubShowEverItemGui", 76)
outs_bgPictureAddEnyExtFileOrText("キーの一覧", gloco_docDir . glob_everHotkeyClickName, "X128 Y128 w64 h64 vPicture76_13 genys_SubShowHotkeyListGui", 76)
outs_bgPictureAddEnyExtFileOrText("入力補完一覧", gloco_docDir . glob_everInputClickName, "X192 Y128 w64 h64 vPicture76_14 genys_SubShowEverInputGui", 76)
outs_bgPictureAddEnyExtFileOrText("Suspendオフ", gloco_docDir . glob_clickSuspendOffName, "X0 Y192 w64 h64 vPicture76_15 genys_SubSuspendOff", 76)
outs_bgPictureAddEnyExtFileOrText("Pauseオフ", gloco_docDir . glob_clickPauseOffName, "X64 Y192 w64 h64 vPicture76_16 genys_SubPauseOff", 76)
outs_bgPictureAddEnyExtFileOrText("Suspendオン", gloco_docDir . glob_clickSuspendOnName, "X128 Y192 w64 h64 vPicture76_17 genys_SubSuspendOn", 76)
outs_bgPictureAddEnyExtFileOrText("Pauseオン", gloco_docDir . glob_clickPauseOnName, "X192 Y192 w64 h64 vPicture76_18 genys_SubPauseOn", 76)
outs_bgPictureAddEnyExtFileOrText("二行以上のテキスト", gloco_docDir . glob_clickScriptsComm1Name, "X0 Y256 w64 h64 vPicture76_19 genys_SubShowMultipleScriptsGui", 76)
outs_bgPictureAddEnyExtFileOrText("タイマー一覧", gloco_docDir . glob_timerClickName, "X64 Y256 w64 h64 vPicture76_20 gSubGui87Show", 76)

;Gui, 76:Add, Button, X10 y+5     Hidden  gSubHidenButton76_1  Default , On(&N)

Gui, 76:Color, EBF7D6
Gui, 76:+AlwaysOnTop
Gui, 76:+Resize
;Gui, 76:-SysMenu
Gui, 76:-MaximizeBox
;Gui, 76:-MinimizeBox



fontNum := cen_fontNumFromDpiAndFontSize(14, 12, 10)
fontNum2 := cen_fontNumFromDpiAndFontSize(10, 8, 6)
;fontNum3 := cen_fontNumFromDpiAndFontSize(8, 7, 5)
tmpNumW := cen_anyOfNumFromDpiAndFontSize(5, 7, 70, 80, 90)
; コマンドのストック
guf_guiFontFromSizeAndName(fontNum, StO_fontNameAll, 77)
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_commStock1BackgName, "X0 Y0", 77)
Gui, 77:Add, Picture, X10 Y10 w32 h32  vPicture77_1 gSubPicture77_1
Gui, 77:Add, Text,      x+5 yp+0,(&1)
Gui, 77:Add, Edit,      x+5 yp+0 w190 vEdit77_1 gSubEdit77_1
Gui, 77:Add, Picture, X10 y+10 w32 h32  vPicture77_2 gSubPicture77_2
Gui, 77:Add, Text,      x+5 yp+0,(&2)
Gui, 77:Add, Edit,      x+5 yp+0 w190 vEdit77_2 gSubEdit77_2
Gui, 77:Add, Picture, X10 y+10 w32 h32  vPicture77_3 gSubPicture77_3
Gui, 77:Add, Text,      x+5 yp+0 ,(&3)
Gui, 77:Add, Edit,      x+5 yp+0 w190 vEdit77_3 gSubEdit77_3
Gui, 77:Add, Picture, X10 y+10 w32 h32  vPicture77_4 gSubPicture77_4
Gui, 77:Add, Text,      x+5 yp+0 ,(&4)
Gui, 77:Add, Edit,      x+5 yp+0 w190 vEdit77_4 gSubEdit77_4
Gui, 77:Add, Picture, X10 y+10 w32 h32  vPicture77_5 gSubPicture77_5
Gui, 77:Add, Text,      x+5 yp+0 ,(&5)
Gui, 77:Add, Edit,      x+5 yp+0 w190 vEdit77_5 gSubEdit77_5
Gui, 77:Add, Picture, X10 y+10 w32 h32  vPicture77_6 gSubPicture77_6
Gui, 77:Add, Text,      x+5 yp+0 ,(&6)
Gui, 77:Add, Edit,      x+5 yp+0 w190 vEdit77_6 gSubEdit77_6
Gui, 77:Add, Picture, X10 y+10 w32 h32  vPicture77_7 gSubPicture77_7
Gui, 77:Add, Text,      x+5 yp+0 ,(&7)
Gui, 77:Add, Edit,      x+5 yp+0 w190 vEdit77_7 gSubEdit77_7
Gui, 77:Add, Picture, X10 y+10 w32 h32  vPicture77_8 gSubPicture77_8
Gui, 77:Add, Text,      x+5 yp+0 ,(&8)
Gui, 77:Add, Edit,      x+5 yp+0 w190 vEdit77_8 gSubEdit77_8
Gui, 77:Add, Picture, X10 y+10 w32 h32  vPicture77_9 gSubPicture77_9
Gui, 77:Add, Text,      x+5 yp+0 ,(9)
Gui, 77:Add, Edit,      x+5 yp+0 w190 vEdit77_9 gSubEdit77_9
Gui, 77:Add, Picture, X10 y+10 w32 h32  vPicture77_10 gSubPicture77_10
Gui, 77:Add, Text,      x+5 yp+0 ,(10)
Gui, 77:Add, Edit,      x+5 yp+0 w180 vEdit77_10 gSubEdit77_10

Gui, 77:Add, Text,    X30 y+10,  リスト名(&T)
Gui, 77:Add, Edit,      x+5 yp+0  w135 Center  vEdit77_11

guf_guiFontFromSizeAndName(fontNum2, "", 77)
Gui, 77:Add, Button,  X10 y+10 w%tmpNumW%  gSubButton77_1, Load(&L)

Gui, 77:Add, Text,      x+10 yp+0,    リスト(&E)
Gui, 77:Add, ListBox,   xp+0 y+5 w170  R8 AltSubmit vListBox77_1, タイプ1||タイプ2|タイプ3|タイプ4|タイプ5|タイプ6|タイプ7|タイプ8|タイプ9|タイプ10|タイプ11|タイプ12|タイプ13|タイプ14|タイプ15|タイプ16|タイプ17|タイプ18|タイプ19|タイプ20

Gui, 77:Add, Button,  X10 yp+50 w%tmpNumW%  gSubButton77_3, Save(&S)
;Gui, 77:Font, S%fontNum3%
;Gui, 77:Add, Button,  X10 y+20  w%tmpNumW%  gSubButton77_2, LoadReLoad(&O)
;Gui, 77:Add, Button,  X10 y+10  w%tmpNumW%  gSubButton77_4, SaveReLoad(&R)
;Gui, 77:Font, S%fontNum2%

Gui, 77:Add, Button, X0 Y0 Hidden gSubHidenButton77_1, HidenButton(&N)

Gui, 77:Color,E0E8FF
;Gui, 77:Color, ,00F0FF
;Gui, 77:+AlwaysOnTop
Gui, 77:+Resize
;cen_removeBorderFromCommTitleFlag(77)



; コマンドのストック Sh+Ct+
guf_guiFontFromSizeAndName(fontNum, StO_fontNameAll, 78)
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_commStock2BackgName, "X0 Y0", 78)
Gui, 78:Add, Picture, X10 Y10 w32 h32  vPicture78_1 gSubPicture78_1
Gui, 78:Add, Text,      x+5 yp+0,(&1)
Gui, 78:Add, Edit,      x+5 yp+0 w190 vEdit78_1 gSubEdit78_1
Gui, 78:Add, Picture, X10 y+10 w32 h32  vPicture78_2 gSubPicture78_2
Gui, 78:Add, Text,      x+5 yp+0,(&2)
Gui, 78:Add, Edit,      x+5 yp+0 w190 vEdit78_2 gSubEdit78_2
Gui, 78:Add, Picture, X10 y+10 w32 h32  vPicture78_3 gSubPicture78_3
Gui, 78:Add, Text,      x+5 yp+0 ,(&3)
Gui, 78:Add, Edit,      x+5 yp+0 w190 vEdit78_3 gSubEdit78_3
Gui, 78:Add, Picture, X10 y+10 w32 h32  vPicture78_4 gSubPicture78_4
Gui, 78:Add, Text,      x+5 yp+0 ,(&4)
Gui, 78:Add, Edit,      x+5 yp+0 w190 vEdit78_4 gSubEdit78_4
Gui, 78:Add, Picture, X10 y+10 w32 h32  vPicture78_5 gSubPicture78_5
Gui, 78:Add, Text,      x+5 yp+0 ,(&5)
Gui, 78:Add, Edit,      x+5 yp+0 w190 vEdit78_5 gSubEdit78_5
Gui, 78:Add, Picture, X10 y+10 w32 h32  vPicture78_6 gSubPicture78_6
Gui, 78:Add, Text,      x+5 yp+0 ,(&6)
Gui, 78:Add, Edit,      x+5 yp+0 w190 vEdit78_6 gSubEdit78_6
Gui, 78:Add, Picture, X10 y+10 w32 h32  vPicture78_7 gSubPicture78_7
Gui, 78:Add, Text,      x+5 yp+0 ,(&7)
Gui, 78:Add, Edit,      x+5 yp+0 w190 vEdit78_7 gSubEdit78_7
Gui, 78:Add, Picture, X10 y+10 w32 h32  vPicture78_8 gSubPicture78_8
Gui, 78:Add, Text,      x+5 yp+0 ,(&8)
Gui, 78:Add, Edit,      x+5 yp+0 w190 vEdit78_8 gSubEdit78_8
Gui, 78:Add, Picture, X10 y+10 w32 h32  vPicture78_9 gSubPicture78_9
Gui, 78:Add, Text,      x+5 yp+0 ,(9)
Gui, 78:Add, Edit,      x+5 yp+0 w190 vEdit78_9 gSubEdit78_9
Gui, 78:Add, Picture, X10 y+10 w32 h32  vPicture78_10 gSubPicture78_10
Gui, 78:Add, Text,      x+5 yp+0 ,(10)
Gui, 78:Add, Edit,      x+5 yp+0 w180 vEdit78_10 gSubEdit78_10

Gui, 78:Add, Text,    X30 y+10,  リスト名(&T)
Gui, 78:Add, Edit,      x+5 yp+0  w135 Center  vEdit78_11

guf_guiFontFromSizeAndName(fontNum2, "", 78)
Gui, 78:Add, Button,  X10 y+10 w%tmpNumW%  gSubButton78_1, Load(&L)

Gui, 78:Add, Text,      x+10 yp+0,    リスト(&E)
Gui, 78:Add, ListBox,   xp+0 y+5 w170  R8 AltSubmit vListBox78_1, タイプ1||タイプ2|タイプ3|タイプ4|タイプ5|タイプ6|タイプ7|タイプ8|タイプ9|タイプ10|タイプ11|タイプ12|タイプ13|タイプ14|タイプ15|タイプ16|タイプ17|タイプ18|タイプ19|タイプ20

Gui, 78:Add, Button,  X10 yp+50 w%tmpNumW%  gSubButton78_3, Save(&S)
;Gui, 78:Font, S%fontNum3%
;Gui, 78:Add, Button,  X10 y+20  w%tmpNumW%  gSubButton78_2, LoadReLoad(&O)
;Gui, 78:Add, Button,  X10 y+10  w%tmpNumW%  gSubButton78_4, SaveReLoad(&R)
;Gui, 78:Font, S%fontNum2%

Gui, 78:Add, Button, X0 Y0 Hidden gSubHidenButton78_1, HidenButton(&N)

Gui, 78:Color,90FF2E
;Gui, 78:Color, ,00F0FF
;Gui, 78:+AlwaysOnTop
Gui, 78:+Resize
;cen_removeBorderFromCommTitleFlag(78)



;  ホットキーの登録
fontNum := cen_fontNumFromDpiAndFontSize(11, 10, 9)
guf_guiFontFromSizeAndName(fontNum, StO_fontNameAll, 79)
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_entryHotkeyBackgName, "X0 Y0", 79)
tmpNumW := cen_anyOfNumFromDpiAndFontSize(15, 18, 200, 220, 240)
Gui, 79:Add, Text,   X20  Y5 w%tmpNumW% vText79_1, キー名(&K)
tmpNumW := cen_anyOfNumFromDpiAndFontSize(14, 16, 180, 200, 220)
Gui, 79:Add, Edit,   X10  y+5 w%tmpNumW%  vEdit79_1

tmpNumW := cen_anyOfNumFromDpiAndFontSize(19, 23, 320, 340, 360)
Gui, 79:Add, Text,   X20 y+10 w%tmpNumW%  vText79_2  ,実行スクリプト(&L)
Gui, 79:Add, Edit,   X10 y+5 w%tmpNumW%   vEdit79_2

Gui, 79:Add, Text,   X20 y+20 , 一時的にのみ保存
Gui, 79:Add, Checkbox,  x+5 yp+0   vCheckbox79_1, (&U)
Gui, 79:Add, Button, X100 y+5 Default gSubButton79_1, OK(&O)
Gui, 79:Add, Button,  x+10 yp+0 gSubButton79_2, Cancel
Gui, 79:Add, Text,   X20 y+5, 説明(&M)
Gui, 79:Add, Edit,   X10 y+5 w250    vBoxEdit79_1  R6 VScroll

Gui, 79:Add, Text,   X20 y+10   ,キー入力補助(&H)
tmpNumW := cen_anyOfNumFromDpiAndFontSize(14, 16, 160, 140, 120)
Gui, 79:Add, Hotkey,  X10 y+10 w%tmpNumW% vHotkey79_1 gSubHotkey79_1 Limit1

Gui, 79:Add, Checkbox, X0 Y0  Hidden  Disabled  vHiddenCheckbox79_1	;0新規作成  1編集
Gui, 79:Add, Edit,     X0 Y0  Hidden  Disabled  vHiddenEdit79_1		; アイテム名の変更用

Gui, 79:+Resize
Gui, 79:-MaximizeBox



; 80 は ショートカットキーの一覧






; 特殊な設定
fontNum := cen_fontNumFromDpiAndFontSize(12, 10, 8)
tmpNumW := cen_anyOfNumFromDpiAndFontSize(3, 5, 30, 40, 50)
guf_guiFontFromSizeAndName(fontNum, StO_fontNameAll, 81)

Gui, 81:Add, Checkbox, X10 Y10 vCheckbox81_1 ,(&P)
Gui, 81:Add, Text,      x+5 yp+0 , コマンドの実行過程を表示する

fontNum := cen_fontNumFromDpiAndFontSize(9, 8, 7)
guf_guiFontFromSizeAndName(fontNum, "", 81)
tmpNumW := cen_anyOfNumFromDpiAndFontSize(5, 7, 70, 80, 90)
Gui, 81:Add, Button,  X30 y+10  w%tmpNumW% Default gSubButton81_1, OK(&O)
Gui, 81:Add, Button,    x+10 yp+0  w%tmpNumW% gSubButton81_2, Cancel(&C)




; 二行以上のスクリプト
fontNum := cen_fontNumFromDpiAndFontSize(12, 10, 8)
guf_guiFontFromSizeAndName(fontNum, StO_fontNameAll, 82)
;guf_Gui("Font", 82, glob_needReloadIniExplainFontOption, glob_needReloadIniExplainFontName)
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_multipleComm1BackgName, "X0 Y0", 82)

Gui, 82:Add, Text,   X20  Y10, 二行以上のテキスト
Gui, 82:Add, Edit, X10 y+5  w300 h220 vBoxEdit82_1 Multi T16 -Wrap VScroll HScroll HwndgGlob_hwndBoxEdit82_1
tmpNumW := cen_anyOfNumFromDpiAndFontSize(5, 7, 70, 90, 110)
Gui, 82:Add, Button, X20 y+10 w%tmpNumW%  vButton82_1  gSubButton82_1, 実行(&O)
Gui, 82:Add, Button,   x+70 yp+0 w%tmpNumW% vButton82_2  gSubButton82_2, 登録(&S)
Gui, 82:+Resize
Gui, 82:Color, 00FFC9
;cen_removeBorderFromCommTitleFlag(82)



; 二行以上のスクリプトのアイテム
fontNum := cen_fontNumFromDpiAndFontSize(11, 10, 9)
guf_guiFontFromSizeAndName(fontNum, StO_fontNameAll, 83)
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_entryMultipleBackgName, "X0 Y30", 83)

tmpNumW := cen_anyOfNumFromDpiAndFontSize(12, 27, 350, 370, 390)
tmpNumH := cen_anyOfNumFromDpiAndFontSize(32, 32, 580, 600, 620)
Gui, 83:Add, Tab2, X0 Y5 w%tmpNumW% h%tmpNumH% vTab83_1, 登録１|登録２

Gui, 83:Tab, 1

tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(15, 18, 200, 180, 160)
Gui, 83:Add, Picture,X20 Y50 w32 h32 vPicture83_1_1
Gui, 83:Add, Text,   X80  yp+0 w%tmpNumW2% vText83_1_1, アイテム名(&E)
tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(14, 16, 180, 160, 140)
Gui, 83:Add, Edit,    xp+0  y+5 w%tmpNumW2%  vEdit83_1_1
tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(17, 21, 290, 310, 330)
Gui, 83:Add, Text,   X20 y+10 w%tmpNumW2%  vText83_1_2,スクリプト(&L)
Gui, 83:Add, Edit,   X10 y+5 w%tmpNumW2%    vBoxEdit83_1_1 Multi R16 T16 -Wrap VScroll HScroll

Gui, 83:Add, Button,  X30 y+20 gSubButton83_1_4, 実行しても履歴に加えない(&R)

Gui, 83:Add, Button,  X150 y+30 gSubButton83_1_3, 一行のアイテム(&1)

Gui, 83:Add, Checkbox,X10 y+20  vCheckbox83_1_1, (&U)
Gui, 83:Add, Text,       x+5 yp+0 , 一時的にのみ保存

Gui, 83:Add, Button, X100 y+5 Default gSubButton83_1_1, 登録(&O)
Gui, 83:Add, Button,  x+10 yp+0 gSubButton83_1_2, Cancel

Gui, 83:Tab, 2

Gui, 83:Add, Picture,X20 Y50 w32 h32 vPicture83_2_1
Gui, 83:Add, Text,   X10 y+5 , アイコンのファイルを指定(&I)
Gui, 83:Add, Edit,   X10 y+5   w%tmpNumW2% vEdit83_1_2   gSubEdit83_1_2
tmpNumW3 := cen_anyOfNumFromDpiAndFontSize(2, 4, 60, 70, 80)
Gui, 83:Add, Edit, X10 y+5  w%tmpNumW3% Number  vUpDown83_1_1  gSubUpDown83_1_1
Gui, 83:Add, UpDown, Range1-50 128, 1

Gui, 83:Add, Text,   X10 y+30, 説明を記入する(&M)
Gui, 83:Add, Edit,   X10 y+5 w250    vBoxEdit83_1_2  R6 VScroll

Gui, 83:Add, Checkbox, X0 Y0  Hidden  Disabled  vHiddenCheckbox83_1_1	;0新規作成  1編集
Gui, 83:Add, Edit,     X0 Y0  Hidden  Disabled  vHiddenEdit83_1_1		; アイテム名の変更用
Gui, 83:+Resize
;cen_removeBorderFromCommTitleFlag(83)



; 最後の文字によって、自動的に実行する。
tmpNumGroupW := cen_anyOfNumFromDpiAndFontSize(36, 38, 610, 640, 670)
tmpNumGroupH := cen_anyOfNumFromDpiAndFontSize(17, 23, 600, 620, 640)
tmpNumStartY := cen_anyOfNumFromDpiAndFontSize(2, 4, 50, 55, 60)

tmpNumW := cen_anyOfNumFromDpiAndFontSize(8, 10, 120, 140, 160)
tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(16, 20, 350, 370, 390)

fontNum := cen_fontNumFromDpiAndFontSize(9, 8, 7)
guf_guiFontFromSizeAndName(fontNum, StO_fontNameAll, 84)
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_lastWordBackgName, "X0 Y50", 84)
tmpNumW3 := cen_anyOfNumFromDpiAndFontSize(4, 8, 90, 100, 110)
;tmpNumY := tmpNumGroupH + 20
;Gui, 84:Add, Button,  X30 y%tmpNumY%  w%tmpNumW3%  Default gSubButton84_1 , OK(&O)
;Gui, 84:Add, Button,    x+10 yp+0  w%tmpNumW3% gSubButton84_2 , Cancel(&C)


;Gui, 84:Add, Tab2, X0 Y5 w%tmpNumGroupW% h%tmpNumGroupH% vTab84_1, 項目１|項目２|項目３|項目４|項目５|項目６
Gui, 84:Add, Tab2, X0 Y5 w%tmpNumGroupW% h%tmpNumGroupH% vTab84_1, 項目１|項目２|項目３|項目４|項目５|途中文字１|設定

fontNum := cen_fontNumFromDpiAndFontSize(12, 10, 8)
fontNum2 := cen_fontNumFromDpiAndFontSize(10, 9, 8)
guf_guiFontFromSizeAndName(fontNum, "", 84)

Gui, 84:Tab, 1

Gui, 84:Add, Checkbox,X10 Y%tmpNumStartY%   vCheckbox84_1 gSubCheckbox84_1,(&A)
Gui, 84:Add, Text,      x+5 yp+0 , 最後の文字で、自動的に実行する。（項目１の分のみ）


Gui, 84:Add, Checkbox, X30 y+30     vCheckbox84_2 ,(&E)
Gui, 84:Add, Edit,      x+5 yp+0  w%tmpNumW%  vEdit84_2  Limit20   ; ,  ok
Gui, 84:Add, Text,        x+5 yp+5, で、Enterを自動的に実行する。

Gui, 84:Add, Edit,     X120 y+5 w%tmpNumW%  vEdit84_6  Limit20   ; ,  ok
Gui, 84:Add, Text,      x+5 yp+5, もう一つのEnter（上のと同じ処理）


Gui, 84:Add, Checkbox, X30 y+10   vCheckbox84_3 ,(&T)
Gui, 84:Add, Edit,      x+5 yp+0 w%tmpNumW%  vEdit84_3  Limit20   ; ,  ctr
Gui, 84:Add, Text,        x+5 yp+5, で、Ctrl+1、Ctrl+2 などを自動的に実行する。`n（例　青 で設定したら、`n　　　青1 や 青2 などで実行できる。）


Gui, 84:Add, Checkbox, X30 y+10   vCheckbox84_4 ,(&S)
Gui, 84:Add, Edit,      x+5 yp+0 w%tmpNumW%  vEdit84_4  Limit20   ; ,  shctr
Gui, 84:Add, Text,        x+5 yp+5, で、Shift+Ctrl+1、Shift+Ctrl+2`nなどを自動的に実行する。`n（例　緑 で設定したら、`n　　　緑1 や 緑2 などで実行できる。）


Gui, 84:Add, Checkbox, X30 y+10   vCheckbox84_8 ,(&B)
Gui, 84:Add, Edit,      x+5 yp+0  w%tmpNumW%  vEdit84_8  Limit20   ; ,  テキストの
Gui, 84:Add, Text,        x+5 yp+5, で、別のテキストを利用して自動的に実行する。`n（例　別のテキスト で設定したら、`n　　　別のテキスト1～3 は 一行テキスト。`n　　　別のテキスト4 か 5 は`n　　　分割テキストを利用して実行。）


Gui, 84:Add, Checkbox, X30 y+10   vCheckbox84_5 ,(&P)
Gui, 84:Add, Edit,      x+5 yp+0  w%tmpNumW%  vEdit84_5  Limit20   ; ,  ctrspace
Gui, 84:Add, Text,        x+5 yp+5  , で、入力補完を最後の文字で表示する。

Gui, 84:Add, Checkbox, X30 y+10   vCheckbox84_7 ,(&L)
Gui, 84:Add, Edit,      x+5 yp+0  w%tmpNumW%  vEdit84_7  Limit20   ; ,  けす
Gui, 84:Add, Text,        x+5 yp+5  , で、入力中の文字を全部消す。


Gui, 84:Add, Checkbox, X30 y+10   vCheckbox84_9 ,(&H)
Gui, 84:Add, Edit,      x+5 yp+0  w%tmpNumW%  vEdit84_9  Limit20   ; ,  しっぽ
Gui, 84:Add, Text,        x+5 yp+5  , で、最後の引数を先頭にして実行する。`n（＆lastAsHeadExecute を実行する）

Gui, 84:Add, Checkbox, X30 y+15   vCheckbox84_10 ,(&N)
Gui, 84:Add, Edit,      x+5 yp+0  w%tmpNumW%  vEdit84_10  Limit20   ; ,  空白
Gui, 84:Add, Text,        x+5 yp+5  , で、半角スペースを付け足す

guf_guiFontFromSizeAndName(fontNum2, "", 84)
Gui, 84:Add, Button,  X30 y+30  w%tmpNumW3%  Default gSubButton84_1 , OK(&O)
Gui, 84:Add, Button,    x+10 yp+0  w%tmpNumW3% gSubButton84_2 , Cancel(&C)


guf_guiFontFromSizeAndName(fontNum, "", 84)

Gui, 84:Tab, 2

Gui, 84:Add, Checkbox,X10 Y%tmpNumStartY%   vCheckbox84_2_1 gSubCheckbox84_2_1
Gui, 84:Add, Text,      x+5 yp+0 , 最後の文字で、自動的に実行する。（項目２の分のみ）

Gui, 84:Add, Text,  X30 y+15, 指定した内容を先頭にして実行する。`n（文字がカラなら何もせずスルーする）

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_2_1_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　１つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_2_1_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_2_2_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5,  で実行。　２つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_2_2_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_2_3_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　３つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_2_3_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_2_4_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　４つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_2_4_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_2_5_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　５つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_2_5_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_2_6_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　６つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_2_6_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_2_7_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　７つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_2_7_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_2_8_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　８つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_2_8_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_2_9_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　９つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_2_9_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_2_10_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　１０つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_2_10_1  Limit255


Gui, 84:Tab, 3

Gui, 84:Add, Checkbox,X10 Y%tmpNumStartY%   vCheckbox84_3_1 gSubCheckbox84_3_1
Gui, 84:Add, Text,      x+5 yp+0 , 最後の文字で、自動的に実行する。（項目３の分のみ）

Gui, 84:Add, Text,  X30 y+15, 指定した内容を先頭にして実行する。`n（文字がカラなら何もせずスルーする）

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_3_1_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　１つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_3_1_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_3_2_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5,  で実行。　２つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_3_2_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_3_3_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　３つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_3_3_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_3_4_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　４つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_3_4_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_3_5_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　５つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_3_5_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_3_6_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　６つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_3_6_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_3_7_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　７つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_3_7_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_3_8_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　８つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_3_8_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_3_9_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　９つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_3_9_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_3_10_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　１０つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_3_10_1  Limit255


Gui, 84:Tab, 4

Gui, 84:Add, Checkbox,X10 Y%tmpNumStartY%   vCheckbox84_4_1 gSubCheckbox84_4_1
Gui, 84:Add, Text,      x+5 yp+0 , 最後の文字で、自動的に実行する。（項目４の分のみ）

Gui, 84:Add, Text,  X30 y+15, 指定した内容を先頭にして実行する。`n（文字がカラなら何もせずスルーする）

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_4_1_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　１つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_4_1_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_4_2_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5,  で実行。　２つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_4_2_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_4_3_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　３つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_4_3_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_4_4_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　４つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_4_4_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_4_5_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　５つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_4_5_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_4_6_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　６つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_4_6_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_4_7_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　７つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_4_7_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_4_8_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　８つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_4_8_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_4_9_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　９つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_4_9_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_4_10_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　１０つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_4_10_1  Limit255



Gui, 84:Tab, 5

Gui, 84:Add, Checkbox,X10 Y%tmpNumStartY%   vCheckbox84_5_1 gSubCheckbox84_5_1
Gui, 84:Add, Text,      x+5 yp+0 , 最後の文字で、自動的に実行する。（項目５の分のみ）

Gui, 84:Add, Text,  X30 y+15, 指定した内容を先頭にして実行する。`n（文字がカラなら何もせずスルーする）

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_5_1_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　１つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_5_1_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_5_2_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5,  で実行。　２つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_5_2_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_5_3_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　３つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_5_3_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_5_4_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　４つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_5_4_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_5_5_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　５つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_5_5_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_5_6_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　６つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_5_6_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_5_7_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　７つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_5_7_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_5_8_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　８つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_5_8_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_5_9_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　９つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_5_9_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_5_10_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　１０つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_5_10_1  Limit255


Gui, 84:Tab, 6

Gui, 84:Add, Text,   X30 Y%tmpNumStartY% , この項目は、最後の文字ではなく、`nテキスト上に指定の文字が含まれていた時に自動的に実行する。

Gui, 84:Add, Checkbox,X50 y+20  vCheckbox84_sendEnd
Gui, 84:Add, Edit,      x+5 yp+0 w%tmpNumW%  vEdit84_sendEnd Limit20
Gui, 84:Add, Text,      x+5 yp+0 , で、カーソルを右端の位置に移動する。

Gui, 84:Add, Checkbox,X10 y+40  vCheckbox84_6_1 gSubCheckbox84_6_1
Gui, 84:Add, Text,      x+5 yp+0 , 以下の文字があると、自動的に実行する。（途中文字１の分のみ）

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_6_1_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　１つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_6_1_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_6_2_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5,  で実行。　２つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_6_2_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_6_3_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　３つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_6_3_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_6_4_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　４つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_6_4_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_6_5_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　５つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_6_5_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_6_6_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　６つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_6_6_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_6_7_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　７つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_6_7_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_6_8_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　８つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_6_8_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_6_9_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　９つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_6_9_1  Limit255

Gui, 84:Add, Edit,    X30 y+15 w%tmpNumW%  vEdit84_6_10_2  Limit20
Gui, 84:Add, Text,      x+5 yp+5 , で実行。　１０つめ。実行する処理
Gui, 84:Add, Edit,      x+5 yp-5  w%tmpNumW2%  vEdit84_6_10_1  Limit255


Gui, 84:Tab, 7

Gui, 84:Add, Text,   X30 Y%tmpNumStartY% , 最後の文字で実行する項目の設定。

Gui, 84:Add, Checkbox,X10 y+30  vCheckbox84_7_num
Gui, 84:Add, Text,      x+5 yp+0 , テキストの右端の文字が全角の数字なら、`n半角の数字に変換して再検証する

Gui, 84:Add, Checkbox,X10 y+50  vCheckbox84_7_1 gSubCheckbox84_7_1
Gui, 84:Add, Text,      x+0 yp+0 , テキストの右端が
Gui, 84:Add, Edit,      x+10 yp-5 w%tmpNumW3%  vEdit84_7_1_2 Limit20
Gui, 84:Add, Edit,      x+10 yp+0 w%tmpNumW3%  vEdit84_7_1_3 Limit20
Gui, 84:Add, Edit,      x+10 yp+0 w%tmpNumW3%  vEdit84_7_1_4 Limit20
Gui, 84:Add, Text,   X80 y+10 , なら、
Gui, 84:Add, Edit,      x+5 yp-5 w%tmpNumW3%   vEdit84_7_1_1 Limit20
Gui, 84:Add, Text,      x+5 yp+5 , に変換して再検証する

Gui, 84:Add, Checkbox,X10 y+50  vCheckbox84_7_2 gSubCheckbox84_7_2
Gui, 84:Add, Text,      x+0 yp+0 , テキストの右端が
Gui, 84:Add, Edit,      x+10 yp-5 w%tmpNumW3%  vEdit84_7_2_2 Limit20
Gui, 84:Add, Edit,      x+10 yp+0 w%tmpNumW3%  vEdit84_7_2_3 Limit20
Gui, 84:Add, Edit,      x+10 yp+0 w%tmpNumW3%  vEdit84_7_2_4 Limit20
Gui, 84:Add, Text,   X80 y+10 , なら、
Gui, 84:Add, Edit,      x+5 yp-5 w%tmpNumW3%   vEdit84_7_2_1 Limit20
Gui, 84:Add, Text,      x+5 yp+5 , に変換して再検証する

Gui, 84:Add, Checkbox,X10 y+50  vCheckbox84_7_3 gSubCheckbox84_7_3
Gui, 84:Add, Text,      x+0 yp+0 , テキストの右端が
Gui, 84:Add, Edit,      x+10 yp-5 w%tmpNumW3%  vEdit84_7_3_2 Limit20
Gui, 84:Add, Edit,      x+10 yp+0 w%tmpNumW3%  vEdit84_7_3_3 Limit20
Gui, 84:Add, Edit,      x+10 yp+0 w%tmpNumW3%  vEdit84_7_3_4 Limit20
Gui, 84:Add, Text,   X80 y+10 , なら、
Gui, 84:Add, Edit,      x+5 yp-5 w%tmpNumW3%   vEdit84_7_3_1 Limit20
Gui, 84:Add, Text,      x+5 yp+5 , に変換して再検証する

Gui, 84:+Resize



fontNum := cen_fontNumFromDpiAndFontSize(12, 11, 10)
; 再起動が必要な設定
guf_guiFontFromSizeAndName(fontNum, StO_fontNameAll, 85)
Gui, 85:Add, Text,   X10 Y10 cFF0000, 「注意」この項目は OK を押すと再起動する。
Gui, 85:Add, Checkbox,  X10 y+10   vCheckbox85_1 ,(&T)
Gui, 85:Add, Text,       x+5 yp+0 , テキストのウインドウの`nウインドウタイトルを表示しない
Gui, 85:Add, Checkbox,  X10 y+20   vCheckbox85_2 ,(&M)
Gui, 85:Add, Text,       x+5 yp+0 , テキストのウインドウのメニューを表示しない

tmpNumGroupW := cen_anyOfNumFromDpiAndFontSize(20, 25, 420, 440, 460)
tmpNumGroupH := cen_anyOfNumFromDpiAndFontSize(12, 10, 240, 260, 280)
Gui, 85:Add, GroupBox, X10 y+10  w%tmpNumGroupW% h%tmpNumGroupH%
Gui, 85:Add, Text,      X30 yp+15 , ソフト全体のフォントのサイズ(&S)
tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(9, 12, 130, 150, 170)
Gui, 85:Add, DropDownList,  x+10 yp+0 w%tmpNumW2% vDropDownList85_1 AltSubmit R8,かなり小さく|小さく|やや小さく|標準|やや大きく|大きく|かなり大きく|さらに大きく
Gui, 85:Add, Text,      X30 y+10 , ソフト全体のフォント名を指定(&F)
Gui, 85:Add, Edit,     x+10 yp-5 w%tmpNumW2%  vEdit85_7

tmpStr := "Gui , Font ,"
tmpStr2 := ","
Gui, 85:Add, Text,   X30 y+25 , テキストのフォント(&A)
Gui, 85:Add, Text,   X80 y+5 , %tmpStr%
tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(8, 10, 100, 115, 130)
Gui, 85:Add, Edit,     x+5 yp-5 w%tmpNumW2%  vEdit85_1
Gui, 85:Add, Text,     x+5 yp+5 , %tmpStr2%
Gui, 85:Add, Edit,     x+5 yp-5 w%tmpNumW2%  vEdit85_2

Gui, 85:Add, Text,   X30 y+5 , 分割テキストのフォント(&B)
Gui, 85:Add, Text,   X80 y+5 , %tmpStr%
Gui, 85:Add, Edit,     x+5 yp-5 w%tmpNumW2%  vEdit85_3
Gui, 85:Add, Text,     x+5 yp+5 , %tmpStr2%
Gui, 85:Add, Edit,     x+5 yp-5 w%tmpNumW2%  vEdit85_4

Gui, 85:Add, Text,   X30 y+5 , 説明表示のフォント(&E)
Gui, 85:Add, Text,   X80 y+5 , %tmpStr%
Gui, 85:Add, Edit,     x+5 yp-5 w%tmpNumW2%  vEdit85_5
Gui, 85:Add, Text,     x+5 yp+5 , %tmpStr2%
Gui, 85:Add, Edit,     x+5 yp-5 w%tmpNumW2%  vEdit85_6


fontNum := cen_fontNumFromDpiAndFontSize(10, 9, 8)
guf_guiFontFromSizeAndName(fontNum, "", 85)
Gui, 85:Add, Button,  X30 y+30  w%tmpNumW3%  Default gSubButton85_1 , OK(&O)
Gui, 85:Add, Button,    x+10 yp+0  w%tmpNumW3% gSubButton85_2 , Cancel(&C)




; userフォルダを通さない設定
tmpNumGroupW := cen_anyOfNumFromDpiAndFontSize(20, 26, 430, 450, 470)
tmpNumGroupH := cen_anyOfNumFromDpiAndFontSize(23, 30, 490, 530, 570)
tmpNumStartY := cen_anyOfNumFromDpiAndFontSize(2, 4, 50, 55, 60)

fontNum2 := cen_fontNumFromDpiAndFontSize(9, 8, 7)
guf_guiFontFromSizeAndName(fontNum2, StO_fontNameAll, 86)
tmpNumW3 := cen_anyOfNumFromDpiAndFontSize(5, 7, 70, 80, 90)
tmpNumY := tmpNumGroupH + 20
Gui, 86:Add, Button,  X30 y%tmpNumY%  w%tmpNumW3%  Default gSubButton86_1 , OK(&O)
Gui, 86:Add, Button,    x+10 yp+0  w%tmpNumW3% gSubButton86_2 , Cancel(&C)

fontNum := cen_fontNumFromDpiAndFontSize(12, 11, 10)
guf_guiFontFromSizeAndName(fontNum, "", 86)
Gui, 86:Add, Tab2, X0 Y5 w%tmpNumGroupW% h%tmpNumGroupH% vTab86_1, 設定１|設定２
Gui, 86:Tab, 1

Gui, 86:Add, Text,   X10 Y%tmpNumStartY% cFF0000, 「注意」この項目は OK を押すと再起動する。

Gui, 86:Add, Text,     X20  y+20 , このソフト自体のウインドウタイトルを設定する`n（ショートカットキーに影響を与える）
Gui, 86:Add, Text,     X20  y+5 , (カラなら設定しない)(&W)
tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(9, 12, 180, 190, 200)
Gui, 86:Add, Edit,      x+10  yp+0 w%tmpNumW2%  vEdit86_6

tmpNumGroupW := cen_anyOfNumFromDpiAndFontSize(22, 27, 380, 400, 420)
tmpNumGroupH := cen_anyOfNumFromDpiAndFontSize(15, 15, 210, 225, 240)
tmpNumW3 := cen_anyOfNumFromDpiAndFontSize(6, 8, 100, 120, 130)
tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(16, 20, 310, 330, 350)
Gui, 86:Add, GroupBox, X10 y+5  w%tmpNumGroupW% h%tmpNumGroupH%
Gui, 86:Add, Checkbox,  xp+10 yp+15   vCheckbox86_1 gSubCheckbox86_1,(&B)
Gui, 86:Add, Text,       x+5 yp+0 , 各種基準のフォルダを変更する
Gui, 86:Add, Text,     X50  y+10 , userフォルダを変更する(&U)
Gui, 86:Add, Edit,      xp+0  y+5 w%tmpNumW2%  vEdit86_1
guf_guiFontFromSizeAndName(fontNum2, "", 86)
Gui, 86:Add, Button,     xp+0 y+5 w%tmpNumW3% gSubButton86_3, フォルダ(&F)
Gui, 86:Add, Button,      x+10 yp+0 w%tmpNumW3% gSubButton86_4, 相対パス(&R)
Gui, 86:Add, Button,      x+10 yp+0 w%tmpNumW3% gSubButton86_5, 絶対パス(&A)
guf_guiFontFromSizeAndName(fontNum, "", 86)
Gui, 86:Add, Text,     X50 y+5  ,docフォルダを変更する(&P)
Gui, 86:Add, Edit,      xp+0 y+5 w%tmpNumW2%   vEdit86_2
tmpNumW := cen_anyOfNumFromDpiAndFontSize(9, 13, 180, 200, 220)
guf_guiFontFromSizeAndName(fontNum2, "", 86)
Gui, 86:Add, Button,     xp+80 y+5 w%tmpNumW% gSubButton86_6, 元のフォルダに戻す(&D)
guf_guiFontFromSizeAndName(fontNum, "", 86)

tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(18, 22, 350, 370, 390)
Gui, 86:Add, Text,     X20 y+40 , 起動時に実行する処理３
Gui, 86:Add, Text,        xp+0  y+5 ,（こちらも起動時のパラメーターは無効）(&3)
Gui, 86:Add, Edit,        xp+0  y+5 w%tmpNumW2%  vEdit86_5


Gui, 86:Tab, 2
Gui, 86:Add, Text,   X10 Y%tmpNumStartY% cFF0000, 「注意」この項目は OK を押すと再起動する。

tmpNumGroupH := cen_anyOfNumFromDpiAndFontSize(8, 13, 180, 200, 220)
;tmpNumW3 := cen_anyOfNumFromDpiAndFontSize(6, 8, 80, 90, 100)
tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(1, 4, 60, 70, 80)
Gui, 86:Add, GroupBox, X10 y+5  w%tmpNumGroupW% h%tmpNumGroupH%
Gui, 86:Add, Checkbox,  xp+10 yp+15   vCheckbox86_2_1
Gui, 86:Add, Text,       x+5 yp+0 , テキスト入力欄の長さを自動的に変えない
Gui, 86:Add, Text,     X20  y+20 cFFA23E, なお、以下の設定は`n一行テキストのウインドウにのみ`n効果があり、分割テキストなどには無効

Gui, 86:Add, Text,     X50  y+10 , 入力欄の規定の長さ
Gui, 86:Add, Edit,       x+30  yp+0 w%tmpNumW2% Limit4 Number vUpDown86_2_1
Gui, 86:Add, UpDown, Range-0-1370 128, 150

Gui, 86:Add, Text,     X50  y+10 , ウインドウの規定の幅
Gui, 86:Add, Edit,       x+30  yp+0 w%tmpNumW2% Limit4 Number vUpDown86_2_2
Gui, 86:Add, UpDown, Range100-1400 128, 212

Gui, 86:Add, Text,     X20  y+35 , 「テキスト」の呼び方を変える
Gui, 86:Add, Edit,       x+10  yp-5 w%tmpNumW3% Limit20 vEdit86_2_1
Gui, 86:Add, Text,     X20  y+10 , 「分割テキスト」の呼び方を変える
Gui, 86:Add, Edit,       x+10  yp-5 w%tmpNumW3% Limit20 vEdit86_2_2

Gui, 86:Add, Checkbox, X20 y+20   vCheckbox86_4 ,(&S)
Gui, 86:Add, Text,       x+5 yp+0 , 規定のキーをオフにする
Gui, 86:Add, Checkbox, X20 y+10   vCheckbox86_5
Gui, 86:Add, Text,       x+5 yp+0 , 規定のキー以外の初期キーをオフにする

Gui, 86:Add, Checkbox, X20 y+20   vCheckbox86_3 ,(&G)
Gui, 86:Add, Text,       x+5 yp+0 , 起動時にテキスト１を表示させ、`nテキスト１を閉じると`nソフトを終了するようにする。



fontNum := cen_fontNumFromDpiAndFontSize(12, 10, 8)
fontNum2 := cen_fontNumFromDpiAndFontSize(10, 9, 7)
tmpNumW := cen_anyOfNumFromDpiAndFontSize(11, 16, 150, 170, 190)
tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(6, 10, 140, 160, 180)
tmpNumW3 := cen_anyOfNumFromDpiAndFontSize(4, 7, 60, 70, 80)
; タイマー
guf_guiFontFromSizeAndName(fontNum, StO_fontNameAll, 87)
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_timerBackgName, "X0 Y0", 87)
Gui, 87:Add, Text, X10 Y10 w%tmpNumW% vText87_1_1 , タイマー1
Gui, 87:Add, Text,   x+5 yp+0  w%tmpNumW2%  vText87_1_2
guf_guiFontFromSizeAndName(fontNum2, "", 87)
Gui, 87:Add, Button, x+5 yp+0  w%tmpNumW3% gSubButton87_1, 中止
guf_guiFontFromSizeAndName(fontNum, "", 87)
Gui, 87:Add, Edit, X50 y+3  w242  vEdit87_1_3 ReadOnly


Gui, 87:Add, Text, X10 y+15 w%tmpNumW% vText87_2_1 , タイマー2
Gui, 87:Add, Text,   x+5 yp+0  w%tmpNumW2%  vText87_2_2 
guf_guiFontFromSizeAndName(fontNum2, "", 87)
Gui, 87:Add, Button, x+5 yp+0  w%tmpNumW3% gSubButton87_2 , 中止
guf_guiFontFromSizeAndName(fontNum, "", 87)
Gui, 87:Add, Edit, X50 y+3  w242  vEdit87_2_3 ReadOnly


Gui, 87:Add, Text, X10 y+15 w%tmpNumW% vText87_3_1 , タイマー3
Gui, 87:Add, Text,   x+5 yp+0  w%tmpNumW2%  vText87_3_2 
guf_guiFontFromSizeAndName(fontNum2, "", 87)
Gui, 87:Add, Button, x+5 yp+0  w%tmpNumW3% gSubButton87_3 , 中止
guf_guiFontFromSizeAndName(fontNum, "", 87)
Gui, 87:Add, Edit, X50 y+3  w242  vEdit87_3_3 ReadOnly


Gui, 87:Add, Text, X10 y+15 w%tmpNumW% vText87_4_1 , タイマー4
Gui, 87:Add, Text,   x+5 yp+0  w%tmpNumW2%  vText87_4_2 
guf_guiFontFromSizeAndName(fontNum2, "", 87)
Gui, 87:Add, Button, x+5 yp+0  w%tmpNumW3% gSubButton87_4 , 中止
guf_guiFontFromSizeAndName(fontNum, "", 87)
Gui, 87:Add, Edit, X50 y+3  w242  vEdit87_4_3 ReadOnly


Gui, 87:Add, Text, X10 y+15 w%tmpNumW% vText87_5_1 , タイマー5
Gui, 87:Add, Text,   x+5 yp+0  w%tmpNumW2%  vText87_5_2 
guf_guiFontFromSizeAndName(fontNum2, "", 87)
Gui, 87:Add, Button, x+5 yp+0  w%tmpNumW3% gSubButton87_5 , 中止
guf_guiFontFromSizeAndName(fontNum, "", 87)
Gui, 87:Add, Edit, X50 y+3  w242  vEdit87_5_3 ReadOnly


Gui, 87:Add, Text, X10 y+15 w%tmpNumW% vText87_6_1 , タイマー6
Gui, 87:Add, Text,   x+5 yp+0  w%tmpNumW2%  vText87_6_2 
guf_guiFontFromSizeAndName(fontNum2, "", 87)
Gui, 87:Add, Button, x+5 yp+0  w%tmpNumW3% gSubButton87_6 , 中止
guf_guiFontFromSizeAndName(fontNum, "", 87)
Gui, 87:Add, Edit, X50 y+3  w242  vEdit87_6_3 ReadOnly


Gui, 87:Add, Text, X10 y+15 w%tmpNumW% vText87_7_1 , タイマー7
Gui, 87:Add, Text,   x+5 yp+0  w%tmpNumW2%  vText87_7_2 
guf_guiFontFromSizeAndName(fontNum2, "", 87)
Gui, 87:Add, Button, x+5 yp+0  w%tmpNumW3% gSubButton87_7 , 中止
guf_guiFontFromSizeAndName(fontNum, "", 87)
Gui, 87:Add, Edit, X50 y+3  w242  vEdit87_7_3 ReadOnly


Gui, 87:Add, Text, X10 y+15 w%tmpNumW% vText87_8_1 , タイマー8
Gui, 87:Add, Text,   x+5 yp+0  w%tmpNumW2%  vText87_8_2 
guf_guiFontFromSizeAndName(fontNum2, "", 87)
Gui, 87:Add, Button, x+5 yp+0  w%tmpNumW3% gSubButton87_8 , 中止
guf_guiFontFromSizeAndName(fontNum, "", 87)
Gui, 87:Add, Edit, X50 y+3  w242  vEdit87_8_3 ReadOnly


Gui, 87:Add, Text, X10 y+15 w%tmpNumW% vText87_9_1 , タイマー9
Gui, 87:Add, Text,   x+5 yp+0  w%tmpNumW2%  vText87_9_2 
guf_guiFontFromSizeAndName(fontNum2, "", 87)
Gui, 87:Add, Button, x+5 yp+0  w%tmpNumW3% gSubButton87_9 , 中止
guf_guiFontFromSizeAndName(fontNum, "", 87)
Gui, 87:Add, Edit, X50 y+3  w242  vEdit87_9_3 ReadOnly


Gui, 87:Add, Text, X10 y+15 w%tmpNumW% vText87_10_1 , タイマー10
Gui, 87:Add, Text,   x+5 yp+0  w%tmpNumW2%  vText87_10_2 
guf_guiFontFromSizeAndName(fontNum2, "", 87)
Gui, 87:Add, Button, x+5 yp+0  w%tmpNumW3% gSubButton87_10 , 中止
guf_guiFontFromSizeAndName(fontNum, "", 87)
Gui, 87:Add, Edit, X50 y+3  w242  vEdit87_10_3 ReadOnly

;Gui, 87:+AlwaysOnTop
Gui, 87:+Resize



fontNum := cen_fontNumFromDpiAndFontSize( 10, 9, 8 )
tmpNumW := cen_anyOfNumFromDpiAndFontSize(8, 10, 80, 100, 110)
; シャットダウンの
guf_guiFontFromSizeAndName(fontNum, StO_fontNameAll, 88)
Gui, 88:Add, Text,   X10 Y5  w%tmpNumW%  vText88_1, シャットダウン
Gui, 88:Add, Text,   X10 y+5  w%tmpNumW%  vText88_2
Gui, 88:Add, Button,   x+10 yp+0  w%tmpNumW2%  gSubButton88_1, 中止(&C)

Gui, 88:+AlwaysOnTop
Gui, 88:+Resize
Gui, 88:-MaximizeBox




fontNum := cen_fontNumFromDpiAndFontSize(10, 9, 8)
fontNum2 := cen_fontNumFromDpiAndFontSize(12, 11, 10)

tmpNumW := cen_anyOfNumFromDpiAndFontSize(27, 33, 520, 540, 560)
tmpNumH := cen_anyOfNumFromDpiAndFontSize(36, 36, 550, 570, 590)

tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(15, 19, 250, 270, 290)
tmpNumW3 := cen_anyOfNumFromDpiAndFontSize(14, 18, 190, 210, 230)

tmpNumR := guaf_anyOfNumFromDpi(20, 18, 16)
tmpNumR2 := guaf_anyOfNumFromDpi(7, 5, 3)

tmpNumStartY := cen_anyOfNumFromDpiAndFontSize(0, 6, 60, 80, 100)

guf_guiFontFromSizeAndName(fontNum, StO_fontNameAll, 89)
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_everInputBackgName, "X0 Y50", 89)
Gui, 89:Margin, X10 Y5
Gui, 89:Add, Tab2, X0 Y5 w%tmpNumW% h%tmpNumH% , 規定のコマンド|変数|特殊な単語|追加の単語|代入用の変数|設定用の変数|簡易入力
guf_guiFontFromSizeAndName(fontNum2, "", 89)

Gui, 89:Tab, 1
Gui, 89:Add, Text,    X10 Y%tmpNumStartY% , 規定のコマンド(&L)
Gui, 89:Add, ListBox, X10 y+5 w%tmpNumW2%  R%tmpNumR%  VScroll  vList89_1_1  gSubList89_1_1
Gui, 89:Add, Edit,    X10 y+5 w%tmpNumW2%  R%tmpNumR2%  Multi T8 VScroll  vBoxEdit89_1_1

Gui, 89:Tab, 2
Gui, 89:Add, Text,    X10 Y%tmpNumStartY% , 規定の変数(&L)
Gui, 89:Add, ListBox, X10 y+5 w%tmpNumW2%  R%tmpNumR%  VScroll  vList89_2_1  gSubList89_2_1
Gui, 89:Add, Edit,    X10 y+5 w%tmpNumW2%  R%tmpNumR2% Multi T8 VScroll  vBoxEdit89_2_1

Gui, 89:Tab, 3
Gui, 89:Add, Text,    X10 Y%tmpNumStartY% , 特殊な単語(&L)
Gui, 89:Add, ListBox, X10 y+5 w%tmpNumW2%  R%tmpNumR%  VScroll  vList89_3_1  gSubList89_3_1
Gui, 89:Add, Edit,    X10 y+5 w%tmpNumW2%  R%tmpNumR2%  Multi T8 VScroll  vBoxEdit89_3_1

Gui, 89:Tab, 4
Gui, 89:Add, Text,    X10 Y%tmpNumStartY% , addWordList.txtで追加された単語(&L)
Gui, 89:Add, ListBox, X10 y+5 w%tmpNumW2%  R%tmpNumR%  VScroll  vList89_4_1  gSubList89_4_1
Gui, 89:Add, Edit,    X10 y+5 w%tmpNumW2%  R%tmpNumR2% Multi T8 VScroll  vBoxEdit89_4_1

Gui, 89:Tab, 5
Gui, 89:Add, Text,    X10 Y%tmpNumStartY% , ユーザーが代入して使用できる変数(&L)
Gui, 89:Add, ListBox, X10 y+5 w%tmpNumW2%  R%tmpNumR%  VScroll  vList89_5_1  gSubList89_5_1
Gui, 89:Add, Edit,    X10 y+5 w%tmpNumW2%  R%tmpNumR2% Multi T8 VScroll  vBoxEdit89_5_1

Gui, 89:Tab, 6
Gui, 89:Add, Text,    X10 Y%tmpNumStartY% , 設定用のオプション変数(&L)
Gui, 89:Add, ListBox, X10 y+5 w%tmpNumW2%  R%tmpNumR%  VScroll  vList89_6_1  gSubList89_6_1
Gui, 89:Add, Edit,    X10 y+5 w%tmpNumW2%  R%tmpNumR2% Multi T8 VScroll  vBoxEdit89_6_1
Gui, 89:Add, Edit,     x+15 yp+0 w%tmpNumW3%  R%tmpNumR2% Multi T8 VScroll  vBoxEdit89_6_2


tmpNumW := cen_anyOfNumFromDpiAndFontSize(21, 29, 450, 470, 490)

Gui, 89:Tab, 7
Gui, 89:Add, Text,    X10 Y%tmpNumStartY% , 簡易スニペットみたいなもの(&L)
Gui, 89:Add, ListBox, X10 y+5 w%tmpNumW2%  R%tmpNumR%  VScroll  vList89_7_1  gSubList89_7_1
Gui, 89:Add, Text,    X10 y+20, 展開後の文字(&T)
Gui, 89:Add, Edit,    X10 y+5 w%tmpNumW% vEdit89_7_1
Gui, 89:Add, Checkbox, xp+0 y+20  vCheckbox89_7_1, (&S)展開後にスペースを付け足す

tmpNumStartY += 50
tmpNumW := tmpNumW2 + 40
Gui, 89:Add, Button,   X%tmpNumW% Y%tmpNumStartY%  gSubButton89_7_1  ,編集(&E)
Gui, 89:Add, Button,    xp+0 y+30  gSubButton89_7_4,削除(&D)

Gui, 89:Add, Text,      xp+0 y+20 w200 c36A2FF vText89_7_2
Gui, 89:Add, Text,      xp+0 y+10 w200 vText89_7_3

Gui, 89:Add, Button,    xp+0 y+30  gSubButton89_7_2,新規登録(&N)

Gui, 89:Add, Text,      xp+0 y+20, 新規登録の際のキーの文字(&K)
Gui, 89:Add, Edit,      xp+0 y+5 w%tmpNumW3% vEdit89_7_2


Gui, 89:+Resize
Gui, 89:-MaximizeBox

