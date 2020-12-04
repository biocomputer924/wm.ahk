window_get_hidden(id) {
    WinGetClass, window_class, ahk_id %id%
    WinGetTitle, title, ahk_id %id%

    if not window_class and not title {
        x := A_DetectHiddenWindows

        DetectHiddenWindows, On

        WinGetClass, window_class, ahk_id %id%
        WinGetTitle, title, ahk_id %id%

        DetectHiddenWindows, %x%

        ; if now window_class or title, but not window_class and not title before, wnd is hidden.
        return (window_class or title)
    }
    else
        return false
}
