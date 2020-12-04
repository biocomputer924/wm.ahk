screen_init(status_bar) {
    result := {}
    result["active_desktop1"] := 1
    result["active_desktop2"] := 1
    result["status_bar"] := status_bar
    result["task_bar_class"] := ""
    result["task_bar_position"] := ""
    result["desktops"] := [desktop_init()]

    SysGet, screen_name, MonitorName %i%

    screen_work_wrea(m)

    return result
}
