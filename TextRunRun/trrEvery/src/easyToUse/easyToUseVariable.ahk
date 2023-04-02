
global B_OutputFile := gloco_userDir . glob_outputFileName
global B_ErrorFile := gloco_userDir . glob_errorOutputFileName
global B_TmpOutputFile := gloco_userDir . glob_outputTmpFileName

global B_DocFolder := gloco_docDir

global B_EveryFolder := A_ScriptDir . gloco_softEveryDirName

SplitPath, A_ScriptDir, , , , , OutDrive
global B_DriveName := OutDrive

global B_LineFeedLF := "`n"
global B_LineFeedCR := "`r"
global B_LineFeedCRLF := "`r`n"

global B_itemNameOwn =
global B_itemArgAll =
global B_itemArg0 = 0
global B_itemArg1 =
global B_itemArg2 =
global B_itemArg3 =
global B_itemArg4 =
global B_itemArg5 =
global B_itemArg6 =
global B_itemArg7 =
global B_itemArg8 =
global B_itemArg9 =

/*
global B_itemArgVarName0 = 0
global B_itemArgVarName1 =
global B_itemArgVarName2 =
global B_itemArgVarName3 =
global B_itemArgVarName4 =
global B_itemArgVarName5 =
global B_itemArgVarName6 =
global B_itemArgVarName7 =
global B_itemArgVarName8 =
global B_itemArgVarName9 =
*/

global B_GuiNumText1 = 63
global B_GuiNumText2 = 64
global B_GuiNumText3 = 65

global B_GuiNumTextSplit1 = 61
global B_GuiNumTextSplit2 = 62

global B_GuiNumStock1 = 77
global B_GuiNumStock2 = 78

global B_GuiNumOutput = 66
global B_GuiNumTmpOutput = 68
global B_GuiNumErrorOutput = 67
global B_GuiNumReadFileOut = 69
global B_GuiNumTimer = 87
global B_GuiNumNoCloseTimer = 88

global B_GuiNumMultipleText1 = 82
global B_GuiNumClickWindow = 76

global B_GuiNumLastWord = 84

global B_GuiNumInputList = 70


global B_WinTitleText1 =
global B_WinTitleText2 =
global B_WinTitleText3 =
global B_WinTitleTextSplit1 =
global B_WinTitleTextSplit2 =
global B_WinTitleMultipleText1 =
global B_WinTitleStock1 =
global B_WinTitleStock2 =
global B_WinTitleClickWindow =
global B_WinTitleOutput =
global B_WinTitleErrorOutput =
global B_WinTitleTmpOutput =
global B_WinTitleReadFileOut =
global B_WinTitleTimer =
global B_WinTitleNoCloseTimer =


global B_conText1_Edit1 := "Edit63_1"
global B_conText2_Edit1 := "Edit64_1"
global B_conText3_Edit1 := "Edit65_1"
global B_conMultipleText1_Edit1 := "BoxEdit82_1"
global B_conText1_Picture1 := "Picture63_1"
global B_conText2_Picture1 := "Picture64_1"
global B_conText3_Picture1 := "Picture65_1"
global B_conTextSplit1_Picture1 := "Picture61_1"
global B_conTextSplit2_Picture1 := "Picture62_1"
global B_conLastWord_Tab := "Tab84_1"

global B_lastWordTabAllStartFlag2 = 0
global B_lastWordTabAllStartFlag3 = 0
global B_lastWordTabAllStartFlag4 = 0
global B_lastWordTabAllStartFlag5 = 0
;global B_lastWordTabAllStartFlag6 = 0

global B_lastWordScriptStart2_1 =
global B_lastWordScriptStart2_2 =
global B_lastWordScriptStart2_3 =
global B_lastWordScriptStart2_4 =
global B_lastWordScriptStart2_5 =
global B_lastWordScriptStart2_6 =
global B_lastWordScriptStart2_7 =
global B_lastWordScriptStart2_8 =
global B_lastWordScriptStart2_9 =
global B_lastWordScriptStart2_10 =

global B_lastWordScriptStart3_1 =
global B_lastWordScriptStart3_2 =
global B_lastWordScriptStart3_3 =
global B_lastWordScriptStart3_4 =
global B_lastWordScriptStart3_5 =
global B_lastWordScriptStart3_6 =
global B_lastWordScriptStart3_7 =
global B_lastWordScriptStart3_8 =
global B_lastWordScriptStart3_9 =
global B_lastWordScriptStart3_10 =

global B_lastWordScriptStart4_1 =
global B_lastWordScriptStart4_2 =
global B_lastWordScriptStart4_3 =
global B_lastWordScriptStart4_4 =
global B_lastWordScriptStart4_5 =
global B_lastWordScriptStart4_6 =
global B_lastWordScriptStart4_7 =
global B_lastWordScriptStart4_8 =
global B_lastWordScriptStart4_9 =
global B_lastWordScriptStart4_10 =

