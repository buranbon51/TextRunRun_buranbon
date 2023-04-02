





72GuiEscape:
	if(ite_hideConfirmGui72()) {
		return
	}
	Gui, 72:Show, Hide
	return

72GuiContextMenu:
	if(A_GuiEvent == "RightClick"){
		edi_GuiContextMenu(A_GuiControl, 72)
	}
	return

72GuiDropFiles:
	StringSplit, filess, A_GuiEvent,`n
	SplitPath, filess1, , , , OutNameNoExt
	guf_setControl( filess1, "Edit72_3", 72 )
	guf_setControl( OutNameNoExt, "Edit72_1", 72 )
	return

73GuiEscape:
	Gui, 73:Show, Hide
	return



75GuiEscape:
	Gui, 75:Hide
	return

76GuiClose:
	guaf_clickWindowCloseOrMinimize()
	return

76GuiEscape:
	guaf_clickWindowCloseOrMinimize()
	return

76GuiContextMenu:
	excof_itemExecute("76GuiContextMenu", "", "", "", 71, "", "", True, "", "", False, 1)
	return

76GuiDropFiles:
	excof_itemExecute("76GuiDropFiles", "", "", "", 71, "", "", True, "", "", False, 1)
	return

77GuiClose:
	Gui, 77:Submit
	chec_commStockListOnEscLogic(ListBox77_1, Edit77_11, gloco_userDir . glob_commStockFile77Name, True, 77)
	return

77GuiEscape:
	Gui, 77:Hide
	return

77GuiSize:
	guaf_sizeChangeStockGui(77)
	return

77GuiDropFiles:
	StringSplit, filess, A_GuiEvent,`n
	edi_addStockSetControl(filess1, 77, 71)
	return

77GuiContextMenu:
	Menu, stockMenuBlue, Show, %A_GuiX%, %A_GuiY%
	return


78GuiClose:
	Gui, 78:Submit
	chec_commStockListOnEscLogic(ListBox78_1, Edit78_11, gloco_userDir . glob_commStockFile78Name, True, 78)
	return

78GuiEscape:
	Gui, 78:Hide
	return

78GuiSize:
	guaf_sizeChangeStockGui(78)
	return

