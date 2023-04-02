

90GuiEscape:
	Gui, 90:Hide
	return



SubList80_3_1:
	hotitpf_autoExplainFromAllGroundKeyList( "BoxEdit80_3_1", "BoxEdit80_3_2", "Text80_3_2", "Text80_3_3", 80, "List80_3_1", "Edit80_3_1")
	return

SubButton80_3_1:
	notGlobalStr := guf_getControl( "List80_3_1", 80 )
	hotitpf_editAllGroundKeyGuiShow(notGlobalStr)
	return

SubButton80_3_2:
	hotitpf_entryAllGroundKeyGuiShow("")
	return

SubButton80_3_3:
	hotitpf_hotkeyAllGroundDeleteFromGui()
	return



SubHotkey90_1:
	notGlobalStr := guf_getControl( "Hotkey90_1", 90 )
	guf_setControl( notGlobalStr, "Edit90_1", 90 )
	return

SubButton90_1:
	hotitpf_entryAllGroundKeyGuiSubmit()
	return

SubButton90_2:
	Gui, 90:Hide
	return
