





guf_Gui("Font", 61, glob_needReloadIniCommBoxFontOption, glob_needReloadIniCommBoxFontName)
;Gui, 61:Font, S10
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_commbox1BackgName, "X0 Y0", 61)
Gui, 61:Add, Text,   X10 Y5  , 規定のコマンド(&Y)
Gui, 61:Add, Edit,   X10 y+5 w250  vEdit61_1 gSubEdit61_1
Gui, 61:Add, Text,   X10 y+5 , アイテム名　か　ファイルパス　か　引数１(&I)
Gui, 61:Add, Edit,   X10 y+5 w250  vEdit61_2 gSubEdit61_2
Gui, 61:Add, Text,   X10 y+5 , アイテムの引数　か　引数２
Gui, 61:Add, Edit,   X10 y+5 w250  vEdit61_3 gSubEdit61_3
Gui, 61:Add, Checkbox,   X90 y+5  vCheckbox61_1  Checked , ファイルパスのみなら""をつける
Gui, 61:Add, Picture,X10 y+10 w32 h32  vPicture61_1 gSubPicture61_1, %glob_textNoneFile%
Gui, 61:Add, Text,    x+50 yp+0 , 作業フォルダのみ
Gui, 61:Add, Edit,     xp+0 y+5 w165  vEdit61_4 gSubEdit61_4
Gui, 61:Add, Text,   X10 y+10 , 引数３
Gui, 61:Add, Edit,    x+10 yp+0 w190   vEdit61_5 gSubEdit61_5
Gui, 61:Add, Text,   X10 y+10 , 引数４
Gui, 61:Add, Edit,    x+10 yp+0 w190   vEdit61_6
Gui, 61:Add, Text,   X10 y+10 , 引数５
Gui, 61:Add, Edit,    x+10 yp+0 w190   vEdit61_7
Gui, 61:Add, Text,   X10 y+10 , ＆＆＆　や　>>>　の引数(&Q)
Gui, 61:Add, Edit,   X10 y+5 w250   vEdit61_8

;Gui, 61:Add, Button, X150 y+10 Default gSubButton61_1, 決定(&N)
edc_buttonPictureAddEnyExtFile(gloco_docDir . glob_textSplitButtonName, "X150 y+10 gSubPicture61_1", "X150 y+10 gSubButton61_1", 61)

Gui, 61:Add, Text,   X10 y+0 , 出力先( &[ )
Gui, 61:Add, Edit,   X10 y+10 w250 vBoxEdit61_1 Multi R5 VScroll
Gui, 61:Add, Edit,   X10 y+10 w250 vBoxEdit61_2 Multi R5 VScroll

Gui, 61:Add, ListBox,X10 y+5  R20  Hidden  Disabled  vList61_1 VScroll
Gui, 61:Add, ListBox,X10 y+10  R20  Hidden  Disabled  vList61_2 VScroll
Gui, 61:Add, ListBox,X10 y+10  R20  Hidden  Disabled  vList61_3 VScroll
Gui, 61:Add, ListBox,X10 y+10  R20  Hidden  Disabled  vList61_4 VScroll
Gui, 61:Add, ListBox,X10 y+10  R20  Hidden  Disabled  vList61_5 VScroll
Gui, 61:Add, Button, X0 Y0 Hidden Default gSubButton61_1, HidenButton(&N)
Gui, 61:Add, Button, X0 Y0     Hidden  gSubHidenButton61_1 , PopupButton(&B)

Gui, 61:Color, AAFFFF
Gui, 61:+Resize
Gui, 61:-MaximizeBox
cen_removeBorderFromCommTitleFlag(61)




guf_Gui("Font", 62, glob_needReloadIniCommBoxFontOption, glob_needReloadIniCommBoxFontName)
;Gui, 62:Font, S10
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_commbox2BackgName, "X0 Y0", 62)
Gui, 62:Add, Text,   X10 Y5 , 規定のコマンド(&Y)
Gui, 62:Add, Edit,   X10 y+5 w250  vEdit62_1 gSubEdit62_1
Gui, 62:Add, Text,   X10 y+5 , アイテム名　か　ファイルパス　か　引数１(&I)
Gui, 62:Add, Edit,   X10 y+5 w250  vEdit62_2 gSubEdit62_2
Gui, 62:Add, Text,   X10 y+5 , アイテムの引数　か　引数２
Gui, 62:Add, Edit,   X10 y+5 w250  vEdit62_3 gSubEdit62_3
Gui, 62:Add, Checkbox,   X90 y+5  vCheckbox62_1  Checked , ファイルパスのみなら""をつける
Gui, 62:Add, Picture,X10 y+10 w32 h32  vPicture62_1 gSubPicture62_1, %glob_textNoneFile%
Gui, 62:Add, Text,    x+50 yp+0 , 作業フォルダのみ
Gui, 62:Add, Edit,     xp+0 y+5 w165  vEdit62_4 gSubEdit62_4
Gui, 62:Add, Text,   X10 y+10 , 引数３
Gui, 62:Add, Edit,    x+10 yp+0 w190   vEdit62_5 gSubEdit62_5
Gui, 62:Add, Text,   X10 y+10 , 引数４
Gui, 62:Add, Edit,    x+10 yp+0 w190   vEdit62_6
Gui, 62:Add, Text,   X10 y+10 , 引数５
Gui, 62:Add, Edit,    x+10 yp+0 w190   vEdit62_7
Gui, 62:Add, Text,   X10 y+10 , ＆＆＆　や　>>>　の引数(&Q)
Gui, 62:Add, Edit,   X10 y+5 w250   vEdit62_8

