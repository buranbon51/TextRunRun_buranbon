;  必須ファイル なし



; 半角スペースを１つに狭める
func_spaceChangeOnlyOne(str){
	; 空白がないなら（引数が一つなら）
	IfNotInString, str, %A_Space%
	{
		return str
	}

	buff =
	Loop, Parse, str , %A_Space%
	{
		if(A_LoopField != ""){
			buff .= A_LoopField . " "
		}
	}
	buff := RTrim(buff)
	return buff
}

; GuiControlGet の FocusV を使用した場合、ウインドウが非表示だと、
; ErrorLevel が 1 になってしまうので、対応策で作った
func_focusVGet(GuiNum){
	GuiControlGet, OutputVar , %GuiNum%:FocusV
	if(OutputVar == ""){
		if(ErrorLevel >= 1 && ErrorLevel < 5){
			ErrorLevel = 0
		}
	}
	return  OutputVar
}

; 文字が長い場合、省略した文字を返す
func_longIfShortWord(str, wordCount, leftLength, rightLength){
	StringLen, length, str
	if(length > wordCount){
		StringLeft, leftStr, str, %leftLength%
		StringRight, rightStr, str, %rightLength%
		str := leftStr  . "......" . rightStr
	}
	return  str
}


; 指定した文字の 右の文字を返す。なければ 空の文字を返す
func_rightStrOrNullFromSearchStr(str, searchStr){
	IfNotInString, str, %searchStr%
	{
		return  ""
	}
	StringGetPos, count, str, %searchStr%
	StringLen, length, searchStr
	count += length
	StringTrimLeft, rStr , str, %count%
	rStr  := Trim( rStr )
	return  rStr 
}

; 指定した文字の 左の文字を返す。なければ 全ての 文字を返す
func_leftStrOrAllFromSearchStr(str, searchStr){
	IfNotInString, str, %searchStr%
	{
		return  str
	}
	StringGetPos, count, str, %searchStr%
	StringLeft, leftStr, str, %count%
	leftStr := Trim(leftStr)
	return  leftStr
}

; 指定した文字の 右の文字を返す。なければ 空の文字を返す
func_rightStrOrNullFromSearchStrTurnAssign(str, searchStr, turnNum){
	IfNotInString, str, %searchStr%
	{
		return  ""
	}
	StringGetPos, count, str, %searchStr%, L%turnNum%
	if(count == -1){
		return  ""
	}
	StringLen, length, searchStr
	count += length
	StringTrimLeft, rStr , str, %count%
	rStr  := Trim(rStr )
	return  rStr 
}

; 指定した文字の 左の文字を返す。なければ 空の文字を返す
func_leftStrOrNullFromSearchStrTurnAssign(str, searchStr, turnNum){
	IfNotInString, str, %searchStr%
	{
		return  ""
	}
	StringGetPos, count, str, %searchStr%, L%turnNum%
	if(count == -1){
		return  ""
	}
	StringLeft, leftStr, str, %count%
	leftStr := Trim(leftStr)
	return  leftStr
}

func_separationSpaceLeftOrAll(argStr) {
	IfInString, argStr, %A_Space%
	{
		StringGetPos, index, argStr, %A_Space%
		StringLeft, argStr, argStr, %index%
	}
	return  argStr
}

func_separationSpaceRightOrNull(argStr) {
	IfInString, argStr, %A_Space%
	{
		StringGetPos, index, argStr, %A_Space%
		StringTrimLeft, rightStr, argStr, %index%
		argStr := LTrim( rightStr )
	} else {
		argStr := ""
	}
	return  argStr
}

func_getShortCutPath(LinkFile){
	FileGetShortcut, %LinkFile% , OutTarget
	return  OutTarget
}

func_getShortCutArgs(LinkFile){
	FileGetShortcut, %LinkFile% , OutTarget, OutDir, OutArgs
	return  OutArgs
}

; 20001212235959 の形式の数字に対して、日付の部分を今日の日付に変える
func_changeTodayDateTime(dateTime){
	StringRight, timeOnly, dateTime, 6
	dateTime = %A_YYYY%%A_MM%%A_DD%%timeOnly%
	return dateTime
}

; .txt ファイルなら True を返す
func_txtFileCheck(file){
	StringRight, suffix, file, 4
	StringLower, suffix, suffix
	if(suffix == ".txt"){
		return  True
	}
	return  False
}

