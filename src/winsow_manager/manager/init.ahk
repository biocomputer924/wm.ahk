#Include %A_ScriptDir%/manager/reginitial_sync.ahk
#Include %A_ScriptDir%/manager/register_shell_hook.ahk
#Include %A_ScriptDir%/status_bar/render.ahk
#Include %A_ScriptDir%/status_bar/update.ahk

manager_init(ByRef manager) {
    ; axes, dimensions, percentage, flipped, gapWidth
    manager_layout_dirty := 0

    ; New/closed windows, active changed,
    manager_windows_dirty := 0

    desktop_tiled_window_ids := []

    SysGet, screen_count, MonitorCount

    screens := []

    loop % screen_count {
        screen := screen_init(A_Index)
        screen["status_bar_id"] = status_bar_render(screen["status_bar"])

        screens.Push(screen)
    }


    manager["hide_show"] := false
    manager["all_window_ids"] := ""
    manager["managed_window_ids"] := []
    manager["active_screen"] := 1

    manager_initial_sync(manager)

    status_bar_update(status_bar)

    for i in screens {
        desktop_arrange(i, screens[i]["current_window_id"])
    }

    manager_register_shell_hook(manager["on_shell_hook"])

    SetTimer, % manager["on_maintenance_label"], % manager["maintenance_interval"]
    SetTimer, % manager["on_status_bar_render_label"], % manager["stattus_bar_render_interval"]
}
