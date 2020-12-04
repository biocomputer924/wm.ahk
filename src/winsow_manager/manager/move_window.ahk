manager_move_window(ByRef manager) {
    WinGet, aWndId, ID, A

    if InStr(manager["managed_window_ids"], aWndId . ";") and not window_#%aWndId%_isFloating
        desktop_toggleFloatingWindow(aWndId)

    window_set(aWndId, "Top", "")

    WM_SYSCOMMAND = 0x112
    SC_MOVE       = 0xF010

    SendMessage, WM_SYSCOMMAND, SC_MOVE, , , ahk_id %aWndId%
}