; 危険な文字があったら True を返す
func_checkDangerStr(str) {
	IfInString, str, A:
	{
		return  True
	}
	IfInString, str, a:
	{
		return  True
	}
	return  False
}

; ファイルかどうかを認識する独自のルール。
; 間違っているのを見つけしだい True を返す
func_myFileCheckIsNot(pattern){

	; 危険な文字があったら
	if( func_checkDangerStr(pattern) ){
		return  True
	}

	;   .  や  ..  だけのとき、ファイル扱いする
	;  ここではコメントにするが、処理によってファイル扱いする記述を書かないといけないかもしれない。
	;  heard_fileNameConfirm(lastStr, str)	では、ファイル扱いしないといけなかった。
	;if(pattern == "."  || pattern == ".."){
	;	return  False
	;}
	; やっぱり . や ..だけならNGにした。今後、不具合を起こすかもしれないがしばらく試す
	patternTmp := Trim(pattern)
	if(patternTmp == "."  || patternTmp == ".."){
		return  True
	}

	; 空なら当然ファイルではない
	if(patternTmp == "") {
		return  True
	}


	; \\ と、２つあっても、ファイル扱いしてしまうので、通さないように
	IfInString, pattern, \\
	{
		return  True
	}

	; Linux ではないので / つきのファイル名は通さない
	IfInString, pattern, /
	{
		return  True
	}

	; 特殊な文字があったらファイルとみなさない
	if( func_checkErrorFile(pattern) ){
		return  True
	}

	; ... ３つ以上コロンがある
	IfInString, pattern, ...
	{
		return  True
	}

	;  . で終わるファイルは 通さないようにする
	StringRight, rChar, pattern, 1
	if(rChar == "."){
		; ただし \..で終わるのは通す
		StringRight, rThree, pattern, 3
		if(rThree != "\..") {
			return  True	; True だったら ファイルではない
		}
	}
	; C:\  ..\.  と言ったファイル名を何故か通してしまうため確認する
	IfInString, pattern, %A_Space%
	{
		StringGetPos, index, pattern, %A_Space% , L1
		StringTrimLeft, rightStr, pattern, %index%
		rightStr  := LTrim(rightStr)
		StringLeft, lChar, rightStr, 1
		if(lChar == "."){
			return  True
		}
	}

	; fileName\..\..\	の場合、必ずフォルダとして認識されてしまう。
	; よって、
	; \..\..\  をとりのぞき、
	; fileName の部分だけでフォルダと認識されるなら正しい指定とする
	if( func_isFolderTailColonEnTrim(pattern) == False ){
		return  True
	}

	return  False
}


