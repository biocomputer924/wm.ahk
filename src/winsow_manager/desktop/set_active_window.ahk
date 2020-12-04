desktop_set_active_window(ByRef desktop, window_id) {
    if window_id {
        array_remove(desktop["window_ids"], window_id)
        array_push_back(desktop["window_ids"], window_id)
    }
}
