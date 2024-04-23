
speli_specialWordList(){
	clist =
(LTrim
ahk_class
ahk_group
ahk_id
ahk_pid
null
none
if(){}
else
global
G_subroutine1
G_subroutine100
D_outputGui
D_tmpOutputGui
D_errorGui
D_readFileGui
D_tmpOutputFile
D_systemOut
D_none
D_text1$$
D_text2$$
D_text3$$
D_textSplit1_1$$
D_textSplit1_2$$
D_textSplit1_3$$
D_textSplit1_4$$
D_textSplit2_1$$
D_textSplit2_2$$
D_textSplit2_3$$
D_textSplit2_4$$
D_stockBlue_1$$
D_stockBlue_2$$
D_stockBlue_3$$
D_stockBlue_4$$
D_stockBlue_5$$
D_stockBlue_6$$
D_stockBlue_7$$
D_stockBlue_8$$
D_stockBlue_9$$
D_stockBlue_10$$
D_stockGreen_1$$
D_stockGreen_2$$
D_stockGreen_3$$
D_stockGreen_4$$
D_stockGreen_5$$
D_stockGreen_6$$
D_stockGreen_7$$
D_stockGreen_8$$
D_stockGreen_9$$
D_stockGreen_10$$
D_menuMain
D_menuTextGui
D_menuTextGuiTop
D_menuClickWindow
D_menuClickWindowTop
F_setControl(GuiNum, controlVar, value)
F_getControl(GuiNum, controlVar)
F_GuiControl(GuiNum,controlVar,option,value="_")
F_GuiControlGet(GuiNum,controlVar,option="_", value="_")
F_Gui(GuiNum, option, value1="_", value2="_", value3="_")
F_GuiAddPictureFileExist(GuiNum, file, option)
F_GuiAddPictureNoExtFile(GuiNum, noExtFile, option)
F_textExe(command)
F_textExeTextSplit(text1, text2, text3, workFolder, text5, text6, text7, text8, dbqFlag=True)
F_output(append)
F_tmpOutput(str)
F_errorOutput(append)
F_toolTipOutput(str)
F_toolTipOutputAssign(str,posX,posY,sec=3)
F_toolTipOutputAssignNumber2(str,posX,posY,sec=3)
F_hideGuiTextPattern(GuiNum)
F_hideGuiTextPatternOption(GuiNum,outGuiHideFlag="1",minimizeOption="1")
F_showToggleGui(GuiNum,option="_")
F_showToggleGuiWinTitle(GuiNum, winTitle, option="_")
F_showToggleGuiTextPattern(GuiNum,pOrder="_")
F_showToggleGuiTextPatternOption(GuiNum,outGuiHideFlag="1",minimizeOption="1",pOrder="_")
F_minimizeGui(GuiNum)
F_multiplelineExe(command)
F_dateAndTimeNow()
F_transformDeref(str)
F_textOut(str)
F_ErrorLevel_TextRunRunCheck(errorMessage)
F_ErrorLevel_TextRunRunRestore()
F_imeGet()
F_imeSet(flag=1)
F_setTextGuiAssign(value, GuiNum, number="1", textOutFlag=True, addFlag=False)
F_getTextGuiAssign(GuiNum, number="1", trimFlag=True)
F_getTextEditExecutor(trimFlag=True)
F_itemExe(itemName,args="")
F_lastWordTabChange(number="1")
F_inputListUpDownKey(number)
F_inputListSelectOutputAssign(GuiNum)
F_snippetAdd(key, sentence, spaceFlag=False)
F_getConvertCollabTextWord(str)
F_getItemScript(itemName)
F_getItemArgument(itemName)
F_getItemWorkingFolder(itemName)
F_getItemType(itemName)
F_hideGuiTextAndWaitActiveAny()
F_hideGuiTextAndWaitActiveIfA(winTitle="A")
F_winWaitActive(winTitle="A")
F_winActiveAndWait(winTitle="A")
F_getShortcutPath(shortcutFile)
F_getShortcutPathAndArgs(shortcutFile)
F_getParentFolder(file, textOutFlag=False)
F_showLastWord(option="_", toggleFlag=True, sleepFlag=False)
F_stringReplace(str, searchText, replaceText, allFlag=False)
F_linefeedReplace(str)
F_linefeedReplaceOnEscapeCharacter(str)
F_confirmDateTime6Char(str)
F_confirmHMSSentence(str)
F_getTimerInformation(listNumber, inforNumber=1)
F_itemReloadOneFromFileName(itemName, itemCategoryDir="", categoryDir="")
F_newItemFromCommand(radioNum, itemName, script, args="", workDir="", dbQuoutFlag=False)
F_kanjiAndFullNumeralReplaceInteger(sentence, errorNotViewFlag=False)
F_getDateTime6CharFromKanji(sentence="二十三時三分三十秒", errorNotViewFlag=False)
F_getHMSSentenceFromKanji(sentence="三分三十秒", errorNotViewFlag=False)
F_lastWordSetOneLineStr(firstNum, secondNum, oneLineStr, blankComment="#", passComment="[", keyTrimBefore="<", keyTrimAfter=">")
F_lastWordSetOneFromAllLineStr(firstNum, secondNum, allLineStr, blankComment="#", passComment="[", keyTrimBefore="<", keyTrimAfter=">")
F_lastWordSetFirstNumAllFromAllLineStr(firstNum, allLineStr, blankComment="#", passComment="[", keyTrimBefore="<", keyTrimAfter=">")
E_donothing
E_closeClickWindow
E_showClickWindow
E_showText1Toggle
E_showText2Toggle
E_showText3Toggle
E_showTextSplit1Toggle
E_showTextSplit2Toggle
E_showTimerGuiToggle
E_guiPositionSave
E_guiPositionInit
E_showConfigToggle
E_showItemListGuiToggle
E_showHotkeyListGuiToggle
E_showEverInputGuiToggle
E_showLastWordToggle
E_showText1ToggleForClick
E_showText2ToggleForClick
E_showText3ToggleForClick
E_showTextSplit1ToggleForClick
E_showTextSplit2ToggleForClick
E_showStock1Toggle
E_showStock2Toggle
E_showTmpOutputToggle
E_showOutputToggle
E_showErrorOutputToggle
E_showMultipleText1Toggle
E_hideGuiTextAndWaitActiveAny
E_lastWordRestoreFirst
E_SuspendOn
E_SuspendOff
E_SuspendToggle
E_PauseOn
E_PauseOff
E_inputListUpKey
E_inputListDownKey
E_inputListPageUp
E_inputListPageDown
51GuiEscape
59GuiEscape
51GuiClose
59GuiClose
51GuiSize
59GuiSize
51GuiDropFiles
59GuiDropFiles
51GuiContextMenu
59GuiContextMenu
76GuiContextMenu
76GuiDropFiles
)

	return clist
}
