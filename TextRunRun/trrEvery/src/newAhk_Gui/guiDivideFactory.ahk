

; ショートカットキーの一覧
fontNum := cen_fontNumFromDpiAndFontSize(10, 9, 8)
fontNum2 := cen_fontNumFromDpiAndFontSize(12, 11, 10)

tmpNumW := cen_anyOfNumFromDpiAndFontSize(20, 24, 470, 420, 370)
tmpNumH := cen_anyOfNumFromDpiAndFontSize(35, 35, 540, 470, 400)

tmpNumW2 := cen_anyOfNumFromDpiAndFontSize(15, 19, 220, 200, 180)
tmpNumW3 := cen_anyOfNumFromDpiAndFontSize(13, 17, 170, 150, 130)

tmpNumR := guaf_anyOfNumFromDpi(20, 18, 16)
tmpNumR2 := guaf_anyOfNumFromDpi(7, 6, 5)

tmpNumStartY := cen_anyOfNumFromDpiAndFontSize(0, 6, 40, 40, 40)
guf_guiFontFromSizeAndName(fontNum, StO_fontNameAll, 80)
outs_bgPictureAddEnyExtFile(gloco_docDir . glob_everHotkeyBackgName, "X0 Y30", 80)
Gui, 80:Margin, X10 Y5
Gui, 80:Add, Tab2, X0 Y5 w%tmpNumW% h%tmpNumH% , 作成したキー|規定のキー
guf_guiFontFromSizeAndName(fontNum2, "", 80)
Gui, 80:Tab, 1
Gui, 80:Add, Text,    X10 Y%tmpNumStartY% , 作成したキー(&L)
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
Gui, 80:Add, Text,    X10 Y%tmpNumStartY% , 規定のキー(&L)
Gui, 80:Add, ListBox, X10 y+5 w%tmpNumW2%  R%tmpNumR%  VScroll  vList80_2  gSubList80_2
Gui, 80:Add, Edit,    X10 y+5 w%tmpNumW2%  R%tmpNumR2% Multi VScroll  vBoxEdit80_2
Gui, 80:Add, Text,      x+15 Y%tmpNumStartY% vText80_2_1, Ｏｎの状態

Gui, 80:+Resize
Gui, 80:-MaximizeBox
