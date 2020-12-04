
desktop_add_window(config, desktop, window_id) {
    StringReplace, % desktop["window_ids"], desktop["window_ids"], % window_id . ";",, All

    if config["new_window_position"] = "last" {

    }
    else if tiler_is_active(desktop) and ((config["new_window_position"] = "master_bottom") or (config["new_window_position"] = "stackTop")) {
        n := desktop_getTiled_window_ids(desktop)

        m_split := desktop["layout_m_x"] * desktop["layout_m_y"]

        if (m_split = 1 and config["new_window_position"] = "master_bottom") {
            array_push_front(desktop["window_ids"], window_id)
        }
        else if ((config["new_window_position"] = "master_bottom" and n < m_split) or (config["new_window_position"] = "stackTop" and n <= m_split)) {
            array_push_back(desktop["window_ids"], window_id)
        }
        else {
            if (config["new_window_position"] = "master_bottom") {
                i := m_split - 1
            }
            else {
                i := m_split
            }

            search  := desktop_tiledWndId%i%

            replace := search wndId

            array_replace(desktop["window_ids"], search, replace)
        }
    }
    else if (desktop["new_window_position"] = "bottom") {
        array_push_back(desktop["window_ids"], window_id)
    }
    else {
        array_push_front(desktop["window_ids"], window_id)
    }
}
