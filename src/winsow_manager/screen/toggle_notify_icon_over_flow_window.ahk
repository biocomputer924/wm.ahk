screen_toggle_notify_icon_over_flow_window() {
    static x

    if not WinExist("ahk_class NotifyIconOverflowWindow") {
        WinGet, x, ID, A

        detect_hidden := A_DetectHiddenWindows

        DetectHiddenWindows, On

        WinShow, ahk_class NotifyIconOverflowWindow

        WinActivate, ahk_class NotifyIconOverflowWindow

        DetectHiddenWindows, %detect_hidden%
    }
    else {
        WinHide, ahk_class NotifyIconOverflowWindow

        WinActivate, ahk_id %x%
    }
}