;Gui, 62:Add, Button, X150 y+10 Default gSubButton62_1, 決定(&N)
edc_buttonPictureAddEnyExtFile(gloco_docDir . glob_textSplitButtonName, "X150 y+10 gSubPicture62_1", "X150 y+10 gSubButton62_1", 62)

Gui, 62:Add, Text,   X10 y+0 , 出力先( &[ )
Gui, 62:Add, Edit,   X10 y+10 w250 vBoxEdit62_1 Multi R5 VScroll
Gui, 62:Add, Edit,   X10 y+10 w250 vBoxEdit62_2 Multi R5 VScroll

Gui, 62:Add, ListBox,X10 y+5  R20  Hidden  Disabled  vList62_1 VScroll
Gui, 62:Add, ListBox,X10 y+10  R20  Hidden  Disabled  vList62_2 VScroll
Gui, 62:Add, ListBox,X10 y+10  R20  Hidden  Disabled  vList62_3 VScroll
Gui, 62:Add, ListBox,X10 y+10  R20  Hidden  Disabled  vList62_4 VScroll
Gui, 62:Add, ListBox,X10 y+10  R20  Hidden  Disabled  vList62_5 VScroll
Gui, 62:Add, Button, X0 Y0 Hidden Default gSubButton62_1, HidenButton(&N)
Gui, 62:Add, Button, X0 Y0     Hidden  gSubHidenButton62_1 , PopupButton(&B)

Gui, 62:Color, FFC908
Gui, 62:+Resize
Gui, 62:-MaximizeBox
;Gui, 62:+AlwaysOnTop
cen_removeBorderFromCommTitleFlag(62)




guf_Gui("Font", 63, glob_needReloadIniCommFontOption, glob_needReloadIniCommFontName)
;Gui, 63:Font, S14
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_comm1BackgName, "X0 Y0", 63)
Gui, 63:Add, Picture,X5 Y5 w32 h32  vPicture63_1 gSubPicture63_1, %glob_textNoneFile%
Gui, 63:Add, Edit,     x+5 yp+5 w%O_widthBasisText1%  vEdit63_1   gSubEdit63_1  HwndgGlob_hwndEdit63_1
;Gui, 63:Font, S10
Gui, 63:Add, Button, X0 Y0     Hidden  gSubHidenButton63_1 Default , HidenButton(&N)
Gui, 63:Add, Button, X0 Y0     Hidden  gSubHidenButton63_2 , PopupButton(&B)
;Gui, 63:Add, ListBox,X0 Y0  R15  Hidden  Disabled  vList63_1 VScroll  HwndgGlob_hwndList63_1

Gui, 63:Color, CED6EF
Gui, 63:+Resize
Gui, 63:-MaximizeBox
cen_removeBorderFromCommTitleFlag(63)



