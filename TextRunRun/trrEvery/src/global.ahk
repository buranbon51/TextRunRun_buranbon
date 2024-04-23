




;global glob_defaultDir := defa_defaultDefaultDir

global glob_exceptionOfUserFile := A_ScriptDir . gloco_softEveryDirName . "\exceptionOfUser.ini"

global glob_managerConfigFile := A_ScriptDir . gloco_softEveryDirName . "\managerConfig.ini"

global glob_configFileName :=  "\config.ini"

global glob_historyListFileName :=  "\historyList.txt"

global glob_commStockFile77Name := "\stockList.ini"

global glob_commStockFile78Name := "\stockListPlus.ini"

;global glob_defaultLogFileName := "\defaultLog.txt"

global glob_lastWordExeConfigFileName := "\lastWordExeConfig.ini"

global glob_needReloadConfigFileName := "\needReloadConfig.ini"

global glob_outputFileName :=  defa_defaultOutputFileName

global glob_errorOutputFileName :=  defa_defaultErrorOutputFileName

;itemフォルダ内
global glob_userItemDirName :=  "\item"

global glob_commandFileName := glob_userItemDirName . "\itemConfig.ini"
global glob_commandListFileName := glob_userItemDirName . "\itemList.txt"

;hotKeyItemフォルダ内
global glob_userHotKeyItemDirName :=  "\hotKeyItem"

global glob_hotkeyItemIniFileName := glob_userHotKeyItemDirName . "\hotkeyItem.ini"
global glob_hotkeyItemListName := glob_userHotKeyItemDirName . "\hotkeyItemList.txt"


; tempフォルダ内
global glob_userTmpDirName :=  "\temp"

global glob_tmpAhkGuiSizePosFileName :=  glob_userTmpDirName . "\tmpAhkGuiSizePos.ini"

global glob_outputTmpFileName := glob_userTmpDirName . defa_defaultOutputTmpFileName

; temp の tmpItemフォルダ
global glob_userTmpTmpItemDirName := glob_userTmpDirName . "\tmpItem"

global glob_tmpCommandFileName :=  glob_userTmpTmpItemDirName . "\tmpItemConfig.ini"
global glob_tmpCommandListFileName :=  glob_userTmpTmpItemDirName . "\tmpItemList.txt"

; temp の tmpHotkeyItemフォルダ
global glob_userTmpHotkeyItemDirName := glob_userTmpDirName . "\tmpHotkeyItem"

global glob_tmpHotkeyItemIniFileName :=  glob_userTmpHotkeyItemDirName . "\tmpHotkeyItem.ini"
global glob_tmpHotkeyItemListName :=  glob_userTmpHotkeyItemDirName . "\tmpHotkeyItemList.txt"

; temp の tmpScriptsフォルダ
global glob_tmpScriptsDirName := glob_userTmpDirName . "\tmpScripts"

global glob_tmpScriptsItemListName := glob_tmpScriptsDirName . "\tmpScriptsItemList.txt"
global glob_tmpScriptsItemName := glob_tmpScriptsDirName . "\tmpScriptsItem.ini"

global glob_tmpScriptsTextDirName := glob_tmpScriptsDirName . "\tmpScriptsText"


; scriptsフォルダ内
global glob_scriptsDirName :=  "\scripts"

global glob_scriptsItemListName := glob_scriptsDirName . "\scriptsItemList.txt"
global glob_scriptsItemName := glob_scriptsDirName . "\scriptsItem.ini"

global glob_scriptsTextDirName := glob_scriptsDirName . "\scriptsText"

; snippetフォルダ内
global glob_userSnippetDirName :=  "\snippet"

global glob_snippetFileName := glob_userSnippetDirName . "\snippetConfig.ini"
global glob_snippetListFileName := glob_userSnippetDirName . "\snippetList.txt"


; addListフォルダ内
global glob_addListDir :=  A_ScriptDir . gloco_softEveryDirName . "\addList"

global glob_addWordListName :=  "\addWordList.txt"


