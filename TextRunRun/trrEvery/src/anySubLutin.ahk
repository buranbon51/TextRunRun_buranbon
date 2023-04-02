

; このサブルーチンを一番手前に置いておくこと
enys_SubCancel:

return

enys_SubExitAppFromMenu:
	ExitApp
	return

enys_SubTrayMenuDefault:
	edi_showHideGuiTextPattern(63, True, True)
	return

enys_SubThisSoftStatus:
	;WinWaitActive , A, , 1
	syf_showGui75AndSetting()
	return

enys_SubShowConfig:
	syf_showSetConfigToggle()
	return

enys_SubShowExplainGui:
	WinWaitActive , A, , 1
	Gui, 68:Show
	return

enys_SubShowAppendExplainGui:
	WinWaitActive , A, , 1
	Gui, 66:Show
	return

enys_SubShowErrorGui:
	WinWaitActive , A, , 1
	Gui, 67:Show
	return

enys_SubShowCommList:
	WinWaitActive , A, , 1
	Gui, 78:Show
	Gui, 77:Show
	return

enys_SubShowMiniEditGui1:
	WinWaitActive , A, , 1
	guf_showGuiAssign(63)
	return

enys_SubShowMiniEditGui2:
	WinWaitActive , A, , 1
	guf_showGuiAssign(64)
	return

enys_SubShowMiniEditGui3:
	WinWaitActive , A, , 1
	guf_showGuiAssign(65)
	return

enys_SubShowEditssGui1:
	WinWaitActive , A, , 1
	guf_showGuiAssign(61)
	return

enys_SubShowEditssGui2:
	WinWaitActive , A, , 1
	guf_showGuiAssign(62)
	return

enys_SubShowManagerGui:
	syf_managerGuiSet()
	return

enys_SubShowOutputTxtGui:
	WinWaitActive , A, , 1
	guf_showGuiAssign(69)
	;linu_moreFromOutFile()
	return

enys_SubShowEverItemGui:
	ite_itemLookGuiToggle()
	return

enys_SubShowClickWindow:
	guf_showHideGuiToggle(gGlob_Gui76Title, 76, "NA")
	return

enys_SubHideClickWindow:
	Gui, 76:Hide
	return

enys_SubShowHotkeyListGui:
	intchf_showHotkeyListGuiToggle()
	return

enys_SubShowEverInputGui:
	cen_showEverInputGui()
	return

enys_SubShowMultipleScriptsGui:
	WinWaitActive , A, , 1
	guf_showHideEnyGui("BoxEdit82_1", 82)
	return

enys_SubShowMultipleScriptsEntryGui:
	musc_showMultipleScriptsGui("")
	return

enys_SubGuiSizePosSave:
	cen_ahkGuiSizePosSave()
	guit_setExplainNotShow("このソフトのGuiの位置とサイズを保存した", 63)
	return

enys_SubGuiSizePosInit:
	init_initGuiAll()
	; クリックのためのウインドウを表示
	cen_clickOnlyGuiShow()
	;cen_ahkGuiSizePosSave()
	; ファイルの削除
	outs_deleteAndMakeFile(gloco_userDir . glob_tmpAhkGuiSizePosFileName, gloco_userDir . glob_userTmpDirName)
	guit_setExplainNotShow("このソフトのGuiの位置とサイズを最初の状態に戻した", 63)
	return

enys_SubPauseToggle:
	cen_trayPauseIconChangeBefore()
	Pause , Toggle
	cen_trayIconChangeFromSuspendOrPause()
	return

enys_SubPauseOn:
	cen_trayPauseIconChangeBefore()
	Pause , On
	cen_trayIconChangeFromSuspendOrPause()
	return

enys_SubPauseOff:
	Pause , Off
	cen_trayIconChangeFromSuspendOrPause()
	return

enys_SubSuspendToggle:
	Suspend , Toggle
	cen_trayIconChangeFromSuspendOrPause()
	return

enys_SubSuspendOn:
	Suspend , On
	cen_trayIconChangeFromSuspendOrPause()
	return

enys_SubSuspendOff:
	Suspend , Off
	cen_trayIconChangeFromSuspendOrPause()
	return