guf_Gui("Font", 64, glob_needReloadIniCommFontOption, glob_needReloadIniCommFontName)
;Gui, 64:Font, S14
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_comm2BackgName, "X0 Y0", 64)
Gui, 64:Add, Picture,X5 Y5 w32 h32  vPicture64_1 gSubPicture64_1, %glob_textNoneFile%
Gui, 64:Add, Edit,     x+5 yp+5 w%O_widthBasisText2%  vEdit64_1   gSubEdit64_1  HwndgGlob_hwndEdit64_1
;Gui, 64:Font, S10
Gui, 64:Add, Button, X0 Y0     Hidden  gSubHidenButton64_1 Default , HidenButton(&N)
Gui, 64:Add, Button, X0 Y0     Hidden  gSubHidenButton64_2 , PopupButton(&B)
;Gui, 64:Add, ListBox,X0 Y0  R15  Hidden  Disabled  vList64_1 VScroll  HwndgGlob_hwndList64_1

Gui, 64:Color, FFFF00
Gui, 64:+Resize
Gui, 64:-MaximizeBox
cen_removeBorderFromCommTitleFlag(64)



guf_Gui("Font", 65, glob_needReloadIniCommFontOption, glob_needReloadIniCommFontName)
;Gui, 65:Font, S14
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_comm3BackgName, "X0 Y0", 65)
Gui, 65:Add, Picture,X5 Y5 w32 h32  vPicture65_1 gSubPicture65_1, %glob_textNoneFile%
Gui, 65:Add, Edit,     x+5 yp+5 w%O_widthBasisText3%  vEdit65_1   gSubEdit65_1  HwndgGlob_hwndEdit65_1
;Gui, 65:Font, S10
Gui, 65:Add, Button, X0 Y0     Hidden  gSubHidenButton65_1 Default , HidenButton(&N)
Gui, 65:Add, Button, X0 Y0     Hidden  gSubHidenButton65_2 , PopupButton(&B)
;Gui, 65:Add, ListBox,X0 Y0  R15  Hidden  Disabled  vList65_1 VScroll  HwndgGlob_hwndList65_1

Gui, 65:Color, 9B0000
Gui, 65:+Resize
Gui, 65:-MaximizeBox
cen_removeBorderFromCommTitleFlag(65)




;  出力に使うBOX
guf_Gui("Font", 66, glob_needReloadIniExplainFontOption, glob_needReloadIniExplainFontName)
;Gui, 66:Font, S12
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_outputBackgName, "X0 Y0", 66)
Gui, 66:Add, Edit, X10 Y5  w300  vBoxEdit66_1 Multi R10 VScroll  HwndgGlob_hwndBoxEdit66_1
Gui, 66:Font, S10
;Gui, 66:Add, Text, X10 y+5  vText66_1 , Main Text(&M)
;Gui, 66:Add, Edit, X10 y+5 w200  vEdit66_1 HwndhwndEdit66_1
;Gui, 66:Add, Picture,  x+30 yp+0 w32 h32  vPicture66_1
tmpNumW := cen_anyOfNumFromDpiAndFontSize(5, 7, 70, 70, 70)
Gui, 66:Add, Button, X10 y+10 w%tmpNumW%  vButton66_1  gSubButton66_1, Clean
Gui, 66:Add, Button, x+25 yp+0 w%tmpNumW%  vButton66_2  gSubButton66_2, 再表示

;Gui, 66:Add, Button, X10 y+5     Hidden  Default  HwndhwndHidenButton66_1 , HidenButton(&N)
;Gui, 66:Add, ListBox,X0 Y0  R9  Hidden  Disabled  vList66_1 VScroll  HwndhwndList66_1

Gui, 66:+AlwaysOnTop
Gui, 66:+Resize
Gui, 66:Color, E8FFAA



;エラー表示用
guf_Gui("Font", 67, glob_needReloadIniExplainFontOption, glob_needReloadIniExplainFontName)
;Gui, 67:Font, S12
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_errorOutputBackgName, "X0 Y0", 67)
Gui, 67:Add, Edit, X10 Y5  w300  vBoxEdit67_1 Multi R10 VScroll  HwndgGlob_hwndBoxEdit67_1

;Gui, 67:-Border
Gui, 67:+AlwaysOnTop
Gui, 67:+Resize
Gui, 67:Color, FF2EA2


; 一時的な説明の表示
guf_Gui("Font", 68, glob_needReloadIniExplainFontOption, glob_needReloadIniExplainFontName)
;Gui, 68:Font, S12
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_tmpOutputBackgName, "X0 Y0", 68)
Gui, 68:Add, Edit, X10 Y5  w200  vBoxEdit68_1 Multi R9 VScroll  HwndgGlob_hwndBoxEdit68_1