; docフォルダ内
global glob_suspendIconName := "\icon\Suspend.ico"
global glob_pauseIconName := "\icon\Pause.ico"
global glob_pauseSuspendIconName := "\icon\PauseSuspend.ico"

global glob_stockNoneName := "\icon\stockNone"
global glob_stockHaveName := "\icon\stockHave"

global glob_textSplitButtonName := "\icon\textSplitButton"

; docフォルダにするのを止めた
global glob_textNoneName := gloco_softEveryDirName . "\textNone"
global glob_textHaveName := gloco_softEveryDirName . "\textHave"


global glob_stockNoneFile =
global glob_stockHaveFile =
global glob_textNoneFile =
global glob_textHaveFile =


global glob_comm1BackgName := "\text1"
global glob_comm2BackgName := "\text2"
global glob_comm3BackgName := "\text3"
global glob_commbox1BackgName := "\textSplit1"
global glob_commbox2BackgName := "\textSplit2"
global glob_multipleComm1BackgName := "\multipleText1"
global glob_commStock1BackgName := "\stock1"
global glob_commStock2BackgName := "\stock2"
global glob_clickWindowBackgName := "\clickWindow"
global glob_outputBackgName := "\output"
global glob_errorOutputBackgName := "\errorOutput"
global glob_tmpOutputBackgName := "\tmpOutput"
global glob_readFileOutBackgName := "\readFileOut"
global glob_configBackgName := "\config"
global glob_timerBackgName := "\timer"
global glob_everItemBackgName := "\everyItem"
global glob_everHotkeyBackgName := "\everyHotkey"
global glob_entryItemBackgName := "\entryItem"
global glob_entryHotkeyBackgName := "\entryHotkey"
global glob_entryMultipleBackgName := "\entryMultiple"
global glob_everInputBackgName := "\everyInput"
global glob_lastWordBackgName := "\lastWord"

global glob_comm1ClickName := "\clickWindow\clickText1"
global glob_comm2ClickName := "\clickWindow\clickText2"
global glob_comm3ClickName := "\clickWindow\clickText3"
global glob_commbox1ClickName := "\clickWindow\clickTextSplit1"
global glob_commbox2ClickName := "\clickWindow\clickTextSplit2"
global glob_commStock1ClickName := "\clickWindow\clickStock1"
global glob_commStock2ClickName := "\clickWindow\clickStock2"
global glob_tmpOutputName := "\clickWindow\clickTmpOutput"
global glob_outputName := "\clickWindow\clickOutput"
global glob_errorOutputName := "\clickWindow\clickErrorOutput"
global glob_configClickName := "\clickWindow\clickConfig"
global glob_timerClickName := "\clickWindow\clickTimer"
global glob_everItemGuiClickName := "\clickWindow\clickEveryItemGui"
global glob_everHotkeyClickName := "\clickWindow\clickEveryHotkey"
global glob_clickSuspendOnName := "\clickWindow\clickSuspendOn"
global glob_clickSuspendOffName := "\clickWindow\clickSuspendOff"
global glob_clickPauseOnName := "\clickWindow\clickPauseOn"
global glob_clickPauseOffName := "\clickWindow\clickPauseOff"
global glob_clickScriptsComm1Name := "\clickWindow\clickMultipleText1"
global glob_everInputClickName := "\clickWindow\clickEveryInput"

;global glob_commandListDirName := "\commandList"

;global glob_syscommFileName :=  glob_commandListDirName . "\sysComList.txt"

;global glob_specialWordFileName :=  glob_commandListDirName . "\specialWordList.txt"

;global glob_ahkCommFileName :=  glob_commandListDirName . "\ahkCommList.txt"

;global glob_variableFileName :=  glob_commandListDirName . "\variableList.txt"


; fromFileName関係
global glob_fromFileNameDir := A_ScriptDir . gloco_softEveryDirName . "\fromFileName"

global glob_itemFfnDirName := "\item"

global glob_startupFfnDirName := "\startup"

global glob_hotkeyOnTextFfnDirName := "\hotkeyOnText"

