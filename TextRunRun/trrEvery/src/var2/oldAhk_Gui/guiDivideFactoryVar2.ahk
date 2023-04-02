﻿

; ショートカットキーの一覧
fontNum := cen_fontNumFromDpiAndFontSize(10, 9, 8)
fontNum2 := cen_fontNumFromDpiAndFontSize(12, 11, 10)

tmpNumW := cen_anyOfNumFromDpiAndFontSize(20, 24, 470, 490, 520)
tmpNumH := cen_anyOfNumFromDpiAndFontSize(35, 35, 540, 560, 580)

tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(15, 19, 220, 240, 260)
tmpNumW3 := cen_anyOfNumFromDpiAndFontSize(13, 17, 170, 190, 210)

tmpNumR := guaf_anyOfNumFromDpi(20, 18, 16)
tmpNumR2 := guaf_anyOfNumFromDpi(7, 5, 3)

tmpNumStartY := cen_anyOfNumFromDpiAndFontSize(0, 6, 40, 60, 80)
guf_guiFontFromSizeAndName(fontNum, StO_fontNameAll, 80)
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_everHotkeyBackgName, "X0 Y30", 80)
Gui, 80:Margin, X10 Y5
Gui, 80:Add, Tab2, X0 Y5 w%tmpNumW% h%tmpNumH% , テキスト上|規定のキー|常時使用
guf_guiFontFromSizeAndName(fontNum2, "", 80)
Gui, 80:Tab, 1
Gui, 80:Add, Text,    X10 Y%tmpNumStartY% , テキスト上の、作成したキー(&L)
Gui, 80:Add, ListBox, X10 y+5 w%tmpNumW2%  R%tmpNumR%  VScroll  vList80_1  gSubList80_1
Gui, 80:Add, Edit,    X10 y+5 w%tmpNumW2%  R%tmpNumR2% Multi VScroll  vBoxEdit80_1
Gui, 80:Add, Edit,      x+15 yp+0 w%tmpNumW3%  R%tmpNumR2% Multi VScroll  vBoxEdit80_1_2

tmpNumStartY2 := tmpNumStartY + 25
Gui, 80:Add, Button,    xp+0 Y%tmpNumStartY2%  gSubButton80_1_1  ,編集(&E)
Gui, 80:Add, Button,    xp+0 y+10  gSubButton80_1_2 ,新規登録(&N)
Gui, 80:Add, Button,    xp+0 y+20  gSubButton80_1_3 ,削除(&D)

Gui, 80:Add, Text,      xp+0 y+20 w200 c36A2FF vText80_1_2
Gui, 80:Add, Text,      xp+0 y+10 w200 cFFB255 vText80_1_3

Gui, 80:Tab, 2
Gui, 80:Add, Text,    X10 Y%tmpNumStartY% , テキスト上の、規定のキー(&L)
Gui, 80:Add, ListBox, X10 y+5 w%tmpNumW2%  R%tmpNumR%  VScroll  vList80_2  gSubList80_2
Gui, 80:Add, Edit,    X10 y+5 w%tmpNumW2%  R%tmpNumR2% Multi VScroll  vBoxEdit80_2

Gui, 80:Add, Text,      x+15 Y%tmpNumStartY2% vText80_2_1, Ｏｎの状態


Gui, 80:Tab, 3
Gui, 80:Add, Text,    X10 Y%tmpNumStartY% , どのウインドウでも使用できる、作成したキー(&L)
Gui, 80:Add, ListBox, X10 y+5 w%tmpNumW2%  R%tmpNumR%  VScroll  vList80_3_1  gSubList80_3_1
Gui, 80:Add, Edit,    X10 y+5 w%tmpNumW2%  R%tmpNumR2% Multi VScroll  vBoxEdit80_3_1
Gui, 80:Add, Edit,      x+15 yp+0 w%tmpNumW3%  R%tmpNumR2% Multi VScroll  vBoxEdit80_3_2

;tmpNumStartY2 := tmpNumStartY + 52
Gui, 80:Add, Button,    xp+0 Y%tmpNumStartY2%  gSubButton80_3_1  ,編集(&E)
Gui, 80:Add, Button,    xp+0 y+10  gSubButton80_3_2 ,新規登録(&N)
Gui, 80:Add, Button,    xp+0 y+20  gSubButton80_3_3 ,削除(&D)

Gui, 80:Add, Text,      xp+0 y+20 , ウインドウ指定
Gui, 80:Add, Edit,      xp+0 y+5 w%tmpNumW3% vEdit80_3_1

Gui, 80:Add, Text,      xp+0 y+20 w200 c36A2FF vText80_3_2
Gui, 80:Add, Text,      xp+0 y+10 w200 cFFB255 vText80_3_3

Gui, 80:+Resize
Gui, 80:-MaximizeBox
