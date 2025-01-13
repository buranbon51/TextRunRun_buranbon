





guinif_cleatedDate(versionNum, vType){
	smallVar1 := ".00.03"
	smallVar2 := ".00.03"
	cleatedDate := "2025年1月12日"
	str_local := "今のAhkの解像度に合わせる"

	version = %vType%%smallVar1%
	if(vType == 2 ){
		version = %vType%%smallVar2%
	}
	groupW := cen_anyOfNumFromDpiAndFontSize(16, 20, 270, 270, 270)
	groupH := cen_anyOfNumFromDpiAndFontSize(6, 8, 145, 135, 125)
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
	height := guaf_anyOfNumFromDpi(573, 473, 373)
	Gui, 61:Show, Hide x40 y30 w%O_widthWindowBasisTextSplit1% h%height%, %gGlob_Gui61Title%
}

guinif_initGui62(){
	height := guaf_anyOfNumFromDpi(573, 473, 373)
	Gui, 62:Show, Hide x350 y30 w%O_widthWindowBasisTextSplit2% h%height%, %gGlob_Gui62Title%
}

guinif_initGui63() {
	height := guaf_anyOfNumFromDpi(48, 48, 48)
	Gui, 63:Show, Hide x40 y210 w%O_widthWindowBasisText1% h%height%, %gGlob_Gui63Title%
}

guinif_initGui64() {
	height := guaf_anyOfNumFromDpi(48, 48, 48)
	Gui, 64:Show, Hide x40 y120 w%O_widthWindowBasisText2% h%height%, %gGlob_Gui64Title%
}

guinif_initGui65() {
	height := guaf_anyOfNumFromDpi(48, 48, 48)
	Gui, 65:Show, Hide x40 y30 w%O_widthWindowBasisText3% h%height%, %gGlob_Gui65Title%
}

guinif_initGui66() {
	subX := guaf_anyOfNumFromDpi(389, 430, 470)
	posX := gloco_maxWinWidth - subX
	width := guaf_anyOfNumFromDpi(320, 300, 280)
	height := guaf_anyOfNumFromDpi(210, 190, 170)
	Gui, 66:Show, Hide x%posX% y306 w%width% h%height%, %gGlob_Gui66Title%
}

guinif_initGui67() {
	subX := guaf_anyOfNumFromDpi(389, 430, 470)
	posX := gloco_maxWinWidth - subX
	width := guaf_anyOfNumFromDpi(320, 300, 280)
	height := guaf_anyOfNumFromDpi(190, 170, 150)
	Gui, 67:Show, Hide x%posX% y60  w%width% h%height%, %gGlob_Gui67Title%
}

guinif_initGui68() {
	width := guaf_anyOfNumFromDpi(235, 220, 205)
	height := guaf_anyOfNumFromDpi(185, 165, 145)
	Gui, 68:Show, Hide x40 y350  w%width% h%height%, %gGlob_Gui68Title%
}

guinif_initGui69() {
	subX := guaf_anyOfNumFromDpi(745, 725, 705)
	posX := gloco_maxWinWidth - subX
	width := guaf_anyOfNumFromDpi(330, 310, 290)
	height := guaf_anyOfNumFromDpi(540, 470, 400)
	Gui, 69:Show, Hide x%posX% y60 w%width% h%height%, %gGlob_Gui69Title%
}

guinif_initGui70() {
	width := guaf_anyOfNumFromDpi(210, 190, 170)
	height := guaf_anyOfNumFromDpi(290, 260, 230)
	Gui, 70:Show, Hide w%width% h%height%, %gGlob_Gui70Title%
}

guinif_initGui72() {
	height := cen_anyOfNumFromDpiAndFontSize(31, 26, 575, 505, 435)
	Gui, 72:Show, Hide x215 y30 w%glob_entryItemWidth% h%height%, %gGlob_Gui72Title%
}

guinif_initGui73() {
	width := cen_anyOfNumFromDpiAndFontSize(23, 31, 460, 420, 380)
	height := cen_anyOfNumFromDpiAndFontSize(35, 42, 550, 440, 350)
	Gui, 73:Show, Hide x130 y30 w%width% h%height%, %gGlob_Gui73Title%
}

guinif_initGui74() {
	width := cen_anyOfNumFromDpiAndFontSize(25, 28, 485, 425, 365)
	height := cen_anyOfNumFromDpiAndFontSize(26, 38, 590, 530, 480)
	Gui, 74:Show, Hide  x110 y10  w%width% h%height%, %gGlob_Gui74Title%
}

guinif_initGui75() {
	width := cen_anyOfNumFromDpiAndFontSize(14, 18, 300, 300, 300)
	height := cen_anyOfNumFromDpiAndFontSize(12, 15, 405, 395, 385)
	Gui, 75:Show, Hide x120 y80 w%width% h%height%, %gGlob_Gui75Title%
}

