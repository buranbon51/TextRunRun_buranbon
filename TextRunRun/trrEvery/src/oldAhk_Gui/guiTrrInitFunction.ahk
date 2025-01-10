





guinif_cleatedDate(versionNum, vType){
	smallVar1 := ".00.03"
	smallVar2 := ".00.03"
	cleatedDate := "2025年1月10日"
	str_local := "昔のAhkの解像度の違いに対応"

	version = %vType%%smallVar1%
	if(vType == 2 ){
		version = %vType%%smallVar2%
	}
	groupW := cen_anyOfNumFromDpiAndFontSize(16, 20, 270, 290, 310)
	groupH := cen_anyOfNumFromDpiAndFontSize(6, 8, 145, 165, 185)
	Gui, 75:Add, GroupBox, X10 y+15  w%groupW% h%groupH%
	Gui, 75:Add, Text,  X30 yp+20,    バージョン：
	Gui, 75:Add, Text,    x+20 yp+0 , %version%
	Gui, 75:Add, Text,  X30 y+15,    %str_local%
	Gui, 75:Add, Text,  X30 y+15,    更新日　：
	Gui, 75:Add, Text,    x+20 yp+0 , %cleatedDate%
	Gui, 75:Add, Text,  X30 y+15,    作者　　：
	Gui, 75:Add, Text,    x+20 yp+0 ,    ブランボン
	Gui, 75:Add, Text,  X30 y+30,    AHKのバージョン：
	Gui, 75:Add, Text,    x+10 yp+0 ,  %A_AhkVersion%
	Gui, 75:Add, Text,  xp+0 y+15,    %trrma_bitVar%
	Gui, 75:Add, Text,  X30 y+15,    %trrma_sign%
}


guinif_initGui61(){
	height := guaf_anyOfNumFromDpi(573, 608, 643)
	Gui, 61:Show, Hide x40 y30 w%O_widthWindowBasisTextSplit1% h%height%, %gGlob_Gui61Title%
}

guinif_initGui62(){
	height := guaf_anyOfNumFromDpi(573, 608, 643)
	Gui, 62:Show, Hide x350 y30 w%O_widthWindowBasisTextSplit2% h%height%, %gGlob_Gui62Title%
}

guinif_initGui63() {
	height := guaf_anyOfNumFromDpi(48, 53, 58)
	Gui, 63:Show, Hide x40 y210 w%O_widthWindowBasisText1% h%height%, %gGlob_Gui63Title%
}

guinif_initGui64() {
	height := guaf_anyOfNumFromDpi(48, 53, 58)
	Gui, 64:Show, Hide x40 y120 w%O_widthWindowBasisText2% h%height%, %gGlob_Gui64Title%
}

guinif_initGui65() {
	height := guaf_anyOfNumFromDpi(48, 53, 58)
	Gui, 65:Show, Hide x40 y30 w%O_widthWindowBasisText3% h%height%, %gGlob_Gui65Title%
}

guinif_initGui66() {
	subX := guaf_anyOfNumFromDpi(389, 400, 410)
	posX := gloco_maxWinWidth - subX
	width := guaf_anyOfNumFromDpi(320, 340, 360)
	height := guaf_anyOfNumFromDpi(210, 230, 250)
	Gui, 66:Show, Hide x%posX% y306 w%width% h%height%, %gGlob_Gui66Title%
}

guinif_initGui67() {
	subX := guaf_anyOfNumFromDpi(389, 400, 410)
	posX := gloco_maxWinWidth - subX
	width := guaf_anyOfNumFromDpi(320, 340, 360)
	height := guaf_anyOfNumFromDpi(190, 210, 230)
	Gui, 67:Show, Hide x%posX% y60  w%width% h%height%, %gGlob_Gui67Title%
}

guinif_initGui68() {
	width := guaf_anyOfNumFromDpi(235, 255, 275)
	height := guaf_anyOfNumFromDpi(185, 205, 225)
	Gui, 68:Show, Hide x40 y350  w%width% h%height%, %gGlob_Gui68Title%
}

guinif_initGui69() {
	subX := guaf_anyOfNumFromDpi(745, 765, 785)
	posX := gloco_maxWinWidth - subX
	width := guaf_anyOfNumFromDpi(330, 340, 350)
	height := guaf_anyOfNumFromDpi(540, 560, 580)
	Gui, 69:Show, Hide x%posX% y60 w%width% h%height%, %gGlob_Gui69Title%
}

guinif_initGui70() {
	width := guaf_anyOfNumFromDpi(210, 215, 220)
	height := guaf_anyOfNumFromDpi(290, 345, 400)
	Gui, 70:Show, Hide w%width% h%height%, %gGlob_Gui70Title%
}

guinif_initGui72() {
	height := cen_anyOfNumFromDpiAndFontSize(31, 26, 575, 595, 615)
	Gui, 72:Show, Hide x215 y30 w%glob_entryItemWidth% h%height%, %gGlob_Gui72Title%
}

guinif_initGui73() {
	width := cen_anyOfNumFromDpiAndFontSize(23, 31, 460, 480, 500)
	height := cen_anyOfNumFromDpiAndFontSize(35, 42, 550, 570, 590)
	Gui, 73:Show, Hide x130 y30 w%width% h%height%, %gGlob_Gui73Title%
}

guinif_initGui74() {
	width := cen_anyOfNumFromDpiAndFontSize(25, 28, 485, 505, 525)
	height := cen_anyOfNumFromDpiAndFontSize(26, 38, 590, 610, 630)
	Gui, 74:Show, Hide  x110 y30  w%width% h%height%, %gGlob_Gui74Title%
}

