manager_activate_window(ByRef manager, id) {
    manager_set_cursor(manager, id)

    if not id
        id := WinExist("bug.n_BAR_" . manager["active_screen"])

    if window_activate(id)
        return 1
    else
        return 0
}
