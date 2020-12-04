manager_unmanage(ByRef window_id) {
    current_screen = manager["screens"][manager["current_screen_id"]]

    current_desktop := manager["desktops"][current_screen["current_desktop_id"]]

    manager["windows"][window_id]["area"] :=
    manager["windows"][window_id]["screen"] :=
    manager["windows"][window_id]["decoration"]["enabled"] :=
    manager["windows"][window_id]["floating"]["enabled"]  :=

    StringReplace, manager_all_window_ids, manager_all_window_ids, %window_id%`;,
    StringReplace, manager["managed_window_ids"], manager["managed_window_ids"], %window_id%`;, , All

    return a
}
