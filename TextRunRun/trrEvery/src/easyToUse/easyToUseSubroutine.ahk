




E_donothing:

	return

E_guiPositionSave:
	cen_ahkGuiSizePosSave()
	guit_setExplainNotShow("このソフトのGuiの位置とサイズを保存した", 71)
	return

E_guiPositionInit:
	init_initGuiAll()
	cen_clickOnlyGuiShow()
	;cen_ahkGuiSizePosSave()
	outs_deleteAndMakeFile(gloco_userDir . glob_tmpAhkGuiSizePosFileName, gloco_userDir . glob_userTmpDirName)
	guit_setExplainNotShow("このソフトのGuiの位置とサイズを最初の状態に戻した", 71)
	return

E_showText1Toggle:
	edi_showHideGuiTextPattern(63, True, True)
	return

E_showText2Toggle:
	edi_showHideGuiTextPattern(64, True, True)
	return

E_showText3Toggle:
	edi_showHideGuiTextPattern(65, True, True)
	return

E_showTextSplit1Toggle:
	edi_showHideGuiTextPattern(61, True, True)
	return

E_showTextSplit2Toggle:
	edi_showHideGuiTextPattern(62, True, True)
	return

E_showTimerGuiToggle:
	timf_showOrHideTimerGui()
	return

E_showClickWindow:
	guf_showGuiAssign(76, "NA")
	return

E_closeClickWindow:
	Gui, 76:Hide
	return

E_showConfigToggle:
	syf_showSetConfigToggle()
	return

E_showItemListGuiToggle:
	ite_itemLookGuiToggle()
	return

E_showHotkeyListGuiToggle:
	intchf_showHotkeyListGuiToggle()
	return

E_showEverInputGuiToggle:
	cen_showEverInputGui()
	return

E_showLastWordToggle:
	syf_showSetLastWordConfigToggle("_", True)
	return

E_showText1ToggleForClick:
	guf_showHideEnyGui("Edit63_1", 63)
	return

E_showText2ToggleForClick:
	guf_showHideEnyGui("Edit64_1", 64)
	return

E_showText3ToggleForClick:
	guf_showHideEnyGui("Edit65_1", 65)
	return

E_showTextSplit1ToggleForClick:
	guf_showHideEnyGui("Edit61_1", 61)
	return

E_showTextSplit2ToggleForClick:
	guf_showHideEnyGui("Edit62_1", 62)
	return

E_showStock1Toggle:
	guf_showHideEnyGui("Edit77_1", 77)
	return

E_showStock2Toggle:
	guf_showHideEnyGui("Edit78_1", 78)
	return

E_showTmpOutputToggle:
	guf_showHideEnyGui("BoxEdit68_1", 68)
	return

E_showOutputToggle:
	guf_showHideEnyGui("BoxEdit66_1", 66)
	return

E_showErrorOutputToggle:
	guf_showHideEnyGui("BoxEdit67_1", 67)
	return

E_showMultipleText1Toggle:
	WinWaitActive , A, , 1
	guf_showHideEnyGui("BoxEdit82_1", 82)
	return

E_hideGuiTextAndWaitActiveAny:
	if(A_Gui != ""){
		edi_hideOrMinimizeGuiTextPattern(A_Gui, True, False, False)
	}
	windc_anyWaitActive()
	return

E_SuspendOn:
	Suspend , On
	cen_trayIconChangeFromSuspendOrPause()
	return

E_SuspendOff:
	Suspend , Off
	cen_trayIconChangeFromSuspendOrPause()
	return

E_SuspendToggle:
	Suspend , Toggle
	cen_trayIconChangeFromSuspendOrPause()
	if( O_suspendNotViewFlag == False ){
		if( A_IsSuspended == 1 ){
			guit_setExplainToolTip("Suspendオン")
		} else {
			guit_setExplainToolTip("Suspendオフ")
		}
	}
	return

E_PauseOn:
	cen_trayPauseIconChangeBefore()
	Pause , On
	cen_trayIconChangeFromSuspendOrPause()
	return

E_PauseOff:
	Pause , Off
	cen_trayIconChangeFromSuspendOrPause()
	return

