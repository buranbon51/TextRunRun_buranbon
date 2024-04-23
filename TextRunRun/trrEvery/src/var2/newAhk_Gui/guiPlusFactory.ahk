


;  ホットキーの登録
fontNum := cen_fontNumFromDpiAndFontSize(11, 10, 9)
guf_guiFontFromSizeAndName(fontNum, StO_fontNameAll, 90)
outs_bgPictureAddEnyExtFile(gloco_docDir . glotaip_entryAllGroundKeyBackgName, "X0 Y0", 90)
tmpNumW := cen_anyOfNumFromDpiAndFontSize(15, 18, 200, 200, 200)
Gui, 90:Add, Text,   X20  Y5 w%tmpNumW% vText90_1, キー名(&K)
tmpNumW := cen_anyOfNumFromDpiAndFontSize(14, 16, 180, 180, 180)
Gui, 90:Add, Edit,   X10  y+5 w%tmpNumW%  vEdit90_1

tmpNumW := cen_anyOfNumFromDpiAndFontSize(19, 23, 320, 280, 240)
Gui, 90:Add, Text,   X20 y+10 w%tmpNumW%  vText90_2  ,実行スクリプト(&L)
Gui, 90:Add, Edit,   X10 y+5  w%tmpNumW% h130 vBoxEdit90_2 Multi T16 -Wrap VScroll HScroll

Gui, 90:Add, Text,   X20 y+20 , 一時的にのみ保存
Gui, 90:Add, Checkbox,  x+5 yp+0   vCheckbox90_1, (&U)
Gui, 90:Add, Button, X100 y+5 Default gSubButton90_1, OK(&O)
Gui, 90:Add, Button,  x+10 yp+0 gSubButton90_2, Cancel

Gui, 90:Add, Text,   X20 y+15 w%tmpNumW% vText90_3, ウインドウタイトルを指定する(&W)
Gui, 90:Add, Edit,   X10 y+5 w%tmpNumW% vEdit90_3

Gui, 90:Add, Text,   X20 y+5, 説明(&M)
Gui, 90:Add, Edit,   X10 y+5 w250    vBoxEdit90_1  R3 VScroll

Gui, 90:Add, Text,   X20 y+10   ,キー入力補助(&H)
tmpNumW := cen_anyOfNumFromDpiAndFontSize(14, 16, 160, 140, 120)
Gui, 90:Add, Hotkey,  X10 y+10 w%tmpNumW% vHotkey90_1 gSubHotkey90_1 Limit1

Gui, 90:Add, Checkbox, X0 Y0  Hidden  Disabled  vHiddenCheckbox90_1	;0新規作成  1編集
Gui, 90:Add, Edit,     X0 Y0  Hidden  Disabled  vHiddenEdit90_1		; アイテム名の変更用

Gui, 90:+Resize

