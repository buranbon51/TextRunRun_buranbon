




windc_titleIfA(title){
	if(title == "A"){
		;Sleep, 300
		WinWaitActive , A, , 1
	}
}

windc_anyWaitActive(){
	;Sleep, 300
	WinWaitActive , A, , 1
}

; ウインドウが最大化していたらリサイズして、少し待つ
windc_winRestoreIfwinMaxSize(winTitle){
	if( func_isWindowMaxSize(winTitle) ){
		WinRestore, %winTitle%
		Sleep, 300
	}
}
