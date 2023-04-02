
guatpulf_initGui90(){
	width := cen_anyOfNumFromDpiAndFontSize(15, 21, 355, 325, 295)
	height := cen_anyOfNumFromDpiAndFontSize(25, 25, 500, 460, 420)
	Gui, 90:Show, Hide  x215 y50  w%width% h%height%, %gglobap_Gui90Title%
}