guinif_initGui75() {
	width := cen_anyOfNumFromDpiAndFontSize(14, 18, 300, 320, 340)
	height := cen_anyOfNumFromDpiAndFontSize(12, 15, 405, 425, 445)
	Gui, 75:Show, Hide x120 y80 w%width% h%height%, %gGlob_Gui75Title%
}

guinif_initGui76(){
	posX := gloco_maxWinWidth - 270
	posY := gloco_maxWinHeight - 112
	posX2 := posX - 40
	posX3 := posX - 80
	posY2 := posY - 15
	posY3 := posY - 40
	posX := guaf_anyOfNumFromDpi(posX, posX2, posX3)
	posY := guaf_anyOfNumFromDpi(posY, posY2, posY3)
	width := guaf_anyOfNumFromDpi(200, 205, 210)
	height := guaf_anyOfNumFromDpi(30, 35, 40)
	Gui, 76:Show, Hide x%posX% y%posY% w%width% h%height%, %gGlob_Gui76Title%
}

guinif_initGui77() {
	subX := cen_anyOfNumFromDpiAndFontSize(19, 26, 680, 710, 740)
	subY := cen_anyOfNumFromDpiAndFontSize(19, 19, 630, 650, 670)
	posX := gloco_maxWinWidth - subX
	posY := gloco_maxWinHeight - subY
	width := cen_anyOfNumFromDpiAndFontSize(7, 10, 300, 315, 330)
	height := cen_anyOfNumFromDpiAndFontSize(25, 20, 560, 580, 600)
	Gui, 77:Show, Hide  x%posX% y%posY% w%width% h%height%, %gGlob_Gui77Title%
}

guinif_initGui78() {
	subX := cen_anyOfNumFromDpiAndFontSize(12, 15, 350, 365, 380)
	subY := cen_anyOfNumFromDpiAndFontSize(19, 19, 630, 650, 670)
	posX := gloco_maxWinWidth - subX
	posY := gloco_maxWinHeight - subY
	width := cen_anyOfNumFromDpiAndFontSize(7, 10, 300, 315, 330)
	height := cen_anyOfNumFromDpiAndFontSize(25, 20, 560, 580, 600)
	Gui, 78:Show, Hide  x%posX% y%posY% w%width% h%height%, %gGlob_Gui78Title%
}

guinif_initGui79(){
	width := cen_anyOfNumFromDpiAndFontSize(15, 21, 355, 375, 395)
	height := cen_anyOfNumFromDpiAndFontSize(21, 21, 375, 395, 415)
	Gui, 79:Show, Hide  x255 y50  w%width% h%height%, %gGlob_Gui79Title%
}

guinif_initGui80(){
	width := cen_anyOfNumFromDpiAndFontSize(20, 24, 480, 500, 520)
	height := cen_anyOfNumFromDpiAndFontSize(35, 35, 560, 580, 600)
	Gui, 80:Show, Hide  x100 y30 w%width% h%height%, %gGlob_Gui80Title%
}

guinif_initGui81(){
	Gui, 81:Show, Hide  x350 y30  AutoSize, __管理者の設定__
}

guinif_initGui82(){
	width := cen_anyOfNumFromDpiAndFontSize(16, 20, 320, 340, 360)
	height := cen_anyOfNumFromDpiAndFontSize(21, 18, 300, 330, 340)
	Gui, 82:Show, Hide  x330 y100 w%width% h%height%, %gGlob_Gui82Title%
}

guinif_initGui83() {
	; アイテム登録の Tab2 の幅と同じにする
	tabW := cen_anyOfNumFromDpiAndFontSize(12, 27, 350, 370, 390)
	tabW += 10
	height := cen_anyOfNumFromDpiAndFontSize(32, 32, 590, 620, 650)
	Gui, 83:Show, Hide x215 y50 w%tabW% h%height%, %gGlob_Gui83Title%
}

guinif_initGui84(){
	width := cen_anyOfNumFromDpiAndFontSize(19, 26, 630, 650, 670)
	height := cen_anyOfNumFromDpiAndFontSize(18, 24, 610, 630, 650)
	Gui, 84:Show, Hide  x50 y30 w%width% h%height%, %gGlob_Gui84Title%
}

guinif_initGui85(){
	Gui, 85:Show, Hide  x190 y30  AutoSize, %gGlob_Gui85Title%
}

guinif_initGui86(){
	Gui, 86:Show, Hide  x190 y30  AutoSize, %gGlob_Gui86Title%
}

guinif_initGui87() {
	subX := cen_anyOfNumFromDpiAndFontSize(21, 28, 455, 480, 505)
	posX := gloco_maxWinWidth - subX
	width := cen_anyOfNumFromDpiAndFontSize(21, 28, 386, 421, 456)
	heigth := timf_decideTimerGuiHeight(1)
	Gui, 87:Show, Hide  x%posX% y10 w%width% h%heigth%, %gGlob_Gui87Title%
}

guinif_initGui88() {
	posY := gloco_maxWinHeight - 114
	width := cen_anyOfNumFromDpiAndFontSize(7, 10, 230, 250, 270)
	height := cen_anyOfNumFromDpiAndFontSize(3, 5, 70, 80, 90)
	Gui, 88:Show, Hide  x15 y%posY%  w%width% h%height%, %gGlob_Gui88Title%
}

guinif_initGui89(){
	width := cen_anyOfNumFromDpiAndFontSize(25, 32, 530, 550, 570)
	height := cen_anyOfNumFromDpiAndFontSize(35, 42, 550, 570, 590)
	Gui, 89:Show, Hide x50 y30 w%width% h%height%, %gGlob_Gui89Title%
}