global glob_firstFfnDirNameOnly := "first"

global glob_categoryFfnMax = 100
global glob_itemFfnMax = 500
global glob_snippetFfnMax = 300
global glob_onTextFfnMax = 51
global glob_allGFfnMax = 51
global glob_allGWindowFfnMax = 30
global glob_startupFfnMax = 200

global glob_itemFfnCount = 1
global glob_snippetFfnCount = 1
global glob_onTextFfnCount = 1
global glob_allGFfnCount = 1
global glob_allGWindowFfnCount = 1
global glob_startupFfnCount = 1


; userMakeScriptフォルダ関係
global glob_userMakeScriptDir :=  A_ScriptDir . gloco_softEveryDirName . "\userMakeScript"

global glob_userMakeStartExeFile :=  glob_userMakeScriptDir . "\userMakeStartUpExecute.ahk"

global glob_userMakeSubFuncFile :=  glob_userMakeScriptDir . "\userMakeSubroutineAndFunction.ahk"

; Plugins関係
global glob_pluginsDir := A_ScriptDir . gloco_softEveryDirName . "\Plugins"

global glob_pluginsStartUpExeFile := glob_pluginsDir . "\pluginsStartUpExecute.ahk"

global glob_pluginsSubAndFuncFile := glob_pluginsDir . "\pluginsSubroutineAndFunction.ahk"


global glob_SHELL32DLL := SystemRoot . "\system32\SHELL32.dll"

global glob_softObj := Object()
global glob_folderObj := Object()
global glob_itemCommandObj := Object()
global glob_multipleObj := Object()

global glob_sysCommObj := Object()

global glob_specialWordObj := Object()

global glob_ahkCommObj := Object()

global glob_variableWordObj := Object()

global glob_userVariableWordObj := Object()

global glob_userMakeWordObj := Object()

global glob_optionVariableWordObj := Object()

global glob_optionSetterFuncWordObj := Object()

global glob_snippetObj := Object()

global glob_historyObj := Object()
global glob_tmpHistoryObj := Object()

global glob_shortKeyFlag := False
global glob_shortKeyComm = 

global glob_pupupNum = 1

global glob_backUp_dq_1 =
global glob_backUp_dq_2 =
global glob_backUp_dq_3 =
global glob_backUp_dq_4 =
global glob_backUp_dq_5 =
global glob_backUp_dq_6 =
global glob_backUp_dq_7 =
global glob_backUp_dq_8 =
global glob_backUp_dq_9 =

global glob_ahkArg0 =
global glob_ahkArg1 =
global glob_ahkArg2 =
global glob_ahkArg3 =
global glob_ahkArg4 =
global glob_ahkArg5 =
global glob_ahkArg6 =
global glob_ahkArg7 =
global glob_ahkArg8 =
global glob_ahkArg9 =

global glob_ahkShutdownCode = 1

global glob_spaceFileObj := Object()
global glob_spaceFileNum = 1

global glob_shutDownTimer_dateTime = 0
global glob_shutDownTimer_dateTime_sec = 0

global glob_shutDownTimer = 0
global glob_textShutDownTimer = 0
global glob_shutDownType = 1

global glob_timePeriod := defa_defaultTimePeriod
global glob_timePeriod_sec := defa_defaultTimePeriod_sec

global glob_commSuccessFlag := True

global glob_timer1 =
global glob_timer2 =
global glob_timer3 =
global glob_timer4 =
global glob_timer5 =
global glob_timer6 =
global glob_timer7 =
global glob_timer8 =
global glob_timer9 =
global glob_timer10 =

global glob_timer_sec1 =
global glob_timer_sec2 =
global glob_timer_sec3 =
global glob_timer_sec4 =
global glob_timer_sec5 =
global glob_timer_sec6 =
global glob_timer_sec7 =
global glob_timer_sec8 =
global glob_timer_sec9 =
global glob_timer_sec10 =


