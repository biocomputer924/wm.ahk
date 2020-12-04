#Include %A_ScriptDir%/array/contains.ahk

screen_toggle_window_tag(i, d = 0) {
    WinGet, x, ID, A

    if (array_contains(manager["managed_window_ids"], x) and i >= 0 and i <= Config_viewCount) {
        if (window_#%x%_tags & (1 << i - 1)) {
            if not ((window_#%x%_tags - (1 << i - 1)) = 0) {
                window_#%x%_tags -= 1 << i - 1

                array_remove(manager["active_screen"], x)

                if (i = manager["active_screen"]["active_desktop1"]) {
                    manager_hideShow := true
                    window_hide(x)
                    manager_hideShow := false

                    window_id := SubStr(desktop_#%manager["active_screen"]%_#%i%_wndIds, 1, InStr(desktop_#%manager["active_screen"]%_#%i%_wndIds, ";")-1)

                    manager_activate_window(window_id)

                    if Config_dynamicTiling
                        desktop_arrange(manager["active_screen"], i)
                }
            }
        }
        else {
            array_push_front(manager["active_screen"]["desktops"][i]["window_ids"], x)

            desktop_set_active_window(manager["active_screen"], i, x)

            window_#%x%_tags += 1 << i - 1
        }
    }
}