E_inputListUpKey:
	edi_UpDownKeyTextAny(1)
	return

E_inputListDownKey:
	edi_UpDownKeyTextAny(2)
	return

E_inputListPageUp:
	edi_UpDownKeyTextAny(3)
	return

E_inputListPageDown:
	edi_UpDownKeyTextAny(4)
	return

E_lastWordRestoreFirst:
	O_lastWordTabAllFlag2 := B_lastWordTabAllStartFlag2
	O_lastWordTabAllFlag3 := B_lastWordTabAllStartFlag3
	O_lastWordTabAllFlag4 := B_lastWordTabAllStartFlag4
	O_lastWordTabAllFlag5 := B_lastWordTabAllStartFlag5
	O_lastWordScript2_1 := B_lastWordScriptStart2_1
	O_lastWordScript2_2 := B_lastWordScriptStart2_2
	O_lastWordScript2_3 := B_lastWordScriptStart2_3
	O_lastWordScript2_4 := B_lastWordScriptStart2_4
	O_lastWordScript2_5 := B_lastWordScriptStart2_5
	O_lastWordScript2_6 := B_lastWordScriptStart2_6
	O_lastWordScript2_7 := B_lastWordScriptStart2_7
	O_lastWordScript2_8 := B_lastWordScriptStart2_8
	O_lastWordScript2_9 := B_lastWordScriptStart2_9
	O_lastWordScript2_10 := B_lastWordScriptStart2_10
	O_lastWordScript3_1 := B_lastWordScriptStart3_1
	O_lastWordScript3_2 := B_lastWordScriptStart3_2
	O_lastWordScript3_3 := B_lastWordScriptStart3_3
	O_lastWordScript3_4 := B_lastWordScriptStart3_4
	O_lastWordScript3_5 := B_lastWordScriptStart3_5
	O_lastWordScript3_6 := B_lastWordScriptStart3_6
	O_lastWordScript3_7 := B_lastWordScriptStart3_7
	O_lastWordScript3_8 := B_lastWordScriptStart3_8
	O_lastWordScript3_9 := B_lastWordScriptStart3_9
	O_lastWordScript3_10 := B_lastWordScriptStart3_10
	O_lastWordScript4_1 := B_lastWordScriptStart4_1
	O_lastWordScript4_2 := B_lastWordScriptStart4_2
	O_lastWordScript4_3 := B_lastWordScriptStart4_3
	O_lastWordScript4_4 := B_lastWordScriptStart4_4
	O_lastWordScript4_5 := B_lastWordScriptStart4_5
	O_lastWordScript4_6 := B_lastWordScriptStart4_6
	O_lastWordScript4_7 := B_lastWordScriptStart4_7
	O_lastWordScript4_8 := B_lastWordScriptStart4_8
	O_lastWordScript4_9 := B_lastWordScriptStart4_9
	O_lastWordScript4_10 := B_lastWordScriptStart4_10
	O_lastWordScript5_1 := B_lastWordScriptStart5_1
	O_lastWordScript5_2 := B_lastWordScriptStart5_2
	O_lastWordScript5_3 := B_lastWordScriptStart5_3
	O_lastWordScript5_4 := B_lastWordScriptStart5_4
	O_lastWordScript5_5 := B_lastWordScriptStart5_5
	O_lastWordScript5_6 := B_lastWordScriptStart5_6
	O_lastWordScript5_7 := B_lastWordScriptStart5_7
	O_lastWordScript5_8 := B_lastWordScriptStart5_8
	O_lastWordScript5_9 := B_lastWordScriptStart5_9
	O_lastWordScript5_10 := B_lastWordScriptStart5_10
	O_lastWordKey2_1 := B_lastWordKeyStart2_1
	O_lastWordKey2_2 := B_lastWordKeyStart2_2
	O_lastWordKey2_3 := B_lastWordKeyStart2_3
	O_lastWordKey2_4 := B_lastWordKeyStart2_4
	O_lastWordKey2_5 := B_lastWordKeyStart2_5
	O_lastWordKey2_6 := B_lastWordKeyStart2_6
	O_lastWordKey2_7 := B_lastWordKeyStart2_7
	O_lastWordKey2_8 := B_lastWordKeyStart2_8
	O_lastWordKey2_9 := B_lastWordKeyStart2_9
	O_lastWordKey2_10 := B_lastWordKeyStart2_10
	O_lastWordKey3_1 := B_lastWordKeyStart3_1
	O_lastWordKey3_2 := B_lastWordKeyStart3_2
	O_lastWordKey3_3 := B_lastWordKeyStart3_3
	O_lastWordKey3_4 := B_lastWordKeyStart3_4
	O_lastWordKey3_5 := B_lastWordKeyStart3_5
	O_lastWordKey3_6 := B_lastWordKeyStart3_6
	O_lastWordKey3_7 := B_lastWordKeyStart3_7
	O_lastWordKey3_8 := B_lastWordKeyStart3_8
	O_lastWordKey3_9 := B_lastWordKeyStart3_9
	O_lastWordKey3_10 := B_lastWordKeyStart3_10
	O_lastWordKey4_1 := B_lastWordKeyStart4_1
	O_lastWordKey4_2 := B_lastWordKeyStart4_2
	O_lastWordKey4_3 := B_lastWordKeyStart4_3
	O_lastWordKey4_4 := B_lastWordKeyStart4_4
	O_lastWordKey4_5 := B_lastWordKeyStart4_5
	O_lastWordKey4_6 := B_lastWordKeyStart4_6
	O_lastWordKey4_7 := B_lastWordKeyStart4_7
	O_lastWordKey4_8 := B_lastWordKeyStart4_8
	O_lastWordKey4_9 := B_lastWordKeyStart4_9
	O_lastWordKey4_10 := B_lastWordKeyStart4_10
	O_lastWordKey5_1 := B_lastWordKeyStart5_1
	O_lastWordKey5_2 := B_lastWordKeyStart5_2
	O_lastWordKey5_3 := B_lastWordKeyStart5_3
	O_lastWordKey5_4 := B_lastWordKeyStart5_4
	O_lastWordKey5_5 := B_lastWordKeyStart5_5
	O_lastWordKey5_6 := B_lastWordKeyStart5_6
	O_lastWordKey5_7 := B_lastWordKeyStart5_7
	O_lastWordKey5_8 := B_lastWordKeyStart5_8
	O_lastWordKey5_9 := B_lastWordKeyStart5_9
	O_lastWordKey5_10 := B_lastWordKeyStart5_10
	O_betweenWordTabAllFlag1 := B_betweenWordTabAllStartFlag1
	O_betweenWordScript1_1 := B_betweenWordScriptStart1_1
	O_betweenWordScript1_2 := B_betweenWordScriptStart1_2
	O_betweenWordScript1_3 := B_betweenWordScriptStart1_3
	O_betweenWordScript1_4 := B_betweenWordScriptStart1_4
	O_betweenWordScript1_5 := B_betweenWordScriptStart1_5
	O_betweenWordScript1_6 := B_betweenWordScriptStart1_6
	O_betweenWordScript1_7 := B_betweenWordScriptStart1_7
	O_betweenWordScript1_8 := B_betweenWordScriptStart1_8
	O_betweenWordScript1_9 := B_betweenWordScriptStart1_9
	O_betweenWordScript1_10 := B_betweenWordScriptStart1_10
	O_betweenWordKey1_1 := B_betweenWordKeyStart1_1
	O_betweenWordKey1_2 := B_betweenWordKeyStart1_2
	O_betweenWordKey1_3 := B_betweenWordKeyStart1_3
	O_betweenWordKey1_4 := B_betweenWordKeyStart1_4
	O_betweenWordKey1_5 := B_betweenWordKeyStart1_5
	O_betweenWordKey1_6 := B_betweenWordKeyStart1_6
	O_betweenWordKey1_7 := B_betweenWordKeyStart1_7
	O_betweenWordKey1_8 := B_betweenWordKeyStart1_8
	O_betweenWordKey1_9 := B_betweenWordKeyStart1_9
	O_betweenWordKey1_10 := B_betweenWordKeyStart1_10
	guit_setExplainNotShow("E_lastWordRestoreFirst  を実行した", 71)
	return
