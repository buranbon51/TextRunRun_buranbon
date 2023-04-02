
guatpulf_initGui90(){
	width := cen_anyOfNumFromDpiAndFontSize(15, 21, 355, 375, 395)
	height := cen_anyOfNumFromDpiAndFontSize(25, 25, 500, 520, 540)
	Gui, 90:Show, Hide  x215 y50  w%width% h%height%, %gglobap_Gui90Title%
}
