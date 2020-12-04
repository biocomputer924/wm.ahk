manager_desktop_add_to_current_window(ByRef screen, i) {
    WinGet, x, ID, A

    if InStr(manager["managed_window_ids"], x ";") and (i > 0) and (i <= Config_viewCount or i = 10) {
        for j in desktops {
            if not (j = i) {
                StringReplace, desktop_#%manager["active_screen"]%_#%A_Index%_wndIds, desktop_#%manager["active_screen"]%_#%A_Index%_wndIds, %x%`;,

                desktop_set_active_window(manager["active_screen"], A_Index, 0)
            }
        }

        if not (window_#%x%_tags & (1 << i - 1))
            desktop_#%manager["active_screen"]%_#%i%_wndIds := x ";" desktop_#%manager["active_screen"]%_#%i%_wndIds

        desktop_set_active_window(manager["active_screen"], i, x)

        window_#%x%_tags := 1 << i - 1

        aView := screen_current_desktop_id()

        if not (i = aView) {
            manager["hide_show"] := true

            wndId := SubStr(desktop_#%manager["active_screen"]%_#%aView%_wndIds, 1, InStr(desktop_#%manager["active_screen"]%_#%aView%_wndIds, ";") - 1)

            manager_activate_window(wndId)

            manager["hide_show"] := false

            if Config_view_follows_tagged
                screen_activateView(i)
            else {
                manager["hide_show"] := true

                window_hide(x)

                manager["hide_show"] := false

                if config_dynamic_tiling
                    desktop_arrange(manager["active_screen"], aView)
            }
        }
    }
}