;Gui, 68:+AlwaysOnTop
Gui, 68:+Resize
;cen_removeBorderFromCommTitleFlag(68)


;ファイルの中を表示用
guf_Gui("Font", 69, glob_needReloadIniExplainFontOption, glob_needReloadIniExplainFontName)
;Gui, 69:Font, S12
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_readFileOutBackgName, "X0 Y0", 69)
Gui, 69:Add, Edit, X10 Y5  w300  vEdit69_1
Gui, 69:Add, Edit, X10 y+10  w300  vBoxEdit69_1 Multi R30 VScroll  HwndgGlob_hwndBoxEdit69_1

;Gui, 69:-Border
;Gui, 69:+AlwaysOnTop
Gui, 69:+Resize
Gui, 69:Color, FFFFB2


; 入力補完のみ

; 一行テキストの設定を使用する
guf_Gui("Font", 70, glob_needReloadIniCommFontOption, glob_needReloadIniCommFontName)
;Gui, 70:Font, S14
Gui, 70:Add, ListBox,X0 Y0 h305 vList70_1 VScroll

Gui, 70:Add, Button, X0 Y0     Hidden  gSubHidenButton70_1 Default , HidenButton(&N)
Gui, 70:Add, Button, X0 Y0     Hidden  gSubHidenButton70_2, PopupButton(&B)

Gui, 70:+Resize
Gui, 70:-MaximizeBox
Gui, 70:-Border



; 設定
tmpNumGroupW := cen_anyOfNumFromDpiAndFontSize(24, 27, 465, 405, 345)
tmpNumGroupH := cen_anyOfNumFromDpiAndFontSize(25, 36, 530, 480, 430)
tmpNumStartY := cen_anyOfNumFromDpiAndFontSize(2, 4, 50, 50, 50)

fontNum2 := cen_fontNumFromDpiAndFontSize(11, 9, 7)
tmpNumW := cen_anyOfNumFromDpiAndFontSize(1, 4, 50, 50, 50)

fontNum := cen_fontNumFromDpiAndFontSize(9, 8, 7)
guf_guiFontFromSizeAndName(fontNum, StO_fontNameAll, 74)
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_configBackgName, "X0 Y30", 74)
tmpNumW3 := cen_anyOfNumFromDpiAndFontSize(5, 7, 70, 70, 70)
tmpNumY := tmpNumGroupH + 20
Gui, 74:Add, Button,  X30 y%tmpNumY%  w%tmpNumW3% gSubButton74_1_1 Default , OK(&O)
Gui, 74:Add, Button,    x+10 yp+0  w%tmpNumW3% gSubButton74_1_2, Cancel(&C)

fontNum := cen_fontNumFromDpiAndFontSize(12, 10, 8)
guf_guiFontFromSizeAndName(fontNum, "", 74)
Gui, 74:Add, Tab2, X0 Y5 w%tmpNumGroupW% h%tmpNumGroupH% vTab74_1, 設定１|設定２|設定３

Gui, 74:Tab, 1
Gui, 74:Add, Checkbox, X10 Y%tmpNumStartY% vCheckbox74_1 ,(&Q)
Gui, 74:Add, Text,      x+5 yp+0 , 空白のあるファイルパスを自動的に調べて`n対応する、という処理をしない
;Gui, 74:Add, Checkbox, X10 y+10 vCheckbox74_3 ,(&P)
;Gui, 74:Add, Text,      x+5 yp+0 , コマンドの実行過程を表示する
Gui, 74:Add, Checkbox, X10 y+15 vCheckbox74_4 ,(&B)
Gui, 74:Add, Text,      x+5 yp+0 , 引数の`n相対パスを絶対パスに変えてから`n実行する、という処理をしない
Gui, 74:Add, Checkbox, X10 y+15 vCheckbox74_9 ,(&L)
Gui, 74:Add, Text,      x+5 yp+0 , 起動時にマウス操作のウインドウを表示しない

Gui, 74:Add, Text,    X10 y+15  , コマンドの履歴の数(&H)
Gui, 74:Add, Edit,      x+5 yp+0  w%tmpNumW%  vUpDown74_1 Limit3 Number
Gui, 74:Add, UpDown, Range-0-999 128, 20

guf_guiFontFromSizeAndName(fontNum, "", 74)
Gui, 74:Add, Checkbox, X10 y+15 vCheckbox74_7 ,(&F)
Gui, 74:Add, Text,      x+5 yp+0 , テキストのストック一覧をAlt+F4で閉じるとき、`n自動でセーブしないようにする。
Gui, 74:Add, Checkbox, X10 y+15 vCheckbox74_1_12 ,(&K)
Gui, 74:Add, Text,      x+5 yp+0 , テキストのストック一覧のリストを変更したとき、`n＆stockChangeBlue 1 ％--`nなどを自動的に入れたりしない

