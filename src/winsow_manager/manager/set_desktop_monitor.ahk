manager_setViewMonitor(i, d = 0) {
    aView := screen_#%manager["active_screen"]%_adesktop_#1

    if (manager_screenCount > 1) and desktop_#%manager["active_screen"]%_#%aView%_wndIds {
        if (i = 0)
            i := manager["active_screen"]

        i := manager_loop(i, d, 1, manager_screenCount)
        v := screen_#%i%_adesktop_#1
        desktop_#%i%_#%v%_wndIds := desktop_#%manager["active_screen"]%_#%aView%_wndIds desktop_#%i%_#%v%_wndIds

        StringTrimRight, wndIds, desktop_#%manager["active_screen"]%_#%aView%_wndIds, 1

        loop PARSE, wndIds, `; {
            loop % Config_viewCount {
                array_remove(manager["active_screen"][A_Index]["window_ids"], %A_LoopField%)
                array_remove(manager["active_screen"][A_Index]["active_window_ids"], %A_LoopField%)
            }
            window_#%A_LoopField%_screen := i
            window_#%A_LoopField%_tags := 1 << v - 1
        }

        desktop_arrange(manager["active_screen"], aView)

        ; Manually set the active screen.
        manager["active_screen"] := i
        desktop_arrange(i, v)
        WinGet, aWndId, ID, A
        manager_activate_window(aWndId)
    }
}