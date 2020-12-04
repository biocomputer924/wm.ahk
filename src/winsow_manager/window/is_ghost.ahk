window_is_ghost(id) {
    WinGet, process_name, ProcessName ahk_id %id%

    WinGetClass, window_class, ahk_id %id%

    if (process_name = "dwm.exe") and (window_class = "Ghost")
        return 1
    else
        return 0
}
