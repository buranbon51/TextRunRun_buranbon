

TextUpUpSub:
	Send,{Blind}{Up Up}
	return

TextDownUpSub:
	Send,{Blind}{Down Up}
	return

TextPgUpUpSub:
	SetKeyDelay 0
	Send,{Blind}{PgUp Up}
	return

TextPgDnUpSub:
	SetKeyDelay 0
	Send,{Blind}{PgDn Up}
	return




TextAnyUpSub:
	edi_UpDownKeyTextAny(1)
	return

TextAnyDownSub:
	edi_UpDownKeyTextAny(2)
	return

TextAnyPgUpSub:
	edi_UpDownKeyTextAny(3)
	return

TextAnyPgDnSub:
	edi_UpDownKeyTextAny(4)
	return




ItemCtrlSpaceSub:
	Send, !b
	return




TextAnyLClickSub:
	edi_leftClickOnTextAny()
	return

InputListLClickSub:
	edi_leftClickOnText(70)
	return





/*
TextSplit1UpSub:
	autg_editssUpDownKey(61, 1)
	return

TextSplit1DownSub:
	autg_editssUpDownKey(61, 2)
	return

TextSplit1PgUpSub:
	autg_editssUpDownKey(61, 3)
	return

TextSplit1PgDnSub:
	autg_editssUpDownKey(61, 4)
	return



TextSplit2UpSub:
	autg_editssUpDownKey(62, 1)
	return

TextSplit2DownSub:
	autg_editssUpDownKey(62, 2)
	return

TextSplit2PgUpSub:
	autg_editssUpDownKey(62, 3)
	return

TextSplit2PgDnSub:
	autg_editssUpDownKey(62, 4)
	return



Text1UpSub:
	edi_UpDownKeyEditAnotherGui(63, 1)
	return

Text1DownSub:
	edi_UpDownKeyEditAnotherGui(63, 2)
	return

Text1PgUpSub:
	edi_UpDownKeyEditAnotherGui(63, 3)
	return

Text1PgDnSub:
	edi_UpDownKeyEditAnotherGui(63, 4)
	return




Text2UpSub:
	edi_UpDownKeyEditAnotherGui(64, 1)
	return

Text2DownSub:
	edi_UpDownKeyEditAnotherGui(64, 2)
	return

Text2PgUpSub:
	edi_UpDownKeyEditAnotherGui(64, 3)
	return

Text2PgDnSub:
	edi_UpDownKeyEditAnotherGui(64, 4)
	return



Text3UpSub:
	edi_UpDownKeyEditAnotherGui(65, 1)
	return

Text3DownSub:
	edi_UpDownKeyEditAnotherGui(65, 2)
	return

Text3PgUpSub:
	edi_UpDownKeyEditAnotherGui(65, 3)
	return

Text3PgDnSub:
	edi_UpDownKeyEditAnotherGui(65, 4)
	return


ItemUpSub:
	ita_gui72UpDownKey(1)
	return

ItemDownSub:
	ita_gui72UpDownKey(2)
	return

ItemPgUpSub:
	ita_gui72UpDownKey(3)
	return

ItemPgDnSub:
	ita_gui72UpDownKey(4)
	return




TextSplit1LClickSub:
	edi_leftClickOnText(61)
	return

TextSplit2LClickSub:
	edi_leftClickOnText(62)
	return

ItemLClickSub:
	edi_leftClickOnText(72)
	return


*/
