﻿
opsefli_optionSetterFuncList(){
	clist =
(LTrim
SetO_enterExeText1Before(headScript="")
SetO_enterExeText2Before(headScript="")
SetO_enterExeText3Before(headScript="")
SetO_enterExeTextSplit1Before(headScript="")
SetO_enterExeTextSplit2Before(headScript="")
SetO_enterExeText1After(headScript="")
SetO_enterExeText2After(headScript="")
SetO_enterExeText3After(headScript="")
SetO_enterExeTextSplit1After(headScript="")
SetO_enterExeTextSplit2After(headScript="")
SetO_anyKeyExeText1After(headScript="")
SetO_anyKeyExeText2After(headScript="")
SetO_anyKeyExeText3After(headScript="")
SetO_anyKeyExeTextSplit1After(headScript="")
SetO_anyKeyExeTextSplit2After(headScript="")
SetO_txtOpenSoftItem(softName="")
SetO_ahkOpenSoftItem(softName="")
SetO_folderOpenSoftItem(softName="")
SetO_stockTextLengthNotFlag(flag=False)
SetO_widthBasisText1(width=150)
SetO_widthBasisText2(width=150)
SetO_widthBasisText3(width=150)
SetO_widthWindowBasisText1(width=212)
SetO_widthWindowBasisText2(width=212)
SetO_widthWindowBasisText3(width=212)
SetO_widthNotFlagText1(flag=False)
SetO_widthNotFlagText2(flag=False)
SetO_widthNotFlagText3(flag=False)
SetO_widthNotFlagTextSplit1(flag=False)
SetO_widthNotFlagTextSplit2(flag=False)
SetO_widthBasisTextSplit1(width=250)
SetO_widthBasisTextSplit2(width=250)
SetO_widthBasisWorkDirTextSplit1(width=165)
SetO_widthBasisWorkDirTextSplit2(width=165)
SetO_widthWindowBasisTextSplit1(width=274)
SetO_widthWindowBasisTextSplit2(width=274)
SetO_widthOneCharText1(width=10)
SetO_widthOneCharText2(width=10)
SetO_widthOneCharText3(width=10)
SetO_widthOneCharTextSplit1(width=10)
SetO_widthOneCharTextSplit2(width=10)
SetO_widthMaxLowerText1(width=130)
SetO_widthMaxLowerText2(width=130)
SetO_widthMaxLowerText3(width=130)
SetO_widthMaxLowerTextSplit1(width=130)
SetO_widthMaxLowerTextSplit2(width=130)
SetO_widthStartCharCountText1(count=15)
SetO_widthStartCharCountText2(count=15)
SetO_widthStartCharCountText3(count=15)
SetO_widthStartCharCountTextSplit1(count=15)
SetO_widthStartCharCountTextSplit2(count=15)
SetO_ahkErrorNotViewFlag(flag=False)
SetO_textHistory(num=20)
SetO_textHistoryNotFlag(flag=False)
SetO_spaceFileNotFlag(flag=False)
SetO_spacePlusFlag(flag=False)
SetO_inputListAutoNotFlag(flag=False)
SetO_minimizeTextFlag(flag=False)
SetO_tmpOutputMultipleTextFlag(flag=False)
SetO_ClickWindowCloseFlag(flag=False)
SetO_suspendNotViewFlag(flag=False)
SetO_lastWordTabAllFlag2(flag=False)
SetO_lastWordScript2_1(script="")
SetO_lastWordKey2_1(word="")
SetO_betweenWordTabAllFlag1(flag=False)
SetO_betweenWordScript1_1(script="")
SetO_betweenWordKey1_1(word="")
SetO_inputListX(posX=0)
SetO_inputListY(posY=30)
SetO_inputListReverseX(posX=260)
SetO_inputListReverseY(posY=340)
SetO_toolTipX(posX=100)
SetO_toolTipY(posY=600)
SetO_toolTipSecond(sec=3)
)

	return clist
}

/*
GetO_enterExeText1Before()
GetO_enterExeText2Before()
GetO_enterExeText3Before()
GetO_enterExeTextSplit1Before()
GetO_enterExeTextSplit2Before()
GetO_enterExeText1After()
GetO_enterExeText2After()
GetO_enterExeText3After()
GetO_enterExeTextSplit1After()
GetO_enterExeTextSplit2After()
GetO_anyKeyExeText1After()
GetO_anyKeyExeText2After()
GetO_anyKeyExeText3After()
GetO_anyKeyExeTextSplit1After()
GetO_anyKeyExeTextSplit2After()
GetO_txtOpenSoftItem()
GetO_ahkOpenSoftItem()
GetO_folderOpenSoftItem()
GetO_stockTextLengthNotFlag()
GetO_widthBasisText1()
GetO_widthBasisText2()
GetO_widthBasisText3()
GetO_widthWindowBasisText1()
GetO_widthWindowBasisText2()
GetO_widthWindowBasisText3()
GetO_widthNotFlagText1()
GetO_widthNotFlagText2()
GetO_widthNotFlagText3()
GetO_widthNotFlagTextSplit1()
GetO_widthNotFlagTextSplit2()
GetO_widthBasisTextSplit1()
GetO_widthBasisTextSplit2()
GetO_widthBasisWorkDirTextSplit1()
GetO_widthBasisWorkDirTextSplit2()
GetO_widthWindowBasisTextSplit1()
GetO_widthWindowBasisTextSplit2()
GetO_ahkErrorNotViewFlag()
GetO_textHistory()
GetO_textHistoryNotFlag()
GetO_spaceFileNotFlag()
GetO_spacePlusFlag()
GetO_inputListAutoNotFlag()
GetO_minimizeTextFlag()
GetO_tmpOutputMultipleTextFlag()
GetO_ClickWindowCloseFlag()
GetO_suspendNotViewFlag()
GetO_lastWordTabAllFlag2()
GetO_lastWordScript2_1()
GetO_lastWordKey2_1()
GetO_betweenWordTabAllFlag1()
GetO_betweenWordScript1_1()
GetO_betweenWordKey1_1()
GetO_widthOneCharText1()
GetO_widthOneCharText2()
GetO_widthOneCharText3()
GetO_widthOneCharTextSplit1()
GetO_widthOneCharTextSplit2()
GetO_widthMaxLowerText1()
GetO_widthMaxLowerText2()
GetO_widthMaxLowerText3()
GetO_widthMaxLowerTextSplit1()
GetO_widthMaxLowerTextSplit2()
GetO_widthStartCharCountText1()
GetO_widthStartCharCountText2()
GetO_widthStartCharCountText3()
GetO_widthStartCharCountTextSplit1()
GetO_widthStartCharCountTextSplit2()
GetO_inputListX()
GetO_inputListY()
GetO_inputListReverseX()
GetO_inputListReverseY()
GetO_toolTipX()
GetO_toolTipY()
GetO_toolTipSecond()

*/
