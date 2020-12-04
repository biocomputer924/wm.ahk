; Given a ghost window, try to find its body. This is only known to work on Windows 7
window_find_hung(ghost_window_id) {
    WinGetTitle, ghost_window_title, ahk_id %ghost_window_id%

    StringReplace, ghost_window_title, ghost_window_title, % config["ghost_window_sub_string"],

    WinGetPos, ghost_window_x, ghost_window_y, ghost_window_w, ghost_window_h, ahk_id %ghost_window_id%

    SetTitleMatchMode, 2

    WinGet, window_id, List %ghost_window_title%

    loop % window_id {
        if (window_id%A_Index% = ghost_window_id)
            Continue

        WinGetPos, x, y, w, h, ahk_id window_id%A_Index%

        if (x = ghost_window_x) and (y = ghost_window_y) and (w = ghost_window_w) and (h = ghost_window_h)
            return window_id%A_Index%
    }

    return 0
}
