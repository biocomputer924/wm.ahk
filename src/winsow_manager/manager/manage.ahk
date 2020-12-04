#Include %A_ScriptDir%/array/contains.ahk

manager_manage(ByRef manager, preferredMonitor, preferredView, window_id, rule = "") {
    ; Manage any window only once.
    if array_contains(manager["all_window_ids"], window_id) and (rule = "")
        return

    body := 0

    if window_is_ghost(window_id) {
        body := window_find_hung(window_id)

        if body {
            x := {}
            x["is_managed"] := array_contains(manager["managed_window_ids"], body)
            x["is_decoration"] := {}
             window_#%body%_isDecorated
            isFloating := window_#%body%_isFloating
            action := ""
        }
    }

    ; Apply rules if the window is either a normal window or a ghost without a body.
    if (body = 0) {
        rule = manager_search_rule(window_id, manager["rules"])

        if (m = 0)
            m := preferredMonitor

        if (m < 0)
            m := 1

        ; if the specified screen is out of scope, set it to the max. screen.
        if (m > manager_screen_count)
            m := manager_screen_count

        if (tags = 0)
            tags := 1 << (preferredView - 1)
    }

    a := manager_set_window_properties(window_id, rule)

    ; Do view placement.
    if is_managed {
        loop % Config_viewCount
        if (window_#%window_id%_tags & (1 << (A_Index - 1))) {
            if (body) {
                ; Try to position near the body.
                desktop_ghostWindow(m, A_Index, body, window_id)
            }
            else
                desktop_add_window(m, A_Index, window_id)
        }
    }

    return a
}
