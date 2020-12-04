
; @todo: This constantly tries to re-add windows that are never going to be manageable.
;   manager_manage should probably ignore all windows that are already in manager_all_window_ids.
;   The problem was, that i. a. claws-mail triggers manager_sync, but the application window
;   would not be ready for being managed, i. e. class and title were not available. Therefore more
;   attempts were needed.
;   Perhaps this method can be refined by not adding any window to manager_all_window_ids, but only
;   those, which have at least a title or class.
manager_sync(ByRef manager, window_ids = "") {
    a := 0

    shown_window_ids := ""

    for i in screens {
        v := screens[i]["active_desktop1"]

        shown_window_ids .= screens[i]["desktops"][v - 1]["window_ids"]
    }

    ; Check all visible windows against the known windows
    visible_window_ids := ""

    WinGet, window_ids, List , ,

    loop % window_ids {
        if not InStr(shown_window_ids, window_ids%A_Index% ";") {
            if not InStr(manager["managed_window_ids"], wndId%A_Index% ";") {
                flag := manager_manage(manager["active_screen"], manager["active_screen"]["active_desktop1"], window_ids%A_Index%)
                if flag
                    a := 1
            }
            else if not window_is_hung(window_ids%A_Index%) {
                ; This is a window that is already managed but was brought into focus by something.
                ; Maybe it would be useful to do something with it.
                window_ids .= window_ids%A_Index% ";"
            }
        }

        visible_window_ids := visible_window_ids window_ids%A_Index% ";"
    }

    ; @todo-future: Find out why this unmanage code exists and if it's still needed.
    ; check, if a window, that is known to be visible, is actually not visible
    StringTrimRight, shown_window_ids, shown_window_ids, 1

    loop PARSE, shown_window_ids, `; {
        if not InStr(visible_window_ids, A_LoopField) {
            flag := manager_unmanage(A_LoopField)

            if (flag and a = 0)
                a := -1
        }
    }

    return a
}
