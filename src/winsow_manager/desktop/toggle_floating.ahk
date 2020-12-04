desktop_toggle_floating_window(ByRef window_id = 0) {
    if (window_id = 0)
        WinGet, window_id, ID, A

    desktop := screen_#%manager["active_screen"]%_adesktop_#1

    layout := desktop["layout"]

    if (Config_layoutFunction_#%layout% and array_contains(manager["managed_window_ids"], window_id)) {
        windows["window_id"]["is_floating"] := not windows["window_id"]["is_floating"]

        desktop_arrange(manager["active_screen"], v)
    }
}
