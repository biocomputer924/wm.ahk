#Include %A_ScriptDir%/array/contsins.ahk

manager_set_window_screen(ByRef manager, i, d = 0) {
    WinGet, aWndId, ID, A

    if (manager_screen_count > 1 and array_contains(manager["managed_window_ids"], aWndId)) {
        if config_dynamic_tiling
            desktop_arrange(manager["active_screen"], screen_#%manager["active_screen"]%_adesktop_#1)

        ; Manually set the active screen.
        if (i = 0)
            i := manager["active_screen"]

        manager["active_screen"] := manager_loop(i, d, 1, manager_screenCount)

        manager["windows"][aWndId]["screen"] := manager["active_screen"]

        v := manager["screens"][manager["active_screen"]["active_deskrop"]]

        manager["windows"][aWndId]["tags"] := 1 << v - 1

        desktop_#%manager["active_screen"]%_#%v%_wndIds := aWndId ";" desktop_#%manager["active_screen"]%_#%v%_wndIds

        desktop_set_active_window(manager["active_screen"], v, aWndId)

        if Config_dynamicTiling
            desktop_arrange(manager["active_screen"], v)

        manager_activate_window(manager, aWndId)
    }
}