; fileName\..\..\	の場合、必ずフォルダとして認識されてしまう。
; よって、
; \..\..\  をとりのぞき、
; fileName の部分だけでフォルダと認識されるなら正しい指定とする
;
; 実行した後、フォルダと認識できれば True
; 	（フォルダと認識されておらず、実行されてなくてもTrue）
func_isFolderTailColonEnTrim(pattern){

	;まず、フォルダと認識されてないなら True（実行しない）
	;	(ファイルの場合も True になる)
	type := FileExist(pattern)
	IfNotInString, type, D
	{
		return True
	}

	; .\ や ..\ だけの場合 フォルダとみなす
	if(pattern == ".\"  ||  pattern == "..\"){
		return  True
	}

	; 右端の \ を取り除いたあと、 . があるなら、操作を実行
	pattern := RTrim( pattern, "\" )
	StringRight, rChar, pattern, 1
	if(rChar == "."){
		pattern := RTrim( pattern, "." )
		; fileName..\  というパターンの場合、Falseにする  (fileName\..\ 、ならいいが)
		StringRight, rChar, pattern, 1
		if(rChar != "\"){
			; 問答無用でFalse
			return  False
		}

		pattern := RTrim( pattern, "\" )
		Loop , 20
		{
			StringRight, rChar, pattern, 1
			if(rChar == "."){
				pattern := RTrim( pattern, "." )
				StringRight, rChar, pattern, 1
				if(rChar != "\"){
					; 問答無用でFalse
					return False
				}
				pattern := RTrim( pattern, "\" )
				; 繰り返し
			} else {
				; . がないなら当然終了
				break
			}
		}
	}

	type := FileExist(pattern)
	IfInString, type, D
	{
		; 正しいフォルダと認識
		return True
	}
	return  False
}


func_myFileExistReturnType(pattern){
	if( func_myFileCheckIsNot(pattern) ) {
		return  ""
	}
	str := FileExist(pattern)
	return  str
}

func_myFileExist(pattern){
	if( func_myFileCheckIsNot(pattern) ) {
		return  False
	}

	IfExist, %pattern%
	{
		return  True
	}
	return  False
}

func_myFileNotExit(pattern){
	if( func_myFileExist(pattern) ){
		return  False
	}
	return  True
}

func_fileExistOnly(pattern){
	IfExist, %pattern%
	{
		return  True
	}
	return  False
}

func_trueFalseStr(res){
	if(res){
		return  "True"
	}
	return  "False"
}

; 23時59分59秒　形式で今の時間返す
func_getHourMinSec(){
	time = %A_Hour%時%A_Min%分%A_Sec%秒
	return time
}

; 2xxx年xx月xx日 23時59分59秒　形式で今の時間返す
func_getYearMonthDayHourMinSec(){
	day := A_YYYY . "年" . A_MM . "月" . A_DD . "日 " . A_Hour "時" . A_Min . "分" . A_Sec . "秒"
	return day
}

; 特殊なファイル名の場合エラーにするようにする
; 特殊な文字の場合、True を返す
func_checkErrorFile(fileName){
	StringRight, str4, fileName, 4
	if(str4 == "\con" || str4 == "\prn" || str4 == "\nul" || str4 == "com1" || str4 == "com2"){		; 謎のファイル con だったら
		return  True
	}
	return  False
}

; 文字数が指定より短い場合 True になる
func_StringShortMoreNum(str, length){
	StringLen, num, str
	if(num > length) {
		return  False
	}
	return  True
}

; 文字数がしていより多い場合はそこでカットする関数
func_cutStringMoreLength(str, length) {
	StringLen, num, str
	if(num > length) {
		StringLeft, str, str, %length%
		str := RTrim(str)
	}
	return  str
}

; ON や OFF の文字列か True や False の文字列なら Trueをかえす
func_checkFlagStr(flagStr){
	flag := False
	StringLower, flagStrLower, flagStr
	if(flagStrLower == "on"){
		flag := True
	} else if(flagStrLower == "true"){
		flag := True
	} else if(flagStrLower == "1"){
		flag := True
	} else if(flagStrLower == "off"){
		flag := True
	} else if(flagStrLower == "false"){
		flag := True
	} else if(flagStrLower == "0"){
		flag := True
	}
	return flag
}

; ON や OFF の文字列ならTrue や False を返す
; それ以外の文字列なら、Falseを返す
func_getFlagByOnOffStr(flagStr){
	flag := False
	StringLower, flagStrLower, flagStr
	if(flagStrLower == "on"){
		flag := True
	} else if(flagStrLower == "true"){
		flag := True
	} else if(flagStrLower == "1"){
		flag := True
	} else if(flagStrLower == "off"){
		flag := False
	} else if(flagStrLower == "false"){
		flag := False
	} else if(flagStrLower == "0"){
		flag := False
	}
	return flag
}

; ON や OFF の文字列ならTrue や False を返す
; それ以外の文字列なら、 error の文字を返す
func_getFlagByOnOffStrOrErrMsg(flagStr){
	StringLower, flagStrLower, flagStr
	if(flagStrLower == "on"){
		return True
	} else if(flagStrLower == "true"){
		return True
	} else if(flagStrLower == "1"){
		return True
	} else if(flagStrLower == "off"){
		return False
	} else if(flagStrLower == "false"){
		return False
	} else if(flagStrLower == "0"){
		return False
	}
	return "error"
}

func_isNotFile(str) {
	if( func_myFileExist(str) )
	{
		return False
	}
	return True
}


func_isFolder(str) {
	if(func_isNotFolder(str))
	{
		return False
	}
	return True
}

func_isNotFolder(str) {
	type := func_myFileExistReturnType(str)
	IfInString, type, D
	{
		return False
	}
	return True
}


 ; ファイルから 指定した文字と一致している行以外 全て読み込む
func_wordTrimfileRead(str, file) {
	IfExist, %file%
	{
		buff =
		Loop, Read, %file%
		{
			if(str != A_LoopReadLine) {
				buff .= A_LoopReadLine  . "`n"
			}
		}
	} else {
		func_msgBoxOnlyOk("読み込むファイルが見つからず", "エラー")
	}
	return  buff
}

;  フォルダ内のファイルリストを返す
func_getListFiles( DirPath ) {
	listfiless = 
	Loop, %DirPath%*, 1, 0
	{
		listfiless .= A_LoopFileName
		listfiless .= "`n"
	}
	return  listfiless
}


; オブジェクトの key を List とかで使えるよう | で区切った文字にする
func_objectToPipeStr(object){
	buff =
	for key in  object {
		if(key != ""){
			buff .= "|" . key
		}
	}
	buff := RTrim(buff, "|")
	return  buff
}

; オブジェクトの key を 改行 で区切った文字にする
func_objectKeyToLineStr(object){
	buff =
	for key, value in  object {
		if(key != ""){
			buff .= key  . "`n"
		}
	}
	buff := RTrim(buff, "`n")
	return  buff
}

; オブジェクトの valueの方を 改行 で区切った文字にする
func_objectValueToLineStr(obj){
	buff =
	for key, value in  obj {
		if(key != ""){
			buff .= value  . "`n"
		}
	}
	buff := RTrim(buff, "`n")
	return  buff
}

;欠陥の関数。OptionとTimeoutは変数で指定できない。
; option 1 Ok,キャンセル 3 はい いいえ キャンセル  4096 モーダル  などの和
/*
func_msgBox(Text, Title="", Options=4097, Timeout=1){
	MsgBox, %Options%, %Title%, %Text%, %Timeout%
}
*/

func_msgBoxOkCancelModal(Text, Title=""){
	MsgBox , 4097 , %Title% , %Text% , 180
}

func_msgBoxOk_No_Modal(Text, Title=""){
	MsgBox , 4099 , %Title% , %Text% , 180
}

func_msgBoxOnlyOk(Text, Title=""){
	MsgBox , 1 , %Title% , %Text% , 180
}



; Optionsは 0でアイコン無し 1 インフォーメーション 2 警告アイコン 3 エラー
; 16 足すと音を鳴らさず表示
; なお、XP以降でないとツールチップは表示されない
func_trayTip(Text, Title="") {
	TrayTip, %Title%, %Text%, 5, 0
}


; エラーがあるならFalseを返す
func_checkErrorLevel( message, mes2="", mes3="", mes4="" ) {
	if(ErrorLevel >= 1){
		MsgBox, ErrorLevel  %ErrorLevel%`n%message%`n%mes2%`n%mes3%`n%mes4%
		return  False
	}
	return True
}

;エラーレベルが5以上の数値なら放置する  エラーがあるならFalseを返す
func_checkErrorLevel_custom( message, mes2="", mes3="", mes4="" ) {
	if(ErrorLevel >= 1 && ErrorLevel < 5){
		MsgBox, ErrorLevel  %ErrorLevel%`n%message%`n%mes2%`n%mes3%`n%mes4%
		return  False
	}
	return True
}


func_bgrToRgb(bgr) {
	StringRight, RR, bgr, 2
	StringRight, GGRR, bgr, 4
	StringLeft, GG, GGRR, 2
	StringTrimLeft, BBGGRR, bgr, 2
	StringLeft, BB, BBGGRR, 2
	RRGGBB := RR . GG . BB
	return  RRGGBB
}

func_RgbToBgr(Rgb) {
	StringLeft, RR, Rgb, 2
	StringRight, BB, Rgb, 2
	StringLeft, RRGG, Rgb, 4
	StringRight, GG, RRGG, 2
	val := "0x" . BB . GG . RR
	return  val
}


; 16進数に変換  15→ F や 第２引数Falseで 0xF
func_numberToHex( number, Trim0x=True ) {
	SetFormat, Integer, H
	hexValue1 := number + 0			; １度計算する。でないと16進数にならない
	if(hexValue1 == "") {
		hexValue1 = 0
	} else {
		if(Trim0x) {
			StringTrimLeft, hexValue1, hexValue1, 2		; 0xを取り除く
		}
	}
	return hexValue1
}


; 2桁の16進数に変換する    15→0F
func_numberToHexAA( number ) {
	SetFormat, Integer, H
	hexValue1 := number + 0			; １度計算する。でないと16進数にならない
	if(hexValue1 == "") {
		hexValue1 = 00
	} else {
		StringTrimLeft, hexValue1, hexValue1, 2		; 0xを取り除く
		if (func_length(hexValue1) == 1) {
			hexValue1 = 0%hexValue1%
		}
	}
	return hexValue1
}


func_hexTo10number( hex ) {
	if(hex == "") {
		return 0
	}
	if(hex == "0") {
	
	} else {
		hex := LTrim(hex, "0")
		hex = 0x%hex%
		basic1 := hex + 0			; １度計算する。でないと16進数だと認識しない
		if(basic1 == "") {
			return 0
		}
		return basic1
	}
	return  0
}



func_length(InputVar) {
	StringLen, OutputVar, InputVar
	return OutputVar
}

; ウインドウのタイトルが  見つかったら  Trueを返す
func_foundWindow(Title) {
	if(Title != "A") {
		Title := Trim(Title)
		WinGetPos, X, Y, Width, Height, %Title%
		if(Width == "") {
			return  False
		}
	}
	return True
}

; ウインドウが最大化してるかどうか確認
func_isWindowMaxSize(winTitle){
	WinGet,OutputVar, MinMax, %winTitle%
	if(OutputVar == 1){
		return True
	}
	return False
}

; ウインドウが最小化してるかどうか確認
func_isWindowMinimizeSize(winTitle){
	WinGet,OutputVar, MinMax, %winTitle%
	if(OutputVar == -1){
		return True
	}
	return False
}

/*
 昔の
func_isWindowMaxSizeOldVersion(winTitle){
	WinGetPos, X, Y, Width, Height, %WinTitle%
	SysGet,varX,61
	SysGet,varY,62
	scrWidth := varX - 12
	scrHeight := varY - 12
	if(Width <= scrWidth) {
		return False
	}
	if(Height <= scrHeight) {
		return False
	}

	if(X >= -1){
		return False
	}
	if(Y >= -1){
		return False
	}
	return True
}

昔の
 ※ 非表示のウインドウは DetectHiddenWindows,On での結果が変わるので注意
func_isWindowMinimizeSizeOldVersion(winTitle){
	WinGetPos, X, Y, Width, Height, %WinTitle%

	; ウインドウが見つからなければ False
	if(X == ""){
		return False
	}

	if(X <= -30000){
		if(Y <= -30000){
			if(Height <= 37){
				return True
			}
		}
	}

	;左下に小さく表示しているソフトの場合
	if(X <= 0){
		if(Width == 160){
			if(Height == 27){
				return True
			}
		}
	}
	return  False
}
*/

; ウインドウの表示・非表示を確認
func_ifWinExist(winTitle){
	IfWinExist, %winTitle%
	{
		return True
	} else {
		return False
	}
}

func_toolTipOpen(Text, X=850, Y=730, num=1, ScreenFlag=True) {
	if(ScreenFlag){
		CoordMode, ToolTip, Screen
	} else {
		CoordMode, ToolTip, Relative
	}
	ToolTip, %Text%, %X%, %Y%, %num%
}


func_toolTipClose(num=1) {
	ToolTip, , , ,%num%
}

func_sendEndToHwndControle(hwnd){
	if(hwnd != ""){
		ControlSend , , {End}, ahk_id  %hwnd%
	}
}

func_linefeedReplace(str){
	IfInString, str, ``n
	{
		StringReplace, str, str,``n,`n, All
	}
	IfInString, str, ``r
	{
		StringReplace, str, str,``r,`r, All
	}
	return str
}

; str の値に searchText の文字があったら、置換
func_stringReplace(str, searchText, replaceText, allFlag=False){
	IfInString, str, %searchText%
	{
		if( allFlag ){
			StringReplace, str, str, %searchText% , %replaceText%, All
		} else {
			StringReplace, str, str, %searchText% , %replaceText%
		}
	}
	return str
}

;  PCを起動してからの時間
func_timeFromPcStart(){
	hour := Floor(A_TickCount / 1000 / 60 / 60)
	minute := Floor(A_TickCount / 1000 / 60) - (hour * 60)
	hour := func_towDigitIfOne(hour)
	minute := func_towDigitIfOne(minute)
	return  hour . ":" . minute
}

func_towDigitIfOne(num){
	StringLen, count, num
	if(count == 1){
		num := 0 . num
	}
	return num
}

; 以降  DvorakJから
func_relativePathToAbsolutePath(p_str)
{
	IfNotExist, %p_str%
	{
		return p_str
	}
	StringLeft, one_char, p_str, 1
	StringLeft, two_chars, p_str, 2
	StringLeft, three_chars, p_str, 3
	StringTrimLeft, rest1, p_str, 1
	StringTrimLeft, rest2, p_str, 2
	StringTrimLeft, rest3, p_str, 3

	if ((one_char = "\" ) and (two_chars != "\\" )) { ; top directory
		;; 現在のパスから、ドライブ名を取得する
		SplitPath, A_ScriptDir, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
		return OutDrive . "\" . rest1
	} else if (two_chars = ".\" ) { ; current directory
		return A_WorkingDir  . "\" . rest2
	} else if (three_chars = "..\" ) { ; parent directory
		i := 1
		Loop
		{
			StringLeft, three_chars, rest3, 3
			if (three_chars = "..\") {
				i++
				StringTrimLeft, rest3, rest3, 3
			} else {
				no_upper_dir := True
			}
		} until (no_upper_dir)

		path := func_getParentDir(A_WorkingDir, i)  . rest3
		IfExist, %path%
		{
			return path
		}
	} else {
		StringRight, twoChr, two_chars, 1
		if(twoChr == ":"){
			return  p_str
		}
		p_str := A_WorkingDir  . "\" . p_str
	}
	return p_str
}


func_getParentDir(path, num){
	tmp_path := RTrim(path, "\")
	StringGetPos, index, tmp_path, \, R%num%
	if (index = -1) { ; "..\" が想定以上に出現したとき
		;; ディレクトリのトップ (Z:\) に設定しておく
		index := 2
	}
	index++
	StringLeft, new_path, tmp_path, %index%
	IfExist, %new_path%
	{
		return new_path
	}
	return path
}

; 上の関数と同じだが ファイルかどうかの確認をしない
func_getBackDir(path, num){
	tmp_path := RTrim(path, "\")
	StringGetPos, index, tmp_path, \, R%num%
	if (index = -1) { ; "..\" が想定以上に出現したとき
		;; ディレクトリのトップ (Z:\) に設定しておく
		index := 2
	}
	index++
	StringLeft, new_path, tmp_path, %index%
	return new_path
}

; フォルダがあるかどうかを調べる フォルダ自体がなければ Trueを返す
; フォルダがある場合 False を返す
; フォルダでない場合 ツールチップに警告をだして、 False を返す
func_existNotFolderCheck(folder){
	type := func_myFileExistReturnType(folder)
	if(type == ""){
		return  True
	} else {
		IfInString, type, D
		{

		} else {
			ToolTip , %folder%はフォルダ名ではない, A_CaretX, A_CaretY, 1
		}
		return  False
	}
}

; フォルダがあるかチェックしてなければそのフォルダを作る
func_folderCheckMakeFolder(folder){
	if( func_existNotFolderCheck(folder) ){
		FileCreateDir, %folder%
	}
}

; ファイルがあるかチェックしてなければフォルダとファイルを作る
func_fileCheckMakeFolderAndFolder(file, parentFolder){
	if( func_myFileCheckIsNot(file) ){
		type := func_myFileExistReturnType(parentFolder)
		if(type == ""){
			FileCreateDir, %parentFolder%
		} else {
			IfNotInString, type, D
			{
				ToolTip , %parentFolder%はフォルダ名ではない, A_CaretX, A_CaretY, 1
				return
			}
		}
		nonStr := ""
		FileAppend , %nonStr%, %file%
	}
}

; 上の関数とほぼ同じ  iniSetFunc.ahk で使用
func_easyFolderCheckMakeFolder(folder){
	type := FileExist(folder)
	if(type == ""){
		FileCreateDir, %folder%
	} else {
		IfNotInString, type, D
		{
			ToolTip , %folder%はフォルダ名ではない, A_CaretX, A_CaretY, 1
		}
	}
}

; 上の関数とほぼ同じ  iniSetFunc.ahk で使用  checkListFunc.ahk で使用
func_easyFileCheckMakeFolderAndFile(file, parentFolder, defaultStr=""){
	IfNotExist, %file%
	{
		type := FileExist(parentFolder)
		if(type == ""){
			FileCreateDir, %parentFolder%
		} else {
			IfNotInString, type, D
			{
				ToolTip , %parentFolder%はフォルダ名ではない, A_CaretX, A_CaretY, 1
				return
			}
		}
		FileAppend , %defaultStr%, %file%
	}
}

; ファイルの拡張子をチェックする。
func_extensionConfirm(file, target1, target2="", target3=""){

	if( func_myFileNotExit(file) ){
		return False
	}

	SplitPath, file , OutFileName, OutDir, OutExtension
	if(OutExtension == target1){
		return True
	}
	if(target2 != ""){
		if(OutExtension == target2){
			return True
		}
	}
	if(target3 != ""){
		if(OutExtension == target3){
			return True
		}
	}
	return False
}