Gui, 74:Add, Checkbox, X10 y+15 vCheckbox74_10 ,(&V)
Gui, 74:Add, Text,      x+5 yp+0 , 自動で入力補完を表示しない

Gui, 74:Add, Checkbox, X10 y+30 vCheckbox74_8 gSubCheckbox74_8,(&S)
Gui, 74:Add, Text,      x+5 yp+0 , 起動時に実行する１(オン/オフ式)

tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(20, 23, 350, 310, 270)
Gui, 74:Add, Text,   X60 y+5 , 実行する処理(&1)
Gui, 74:Add, Edit,   X60 y+5 w%tmpNumW2%  vEdit74_4
tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(22, 26, 400, 360, 320)
Gui, 74:Add, Text,   X10 y+5 , 起動時に実行する処理２`n(こちらは起動時のパラメーターは無効)(&2)
Gui, 74:Add, Edit,   X10 y+5 w%tmpNumW2%  vEdit74_5


Gui, 74:Tab, 2
Gui, 74:Add, Text,    X10 Y%tmpNumStartY%, タイマーの秒数を表示させる間隔(&N)
Gui, 74:Add, Edit,      x+5 yp+0  w%tmpNumW%  vEdit74_2  Limit4  Number
Gui, 74:Add, UpDown, Range-0-9999  128,  5
Gui, 74:Add, Text,      x+2 yp+0  , 秒ごと

Gui, 74:Add, Checkbox, X10 y+20 vCheckbox74_11 ,(&G)
Gui, 74:Add, Text,      x+5 yp+0 , 二行以上のスクリプトの時も`n「一時的な説明表示」に結果を出力する

