





;;; How to detect Normal or Large font size settings (DPI)
;;; http://www.autohotkey.com/forum/post-198727.html&sid=5f964c930528a1331705e692e5bcf639#198727
;;; Posted: Mon May 26, 2008 6:31 pm

othli_GetDPI() {
/*
    RegRead, DPI_value, HKEY_CURRENT_USER, Control Panel\Desktop\WindowMetrics, AppliedDPI
    return % (errorlevel = 1) ? 96
            : DPI_value
*/

    hDC := DllCall("GetDC", Int, 0)
    dpi := DllCall("GetDeviceCaps", UInt, hDC , UInt, 88)
    DllCall("ReleaseDC",Int, 0, UInt, hDC)

    return dpi ? dpi : 0
}







;;; IME.ahk NYSL <http://www.kmonos.net/nysl/>
;;; AutoHotokeyを流行らせるアップローダ <http://lukewarm.s101.xrea.com/up/> の 089.zip [Shift&Space + IME.ahk] (2008/09/21 20:18)

;;; Index of /_pub/eamat/MyScript の IME20091203.zip (IME.ahk)
;;; http://www6.atwiki.jp/eamat/pub/MyScript/

;;; AutoHotkey_L (unicode binaries) に準拠した


;-----------------------------------------------------------
; IMEの状態の取得
;   WinTitle="A"    対象Window
;   戻り値          1:ON / 0:OFF
;-----------------------------------------------------------
othli_IME_GET(WinTitle="A")  {
    VarSetCapacity(stGTI, 48, 0)
    NumPut(48, stGTI,  0, "UInt")   ;	DWORD   cbSize;
	hwndFocus := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
	             ? NumGet(stGTI,12,"UInt") : WinExist(WinTitle)

    return DllCall("SendMessageW"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwndFocus)
          , UInt, 0x0283  ;Message : WM_IME_CONTROL
          ,  Int, 0x0005  ;wParam  : IMC_GETOPENSTATUS
          ,  Int, 0)      ;lParam  : 0
}

;-----------------------------------------------------------
; IMEの状態をセット
;   SetSts          1:ON / 0:OFF
;   WinTitle="A"    対象Window
;   戻り値          0:成功 / 0以外:失敗
;-----------------------------------------------------------
othli_IME_SET(SetSts, WinTitle="A")    {
    VarSetCapacity(stGTI, 48, 0)
    NumPut(48, stGTI,  0, "UInt")   ;	DWORD   cbSize;
	hwndFocus := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
	             ? NumGet(stGTI,12,"UInt") : WinExist(WinTitle)

    return DllCall("SendMessageW"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwndFocus)
          , UInt, 0x0283  ;Message : WM_IME_CONTROL
          ,  Int, 0x006   ;wParam  : IMC_SETOPENSTATUS
          ,  Int, SetSts) ;lParam  : 0 or 1
}



; パソコンの音声
othli_Voice(com2){
	ComObjCreate("SAPI.SpVoice").Speak(com2)
}




; MouseGestureL から
othli_MG_ExePath(pid=0){
	if(!pid){
		WinGet,pid,PID,A
	}
	len := 260
	VarSetCapacity(s, (len+1)*2, 0)
	hProc := DllCall("OpenProcess", "UInt",0x410, "UInt",0, "UInt",pid, "Ptr")
	if(DllCall("psapi.dll\EnumProcessModules", "Ptr",hProc, "Ptr*",hMod, "Int",4, "Ptr*",nd, "Ptr")<>0) {
		DllCall("psapi.dll\GetModuleFileNameEx", "Ptr",hProc, "Ptr",hMod, "Str",s, "Int",len, "Int")
	}
	DllCall("CloseHandle", Ptr,hProc)
	return s
}


/*
やや昔の
othli_MG_ExePath(pid=0){
	if(!pid){
		WinGet,pid,PID,A
	}
	VarSetCapacity(s,256,0)
	hProc:=DllCall("OpenProcess","UInt",0x410,"UInt",0,"UInt",pid,"UInt")
	if(DllCall("psapi.dll\EnumProcessModules","UInt",hProc,"UInt*",hMod,"Int",4,"UInt*",nd,"Int")<>0){
		DllCall("psapi.dll\GetModuleFileNameEx","UInt",hProc,"UInt",hMod,"Str",s,"Int",255,"Int")
	}
	DllCall("psapi.dll\CloseProcess","UInt",hProc)
	return s
}
*/