global glob_timerFlag1 := False
global glob_timerFlag2 := False
global glob_timerFlag3 := False
global glob_timerFlag4 := False
global glob_timerFlag5 := False
global glob_timerFlag6 := False
global glob_timerFlag7 := False
global glob_timerFlag8 := False
global glob_timerFlag9 := False
global glob_timerFlag10 := False


global glob_timerText_sec1 = 0
global glob_timerText_sec2 = 0
global glob_timerText_sec3 = 0
global glob_timerText_sec4 = 0
global glob_timerText_sec5 = 0
global glob_timerText_sec6 = 0
global glob_timerText_sec7 = 0
global glob_timerText_sec8 = 0
global glob_timerText_sec9 = 0
global glob_timerText_sec10 = 0

global glob_timeArgStr1 =
global glob_timeArgStr2 =
global glob_timeArgStr3 =
global glob_timeArgStr4 =
global glob_timeArgStr5 =
global glob_timeArgStr6 =
global glob_timeArgStr7 =
global glob_timeArgStr8 =
global glob_timeArgStr9 =
global glob_timeArgStr10 =
global glob_timePControl1 =
global glob_timePControl2 =
global glob_timePControl3 =
global glob_timePControl4 =
global glob_timePControl5 =
global glob_timePControl6 =
global glob_timePControl7 =
global glob_timePControl8 =
global glob_timePControl9 =
global glob_timePControl10 =
global glob_timeGuiNum1 =
global glob_timeGuiNum2 =
global glob_timeGuiNum3 =
global glob_timeGuiNum4 =
global glob_timeGuiNum5 =
global glob_timeGuiNum6 =
global glob_timeGuiNum7 =
global glob_timeGuiNum8 =
global glob_timeGuiNum9 =
global glob_timeGuiNum10 =
global glob_timerLogStr1 =
global glob_timerLogStr2 =
global glob_timerLogStr3 =
global glob_timerLogStr4 =
global glob_timerLogStr5 =
global glob_timerLogStr6 =
global glob_timerLogStr7 =
global glob_timerLogStr8 =
global glob_timerLogStr9 =
global glob_timerLogStr10 =

global glob_timerToolTip = 0
global glob_timerToolTip2 = 0

global glob_sendToTextArg =
global glob_sendToTextGuiNum =
global glob_sendToTextTimer = 0

global glob_startUpBuff =
global glob_startUpErrorBuff =

;iniファイル
global glob_iniTimerTextPeriod_sec := defa_defaultIniTimerTextPeriod_sec

;global glob_iniSpaceFileNotFlag = 0
;global O_spaceFileNotFlag = 0

;global glob_iniHistoryCount := defa_defaultIniHistoryCount
;global O_textHistory := defa_defaultIniHistoryCount

global glob_iniEasyCheck = 0
global glob_iniAbsolePathNotFlag = 0

global glob_iniCommListCloseNotSaveFlag = 0

global glob_iniStartUpOptionFlag = 0
global glob_iniStartUpOptionText =

global glob_iniStartUpOptionTextPattern2 =

global glob_iniClickOnlyGuiNotFlag = 0

;global glob_iniAutoPopupNotViewFlag = 0
;global O_inputListAutoNotFlag = 0

global glob_iniChangeStockInsertNotFlag = 0

;global glob_iniMultipleExplainNotFlag = 0
;global O_tmpOutputMultipleTextFlag = 0

global glob_iniOutput_sec = 7
global glob_iniTmpOutput_sec = 7
global glob_iniError_sec = 10
global glob_iniStock_sec = 7
global glob_iniTimerGui_sec = 7

global glob_iniOutputNotViewFlag = 0
global glob_iniTmpOutputNotViewFlag = 0
global glob_iniErrorNotViewFlag = 0

global glob_iniFileCleanTextFlag = 0
global glob_iniScriptCleanTextFlag = 0
global glob_iniMultipleCleanTextFlag = 0

global glob_iniFileGuiNotHide = 0
global glob_iniScriptGuiHide = 0
global glob_iniMultipleGuiHide = 0
global glob_iniAhkCommExeGuiHide = 0
;global glob_iniFuncExeGuiHide = 0