tmpNumGroupW := cen_anyOfNumFromDpiAndFontSize(18, 27, 430, 370, 310)
tmpNumGroupH := cen_anyOfNumFromDpiAndFontSize(11, 22, 340, 320, 300)
Gui, 74:Add, GroupBox, X10 y+20  w%tmpNumGroupW% h%tmpNumGroupH%
Gui, 74:Add, Text,    X30 yp+15  , 自動で閉じるＧｕｉの、閉じるまでの秒数の指定`n（なお、0 なら自動で閉じない）
Gui, 74:Add, Text,    X60 y+20  , 一時的な説明表示(&P)
Gui, 74:Add, Edit,      x+65 yp+0  w%tmpNumW%  vUpDown74_2_1  Limit4  Number
Gui, 74:Add, UpDown, Range-0-9999  128, 7
Gui, 74:Add, Text,      x+2 yp+0  , 秒後
Gui, 74:Add, Checkbox, X150 y+10 vCheckbox74_2_1 ,(&I)
Gui, 74:Add, Text,      x+5 yp+0 , 最初から表示しない

Gui, 74:Add, Text,    X60 y+20  , 蓄え式説明表示(&U)
Gui, 74:Add, Edit,      x+80 yp+0  w%tmpNumW%  vUpDown74_2_2  Limit4  Number
Gui, 74:Add, UpDown, Range-0-9999  128, 7
Gui, 74:Add, Text,      x+2 yp+0  , 秒後
Gui, 74:Add, Checkbox, X150 y+10 vCheckbox74_2_2 ,(&A)
Gui, 74:Add, Text,      x+5 yp+0 , 最初から表示しない

Gui, 74:Add, Text,    X60 y+20  , エラー表示(&E)
Gui, 74:Add, Edit,      x+115 yp+0  w%tmpNumW%  vUpDown74_2_3  Limit4  Number
Gui, 74:Add, UpDown, Range-0-9999  128, 10
Gui, 74:Add, Text,      x+2 yp+0  , 秒後
Gui, 74:Add, Checkbox, X150 y+10 vCheckbox74_2_3 ,(&R)
Gui, 74:Add, Text,      x+5 yp+0 , 最初から表示しない

Gui, 74:Add, Text,    X60 y+30  , テキストのストック一覧の表示(&M)
Gui, 74:Add, Edit,      x+10 yp+0  w%tmpNumW%  vUpDown74_2_4  Limit4  Number
Gui, 74:Add, UpDown, Range-0-9999  128, 7
Gui, 74:Add, Text,      x+2 yp+0  , 秒後

Gui, 74:Add, Text,    X60 y+20  , タイマー一覧(&T)
Gui, 74:Add, Edit,      x+100 yp+0  w%tmpNumW%  vUpDown74_2_5  Limit4  Number
Gui, 74:Add, UpDown, Range-0-9999  128, 7
Gui, 74:Add, Text,      x+2 yp+0  , 秒後


Gui, 74:Tab, 3
tmpNumGroupH := cen_anyOfNumFromDpiAndFontSize(8, 6, 130, 120, 110)
Gui, 74:Add, GroupBox, X10 y+10  w%tmpNumGroupW% h%tmpNumGroupH%
Gui, 74:Add, Text,    X30 yp+15  , 実行した後、テキストの入力欄の文字を消す
Gui, 74:Add, Checkbox, X40 y+10 vCheckbox74_3_1
Gui, 74:Add, Text,      x+5 yp+0 , ソフト・ファイル・フォルダのアイテムの場合
Gui, 74:Add, Checkbox, X40 y+10 vCheckbox74_3_2
Gui, 74:Add, Text,      x+5 yp+0 , スクリプトのアイテムの場合
Gui, 74:Add, Checkbox, X40 y+10 vCheckbox74_3_3
Gui, 74:Add, Text,      x+5 yp+0 , 二行以上のアイテムの場合

tmpNumGroupH := cen_anyOfNumFromDpiAndFontSize(11, 8, 175, 165, 155)
Gui, 74:Add, GroupBox, X10 y+25  w%tmpNumGroupW% h%tmpNumGroupH%
Gui, 74:Add, Text,    X30 yp+15  , 実行した後、テキストのウインドウを閉じる
Gui, 74:Add, Checkbox, X40 y+10 vCheckbox74_3_4
Gui, 74:Add, Text,      x+5 yp+0 , ソフト・ファイル・フォルダのアイテムの場合は
Gui, 74:Add, Text,      xp+0 y+5 cFFA23E,閉じない
Gui, 74:Add, Checkbox, X40 y+10 vCheckbox74_3_5
Gui, 74:Add, Text,      x+5 yp+0 , スクリプトのアイテムの場合は閉じる
Gui, 74:Add, Checkbox, X40 y+10 vCheckbox74_3_6
Gui, 74:Add, Text,      x+5 yp+0 , 二行以上のアイテムの場合は閉じる
Gui, 74:Add, Checkbox, X40 y+10 vCheckbox74_3_7
Gui, 74:Add, Text,      x+5 yp+0 , AHKのコマンドの場合は閉じる
;Gui, 74:Add, Checkbox, X40 y+10 vCheckbox74_3_8
;Gui, 74:Add, Text,      x+5 yp+0 , 関数の実行の場合は閉じる


Gui, 74:Add, Checkbox, X10 y+35 vCheckbox74_3_9
Gui, 74:Add, Text,      x+5 yp+0 , テキストを閉じるのではなく、最小化させるようにする

Gui, 74:Add, Checkbox, X10 y+10 vCheckbox74_3_10
Gui, 74:Add, Text,      x+5 yp+0 , 入力補完の決定後に、スペースを足す


guf_guiFontFromSizeAndName(fontNum2, "", 74)
tmpNumW3 := cen_anyOfNumFromDpiAndFontSize(20, 25, 410, 360, 310)
Gui, 74:Add, Button,  X10 y+20  w%tmpNumW3% gSubButton74_3_3, 再起動が必要な設定(&D)

Gui, 74:Add, Button,  X10 y+5  w%tmpNumW3% gSubButton74_3_2, userフォルダに加えない設定(&U)

Gui, 74:Add, Button,  X10 y+5  w%tmpNumW3% gSubButton74_3_1, 「テキストの文字で自動的に実行」の設定(&W)

Gui, 74:+Resize
Gui, 74:-MaximizeBox
