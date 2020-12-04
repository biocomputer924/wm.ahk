window_is_hung(id) {
    WM_NULL := 0

    detect_hidden := A_DetectHiddenWindows

    DetectHiddenWindows, On

    SendMessage, WM_NULL, , , , ahk_id %id%

    x := ErrorLevel

    DetectHiddenWindows, % detect_hidden

    if x
        return 1
    else
        return 0
}