;global glob_iniTextGuiMinimize = 0
;global O_minimizeTextFlag = 0

;global glob_iniSpacePlusFlag = 0
;global O_spacePlusFlag = 0

; 最後の文字によって、自動で決定させる項目の設定
global glob_iniLastWordExeAllFlag := False

global glob_iniLastWordExeEnterFlag := False
global glob_iniLastWordExeEnterText := defa_defaultIniLastWordExeEnterText
global glob_iniLastWordExeEnterText2 := defa_defaultIniLastWordExeEnterText2

global glob_iniLastWordExeCtrlNumFlag := False
global glob_iniLastWordExeCtrlNumText := defa_defaultIniLastWordExeCtrlNumText

global glob_iniLastWordExeShiftCtrlNumFlag := False
global glob_iniLastWordExeShiftCtrlNumText := defa_defaultIniLastWordExeShiftCtrlNumText

global glob_iniLastWordExeUseTextNumFlag := False
global glob_iniLastWordExeUseTextNumText := defa_defaultIniLastWordExeUseTextNumText

global glob_iniLastWordExePuppupViewFlag := False
global glob_iniLastWordExePuppupViewText := defa_defaultIniLastWordExePuppupViewText

global glob_iniLastWordTextCleanFlag := False
global glob_iniLastWordTextCleanText := defa_defaultIniLastWordTextCleanText

global glob_iniLastWordAsHeadExeFlag := False
global glob_iniLastWordAsHeadExeText := defa_defaultIniLastWordAsHeadExeText

global glob_iniLastWordSpaceSendFlag := False
global glob_iniLastWordSpaceSendText := defa_defaultIniLastWordSpaceSendText

global glob_iniLastWordChangeHalfNumFlag := False

global glob_iniLastWordChangeFlag1 := False
global glob_iniLastWordChangeFlag2 := False
global glob_iniLastWordChangeFlag3 := False

global glob_iniLastWordChangeAfter1 =
global glob_iniLastWordChangeAfter2 =
global glob_iniLastWordChangeAfter3 =

global glob_iniLastWordChangeChoice1_1 =
global glob_iniLastWordChangeChoice1_2 =
global glob_iniLastWordChangeChoice1_3 =

global glob_iniLastWordChangeChoice2_1 =
global glob_iniLastWordChangeChoice2_2 =
global glob_iniLastWordChangeChoice2_3 =

global glob_iniLastWordChangeChoice3_1 =
global glob_iniLastWordChangeChoice3_2 =
global glob_iniLastWordChangeChoice3_3 =

;global glob_iniLastWordTabFlag2 := False

;global glob_iniLastWordAssignComm2_1 =
;global glob_iniLastWordAssignComm2_2 =
;global glob_iniLastWordAssignComm2_3 =
;global glob_iniLastWordAssignComm2_4 =
;global glob_iniLastWordAssignComm2_5 =
;global glob_iniLastWordAssignComm2_6 =
;global glob_iniLastWordAssignComm2_7 =

;global glob_iniLastWordAssignText2_1 =
;global glob_iniLastWordAssignText2_2 =
;global glob_iniLastWordAssignText2_3 =
;global glob_iniLastWordAssignText2_4 =
;global glob_iniLastWordAssignText2_5 =
;global glob_iniLastWordAssignText2_6 =
;global glob_iniLastWordAssignText2_7 =

;global glob_iniLastWordTabFlag3 := False

;global glob_iniLastWordAssignComm3_1 =
;global glob_iniLastWordAssignComm3_2 =
;global glob_iniLastWordAssignComm3_3 =
;global glob_iniLastWordAssignComm3_4 =
;global glob_iniLastWordAssignComm3_5 =
;global glob_iniLastWordAssignComm3_6 =
;global glob_iniLastWordAssignComm3_7 =

