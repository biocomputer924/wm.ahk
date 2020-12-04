screen_toggle_active_desktop_status_bar(ByRef screen) {
    screen["active_desktop"]["status_bar_enabled"] = not active_desktop["status_bar_enabled"]

    if active_desktop["status_bar_enabled"]
        window_hide(screen["status_bar"]["id"])
    else
        window_show(screen["status_bar"]["id"])

    screen_work_area(current_screen_id)

    desktop_arrange(current_screen_id, active_desktop)
}
