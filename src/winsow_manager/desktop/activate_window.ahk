desktop_activate_window(ByRef manager, i) {
    WinGet, aWndId, ID, A

    v := screen_#%manager["active_screen"]%_adesktop_#1

    StringTrimRight, wndIds, desktop_#%manager["active_screen"]%_#%v%["window_ids"], 1

    StringSplit, wndId, wndIds, `;

    if (i > 0) and (i <= wndId0) and (d = 0) {
        wndId := wndId%i%

        window_set(wndId, "AlwaysOnTop", "On")
        window_set(wndId, "AlwaysOnTop", "Off")

        window_#%wndId%_isMinimized := false

        manager_activate_window(wndId)
    }
    else if (wndId0 > 1) {
        if not InStr(manager["managed_window_ids"], aWndId . ";") or window_#%aWndId%_isFloating
            window_set(aWndId, "Bottom", "")

        loop % wndId0 {
            if (wndId%A_Index% = aWndId) {
                j := A_Index
                Break
            }
        }

        if (d > 0)
            direction := 1
        else
            direction := -1

        i := manager_loop(j, d, 1, wndId0)

        loop % wndId0 {
            wndId := wndId%i%
    
            if not window_#%wndId%_isMinimized {
                window_set(wndId, "AlwaysOnTop", "On")
                window_set(wndId, "AlwaysOnTop", "Off")

                ; if there are hung windows on the screen, we still want to be able to cycle through them.
                failure := manager_activate_window(manager, wndId)

                if not failure
                    Break
            }

            i := manager_loop(i, direction, 1, wndId0)
        }
    }
}
