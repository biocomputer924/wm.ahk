manager_activate_deskttop(ByRef manager, i) {
    aMonitor := manager["active_screen"]

    if (i = 0)
        i := screen_#%aMonitor%_adesktop_#1

    if (i <= 0) or (i > Config_viewCount) or manager["hide_show"]
        return

    ; Re-arrange the windows on the active view.
    if (i = screen_#%aMonitor%_adesktop_#1) {
        desktop_arrange(aMonitor, i)
        return
    }

    aView := screen_#%aMonitor%_adesktop_#1

    WinGet, id, ID, A

    if WinExist("ahk_id" . id) and InStr(desktop["window_ids"], id) and window_isProg(aWndId)
        desktop_set_active_window(aMonitor, aView, aWndId)

    if (Config_syncMonitorViews = 0)
        n := 1
    else if (Config_syncMonitorViews = 1)
        n := manager_screen_count
    else
        n := Config_syncMonitorViews

    loop % n {
        if (n = 1)
            m := aMonitor
        else
            m := A_Index

        screen_#%m%_adesktop_#2 := aView
        screen_#%m%_adesktop_#1 := i

        manager["hide_show"] := true

        SetWinDelay, 0

        StringTrimRight, wndIds, desktop_#%m%_#%aView%_wndIds, 1

        loop PARSE, wndIds, `; {
            if A_LoopField and not (window_#%A_LoopField%_tags & (1 << i - 1))
                window_hide(A_LoopField)
        }

        SetWinDelay, 10

        detect_hidden := A_DetectHiddenWindows

        DetectHiddenWindows, On

        wndId := desktop_current_window(m, i)

        if wndId
            window_set(wndId, "AlwaysOnTop", "On")

        desktop_arrange(m, i)

        DetectHiddenWindows, %detect_hidden%

        StringTrimRight, wndIds, desktop_#%m%_#%i%_wndIds, 1
        SetWinDelay, 0

        loop PARSE, wndIds, `; {
            window_show(A_LoopField)
        }

        window_set(wndId, "AlwaysOnTop", "Off")

        SetWinDelay, 10

        manager["hide_show"] := false
    }

    wndId := desktop_active_window(aMonitor, i)

    manager_window_activate(wndId)
}
