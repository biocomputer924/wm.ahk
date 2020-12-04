manager_register_shell_hook(function_name) {
    ; This message is sent when the display resolution has changed.
    WM_DISPLAYCHANGE := 126

    Gui, +LastFound

    handle := WinExist()

    ; Minimum operating systems: Windows 2000 (http://msdn.microsoft.com/en-us/library/ms644989(VS.85).aspx)
    DllCall("RegisterShellHookWindow", "UInt", handle)

    msgNum := DllCall("RegisterWindowMessage", "Str", "SHELLHOOK")

    OnMessage(msgNum, function_name)

    if Config_screenDisplayChangeMessages
        OnMessage(WM_DISPLAYCHANGE, "manager_onDisplayChange")
}
; SKAN: How to Hook on to Shell to receive its messages? (http://www.autohotkey.com/forum/viewtopic.php?p=123323#123323)
