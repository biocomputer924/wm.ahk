; @TODO: Theoretically, something is wrong here. From the hotkeys this should be manual tiling, but the function says otherwise.
desktop_move_window(i=0) {
    WinGet, aWndId, ID, A

    m := manager["active_screen"]

    v := screen_#%m%_adesktop_#1

    if tiler_is_active(manager["active_screen"], v) and InStr(manager["managed_window_ids"], aWndId ";") and not i = 0 and desktop_#%m%_#%v%_area_#0 and (i <= desktop_#%m%_#%v%_area_#0) {
        if (i = 0)
            i := manager_loop(window_#%aWndId%_area, 1, desktop_#%m%_#%v%_area_#0)

        window_move(aWndId, desktop_#%m%_#%v%_area_#%i%_x, desktop_#%m%_#%v%_area_#%i%_y, desktop_#%m%_#%v%_area_#%i%_width, desktop_#%m%_#%v%_area_#%i%_height)
        window_#%aWndId%_area := i

        manager_set_cursor(manager, aWndId)
    }
}