;global glob_iniLastWordAssignText3_1 =
;global glob_iniLastWordAssignText3_2 =
;global glob_iniLastWordAssignText3_3 =
;global glob_iniLastWordAssignText3_4 =
;global glob_iniLastWordAssignText3_5 =
;global glob_iniLastWordAssignText3_6 =
;global glob_iniLastWordAssignText3_7 =

;global glob_iniLastWordTabFlag4 := False

;global glob_iniLastWordAssignComm4_1 =
;global glob_iniLastWordAssignComm4_2 =
;global glob_iniLastWordAssignComm4_3 =
;global glob_iniLastWordAssignComm4_4 =
;global glob_iniLastWordAssignComm4_5 =
;global glob_iniLastWordAssignComm4_6 =
;global glob_iniLastWordAssignComm4_7 =

;global glob_iniLastWordAssignText4_1 =
;global glob_iniLastWordAssignText4_2 =
;global glob_iniLastWordAssignText4_3 =
;global glob_iniLastWordAssignText4_4 =
;global glob_iniLastWordAssignText4_5 =
;global glob_iniLastWordAssignText4_6 =
;global glob_iniLastWordAssignText4_7 =


; 文字が含まれていれば、自動で実行させる項目の設定
global glob_iniBetweenExeWordEndFlag := False
global glob_iniBetweenExeWordEndKey := defa_defaultIniBetweenExeWordEndKey


; userフォルダに含まない設定
global glob_reloadIniUserDirChangeFlag = 0

global glob_reloadIniCommGuiOnlyFlag = 0
;global glob_reloadIniCommGuiOnlyColor =

global glob_reloadIniShortKeyOffFlag = 0

global glob_reloadIniExceptCommKeyOff = 0

global glob_reloadIniCommWinTitle =

global glob_reloadIniStartUpText3 =

global glob_reloadIniTextWidthAutoNotFlag = 0

global glob_reloadIniCommWidthBasis := defa_defaultReloadIniCommWidthBasis

global glob_reloadIniCommWindowWidthBasis := defa_defaultReloadIniCommWindowWidthBasis

global glob_reloadIniOneLineTextTitle =

global glob_reloadIniTextSplitTitle =

global glob_oneLineTextAlias := "テキスト"

global glob_textSplitAlias := "分割テキスト"

; 再起動が必要な設定
global glob_needReloadIniCommTitleNotFlag = 0

;global glob_needReloadIniAllFontSize := defa_defaultNeedReloadIniAllFontSize
;global StO_fontSizeAllOption := defa_defaultNeedReloadIniAllFontSize

;global glob_needReloadIniAllFontName =
;global StO_fontNameAll =

global glob_needReloadIniCommFontOption := defa_defaultNeedReloadIniCommFontOption

global glob_needReloadIniCommFontName =

global glob_needReloadIniCommBoxFontOption := defa_defaultNeedReloadIniCommBoxFontOption

global glob_needReloadIniCommBoxFontName =

global glob_needReloadIniExplainFontOption := defa_defaultNeedReloadIniExplainFontOption

global glob_needReloadIniExplainFontName =

global glob_needReloadIniCommMenuNotFlag = 0

global glob_backOfBackPath = 
global glob_pwdBackup = 

global glob_nowAutoPopGui = 63

global glob_lastWordInputListStop = 0

global glob_runAsStatus := "通常"

;global glob_commboxWidth = 274

global glob_entryItemWidth = 320

global glob_stockEditValue =

global glob_commShortCutKeyUsedCount = 0
global glob_commShortCutKeyObj := Object()
global glob_commShortLongKeyNameObj := Object()

global glob_systemHotkeyObj := Object()

global glob_outputChangeNum = 1
global glob_errorOutputChangeNum = 1
global glob_outputChangeFile =

global glob_iconName := A_ScriptDir . gloco_softEveryDirName . "\icon.ico"

IfNotExist,  %glob_iconName%
{
	if(A_IsCompiled == 1){
		glob_iconName := A_ScriptFullPath
	} else {
		glob_iconName := A_AhkPath
	}
}
;Menu, Tray, Icon, %glob_iconName%
;Menu, Tray, Icon, %glob_iconName%, , 1
