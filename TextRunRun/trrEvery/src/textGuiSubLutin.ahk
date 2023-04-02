

61GuiEscape:
	if( guaf_listVisibleEditss(61) ){
		return
	}
	; テキストを最小化させる設定
	;if( glob_iniTextGuiMinimize ){
	if( O_minimizeTextFlag ){
		Gui, 61:Minimize
		return
	}
	Gui, 61:Show, Hide
	return

61GuiContextMenu:
	if(A_GuiEvent == "RightClick"){
		edi_GuiContextMenu(A_GuiControl, 61)
	}
	return

61GuiDropFiles:
	StringSplit, filess, A_GuiEvent,`n
	guf_setControl( filess1, "Edit61_2", 61 )
	guf_setControl( A_GuiEvent, "BoxEdit61_1", 61 )
	return

62GuiEscape:
	if( guaf_listVisibleEditss(62) ){
		return
	}
	; テキストを最小化させる設定
	;if( glob_iniTextGuiMinimize ){
	if( O_minimizeTextFlag ){
		Gui, 62:Minimize
		return
	}
	Gui, 62:Show, Hide
	return

62GuiContextMenu:
	if(A_GuiEvent == "RightClick"){
		edi_GuiContextMenu(A_GuiControl, 62)
	}
	return

62GuiDropFiles:
	StringSplit, filess, A_GuiEvent,`n
	guf_setControl( filess1, "Edit62_2", 62 )
	guf_setControl( A_GuiEvent, "BoxEdit62_1", 62 )
	return

63GuiClose:
	; テキスト１が閉じたら終了の設定かどうか
	edi_exitAppIfCommGuiOnlyFlag()
	edi_commListHideAnotherGui()
	Gui, 63:Hide
	return

63GuiEscape:
	;if( edi_commListHide("List63_1", "Edit63_1", 63) ){
	;	return
	;}
	if( edi_commListHideAnotherGui() ){
		return
	}

	Gui, 68:Show, Hide
	; テキストを最小化させる設定
	;if( glob_iniTextGuiMinimize ){
	if( O_minimizeTextFlag ){
		Gui, 63:Minimize
		return
	}
	; テキスト１が閉じたら終了の設定かどうか
	edi_exitAppIfCommGuiOnlyFlag()
	Gui, 63:Show, Hide
	return

63GuiContextMenu:
	if(A_GuiEvent == "RightClick"){
		edi_GuiContextMenu(A_GuiControl, 63)
	}
	return

63GuiDropFiles:
	StringSplit, filess, A_GuiEvent,`n
	guf_setControl( filess1, "Edit63_1", 63 )
	return


64GuiClose:
	edi_commListHideAnotherGui()
	Gui, 64:Hide
	return


64GuiEscape:
	;if( edi_commListHide("List64_1", "Edit64_1", 64) ){
	;	return
	;}
	if( edi_commListHideAnotherGui() ){
		return
	}

	Gui, 68:Show, Hide
	; テキストを最小化させる設定
	;if( glob_iniTextGuiMinimize ){
	if( O_minimizeTextFlag ){
		Gui, 64:Minimize
		return
	}
	Gui, 64:Show, Hide
	return

64GuiContextMenu:
	if(A_GuiEvent == "RightClick"){
		edi_GuiContextMenu(A_GuiControl, 64)
	}
	return

64GuiDropFiles:
	StringSplit, filess, A_GuiEvent,`n
	guf_setControl( filess1, "Edit64_1", 64 )
	return


65GuiClose:
	edi_commListHideAnotherGui()
	Gui, 65:Hide
	return

65GuiEscape:
	;if( edi_commListHide("List65_1", "Edit65_1", 65) ){
	;	return
	;}
	if( edi_commListHideAnotherGui() ){
		return
	}

	Gui, 68:Show, Hide
	; テキストを最小化させる設定
	;if( glob_iniTextGuiMinimize ){
	if( O_minimizeTextFlag ){
		Gui, 65:Minimize
		return
	}
	Gui, 65:Show, Hide
	return

65GuiContextMenu:
	if(A_GuiEvent == "RightClick"){
		edi_GuiContextMenu(A_GuiControl, 65)
	}
	return

65GuiDropFiles:
	StringSplit, filess, A_GuiEvent,`n
	guf_setControl( filess1, "Edit65_1", 65 )
	return


66GuiEscape:
	;if(guf_controlHideDisable("List66_1", 66)){
	;	return
	;}
	Gui, 66:Show, Hide
	return

66GuiSize:
	tmpNumW := A_GuiWidth - 20
	;width2 := A_GuiWidth - 120
	tmpNumH := A_GuiHeight - 45
	changeY1 := tmpNumH + 10
	;changeY2 := changeY1 + 45
	;changeX := width2 + 40
	;changeY3 := changeY1 + 15
	GuiControl, 66:Move, BoxEdit66_1, w%tmpNumW%  h%tmpNumH%
	;GuiControl, 66:Move, Text66_1,  y%changeY1%
	;GuiControl, 66:Move, Edit66_1,  y%changeY3%  w%width2%
	;GuiControl, 66:Move, Picture66_1,     x%changeX%  y%changeY1%
	;GuiControl, 66:Move, HidenButton66_1, x%changeX%  y%changeY1%
	GuiControl, 66:Move, Button66_1,  y%changeY1%
	GuiControl, 66:Move, Button66_2,  y%changeY1%
	return


67GuiEscape:
	Gui, 67:Hide
	return

67GuiSize:
	tmpNumW := A_GuiWidth - 20
	tmpNumH := A_GuiHeight - 20
	GuiControl, 67:Move, BoxEdit67_1, w%tmpNumW%  h%tmpNumH%
	return

68GuiEscape:
	Gui, 68:Show, Hide
	return

68GuiSize:
	tmpNumW := A_GuiWidth - 20
	tmpNumH := A_GuiHeight - 20
	GuiControl, 68:Move, BoxEdit68_1, w%tmpNumW%  h%tmpNumH%
	return

69GuiEscape:
	Gui, 69:Hide
	return

69GuiSize:
	tmpNumW := A_GuiWidth - 20
	tmpNumH := A_GuiHeight - 50
	GuiControl, 69:Move, Edit69_1, w%tmpNumW%
	GuiControl, 69:Move, BoxEdit69_1, w%tmpNumW%  h%tmpNumH%
	return

70GuiEscape:
	Gui, 70:Hide
	return

70GuiContextMenu:
	if(A_GuiEvent == "RightClick"){
		edi_GuiContextMenu(A_GuiControl, 70)
	}
	return

70GuiSize:
	tmpNumW := A_GuiWidth
	tmpNumH := A_GuiHeight + 15
	GuiControl, 70:Move, List70_1, w%tmpNumW%  h%tmpNumH%
	return

74GuiEscape:
	Gui, 74:Hide
	return

SubEdit61_1:
	Edit61_1 := guf_getControl( "Edit61_1", 61 )
	edi_textSizeChangeCommbox(Edit61_1, "Edit61_1", O_widthOneCharTextSplit1, O_widthBasisTextSplit1, O_widthMaxLowerTextSplit1, O_widthStartCharCountTextSplit1, gGlob_Gui61Title, O_widthWindowBasisTextSplit1, O_widthNotFlagTextSplit1, 61)
	aut_controlKeyUpDownTestList1(True)
	auts_autoPouUpListSyscommUserMakeWord( Edit61_1, "List61_1", 61)
	aut_autoSysCommExplanation( Edit61_1, "BoxEdit61_2", 61 )
	edc_viewPopupFromAutoFlag(Edit61_1, "Edit61_1", 61, "List61_1", 61)
	lasw_autoExecuteFromLastWord( "Edit61_1", "List61_1", gGlob_Gui61Title, 61 )
	return

SubEdit61_2:
	Edit61_2 := guf_getControl( "Edit61_2", 61 )
	edi_textSizeChangeCommbox(Edit61_2, "Edit61_2", O_widthOneCharTextSplit1, O_widthBasisTextSplit1, O_widthMaxLowerTextSplit1, O_widthStartCharCountTextSplit1, gGlob_Gui61Title, O_widthWindowBasisTextSplit1, O_widthNotFlagTextSplit1, 61)
	aut_controlKeyUpDownTestList2(True)
	Edit61_2 := outs_textOutDqAllTrim(Edit61_2)
	Edit61_2 := aut_checkDangerStr(Edit61_2)
	auts_popUpEny( Edit61_2, "List61_2", 61)
	aut_pictuerSetByFileOrObj( Edit61_2, glob_textNoneFile, glob_textHaveFile, "BoxEdit61_2", 61, "Picture61_1", 61, True, "")
	aut_autoSysCommExplanation( Edit61_2, "BoxEdit61_2", 61 )
	edc_viewPopupFromAutoFlag(Edit61_2, "Edit61_2", 61, "List61_2", 61)
	lasw_autoExecuteFromLastWord( "Edit61_2", "List61_2", gGlob_Gui61Title, 61 )
	return

SubEdit61_3:
	Edit61_3 := guf_getControl( "Edit61_3", 61 )
	edi_textSizeChangeCommbox(Edit61_3, "Edit61_3", O_widthOneCharTextSplit1, O_widthBasisTextSplit1, O_widthMaxLowerTextSplit1, O_widthStartCharCountTextSplit1, gGlob_Gui61Title, O_widthWindowBasisTextSplit1, O_widthNotFlagTextSplit1, 61)
	aut_controlKeyUpDownTestList3(True)
	Edit61_3 := outs_textOutDqAllTrim(Edit61_3)
	Edit61_3 := aut_checkDangerStr(Edit61_3)
	auts_popUpEny( Edit61_3, "List61_3", 61)
	edc_viewPopupFromAutoFlag(Edit61_3, "Edit61_3", 61, "List61_3", 61)
	lasw_autoExecuteFromLastWord( "Edit61_3", "List61_3", gGlob_Gui61Title, 61 )
	return

SubEdit61_4:
	Edit61_4 := guf_getControl( "Edit61_4", 61 )
	edi_textSizeChangeCommbox(Edit61_4, "Edit61_4", O_widthOneCharTextSplit1, O_widthBasisWorkDirTextSplit1, O_widthMaxLowerTextSplit1, O_widthStartCharCountTextSplit1, gGlob_Gui61Title, O_widthWindowBasisTextSplit1, O_widthNotFlagTextSplit1, 61)
	aut_controlKeyUpDownTestList4(True)
	Edit61_4 := outs_textOutDqAllTrim(Edit61_4)
	Edit61_4 := aut_checkDangerStr(Edit61_4)
	auts_autoPopUpItemAndFolderList( Edit61_4, "List61_4", 61)
	edc_viewPopupFromAutoFlag(Edit61_4, "Edit61_4", 61, "List61_4", 61)
	;lasw_autoExecuteFromLastWord( "Edit61_4", "List61_4", gGlob_Gui61Title, 61 )
	return

SubEdit61_5:
	Edit61_5 := guf_getControl( "Edit61_5", 61 )
	;edi_textSizeChangeCommbox(Edit61_5, "Edit61_5", O_widthOneCharTextSplit1, 205, O_widthMaxLowerTextSplit1, O_widthStartCharCountTextSplit1, gGlob_Gui61Title, O_widthWindowBasisTextSplit1, O_widthNotFlagTextSplit1, 61)
	aut_controlKeyUpDownTestList5(True)
	Edit61_5 := outs_textOutDqAllTrim(Edit61_5)
	Edit61_5 := aut_checkDangerStr(Edit61_5)
	auts_popUpEny( Edit61_5, "List61_5", 61)
	edc_viewPopupFromAutoFlag(Edit61_5, "Edit61_5", 61, "List61_5", 61)
	;lasw_autoExecuteFromLastWord( "Edit61_5", "List61_5", gGlob_Gui61Title, 61 )
	return

SubButton61_1:
	Gui, 61:Submit, NoHide
	edc_editssCommExeLogicWrapperOfWrapper(O_enterExeTextSplit1Before, O_enterExeTextSplit1After, O_anyKeyExeTextSplit1After, Edit61_1, Edit61_2, Edit61_3, Edit61_4, Edit61_5, Edit61_6, Edit61_7, Edit61_8, Checkbox61_1, 61)
	return

SubHidenButton61_1:
	edc_popupShowEditType(61, 1, 2)
	return

SubPicture61_1:
	Send, !n
	return




SubEdit62_1:
	Edit62_1 := guf_getControl( "Edit62_1", 62 )
	edi_textSizeChangeCommbox(Edit62_1, "Edit62_1", O_widthOneCharTextSplit2, O_widthBasisTextSplit2, O_widthMaxLowerTextSplit2, O_widthStartCharCountTextSplit2, gGlob_Gui62Title, O_widthWindowBasisTextSplit2, O_widthNotFlagTextSplit2, 62)
	aut_controlKeyUpDownTestList1(True)
	auts_autoPouUpListSyscommUserMakeWord( Edit62_1, "List62_1", 62)
	aut_autoSysCommExplanation( Edit62_1, "BoxEdit62_2", 62 )
	edc_viewPopupFromAutoFlag(Edit62_1, "Edit62_1", 62, "List62_1", 62)
	lasw_autoExecuteFromLastWord( "Edit62_1", "List62_1", gGlob_Gui62Title, 62 )
	return

SubEdit62_2:
	Edit62_2 := guf_getControl( "Edit62_2", 62 )
	edi_textSizeChangeCommbox(Edit62_2, "Edit62_2", O_widthOneCharTextSplit2, O_widthBasisTextSplit2, O_widthMaxLowerTextSplit2, O_widthStartCharCountTextSplit2, gGlob_Gui62Title, O_widthWindowBasisTextSplit2, O_widthNotFlagTextSplit2, 62)
	aut_controlKeyUpDownTestList2(True)
	Edit62_2 := outs_textOutDqAllTrim(Edit62_2)
	Edit62_2 := aut_checkDangerStr(Edit62_2)
	auts_popUpEny( Edit62_2, "List62_2", 62)
	aut_pictuerSetByFileOrObj( Edit62_2, glob_textNoneFile, glob_textHaveFile, "BoxEdit62_2", 62, "Picture62_1", 62, True, "")
	aut_autoSysCommExplanation( Edit62_2, "BoxEdit62_2", 62 )
	edc_viewPopupFromAutoFlag(Edit62_2, "Edit62_2", 62, "List62_2", 62)
	lasw_autoExecuteFromLastWord( "Edit62_2", "List62_2", gGlob_Gui62Title, 62 )
	return

SubEdit62_3:
	Edit62_3 := guf_getControl( "Edit62_3", 62 )
	edi_textSizeChangeCommbox(Edit62_3, "Edit62_3", O_widthOneCharTextSplit2, O_widthBasisTextSplit2, O_widthMaxLowerTextSplit2, O_widthStartCharCountTextSplit2, gGlob_Gui62Title, O_widthWindowBasisTextSplit2, O_widthNotFlagTextSplit2, 62)
	aut_controlKeyUpDownTestList3(True)
	Edit62_3 := outs_textOutDqAllTrim(Edit62_3)
	Edit62_3 := aut_checkDangerStr(Edit62_3)
	auts_popUpEny( Edit62_3, "List62_3", 62)
	edc_viewPopupFromAutoFlag(Edit62_3, "Edit62_3", 62, "List62_3", 62)
	lasw_autoExecuteFromLastWord( "Edit62_3", "List62_3", gGlob_Gui62Title, 62 )
	return

SubEdit62_4:
	Edit62_4 := guf_getControl( "Edit62_4", 62 )
	edi_textSizeChangeCommbox(Edit62_4, "Edit62_4", O_widthOneCharTextSplit2, O_widthBasisWorkDirTextSplit2, O_widthMaxLowerTextSplit2, O_widthStartCharCountTextSplit2, gGlob_Gui62Title, O_widthWindowBasisTextSplit2, O_widthNotFlagTextSplit2, 62)
	aut_controlKeyUpDownTestList4(True)
	Edit62_4 := outs_textOutDqAllTrim(Edit62_4)
	Edit62_4 := aut_checkDangerStr(Edit62_4)
	auts_autoPopUpItemAndFolderList( Edit62_4, "List62_4", 62)
	edc_viewPopupFromAutoFlag(Edit62_4, "Edit62_4", 62, "List62_4", 62)
	;lasw_autoExecuteFromLastWord( "Edit62_4", "List62_4", gGlob_Gui62Title, 62 )
	return

SubEdit62_5:
	Edit62_5 := guf_getControl( "Edit62_5", 62 )
	;edi_textSizeChangeCommbox(Edit62_5, "Edit62_5", O_widthOneCharTextSplit2, 205, O_widthMaxLowerTextSplit2, O_widthStartCharCountTextSplit2, gGlob_Gui62Title, O_widthWindowBasisTextSplit2, O_widthNotFlagTextSplit2, 62)
	aut_controlKeyUpDownTestList5(True)
	Edit62_5 := outs_textOutDqAllTrim(Edit62_5)
	Edit62_5 := aut_checkDangerStr(Edit62_5)
	auts_popUpEny( Edit62_5, "List62_5", 62)
	edc_viewPopupFromAutoFlag(Edit62_5, "Edit62_5", 62, "List62_5", 62)
	;lasw_autoExecuteFromLastWord( "Edit62_5", "List62_5", gGlob_Gui62Title, 62 )
	return

SubButton62_1:
	Gui, 62:Submit, NoHide
	edc_editssCommExeLogicWrapperOfWrapper(O_enterExeTextSplit2Before, O_enterExeTextSplit2After, O_anyKeyExeTextSplit2After, Edit62_1, Edit62_2, Edit62_3, Edit62_4, Edit62_5, Edit62_6, Edit62_7, Edit62_8, Checkbox62_1, 62)
	return

SubHidenButton62_1:
	edc_popupShowEditType(62, 1, 2)
	return

SubPicture62_1:
	Send, !n
	return




SubEdit63_1:
	Edit63_1 := guf_getControl( "Edit63_1", 63 )
	edi_textSizeChangeEditMini(Edit63_1, "Edit63_1", O_widthOneCharText1, O_widthBasisText1, O_widthMaxLowerText1, O_widthStartCharCountText1, gGlob_Gui63Title, O_widthWindowBasisText1, O_widthNotFlagText1, 63)
	aut_controlKeyUpDownTestAnotherGui(True, 1)
	Edit63_1 := outs_textOutDqAllTrim(Edit63_1)
	Edit63_1 := aut_checkDangerStr(Edit63_1)
	edi_popUpEnyEditAnotherGui( Edit63_1 )
	aut_pictuerSetByFileOrObj( Edit63_1, glob_textNoneFile, glob_textHaveFile, "BoxEdit68_1", 68, "Picture63_1", 63, True, "")
	aut_autoSysCommExplanation( Edit63_1, "BoxEdit68_1", 68 )
	edc_viewPopupFromAutoFlag(Edit63_1, "Edit63_1", 63, "List70_1", 70)
	lasw_autoExecuteFromLastWord( "Edit63_1", "", gGlob_Gui63Title, 63 )
	return

SubHidenButton63_1:
	Gui, 63:Submit, NoHide
	edi_commandExeLogicWrapperOfWrapper(Edit63_1, O_enterExeText1Before, O_enterExeText1After, O_anyKeyExeText1After, "Edit63_1", 63, gGlob_hwndEdit63_1)
	return

SubHidenButton63_2:
	edc_popupShowEditType(63, 1, 2)
	return

SubPicture63_1:
	Send, !n
	return


SubEdit64_1:
	Edit64_1 := guf_getControl( "Edit64_1", 64 )
	edi_textSizeChangeEditMini(Edit64_1, "Edit64_1", O_widthOneCharText2, O_widthBasisText2, O_widthMaxLowerText2, O_widthStartCharCountText2, gGlob_Gui64Title, O_widthWindowBasisText2, O_widthNotFlagText2, 64)
	aut_controlKeyUpDownTestAnotherGui(True, 1)
	Edit64_1 := outs_textOutDqAllTrim(Edit64_1)
	Edit64_1 := aut_checkDangerStr(Edit64_1)
	edi_popUpEnyEditAnotherGui( Edit64_1 )
	aut_pictuerSetByFileOrObj( Edit64_1, glob_textNoneFile, glob_textHaveFile, "BoxEdit68_1", 68, "Picture64_1", 64, True, "")
	aut_autoSysCommExplanation( Edit64_1, "BoxEdit68_1", 68 )
	edc_viewPopupFromAutoFlag(Edit64_1, "Edit64_1", 64, "List70_1", 70)
	lasw_autoExecuteFromLastWord( "Edit64_1", "", gGlob_Gui64Title, 64 )
	return

SubHidenButton64_1:
	Gui, 64:Submit, NoHide
	edi_commandExeLogicWrapperOfWrapper(Edit64_1, O_enterExeText2Before, O_enterExeText2After, O_anyKeyExeText2After, "Edit64_1", 64, gGlob_hwndEdit64_1)
	return

SubHidenButton64_2:
	edc_popupShowEditType(64, 1, 2)
	return

SubPicture64_1:
	Send, !n
	return


SubEdit65_1:
	Edit65_1 := guf_getControl( "Edit65_1", 65 )
	edi_textSizeChangeEditMini(Edit65_1, "Edit65_1", O_widthOneCharText3, O_widthBasisText3, O_widthMaxLowerText3, O_widthStartCharCountText3, gGlob_Gui65Title, O_widthWindowBasisText3, O_widthNotFlagText3, 65)
	aut_controlKeyUpDownTestAnotherGui(True, 1)
	Edit65_1 := outs_textOutDqAllTrim(Edit65_1)
	Edit65_1 := aut_checkDangerStr(Edit65_1)
	edi_popUpEnyEditAnotherGui( Edit65_1 )
	aut_pictuerSetByFileOrObj( Edit65_1, glob_textNoneFile, glob_textHaveFile, "BoxEdit68_1", 68, "Picture65_1", 65, True, "")
	aut_autoSysCommExplanation( Edit65_1, "BoxEdit68_1", 68 )
	edc_viewPopupFromAutoFlag(Edit65_1, "Edit65_1", 65, "List70_1", 70)
	lasw_autoExecuteFromLastWord( "Edit65_1", "", gGlob_Gui65Title, 65 )
	return

SubHidenButton65_1:
	Gui, 65:Submit, NoHide
	edi_commandExeLogicWrapperOfWrapper(Edit65_1, O_enterExeText3Before, O_enterExeText3After, O_anyKeyExeText3After, "Edit65_1", 65, gGlob_hwndEdit65_1)
	return

SubHidenButton65_2:
	edc_popupShowEditType(65, 1, 2)
	return

SubPicture65_1:
	Send, !n
	return


SubButton66_1:
	guaf_cleanBoxEdit66_1()
	return

SubButton66_2:
	guaf_returnBoxEdit66_1()
	return

SubHidenButton70_1:
	edi_pushEnterFromListEditAnotherGui(glob_nowAutoPopGui, False)
	return

SubHidenButton70_2:
	edc_popupShowEditType(glob_nowAutoPopGui, 1, 2)
	return


SubButton74_3_1:
	syf_showSetLastWordConfigToggle("_", True)
	return

SubButton74_3_2:
	syf_showAndExceptionOfUserGuiSet()
	return

SubButton74_3_3:
	syf_showAndNeedReloadGuiSet()
	return

SubButton74_1_1:
	syf_configGui()
	Gui, 74:Hide
	return

SubButton74_1_2:
	Gui, 74:Hide
	return

SubCheckbox74_8:
	Checkbox74_8 := guf_getControl( "Checkbox74_8", 74 )
	guf_switchEnableByFlag(Checkbox74_8, "Edit74_4", 74)
	return
