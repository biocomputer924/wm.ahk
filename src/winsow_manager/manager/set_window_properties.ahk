#Include %A_ScriptDir%/array/contsins.ahk
#Include %A_ScriptDir%/array/push.ahk

manager_set_window_properties(ByRef manager, window_id, window) {
    a := false

    if not array_contains(manager["all_window_ids"], window_id)
        array_push_back(manager["all_window_ids"], window_id)

    if (is_managed) {
        if action = "close"
            window_close(window_id)
        else if action = "maximize"
            window_maximize(window_id)
        else if action = "restore"
            window_restore(window_id)

        if not array_contains(manager["managed_window_ids"], window_id) {
            array_push_back(manager["managed_window_ids"], window_id)
        }

        windows[window_id]["screen"]  := window["screen"]
        windows[window_id]["desktop"] := window["desktop"]
        windows[window_id]["decoration"] := window["decoration"]
        windows[window_id]["floating"] := window["floating"]
        windows[window_id]["is_minimized"] := window["is_minimized"]
        windows[window_id]["area"] := 0

        if not windows[window_id]["border"]["enabled"]
            window_set(window_id, "Style", "-0x40000")

        if not windows[window_id]["decoration"]["enabled"]
            window_set(window_id, "Style", "-0xC00000")

        a := windows[window_id]["tags"] & (1 << (screen_#%m%_adesktop_#1 - 1))

        if a {
            ; A newly created window defines the active screen, if it is visible.
            manager["current_screen"] := m
            manager_window_activate(manager, window_id)
        }
        else {
            manager_hideShow := true

            window_hide(window_id)

            manager_hideShow := false
        }
    }

    return a
}