guinif_initGui76(){
	posX := gloco_maxWinWidth - 270
	posY := gloco_maxWinHeight - 112
	posX2 := posX - 50
	posX3 := posX - 100
	posY2 := posY - 25
	posY3 := posY - 50
	posX := guaf_anyOfNumFromDpi(posX, posX2, posX3)
	posY := guaf_anyOfNumFromDpi(posY, posY2, posY3)
	width := guaf_anyOfNumFromDpi(200, 200, 200)
	height := guaf_anyOfNumFromDpi(30, 30, 30)
	Gui, 76:Show, Hide x%posX% y%posY% w%width% h%height%, %gGlob_Gui76Title%
}

guinif_initGui77() {
	subX := cen_anyOfNumFromDpiAndFontSize(19, 26, 680, 770, 860)
	subY := cen_anyOfNumFromDpiAndFontSize(19, 19, 630, 690, 750)
	posX := gloco_maxWinWidth - subX
	posY := gloco_maxWinHeight - subY
	width := cen_anyOfNumFromDpiAndFontSize(7, 10, 300, 270, 240)
	height := cen_anyOfNumFromDpiAndFontSize(25, 20, 560, 490, 420)
	Gui, 77:Show, Hide  x%posX% y%posY% w%width% h%height%, %gGlob_Gui77Title%
}

guinif_initGui78() {
	subX := cen_anyOfNumFromDpiAndFontSize(12, 15, 350, 400, 450)
	subY := cen_anyOfNumFromDpiAndFontSize(19, 19, 630, 690, 750)
	posX := gloco_maxWinWidth - subX
	posY := gloco_maxWinHeight - subY
	width := cen_anyOfNumFromDpiAndFontSize(7, 10, 300, 270, 240)
	height := cen_anyOfNumFromDpiAndFontSize(25, 20, 560, 490, 420)
	Gui, 78:Show, Hide  x%posX% y%posY% w%width% h%height%, %gGlob_Gui78Title%
}

guinif_initGui79(){
	width := cen_anyOfNumFromDpiAndFontSize(15, 21, 355, 335, 315)
	height := cen_anyOfNumFromDpiAndFontSize(21, 21, 375, 355, 335)
	Gui, 79:Show, Hide  x255 y50  w%width% h%height%, %gGlob_Gui79Title%
}

guinif_initGui80(){
	width := cen_anyOfNumFromDpiAndFontSize(20, 24, 480, 430, 380)
	height := cen_anyOfNumFromDpiAndFontSize(35, 35, 550, 470, 390)
	Gui, 80:Show, Hide  x100 y30 w%width% h%height%, %gGlob_Gui80Title%
}

guinif_initGui81(){
	Gui, 81:Show, Hide  x350 y30  AutoSize, __管理者の設定__
}

guinif_initGui82(){
	width := cen_anyOfNumFromDpiAndFontSize(16, 20, 320, 290, 260)
	height := cen_anyOfNumFromDpiAndFontSize(21, 18, 300, 270, 240)
	Gui, 82:Show, Hide  x330 y100 w%width% h%height%, %gGlob_Gui82Title%
}

guinif_initGui83() {
	; アイテム登録の Tab2 の幅と同じにする
	tabW := cen_anyOfNumFromDpiAndFontSize(13, 27, 350, 320, 290)
	tabW += 10
	height := cen_anyOfNumFromDpiAndFontSize(32, 32, 590, 560, 530)
	Gui, 83:Show, Hide x215 y20 w%tabW% h%height%, %gGlob_Gui83Title%
}

guinif_initGui84(){
	width := cen_anyOfNumFromDpiAndFontSize(19, 26, 630, 500, 370)
	height := cen_anyOfNumFromDpiAndFontSize(18, 24, 610, 520, 410)
	Gui, 84:Show, Hide  x50 y20 w%width% h%height%, %gGlob_Gui84Title%
}

guinif_initGui85(){
	Gui, 85:Show, Hide  x190 y30  AutoSize, %gGlob_Gui85Title%
}

guinif_initGui86(){
	Gui, 86:Show, Hide  x190 y30  AutoSize, %gGlob_Gui86Title%
}

guinif_initGui87() {
	subX := cen_anyOfNumFromDpiAndFontSize(21, 28, 455, 500, 550)
	posX := gloco_maxWinWidth - subX
	width := cen_anyOfNumFromDpiAndFontSize(21, 28, 386, 360, 335)
	heigth := timf_decideTimerGuiHeight(1)
	Gui, 87:Show, Hide  x%posX% y10 w%width% h%heigth%, %gGlob_Gui87Title%
}

guinif_initGui88() {
	posY := gloco_maxWinHeight - 114
	width := cen_anyOfNumFromDpiAndFontSize(7, 10, 260, 260, 260)
	height := cen_anyOfNumFromDpiAndFontSize(3, 5, 70, 70, 70)
	Gui, 88:Show, Hide  x15 y%posY%  w%width% h%height%, %gGlob_Gui88Title%
}

guinif_initGui89(){
	width := cen_anyOfNumFromDpiAndFontSize(25, 32, 530, 480, 430)
	height := cen_anyOfNumFromDpiAndFontSize(35, 42, 550, 490, 430)
	Gui, 89:Show, Hide x50 y30 w%width% h%height%, %gGlob_Gui89Title%
}
