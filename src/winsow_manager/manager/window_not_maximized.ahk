manager_window_not_maximized(ByRef manager, width, height) {
    screen := manager_current_screen(manager)

    return (width < 0.99 * screen["width"] or height < 0.99 * screen["height"])
}