global B_lastWordScriptStart5_1 =
global B_lastWordScriptStart5_2 =
global B_lastWordScriptStart5_3 =
global B_lastWordScriptStart5_4 =
global B_lastWordScriptStart5_5 =
global B_lastWordScriptStart5_6 =
global B_lastWordScriptStart5_7 =
global B_lastWordScriptStart5_8 =
global B_lastWordScriptStart5_9 =
global B_lastWordScriptStart5_10 =

global B_lastWordKeyStart2_1 =
global B_lastWordKeyStart2_2 =
global B_lastWordKeyStart2_3 =
global B_lastWordKeyStart2_4 =
global B_lastWordKeyStart2_5 =
global B_lastWordKeyStart2_6 =
global B_lastWordKeyStart2_7 =
global B_lastWordKeyStart2_8 =
global B_lastWordKeyStart2_9 =
global B_lastWordKeyStart2_10 =

global B_lastWordKeyStart3_1 =
global B_lastWordKeyStart3_2 =
global B_lastWordKeyStart3_3 =
global B_lastWordKeyStart3_4 =
global B_lastWordKeyStart3_5 =
global B_lastWordKeyStart3_6 =
global B_lastWordKeyStart3_7 =
global B_lastWordKeyStart3_8 =
global B_lastWordKeyStart3_9 =
global B_lastWordKeyStart3_10 =

global B_lastWordKeyStart4_1 =
global B_lastWordKeyStart4_2 =
global B_lastWordKeyStart4_3 =
global B_lastWordKeyStart4_4 =
global B_lastWordKeyStart4_5 =
global B_lastWordKeyStart4_6 =
global B_lastWordKeyStart4_7 =
global B_lastWordKeyStart4_8 =
global B_lastWordKeyStart4_9 =
global B_lastWordKeyStart4_10 =

global B_lastWordKeyStart5_1 =
global B_lastWordKeyStart5_2 =
global B_lastWordKeyStart5_3 =
global B_lastWordKeyStart5_4 =
global B_lastWordKeyStart5_5 =
global B_lastWordKeyStart5_6 =
global B_lastWordKeyStart5_7 =
global B_lastWordKeyStart5_8 =
global B_lastWordKeyStart5_9 =
global B_lastWordKeyStart5_10 =

global B_betweenWordTabAllStartFlag1 = 0

global B_betweenWordScriptStart1_1 =
global B_betweenWordScriptStart1_2 =
global B_betweenWordScriptStart1_3 =
global B_betweenWordScriptStart1_4 =
global B_betweenWordScriptStart1_5 =
global B_betweenWordScriptStart1_6 =
global B_betweenWordScriptStart1_7 =
global B_betweenWordScriptStart1_8 =
global B_betweenWordScriptStart1_9 =
global B_betweenWordScriptStart1_10 =

global B_betweenWordKeyStart1_1 =
global B_betweenWordKeyStart1_2 =
global B_betweenWordKeyStart1_3 =
global B_betweenWordKeyStart1_4 =
global B_betweenWordKeyStart1_5 =
global B_betweenWordKeyStart1_6 =
global B_betweenWordKeyStart1_7 =
global B_betweenWordKeyStart1_8 =
global B_betweenWordKeyStart1_9 =
global B_betweenWordKeyStart1_10 =

global ErrorLevel_TextRunRun = 0


global V_var := "??"
global V_var0 := "??"
global V_var1 := "??"
global V_var2 := "??"
global V_var3 := "??"
global V_var4 := "??"
global V_var5 := "??"
global V_var6 := "??"
global V_var7 := "??"
global V_var8 := "??"
global V_var9 := "??"
global V_var10 := "??"
global V_var11 := "??"
global V_var12 := "??"
global V_var13 := "??"
global V_var14 := "??"
global V_var15 := "??"
global V_var16 := "??"
global V_var17 := "??"
global V_var18 := "??"
global V_var19 := "??"
global V_var20 := "??"
global V_var21 := "??"
global V_var22 := "??"
global V_var23 := "??"
global V_var24 := "??"
global V_var25 := "??"
global V_var26 := "??"
global V_var27 := "??"
global V_var28 := "??"
global V_var29 := "??"
global V_var30 := "??"
global V_var31 := "??"
global V_var32 := "??"
global V_var33 := "??"
global V_var34 := "??"
global V_var35 := "??"
global V_var36 := "??"
global V_var37 := "??"
global V_var38 := "??"
global V_var39 := "??"
global V_var40 := "??"
global V_var41 := "??"
global V_var42 := "??"
global V_var43 := "??"
global V_var44 := "??"
global V_var45 := "??"
global V_var46 := "??"
global V_var47 := "??"
global V_var48 := "??"
global V_var49 := "??"
global V_var50 := "??"