78GuiDropFiles:
	StringSplit, filess, A_GuiEvent,`n
	edi_addStockSetControl(filess1, 78, 71)
	return

78GuiContextMenu:
	Menu, stockMenuGreen, Show, %A_GuiX%, %A_GuiY%
	return


79GuiEscape:
	Gui, 79:Hide
	return

80GuiEscape:
	Gui, 80:Hide
	return

81GuiEscape:
	Gui, 81:Hide
	return

82GuiEscape:
	Gui, 82:Hide
	return

82GuiSize:
	tmpNumW := A_GuiWidth - 20
	tmpNumH := A_GuiHeight - 80
	tmpNumY := tmpNumH + 40
	GuiControl, 82:Move, BoxEdit82_1, w%tmpNumW%  h%tmpNumH%
	GuiControl, 82:Move, Button82_1,  y%tmpNumY%
	GuiControl, 82:Move, Button82_2,  y%tmpNumY%
	return

83GuiEscape:
	Gui, 83:Hide
	return

83GuiSize:
	tmpNumW := A_GuiWidth - 35
	GuiControl, 83:Move, BoxEdit83_1_1, w%tmpNumW%
	return

84GuiEscape:
	Gui, 84:Hide
	return

85GuiEscape:
	Gui, 85:Hide
	return

86GuiEscape:
	Gui, 86:Hide
	return

87GuiEscape:
	Gui, 87:Hide
	return

87GuiSize:
	tmpNumW := A_GuiWidth - 80
	GuiControl, 87:Move, Edit87_1_3, w%tmpNumW%
	GuiControl, 87:Move, Edit87_2_3, w%tmpNumW%
	GuiControl, 87:Move, Edit87_3_3, w%tmpNumW%
	GuiControl, 87:Move, Edit87_4_3, w%tmpNumW%
	GuiControl, 87:Move, Edit87_5_3, w%tmpNumW%
	GuiControl, 87:Move, Edit87_6_3, w%tmpNumW%
	GuiControl, 87:Move, Edit87_7_3, w%tmpNumW%
	GuiControl, 87:Move, Edit87_8_3, w%tmpNumW%
	GuiControl, 87:Move, Edit87_9_3, w%tmpNumW%
	GuiControl, 87:Move, Edit87_10_3, w%tmpNumW%
	return


88GuiClose:
	guaf_closeGui88()
	return

88GuiEscape:
	guaf_closeGui88()
	return

89GuiEscape:
	Gui, 89:Hide
	return



;  アイテムの新規登録の
SubEdit72_1:
	GuiControlGet, Edit72_1 ,72:
	GuiControlGet, HiddenCheckbox72_1 ,72:
	ite_itemKeywordConfilrm(Edit72_1, HiddenCheckbox72_1)
	return

SubEdit72_3:
	GuiControlGet, Edit72_3 ,72:
	edi_textSizeChangeCommbox(Edit72_3, "Edit72_3", 10, 290, 130, 15, gGlob_Gui72Title, glob_entryItemWidth, False, 72)
	aut_controlKeyUpDownTestList1(True)
	changeEdit72_3 := outs_textOutDqAllTrim(Edit72_3)
	Edit72_3 := aut_checkDangerStr(Edit72_3)
	changeEdit72_3 := aut_checkDangerStr(changeEdit72_3)
	ita_autoPupupFileItemList( changeEdit72_3, "List72_1", 72 )
	ite_pictuerOfPath72_1( changeEdit72_3 )
	ite_itemPathConfilrm(changeEdit72_3)
	ite_workDirAutoSet(Edit72_3, changeEdit72_3, "Edit72_5", 72)
	return

SubEdit72_4:
	GuiControlGet, Edit72_4 ,72:
	edi_textSizeChangeCommbox(Edit72_4, "Edit72_4", 10, 290, 130, 15, gGlob_Gui72Title, glob_entryItemWidth, False, 72)
	aut_controlKeyUpDownTestList2(True)
	Edit72_4 := outs_textOutDqAllTrim(Edit72_4)
	;Edit72_4 := aut_checkDangerStr(Edit72_4)
	ita_autoPupupFileItemListForArgs( Edit72_4, "List72_2", 72 )
	return

SubEdit72_5:
	GuiControlGet, Edit72_5 ,72:
	;edi_textSizeChangeCommbox(Edit72_5, "Edit72_5", 10, 290, 130, 15, gGlob_Gui72Title, glob_entryItemWidth, False, 72)
	aut_controlKeyUpDownTestList3(True)
	Edit72_5 := outs_textOutDqAllTrim(Edit72_5)
	;Edit72_5 := aut_checkDangerStr(Edit72_5)
	ita_autoPupupItemOnlyFolderList( Edit72_5, "List72_3", 72 )
	return

SubRadio72_1:
	ite_autoItemRadioChange()
	return

SubRadio72_2:
	ite_autoItemRadioChange()
	return

SubRadio72_3:
	ite_autoItemRadioChange()
	return

SubHidenButton72_1:
	ita_pupUpShowGui72()
	return

SubButton72_1:
	FileSelectFile, notGlobalStr, 3, %A_WorkingDir%, ファイルの選択
	if(notGlobalStr != "") {
		guf_setControl( notGlobalStr, "Edit72_3", 72 )
	}
	return

SubButton72_2:
	FileSelectFolder, notGlobalStr, %A_WorkingDir%, 3, フォルダの選択
	if(notGlobalStr != ""){
		guf_setControl( notGlobalStr, "Edit72_3", 72 )
	}
	return

SubButton72_3:
	ite_relativButton(A_LineFile, A_LineNumber)
	return

SubButton72_4:
	ite_absoleButton(A_LineFile, A_LineNumber)
	return

SubButton72_5:
	Gui, 72:Submit, NoHide
	ite_submitItemEntry(Edit72_1, Edit72_3, Edit72_4, Edit72_5, BoxEdit72_1, Edit72_2_1, UpDown72_2_1, HiddenEdit72_2)
	return

SubButton72_6:
	Gui, 72:Show, Hide
	return

SubButton72_7:
	Gui, 72:Hide
	windc_anyWaitActive()
	musc_showMultipleScriptsGui("")
	return

SubEdit72_2_1:
	ite_autoSetPictuerOfPath()
	return

SubUpDown72_2_1:
	ite_autoSetPictuerOfPath()
	return

SubButton72_2_1:
	ite_itemIconButtonOfPath()
	return


SubList73_1:
	notGlobalStr := guf_getControl( "List73_1", 73 )
	ite_autoSetPicture( notGlobalStr, "BoxEdit73_1", "BoxEdit73_1_2", "Picture73_1", "Text73_1_2", "Text73_1_3", "Text73_1_4")
	return

SubList73_2:
	notGlobalStr := guf_getControl( "List73_2", 73 )
	ite_autoSetPicture( notGlobalStr, "BoxEdit73_2", "BoxEdit73_2_2", "Picture73_2", "Text73_2_2", "Text73_2_3", "Text73_2_4")
	return

SubList73_3:
	notGlobalStr := guf_getControl( "List73_3", 73 )
	ite_autoSetPicture( notGlobalStr, "BoxEdit73_3", "BoxEdit73_3_2", "Picture73_3", "Text73_3_2", "Text73_3_3", "Text73_3_4")
	return


SubButton73_1_1:
	notGlobalStr := guf_getControl( "List73_1", 73 )
	ite_editCommand(notGlobalStr)
	return

SubButton73_1_2:
	notGlobalStr := guf_getControl( "List73_1", 73 )
	ite_itemCopyEdit(notGlobalStr, "List73_1")
	return

SubButton73_1_3:
	notGlobalStr := guf_getControl( "List73_1", 73 )
	ite_deleteCommand(notGlobalStr, 63)
	return

SubButton73_2_1:
	notGlobalStr := guf_getControl( "List73_2", 73 )
	ite_editCommand(notGlobalStr)
	return

SubButton73_2_2:
	notGlobalStr := guf_getControl( "List73_2", 73 )
	ite_itemCopyEdit(notGlobalStr, "List73_2")
	return

SubButton73_2_3:
	notGlobalStr := guf_getControl( "List73_2", 73 )
	ite_deleteCommand(notGlobalStr, 63)
	return

SubButton73_3_1:
	notGlobalStr := guf_getControl( "List73_3", 73 )
	ite_editCommand(notGlobalStr)
	return

SubButton73_3_2:
	notGlobalStr := guf_getControl( "List73_3", 73 )
	ite_itemCopyEdit(notGlobalStr, "List73_3")
	return

SubButton73_3_3:
	notGlobalStr := guf_getControl( "List73_3", 73 )
	ite_deleteCommand(notGlobalStr, 63)
	return

SubList73_7_1:
	notGlobalStr := guf_getControl( "List73_7_1", 73 )
	ite_autoSetPicture( notGlobalStr, "BoxEdit73_7_1", "BoxEdit73_7_2", "Picture73_7_1", "Text73_7_2", "Text73_7_3", "Text73_7_4")
	return

SubButton73_7_1:
	notGlobalStr := guf_getControl( "List73_7_1", 73 )
	musc_editMultipleScriptsGui(notGlobalStr)
	return

SubButton73_7_2:
	musc_showMultipleScriptsGui("")
	return

SubButton73_7_3:
	notGlobalStr := guf_getControl( "List73_7_1", 73 )
	musc_copyMultipleItem(notGlobalStr, "List73_7_1", 73)
	return

SubButton73_7_4:
	notGlobalStr := guf_getControl( "List73_7_1", 73 )
	musc_submitMultipleScriptsDelete(notGlobalStr)
	return

SubButton73_1_4:
	ite_showGui72("", "", 1)
	return

SubButton73_2_4:
	ite_showGui72("", "", 2)
	return

SubButton73_3_4:
	ite_showGui72("", "", 3)
	return



SubPicture76_1:
	guf_showHideEnyGui("Edit63_1", 63)
	return

SubPicture76_2:
	guf_showHideEnyGui("Edit64_1", 64)
	return

SubPicture76_3:
	guf_showHideEnyGui("Edit65_1", 65)
	return

SubPicture76_4:
	guf_showHideEnyGui("Edit61_1", 61)
	return

SubPicture76_5:
	guf_showHideEnyGui("Edit62_1", 62)
	return

SubPicture76_6:
	guf_showHideEnyGui("Edit77_1", 77)
	return

SubPicture76_7:
	guf_showHideEnyGui("Edit78_1", 78)
	return

SubPicture76_8:
	guf_showHideEnyGui("BoxEdit68_1", 68)
	return

SubPicture76_9:
	guf_showHideEnyGui("BoxEdit66_1", 66)
	return

SubPicture76_10:
	guf_showHideEnyGui("BoxEdit67_1", 67)
	return

SubHidenButton76_1:
	Gui, 63:Show
	return



SubButton77_1:
	Gui, 77:Submit, NoHide
	chec_commStockListLoad(ListBox77_1, Edit77_11, gloco_userDir . glob_commStockFile77Name, 77)
	return

SubButton77_2:
	Gui, 77:Submit, NoHide
	chec_commStockListLoadBackupLoad(ListBox77_1, gloco_userDir . glob_commStockFile77Name, 77)
	return

SubButton77_3:
	Gui, 77:Submit, NoHide
	chec_commStockListSave(ListBox77_1, Edit77_11, gloco_userDir . glob_commStockFile77Name, False, 77)
	return

SubButton77_4:
	Gui, 77:Submit, NoHide
	chec_commStockListLoadBackupSave(ListBox77_1, gloco_userDir . glob_commStockFile77Name, 77)
	return

SubPicture77_1:
	glob_stockEditValue := guf_getControl( "Edit77_1", 77 )
	Send, !n
	return

SubPicture77_2:
	glob_stockEditValue := guf_getControl( "Edit77_2", 77 )
	Send, !n
	return

SubPicture77_3:
	glob_stockEditValue := guf_getControl( "Edit77_3", 77 )
	Send, !n
	return

SubPicture77_4:
	glob_stockEditValue := guf_getControl( "Edit77_4", 77 )
	Send, !n
	return

SubPicture77_5:
	glob_stockEditValue := guf_getControl( "Edit77_5", 77 )
	Send, !n
	return

SubPicture77_6:
	glob_stockEditValue := guf_getControl( "Edit77_6", 77 )
	Send, !n
	return

SubPicture77_7:
	glob_stockEditValue := guf_getControl( "Edit77_7", 77 )
	Send, !n
	return

SubPicture77_8:
	glob_stockEditValue := guf_getControl( "Edit77_8", 77 )
	Send, !n
	return

SubPicture77_9:
	glob_stockEditValue := guf_getControl( "Edit77_9", 77 )
	Send, !n
	return

SubPicture77_10:
	glob_stockEditValue := guf_getControl( "Edit77_10", 77 )
	Send, !n
	return

SubEdit77_1:
	edi_autoImageSetFromText("Edit77_1", "Picture77_1", 77)
	return

SubEdit77_2:
	edi_autoImageSetFromText("Edit77_2", "Picture77_2", 77)
	return

SubEdit77_3:
	edi_autoImageSetFromText("Edit77_3", "Picture77_3", 77)
	return

SubEdit77_4:
	edi_autoImageSetFromText("Edit77_4", "Picture77_4", 77)
	return

SubEdit77_5:
	edi_autoImageSetFromText("Edit77_5", "Picture77_5", 77)
	return

SubEdit77_6:
	edi_autoImageSetFromText("Edit77_6", "Picture77_6", 77)
	return

SubEdit77_7:
	edi_autoImageSetFromText("Edit77_7", "Picture77_7", 77)
	return

SubEdit77_8:
	edi_autoImageSetFromText("Edit77_8", "Picture77_8", 77)
	return

SubEdit77_9:
	edi_autoImageSetFromText("Edit77_9", "Picture77_9", 77)
	return

SubEdit77_10:
	edi_autoImageSetFromText("Edit77_10", "Picture77_10", 77)
	return

SubHidenButton77_1:
	edc_stockCommExeLogic(77)
	return


SubButton78_1:
	Gui, 78:Submit, NoHide
	chec_commStockListLoad(ListBox78_1, Edit78_11, gloco_userDir . glob_commStockFile78Name, 78)
	return

SubButton78_2:
	Gui, 78:Submit, NoHide
	chec_commStockListLoadBackupLoad(ListBox78_1, gloco_userDir . glob_commStockFile78Name, 78)
	return

SubButton78_3:
	Gui, 78:Submit, NoHide
	chec_commStockListSave(ListBox78_1, Edit78_11, gloco_userDir . glob_commStockFile78Name, False, 78)
	return

SubButton78_4:
	Gui, 78:Submit, NoHide
	chec_commStockListLoadBackupSave(ListBox78_1, gloco_userDir . glob_commStockFile78Name, 78)
	return

SubPicture78_1:
	glob_stockEditValue := guf_getControl( "Edit78_1", 78 )
	Send, !n
	return

SubPicture78_2:
	glob_stockEditValue := guf_getControl( "Edit78_2", 78 )
	Send, !n
	return

SubPicture78_3:
	glob_stockEditValue := guf_getControl( "Edit78_3", 78 )
	Send, !n
	return

SubPicture78_4:
	glob_stockEditValue := guf_getControl( "Edit78_4", 78 )
	Send, !n
	return

SubPicture78_5:
	glob_stockEditValue := guf_getControl( "Edit78_5", 78 )
	Send, !n
	return

SubPicture78_6:
	glob_stockEditValue := guf_getControl( "Edit78_6", 78 )
	Send, !n
	return

SubPicture78_7:
	glob_stockEditValue := guf_getControl( "Edit78_7", 78 )
	Send, !n
	return

SubPicture78_8:
	glob_stockEditValue := guf_getControl( "Edit78_8", 78 )
	Send, !n
	return

SubPicture78_9:
	glob_stockEditValue := guf_getControl( "Edit78_9", 78 )
	Send, !n
	return

SubPicture78_10:
	glob_stockEditValue := guf_getControl( "Edit78_10", 78 )
	Send, !n
	return

SubEdit78_1:
	edi_autoImageSetFromText("Edit78_1", "Picture78_1", 78)
	return

SubEdit78_2:
	edi_autoImageSetFromText("Edit78_2", "Picture78_2", 78)
	return

SubEdit78_3:
	edi_autoImageSetFromText("Edit78_3", "Picture78_3", 78)
	return

SubEdit78_4:
	edi_autoImageSetFromText("Edit78_4", "Picture78_4", 78)
	return

SubEdit78_5:
	edi_autoImageSetFromText("Edit78_5", "Picture78_5", 78)
	return

SubEdit78_6:
	edi_autoImageSetFromText("Edit78_6", "Picture78_6", 78)
	return

SubEdit78_7:
	edi_autoImageSetFromText("Edit78_7", "Picture78_7", 78)
	return

SubEdit78_8:
	edi_autoImageSetFromText("Edit78_8", "Picture78_8", 78)
	return

SubEdit78_9:
	edi_autoImageSetFromText("Edit78_9", "Picture78_9", 78)
	return

SubEdit78_10:
	edi_autoImageSetFromText("Edit78_10", "Picture78_10", 78)
	return

SubHidenButton78_1:
	edc_stockCommExeLogic(78)
	return


SubHotkey79_1:
	hoit_hotkeyControlInput()
	return

SubButton79_1:
	hoit_everHotkeySubmit()
	return

SubButton79_2:
	Gui, 79:Hide
	return


SubList80_1:
	hoit_autoExplainFromLongKeyName( "BoxEdit80_1", "BoxEdit80_1_2", "Text80_1_2", "Text80_1_3", 80 )
	return

SubList80_2:
	hoit_autoSetSystemHotkey( "BoxEdit80_2", 80 )
	return

SubButton80_1_1:
	hoit_hotkeyEditFromGui()
	return

SubButton80_1_2:
	hoit_everHotkeyShow("")
	return

SubButton80_1_3:
	hoit_hotkeyDeleteFromGui()
	return



SubButton81_1:
	syf_managerConfigWrite()
	return

SubButton81_2:
	Gui, 81:Hide
	return


SubButton82_1:
	Gui, 82:Submit, NoHide
	musc_multipleScriptsExeWrapper(BoxEdit82_1, "BoxEdit82_1", 82, gGlob_hwndBoxEdit82_1)
	return

SubButton82_2:
	Gui, 82:Submit
	musc_showMultipleScriptsGui(BoxEdit82_1)
	return



SubEdit83_1_2:
	musc_setMultipleItemPictuer()
	return

SubUpDown83_1_1:
	musc_setMultipleItemPictuer()
	return

SubButton83_1_1:
	Gui, 83:Submit, NoHide
	musc_submitMultipleScriptsEntry(Edit83_1_1, BoxEdit83_1_1, BoxEdit83_1_2, Edit83_1_2, UpDown83_1_1, Checkbox83_1_1)
	return

SubButton83_1_2:
	Gui, 83:Show, Hide
	return

SubButton83_1_3:
	Gui, 83:Hide
	windc_anyWaitActive()
	ite_showGui72("", "", 1)
	return

SubButton83_1_4:
	musc_historyNotAddSignInsert()
	return


SubButton84_1:
	syf_lastWordConfigGuiSetting()
	Gui, 84:Hide
	return

SubButton84_2:
	Gui, 84:Hide
	return

SubCheckbox84_1:
	notGlobalStr := guf_getControl( "Checkbox84_1", 84 )
	cen_switchEnableLastWordGui(notGlobalStr)
	return

SubCheckbox84_2_1:
	notGlobalStr := guf_getControl( "Checkbox84_2_1", 84 )
	cen_switchEnableLastWordAnyTab(notGlobalStr, 2)
	return

SubCheckbox84_3_1:
	notGlobalStr := guf_getControl( "Checkbox84_3_1", 84 )
	cen_switchEnableLastWordAnyTab(notGlobalStr, 3)
	return

SubCheckbox84_4_1:
	notGlobalStr := guf_getControl( "Checkbox84_4_1", 84 )
	cen_switchEnableLastWordAnyTab(notGlobalStr, 4)
	return

SubCheckbox84_5_1:
	notGlobalStr := guf_getControl( "Checkbox84_5_1", 84 )
	cen_switchEnableLastWordAnyTab(notGlobalStr, 5)
	return

SubCheckbox84_6_1:
	notGlobalStr := guf_getControl( "Checkbox84_6_1", 84 )
	cen_switchEnableLastWordAnyTab(notGlobalStr, 6)
	return

SubCheckbox84_7_1:
	notGlobalStr := guf_getControl( "Checkbox84_7_1", 84 )
	cen_switchEnableLastWordChangeChoice(notGlobalStr, "Edit84_7_1_1", "Edit84_7_1_2", "Edit84_7_1_3", "Edit84_7_1_4")
	return

SubCheckbox84_7_2:
	notGlobalStr := guf_getControl( "Checkbox84_7_2", 84 )
	cen_switchEnableLastWordChangeChoice(notGlobalStr, "Edit84_7_2_1", "Edit84_7_2_2", "Edit84_7_2_3", "Edit84_7_2_4")
	return

SubCheckbox84_7_3:
	notGlobalStr := guf_getControl( "Checkbox84_7_3", 84 )
	cen_switchEnableLastWordChangeChoice(notGlobalStr, "Edit84_7_3_1", "Edit84_7_3_2", "Edit84_7_3_3", "Edit84_7_3_4")
	return

SubButton85_1:
	syf_needReloadGuiSettingConfirm()
	return

SubButton85_2:
	Gui, 85:Hide
	return


SubButton86_1:
	syf_exceptionOfUserGuiSettingConfirm()
	return

SubButton86_2:
	Gui, 86:Hide
	return

SubButton86_3:
	cen_selectFolderButton("Edit86_1", 86)
	return

SubButton86_4:
	cen_relativButton("Edit86_1", 86)
	return

SubButton86_5:
	cen_absoleButton("Edit86_1", 86)
	return

SubButton86_6:
	syf_userDirChangeDefaultButton()
	return

SubCheckbox86_1:
	Checkbox86_1 := guf_getControl( "Checkbox86_1", 86 )
	guf_switchEnableByFlag(Checkbox86_1, "Edit86_1", 86)
	guf_switchEnableByFlag(Checkbox86_1, "Edit86_2", 86)
	return



SubButton87_1:
	timf_stopAnyTimerChangeHeight(1)
	return

SubButton87_2:
	timf_stopAnyTimerChangeHeight(2)
	return

SubButton87_3:
	timf_stopAnyTimerChangeHeight(3)
	return

SubButton87_4:
	timf_stopAnyTimerChangeHeight(4)
	return

SubButton87_5:
	timf_stopAnyTimerChangeHeight(5)
	return

SubButton87_6:
	timf_stopAnyTimerChangeHeight(6)
	return

SubButton87_7:
	timf_stopAnyTimerChangeHeight(7)
	return

SubButton87_8:
	timf_stopAnyTimerChangeHeight(8)
	return

SubButton87_9:
	timf_stopAnyTimerChangeHeight(9)
	return

SubButton87_10:
	timf_stopAnyTimerChangeHeight(10)
	return


; シャットダウンの
SubButton88_1:
	SetTimer, SubTimerShutDown, Off
	Gui, 88:Hide
	return


SubList89_1_1:
	cen_autoEditSysExplanation("List89_1_1", "BoxEdit89_1_1", 89)
	return

SubList89_2_1:
	outs_controlValueToOtherControl("List89_2_1", "BoxEdit89_2_1", 89)
	return

SubList89_3_1:
	notGlobalStr := guf_getControl( "List89_3_1", 89 )
	guf_setControl( glob_specialWordObj[notGlobalStr], "BoxEdit89_3_1", 89  )
	return

SubList89_4_1:
	notGlobalStr := guf_getControl( "List89_4_1", 89 )
	guf_setControl( glob_userMakeWordObj[notGlobalStr], "BoxEdit89_4_1", 89  )
	return

SubList89_5_1:
	outs_controlValueToOtherControl("List89_5_1", "BoxEdit89_5_1", 89)
	return

SubList89_6_1:
	notGlobalStr := guf_getControl( "List89_6_1", 89 )
	guf_setControl( glob_optionVariableWordObj[notGlobalStr], "BoxEdit89_6_2", 89  )
	notGlobalStr := outs_ansValuePersent(notGlobalStr)
	guf_setControl( notGlobalStr, "BoxEdit89_6_1", 89 )
	return

SubList89_7_1:
	notGlobalStr := guf_getControl( "List89_7_1", 89 )
	cinp_autoSetSnippet( notGlobalStr, "Edit89_7_1", "Checkbox89_7_1", "Text89_7_2", "Text89_7_3", 89 )
	return

SubButton89_7_1:
	Gui, 89:Submit, NoHide
	cinp_submitSnippetEdit(List89_7_1, Edit89_7_1, Checkbox89_7_1)
	return

SubButton89_7_2:
	Gui, 89:Submit, NoHide
	cinp_submitSnippetEntry(Edit89_7_2, Edit89_7_1, Checkbox89_7_1)
	return

SubButton89_7_4:
	notGlobalStr := guf_getControl( "List89_7_1", 89 )
	cinp_submitSnippetDelete(notGlobalStr, 63)
	return
